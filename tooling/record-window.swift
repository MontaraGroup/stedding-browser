// Records one window of a process, and nothing else on the screen: ScreenCaptureKit's
// single-window filter takes the window's own pixels, so another app's window over it,
// a notification, or the desktop around it never reach the file, and the window may be
// behind others or on another Space. tooling/record-window builds and runs it.
//
// Usage: record-window PID OUT.mov MAX_SECONDS
// Records the largest window PID owns at its pixel density, 30 frames a second, with the
// pointer, until SIGINT or SIGTERM or MAX_SECONDS, then writes OUT.mov (H.264) and exits 0.

import AVFoundation
import AppKit
import CoreGraphics
import Foundation
import ScreenCaptureKit

// An app with no Dock icon that never becomes active: ScreenCaptureKit needs the window
// server and a running app loop, for the recording indicator it puts in the menu bar.
let application = NSApplication.shared
application.setActivationPolicy(.accessory)

let arguments = CommandLine.arguments
guard arguments.count == 4, let pid = pid_t(arguments[1]), let maxSeconds = Double(arguments[3]) else {
  FileHandle.standardError.write("usage: record-window PID OUT.mov MAX_SECONDS\n".data(using: .utf8)!)
  exit(2)
}
let outputURL = URL(fileURLWithPath: arguments[2])
try? FileManager.default.removeItem(at: outputURL)

func fail(_ message: String) -> Never {
  FileHandle.standardError.write("record-window: \(message)\n".data(using: .utf8)!)
  exit(1)
}

final class Recorder: NSObject, SCRecordingOutputDelegate, SCStreamDelegate {
  var stream: SCStream?
  let finished = DispatchSemaphore(value: 0)

  func recordingOutputDidFinishRecording(_ recordingOutput: SCRecordingOutput) {
    finished.signal()
  }

  func recordingOutput(_ recordingOutput: SCRecordingOutput, didFailWithError error: Error) {
    FileHandle.standardError.write("record-window: \(error)\n".data(using: .utf8)!)
    finished.signal()
  }

  func stream(_ stream: SCStream, didStopWithError error: Error) {
    FileHandle.standardError.write("record-window: the stream stopped: \(error)\n".data(using: .utf8)!)
    finished.signal()
  }
}

let recorder = Recorder()

// On the main thread, as ScreenCaptureKit's teardown is.
Task { @MainActor in
  do {
    let content = try await SCShareableContent.excludingDesktopWindows(
      false, onScreenWindowsOnly: false)
    let windows = content.windows.filter {
      $0.owningApplication?.processID == pid && $0.windowLayer == 0
        && $0.frame.width >= 200 && $0.frame.height >= 100
    }
    guard let window = windows.max(by: {
      $0.frame.width * $0.frame.height < $1.frame.width * $1.frame.height
    }) else {
      fail("no window owned by pid \(pid)")
    }
    let filter = SCContentFilter(desktopIndependentWindow: window)
    let configuration = SCStreamConfiguration()
    let scale = CGFloat(filter.pointPixelScale)
    configuration.width = Int(window.frame.width * scale) / 2 * 2
    configuration.height = Int(window.frame.height * scale) / 2 * 2
    configuration.minimumFrameInterval = CMTime(value: 1, timescale: 30)
    configuration.showsCursor = true
    configuration.capturesAudio = false
    configuration.queueDepth = 6

    let stream = SCStream(filter: filter, configuration: configuration, delegate: recorder)
    let outputConfiguration = SCRecordingOutputConfiguration()
    outputConfiguration.outputURL = outputURL
    outputConfiguration.outputFileType = .mov
    outputConfiguration.videoCodecType = .h264
    try stream.addRecordingOutput(
      SCRecordingOutput(configuration: outputConfiguration, delegate: recorder))
    try await stream.startCapture()
    recorder.stream = stream
    print("recording window \(window.windowID) of pid \(pid) at \(configuration.width)x\(configuration.height)")
    fflush(stdout)
  } catch {
    fail("\(error)")
  }
}

func stop() {
  Task { @MainActor in
    guard let stream = recorder.stream else { exit(1) }
    try? await stream.stopCapture()
  }
}

var signalSources: [DispatchSourceSignal] = []
for number in [SIGINT, SIGTERM] {
  signal(number, SIG_IGN)
  let source = DispatchSource.makeSignalSource(signal: number, queue: .main)
  source.setEventHandler { stop() }
  source.resume()
  signalSources.append(source)
}
DispatchQueue.main.asyncAfter(deadline: .now() + maxSeconds) { stop() }
DispatchQueue.global().async {
  recorder.finished.wait()
  exit(FileManager.default.fileExists(atPath: outputURL.path) ? 0 : 1)
}
application.run()
