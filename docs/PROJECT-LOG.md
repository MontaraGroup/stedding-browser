# Project log -- what was built, in order, with the evidence

History for orientation. Nothing here is needed to do a task: `AGENTS.md` carries what is
true now, `BACKLOG.md` the order of work, `PLAN.md` the owner's decisions.
This file was the "State of the project" section of `AGENTS.md` until 2026-09-30, moved
unchanged, and is where the dated record goes from now on: an agent opening the repo cold
should not have to read four hundred lines of rounds to learn the rules.


## 2026-10-14 -- fewer tests, a faster run, the plan into the backlog (patch 0064)

The operator asked to cut the number of tests radically without losing quality, to make the
runs faster, and to clear the repo of what is outdated. Every test was read against the specs
before anything moved: three reviews of the browser tests, two of the unit tests, one of
Chromium's own suites in the sweep, one of the docs and the tooling.

What the time went on: all unit tests took 13 s; the browser suite took 208 s, one test at a
time; a build after an edit takes one to two minutes. So the cut that saves time is in the
browser tests, and the unit tests were cut for clarity only.

- Browser tests, 233 to 103: tests that shared a setup are one scenario, each old test a step
  under a `SCOPED_TRACE` with its expectations kept and the state put back between steps;
  tests whose checks another test already made are gone. 73 run four at a time and 30 one at a
  time (`SERIAL_BROWSER_TESTS`): the drags, hovers and keys, the clipboard, picture-in-picture,
  a page that must paint for its colour, a command bar held across a wait. The suite takes about
  65 s on the release build and 130 s on the checked one.
- Unit tests, 930 to 760: Chromium's suites over code the series changes only at its edges
  moved to `tooling/dev test rebase` (`TabTest`, `TabContainerTest`, `TabStripTest`), and
  `ThemeServiceTest`, over code the series does not change, left the sweep (476 to 336 of
  Chromium's). Stedding's own 454 to 424: duplicates deleted, near-copies made tables, and
  different behaviours kept as separate tests, since a unit test costs nothing to run.
- Checks that could not fail were tightened on the way: a context menu's rows asserted present
  before hidden, the tab strip internals page showing the folder, a link drop below a folder's
  last row and on a collapsed folder, the settings page's address loading in the profile's jar,
  the isolation question skipping pins and sleeping tabs, the emptied nested folder going.
- The merges were reviewed three more times against the old tests: thirteen findings (three
  tests deleted without a real cover and brought back, a wait made shorter, steps that leaned on
  the step before), all fixed before the runs below.
- Parallel runs found what the serial ones hid (trap 88): a tab drag asks Windows which window is
  under each point and a new test window is not always in front, so the agent's own window took
  the drop (the drag fixtures now keep their window above others); a command bar closes when its
  window loses focus, and two tests held a pointer to it across a wait.
- The one product change: the hidden sidebar's test path reveals without the frame painting
  active, as it already did without the real cursor (patch 0059).

The docs: the 2026-09-26 plan, round 6's plan and the operator's rounds 2 to 11 moved to
`docs/history/`; `PLAN.md` is now the owner's decisions and when an item is done;
`BACKLOG.md` is the order of work, its rows `S-138` to `S-177` carrying the 225 items of the
old plan still open, by root cause, and `S-178` the Mac's half of this round. The roadmap's
status table, stale within days, is gone; the contradictions a review found between the docs,
the ADRs and the tooling are fixed (codecs, the updater, the development machine, Nook's
extensions, the idle-network run). Tooling: `tooling/status` sees the Windows builds,
`check-repo` keeps every build configuration's shared settings and reads a renamed test's
declaration whole, the build supervisor defaults to 12 jobs, `verify-build` requires H.264.

Tests: on `win-release` and on `win-checks` (DCHECKs and the dangling-pointer detector), 760
unit tests and 103 browser tests, both suites green twice on each build and the browser suite
green four times more on the release build. Not run: the Mac (`S-178`), `components_unittests`
(not built on Windows), ASan (`S-106`).

## 2026-10-14 -- a split keeps its folder, a folder comes back in order, five small defects (patch 0063)

The operator asked for `S-135`, `S-136` and the other small defects known, tested thoroughly.
Each root cause was traced through the code before its fix, the whole diff was reviewed against
its callers, each new test was run against the code without its fix and failed, and the build
was used by hand. One patch, 0063, as the rounds before it.

A split made of a folder's tabs stays in the folder (folders F34, splits J8): Chromium gathers
the tabs by strip index, and a folder's first and last slots resolve in its parent; they now
gather into the pivot tab's folder, as into its tab group, and a split with a new tab keeps the
tab it splits as the pivot. ⇧⌘T, or the Mac's History menu, from another window brought a folder
back reversed, the order judged by the command's window while the tabs go back to their own
(folders F19). Using the build found more in the same place: with the folder's own window left
shorter than the folder's old place, the tabs restored first grew the window past it, and a later
tab went back at that place, in front of them and, in one case, between a split's panes, which
broke the split. Chromium records a closing split before any tab of the close, so the list does
not hold a folder in its order; the close now marks each tab's place, and a folder whose place is
past its window's end comes back at the end, in order. The chip under a drag was lit at the lookup
of the drop target, before the drag said it carried an essential (spaces B12). A Space chip in the
open sidebar showed its floating name and a tooltip (sidebar Y14, `S-70`); the Mac's ⌃N badges on
the chips went by position, wrong with Focus on, and put a glyph on a dot. "Continue where you
left off" stayed across a page's full screen (toolbar T33, `S-69`).

`TabDropTest.TheChipUnderADraggedRowIsLit` failed one run in three or four, before this round as
after. Logging found a product race, not the machine (compare trap 77): a theme change rebuilt
the Space chips during the drag, a new chip had no bounds until the next paint, the drag's next
move found no chip under the pointer, and the release dropped nothing. A rebuilt chip now keeps
its old bounds until the row is laid out (`TabDropTest.AChipRebuiltMidDragStillTakesTheDrop`).
Left as `S-137`: a folder closed in part, a tab of it in another Space, comes back at the
folder's end. The three sidebar hover tests of trap 78 failed once more, after a live check
left the cursor mid-screen: the parking trap 78 credited to "the PC's suite scripts" lived in
uncommitted scripts, and `tooling/dev` now parks it on Windows
(`tooling/win/park-cursor.ps1`).
Tests: on the final code, on both the release and the DCHECK build (DCHECKs and the dangling-pointer detector), 930 of 930 unit tests and 233 of 233 browser tests. Each new test was run against the code without its fix and failed: `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, `FolderTabsTest.AFolderRestoredFromAnotherWindowKeepsItsOrder`, `FolderTabsTest.AFolderComesBackInOrderToAShortWindow`, the shown-tab check in `FolderTabsTest.AFolderHoldingASplitComesBackWhole`, `SpaceSwitchTest.FindingTheDropTargetLightsNoChip`, `SpaceSwitchTest.AChipShowsItsNameOnce`, `SidebarFormsTest.TheRestoreBarLeavesAPagesFullScreen` and `TabDropTest.AChipRebuiltMidDragStillTakesTheDrop`. `TabDropTest.*` passed 8 runs in a row after the chip fix. Used by hand on the Windows release build: the floating Space name alone over a chip after a two-second rest, no tooltip window; the restore bar gone in F11 and in a video's own full screen and back after each; a split of a folder's two tabs inside the folder; a folder holding a split and a tab, closed, its window left shorter than its place, restored with ⇧⌘T from a second window, whole and in order, the split first and shown. The macOS build is not run (`S-105`).

## 2026-10-13 -- the Mac's round checked on Windows (patches 0030, 0062)

The Mac's round (the entry below) pulled onto the PC: the branch rebuilt from patch 0030 on out
of the patch files with git plumbing alone, so only the files that differ were written, and its
export matched the pulled series byte for byte. A read of the round for the PC found three
faults, fixed in 0062 with tests that failed before: a split inside a folder was left behind
by Restore Folder and ⇧⌘T, being its own split entry (folders F19); Recently Closed kept the
old folder ids after a rebuild, so no folder showed ⇧⌘T's chord (TAB-13); a normal window's
colour supplier was freed with its window, and its address could come back as a private
window's, which would then take the normal window's cached provider (private V9). Left as
`S-135`: the order of a folder restored from another window, and a chip lit for one frame for
an essential. The quiet-start tests (`QuietStartTest.*`, the two Google calls) ran in the
Windows browser suite. Tests: on both the release and the DCHECK build, 928 of 928 unit tests and 226 browser tests: everything passed but the two new folder tests, whose first versions were wrong (one built its split after the folder, which takes the split out of it; one asked a menu with no window for its chord), and which pass on both builds as corrected. Four sidebar hover tests and a Guest-window colour test failed once with the real cursor over where test windows open and passed with it parked (trap 78).

## 2026-10-12 and 13 -- two privacy leaks, Phase 0's last code items, and the operator's three (patches 0030, 0062)

The operator asked for the two startup calls to Google (`S-54`, `S-67`) and the Phase 0
items with code left (TAB-13, SPC-4, WEB-5, CMD-1), pushed without a release and tested
properly. Every fix has a test that failed with the fix taken out.

- **Google's push service** (privacy Q11; patch 0030). The user policy invalidations
  (`UserFmRegistrationTokenUploader`) asked the push service for a token for every
  profile at every start, managed or not; they wait for a connected user policy now,
  which a profile with no browser sign-in never has. `QuietStartTest.GooglesPushServiceStaysOff`.
- **The Google account check** (privacy Q12; patch 0030). Three startup readers -- a
  session-length metric, the account investigator, the trusted vault client -- made the
  cookie manager ask `accounts.google.com/ListAccounts`; it no longer asks where browser
  sign-in is not allowed, as in every Stedding build. Browser tests pretend an OAuth client
  exists, so the test puts itself where the build is (`--allow-browser-signin=false`, trap
  84), and a control test shows the stand-in server does see the check where sign-in is
  allowed.
- **The network record.** A fresh profile of the fixed release build, five minutes
  headless and ten with a window, beside the same runs of the installed beta 10: the
  account check is gone (beta 10 asked it in both runs); neither build reached the push
  service in these runs, so that part rests on its browser test (`PRIVACY.md`).
- **Safe Browsing in Settings** (privacy Q13, PLAN.md WEB-5; patch 0030): Settings →
  Security says it does not work, above the modes.
- **A folder close as one Recently Closed entry** (PLAN.md TAB-13, folders F19; patch 0062).
  Not a new kind of entry in Chromium's restore code: Close Folder's Tabs marks each tab
  with the close's batch and the folder's name, which the tab's record keeps; the app
  menu's Recently Closed and the Mac's History menu show a batch as one item, and Restore
  Folder and ⇧⌘T bring the folder back. A batch close records every tab at the same index,
  so ⇧⌘T restores newest first, undoing the closes in turn (oldest first reversed the
  folder). The list keeps an entry per tab, so Undo and the Archived view are unchanged.
- **The lit chip** (PLAN.md SPC-4, spaces B12; patch 0062), seen live with the real
  pointer: over the chip a disc of its Space's colour, back over the list dark, dropped
  dark with the row in that Space.
- **The extension-reload test** (PLAN.md CMD-1, F61; patch 0062).
- **The series.** The privacy code folded into 0030 by plumbing (32 commits rewritten);
  the rest conflicted with the archive and test layouts of 0058 to 0061, so it is one new
  patch, 0062, under the operator-round exception. A Mac checked configuration,
  `tooling/args/mac-checks.gn`, and a Mac-only unit filter table in `tooling/dev` (trap
  80's case: `HistoryMenuBridgeTest` exists only on the Mac).
- **Tests**: on the release build with every change of the round in, 941 of 941 unit tests,
  20 of 20 component tests (the account-check test among them) and 225 of 225 browser tests,
  in one run at a load near 10. An earlier run, before the operator's three, had six sidebar
  tests crash at "CompleteShutdown took more than 30 seconds" with the Mac at a load of 100 to
  400 (trap 66); they passed on their own once it fell. Each new test also ran on its own.
- **Seen live** with the real pointer and keyboard on fresh profiles: the lit chip (above);
  Settings → Security's note above the Safe Browsing modes; a folder of three tabs closed from
  its header's menu, the Mac's History menu holding it as one item, "New Folder - 3 Tabs",
  with Restore Folder and its tabs in order, and ⇧⌘T bringing the folder back with its first
  tab shown. That look found the unnamed folder's item reading " - 3 Tabs": the close now
  records the name the header shows (`FolderTabsTest.AnUnnamedFolderKeepsItsHeadersName`,
  red before the fix).
- **The checked build** (`tooling/args/mac-checks.gn`, DCHECKs and the dangling-pointer
  detector; the Mac's first). Its first run passed 922 of 922 unit tests and 20 of 20 component
  tests, and 11 browser tests crashed with the detector's report: the tab layout's animation
  maps (`TabCollectionAnimatingLayoutManager`) kept raw pointers to rows destroyed outright, a
  folder closed or a window restored. The manager forgets a child now when its host loses it
  (`TabCollectionAnimatingLayoutManagerTest.AChildDestroyedOutrightLeavesNoPointerBehind`,
  which crashed with the report before the fix). With every change of the round in, the
  checked build passed 941 of 941 unit tests, 20 of 20 component tests and 225 of 225 browser
  tests, with no dangling-pointer report.
- **The operator's three** (2026-10-13; patch 0062). Each test failed with its fix taken out.
  - *Split view* (splits J7): Chromium padded each pane 5 DIP for its ring, so a band of the
    mat ran between the address row and both pages and the pages were 20 DIP apart. A pane
    is the page itself now: measured on the release build, the pages start under the row's
    1 DIP hairline (a 6 DIP band before), lie 6 DIP apart and keep the card's 6 DIP gutter
    to the window's edge (11 before); with the sidebar hidden, 6 DIP apart and edge to edge.
    `SidebarFormsTest.SplitPanesAreThePageAGutterApart`.
  - *The traffic lights on Back and Forward* (sidebar Y19). The operator saw it in a test
    window. Every steady form cleared the lights in seven live repros; capturing the test
    windows a few times a second found it: while a hidden sidebar opens, or the closed form
    changes between the rail and nothing, the strip is narrower than the lights, and the
    row started right after the strip, under them, for seconds on the loaded Mac (trap 86).
    The row's contents now start past the lights while the strip is narrower than the rail.
    `WindowButtonsTest.OpeningAHiddenSidebarKeepsTheRowOffTheLights` steps the animation by
    hand (13 steps under the lights without the fix); live, Cmd-S toggled six times over an
    orange page and captured about ten times a second: the seven frames with a strip narrower
    than the rail all had Back at 127 pt, past the lights.
  - *Back, Forward and Reload with no ground* (private V9, half of PLAN.md WIN-6). A private
    or Guest window has no Space model, which owns the page's colour, so its row was never
    painted and the buttons sat on the bare window ground. `BrowserWindowFeatures` owns the
    colour for those windows; in a private window the row's supplier takes the colour key's
    one slot, marked to stand for the private mark, so the window stays graphite.
    `PrivateCoatTest.APrivateWindowsRowTakesThePagesColour`,
    `SteddingColorMixerTest.AMarkedSupplierStandsForThePrivateMark`; live, a private window
    over the incognito page, an orange page and a white one: the row in each page's colour,
    the buttons on it, the ground graphite.

## 2026-10-12 -- the Mac's pass on betas 13 and 14 (beta 14's macOS image)

Betas 13 and 14 went out from the PC with no macOS image (`S-105`). The Mac pulled, applied the
61 patches, built the release configuration, ran its suites and used the build; its fixes were
folded into 0059 and 0060, and the signed, notarized DMG joined `v0.2.0-beta.14`.

- **Two faults in the hidden sidebar** (sidebar Y19, Y20; patch 0059). With the sidebar hidden,
  the address row's page-coloured bar started where the row's contents start, right of the
  traffic lights, which sat on a patch of the window's dark ground; `PageBarSurface` now starts
  the bar at the window's edge (`WindowButtonsTest.HiddenTheLightsSitOnTheRowsBar`, red before
  the fix). The sidebar slid in from the window's edge drew its top row 40 DIP high where the
  open one is 38: a hidden strip was given no address-row height and fell back to the toolbar
  buttons' own insets (`SidebarFormsTest.TheLeadingEdgeSlidesItInOverThePage`). The second is
  in code Windows shares.
- **The welcome flow's focus** (welcome W12; patch 0060). Every late answer (the Arc check, the
  importer's list, the default-browser check, an import's progress) redraws the whole flow, and
  the redraw dropped the keyboard focus onto the page; on the Mac
  `EachBehaviourChoiceIsWrittenAtOnce` caught it in four runs of five. The redraw now gives the
  focus back to the same control (`WelcomeFlowTest.ALateAnswerKeepsTheFocus`, red before the
  fix; then all six welcome tests five times each, 30 of 30).
- **The toasts' place** (toolbar T35; patch 0060). Seen live: ⌘W's undo toast crossed the line
  under the address row by 6 DIP. Over the page, Chromium places a toast `kShadowBlur` above its
  anchor's bottom, the room its border's shadow takes; on the Mac the window server draws the
  shadow, the border has no inset (measured: the toast's top at 65 against the row's 71), and
  the toast's body started that much above the row. The toast now starts as far above as its
  border's own inset, nothing on the Mac; `AddressBandTest.AToastLeavesTheAddressReadable`
  checks the visible edge, and the live toast sits right under the line.
- **Tests that assumed Windows or raced on the Mac**: the hidden form's address row starts right
  of the lights on the Mac; the undo toast was measured while its window was still moving (trap
  81); a `RunUntil` check that waited inside itself never returned on the Mac (trap 79); a
  rename test clicked while the rows still grew; and the strings test had no Mac case, so its
  filter stopped the whole sweep (trap 80).
- **Tests**: the final build, `tooling/dev test all`: 918 of 918 unit tests, 19 of 19 component
  tests and 214 of 214 browser tests, no retries, with another job's processes holding the
  load near 110 (trap 66 did not bite).
- **Seen live** with the real pointer and keyboard on fresh profiles, on the release build: the hidden form
  from the command bar, its leading edge in and out, ⌘S, the toggle naming ⌘S, the lights on
  a themed page's bar; ⌃M, ⌥⇧⌘R (the page's cookie gone at its reload), a folder from the
  command bar and ⇧⌘E both ways; ⌘W's toast before and after its fix; the welcome flow's
  behaviour step. Not tried by hand: ⌥⇧⌘P, Site Search, New Documents, Close Duplicate Tabs,
  Collapse Pinned Tabs, the edge's bar.
- **Signed and notarized**: Apple accepted the app, `spctl` reads it as a notarized Developer ID
  app and `syspolicy_check distribution` as ready for distribution; `tooling/verify-build` on
  the signed app: the page, WebGL, the three codecs and full screen passed; its network check ran
  offline, because this Mac's outgoing firewall held the new build's first connections for an
  answer and the check timed out behind it. The DMG's sha256 is `10348451…cc076d`; beta 13's notes now send
  the Mac to beta 14.

## 2026-10-12 -- beta 14 released (patches 0060 and 0061)

`v0.2.0-beta.14`, the Windows installer first (unsigned; the Mac adds its image after its own
pass, `S-105`). Before the cut: a docs pass over every Markdown file, cutting history and stale
notes; the row-numbers setting's sub-label corrected to "the first eight rows you can see, and
9 to the last one" (folded into 0061). The release build with the version set: 904 of 904 unit
tests, 212 of 213 browser tests, the other the known `SleepInUseTest` race, three of three
alone. Four sidebar hover tests failed once with the real cursor resting over where test windows
open, and passed with it parked in the screen's corner (trap 78). The installer ran over beta 13
as a repair with Stedding closed, the installed `chrome.dll` matching the build
(`docs/release-notes/v0.2.0-beta.14.md`).
## 2026-10-11 -- three more items (patch 0061, beta 14)

The operator asked for the next three, fast. Three small items in different parts of the code
were built together without building in between, then built and tested once.

- **Site Search** (S-109, commandbar K27): typing a search engine's keyword, name or domain
  offers "Search <name> — Tab"; Tab makes a chip and only that engine's rows show. The list is
  Chromium's own search engine settings. The first cut offered the @bookmarks and @history
  scopes by name, which took "bo" and "hi", and Tab with them, from the actions, and a leading
  "@" from the Space filter (K19); the scopes now need their whole keyword.
- **Collapse Pinned Tabs** (S-114, pins H17): from the Space menu or the command bar, per
  Space, kept across a restart; the pins hide by the one row rule and the selected pin keeps
  its row.
- **New Documents** (S-116, commandbar K28): command bar rows for eleven services' blank
  documents through their .new addresses, a fixed list as Arc's.
- **Tests**: one build of both configurations and the suites in one pass, after the Site Search fix: 904 of 904 unit tests and 213 of 213 browser tests on the release build, the same on the DCHECK build with no DCHECK or dangling report. Seen with the real keyboard on the release build: the Bing chip and its search row, the New Documents rows under "new g", and a collapsed run hiding its pin with the Clear line kept, then expanded again.
- **A machine fault, not the code**: three drag tests (`TabDropTest.*`) began failing on the
  release build between two runs an hour apart; the same three failed on patch 0060's own code
  rebuilt for the check, which had passed them at noon, so the cause is this PC's state (trap
  77), not the round. The DCHECK build passed them in the same round.

## 2026-10-11 -- the operator's round after beta 13 (patch 0060, beta 14)

After beta 13 the operator asked that auto-archive not run by default, a welcome step to ask
about it and the like, ten backlog items that are not hard, built and tested together, and a
fix for the address row's hover. All of it is one new patch, 0060 (the operator-round
exception in `patches/README.md`). It went out in beta 14 with patch 0061.

- **Auto-archive off by default** (S-130; archive A6, settings T2 and T8, commandbar K17):
  `stedding.archive.idle_hours` defaults to 0, Never, where it was 12, and a 7-day choice joins
  Settings, the command bar's row and the welcome step. A profile that never changed the
  setting stops archiving on update; one that chose a time keeps it.
- **A sixth welcome step, "Choose how Stedding behaves"** (S-131; welcome W12), after Light or
  dark: archive (Never by default, up to 7 days), what the sidebar does when it closes (Shrink
  to icons by default, or Hide it completely), and a Space's sleep after you leave it (Never by
  default, up to an hour). It shows the current values and writes each choice at once.
- **The search engines' marks** (S-77): each engine in the welcome flow's first step shows its
  initial on a colour, Stedding's own drawing; nothing is fetched. A public Chromium checkout
  ships no engine images, so every engine had drawn the default globe.
- **The sidebar**: "Page flush against the window" in Settings → Stedding → Sidebar, off by
  default, for no gutter and square corners beside an open sidebar (S-124; sidebar Y23,
  settings T15); a thin bar along the edge after a rest, and a double click or tap there for
  the default width (S-123, Y22); a middle click on the sidebar's empty ground opens the
  command bar (part of S-125, Y24).
- **Tabs and media**: Ctrl+M mutes or unmutes the selected rows, both panes of a split, and
  Ctrl+Alt+Shift+P toggles picture in picture on the page's video when its media session offers
  it (S-122; tabs R29, commandbar K25, player Mp5). After a user's close, of one tab or many, a
  toast offers Undo, which reopens exactly those in their Space and folder; none for archive
  sweeps, window closes, pages that close themselves or extensions; a switch in Settings →
  Stedding → Tabs turns it off (S-97; tabs R25 to R28 and R30, settings T17).
- **Folders and pins**: Ctrl+Shift+E collapses every folder of the Space while one is open,
  else expands them all; a folder header's menu gains New Tab in Folder and Alphabetize; a
  collapsed header shows its tab count (S-120; folders F30 to F33, menus M7). Edit Pinned
  Address… on a pin's or an essential's menu, and a middle click sends a pin home (S-121; pins
  H15 and H16, menus M7 and M8).
- **The command bar**: inline completion to a site from history (S-108, K23); Clear Site
  Cookies and Reload, Ctrl+Alt+Shift+R, in the Space's own jar when it has an independent
  session (S-119; K24, sessions S27); Close Duplicate Tabs, listed only while the Space has a
  duplicate (part of S-125, K26). Also from S-125, a switch for the link address shown at the
  window's corner on hover (page U9, settings T16); S-125 stays open for its other parts.
- **The address row's hover** (S-132, toolbar T34), the operator's report: with the address
  gathered on the page's middle in a field that takes the row, hovering painted the field's
  translucent colour twice, a lighter pill whose rounded edge cut through the first letter, and
  the band began at the row's far left where nothing is. Now the band runs from the chip to the
  page actions and the address paints no pill of its own; while editing, Chromium's whole field
  stands (`AddressBandTest.*`).
- **Seen on the release build with the real pointer and keyboard** (Windows): the six welcome
  steps with the engines' marks, the behaviour step fitting with Never chosen, and "1 day" and
  "Hide it completely" written to the profile and shown in Settings; the flush page on, then
  off again; the address row's band from the chip to the star, with no pill; the edge's bar, a
  drag from 328 to 398 px and a double click back to 328; Ctrl+W's toast with Undo; the command
  bar's "Mute Tab" and "Clear Site Cookies and Reload" rows with their keys, and no Close
  Duplicate Tabs without a duplicate; a middle click on the sidebar's ground opening the bar,
  a non-client press that no test reaches.
- **Not checked live**: picture in picture by its key, the Edit Pinned Address dialog, the
  folder verbs and the count, Clear Site Cookies on a real signed-in site, inline completion
  with real history. The Mac has built none of 0060.
- **Found by that use, and fixed**: Chromium's toasts sat half over the line under the address
  row, which is thinner than Chromium's toolbar, so the Undo toast hid the address for 8 s
  after every close. In the Stedding window a toast now sits in the page under the row, as in
  full screen (S-133, toolbar T35), and the toast was seen there afterwards.
- **Found by the suites, and fixed**: after Alphabetize, and after any move inside a folder, the
  drawn rows kept their old order: the folder's view lays its rows out in view order, while a
  move reorders only the node's children; the folder now puts its rows in the folder's order
  before it lays out (folders F31). The address band's own test kept a pointer to the window
  past its end (the dangling-pointer detector). `RenameFieldWatcherTest`'s field had no
  accessible name, which the accessibility paint check stops whenever its window paints in
  time (a latent test fault, folded into patch 0057). The right-to-left edge test failed once
  on the release build and passed three times out of three alone.
- **Found, not fixed**: skipping the welcome flow's engine step leaves no default chosen, and
  Chromium's own "Choose your search engine" dialog then opens over the first page with a
  globe for every engine (S-134, for the owner; `PLAN.md` WEB-13, WEB-F41).
- **Tooling**: `-Wunsafe-buffer-usage` stops a test that indexes a plain C array in a loop
  (trap 73); the DCHECK build ran out of commit at 22 jobs and built at 16 (trap 74).
- **Tests**: one build of everything, then the suites in one pass on both builds. The first
  pass found one compile error (trap 73) and four faults (above); the second, after the fixes:
  on the release build 882 of 882 unit tests and 209 of 209 browser tests, and the same 882 and
  209 on the DCHECK build with the dangling-pointer detector, with no DCHECK or dangling report.
  No ASan run (`S-106`), and nothing of 0060 on a Mac.

## 2026-10-10 and 11 -- the operator's pass on beta 12: the hidden sidebar (patch 0059)

The operator asked for a third sidebar form and named three faults; the PC built each, used it
with the real pointer and keyboard, and fixed what that use found before calling it done.

- **The hidden form** (`docs/features/sidebar.md` Y19): "When the sidebar closes: Shrink to
  icons / Hide it completely" (`stedding.sidebar.closed_form`). Hidden, the strip takes no width
  and the page card no gutter or corner, the address row runs edge to edge, and the pointer
  resting at the window's leading edge slides the sidebar in over the page. The command bar has
  "Show Sidebar", "Collapse Sidebar to Icons" and "Hide Sidebar" (K22).
- **Pins** (pins H14): a pin joins the end of the run; an unpin goes to the top of the tabs under
  the Clear line instead of splitting the run, which showed the pins below it as unpinned.
- **The resize edge** (Y18): the handle reaches over the 6 DIP gutter to the card's edge.
- **Settings** (settings T13, T14): the page in sections, Sidebar first; the width, tab row
  height and text size were already there, mid-list.
- **Found by using it, fixed**: the hidden strip's rows painted over the page (child layers its
  bounds did not clip); an empty band under the rail's toggle, older than this round, from a
  hidden combo button still counted (Y20); the selected row's globe at 1.4:1 in dark (S-73, Y21);
  Chromium 155's Ctrl+Shift+L in the toggle's tooltip and the bar (S-87); F11 and a video's full
  screen keeping the card's gutter (S-69's gutter half, toolbar T33). From the backlog: S-82,
  S-83.
- **The roadmap** (`docs/ROADMAP.md`): brought up to date (a state table; M5 is partly done, not
  done; M4's command bar did not replace the address row), and a milestone M10 for ideas read in
  Nook and Aura, rebuilt and never copied (ADR 0021; `BACKLOG.md` S-88 to S-101;
  `docs/COMPETITORS.md`).
- **Tooling**: the build supervisor ends with SUPERVISOR_EXIT=6 when `build.ps1` refuses to
  start (trap 70); `Drive-VisibleRect` for aiming at a window's real edge (trap 69); a firewall
  prompt holding the foreground is the operator's to answer (trap 71).
- **A review before the cut** read the diff and found eight faults, none a crash (the edge
  opening a sidebar F11 hid, right to left on the wrong side, two macOS full-screen layouts, a
  DIP past the window at fractional scales, mixed selections, two Mac paths); all fixed.
- **Tests**: unit 822 of 822; browser 170 of 171, the one failure a focus race at typing into a
  page's field (`SleepInUseTest`), which passed alone three times out of three. Then the DCHECK
  build with the dangling-pointer detector (`out\win-checks`): 822 unit tests passed, and three
  browser tests stopped on one fault, the welcome dialog holding its page's view past its widget
  (folded into patch 0015, trap 72); after the fix all 171 passed, and on the release build all
  822 unit tests and all 171 browser tests passed. No ASan run of 0058 and 0059 yet (`S-106`); the Mac has not built 0059 (`S-105`).
- **Beta 13** (2026-10-11): the Windows installer of this series, run as the user as a repair
  over the installed beta 12 before it was cut (`docs/release-notes/v0.2.0-beta.13.md`); the
  macOS image is the Mac's to add after its own pass.

## 2026-10-02 -- round 11 seen live, and beta 11

Patch 0058 (the owner's report on beta 10) had passed its tests without anyone looking at
it; the Mac then used the release build with the real pointer and keyboard on a copy of the
owner's profile and on a fresh one.

- **Round 11's live column, filled in** (`docs/history/operator-rounds.md`): three restarts of the copy with
  no "reason 332" and the imported tabs loading; rows clicked in the open sidebar and the rail;
  ⌘S keeping the address row; the swipe following the fingers; the eight Spaces as icons; the
  row's colour against the page on five pages and in full screen. TAB-3's and WIN-29's Mac
  halves passed too (`PLAN.md`).
- **Five faults found and fixed in 0058**, each with a test that failed first: the page's top
  read in the display's colour space (Display P3) and painted as sRGB (toolbar T31); a Space
  switch that showed nothing for half a second on the owner's profile, because the Space's tint
  re-themed every row and each row laid the whole list out again and redrew its folder glyph
  (spaces B36, found with `sample`, HANDOFF trap 65); a second line under the row in full screen
  (T32); the rail's Clear label clipped to "lear" (B17); folder names nearly invisible in light
  mode (folders F12). Logged instead: S-76 to S-80.
- **Two things about the harness**: the round 11 swipe helper set the event's line delta, which
  makes macOS report eight times the travel (trap 63), and Arc takes ⌥⌘N from every app while
  it runs (trap 64, `S-79`).
- **Beta 11**, the macOS image of this series, signed and notarized; Windows stays on beta 10's
  installer until the PC builds this tag.
- **Beta 12** the same day: what the pass had logged, fixed in 0058 with tests that failed first
  and seen on the rebuilt app -- the rows in place on a Space switch (S-80), ⌘T into an empty
  New Tab (S-78), the welcome flow fitting or fading (S-76), the Clear line on tinted Spaces, and
  Arc's ⌥⌘N in Settings' shortcut notes. The browser suite crashed at the harness's 30-second
  shutdown limit while other jobs held the Mac at a load of about 400 with swap full, and passed
  once the load fell; a sweep is only read on a quiet machine.
- **Beta 12 for Windows**, built on the PC and driven from the Mac over SSH. Its browser suite
  found the welcome flow's keys step 44 px under its footer on Windows, where the chords are
  spelled out; fixed in 0058, and Windows is no longer taught the Space swipe, which works on
  the Mac only. Two lessons about running the suite unattended: a scheduled task in the
  operator's session can run it at normal priority, but its windows cannot take the foreground
  a drag needs (trap 67); and at a display scale of 150 % Chromium's event generator scales a
  click twice, so sixteen click tests had been testing the generator (trap 68). The installer
  went into beta 12 beside the Mac's DMG: unit 817 of 817, browser 157 of 161, the four drag tests the only failures.

## 2026-10-01 -- the Mac's half of beta 10

The Mac took the PC's series as it was, re-exported byte for byte from the Mac checkout (a
re-apply by plumbing rewrote only the 39 files the PC had changed, so the rebuild took half an
hour), and the suites passed on it before anything changed. Then:

- **The migration, proven and fixed.** On a made-up profile the release build lost the move for
  good when another browser held Chromium's folder: it started an empty profile, and no later
  launch moved anything. The system's alert now asks first (patch 0057). On a clone of the
  owner's real beta 8 profile in a scratch home (`CFFIXED_USER_HOME`) the move then held in all
  four cases: no Stedding folder, a folder holding only `Crashpad`, beta 8 running on the old
  folder (the alert, **Quit**, then the move), and a profile from the official Chromium 157
  snapshot (left alone). `PLAN.md` PLT-1 is ticked.
- **The keychain, with the real login keychain.** No macOS prompt came up on this Mac. A fresh
  profile made its own "Stedding Safe Storage" item; a profile beta 8 itself made, with a cookie
  sealed under Chromium's key, still sent the cookie after the move and on the next launch.
- **The owner's eye.** The collapsed rail put the zoom button on the page's corner (the Mac's
  rail is 80 DIP now, patch 0039, sidebar Y16), and full screen left an empty band at the top
  of the sidebar (its toggle sits on the overlay's toolbar row, patch 0057, sidebar Y17).
- **Signing.** The first run to reach the end showed Chromium's signer deleting the notarized
  app when packaging is off (patch 0051). Beta 10's macOS image is the first Stedding signed
  with the Developer ID and notarized by Apple, and it went into the existing beta 10 release.
- **Tooling on macOS 26.** `tooling/drive-window.py` refused every click, because the Dock is
  one transparent full-screen window there now; `tooling/capture-state` has light and dark seeds.

## 2026-09-29 to 2026-09-30 -- the Windows PC takes over

The Windows build machine picked the work up from the Mac on 2026-09-29 (Ryzen 9 5900XT, 32 GB) with the pin at 155.0.8059.12 and 57 patches, and in two days did what the Mac's 2026-09-28 pass could not: built the series on Windows, ran it under sanitizers, and used the product with the real pointer and keyboard.

- **2026-09-29.** `tooling/sync-chromium` got a Windows mode (18 minutes). The first full build died of memory at 32 jobs and finished at 20 to 26 (trap 54). Everything compiled but three test files (a narrow literal passed to `FilePath::Append`, a local named `far`, a Mac-only path key), and the suites passed once the tests that assumed the Mac were corrected (unit 798 of 798, browser 150 of 150 with five Windows-only tests added; trap 55). No product bug turned up on Windows.
- **2026-09-30, sanitizers.** A DCHECK build with the dangling-pointer detector (3 h 20 min) and an ASan build (trap 57: its assembler never finished until `malloc_context_size=0`) found twelve defects in a tree whose suites were green (trap 60): a light-mode contrast bug, the quiet/adaptive permission defaults, a dangling Clear line and New Tab row after the switch to horizontal tabs, views without an accessible name, and the tests' own lifetimes. All are folded into patches 0030, 0042, 0043, 0047 and 0057. Final tree: release 800 of 800 unit, 151 of 151 browser; DCHECKs and the dangling-pointer detector the same; ASan: unit 800 of 800, browser 151 of 151.
- **2026-09-30, real use.** With the owner's leave, `tooling\win\drive.ps1` drove a fresh profile with the real pointer and keyboard (trap 58): the Mac's words on Windows in the welcome flow, a tooltip and three command-bar rows (fixed); light-mode row text (fixed); three more faults logged as S-68 to S-70. Every click on every kind of row selected its tab (8 of 8 open, 7 of 7 in the rail).
- **2026-09-30, beta 9.** `v0.2.0-beta.9` (https://github.com/ysalitrynskyi/stedding-browser/releases/tag/v0.2.0-beta.9), the Windows installer alone on Chromium 155.0.8059.12, published from this PC; macOS stays on beta 8 until the Mac has built the series and proved the keychain copy and the profile migration. The installer was run as the user over beta 6, on a copy of its profile, uninstalled and installed again (`tooling/win/test-installer.ps1`); the unit sweep and the browser suite passed on the exact image (800 of 800, 151 of 151). Open after it: S-68 to S-71, Win+V's own list, the Mac-only Phase 0 items, signing and updates (S-56).
- **2026-09-30, beta 10.** `v0.2.0-beta.10` (https://github.com/ysalitrynskyi/stedding-browser/releases/tag/v0.2.0-beta.10), the Windows installer on the same Chromium 155.0.8059.12 as beta 9, after the operator's screenshot of the address bar: the field was a pill of about 220 px in a window of 1688 and a click left only the bare host selected. Now the whole address shows always (Chromium's "Always show full URLs" registered on), the host in the text colour and the rest a step dimmer, and the field takes the row with the address gathered on the page's centre (toolbar T28 to T30, PLAN.md WIN-29); the command bar stays inside a narrow window (S-68, K20). Because the file version is the pin's, it installs as a repair and needs Stedding closed (S-72, trap 62). Built on the operator's word although PLAN.md would have queued it. The gates: 802 unit and 153 browser tests on the exact build and again on a build with DCHECKs and the dangling-pointer detector on (3 h 49 min from nothing, still the long pole); the installer run over the installed beta 9 as a repair, with the operator's Stedding closed (the file version is the pin's, so it replaced `chrome.dll` in place); the installed build opened on a fresh profile and on a copy of the real one. AddressSanitizer was not re-run: the change adds an integer to a view.
- **2026-09-30, the method.** The owner asked what the work did inefficiently. `AGENTS.md` and `docs/AGENT-LOOP.md` were rewritten around the answer (ask once, order of evidence, supervise long jobs, one pass that finds every failure), `docs/HANDOFF.md` gained the fast path and a trap index, and the machine-wide agent notes got a *Long jobs* section.

## 2026-09-26 to 2026-09-29 -- the audit, the owner's decisions and patch 0057

- **The audit (2026-09-26).** Sixteen review units read every file the series of 52 patches
  changed, each twice; 353 root-cause clusters stood after verification, every one a reading
  of the code, nothing built or run. It became `PLAN.md`, whose section 1 keeps the verdict
  as written. The owner answered its questions the same day (the decisions at the top of
  `PLAN.md`): horizontal tabs stay, Peek off until rebuilt, sleep at Never, every cut approved.
- **Patch 0057 (2026-09-28 and 29).** Patches 0053 to 0056 had claimed the plan done without
  being built. 0057 finished Phase 0's code and proved it on a real build of the pin: on the
  series pushed on 2026-09-29, `stedding_browser_tests` 146 of 146 and the unit sweep 809 of
  809, with real windows throughout (clicks on every kind of row and the rail, drags onto
  folder headers and Space chips, Space switches by every path, three restarts, the cookie jar
  of every way a tab opens, the archive, little windows, the sleep gate, search defaults,
  HTTPS-First, the private coat, the horizontal strip) and each change seen to fail with its
  fix taken out. The items it closed are ticked in `PLAN.md` section 4.
- **Found and fixed on the way:** a folder row reading a freed folder as a window closed (a
  crash, TAB-8); closing a Space's last tab briefly activating another Space's tab (spaces
  B4); Settings' sidebar-hover switch bound to a preference M155 renamed; a Space chip taking a
  tab group's header; a restored Blank Window following the Spaces; `tooling/capture-state`
  never capturing, because Chromium made the app frontmost (trap 29); a command bar row that
  turned Peek on; new tabs made during a Space switch filed in the Space being left.
- **Left for others:** the owner's own steps, a Windows build, the sanitizer builds,
  VoiceOver, the Keychain prompts and the owner's decisions; `PLAN.md`, "Where Phase 0
  stands", tracks each.

## State of the project, up to 2026-09-28

**Feature work is well past M1** — the milestone ladder in `docs/ROADMAP.md` is
being executed out of order on purpose, chasing operator feedback on real
builds. The patch series sits on the pin; unsigned beta pre-releases go to
GitHub Releases. `tooling/dev status` prints the real counts (patches, tests
per feature, pin); do not type them here.

What "working" means here: **a behaviour is done when its "Done when" check passes
on a real build** (`PLAN.md` §2). A green unit test alone proves nothing about what a
user sees, and captures prove pixels only: the old rule ("shipped when its test is
green") let broken basics ship, such as rows that would not select on click. The
September 2026 audit of the whole series is `PLAN.md`; it lists what is broken in
each feature below and the order of repair.

Built, by the old measure (each has open findings in `PLAN.md`):

- Arc-proportioned sidebar: essentials row, per-Space pins, Clear line,
  44 px rows, 18 px favicons; floating content card; centred bare-host URL;
  33 px toolbar.
- **Spaces**: switcher with floating hover names, per-Space tint, context-menu
  icon/rename/colour/delete, drag-tab-onto-Space, persistence (`decisions/0015`).
  Core semantics — membership on open, active tab follows the switch, delete
  moves tabs — landed as patch 0004 with `space_model_window_unittest.cc`.
- **Folders with nesting**: create from tab context menu, drop a dragged tab
  on a folder header (patch 0008), collapse, inline rename, session
  persistence; the close-path use-after-free is fixed and regression-tested.
- **⌘T command bar** across Spaces, also behind the sidebar's New Tab row.
  Stedding colours (sand light, blue→plum gradient dark). Codecs verified.
  Sign-in promo removed; DuckDuckGo default search; the new tab page is
  local (hint line, no Web Store tile) and the omnibox has no Google entry
  points; chrome://settings has no Google or AI sections and carries the
  Stedding mark. Mac updater stubbed
  (no Keystone) pointing at GitHub Releases.
- **Peek**: switched off, and its setting hidden, while its host is rebuilt
  (`PLAN.md` CMD-9, CMD-10; `docs/features/peek.md`).
- **Settings**: a "Stedding" section first in chrome://settings, one control
  per Stedding preference, plus the window's Spaces to rename or delete
  (`docs/features/settings.md`).
- **Auto-archive**: unpinned tabs outside folders that nobody has looked at
  for 12 hours (a setting) close into the recently-closed list
  (`docs/features/archive.md`).
- **Round 5 Arc parity** (`docs/history/operator-rounds.md`): the bar sits on the page and
  takes its colour, the Space title heads the list with its pinned run and
  the Clear line, ⌘S toggles the sidebar, ⌘T classifies and suggests,
  downloads at the bottom-left, the sidebar edge drags, a swipe changes Space.
- **Screenshots**: ⇧⌘2 the page, ⌥⇧⌘2 a region, ⇧⌘1 the full document; PNG
  to Downloads and the clipboard (`docs/features/screenshot.md`).
- **Welcome flow**: `chrome://stedding-welcome` over a profile's first window:
  search engine, import, appearance, default browser, shortcuts
  (`docs/features/welcome.md`).
- **Round 6, wave 1** (`docs/history/round6-plan.md`, patches 0016–0018): Arc's keys for
  Spaces (⌃1–9, ⌥⌘←/→, ⌘D pins, ⇧⌘K clears, ⌥⇧⌘←/→ moves the tab) and a
  Spaces menu in the menu bar; ⇧⌘C copies a clean link, ⌥⇧⌘C a Markdown one;
  the close glyph only on hover, alerts as a corner badge on essentials; the
  shortcut reference in chrome://settings/stedding; the status pill and the
  find bar inside the card, no ring around split panes; the capture and
  copy-link toasts; motion follows macOS Reduce Motion and a setting; the
  About line reads "Stedding <VERSION> · Chromium <pin>"; Space swatches on
  the welcome flow; the address row takes the page colour on either side of
  the contrast line (toolbar T7) and sits in a 6 DIP gutter like the card's
  other three sides.
- **Round 6, wave 2** (patches 0019–0025): sleeping tabs with one dimmed look,
  Sleep Tab / Sleep Others and a Space that sleeps after the user leaves it;
  rename in place that survives restore; row numbers while ⌘ is held; verbs
  that act on the selection with plural labels; Stedding's short tab menu
  with Chromium's behind a setting; Arc's pinned-tab lifecycle (a home URL,
  ⌘W sleeps, the drifted dot, the favicon reset, the menu rows, peek reads
  the stored site); the switcher's overflow dots and Move Left / Move Right;
  download progress on the sidebar button; the command bar's actions mode
  (⇥, a leading ">", ⇧⌘P: Stedding's own commands with their chords, ⌘L
  with the URL selected); ⌃⇥ through the Space's most recent tabs with a hold-to-see
  strip, ⌥⇧⌘↑/↓ moving the row folder-aware; the page and app menus without
  Google's rows, Import, Screenshot and Spaces in the app menu, a menu per
  row kind and for the folder header, Move to Space; a chip drag reorders
  the Spaces; a split's panes take a Space, a pin and a sleep together.
- **Round 6, wave 4** (patches 0034–0036, complete): private windows wear a
  different coat (`docs/features/private.md`); the little window for links
  from other apps (`docs/features/little.md`); one sidebar for every window
  through the SpaceRegistry (`docs/features/windows.md`, ADR 0016); ADR 0016 (the SpaceRegistry)
  and the specs for the little window and one sidebar for every window
  are written (`docs/features/little.md`, `docs/features/windows.md`).
- **Round 6, wave 3** (patches 0026–0033, complete): Import from Arc — Spaces,
  essentials, pins and folders from Arc's sidebar file, every tab unloaded
  (`docs/features/import.md`); routing — a site opens in the Space it is
  routed to, with a toast that undoes it (`docs/features/routing.md`); the
  archived view — what auto-archive, Clear and a close left behind, by day
  and Space, restorable (`docs/features/archive.md` A7–A11); the address
  row hides with the sidebar, ⇧⌘D shows it on its own
  (`docs/features/toolbar.md` T8–T12); the tracker-free defaults and the
  Privacy block (`docs/features/privacy.md`, ADR 0017); sidebar density
  presets and a text size (`docs/features/sidebar.md`); imported bookmarks
  become pins on demand from ⌘T, and a Space exports to a file in the importer's
  format and imports back (`docs/features/import.md` I13–I20; the hourly backups
  were cut in patch 0055).
- **Round 7** (2026-09-05, `docs/history/operator-rounds.md`; patches 0037 and 0038, with a
  second pass the same evening on the operator's replies): the row is the page's
  colour exactly, square under it, the address centred on the row in a field with
  no chrome around it, 560 DIP where the row has the room and shrinking when it
  does not (toolbar T15–T18); the collapsed rail centred and the sidebar's toggle
  on the traffic lights' own centre (sidebar Y6–Y7); Arc's folder row — macOS's
  own folder symbol, the header, the New Tab row and the Space title on the tab
  rows' column — and the drifted-pin row (folders F12, pins H12); the folder quit
  crash; the keychain item under Stedding's own name (import I24); Arc's history
  and passwords in one click from the welcome flow (import I6, I21–I23, welcome
  W8). Two of Chromium's own suites had been red since patch 0002 because nothing
  ran them: they now assert what this fork does (`docs/HANDOFF.md`, trap 31).

- **Round 8** (2026-09-08, `docs/history/operator-rounds.md`; patch 0039): the series built
  and ran on Windows for the first time -- nine `FilePath` portability fixes, then
  the operator's look at it, in four passes the same day. The address row under
  Windows' caption buttons with their glyphs in its colour and the buttons on the
  row's centre line; the focused bar and the dropdown in the page's colour; the
  row's colour surviving a reload; the rail's rows 44 DIP squares, centred, the
  switcher stacked, the hover overlay opaque. Three of them reach the Mac: a
  profile killed while collapsed crashed on every launch (the crashed-session
  bubble, toolbar T23), the address field could sit over the back button in a
  narrow window (toolbar T18), and the rail itself. Chrome's registry key for
  extensions is no longer read (privacy Q9). Verified on captures the tooling
  took itself with no focus and no input (`tooling/win/capture.ps1`, trap 36);
  the card measures the mac's geometry to the pixel. Not a port (M8, `S-56`):
  branding and the macOS chrome are `is_mac`.
- **M8, first slice** (2026-09-09; patches 0040–0041, ADR 0018): the collapsed
  rail expands on hover after a pause the user sets, 2 s by default, a click in
  the rail restarting it (sidebar Y11, settings T11); Windows knows the build as
  Stedding -- the name, the icon, `%LOCALAPPDATA%\Stedding`, its own registry
  keys, COM classes and sandbox prefix, so it lives beside a Chromium install
  (windows N3–N4); `tooling/apply-branding` runs under Git for Windows and the
  product-name rewrite reaches every locale; `tooling/win/build.ps1`,
  `package-installer.ps1` and a `publish-release` that joins a release across
  platforms make Chromium's `mini_installer` the Windows image, built, installed
  and uninstalled on the build machine (windows N6) and published with beta 5 as
  a preview. Chromium's field-trial testing config is off in every build from
  now on and the 2026 refresh it carried is on by decision (privacy Q10, patch
  0042). Still to come: little windows and links from other applications;
  unsigned; no updates (`S-56`).

- **Round 9** (2026-09-09, `docs/history/operator-rounds.md`; patches 0043–0045): the
  operator's first three minutes in the Windows preview. Arc's keyboard for
  Windows -- ⌘ read as Ctrl, ⌥⌘ as Ctrl+Alt, Alt+1–9 for the Spaces (windows
  N7) -- with the shortcut reference reading the platform's own table on every
  platform (shortcuts Z6) and the settings and welcome strings in the
  platform's words; the local new tab page for Google too (`S-45` closed), no
  API-keys infobar (welcome W9), no Chromium theme picker (settings T12); the
  rail's rows 6 DIP apart, the Space title its glyph alone, the switcher's
  stack measuring itself so a Space added in the rail keeps the "+" on
  screen, no floating name over the downloads button (sidebar Y12–Y14).
  Published as beta 6 from Windows.

- **The Mac pass on beta 6** (2026-09-10, `docs/history/operator-rounds.md`, *The Mac pass*):
  the checkout had been deleted for disk and was re-synced (HANDOFF trap 44); the
  first macOS build of the Windows-written patches needed a guard on a Windows-only
  colour id and a UTF-8 export file name (fixups into 0039); the first multi-tab
  capture showed every inactive sidebar row filled -- Chromium's field-trial
  testing config had been hiding that in every beta up to 4, and beta 5 was the
  first build with it off (privacy Q10) -- so the mixer pins inactive rows
  transparent (tabs R23, fixup into 0042); the release sweep grew
  `tooling/dev test upstream` and seven of Chromium's own cases now assert what
  this fork does. The macOS image joined beta 6 that day; the README's captures
  are from it.
- **Independent sessions and the keep-pile** (2026-09-16 to 18; patches 0046–0048,
  ADR 0019, ADR 0020; `docs/features/sessions.md`): a Space can keep its own
  cookies, cache and site data in a Chromium `StoragePartition` -- the chip menu's
  check item, a toggle in Settings → Stedding, a row in ⌘T -- with essentials on
  the shared jar, a moved tab rebound with its history and name (asleep stays
  asleep), Clear Independent Session on the chip menu, the jar wiped when the
  Space goes, and off-then-on reattaching the same jar. With it: keyword search
  and `@Space` in ⌘T, a split that renames as one (Chromium itself restores the
  pair), host and host-suffix routes, Focus and Hide Other Spaces. The 2026-09-18
  audit of those two patches (HANDOFF trap 46) found seven helpers with tests and
  no surface; patch 0055 cut them.

Released: `v0.2.0-beta.4` (2026-09-05, published from this repo with
`tooling/publish-release`), unsigned (M7 waits on Apple). It carries rounds 5,
6 and 7, the round-7 second pass included. Published from Windows: `v0.2.0-beta.5`
(2026-09-09, round 8 and M8's first slice, the Windows preview installer alone)
and `v0.2.0-beta.6` (`docs/release-notes/v0.2.0-beta.6.md`, 2026-09-10, round 9:
the Windows keyboard map, the first start, the rail); the DMG and its checksum in
the notes were the Mac's to add to beta 6, and it did on 2026-09-10 -- after
re-syncing a checkout that had been deleted for disk (`docs/HANDOFF.md`, trap 44),
with two fixups into patch 0039 that the first macOS build of the Windows-written
patches turned up (`docs/history/operator-rounds.md`, *The Mac pass*). Beta 5 stays a
Windows-only preview. Signing: the Developer ID certificate and the notary profile
exist since 2026-09-23, and the signer works end to end (`S-17`, patch 0051).
The pin is 155.0.8059.12 (2026-09-24, `S-64`: Google's early-stable build of M155,
taken straight from M153 because the owner wants the newest stable-channel build,
ADR 0007); `tooling/dev status` counts the series on it. `v0.2.0-beta.8` is the Mac image of the
previous pin, 153.0.8010.53, and `v0.2.0-beta.7` (153.0.8010.48) the one before. Outstanding:
`BACKLOG.md`. First vanilla perf comparison is in
`docs/perf/README.md`: on the deterministic page list every QUALITY budget is
met (cold +2.3%, warm −2.0%, memory +0.0% over vanilla).


## The hand-over note of 2026-09-28 (summary)

The note left on the Mac before the PC took over said: read `docs/HANDOFF.md`, then
`PLAN.md`; nothing is released until Phase 0 is done, and the profile migration and the
keychain copy are proven on a real beta 8 profile first; the sanitizer runs wait for a
second output directory; never edit the checkout while a build runs, and never inject input
while someone is at the machine. All of it was done or replaced in the days after: the
sanitizer runs on the PC on 2026-09-30, the migration and keychain on the Mac on 2026-10-01,
releases from beta 9, and real input with the operator's yes through a guarded driver
(`docs/HANDOFF.md`, trap 27).
