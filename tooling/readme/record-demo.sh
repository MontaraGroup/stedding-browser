#!/usr/bin/env bash
# The README's animated demo (docs/images/readme/STORYBOARD.md): the scenes driven
# with real input through tooling/drive, the window recorded, and the recording
# turned into a GIF and an MP4 (macOS only).
#
# Usage:
#   tooling/readme/record-demo.sh <mode> <out-dir> [options]
#
# Modes:
#   check      render every steps file and check it (tooling/drive-window.py --check)
#              and the captions; launches nothing, sends no input
#   layout     build the fixture and photograph it (shots/setup-*.png): confirm the
#              GUESS coordinates in steps/ from these before a recording   [real input]
#   rehearse   the fixture, then the scenes, unrecorded; each scene's first frame is
#              in marks/                                                    [real input]
#   record     the fixture, the scenes recorded, then convert              [real input]
#   convert    the GIF and the MP4 again from the recording a record run kept, e.g.
#              with --offset after looking at the result
#   slideshow  an input-free GIF and MP4 instead: the stills of
#              capture-stills.sh (--stills DIR), crossfaded, with the same captions
#   probe      which recorder works on this Mac: three seconds of a corner of the
#              screen with each; nothing else
#
# Options:
#   --scenes a,b,...    the scenes in order (default
#                       hero,colour,bar,spaces,split,dark,end; rail and local are
#                       left out to keep the take under 40 seconds)
#   --with-new          slideshow: add the stills of the features of beta 20
#   --scheme S          light (default) or dark
#   --recorder R        auto (default: screencapture if it records here, else ffmpeg),
#                       screencapture or ffmpeg
#   --app PATH          drive an installed copy instead of out/release
#   --idle SECONDS      how long nobody may have touched the Mac before a driven run
#                       starts (default 15); the script waits for it
#   --offset SECONDS    convert: shift the cut and the captions (default: synced on the
#                       command bar opening)
#   --max-mb N          the GIF's budget (default 8): fewer frames or pixels until it fits
#   --show-clicks       a ring at each click (screencapture only)
#   --stills DIR        slideshow: capture-stills.sh's output directory
#   --keep-profile      keep the demo profile (work/profile) after the run
#
# A driven run moves the real pointer and presses real keys: start it only with the
# operator's yes, then leave the Mac alone. It refuses to start while another
# Stedding runs, waits until nobody has touched the keyboard or pointer for --idle
# seconds, checks again between the fixture and the scenes (as
# tooling/acceptance/mac/run-mac.sh does), and stops if anyone did. check, convert
# and slideshow start no browser and record nothing.
#
# Writes under <out-dir> (a run replaces what the last one wrote):
#   demo.gif, demo.mp4   the results; timeline.txt the scenes' times
#   raw.mov              the recording (kept for convert; delete it when done)
#   steps/ marks/ shots/ the rendered steps, each scene's first frame, the fixture's
#   logs/ work/          every tool's output; the profile, the captions, the palette

# shellcheck source-path=SCRIPTDIR
# shellcheck source=./common.sh
. "$(cd "$(dirname "$0")" && pwd -P)/common.sh"

KNOWN_SCENES="hero colour bar spaces split dark rail local end"
DEMO_SCENES="hero,colour,bar,spaces,split,dark,end"
BASE_SLIDES="hero,spaces,command-bar,folders,pins,rail,private"
NEW_SLIDES="hero,spaces,command-bar,folders,pins,rail,isolated-space,local-tabs,dark-pages,private"

# The picture: the window on the brand's slate ground, a caption lane under it.
CANVAS_W=1400
MARGIN=28
GAP=12
LANE_H=64
GROUND="0x2F4858"
# The GIF's ladder: frames per second and width, tried in turn until it fits.
GIF_LADDER="15:1200 12:1200 12:1120 12:1040"
# The longest a recording may run; screencapture stops by itself at it.
CAP_SECONDS=150

MODE=""
SCENES=""
WITH_NEW=0
SCHEME="light"
RECORDER="auto"
APP_ARG=""
IDLE_NEED=15
OFFSET=""
MAX_MB=8
SHOW_CLICKS=0
STILLS_DIR=""
KEEP_PROFILE=0

PROFILE=""
MARKS=""
SHOTS=""
STEPS=""
DRIVE_PID=""
RECORDER_PID=""
T0=""

usage() {
  sed -n '2,53p' "$0"
  exit 2
}

# ------------------------------------------------------------------ the steps

render_steps() {
  local scene first last
  first="${SCENES%%,*}"
  last="${SCENES##*,}"
  for scene in $(printf '%s' "$SCENES" | tr ',' ' '); do
    case " $KNOWN_SCENES " in
      *" $scene "*) ;;
      *) die "no scene named $scene (known: $KNOWN_SCENES)" ;;
    esac
  done
  [ "$last" = end ] || die "the last scene is end: it brings the window back to the first frame"
  [ "$first" != end ] || die "end is the last scene only"
  remove_ours "$STEPS"
  mkdir -p "$STEPS"
  python3 -I "$MEDIA_PY" render "$STEPS/setup.steps" --scenes setup \
    --marks "$MARKS" --shots "$SHOTS" >/dev/null || die "steps/setup.steps does not render"
  python3 -I "$MEDIA_PY" render "$STEPS/demo.steps" --scenes "preroll,$SCENES" \
    --marks "$MARKS" --shots "$SHOTS" >/dev/null || die "the scenes do not render"
  python3 -I "$MEDIA_PY" check-captions --keys "$SCENES" || die "captions.tsv lacks a scene"
  python3 "$STEDDING_ROOT/tooling/drive-window.py" --check "$STEPS/setup.steps" >/dev/null ||
    die "$STEPS/setup.steps has errors (above)"
  python3 "$STEDDING_ROOT/tooling/drive-window.py" --check "$STEPS/demo.steps" >/dev/null ||
    die "$STEPS/demo.steps has errors (above)"
  printf '%s\n' "$SCENES" > "$STEPS/scenes.txt"
  log "steps rendered and checked: $STEPS (scenes $SCENES)"
}

# --------------------------------------------------------------- the runs

drive_run() {
  local name="$1" steps="$2" status=0
  shift 2
  log "driving: $name (log: $LOGS/$name.txt)"
  DRIVE_LOG="$LOGS/$name-browser.log" "$STEDDING_ROOT/tooling/drive" "$PROFILE" "$steps" "$@" \
    >"$LOGS/$name.txt" 2>&1 || status=$?
  [ "$status" -eq 0 ] || die "$name: tooling/drive exited $status; see $LOGS/$name.txt"
}

fixture() {
  PROFILE="$WORKDIR/profile"
  remove_ours "$MARKS"
  remove_ours "$SHOTS"
  mkdir -p "$MARKS" "$SHOTS"
  seed_profile "$PROFILE" demo --scheme "$SCHEME"
  drive_run setup "$STEPS/setup.steps" --enable-features="$DEMO_PARAMS" \
    "${BROWSER_ARGS[@]}" "${DEMO_URLS[@]}"
  log "fixture built; its pictures: $SHOTS/setup-*.png"
}

# The scenes, in one tooling/drive run on the fixture's profile (the session comes
# back). With $1 = 1 the window is recorded from the moment it exists.
scenes_run() {
  local record="$1" exe pid="" rect="" status=0 _
  exe="$(app_executable "$APP")" || die "no executable in $APP"
  log "driving: the scenes (log: $LOGS/scenes.txt)"
  DRIVE_LOG="$LOGS/scenes-browser.log" "$STEDDING_ROOT/tooling/drive" "$PROFILE" \
    "$STEPS/demo.steps" "${BROWSER_ARGS[@]}" >"$LOGS/scenes.txt" 2>&1 &
  DRIVE_PID=$!
  if [ "$record" -eq 1 ]; then
    for _ in $(seq 1 120); do
      pid="$(pids_running_executable "$exe")"
      case "$pid" in ''|*[!0-9]*) pid="" ;; esac
      [ -n "$pid" ] && rect="$(python3 "$MEDIA_PY" rect "$pid" 2>/dev/null || true)"
      [ -n "$rect" ] && break
      kill -0 "$DRIVE_PID" 2>/dev/null || break
      sleep 0.25
    done
    [ -n "$rect" ] || die "the browser's window did not appear (see $LOGS/scenes.txt)"
    start_recorder "$rect"
  fi
  wait "$DRIVE_PID" || status=$?
  DRIVE_PID=""
  [ "$record" -eq 0 ] || stop_recorder
  [ "$status" -eq 0 ] || die "the scenes stopped: tooling/drive exited $status; see $LOGS/scenes.txt"
}

# -------------------------------------------------------------- recording

# Runs a command for at most $1 seconds; an interrupt, then a kill, past that.
with_timeout() {
  local seconds="$1" pid ticks=0
  shift
  "$@" &
  pid=$!
  while kill -0 "$pid" 2>/dev/null; do
    if [ "$ticks" -ge $((seconds * 4)) ]; then
      kill -INT "$pid" 2>/dev/null || true
      sleep 1
      kill -9 "$pid" 2>/dev/null || true
      wait "$pid" 2>/dev/null || true
      return 124
    fi
    sleep 0.25
    ticks=$((ticks + 1))
  done
  wait "$pid"
}

# The avfoundation device of the main display, for ffmpeg.
screen_device() {
  { "$FFMPEG" -hide_banner -f avfoundation -list_devices true -i "" 2>&1 || true; } |
    sed -n 's/.*\[\([0-9][0-9]*\)\] Capture screen 0.*/\1/p' | head -1
}

frames_in() {
  "$FFPROBE" -v error -count_frames -select_streams v:0 \
    -show_entries stream=nb_read_frames -of csv=p=0 "$1" 2>/dev/null | head -1
}

# probe_one <recorder> <file>: two seconds of a corner of the main display.
probe_one() {
  local device frames
  rm -f "$2"
  case "$1" in
    screencapture)
      with_timeout 12 screencapture -v -x -V2 -R0,60,240,160 "$2" >/dev/null 2>&1 || return 1 ;;
    ffmpeg)
      device="$(screen_device)"
      [ -n "$device" ] || return 1
      with_timeout 12 "$FFMPEG" -nostdin -hide_banner -v error -f avfoundation -framerate 30 \
        -pixel_format bgr0 -i "$device:none" -t 2 -c:v h264_videotoolbox -b:v 4M "$2" \
        >/dev/null 2>&1 || return 1 ;;
  esac
  frames="$(frames_in "$2")"
  case "$frames" in ''|*[!0-9]*) return 1 ;; esac
  [ "$frames" -ge 10 ]
}

choose_recorder() {
  local file="$WORKDIR/probe.mov"
  case "$RECORDER" in
    screencapture|ffmpeg) log "recorder: $RECORDER"; return 0 ;;
  esac
  if probe_one screencapture "$file"; then
    RECORDER=screencapture
  elif probe_one ffmpeg "$file"; then
    RECORDER=ffmpeg
  else
    rm -f "$file"
    die "neither screencapture nor ffmpeg recorded the screen here; does this terminal have Screen Recording permission (System Settings, Privacy and Security)?"
  fi
  rm -f "$file"
  log "recorder: $RECORDER (it recorded a test corner of the screen)"
}

# start_recorder "<x> <y> <w> <h> <scale> <screen w> <screen h>": the window's rect.
start_recorder() {
  local x y w h scale sw sh clicks=() device
  read -r x y w h scale sw sh <<EOF
$1
EOF
  rm -f "$OUT/raw.mov"
  T0="$(python3 -c 'import time; print("%.3f" % time.time())')"
  case "$RECORDER" in
    screencapture)
      [ "$SHOW_CLICKS" -eq 0 ] || clicks=(-k)
      screencapture -v -x -C ${clicks[@]+"${clicks[@]}"} -V"$CAP_SECONDS" -R"$x,$y,$w,$h" \
        "$OUT/raw.mov" >"$LOGS/recorder.txt" 2>&1 &
      ;;
    ffmpeg)
      device="$(screen_device)"
      [ -n "$device" ] || die "ffmpeg lists no screen to record"
      "$FFMPEG" -nostdin -hide_banner -v error -f avfoundation -capture_cursor 1 -framerate 30 \
        -pixel_format bgr0 -i "$device:none" -t "$CAP_SECONDS" -c:v h264_videotoolbox -b:v 24M \
        -movflags +frag_keyframe+empty_moov -f mov "$OUT/raw.mov" >"$LOGS/recorder.txt" 2>&1 &
      ;;
  esac
  RECORDER_PID=$!
  {
    printf 'RECORDER=%s\n' "$RECORDER"
    printf 'T0=%s\n' "$T0"
    printf 'RECT=%s %s %s %s\n' "$x" "$y" "$w" "$h"
    printf 'SCALE=%s\n' "$scale"
    printf 'SCREEN=%s %s\n' "$sw" "$sh"
    printf 'SCENES=%s\n' "$SCENES"
    printf 'SCHEME=%s\n' "$SCHEME"
    printf 'APP_VERSION=%s\n' "$(app_version)"
  } > "$OUT/recording.env"
  log "recording the window at $x,$y ${w}x${h} with $RECORDER"
}

stop_recorder() {
  [ -n "$RECORDER_PID" ] || return 0
  case "$RECORDER" in
    # ffmpeg writes its file out on an interrupt.
    ffmpeg) kill -INT "$RECORDER_PID" 2>/dev/null || true ;;
    # screencapture stops by itself at -V; an interrupt may leave no file.
    screencapture) log "waiting for screencapture to finish (at most $CAP_SECONDS s from the start)" ;;
  esac
  wait "$RECORDER_PID" 2>/dev/null || true
  RECORDER_PID=""
  [ -s "$OUT/raw.mov" ] || die "the recorder wrote no $OUT/raw.mov (see $LOGS/recorder.txt)"
}

# ---------------------------------------------------------------- converting

env_get() {
  sed -n "s/^$1=//p" "$OUT/recording.env" | tail -1
}

# The picture's sizes for a window of $1 x $2 pixels: sets WIN_W WIN_H TOP_H.
canvas_sizes() {
  WIN_W=$((CANVAS_W - 2 * MARGIN))
  WIN_H=$(( (WIN_W * $2 / $1) / 2 * 2 ))
  TOP_H=$((MARGIN + WIN_H + GAP))
}

# The GIF in the budget, then the MP4, from the composed picture $1.
finish() {
  local composed="$1" step fps width size budget
  budget=$((MAX_MB * 1024 * 1024))
  for step in $GIF_LADDER; do
    fps="${step%%:*}"
    width="${step#*:}"
    "$FFMPEG" -nostdin -y -hide_banner -v error -i "$composed" \
      -vf "fps=$fps,scale=$width:-2:flags=lanczos,palettegen=max_colors=256:stats_mode=full" \
      -frames:v 1 -update 1 "$WORKDIR/palette.png" || die "palettegen failed"
    "$FFMPEG" -nostdin -y -hide_banner -v error -i "$composed" -i "$WORKDIR/palette.png" \
      -filter_complex "[0:v]fps=$fps,scale=$width:-2:flags=lanczos,mpdecimate[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=4:diff_mode=rectangle" \
      -fps_mode vfr -loop 0 "$OUT/demo.gif" || die "the GIF did not encode"
    size="$(stat -f %z "$OUT/demo.gif")"
    log "demo.gif at $fps fps, $width px wide: $((size / 1024)) KB"
    [ "$size" -gt "$budget" ] || break
  done
  [ "$size" -le "$budget" ] || warn "demo.gif is over ${MAX_MB} MB even at $fps fps and $width px; shorten the scenes"
  "$FFMPEG" -nostdin -y -hide_banner -v error -i "$composed" -c:v libx264 -preset slow -crf 18 \
    -pix_fmt yuv420p -movflags +faststart "$OUT/demo.mp4" || die "the MP4 did not encode"
  log "demo.mp4: $(( $(stat -f %z "$OUT/demo.mp4") / 1024 )) KB"
}

convert_recording() {
  local raw="$OUT/raw.mov" crop="" raw_w rx ry rw rh sw scale changes start stop dur mask
  require_ffmpeg
  [ -f "$OUT/recording.env" ] || die "no $OUT/recording.env: record first"
  [ -s "$raw" ] || die "no recording at $raw"
  RECORDER="$(env_get RECORDER)"
  T0="$(env_get T0)"
  SCENES="$(env_get SCENES)"
  raw_w="$("$FFPROBE" -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$raw" | head -1)"
  [ -n "$raw_w" ] || die "ffprobe cannot read $raw"
  if [ "$RECORDER" = ffmpeg ]; then
    # ffmpeg recorded the whole display: cut the window out, in the recording's pixels.
    read -r rx ry rw rh <<EOF
$(env_get RECT)
EOF
    sw="$(env_get SCREEN)"
    sw="${sw%% *}"
    scale="$(awk -v a="$raw_w" -v b="$sw" 'BEGIN { printf "%.6f", a / b }')"
    crop="$(awk -v s="$scale" -v x="$rx" -v y="$ry" -v w="$rw" -v h="$rh" \
      'BEGIN { printf "crop=%d:%d:%d:%d,", int(w*s/2)*2, int(h*s/2)*2, int(x*s), int(y*s) }')"
  fi
  changes="$WORKDIR/changes.txt"
  "$FFMPEG" -nostdin -hide_banner -v error -i "$raw" \
    -vf "${crop}scale=480:-2,select='gt(scene,0.02)',metadata=print:file=-" -f null - \
    >"$changes" 2>"$LOGS/changes.txt" || warn "no scene changes read; the captions are not synced"
  local lane="$WORKDIR/lane" first
  remove_ours "$lane"
  if [ -n "$OFFSET" ]; then
    python3 -I "$MEDIA_PY" timeline --marks "$MARKS" --scenes "$SCENES" --t0 "$T0" \
      --lane "$lane" --offset "$OFFSET" --out "$WORKDIR" || die "no timeline"
  else
    python3 -I "$MEDIA_PY" timeline --marks "$MARKS" --scenes "$SCENES" --t0 "$T0" \
      --lane "$lane" --changes "$changes" --out "$WORKDIR" || die "no timeline"
  fi
  cp "$WORKDIR/timeline.txt" "$OUT/timeline.txt"
  start="$(sed -n 's/^TRIM_START=//p' "$WORKDIR/timeline.env")"
  stop="$(sed -n 's/^TRIM_END=//p' "$WORKDIR/timeline.env")"
  dur="$(sed -n 's/^DURATION=//p' "$WORKDIR/timeline.env")"
  python3 "$MEDIA_PY" captions "$lane" --width "$CANVAS_W" --height "$LANE_H" --keys "$SCENES" \
    >/dev/null || die "the captions did not render"
  # The window's own shape: the first scene's marker is a capture of the window by
  # its id, with transparent corners; its alpha cuts the corners out of every frame.
  first="${SCENES%%,*}"
  mask="$MARKS/$first.png"
  [ -f "$mask" ] || die "no $mask"
  read -r rw rh <<EOF
$(sips -g pixelWidth -g pixelHeight "$mask" | awk '/pixelWidth/ { w = $2 } /pixelHeight/ { h = $2 } END { print w, h }')
EOF
  canvas_sizes "$rw" "$rh"
  local filter
  filter="[0:v]${crop}fps=30,scale=$WIN_W:$WIN_H:flags=lanczos,format=rgba[win];"
  filter="${filter}[1:v]scale=$WIN_W:$WIN_H:flags=lanczos,format=rgba,alphaextract[shape];"
  filter="${filter}[win][shape]alphamerge[shaped];"
  filter="${filter}color=c=$GROUND:s=${CANVAS_W}x$TOP_H:r=30:d=${dur}[ground];"
  filter="${filter}[ground][shaped]overlay=x=$MARGIN:y=$MARGIN:shortest=1,format=rgb24[top];"
  filter="${filter}[2:v]fps=30,scale=$CANVAS_W:$LANE_H,format=rgb24[lane];"
  filter="${filter}[top][lane]vstack=inputs=2:shortest=1,setsar=1[out]"
  log "composing $dur s of the recording"
  "$FFMPEG" -nostdin -y -hide_banner -v error -ss "$start" -to "$stop" -i "$raw" \
    -loop 1 -framerate 30 -t "$dur" -i "$mask" -f concat -safe 0 -i "$WORKDIR/lane.txt" \
    -filter_complex "$filter" -map "[out]" -c:v libx264rgb -preset veryfast -qp 0 \
    "$WORKDIR/composed.mkv" || die "composing failed"
  finish "$WORKDIR/composed.mkv"
  rm -f "$WORKDIR/composed.mkv"
  log "done: $OUT/demo.gif and $OUT/demo.mp4; the times are in $OUT/timeline.txt"
}

# An input-free GIF: capture-stills.sh's window captures, each held, crossfaded.
slideshow() {
  local hold=4.2 fade=0.6 name names=() starts="" total n k offset filter="" inputs=() prev
  require_ffmpeg
  [ -n "$STILLS_DIR" ] && [ -d "$STILLS_DIR/raw" ] ||
    die "--stills <dir>: capture-stills.sh's output directory (its raw/ holds the captures)"
  for name in $(printf '%s' "$SCENES" | tr ',' ' '); do
    if [ -f "$STILLS_DIR/raw/$name.png" ]; then
      names+=("$name")
    else
      warn "no still $name in $STILLS_DIR/raw; left out"
    fi
  done
  n="${#names[@]}"
  [ "$n" -ge 2 ] || die "a slideshow needs two stills or more"
  canvas_sizes 1400 880
  total="$(awk -v n="$n" -v h="$hold" -v f="$fade" 'BEGIN { printf "%.3f", n * h - (n - 1) * f }')"
  local keys
  keys="$(printf '%s,' "${names[@]}")"
  keys="${keys%,}"
  python3 -I "$MEDIA_PY" check-captions --keys "$keys" || die "captions.tsv lacks a still"
  local lane="$WORKDIR/lane"
  remove_ours "$lane"
  python3 "$MEDIA_PY" captions "$lane" --width "$CANVAS_W" --height "$LANE_H" --keys "$keys" \
    >/dev/null || die "the captions did not render"
  for k in $(seq 0 $((n - 1))); do
    starts="$starts$(awk -v k="$k" -v h="$hold" -v f="$fade" 'BEGIN { printf "%.3f", k * (h - f) }'),"
    inputs+=(-loop 1 -framerate 30 -t "$hold" -i "$STILLS_DIR/raw/${names[$k]}.png")
    filter="${filter}[$k:v]scale=$WIN_W:$WIN_H:force_original_aspect_ratio=decrease:flags=lanczos,format=rgba[w$k];"
    filter="${filter}color=c=$GROUND:s=${CANVAS_W}x$TOP_H:r=30:d=${hold}[g$k];"
    filter="${filter}[g$k][w$k]overlay=x=(W-w)/2:y=$MARGIN+($WIN_H-h)/2:shortest=1,format=rgb24,settb=AVTB[s$k];"
  done
  python3 -I "$MEDIA_PY" lane --keys "$keys" --starts "${starts%,}" --total "$total" \
    --lane "$lane" --out "$WORKDIR/lane.txt" || die "no caption lane"
  prev="s0"
  for k in $(seq 1 $((n - 1))); do
    offset="$(awk -v k="$k" -v h="$hold" -v f="$fade" 'BEGIN { printf "%.3f", k * (h - f) }')"
    filter="${filter}[$prev][s$k]xfade=transition=fade:duration=$fade:offset=${offset}[x$k];"
    prev="x$k"
  done
  filter="${filter}[$n:v]fps=30,scale=$CANVAS_W:$LANE_H,format=rgb24[lane];"
  filter="${filter}[$prev][lane]vstack=inputs=2:shortest=1,setsar=1[out]"
  log "composing $n stills, $total s"
  "$FFMPEG" -nostdin -y -hide_banner -v error "${inputs[@]}" -f concat -safe 0 -i "$WORKDIR/lane.txt" \
    -filter_complex "$filter" -map "[out]" -c:v libx264rgb -preset veryfast -qp 0 \
    "$WORKDIR/composed.mkv" || die "composing failed"
  finish "$WORKDIR/composed.mkv"
  rm -f "$WORKDIR/composed.mkv"
  log "done: $OUT/demo.gif and $OUT/demo.mp4 from the stills ($(printf '%s ' "${names[@]}"))"
}

probe() {
  local r file frames
  require_ffmpeg
  for r in screencapture ffmpeg; do
    file="$WORKDIR/probe-$r.mov"
    if probe_one "$r" "$file"; then
      frames="$(frames_in "$file")"
      log "$r: recorded $frames frames of a corner of the screen ($file)"
    else
      warn "$r: recorded nothing here (see the log of a manual run; Screen Recording permission?)"
    fi
  done
}

# ------------------------------------------------------------------- main

cleanup() {
  if [ -n "$DRIVE_PID" ]; then
    # drive-window.py lets go of every key and button it pressed on a TERM, and
    # tooling/drive then quits the browser it launched.
    pkill -TERM -P "$DRIVE_PID" 2>/dev/null || true
    kill -TERM "$DRIVE_PID" 2>/dev/null || true
    wait "$DRIVE_PID" 2>/dev/null || true
    DRIVE_PID=""
  fi
  if [ -n "$RECORDER_PID" ]; then
    # A run that stops early keeps no recording worth converting.
    kill -TERM "$RECORDER_PID" 2>/dev/null || true
    wait "$RECORDER_PID" 2>/dev/null || true
    RECORDER_PID=""
  fi
  stop_local_servers
  if [ -n "$PROFILE" ] && [ "$KEEP_PROFILE" -eq 0 ] && [ -d "$PROFILE" ]; then
    remove_ours "$PROFILE"
  fi
}

main() {
  [ $# -ge 2 ] || usage
  MODE="$1"
  case "$MODE" in
    check|layout|rehearse|record|convert|slideshow|probe) ;;
    *) usage ;;
  esac
  set_out_dir "$2"
  shift 2
  while [ $# -gt 0 ]; do
    case "$1" in
      --with-new) WITH_NEW=1; shift ;;
      --scenes) SCENES="${2:-}"; shift 2 ;;
      --scheme) SCHEME="${2:-}"; shift 2 ;;
      --recorder) RECORDER="${2:-}"; shift 2 ;;
      --app) APP_ARG="${2:-}"; shift 2 ;;
      --idle) IDLE_NEED="${2:-}"; shift 2 ;;
      --offset) OFFSET="${2:-}"; shift 2 ;;
      --max-mb) MAX_MB="${2:-}"; shift 2 ;;
      --show-clicks) SHOW_CLICKS=1; shift ;;
      --stills) STILLS_DIR="${2:-}"; shift 2 ;;
      --keep-profile) KEEP_PROFILE=1; shift ;;
      *) die "unknown option $1 (see the top of $0)" ;;
    esac
  done
  case "$SCHEME" in light|dark) ;; *) die "--scheme takes light or dark" ;; esac
  case "$RECORDER" in auto|screencapture|ffmpeg) ;; *) die "--recorder takes auto, screencapture or ffmpeg" ;; esac
  case "$IDLE_NEED" in ''|*[!0-9]*) die "--idle takes whole seconds" ;; esac
  case "$MAX_MB" in ''|*[!0-9]*) die "--max-mb takes whole megabytes" ;; esac
  case "$OFFSET" in ''|-[0-9]*|[0-9]*) ;; *) die "--offset takes seconds, e.g. -0.4" ;; esac
  if [ -z "$SCENES" ]; then
    if [ "$MODE" = slideshow ]; then
      SCENES="$BASE_SLIDES"
      [ "$WITH_NEW" -eq 0 ] || SCENES="$NEW_SLIDES"
    else
      SCENES="$DEMO_SCENES"
    fi
  fi
  MARKS="$OUT/marks"
  SHOTS="$OUT/shots"
  STEPS="$OUT/steps"
  trap cleanup EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM

  case "$MODE" in
    check)
      render_steps
      return 0 ;;
    convert)
      convert_recording
      return 0 ;;
    slideshow)
      slideshow
      return 0 ;;
  esac

  # The rest start a browser or record the screen.
  [ -z "$APP_ARG" ] || use_app "$APP_ARG"
  preflight_browser
  if [ "$MODE" = probe ]; then
    probe
    return 0
  fi
  render_steps
  if [ "$MODE" = record ]; then
    require_ffmpeg
    choose_recorder
  fi
  start_local_servers
  wait_for_empty_chair "$IDLE_NEED"
  fixture
  [ "$MODE" != layout ] || { log "look at $SHOTS/setup-*.png and confirm the GUESS coordinates in tooling/readme/steps/"; return 0; }
  still_empty "the scenes"
  if [ "$MODE" = rehearse ]; then
    scenes_run 0
    log "rehearsed: each scene's first frame is in $MARKS"
    return 0
  fi
  scenes_run 1
  log "recorded $OUT/raw.mov; converting"
  stop_local_servers
  convert_recording
}

main "$@"
