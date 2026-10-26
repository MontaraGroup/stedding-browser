# Feature: Acceptance scripts

Status: **the core loop's script is written and has run on installed builds on the Mac and on
Windows: on 0.2.0 beta 20 (2026-10-19 and 2026-10-20, "Runs" below) every step passes on
both**; `S-173` keeps the owner's day. The feature
checks after it -- dark pages, the session mark, local tabs and apps made from pages, all
written on 2026-10-18 -- have not run.
Owner docs: `PLAN.md` ("When an item is done"), `docs/ROADMAP.md#the-quality-bar` (the release checklist),
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
| 10 | Press ⌃1 (Alt+1), click Page A, click the folder's header; then ⌃2 (Alt+2) and ⌃1 (Alt+1). | The folder collapses: Page B's row goes, the header shows its name and no count, Page A stays on screen. Away and back, the folder is still collapsed and Page A is still the page on screen. |
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
| 2026-10-19 | installed: the per-user installer of 0.2.0 beta 19, as the row above, after the runner's fix for `S-248` | Windows | P | P | P | P | P | P | P | P | P | P | P | P | P | `s173-live.ps1 -Part tst6`, `tst7`, `tst9` in one task, one after another: each part's first page on screen five to six seconds after its launch (a minute before the fix), TST-6 all thirteen steps and its fixture, TST-7's four drags, TST-9 all nineteen, none not checked, no call timed out |
| 2026-10-19 | installed: 0.2.0 beta 20 as published, installed by its own updater from beta 19 and then fresh after an uninstall that kept the profile | Windows | P | P | P | P | P | P | P | P | P | P | P | P | P | `s173-live.ps1 -Part tst6`, `tst7`, `tst9` in one task, then `tst6` alone for its full record: TST-6 all thirteen steps and its fixture, TST-7's four drags (the rail's drop onto the folder's glyph joins the folder, `S-232`), TST-9 all nineteen steps and 6b, none not checked |
| 2026-10-20 | installed: 0.2.0 beta 20 as published (notarized, 156.0.8078.36), the copy in /Applications | macOS | P | P | P | P | P | P | P | P | P | P | P | P | P | `run-mac.sh all /Applications/Stedding.app`, then `tst7` and `tst9` again after three harness fixes of the day: each part's fixture keeps its own captures; TST-7 gained a step 6 that opens the sidebar in Home, since the rail draws a folder's rows without an indent and could not show whether the drop joined; TST-9's Ctrl-Tab tap now lets go of Ctrl, where the walk had stayed open with its strip on screen. TST-6: all thirteen steps; after the relaunch every row keeps its title, Page D's included (`S-229`), and step 9's bar lists Page F once, as Play's open tab (`S-230`). TST-7: the four drags; the rail's drop of Page A onto the folder's glyph joins the folder (`S-232`). TST-9: all nineteen steps. With ⌘ held, the third Space chip reads "…" where ⌃3 belongs, as does the one chip under Focus on Space 3 (not yet in BACKLOG) |

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
| `im_badge` | Look at Work's chip in the open sidebar and in the rail, in Light and in Dark (Settings → Appearance), with Work given each of the twelve Space colours, on screen and not. Then drag a tab over Work's chip, and rest the pointer on it. | The cookie reads as a cookie in a disc at the chip's bottom trailing corner, over the emoji and apart from it; Home and Play show none. The ring round the disc is the sidebar's ground: no halo of another colour under the drag's fill, the hover's fill or the sidebar's gradient. At 1x the cookie is not a blob. |
| `im_title_row` | Switch to Work in the open sidebar and in the rail; hover the title row. | The cookie after Work's name, or the badge on its glyph in the rail; the tooltip says what the mark means and that the essentials here are Work's own, in the rail after Work's name. |
| `im_menus` | Right-click a tab in Home: Move to Space, Always Open <site> in. Open the command bar (⇧⌘P, Ctrl+Shift+P) and type "move". | Work's rows wear the cookie and "Independent session" (on Windows after the row; on the Mac after the name, and the cookie only where the Mac's menus draw icons); Play's rows wear neither. The bar's Move Tab to Work row has the cookie after its text, quieter than the text. |
| `im_pin` | In Work, on a page signed into a site, right-click the tab, Add to Essentials. Switch to Home, then back to Work. Quit and relaunch. | No toast, and the page stays signed in: the essential is Work's own (spaces B6, sessions S8). Home shows Home's essentials, not this one; Work shows it alone in its essentials row. After the relaunch it is back in Work's row, still signed in. |
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
| `lt_tape_light` | The same in Light. | The near-black dashes carry the tape on the light slate ground, and the host line reads (Lt4). |
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
app installed, a launch with Stedding quit). About thirty minutes by hand on each platform.

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

One row per run, as for the core loop. A check left out of a run is "not run".

| Date | Build | Platform | `wa_mac_install` | `wa_tile_kept_out` | `wa_win_install` | `wa_app_*` | `wa_session` | `wa_session_off` | `wa_relaunch` | `wa_launch_quit` | `wa_update` | `wa_uninstall` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-10-20 | installed beta 20 | Windows 11 | — | — | pass | not run | pass (the shortcut's first request carried Work's cookie) | not run | not run | not run | not run | pass, from the app's menu and from chrome://apps | The uninstall box ran its two sentences together; fixed in patch 0072. The Start menu folder is "Stedding Apps" (Wa8) |
| 2026-10-20 | release build of patch 0075 | macOS 27 | pass, from the command bar; File → Add to Dock… is listed and enabled but was not pressed (the input tool does not drive the menu bar); Enter in the dialog did nothing, its Add button worked (BACKLOG `S-235`) | not run | — | not run | not run | not run | not run | not run | not run | pass, from chrome://apps: the launcher and the tile went, the Dock had its 43 tiles in the same order; the app window's own Uninstall was not tried | The empty `~/Applications/Stedding Apps.localized` folder stays after the last app goes, as Chromium leaves its own |

## Peek

The live checks `docs/features/peek.md` cites: what a person does with a peek on a real
build, with the real pointer and keyboard, which the browser tests cannot (they click by
script and call the window's activation). About ten minutes on each platform.

### Before the run

- An installed build, Peek on (Settings → Stedding → "Open links from pinned tabs in a peek").
- A page on one site with links to another, served from this computer: for example
  `python3 -m http.server 8765` serving `pin.html` (a link to `http://localhost:8765/peeked.html`,
  opened as `http://127.0.0.1:8765/pin.html`, so the two are different sites) and `peeked.html`
  (a page with a button that calls `alert()`).
- A real site with redirect links for `pk_redirect`: a mail or chat app you use, pinned.

### The checks

| Id | Do | Expect |
|---|---|---|
| `pk_open` | Open `pin.html`, pin it in its Space (⌘D, Ctrl+D), click its link. | A peek opens over the window, a margin of the window showing around it, the page loaded, its row showing the address, Open in Split View and Open as Tab; the pinned tab stays on `pin.html` (P1, P6, P12). |
| `pk_dialog` | In the peek, press the page's button. | The page's dialog shows in the peek (P6). |
| `pk_as_tab` | Open a peek; press Open as Tab, then the same with ⌘O (Ctrl+O). | The page becomes the active tab of the window, under the Clear line, without loading again; the peek is gone (P7). |
| `pk_split` | Open a peek; press Open in Split View, then the same with ⇧⌘O (Ctrl+Shift+O). | The page sits in a split beside the pinned tab (P9). |
| `pk_essential` | Drag the pin into the essentials, click its link. Right-click the peek's page; on the Mac, open the File menu. | The peek offers Open as Tab alone: on its row, in the page menu, and in the File menu, whose first row reads Open as Tab (P9). |
| `pk_close` | Open a peek; click the window's margin outside it. Open it again; press Escape. Open it again; press ⌘W (Ctrl+W). Open it again; wait a second, click the window's margin, then the pin's link at once. | Each closes the peek, and the window is in front, the pinned tab where it was; the link clicked straight after opens the peek again (P14). |
| `pk_fullscreen` | Put the window in full screen (⌃⌘F on the Mac, F11 on Windows), click the pin's link. | The peek opens over the full-screen window, in its Space on the Mac, not on another desktop (P6). |
| `pk_redirect` | In the pinned mail or chat app, click a link to another site, then a link to the app's own pages, then its "Sign in" or account link. | The first peeks; the second and the third go on in the pin (P2, P15, P16). |
| `pk_off` | Turn Peek off in Settings; click the pin's link. | The pinned tab follows the link, as any tab would (P10). |
| `pk_space` | With two Spaces, open a peek from a tab pinned in its Space; without clicking the window, swipe two fingers sideways over the sidebar to the other Space; press Open in Split View. Repeat with Open as Tab. | The window shows the pinned tab's Space again: the page in a split beside the pinned tab, then as the active tab; the other Space's tabs stay where they were (P7, P9). |
| `pk_grace` | Click the pin's link, and as the peek appears (within half a second) click the window's margin. | The peek comes back to the front, over the window; a click on the margin a moment later closes it (P14). |
| `pk_restore` | With the next launch set to continue where you left off, open a peek from a pin in a Space with a session of its own; quit (⌘Q, or Exit from the menu on Windows) with the peek open; start the browser again. | The window and its pinned tab come back; the peek does not (P17). |

### Runs

One row per run, as for the core loop.

| Date | Build | Platform | `pk_open` | `pk_dialog` | `pk_as_tab` | `pk_split` | `pk_essential` | `pk_close` | `pk_fullscreen` | `pk_redirect` | `pk_off` | `pk_space` | `pk_grace` | `pk_restore` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-10-25 | patch 0088, release, a copy with its own data folder | Mac | pass | pass | pass (the button and ⌘O) | pass (the button and ⇧⌘O; the pair's row leaves the pinned run, splits J5) | TBD | pass (margin, Escape, ⌘W) | pass | TBD | pass | not run | not run | not run | driven by `tooling/drive` with synthetic input, the owner asleep; captures by window id |
| 2026-10-25 | patch 0088, `out\win-release` | Windows 11 | pass (`example.com` pinned, a link to `iana.org`: a peek at the window's inset bounds) | TBD | pass (Ctrl+O) | TBD | TBD | pass (Escape, a click on the window's margin) | TBD | TBD | TBD | not run | not run | not run | `tooling\win\drive.ps1`'s real pointer and keyboard, the owner asleep; checked by window bounds and DevTools' page list, no captures |

## Clean links

The live checks `docs/features/clean-links.md` cites: a tracked link, a typed one and a
redirect page, opened on a real build, with the address field and history read by eye.
About five minutes on each platform.

### Before the run

- An installed build with a fresh profile ("Remove tracking from links you open" on, as
  shipped).
- A page served from this computer with links to another site: for example
  `python3 -m http.server 8765` serving `links.html`, with a link to
  `http://localhost:8765/a.html?utm_source=mail&id=1` and one to
  `https://www.google.com/url?q=http%3A%2F%2Flocalhost%3A8765%2Fb.html%3Ffbclid%3Dx`,
  opened as `http://127.0.0.1:8765/links.html`. The server's own log shows what it was
  asked for.

### The checks

| Id | Do | Expect |
|---|---|---|
| `cl_click` | Click the `utm_source` link; then ⌘-click (Ctrl-click) it. | Both pages open at `a.html?id=1`; the address field shows no `utm_source`; the server's log has no request with it (Cl1). |
| `cl_typed` | Type `localhost:8765/a.html?gclid=1&id=2` in the address field and press Enter. | The page opens at `a.html?id=2`, and the field shows that once it has loaded (Cl1). |
| `cl_redirect` | Click the Google link. | `b.html` opens with no `fbclid`, without a stop at google.com (Cl3). |
| `cl_history` | Open chrome://history. | `a.html?id=1`, `a.html?id=2` and `b.html` are listed; no `utm_source`, `gclid` or google.com/url address is (Cl6). |
| `cl_kept` | In Settings → Stedding → Privacy, add `localhost` to "Sites that keep their links"; click the `utm_source` link again. | The page opens with `utm_source=mail` (Cl8, Cl9). |
| `cl_off` | Remove the site; turn "Remove tracking from links you open" off; click the link. | The page opens with `utm_source=mail`; the Google link stops at google.com (Cl7). |

### Runs

One row per run, as for the core loop.

| Date | Build | Platform | `cl_click` | `cl_typed` | `cl_redirect` | `cl_history` | `cl_kept` | `cl_off` | Notes |
|---|---|---|---|---|---|---|---|---|---|

## The sidebar on the right

The live checks `docs/features/sidebar.md` Y34–Y43 cite: what the sidebar on the right looks
like and how it answers the real pointer, which the browser tests play by hand. About ten
minutes on each platform; none has run yet.

### Before the run

- An installed build, a fresh profile, two normal windows and a long page (one with a
  vertical scroll bar) in each.
- On Windows, a white page and a page with a dark `theme-color`, for the caption buttons'
  colours.

### The checks

| Id | Do | Expect |
|---|---|---|
| `sr_switch` | Settings → Stedding → Sidebar → turn "Sidebar on the right" on; look at both windows; turn it off. | Both sidebars move to the right at once, the page a gutter to their left and the address row over the page; off, both come back (Y34, Y35, Y36). |
| `sr_menus` | Right-click the sidebar's empty ground; choose "Move Sidebar to the Right". Then ⌘T (Ctrl+T), type "Move Sidebar", Enter. On the Mac, the View menu. | Each names the side the sidebar goes to and moves it there (Y34). |
| `sr_private` | Open a private window (⇧⌘N, Ctrl+Shift+N); move the sidebar from its menu; close it. | The normal windows move too, and stay moved (Y34). |
| `sr_edge` | With the sidebar on the right, rest on its left edge, drag it left and right; double-click it; Tab to it and press Left and Right. | The bar shows on the gutter; left widens, right narrows; the double click returns the default width (Y37). |
| `sr_rail` | ⌘S (Ctrl+S) with "Shrink to icons"; rest on the rail with expand-on-hover on. | The rail is at the right, its icons centred against the page's edge; it opens leftward over the page, which does not move (Y35, Y38). |
| `sr_hidden` | "Hide it completely", ⌘S; push the pointer to the window's right edge and rest. Then, in a maximized window, throw the pointer at the screen's right edge and drag the page's scroll bar at once. | The sidebar slides in from the right; the scroll bar drag scrolls the page and the sidebar stays hidden (Y39). |
| `sr_drop` | Drag a link from another app toward the sidebar. | The drop arrow is at the sidebar's right edge, pointing left (Y40). |
| `sr_lights` | On the Mac: look at the window's top left, open and as the rail; then full screen with Always Show Toolbar off, pointer to the screen's top. | The traffic lights sit on the address row's bar, its buttons past them; in full screen the row's contents start past where the lights come in (Y41). |
| `sr_caption` | On Windows: look at the top right, open and as the rail, on the white page and the dark one; hover each caption button. | Over the open sidebar the buttons are drawn in the sidebar's colours and its toggle is clear of them; over the rail they sit on the row's bar in its colours and the rail's toggle is below them; every glyph and hover fill is readable (Y42). |

### Runs

One row per run, as for the core loop.

| Date | Build | Platform | `sr_switch` | `sr_menus` | `sr_private` | `sr_edge` | `sr_rail` | `sr_hidden` | `sr_drop` | `sr_lights` | `sr_caption` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
## Site controls

The live checks `docs/features/site-controls.md` Si11 and Si12 wait on, and the rest of the
panel as a person meets it: how it looks and sounds, which no browser test sees, and the
real pointer and keyboard. About fifteen minutes by hand on each platform; none has run yet.

### Before the run

- An installed build; a profile with Home and Work, Work's Independent session on (its
  chip menu); a site you can sign in to, signed in from a tab in Work and from a tab in
  Home.
- One extension installed and not pinned; a page with a video; an https site that has
  never asked for the camera.
- VoiceOver on the Mac, Narrator on Windows, for `sc_voice`.

### The checks

| Id | Do | Expect |
|---|---|---|
| `sc_open` | Click the site chip at the address row's left. Hide the row (⇧⌘D, Ctrl+Shift+D) and run View Site Information from the command bar. | Both open page info with the strip under its title and Stedding's rows before Site settings; with the row hidden, inside the page at the card's top left (Si1). |
| `sc_strip` | Rest the pointer on each strip button. Press Copy link, Option-click it (Alt-click), press Copy title; paste each into a text field. | Each tooltip names the action and its chord. The clean link, the Markdown link, the title; the panel closes after each; the toasts say what was copied (Si2, Si3). |
| `sc_media` | On the video page open the panel, then play the video. Press Mute, then Picture in picture. | Picture in picture comes on as the video plays; Mute's words and icon flip and the panel stays; Picture in picture opens the floating window (Si4). |
| `sc_zoom` | Press Zoom in twice, the percentage, Zoom out. Press ⌘+ (Ctrl++) with the panel open. | 110%, 125%, 100%, 90%; no zoom bubble over the panel; the key shows in the percentage (Si5). |
| `sc_camera` | Open the panel on the https site. Turn the camera off, then look at Site settings. | Camera and Microphone rows though the site never asked; the choice shows in Site settings (Si6). |
| `sc_session` | Open the panel on Work's page, then on Home's. | "Work · Independent session" with the cookie, its tooltip the mark's; "Shared session" (Si7). |
| `sc_clear` | On the signed-in site in Work, press Clear site data…, read the question, press Clear and Reload. Then show the same site in Home. | The question names the site and Work and says you will be signed out; the page reloads signed out, with the toast; Home is still signed in (Si8). |
| `sc_dark` | Turn Dark pages on in the panel, then turn the site's row off. Press ⌥⇧⌘D (Ctrl+Alt+Shift+D) with the panel open. | The moon turns on with the switch; the page darkens, then stays light; the switch row follows the chord (Si9). |
| `sc_extensions` | Press Extensions in the panel and pin the extension. Hide the row and do it again from View Site Information. | The menu opens from the extensions button; the pinned button shows in the row at once; with the row hidden, the menu opens at the card's top left (Si10). |
| `sc_look` | Look at the panel in Light and Dark (Settings → Appearance), on a page with a coloured top. Capture it by window id (`tooling/capture-windows`). | Page info's own colours; the strip's buttons hover and press as page info's rows do; no page colour in the panel (Si12). |
| `sc_voice` | With VoiceOver or Narrator on, Tab through the panel; press Escape. | Each strip button read by its action, the zoom as "Reset zoom, 100%", each switch as a toggle named for what it turns, the session row once with the mark's meaning; Escape closes the panel and the page has the focus (Si11). |

### Runs

One row per run, as for the core loop. None yet.

| Date | Build | Platform | `sc_open` | `sc_strip` | `sc_media` | `sc_zoom` | `sc_camera` | `sc_session` | `sc_clear` | `sc_dark` | `sc_extensions` | `sc_look` | `sc_voice` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

## Sidebar panels

The live checks `docs/features/sidebar-panels.md` cites: what the browser tests cannot see or
do -- the Mac's menu-bar keys, the look over a Space's colour, the system's Trash, a drag into
the Finder or Explorer, a screen reader. About fifteen minutes on each platform.

### Before the run

- An installed build with "Open History and Downloads in the sidebar" on (the default).
- Some history, and two finished downloads, one of them small enough to move to the Trash.
- Three Spaces of different colours; the system in light, then dark.

### The checks

| Id | Do | Expect |
|---|---|---|
| `sp_keys` | Press ⌘Y (Ctrl+H), then ⇧⌘J and ⌥⌘L (Ctrl+J), then the same again; click into the panel's search field and press ⌘Y (Ctrl+H) again. | History opens in the sidebar's column, Downloads replaces it, the same key closes it; with the focus in the panel the key still closes it (Pn1, Pn2). |
| `sp_glass` | On the Mac, set the sidebar narrow (about 200 DIP) and open History. | The sidebar is drawn about 340 DIP wide with the glass behind all of it; closed, it is narrow again (Pn4). |
| `sp_look` | Open each panel in each Space, in light and in dark. | Every row, heading and button reads clearly over the Space's colour; the panel has no ground of its own (Pn16). |
| `sp_caption` | With the address row shown, click into the search field and press on the panel's header. | The field takes the focus and the window does not move (Pn16). |
| `sp_open_show` | In Downloads, click a finished row; then its menu's Show in Finder (Show in Folder). | The file opens; the Finder (Explorer) shows it (Pn9). |
| `sp_trash` | Move to Trash (Recycle Bin) on the small download. | The file is in the Trash and can be put back; the row stays, marked as deleted (Pn11). |
| `sp_drag` | Drag a finished row to the Finder's desktop (Explorer's). | A copy of the file lands there (Pn12). |
| `sp_nudge` | Download a file with the sidebar open; then again with Reduce Motion on (Windows: animation effects off). | The downloads button bobs twice when it finishes; with motion off it does not (Pn13). |
| `sp_reader` | With VoiceOver (Narrator) on, press F6 until the panel. | It is announced as "History" or "Downloads", and its rows read their titles (Pn16). |

### Runs

| Date | Build | Platform | `sp_keys` | `sp_glass` | `sp_look` | `sp_caption` | `sp_open_show` | `sp_trash` | `sp_drag` | `sp_nudge` | `sp_reader` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|

## Shortcuts the user changes

The live checks `docs/features/shortcuts.md` cites (Z5, Z11, Z15, Z17-Z19): what a person
does in the Shortcuts block on a real build, with the real keyboard. About fifteen minutes
on each platform.

### Before the run

- An installed build that carries BACKLOG S-91, two windows open, a few tabs in each.
- On the Mac, an App Shortcut set in System Settings (Keyboard, Keyboard Shortcuts, App
  Shortcuts) for one of the browser's menu rows, for `sc_macos`. On Windows, a keyboard
  layout with AltGr (Polish (Programmers), German) for `sc_altgr`.
- VoiceOver or Narrator for `sc_reader`.

### The checks

| Id | Do | Expect |
|---|---|---|
| `sc_rebind` | In Settings → Stedding → Shortcuts, press Add on Next Space and press ⌃⌥⇧J (Ctrl+Alt+Shift+J); take its shipped chords off with their ×. Press the new chord in both windows, then the old one. | The new chord moves to the next Space in each window, at once; the old one does nothing (Z11). On the Mac the Spaces menu's row shows the new chord. |
| `sc_record` | Press Add on a row and press ⌘T (Ctrl+T), then ⌘W (Ctrl+W). | No tab opens or closes; the row names ⌘T's owner (Z12, Z19). Escape cancels; Tab alone leaves the recorder. |
| `sc_replace` | Record ⇧⌘E (Ctrl+Shift+E) on Clear; press Replace. | Clear has it; Collapse the folders is off (its only chord gone); Cancel instead leaves both (Z12). |
| `sc_refused` | Record ⌘Q, ⌘C (Ctrl+C), Escape alone, and a chord macOS has on (⌃Space). | Each is refused with its reason (Z14, Z15). |
| `sc_held` | Move Most Recent Tab to ⌥J (Alt+J) and hold it: press J again, let go of ⌥ (Alt). | The strip of recent tabs follows the new chord and commits on letting go (Z18). |
| `sc_numbers` | Turn the row chords' switch off; hold ⌘ (Ctrl). | No row numbers appear, and ⌘1 (Ctrl+1) does nothing (Z17). |
| `sc_macos` | Find the row of the menu command with an App Shortcut. | It says macOS sets it, and has no Add (Z15). |
| `sc_altgr` | On a layout with AltGr, record a chord with AltGr. | The recorder asks for the left Alt instead (Z15). |
| `sc_reader` | With VoiceOver or Narrator, press Add. | It reads "Press the keys for <command>; Escape cancels" (Z19). |
| `sc_restart` | Reset all shortcuts after changing two; then change one and relaunch. | Reset all asks first and puts both back; the relaunched browser keeps the one changed (Z5, Z10). |

### Runs

One row per run, as for the core loop.

| Date | Build | Platform | `sc_rebind` | `sc_record` | `sc_replace` | `sc_refused` | `sc_held` | `sc_numbers` | `sc_macos` | `sc_altgr` | `sc_reader` | `sc_restart` | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

## Sync through a folder

The live checks `docs/features/sidebar-file.md` Sf7–Sf41 cite, which the tests cannot make: two
computers, a real sync tool, the system's privacy prompts. About forty minutes; none has run
yet.

### Before the run

- The Mac (a signed build) and the PC, each with a profile holding two Spaces and a few
  pins, one pinned folder and two essentials; a folder both see (Syncthing, or a share on
  the NAS), an iCloud Drive folder on the Mac and a OneDrive folder on the PC.

### The checks

| Id | Do | Expect |
|---|---|---|
| `sy_join` | Mac: Settings → Stedding → Sync and import → Set up…, pick the shared folder, Start syncing. PC: the same; tick the pairs; Combine. | The sheet names the Mac and its counts and the pairs; after Combine, one Space per pair on both, the Mac's pins unloaded on the PC; nothing open closed (Sf9, Sf10, Sf17). |
| `sy_edit` | Mac: rename a Space; PC within the same minute: recolour it. Pin a page on the PC. | Both computers show the new name and colour within a few seconds of the sync tool moving the file; the pin arrives unloaded on the Mac (Sf13, Sf15). |
| `sy_remove` | PC: unpin one pin; close a window holding pins; quit and relaunch. | The unpinned pin goes on the Mac (into Recently Closed if never opened there); the window's pins stay on the Mac (Sf18, Sf19, Sf21). |
| `sy_bulk` | PC: unpin five pins at once; delete a Space. | The Mac shows one row for the five with Apply and Keep, and one for the Space with Delete here… and Keep; nothing goes until answered (Sf22, Sf23). |
| `sy_copy` | Edit the PC's file on both machines while Syncthing is paused, then resume. | A conflict copy is named with Show in folder and Dismiss; nothing in it applies (Sf28). |
| `sy_cloud` | Mac: an iCloud Drive folder; Remove Download on the PC's file; Sync now. PC: OneDrive with Files On-Demand. | "Waiting for … to download", nothing removed; the change applies once the file is down (Sf30). |
| `sy_prompt` | Mac: pick a folder in Documents and one on a network volume; quit and relaunch. | Any prompt shows right after the pick with Stedding's sentence, and at a launch only once a window is up (Sf32). |
| `sy_share` | Mac: a NAS share; write from the PC; bring Stedding to the front. | The change arrives within ten seconds of Stedding being in front (Sf13). |
| `sy_stop` | Stop syncing on the PC, with the box ticked. | The PC's sidebar is unchanged; its file goes from the folder; the Mac keeps its own (Sf37). |
| `sy_time` | Join a profile with 300 pins. | The join applies without a visible stall; time it. |

### Runs

One row per run, as for the core loop.

| Date | Build | Platforms | `sy_join` | `sy_edit` | `sy_remove` | `sy_bulk` | `sy_copy` | `sy_cloud` | `sy_prompt` | `sy_share` | `sy_stop` | `sy_time` | Notes |
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
