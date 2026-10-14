# Parks the real cursor in the bottom-right corner of the primary screen before a run of
# the browser tests (docs/HANDOFF.md, trap 78): test windows open at the screen's top
# left, and a cursor resting over a test window's sidebar expands it on hover and fails
# the hover and edge tests. It moves the cursor only when nobody has touched the mouse or
# keyboard for ten seconds, so it never takes the pointer from the operator's hand; then
# it says so and does nothing.
#
# Windows PowerShell 5.1; tooling/dev runs it before stedding_browser_tests:
#
#   powershell -NoProfile -File tooling\win\park-cursor.ps1
#
# The exit code is 0 when the cursor is parked, 1 when the operator was busy.
Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class StedPark {
  [StructLayout(LayoutKind.Sequential)] public struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
  [DllImport("user32.dll")] public static extern bool GetLastInputInfo(ref LASTINPUTINFO p);
  [DllImport("kernel32.dll")] public static extern uint GetTickCount();
  [DllImport("user32.dll")] public static extern bool SetCursorPos(int x, int y);
  [DllImport("user32.dll")] public static extern int GetSystemMetrics(int i);
}
"@
$info = New-Object StedPark+LASTINPUTINFO
$info.cbSize = 8
[void][StedPark]::GetLastInputInfo([ref]$info)
$idle = ([StedPark]::GetTickCount() - $info.dwTime) / 1000
if ($idle -lt 10) {
  Write-Host "cursor not parked: the mouse or keyboard was used $([int]$idle) s ago (trap 78)"
  exit 1
}
# SM_CXSCREEN, SM_CYSCREEN: the primary screen, where test windows open.
$w = [StedPark]::GetSystemMetrics(0)
$h = [StedPark]::GetSystemMetrics(1)
[void][StedPark]::SetCursorPos($w - 2, $h - 2)
Write-Host "cursor parked at $($w - 2),$($h - 2)"
exit 0
