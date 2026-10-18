# Feature: Acceptance scripts

Status: **the core loop's script is written and passed three runs on the Mac's release build
(2026-10-18, "Runs" below); a run on an installed build, and any run on Windows, are still
owed** (BACKLOG `S-173`).
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
- Windows' run is `tooling/acceptance/win/s173-live.ps1`, with `tooling/win/drive.ps1`.

### Runs

One row per run: the date, the build (version and commit), the platform, and each step's
result. P passes, F fails (with the BACKLOG row it opened), – was not run.

| Date | Build | Platform | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | P | P | P | P | P | P | P | P | P | P | P | P | P | run 1 of three, `tooling/acceptance/mac/run-mac.sh tst6` |
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | P | P | P | P | P | P | P | P | P | P | P | P | P | run 2 of three, `tooling/acceptance/mac/run-mac.sh tst6` |
| 2026-10-18 | release, 156.0.8078.36, the round's tree before patch 0071 | macOS | P | P | P | P | P | P | P | P | P | P | P | P | P | run 3 of three, `tooling/acceptance/mac/run-mac.sh tst6` |
| TBD | TBD | Windows | – | – | – | – | – | – | – | – | – | – | – | – | – | not run yet |

## The tests beside the script

The script is what a person sees; these browser tests drive the same paths through the
window, so a sweep finds a regression before the next run (BACKLOG `S-173`):

- TST-7, drags in the open sidebar and the rail: `TabDropTest.*` (folders F7, spaces B12).
- TST-8, a selection holds only rows on screen: `SidebarSelectionTest.*` (tabs R20, R21,
  copy-link L1).
- TST-9, the core keyboard: `NumberBadgeTest.CtrlTabEndsWithTheKeyOrTheWindow` (switcher X3),
  `SpaceSwitchTest.TheCoreChordsAsKeysThroughTheWindow` and
  `SpaceKeysTest.TheCoreChordsReachTheirCommands` (shortcuts Z7).
