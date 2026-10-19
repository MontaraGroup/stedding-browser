# Feature: Acceptance scripts

Status: **the core loop's script is written and has run on installed builds on the Mac and on
Windows (2026-10-18, "Runs" below): every step but the first passes on both, and the first fails
on a restored row's title (BACKLOG `S-229`)**; `S-173` keeps the owner's day. The feature
checks after it -- dark pages, the session mark, local tabs and apps made from pages, all
written on 2026-10-18 -- have not run.
Owner docs: `PLAN.md` ("When an item is done"), `docs/QUALITY.md` (the release checklist),
`docs/history/plan-2026-09-26.md` TST-6.

A green sweep is not what a person sees. This file holds the scripts a person, or
`tooling/drive` on the Mac and `tooling\win\drive.ps1` on Windows, runs on an installed build
of the current pin before a release, and the record of each run. A step passes when what it
expects is on screen and, where the tools can read it, in the browser's own state (the page
on screen through DevTools, the rows through UI Automation). Every failed step gets a BACKLOG
row and a test that fails with it before the release goes out.

## The core loop

What every user does in the first minute: click rows, switch Spaces, fold a folder away,
quit and come back, open and change pages from the keyboard. Thirteen steps, about ten
minutes by hand.

### Before the run

- An installed build: the disk image's app in /Applications on the Mac, the installer's copy
  in `%LOCALAPPDATA%\Stedding\Application` on Windows. The person's own Stedding is closed,
  or runs on another profile.
- A fresh profile with three Spaces, Home, Work and Play, and the welcome flow already seen.
  The tools seed it (`stedding.spaces.registry` and `stedding.welcome.shown` in the profile's
  Preferences); by hand, add two Spaces with the switcher's "+" and name the three.
- Eight local pages, Page A to Page H, so nothing waits on the network.
- The fixture, filed with the product's own keys: open Pages A to F in Home; on Page B,
  ⇧⌘P (Ctrl+Shift+P), "Move to New Folder", Enter; on Page E, ⌥⇧⌘→ (Ctrl+Alt+Shift+→);
  back in Home, on Page F, ⌥⇧⌘→ twice. Home then holds Page A, a folder holding Page B,
  Page C and Page D; Work holds Page E; Play holds Page F. Quit.

### The steps

| # | Do | Expect |
|---|---|---|
| 1 | Launch the installed build on the fixture profile. | Home is on screen with Page A selected and its page showing; the rows read Page A, the folder with Page B under it, Page C, Page D; three Space chips. No dialog, no restore bar. |
| 2 | In the open sidebar, click Page A, then Page B (inside the folder), Page C and Page D. | Each click selects that row and shows its page at once. Nothing else moves. |
| 3 | Click the sidebar's toggle. | The sidebar closes to the rail: a column of icons, the folder as its glyph, the chips stacked at the bottom. |
| 4 | In the rail, click Page A, Page B, Page D and Page A again, moving the pointer off the rail after each. | Each click selects that row and shows its page. No close button appears on a hovered row; nothing closes; the rail stays a rail once the pointer leaves. |
| 5 | Click the rail's toggle. | The sidebar opens again, as it was. |
| 6 | Click the Work chip. | Work is on screen with Page E; no row of Home shows. |
| 7 | Press ⌃3 (Alt+3). | Play is on screen with Page F. |
| 8 | Press ⌥⌘← (Ctrl+Alt+←) twice. | Work with Page E, then Home on the tab left there: Page A, the last row clicked in Home. |
| 9 | Press ⌘T (Ctrl+T), type "Page F", choose Page F's tab row, press Enter. | The bar closes and Play is on screen with Page F. |
| 10 | Press ⌃1 (Alt+1), click Page A, click the folder's header; then ⌃2 (Alt+2) and ⌃1 (Alt+1). | The folder collapses: Page B's row goes, the header shows its count, Page A stays on screen. Away and back, the folder is still collapsed and Page A is still the page on screen. |
| 11 | Quit (⌘Q, or the Dock's Quit; Ctrl+Shift+W on Windows) and launch again. | Everything as it was left: Home on Page A, the folder collapsed, Page C and Page D; Work holds Page E, Play holds Page F. No restore bar. |
| 12 | Press ⌘T (Ctrl+T), type Page G's address, press Enter. | The bar closes; a new row, Page G, is selected in Home and its page shows. |
| 13 | Press ⌘L (Ctrl+L), type Page H's address, press Enter. | The bar opened with Page G's address selected; after Enter the same row shows Page H. No new row. |

### Running it with the tools

- Both tools move the real pointer and press real keys: only with the operator's yes, and
  nobody at the machine (`AGENTS.md`, red lines).
- `tooling/drive` cannot quit and relaunch inside one steps file: step 11 ends one run and
  starts the next, on the same profile. The captures are the record; each is looked at
  against its step's Expect column.
- On Windows the rows, the chips, the folder's header and the toggle are found by UI
  Automation, and each step's result is read back through DevTools and UI Automation.
- The Mac's run is `tooling/acceptance/mac/run-mac.sh` (`layout`, `tst6`, `tst7`, `tst9` or
  `all`): it seeds a profile with three Spaces (`seed-profile.py`), builds the fixture from
  local pages (`pages/`), renders the steps from `templates/` and keeps each run's captures
  and logs in a directory of its own. Its coordinates are the Mac's at the window's default
  1400×880; a changed layout is measured again with `layout`. TST-7 runs with expand-on-hover
  off, as a slow drag rests on the rail longer than its hover pause.
- Windows' run is `tooling/acceptance/win/s173-live.ps1`, with `tooling/win/drive.ps1`. Each
  step, key, click and wait on the browser is logged before it happens to
  `%TEMP%\stedding-s173\progress.log`, and no call waits for ever: UI Automation and the
  clipboard run on a runspace of their own with a clock, DevTools calls have theirs. A tab put
  to sleep never answers DevTools, and the run had stalled for good at the pin step (S-233);
  a call that gives no answer in time is logged as TIMEOUT and the run goes on. A step whose
  condition was not there to check is NOT-CHECKED, never a pass: tst9-9 reads the hidden
  address row's line only over an infobar (toolbar T36), on Page A's saturated colour.
  `results.txt` ends with the counts of both.

### Runs

One row per run: the date, the build (version and commit), the platform, and each step's
result. P passes, F fails (with the BACKLOG row it opened), – was not run.

| Date | Build | Platform | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | F (S-229) | P | P | P | P | P | P | P | P | P | P | P | P | run 1 of three, `tooling/acceptance/mac/run-mac.sh tst6`; step 1 corrected on re-reading the capture: Page D's row read "d.html" |
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | F (S-229) | P | P | P | P | P | P | P | P | P | P | P | P | run 2 of three, `tooling/acceptance/mac/run-mac.sh tst6`; step 1 corrected on re-reading the capture: Page D's row read "d.html" |
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | F (S-229) | P | P | P | P | P | P | P | P | P | P | P | P | run 3 of three, `tooling/acceptance/mac/run-mac.sh tst6`; step 1 corrected on re-reading the capture: Page D's row read "d.html" |
| 2026-10-18 | installed: the signed and notarized image of patch 0071 (checkout 2b5d5e2), dragged to /Applications in Finder and opened through Gatekeeper's prompt | macOS | F (S-229) | P | P | P | P | P | P | P | P | P | P | P | P | `run-mac.sh all /Applications/Stedding.app`; step 9's bar also listed Page F as archived (S-230); TST-7's four drags as the captures show them (the rail's drop onto the glyph looks like Windows' miss, S-232); TST-9 passed once three of the template's steps were fixed (row numbers once a pin and a split exist, a second Escape) |
| 2026-10-18 | installed: the per-user installer of patch 0071 (`win-release`, checkout ab9ed97, the same tree), over beta 17 as a repair, `chrome.dll` matching the build | Windows | P | P | P | P | P | P | P | P | P | P | P | P | P | `s173-live.ps1 -Part all -Exe <installed chrome.exe>`, after the harness fixes of the day (the last-run version seeded, the toggle's real name, expand-on-hover off for the drags, a dragged row's activity in the folder check); TST-7: three drags pass, the rail's drop onto the folder's glyph lands after the folder (S-232); TST-9: steps 1 to 10 run, Escape in a Ctrl+Tab run opens the Start menu (S-228), the hidden address row leaves a line (S-231), the runner stalls at the pin step (S-233) |
| 2026-10-19 | installed: the per-user installer of patch 0072 (`win-release`, checkout af9051f, with the S-242 test fixes and the essentials card of S-243), over beta 17 as a repair, `chrome.dll` matching the build | Windows | – | – | – | – | – | – | – | – | – | – | – | – | – | `s173-live.ps1 -Part tst9 -Exe <installed chrome.exe>` alone: all nineteen steps that report pass, none not checked, no call timed out, two minutes. Ctrl+Esc in a Ctrl+Tab run opens the Start menu and the run keeps its tab, a tap goes back (tst9-6, S-228); Shift+Tab back to the first tab (tst9-6b); the hidden address row leaves no line with an infobar up (tst9-9, S-231); the pin step runs through (tst9-11, S-233). tst9-17's capture shows Ctrl+W's toast over the infobar's text (S-244, fixed the same day) |
| 2026-10-19 | installed: the per-user installer of 0.2.0 beta 18 (`win-release`, the version set, repo 9c23aec), as a repair and then fresh after an uninstall that kept the profile, `chrome.dll` matching the build | Windows | P | P | P | P | P | P | P | P | P | P | P | P | P | `s173-live.ps1 -Part tst6`, `tst7`, `tst9` on the installed copy: TST-6 all thirteen steps and its fixture; TST-7's four drags, the rail's drop onto the folder's glyph joining the folder (S-232); TST-9 all nineteen, with Ctrl+W's undo toast under the infobar (S-244). TST-7 and TST-9 first failed at their fixtures while an ASan build and its link ran: the browser drew no page and took no key for about a minute after its launch, and the fixture's keys went before it was ready; the fixture now waits for its first page (trap 116), and both passed on a quiet machine |
| 2026-10-19 | installed: the per-user installer of 0.2.0 beta 19 (`win-release`, the version set, patch 0073), fresh after an uninstall that kept the profile, `chrome.dll` matching the build | Windows | P | P | P | P | P | P | P | P | P | P | P | P | P | `s173-live.ps1 -Part tst6`, `tst7`, `tst9` on the installed copy, a quiet machine. TST-6 all thirteen steps and its fixture; TST-9 all nineteen; TST-7's four drags passed alone. Run after another part in the same task, TST-7 and TST-9 waited a minute for their first page: DevTools answered and listed the pages, but none was visible, and two of TST-7's drags and five of TST-9's steps then failed on a fixture filed late; a launch, stop and launch with no input started in under a second each time (`S-248`) |

## Dark pages

The live checks `docs/features/dark-pages.md` cites: what its browser tests cannot see (a
frame on screen, video, print preview, the moon's look) or cannot press (the Mac's key path).
About twenty minutes by hand on each platform; none has run yet.

### Before the run

- An installed build, a fresh profile, dark pages off, the window in Light mode (Settings →
  Appearance) unless a check says otherwise.
- Local pages, so nothing waits on the network: `white.html` (a white page, black text),
  `media.html` (a playing local video and a photo on white), `doc.pdf` (a text PDF on white),
  `heavy.html` (a long page of text, tables and images), `pale.html` (`white.html` with
  `<meta name="theme-color" content="#e8f0fe">`, for the app window's title bar), `slow.html`
  (`white.html` with a manifest, `slow.webmanifest`, whose `theme_color` is `#e8f0fe`; the
  local server answers `slow.html` five seconds late, for an app window before its page
  loads), and two hosts for them (`a.test`, `b.test`) with `b.test` kept light in Settings for
  the exception checks.
- A screen recorder that can keep every frame (QuickTime at 60 fps on the Mac; the Xbox Game
  Bar or OBS on Windows) for the flash checks.

### The checks

| Id | Do | Expect |
|---|---|---|
| `dk_no_flash_light` | Turn dark pages on (⌥⇧⌘D, Ctrl+Alt+Shift+D). Record while you: open a new window (⌘N, Ctrl+N) and type `a.test/white.html`; on the new tab page, type the same address; click a link from `a.test` to `b.test` and back; open a link to `a.test` through a redirect from `b.test`. Step through the recording frame by frame. | No frame shows a white page area under a page that is darkened, and no frame shows a dark one under `b.test`, which is kept light. The new tab page itself stays as the window draws it. Dk7 is "built" only once this passes on both platforms. |
| `dk_media` | With dark pages on, open `media.html` and let the video play; open `doc.pdf`; do both in a light and in a dark window. | The video, the photo and the PDF's page keep their colours (white stays white); the page around them is dark. The PDF viewer's own controls look as they do with dark pages off, or darker. |
| `dk_print` | With dark pages on, open `white.html`, press ⌘P (Ctrl+P). | The preview shows the page light, as its author made it; the page in the tab stays dark. |
| `dk_button_light` | In a light window, look at the address row with dark pages off, then on; then at the narrowest window. Hover the moon. | Off, an outline moon; on, a filled moon with the toolbar's active highlight, both in the row's contrast colour and as sharp as the buttons beside them. The tooltip names the action and its chord; it is in the row at the narrowest width, or the row drops it with the other buttons. |
| `dk_button_dark` | The same in a dark window and on a page with a saturated `theme-color` (the row takes the page's colour). | The same, legible on each row colour. |
| Dk18 keys | On the Mac, press ⌥⇧⌘D from a page, from the address field, from a private window and with the address row hidden (⇧⌘D). On Windows, Ctrl+Alt+Shift+D the same way, on the US layout and on one AltGr layout (Polish or German, windows N14). | Each press turns dark pages on or off, and every open page follows. On the AltGr layout, note what the chord does and file a BACKLOG row if it types a character instead. |
| `dk_view_menu` | On the Mac, open the menu bar's View menu with dark pages off, then on; choose its "Dark Pages" row. Then open an app made from a page (web apps Wa1), and open the View menu there. | "Dark Pages" right after Zoom Out, with ⌥⇧⌘D beside it and a check mark only while dark pages is on; choosing it turns dark pages off or on in every window. The app's menu bar has the same row (Dk24). |
| `dk_app_title_bar` | Make an app of `a.test/pale.html` (web apps Wa1) and open it. Turn dark pages on from the app window (⌥⇧⌘D, Ctrl+Alt+Shift+D), then keep `a.test` light from the page menu, then put it back, then turn dark pages off. Then make an app of `a.test/slow.html`, turn dark pages on, close the app, and open it again while recording the screen; step through the recording frame by frame. Do it all in a light and in a dark window. | Off, a pale blue title bar; on, a dark blue one over the dark page, at once, its title, icon and buttons legible; kept light, pale blue again, and dark again when put back. The app of `slow.html`, opened while dark pages is on, has a dark blue title bar from its first frame and through the five seconds before its page shows; no frame shows a pale title bar over the dark content area (Dk7, Dk8, web apps Wa9). |
| `dk_load_trace` | Record a startup trace (`--trace-startup`) loading `heavy.html`, once with dark pages seeded off and once on, three times each; or `tooling/measure/harness.py` with the switch seeded on against off. | The difference in the first contentful paint and in the renderer's paint time, written into Dk23 with the machine and the build. |
| `dk_toggle_trace` | On `heavy.html` with other tabs open, trace one press of ⌥⇧⌘D (Ctrl+Alt+Shift+D). | How long the restyle and repaint of the open pages takes, written into Dk23. |

### Runs

One row per run, as for the core loop: the date, the build, the platform, and each check's
result (P, F with the BACKLOG row it opened, – not run). None yet.

| Date | Build | Platform | `dk_no_flash_light` | `dk_media` | `dk_print` | `dk_button_light` | `dk_button_dark` | Dk18 keys | `dk_view_menu` | `dk_app_title_bar` | `dk_load_trace` | `dk_toggle_trace` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

## The session mark

The live checks `docs/features/sessions.md` S32-S34 and `docs/features/spaces.md` B38 wait on:
how the cookie mark looks and sounds, which no browser test sees. About fifteen minutes by
hand on each platform; none has run yet.

### Before the run

- An installed build and a fresh profile with three Spaces, Home, Work and Play; Work's
  Independent session on (its chip menu), a web page open in each Space.
- On Windows, the display at 100% scaling for the 1x checks; on the Mac, a Retina display.
- VoiceOver on the Mac, Narrator on Windows, for the last check.

### The checks

| Id | Do | Expect |
|---|---|---|
| `im_badge` | Look at Work's chip in the open sidebar and in the rail, in Light and in Dark (Settings → Appearance), with Work given each of the five Space colours, on screen and not. Then drag a tab over Work's chip, and rest the pointer on it. | The cookie reads as a cookie in a disc at the chip's bottom trailing corner, over the emoji and apart from it; Home and Play show none. The ring round the disc is the sidebar's ground: no halo of another colour under the drag's fill, the hover's fill or the sidebar's gradient. At 1x the cookie is not a blob. |
| `im_title_row` | Switch to Work in the open sidebar and in the rail; hover the title row. | The cookie after Work's name, or the badge on its glyph in the rail; the tooltip says what the mark means and that essentials use the shared session, in the rail after Work's name. |
| `im_menus` | Right-click a tab in Home: Move to Space, Always Open <site> in. Open the command bar (⇧⌘P, Ctrl+Shift+P) and type "move". | Work's rows wear the cookie and "Independent session" (on Windows after the row; on the Mac after the name, and the cookie only where the Mac's menus draw icons); Play's rows wear neither. The bar's Move Tab to Work row has the cookie after its text, quieter than the text. |
| `im_pin` | In Work, on a page signed into a site, right-click the tab, Add to Essentials. Then press the toast's Undo. | A toast, "Essentials use the shared session, not Work's", before the page reloads signed out; Undo brings the tab back into Work, signed in. Pinning a Home tab shows no such toast. |
| `im_voice` | With VoiceOver or Narrator on, move to Work's chip, the title row, the bar's Move Tab to Work row and the tab menu's Work row. | Each is read once with its name, then "Independent session: its own cookies and storage"; the cookie itself is not read on its own. |

### Runs

One row per run, as for the core loop. None yet.

| Date | Build | Platform | `im_badge` | `im_title_row` | `im_menus` | `im_pin` | `im_voice` | Notes |
|---|---|---|---|---|---|---|---|---|

## Local tabs

The live checks `docs/features/local-tabs.md` waits on: how the tape and the host line look on
each ground, at each density, in the rail and on an essentials split, and how a screen reader
reads a local row. Its unit tests measure the colours and its browser tests the geometry; none
looks at the pixels on screen. About fifteen minutes by hand on each platform; none has run yet.

### Before the run

- An installed build and a fresh profile with three Spaces, Home, Work and Play; Play given the
  Plum colour (Settings → Stedding → Spaces), the sidebar at the Comfortable density (the
  default) and "Mark local development tabs" on (the default).
- Two servers on this computer, so the rows have two ports to tell apart: for example
  `python3 -m http.server 3000` and `python3 -m http.server 5173`, each serving a page with a
  `<title>` (`titled.html`, linking to a second titled page) and one without (`untitled.html`).
  One page that is not local, such as a page of `a.test` through the hosts file.
- VoiceOver on the Mac, Narrator on Windows, for the last check.

### The checks

| Id | Do | Expect |
|---|---|---|
| `lt_tape_dark` | In Dark (Settings → Appearance), in Home, open `localhost:3000/titled.html`, `127.0.0.1:5173/titled.html` and `a.test`. Click each row in turn; then select two rows with ⇧-click; hover a local row in the background. | The active local row alone wears a yellow and black dashed tape inside its own rounded edge, the dashes even all the way round, with no stub where they meet; a selected row that is not active, a hovered one and a local row in the background wear none, and the tape moves with the active row without a flicker. Each local row shows `localhost:3000` or `127.0.0.1:5173` under its title, smaller and dimmer than the title; `a.test` has one line. No row is taller than a plain one, and the close button, the favicon and the title's left edge sit where a plain row's do (Lt3, Lt5, Lt6). |
| `lt_tape_light` | The same in Light. | The near-black dashes carry the tape on the sand ground, and the host line reads (Lt4). |
| `lt_tape_plum` | The same in Play, coloured Plum, then with Play given Slate, Moss, Clay and Rose; then in a private window. | The tape and the host line read on every tint and in the private window (Lt4, Lt11). |
| `lt_host_line` | On `localhost:3000/titled.html`, follow its link; open `localhost:3000/untitled.html`; rename a local row (double-click its title); put a local tab to sleep (its menu's Sleep Tab). | Following the link moves neither line. The untitled page's row reads its address as its title and has no second line once it has loaded. The renamed row keeps the host line under its new name, the field covering the title's line alone. The sleeping row's host line dims with its title (Lt5, Lt11). |
| `lt_density` | Settings → Stedding → Sidebar: Compact, then Dense, at the default text size and at the largest; then Comfortable again. | At Compact and Dense every local row has one line, and only the active one is marked, by its tape; at Comfortable the second line is back. No row changes height for being local (Lt6). |
| `lt_rail` | Collapse the sidebar to the rail (⌘S, Ctrl+S) with a local tab active; then, with expand-on-hover on, rest the pointer on the rail. | The active local row's square in the rail wears the tape at the row's radius, with no text; the sidebar expanded on hover shows the host line under the titles (Lt8). |
| `lt_tape_essentials_split` | Add the local tab to the essentials, then split it with `a.test` (its menu's Add Tab to New Split View); look at the card on screen and with another tab on screen. | One card, the local pane alone taped, inside the card's edge; the tape's corners follow the pane's own clip, rounder than the card's and not concentric with them; nothing taped while the split is not on screen. Whether those corners look right is the owner's call (Lt9, owner decision 7). |
| `lt_settings` | Settings → Stedding → Sidebar, with a second window open: turn "Mark local development tabs" off, then on; then do the same from the command bar (⇧⌘P, Ctrl+Shift+P, "mark local"). | The row is last in the Sidebar group, after the row numbers. Off, every row is plain in both windows at once; on, the marks come back without a restart (Lt13). |
| `lt_voice` | With VoiceOver or Narrator on, move to a local row, then to `a.test`'s row. | The local row is read with its title and then "Local: localhost:3000"; the host line is not read on its own; the plain row has no such description (Lt12). |

### Runs

One row per run, as for the core loop. None yet.

| Date | Build | Platform | `lt_tape_dark` | `lt_tape_light` | `lt_tape_plum` | `lt_host_line` | `lt_density` | `lt_rail` | `lt_tape_essentials_split` | `lt_settings` | `lt_voice` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|

## Apps made from pages

The live checks `docs/features/web-apps.md` cites: what its browser tests cannot reach, because
they run against a stand-in for the Dock and a test override for the launchers and shortcuts
(the Dock tile, the launcher, the Start menu, the app's window as it looks, an update with an
app installed, a launch with Stedding quit). About thirty minutes by hand on each platform;
none has run yet.

### Before the run

- An installed build, a fresh profile with two Spaces, Home and Work, and Work's Independent
  session on (its chip menu). The person's own Stedding is closed, or runs on another profile.
- Local pages on two hosts, so nothing waits on the network and the sessions can be told
  apart: `a.test/plain.html` (no manifest), `b.test/app/` (an installable manifest, two icons,
  a pale `theme-color`) and `b.test/whoami.html`, which sets a cookie on its first visit and
  shows which one it holds. Visit `whoami.html` once in Home and once in Work first, so each
  Space's session holds its own cookie.
- On the Mac, the operator's yes for the install itself: it writes a launcher into
  `~/Applications/Stedding Apps.localized`, adds a tile to the Dock and restarts the Dock.
  The app's Uninstall at the end (`wa_uninstall`) takes both away again.

### The checks

| Id | Do | Expect |
|---|---|---|
| `wa_mac_install` | On the Mac, in Work, open `a.test/plain.html` and choose File → Add to Dock…; then do the same for `b.test/app/` from the app menu's Save and Share block, and once from the command bar ("add app"). | Each dialog reads "Add to Dock", its button "Add", and names Work's session ("Opens with the session of “Work”."); the plain page's dialog has a name field with the page's title. After Add the page moves into its app window as it was, without a reload; one tile per app appears right after the last browser tile, the Dock blinks once, no Finder window opens, and each launcher is in `~/Applications/Stedding Apps` (Wa1, Wa5, Wa6, Wa7). |
| `wa_tile_kept_out` | Drag one app's tile out of the Dock. Launch that app from `~/Applications/Stedding Apps` and let its page load; quit and start Stedding, and launch it again. | The tile does not come back and the Dock does not restart (Wa7). |
| `wa_win_install` | On Windows, in Work, open `a.test/plain.html` and choose the app menu's Save and Share → "Install page as app…"; then the same for `b.test/app/` ("Install <App>…"). | Chromium's dialogs and words; each app gets a Start menu entry (in a "Stedding Apps" folder: write down the folder's real name, Wa8 says it is **UNVERIFIED**), a desktop shortcut, and a taskbar button of its own when it runs (Wa2, Wa8). |
| `wa_app_light`, `wa_app_dark`, `wa_app_theme_color` | Open each app in Light and in Dark; `b.test/app/` with its `theme-color`, `a.test/plain.html` without one. Open its menu, and find on the page (⌘F, Ctrl+F). | The page runs edge to edge under Chromium's title bar: no sidebar, no Spaces, no address row, no mat or rounded card around the page; the find bar sits on the page's corner. The title bar takes the page's colour when it names one, else the window's ground, legible in both modes. The menu is Chromium's (App info, Copy URL, Open in Stedding, Uninstall…); on the Mac the menu bar has no Spaces menu and no Add to Dock (Wa9, Wa10, windows G7). |
| `wa_session` | In the app made in Work, open `b.test/whoami.html`. Then the app's menu → Open in Stedding; then, from the page in Work, the address row's "Open in <App>" chip; then, in the app, a link to `a.test`. | The app's page holds Work's cookie, not Home's, from its first request. Open in Stedding puts the page in a tab of Work, on screen, not reloaded; the chip moves it back; the link leaving the app opens in a tab of Work (Wa11, Wa14). |
| `wa_session_off` | Turn Work's Independent session off from its chip menu, with the app's window open; answer the question; open a new page of the app; turn the session on again. Then delete Work, with the app's window open. | The question names the app ("… will use the shared session while it is off."), even with no Work tab open. The open app window stays signed in as Work until it closes; a new page of the app holds the shared cookie; on again, Work's. Deleting Work names the app ("… will then use the shared session."), and Work's site data is erased only once the app's window has closed (Wa13; sessions S10, S17; spaces B5). |
| `wa_relaunch` | With the app's window open, open chrome://restart in a browser tab; after the restart close the app's window and press ⇧⌘T (Ctrl+Shift+T). Then quit and start Stedding normally. | After the restart the app's window comes back, still in Work's session; ⇧⌘T brings it back the same way. A plain start restores the browser's windows and not the app's (Wa12). Note whether the archive page (⇧⌘P, "Show Archived Tabs") lists the app's page (`docs/features/archive.md`, notes). |
| `wa_launch_quit` | Quit Stedding. Launch an app from the Dock (the Mac) or the Start menu (Windows). | Stedding starts and opens the app's window. Write down whatever else opens, the browser's windows or not: Wa22 takes what the real build does. |
| `wa_update` | With an app installed, update Stedding to the next release the way a user gets it (on the Mac through the feed, on Windows with the next installer over this one); launch the app afterwards. On Windows, then uninstall Stedding. | The app launches from its tile or shortcut after the update, with no launcher to rebuild by hand; on Windows the uninstall deletes the app's shortcuts (Wa16, Wa17). Needs two releases, so it runs with the next release. |
| `wa_uninstall` | From each app's window menu, Uninstall <App>…, the first with "Also clear data" ticked. | The launcher goes (on the Mac the tile Stedding added goes too, and the Dock restarts once), or the Start menu entry and the desktop shortcut on Windows. The box for clearing data says "This also signs the tabs of “Work” out of the site." and, ticked, Work's tabs of the site are signed out; the app is gone from chrome://apps (Wa18). |

### Runs

One row per run, as for the core loop. None yet.

| Date | Build | Platform | `wa_mac_install` | `wa_tile_kept_out` | `wa_win_install` | `wa_app_*` | `wa_session` | `wa_session_off` | `wa_relaunch` | `wa_launch_quit` | `wa_update` | `wa_uninstall` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

## The tests beside the script

The script is what a person sees; these browser tests drive the same paths through the
window, so a sweep finds a regression before the next run (BACKLOG `S-173`):

- TST-7, drags in the open sidebar and the rail: `TabDropTest.*` (folders F7, spaces B12).
- TST-8, a selection holds only rows on screen: `SidebarSelectionTest.*` (tabs R20, R21,
  copy-link L1).
- TST-9, the core keyboard: `NumberBadgeTest.CtrlTabEndsWithTheKeyOrTheWindow` (switcher X3),
  `SpaceSwitchTest.TheCoreChordsAsKeysThroughTheWindow` and
  `SpaceKeysTest.TheCoreChordsReachTheirCommands` (shortcuts Z7).
