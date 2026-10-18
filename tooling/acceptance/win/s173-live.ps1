<#
The live half of BACKLOG S-173 on Windows: the core-loop acceptance script (TST-6), the drags
onto a folder header and a Space chip (TST-7) and the core keyboard (TST-9), with real input
through tooling\win\drive.ps1. Rows, buttons and chips are found by UI Automation
(Drive-Rows), never by fixed coordinates; what a step did is read back from DevTools
(Drive-Visible: the page that says it is visible) and UI Automation, not from a picture. The
captures are for the record.

It moves the real pointer and presses real keys: run it only with the operator's yes, nobody
at the keyboard, in a connected session (docs/HANDOFF.md trap 59). drive.ps1's guards stop
input whenever another window is in front or the operator touched the machine.

  powershell -NoProfile -ExecutionPolicy Bypass -File s173-live.ps1 -Part layout
  powershell -NoProfile -ExecutionPolicy Bypass -File s173-live.ps1 -Part all
  powershell ... -Part all -Exe "$env:LOCALAPPDATA\Stedding\Application\chrome.exe"   # installed

-Part layout builds the fixture and lists what UI Automation sees (rows, buttons, chips), so
the names this script looks for can be confirmed first. Results: one PASS or FAIL line per
step in $env:TEMP\stedding-s173\results.txt; captures in $env:TEMP\stedding-drive.

Names the script assumes and -Part layout confirms (GUESS): a row's UI Automation name starts
with its page title; the folder's header is a Button whose name holds "New Folder"; a Space
chip is a Button whose name holds the Space's name; the sidebar's toggle is a Button whose
name holds "sidebar"; the address field is an Edit whose name holds "Address".
#>
param(
  [ValidateSet('layout', 'tst6', 'tst7', 'tst9', 'all')][string]$Part = 'layout',
  [string]$Exe = '',
  [string]$Repo = (Join-Path $env:USERPROFILE 'work\stedding-browser')
)
$ErrorActionPreference = 'Stop'
$drive = Join-Path $Repo 'tooling\win\drive.ps1'
if ($Exe) { . $drive -Exe $Exe } else { . $drive }

$work = Join-Path $env:TEMP 'stedding-s173'
$pages = Join-Path $work 'pages'
New-Item -ItemType Directory -Force $pages | Out-Null
foreach ($n in 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') {
  $t = 'Page ' + $n.ToUpper()
  "<!doctype html><meta charset=`"utf-8`"><title>$t</title><body style=`"font:48px sans-serif;margin:40px`">$t</body>" |
    Set-Content -Path (Join-Path $pages "$n.html") -Encoding UTF8
}
function Url([string]$n) { 'file:///' + ((Join-Path $pages "$n.html") -replace '\\', '/') }

$results = Join-Path $work 'results.txt'
"S-173 live run $(Get-Date -Format s) exe=$($script:Drive.Exe)" | Set-Content -Path $results -Encoding UTF8
function Result([string]$Id, [bool]$Ok, [string]$What, [string]$Seen) {
  $line = '{0,-8} {1} {2} | seen: {3}' -f $Id, $(if ($Ok) { 'PASS' } else { 'FAIL' }), $What, $Seen
  Add-Content -Path $results -Value $line -Encoding UTF8
  Drive-Log $line
}

# ---- what UI Automation and DevTools say ----------------------------------------------------

function Row([string]$Title) { Drive-Rows | Where-Object { $_.Name -like "$Title*" } | Select-Object -First 1 }
function RowNames { (Drive-Rows | Sort-Object Y | ForEach-Object { $_.Name }) -join ', ' }
function Button([string]$Pattern) { Drive-Rows 'Button' | Where-Object { $_.Name -like $Pattern } | Select-Object -First 1 }
function Visible { Start-Sleep -Milliseconds 400; Drive-Visible }
# The browser's own top-level windows: a drag that tears a window off makes two.
function BrowserWindows {
  @([StedDrive]::WindowsOf([uint32]$script:Drive.Pid) | Where-Object {
      $cls = New-Object Text.StringBuilder 256; [void][StedDrive]::GetClassName($_, $cls, 256)
      $r = New-Object StedDrive+RECT; [void][StedDrive]::GetWindowRect($_, [ref]$r)
      $cls.ToString() -eq 'Chrome_WidgetWin_1' -and ($r.Right - $r.Left) -gt 300 }).Count
}
# Whether the sidebar is the rail: Page A's row narrower than half its open width.
$script:OpenWidth = 0
function IsRail { $a = Row 'Page A'; return [bool]($a -and $script:OpenWidth -gt 0 -and $a.W -lt $script:OpenWidth / 2) }
function IsOpen { $a = Row 'Page A'; return [bool]($a -and $script:OpenWidth -gt 0 -and $a.W -ge $script:OpenWidth * 0.9) }

# ---- input that drive.ps1 has no single call for ---------------------------------------------

function ClickRow([string]$Title) {
  $r = Row $Title
  if (-not $r) { Drive-Log "no row '$Title' (rows: $(RowNames))"; return $false }
  return (Drive-Click $r.X $r.Y)
}
function ClickButton([string]$Pattern) {
  $b = Button $Pattern
  if (-not $b) { Drive-Log "no button like '$Pattern'"; return $false }
  return (Drive-Click $b.X $b.Y)
}
# The pointer off the sidebar, so a hover-expanded rail folds back (sidebar Y11).
function Away {
  $r = Drive-VisibleRect
  Drive-Move ([int](($r.Left + $r.Right) / 2 + 200)) ([int](($r.Top + $r.Bottom) / 2))
  Start-Sleep -Milliseconds 2500
}
# A key held down on its own, and let go (Ctrl for the row numbers and Ctrl+Tab).
function Hold([string]$Key) { if (-not (Drive-Guard)) { return $false }; Drive-Key (Drive-VkOf $Key); Drive-Mark; return $true }
function Release([string]$Key) { Drive-Key (Drive-VkOf $Key) -Up; Drive-Mark }
# A drag in two halves, so a capture can land while the button is down (a drop highlight).
function DragTo([int]$x1, [int]$y1, [int]$x2, [int]$y2) {
  if (-not (Drive-Guard)) { return $false }
  Drive-Move $x1 $y1; Start-Sleep -Milliseconds 150
  [StedDrive]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero); Start-Sleep -Milliseconds 120
  for ($i = 1; $i -le 30; $i++) {
    if (-not (Drive-ForegroundIsBrowser)) { DropHere; Drive-Log 'REFUSED mid-drag: released'; return $false }
    Drive-Move ([int]($x1 + ($x2 - $x1) * $i / 30)) ([int]($y1 + ($y2 - $y1) * $i / 30))
    Start-Sleep -Milliseconds 18
  }
  Start-Sleep -Milliseconds 500
  Drive-Mark
  return $true
}
function DropHere { [StedDrive]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero); Start-Sleep -Milliseconds 800; Drive-Mark }

# ---- the profile -----------------------------------------------------------------------------

$seed = @{
  stedding = @{
    welcome = @{ shown = $true }
    spaces  = @{ registry = @(
        @{ id = '5ED1D9A1A0C04B0B9C1F0A11C0FE0001'; name = 'Home'; color = -10785908; color_chosen = $false; icon = ''; isolated = $false; pins_collapsed = $false; profile = '' },
        @{ id = '5ED1D9A1A0C04B0B9C1F0A11C0FE0002'; name = 'Work'; color = -10785908; color_chosen = $false; icon = ''; isolated = $false; pins_collapsed = $false; profile = '' },
        @{ id = '5ED1D9A1A0C04B0B9C1F0A11C0FE0003'; name = 'Play'; color = -10785908; color_chosen = $false; icon = ''; isolated = $false; pins_collapsed = $false; profile = '' }) }
  }
}
$extra = @('--disable-search-engine-choice-screen')

# A seeded profile and the fixture, filed through the product's own keys:
#   Home: Page A, a folder holding Page B, Page C, Page D;  Work: Page E;  Play: Page F.
function Fixture([string]$Name) {
  $dir = Join-Path $work "profile-$Name"
  $null = Drive-Launch -Profile $dir -Urls (@('a', 'b', 'c', 'd', 'e', 'f') | ForEach-Object { Url $_ }) -Seed $seed -Extra $extra
  Start-Sleep -Seconds 4
  if (-not (Drive-Focus)) { throw 'the browser did not come to the front' }
  $null = Drive-Keys 'ctrl+2'
  $null = Drive-Keys 'ctrl+shift+p'; Start-Sleep -Milliseconds 800
  $null = Drive-Type 'new folder'; Start-Sleep -Milliseconds 1200
  $null = Drive-Shot "$Name-setup-01-actions"
  $null = Drive-Keys 'enter'; Start-Sleep -Milliseconds 1200
  $null = Drive-Keys 'ctrl+5'
  $null = Drive-Keys 'ctrl+alt+shift+right'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'ctrl+5'
  $null = Drive-Keys 'ctrl+alt+shift+right'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'ctrl+alt+shift+right'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'ctrl+1'; Start-Sleep -Seconds 1
  $null = Drive-Shot "$Name-setup-02-open"
  $script:OpenWidth = (Row 'Page A').W
  $rows = RowNames
  Result "$Name-0" ($rows -like 'Page A*Page B*Page C*Page D*' -and $rows -notlike '*Page E*' -and $rows -notlike '*Page F*') 'fixture: Home shows A, B (in the folder), C, D and no other Space''s rows' $rows
  return $dir
}

function Quit([string]$Dir) {
  $null = Drive-Keys 'ctrl+shift+w'
  for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Milliseconds 500
    $left = Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" | Where-Object { $_.CommandLine -like "*$Dir*" }
    if (-not $left) { return $true }
  }
  return $false
}

# The same profile again, kept: Drive-Launch would wipe it.
function Relaunch([string]$Dir) {
  $argv = @("--user-data-dir=$Dir", "--remote-debugging-port=$($script:Drive.Port)") + $extra
  $null = Start-Process -FilePath $script:Drive.Exe -ArgumentList $argv -PassThru
  $h = [IntPtr]::Zero
  for ($i = 0; $i -lt 60 -and $h -eq [IntPtr]::Zero; $i++) { Start-Sleep -Milliseconds 500; $h = Drive-Find $Dir }
  if ($h -eq [IntPtr]::Zero) { throw "no window after the relaunch on $Dir" }
  Start-Sleep -Seconds 4
  return (Drive-Focus)
}

# ---- TST-6: the core loop ------------------------------------------------------------------

function Tst6 {
  $dir = Fixture 'tst6'
  $null = Drive-Shot 'tst6-01-start'
  Result 'tst6-1' ((Visible) -eq 'Page A') 'start: Home on screen, Page A selected' (Visible)

  $ok = $true; $seen = @()
  foreach ($t in 'Page A', 'Page B', 'Page C', 'Page D') {
    $null = ClickRow $t; $v = Visible; $seen += "$t->$v"; $ok = $ok -and ($v -eq $t)
  }
  $null = Drive-Shot 'tst6-02-open-rows'
  Result 'tst6-2' $ok 'a click on each row of the open sidebar selects it and shows its page' ($seen -join '; ')

  if (-not (ClickButton '*sidebar*')) { $null = Drive-Keys 'ctrl+s' }
  Start-Sleep -Seconds 2; Away
  $a = Row 'Page A'
  $null = Drive-Shot 'tst6-03-rail'
  Result 'tst6-3' (IsRail) 'the toggle closes the sidebar to the rail' "row A is $($a.W) px wide, $($script:OpenWidth) px open"

  $ok = $true; $seen = @()
  foreach ($t in 'Page A', 'Page B', 'Page D', 'Page A') {
    $null = ClickRow $t; $v = Visible; $seen += "$t->$v"; $ok = $ok -and ($v -eq $t); Away
  }
  $null = Drive-Shot 'tst6-04-rail-rows'
  Result 'tst6-4' ($ok -and (IsRail)) 'a click on each row of the rail selects it; the rail stays a rail' ($seen -join '; ')

  if (-not (ClickButton '*sidebar*')) { $null = Drive-Keys 'ctrl+s' }
  Start-Sleep -Seconds 2; Away
  $a = Row 'Page A'
  Result 'tst6-5' (IsOpen) 'the toggle opens the sidebar again' "row A is $($a.W) px wide"

  $null = ClickButton '*Work*'; Start-Sleep -Seconds 2
  $v = Visible; $null = Drive-Shot 'tst6-06-chip-work'
  Result 'tst6-6' ($v -eq 'Page E' -and -not (Row 'Page A')) 'the Work chip shows Work: Page E, no row of Home' "$v; rows: $(RowNames)"

  $null = Drive-Keys 'alt+3'; Start-Sleep -Seconds 2
  $v = Visible; $null = Drive-Shot 'tst6-07-alt3-play'
  Result 'tst6-7' ($v -eq 'Page F') 'Alt+3 shows Play: Page F' $v

  $null = Drive-Keys 'ctrl+alt+left'; Start-Sleep -Seconds 2; $v1 = Visible
  $null = Drive-Keys 'ctrl+alt+left'; Start-Sleep -Seconds 2; $v2 = Visible
  $null = Drive-Shot 'tst6-08-previous-twice'
  Result 'tst6-8' ($v1 -eq 'Page E' -and $v2 -eq 'Page A') 'Ctrl+Alt+Left twice: Work (Page E), then Home on the tab left there (Page A)' "$v1, then $v2"

  $null = Drive-Keys 'ctrl+t'; Start-Sleep -Milliseconds 800
  $null = Drive-Type 'Page F'; Start-Sleep -Milliseconds 1500
  $null = Drive-Keys 'down'
  $null = Drive-Shot 'tst6-09a-bar'
  $null = Drive-Keys 'enter'; Start-Sleep -Seconds 2
  $v = Visible; $null = Drive-Shot 'tst6-09b-bar-play'
  Result 'tst6-9' ($v -eq 'Page F' -and (Row 'Page F')) 'the bar''s row for another Space''s tab switches to Play and shows Page F' "$v; rows: $(RowNames)"

  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  $null = ClickRow 'Page A'
  $null = ClickButton '*New Folder*'; Start-Sleep -Milliseconds 1500
  $collapsed = -not (Row 'Page B')
  $null = Drive-Shot 'tst6-10a-collapsed'
  $null = Drive-Keys 'alt+2'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  $v = Visible; $null = Drive-Shot 'tst6-10b-back'
  Result 'tst6-10' ($collapsed -and -not (Row 'Page B') -and $v -eq 'Page A') 'the collapsed folder hides Page B; away and back it is still collapsed and Page A is on screen' "$v; rows: $(RowNames)"

  $quit = Quit $dir
  $back = Relaunch $dir
  $v = Visible; $rows = RowNames; $null = Drive-Shot 'tst6-11a-relaunched'
  $null = Drive-Keys 'alt+2'; Start-Sleep -Seconds 2; $w = Visible
  $null = Drive-Keys 'alt+3'; Start-Sleep -Seconds 2; $p = Visible
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  Result 'tst6-11' ($quit -and $back -and $v -eq 'Page A' -and $rows -notlike '*Page B*' -and $rows -like '*Page C*Page D*' -and $w -eq 'Page E' -and $p -eq 'Page F') 'quit and relaunch: Home on Page A, the folder still collapsed, Work and Play as left' "quit=$quit back=$back; $v; rows: $rows; Work: $w; Play: $p"

  $before = (Drive-Rows).Count
  $null = Drive-Keys 'ctrl+t'; Start-Sleep -Milliseconds 800
  $null = Drive-Type (Url 'g'); Start-Sleep -Milliseconds 800
  $null = Drive-Keys 'enter'; Start-Sleep -Seconds 3
  $v = Visible; $after = (Drive-Rows).Count; $null = Drive-Shot 'tst6-12-ctrl-t'
  Result 'tst6-12' ($v -eq 'Page G' -and $after -eq $before + 1 -and (Row 'Page G')) 'Ctrl+T, an address, Enter: a new row in Home shows Page G' "$v; rows $before -> $after"

  $before = (Drive-Rows).Count
  $null = Drive-Keys 'ctrl+l'; Start-Sleep -Milliseconds 800
  $null = Drive-Shot 'tst6-13a-ctrl-l'
  $null = Drive-Type (Url 'h'); Start-Sleep -Milliseconds 800
  $null = Drive-Keys 'enter'; Start-Sleep -Seconds 3
  $v = Visible; $after = (Drive-Rows).Count; $null = Drive-Shot 'tst6-13b-same-tab'
  Result 'tst6-13' ($v -eq 'Page H' -and $after -eq $before -and -not (Row 'Page G')) 'Ctrl+L, an address, Enter: the same row now shows Page H; no new row' "$v; rows $before -> $after"
  Drive-Stop
}

# ---- TST-7: drags onto a folder header and a Space chip --------------------------------------

function Tst7 {
  $null = Fixture 'tst7'
  # Open sidebar, Page D onto the folder's header.
  $d = Row 'Page D'; $h = Button '*New Folder*'
  $null = DragTo $d.X $d.Y $h.X $h.Y
  $null = Drive-Shot 'tst7-01a-open-over-header'
  DropHere
  # Membership: collapsing the folder hides its rows.
  $null = ClickButton '*New Folder*'; Start-Sleep -Milliseconds 1200
  $inside = -not (Row 'Page D') -and -not (Row 'Page B')
  $null = ClickButton '*New Folder*'; Start-Sleep -Milliseconds 1200
  $null = Drive-Shot 'tst7-01b-open-joined'
  Result 'tst7-1' ($inside -and (Row 'Page D')) 'open sidebar: Page D dropped on the folder header joins the folder' "rows: $(RowNames)"

  # Open sidebar, Page C onto the Work chip.
  $c = Row 'Page C'; $chip = Button '*Work*'
  $null = DragTo $c.X $c.Y $chip.X $chip.Y
  $null = Drive-Shot 'tst7-02a-open-over-chip'
  DropHere; Start-Sleep -Seconds 1
  $v = Visible; $windows = BrowserWindows
  $null = Drive-Shot 'tst7-02b-open-moved'
  Result 'tst7-2' ($v -eq 'Page C' -and (Row 'Page E') -and (Row 'Page C') -and $windows -eq 1) 'open sidebar: Page C dropped on the Work chip moves to Work, which comes on screen with it; no window tears off' "$v; rows: $(RowNames); windows: $windows"
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2

  # The rail.
  if (-not (ClickButton '*sidebar*')) { $null = Drive-Keys 'ctrl+s' }
  Start-Sleep -Seconds 2; Away
  $a = Row 'Page A'; $h = Button '*New Folder*'
  $null = DragTo $a.X $a.Y $h.X $h.Y
  $null = Drive-Shot 'tst7-03a-rail-over-glyph'
  DropHere; Away
  $null = ClickButton '*New Folder*'; Start-Sleep -Milliseconds 1200
  $inside = -not (Row 'Page A')
  $null = ClickButton '*New Folder*'; Start-Sleep -Milliseconds 1200; Away
  $null = Drive-Shot 'tst7-03b-rail-joined'
  Result 'tst7-3' ($inside -and (IsRail) -and (BrowserWindows) -eq 1) 'rail: Page A dropped on the folder''s glyph joins the folder; the rail stays a rail' "rows: $(RowNames)"

  $b = Row 'Page B'; $chip = Button '*Work*'
  $null = DragTo $b.X $b.Y $chip.X $chip.Y
  $null = Drive-Shot 'tst7-04a-rail-over-chip'
  DropHere; Start-Sleep -Seconds 1; Away
  $v = Visible; $null = Drive-Shot 'tst7-04b-rail-moved'
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2
  $homeRows = RowNames
  Result 'tst7-4' ($v -eq 'Page B' -and $homeRows -notlike '*Page B*' -and $homeRows -like '*Page A*' -and (BrowserWindows) -eq 1) 'rail: Page B, from inside the folder, dropped on the Work chip moves to Work and leaves the folder, which keeps Page A and Page D' "$v; Home rows: $homeRows"
  Drive-Stop
}

# ---- TST-9: the core keyboard ----------------------------------------------------------------

function Tst9 {
  $null = Fixture 'tst9'
  $null = Drive-Keys 'ctrl+1'

  if (Hold 'ctrl') {
    try { Start-Sleep -Milliseconds 800; $null = Drive-Shot 'tst9-01a-numbers' } finally { Release 'ctrl' }
  }
  Start-Sleep -Milliseconds 500; $null = Drive-Shot 'tst9-01b-numbers-gone'
  Result 'tst9-1' $true 'Ctrl held: numbers 1-4 on the rows (9 on the last), Alt+1-3 on the chips; gone on release (read the two captures)' 'tst9-01a, tst9-01b'

  $null = Drive-Keys 'ctrl+2'; $v2 = Visible
  $null = Drive-Keys 'ctrl+9'; $v9 = Visible
  $null = Drive-Keys 'ctrl+1'; $v1 = Visible
  Result 'tst9-2' ($v2 -eq 'Page B' -and $v9 -eq 'Page D' -and $v1 -eq 'Page A') 'Ctrl+2, Ctrl+9 (the last row), Ctrl+1' "$v2, $v9, $v1"

  $null = Drive-Keys 'ctrl+alt+down'; $vd = Visible
  $null = Drive-Keys 'ctrl+alt+up'; $vu = Visible
  Result 'tst9-3' ($vd -eq 'Page B' -and $vu -eq 'Page A') 'Ctrl+Alt+Down and Up: the next row down the sidebar, and back' "$vd, $vu"

  $null = Drive-Keys 'ctrl+3'; $null = Drive-Keys 'ctrl+1'
  $null = Drive-Keys 'ctrl+tab'; $v = Visible
  Result 'tst9-4' ($v -eq 'Page C') 'Ctrl+Tab tapped: the tab used before' $v

  $start = Visible; $v1 = ''; $v2 = ''
  if (Hold 'ctrl') {
    try {
      Drive-Key 0x09; Drive-Key 0x09 -Up; Start-Sleep -Milliseconds 600; $v1 = Drive-Visible
      $null = Drive-Shot 'tst9-05a-strip'
      Drive-Key 0x09; Drive-Key 0x09 -Up; Start-Sleep -Milliseconds 400; $v2 = Drive-Visible
    } finally { Release 'ctrl' }
  }
  Start-Sleep -Milliseconds 800; $v3 = Visible; $null = Drive-Shot 'tst9-05b-committed'
  Result 'tst9-5' ($v1 -ne $start -and $v2 -ne $v1 -and $v3 -eq $v2) 'Ctrl+Tab held: the strip shows, Tab steps it, letting go of Ctrl keeps the tab reached' "$start -> $v1 -> $v2, after release $v3"

  $start = Visible; $v1 = ''
  if (Hold 'ctrl') {
    try { Drive-Key 0x09; Drive-Key 0x09 -Up; Start-Sleep -Milliseconds 600; $v1 = Drive-Visible; Drive-Key 0x1B; Drive-Key 0x1B -Up } finally { Release 'ctrl' }
  }
  Start-Sleep -Milliseconds 800; $v = Visible
  Result 'tst9-6' ($v1 -ne $start -and $v -eq $start) 'Ctrl+Tab held, then Escape: back where the run began' "$start -> $v1, after Escape $v"

  $null = Drive-Keys 'ctrl+1'
  $null = Drive-Keys 'ctrl+shift+e'; Start-Sleep -Milliseconds 1200; $hidden = -not (Row 'Page B')
  $null = Drive-Keys 'ctrl+shift+e'; Start-Sleep -Milliseconds 1200; $shown = [bool](Row 'Page B')
  Result 'tst9-7' ($hidden -and $shown) 'Ctrl+Shift+E collapses the Space''s folders, and again opens them' "hidden=$hidden shown=$shown"

  $null = Drive-Keys 'ctrl+s'; Start-Sleep -Seconds 2; Away; $rail = IsRail; $w1 = (Row 'Page A').W
  $null = Drive-Keys 'ctrl+s'; Start-Sleep -Seconds 2; $open = IsOpen; $w2 = (Row 'Page A').W
  Result 'tst9-8' ($rail -and $open) 'Ctrl+S closes the sidebar to the rail, and again opens it' "row A $w1 px, then $w2 px"

  $null = Drive-Keys 'ctrl+shift+d'; Start-Sleep -Milliseconds 1200; $gone = -not (Drive-Rows 'Edit' | Where-Object { $_.Name -like '*Address*' })
  $null = Drive-Shot 'tst9-09-address-row-hidden'
  $null = Drive-Keys 'ctrl+shift+d'; Start-Sleep -Milliseconds 1200; $back = [bool](Drive-Rows 'Edit' | Where-Object { $_.Name -like '*Address*' })
  Result 'tst9-9' ($gone -and $back) 'Ctrl+Shift+D hides the address row, and again shows it' "gone=$gone back=$back"

  $null = Drive-Keys 'alt+2'; Start-Sleep -Seconds 2; $va = Visible
  $null = Drive-Keys 'ctrl+alt+right'; Start-Sleep -Seconds 2; $vn = Visible
  $null = Drive-Keys 'ctrl+alt+left'; Start-Sleep -Seconds 2
  $null = Drive-Keys 'ctrl+alt+left'; Start-Sleep -Seconds 2; $vh = Visible
  Result 'tst9-10' ($va -eq 'Page E' -and $vn -eq 'Page F' -and $vh -like 'Page *' -and $vh -notin @('Page E', 'Page F')) 'Alt+2, Ctrl+Alt+Right, Ctrl+Alt+Left twice' "$va, $vn, $vh"

  $null = Drive-Keys 'ctrl+3'; $null = Drive-Keys 'ctrl+d'; Start-Sleep -Milliseconds 1200
  $c = Row 'Page C'; $nt = Button '*New Tab*'
  $pinned = $c -and $nt -and $c.Y -lt $nt.Y
  $null = Drive-Keys 'ctrl+w'; Start-Sleep -Seconds 2
  $v = Visible; $null = Drive-Shot 'tst9-11-pin-slept'
  Result 'tst9-11' ($pinned -and (Row 'Page C') -and $v -ne 'Page C') 'Ctrl+D pins Page C above the New Tab row; Ctrl+W puts it to sleep: its row stays (dimmed in the capture), another page shows' "pinned=$pinned; $v"

  $null = ClickRow 'Page A'
  $null = Drive-Keys 'ctrl+alt+shift+down'; Start-Sleep -Milliseconds 1200
  $a = Row 'Page A'; $b = Row 'Page B'
  Result 'tst9-12' ($a -and $b -and $a.Y -gt $b.Y) 'Ctrl+Alt+Shift+Down moves Page A below the folder (a folder beside it is one row)' "rows: $(RowNames)"

  $null = Drive-Keys 'ctrl+alt+shift+right'; Start-Sleep -Seconds 2
  $v = Visible; $rows = RowNames
  Result 'tst9-13' ($v -eq 'Page A' -and $rows -like '*Page E*') 'Ctrl+Alt+Shift+Right moves Page A to Work and the window follows' "$v; rows: $rows"
  $null = Drive-Keys 'alt+1'; Start-Sleep -Seconds 2

  $null = Drive-Keys 'ctrl+shift+c'; Start-Sleep -Milliseconds 600
  $null = Drive-Shot 'tst9-14-copy-link-toast'
  $clip = Get-Clipboard -Raw
  Result 'tst9-14' ($clip -like 'file:///*.html*') 'Ctrl+Shift+C copies the page''s address (and the toast says so: capture)' $clip

  $null = Drive-Keys 'alt+shift+n'; Start-Sleep -Seconds 2
  $null = Drive-Shot 'tst9-15-split'
  Result 'tst9-15' $true 'Alt+Shift+N splits the tab with a new one (read the capture)' 'tst9-15-split'
  $null = Drive-Keys 'esc'

  $null = Drive-Keys 'ctrl+2'; $t = Visible
  $null = Drive-Keys 'ctrl+w'; Start-Sleep -Milliseconds 1200; $closed = -not (Row $t)
  $null = Drive-Shot 'tst9-16a-closed-toast'
  $null = Drive-Keys 'ctrl+shift+t'; Start-Sleep -Seconds 2; $v = Visible
  Result 'tst9-16' ($closed -and $v -eq $t -and (Row $t)) 'Ctrl+W closes a plain row with the Undo toast; Ctrl+Shift+T brings it back' "closed '$t'=$closed; back: $v"

  $null = Drive-Keys 'ctrl+shift+p'; Start-Sleep -Milliseconds 800
  $null = Drive-Shot 'tst9-17-actions'
  $null = Drive-Keys 'esc'

  $null = Drive-Keys 'ctrl+m'; Start-Sleep -Milliseconds 800
  $null = Drive-Keys 'ctrl+shift+p'; Start-Sleep -Milliseconds 800
  $null = Drive-Type 'mute'; Start-Sleep -Milliseconds 800
  $null = Drive-Shot 'tst9-18-mute-row'
  $null = Drive-Keys 'esc'; $null = Drive-Keys 'ctrl+m'
  Result 'tst9-18' $true 'Ctrl+M mutes the tab: the bar''s row reads Unmute Tab, with Ctrl+M (read the capture)' 'tst9-18-mute-row'

  $null = Drive-Keys 'ctrl+shift+k'; Start-Sleep -Seconds 2
  $rows = RowNames; $null = Drive-Shot 'tst9-19-clear'
  Result 'tst9-19' ($rows -like '*Page C*' -and $rows -notlike '*Page D*') 'Ctrl+Shift+K clears the Space''s unpinned tabs and keeps the pin' "rows: $rows"
  Drive-Stop
}

# ---- run -------------------------------------------------------------------------------------

try {
  switch ($Part) {
    'layout' {
      $null = Fixture 'layout'
      Drive-Rows | Sort-Object Y | ForEach-Object { Drive-Log ("row    '{0}' at {1},{2} {3}x{4}" -f $_.Name, $_.X, $_.Y, $_.W, $_.H) }
      Drive-Rows 'Button' | Sort-Object Y | ForEach-Object { Drive-Log ("button '{0}' at {1},{2}" -f $_.Name, $_.X, $_.Y) }
      Drive-Rows 'Edit' | ForEach-Object { Drive-Log ("edit   '{0}' at {1},{2}" -f $_.Name, $_.X, $_.Y) }
      if (-not (ClickButton '*sidebar*')) { $null = Drive-Keys 'ctrl+s' }
      Start-Sleep -Seconds 2; Away
      $null = Drive-Shot 'layout-rail'
      Drive-Rows | Sort-Object Y | ForEach-Object { Drive-Log ("rail   '{0}' at {1},{2} {3}x{4}" -f $_.Name, $_.X, $_.Y, $_.W, $_.H) }
      Drive-Rows 'Button' | Sort-Object Y | ForEach-Object { Drive-Log ("rail button '{0}' at {1},{2}" -f $_.Name, $_.X, $_.Y) }
      Drive-Stop
    }
    'tst6' { Tst6 }
    'tst7' { Tst7 }
    'tst9' { Tst9 }
    'all' { Tst6; Tst7; Tst9 }
  }
} catch {
  Add-Content -Path $results -Value "ERROR $_" -Encoding UTF8
  Drive-Log "error: $_"
  try { Drive-Stop } catch {}
}
Drive-Log "results: $results"
