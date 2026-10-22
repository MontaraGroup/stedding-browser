# Project log -- what was built, in order, with the evidence

History for orientation. Nothing here is needed to do a task: `AGENTS.md` carries what is
true now, `BACKLOG.md` the order of work, `PLAN.md` the owner's decisions.
This file was the "State of the project" section of `AGENTS.md` until 2026-09-30, moved
unchanged, and is where the dated record goes from now on: an agent opening the repo cold
should not have to read four hundred lines of rounds to learn the rules.


## 2026-10-21, evening -- after 0.3.0 beta 1: quieter defaults, a split's row, the Space row, folders

After the release the owner asked for quieter defaults and sooner update checks (patch 0078,
held for the next release, `S-258`), then sent three notes from using the build:

- A split's address row met in a soft blend over the gap, a smudge where a dark page met a
  light one. Captures of the blend, a sharp edge and the window's ground over the gap went to
  the owner, who chose the ground: each pane's part now ends at the pane (toolbar T41, splits
  J16). `split_tabs/1` opens a split for captures and `capture-state --sidebar-width` sets the
  sidebar's width, so these captures need no pointer.
- The Space icons at the sidebar's foot turned to dots with room to spare. The row now closes
  its leading inset and shrinks its chips to 16 DIP first (18 at first; the owner asked for 16), and the dots' gaps close so the "+"
  stays in a narrow sidebar (spaces B24). The owner then saw the "+" sit nearer the sidebar's
  end than the downloads button was to its start: the trailing inset stays 10 DIP, and five
  captures from 215 to 330 DIP measure both ends at 21.5 DIP within a DIP.
- A collapsed folder's count of its tabs went, as Arc has none (folders F33).

Patch 0079 carries all three. On the Mac's release build 34 unit tests and 42 browser tests
pass; the run found `FolderTabsTest.UndoOfAFoldersLastTabStaysOutOfAGroup` still expecting the
toast 0078 turned off, fixed in 0078. Not yet run on Windows. The same evening: the FAQ's Arc
comparison now matches the README, and stedding.dev's three-column section has its room above
the headings back (a list reset had outweighed its padding).

## 2026-10-20 night to 2026-10-21 -- the owner's notes on beta 21, the Chrome 156 stable pin, 0.3.0 beta 1

The owner sent twelve notes on beta 21 on 2026-10-20. The round built them, fixed `S-251`,
took in a review of patches 0075 and 0076 and a by-hand pass on Windows, moved the pin to
Chrome 156's stable release and read the open GitHub issues, for the next release, 0.3.0
beta 1, the first of 0.3. On 2026-10-21 the owner set the rule for GitHub issues: a user's
issue is a suggestion unless it reports a bug, a feature waits for the owner's yes, and
nothing is said, labelled or closed there (`AGENTS.md`; `PLAN.md` decision 16).

- **The owner's notes** (patch 0077): a folder renamed only from a double click on its name,
  in a field as wide as the name (folders F4); a folder in the pinned run, by a drag over the
  Clear line or Pin Folder (F38, `S-107`; the Arc importer still makes such a folder an
  ordinary one); the rail following the density, square rows of 44, 36 and 30 DIP (sidebar
  Y8, Y12); a site's favicon kept on its pages that name none (tabs R54); a pin closed the
  Arc way, unloaded at its home by ⌘W, its ✕, a middle click or the menu's Close (pins H3,
  H9, H16; `PLAN.md` decision 11); the address row's buttons hovering in the row's own colour
  (toolbar T44), and a newly pinned extension shown at once (T43; the owner's fault not
  reproduced); every chip fitting the address field (T42); every empty part of the window's
  top a title bar, on the Mac and on Windows (sidebar Y29); an extension's popup window
  opening over a full-screen window on the Mac (windows G8).
- **Tabs given on the command line** (`S-251`, patch 0077). The background tabs had committed
  ERR_CONNECTION_RESET: two certificate verifier updates in a launch's first second (the
  profile's first one and the network time) dropped every connection opened ahead of the
  tabs' requests, though nothing had been verified yet; the tabs reconnected at once, and a
  server with a short accept queue reset the overflow. The verifier service now passes a
  change on only once it has verified a certificate
  (`CommandLineTabsConnectedAheadTest.ATabLoadsOverTheConnectionItOpenedAhead`, failing
  without the fix): 0 of 30 real launches lost a tab after, 13 of 22 before (traps 119, 120;
  `docs/ARCHITECTURE.md` lists the series' changes to the network stack).
- **The Windows pass and the review** (patch 0077). On Windows' beta 21: a row dragged from
  the rail onto the page opened the sidebar under the drag, and a split's pane names kept the
  sides the split first gave them (splits J10, J11, sidebar Y11); Escape during the
  Ctrl+Alt+E chord sent the window to the back, Windows' own Alt+Esc, which a hot key of the
  browser's now takes while the chord holds (toolbar T39, trap 122); tabs restored asleep did
  not draw asleep (tabs R46); the rail's rows showed no hover card (pins H19). The review of
  patches 0075 and 0076: the sleep gate no longer hits a CHECK on a split the model has let
  go of, and the termination policy asks it once a page; the split's drop light and the emoji
  centring mirror in right-to-left layouts; the split row's icons read on the ground beside a
  page's colour; a replaced pane is watched again.
- **Smoother motion** (motion O4 to O8), measured frame by frame in a real window on the
  Mac's release build at 120 Hz: no main frame longer than a vsync, the longest 8.2 ms. Hidden
  row controls are left out of each frame's layout (a frame of the rail's hover opening laid
  out 152 views, now 120); the sidebar's collapse, expand and hover overlay ease out, where a
  collapse had moved a third of the way in one frame; the Space being left is kept as a
  recording the compositor rasters, so a switch takes 13 to 14 ms where it took 18 to 22;
  the omnibox's hidden popups follow the address field once a motion ends, where each moved
  32 times in a collapse and 38 in an expand (`d87ed04`). The Windows runs are not yet made.
- **The pin.** Chrome 156 reached the stable channel on 2026-10-20 as 156.0.8078.47 and .48;
  the pin moved to 156.0.8078.48, and the series applied unchanged (`5147193`, ADR 0007).
- **GitHub issues.** Issue 10, switching Spaces with the mouse, is built as the owner chose
  (spaces B39; `PLAN.md` decision 15): over the sidebar a sideways scroll steps one Space, from
  a tilt wheel or Shift with the wheel, and on Windows also from a touchpad's sideways scroll
  and Ctrl with the wheel. On the Mac its unit and browser tests pass on the release build,
  and real wheel events posted to the window stepped as specified. Its first Windows run found
  a real fault: off the Mac the root view hands one wheel event to every view on its way up, and
  the handler read it at each, so a vertical touchpad scroll with a little sideways drift was
  swallowed and the tab list did not scroll; each event is now read once, and its tests pass
  on all three Windows builds (a real touchpad and tilt wheel are still to be tried there).
  Issue 9, the little window's way into the main window, is built: an "Open in Stedding" button
  at the right end of its bar, rows in the page's menu and the File menu, Show as Tab doing the
  same move, and a new window when none is open; the window has no title bar, its traffic
  lights in Stedding's own address row in the page's colour, light or dark as the main window
  (little E7 to E9, `S-157`). A single quit hang with a little window open, seen once while it
  was built, did not come back in eight timed quits (0.7 s each). Issue 8, essentials of one Space, is declined by the owner:
  essentials stay shared by every Space, as in Arc (`S-254`; `PLAN.md` decision 14).
- **A by-hand pass on the Mac's release build** (2026-10-21) found what no test had asked
  about: a pin closed while it played kept its speaker mark (pins H24); a double click renamed
  the row the list had moved under the pointer, and a row moved away kept its hover (tabs R14,
  R1); the chords on the Space chips read 2.5:1 on the light ground (tabs R11); the address
  row's hovers stood 1.12:1 to 1.36:1 from the row, the star's 1.00:1 (toolbar T44); Close on a
  pin showed no chord in the Mac's menu (menus M1). Each was fixed with a test.
- **Found and filed.** A crash when vertical tabs came back on while a tab of the horizontal
  strip glided home after a drag, in Chromium's `TabStrip::Reset`, which upstream's main
  branch shares: fixed (`S-253`, tabs R55). A drag test that reads the machine's real cursor
  (`S-252`). The split row's colour test read a pane's first paint over its step on a busy
  machine: it now waits for both panes (4 of 60 failed before, 90 of 90 passed after,
  `e94ae63`).
- **Tooling.** `tooling/drive` takes a `move` step (the pointer along a timed path) and a
  `wheel` step (a mouse wheel's notches); traps 117 to 123.
- **Late in the round:** a pinned folder moves among the pins as a pin does, a bar showing
  where it lands (folders F38, the owner's question); a split's row keeps each pane's edge
  through a dark pages switch, where both parts had shown the page's declared colour for two
  frames (dark-pages Dk8, seen in the README recording); the hidden omnibox popups follow the
  field once a motion ends instead of moving at every frame (motion O8). The Windows runs found
  four tests at fault there (an owned popup widget, a late resolver rule, a window reported
  covered at a drag's press, the real cursor reaching a test), all made right.
- **Release:** `v0.3.0-beta.1` (tag at `7031160`, 77 patches on 156.0.8078.48), the first
  published as the repository's latest release rather than a pre-release (the owner's wish, so
  it shows on the repository's page; `tooling/publish-release`). Mac release build: 1008 unit,
  56 component and 468 browser tests, one shutdown overrun passing on a rerun (`S-257`). PC:
  999 unit and 561 browser tests on each of the release, DCHECK and ASan builds, with no
  report. The installer upgraded 0.2.0 beta 21, uninstalled keeping the profile and installed
  fresh, `chrome.dll` matching each time. Local n-1 on both platforms, then published (DMG
  `0ca31dc3…7c3b`, installer `ccbcfc34…628d`), both downloads matching and Gatekeeper accepting
  the app; both feeds pushed (`0ecfa30`, `ccdfe5d`) and read back. Real updates through the
  published feeds: the PC's installed 0.2.0 beta 21 at 25 seconds, restarting into 156.3.0.1 in
  two; a Mac copy of 0.2.0 beta 21 at 43 seconds, relaunching as 10030.1. stedding.dev went out
  the same hour with a Support button, a "What's new in 0.3" section of clips, a new hero and
  the footer's link to YS Progress Inc.

## 2026-10-19 night to 2026-10-20 -- the planned fixes, six features, the owner's look notes, beta 21

The operator asked for S-250 and "all other planned things": the defects, the updater's
leftovers, the checks owed that need no new hardware and Chrome's own defaults first, then the
features in the backlog's order, with the owner's choices for six of them; then for GitHub
issue 7 (drag a tab onto the page to split it) to be built without a comment on it, for the
collapsed sidebar's icons to line up, for a split's address row to take each pane's colour, and
for the tab strip on top to look right. Beta 21 was to follow once the checks passed.

- **Fixes** (patches 0071 to 0073): a closing tab is told of its detach once (`S-250`, the
  checks build's dangling pointer); the toolbar's download button measured mid-slide
  (`S-250`); a quit's windows stay in the archive when the next launch does not reopen them
  (`S-230`); a moved row's stuck hover (`S-143`); the chips' chords drawn whole (`S-144`); a
  Space model's leftover callback; an app's uninstall box; the Windows updater's six review
  items and the uninstaller's PDF key (`S-249`, `S-71`).
- **Chrome's defaults** (patch 0074, `S-236`, `S-237`, `S-240`): the features Chrome turns on
  for all its users by its field trials, Google's key pins and Certificate Transparency, with
  none of Chrome's certificate reports; `tooling/field-trials` compares Chrome Stable's seed
  with the pin's defaults.
- **Checks owed**, on the installed beta 20: the core loop and the by-hand checks on both
  platforms (`docs/features/acceptance.md`), the Windows install of an app made from a page
  (`S-235`), the sidebar labels' grayscale text (`S-214`).
- **Six features** (patch 0075, the owner's choices of 2026-10-20): a tab dragged onto the page
  makes a split (`S-113`, issue 7); the tab shown after a close is the one used last (`S-112`);
  only the selected tab loads at launch (`S-110`); tabs sleep on a timer and under memory
  pressure, with Sleep Other Tabs (`S-111`); page pictures in the Mac's hover cards (`S-115`);
  with the address row hidden, its controls in the command bar and ⌘E (`S-104`).
- **The Mac by hand**, with the real pointer and keyboard on a release build: the split by drop
  from the sidebar, the rail and the strip, ⌘W, the launch choices, Sleep Other Tabs, the hover
  pictures and Add to Dock with its Dock tile passed. It found five faults: four fixed in patch
  0075 (the first ⌘W after a relaunch counted the restore's own selections; Escape with ⌘ held
  never reached the bar, so ⌘. cancels; Show Media Controls looked for the hidden button; Return
  did nothing in the Add to Dock box) plus a popup over the rail; the fifth, tabs given on the
  command line that sometimes never load, is in beta 20 too (`S-251`).
- **The owner's look notes** (patch 0076): the row over a split in each pane's colour with a
  blend over the gap; the horizontal strip's tabs as pills, a split's halves each a tab wide, no
  Material blue left; every glyph of the rail on its centre line, emoji centred by their ink.
  Its Windows run found the glyph's ink measured short with Segoe UI Emoji and an older race
  that put a page's old edge colour back on a background tab after Dark Pages changed (Dk8);
  both fixed with tests.
- **The PC's test runs**: the two extension-popup tests had looked up the popup's widget the
  Mac's way; the four mock-clock unit tests that stalled only in the scheduled task were starved
  by its default priority 7, which lowers disk and memory priority (traps 67 and 99): made at
  priority 4, the unit leg takes 19 seconds.
- **Beta 21** (`v0.2.0-beta.21`, tag at `f57fc2f`, 76 patches): the Mac's release build 997
  unit, 56 component and 407 browser tests; the PC's release, checks and ASan builds 988 unit
  and 491 browser tests each, no DCHECK, no report; the installer over beta 20, uninstalled
  keeping the profile and installed fresh, `chrome.dll` matching each time. The local n-1 on
  both: the Mac's copy of beta 20 showed the pill at 28 seconds and came back as 10020.21 with
  the thank-you page; the PC's installed beta 20 showed it at 20 seconds and restarted into
  156.2.0.21 two seconds after the press, through UI Automation once the click was refused
  (trap 118). Published from the Mac (the DMG, sha256 `5b173e57…ac32`, 179 MB) and the PC (the
  installer, `f1c8d94e…a410`, 168.1 MB); both downloads matched and Gatekeeper accepted the
  app. Both feeds pushed (`52f2811`, `4e816ae`) and read back from GitHub. **Real updates
  through the published feeds:** a Mac copy of beta 20 showed the pill at 38 seconds and
  relaunched as 10020.21, on the person's own profile, which the published bundle names (trap
  117); the PC's installed beta 20 at 25 seconds, restarting into 156.2.0.21 in two. The site
  rebuild was started.

## 2026-10-19, evening -- a review of betas 18 and 19, and beta 20 for both platforms

The operator asked for every change since patch 0072 was first pushed to be read, those made on
the Mac by another agent most of all, for the bugs to be fixed, and for the next version to be
built and released on both platforms together.

- **The review** read four parts at once: the two fixes made on the Mac after beta 18 (patches
  0058 and 0072), the Windows updater (patch 0073), the PC's changes to patch 0072, and the
  repository's tooling and docs.
- **Restored tabs were crashing again** (import I26). The Mac's fix for two restored copies
  of an entry sharing their frame wrote the sequence number -1 back into the saved page state
  and sent it to the renderer, which the browser kills; `RestoredPageStateTest` failed on that
  build. Now the session and the frame entries keep upstream's -1 (so Chromium's
  `ToNavigationEntries` and `ToNavigationEntry` pass) and only the page state sent for a
  commit carries 0 (patch 0058).
- **The toast** (toolbar T38): on the Mac `AddressBandTest.AToastSitsUnderTheInfobars` had
  never passed. A toast whose anchor changed while it slid in stayed where the slide ended; it
  is placed again when the slide ends, the end-of-layout placement skips the slide's frames,
  and a window closing with a toast up no longer re-anchors it, which crashed the test's
  teardown once the toast stayed up (patch 0072).
- **The Windows updater** (patch 0073, `S-249` for what is left): one check at a time,
  timeouts on both requests, the download's folder made off the UI thread, its name checked,
  a quit not held by an install, the installer deleted before a quit ends; the root store's
  rules, the Web Store, Safe Browsing, GCM, sync, OAuth, image search and DIAL now get
  Chromium's version. Tooling: `publish-appcast.ps1` got the Mac script's guards,
  `update-key.ps1`'s backup keeps the passphrase apart, `build.ps1` refuses what the Mac
  cannot build. The Mac's pixel tests run at the screen's scale again.
- **Beta 20's checks.** Mac release build: unit 964, components 56, browser 361, all green.
  PC: release unit 951 and browser 341; `win-checks` the same with no DCHECK; ASan the same
  with no report. The installer upgraded the installed beta 19, uninstalled keeping the
  profile and installed fresh, `chrome.dll` matching each time. The Mac's n-1 from the
  released beta 17 to a Developer-ID copy of this build: pill at 25 seconds, relaunched as
  10020.20 13 seconds after the press, tab and thank-you page there. A first signing attempt
  stopped because the notary profile had gone from the keychain; the operator stored it
  again.
- **Published** `v0.2.0-beta.20` from the Mac (the DMG) and the PC (the installer); both
  downloads matched their checksums and Gatekeeper accepted the app. Both feeds pushed and
  verified. **The first real Windows update**: the PC's installed beta 19 installed beta 20
  from GitHub within 30 seconds and swapped it in at the quit. The Mac's installed copy
  updated itself through the real feed as well. Beta 18 and 19's notes and release pages now
  say the Mac's image of that work is beta 20's.
- **The Mac's checks build, after the release:** unit 964 and components 56 with no DCHECK;
  browser 358 of 361, the three intermittent: a tab row's dangling pointer, never read after
  the free, and two slow-build timings, filed as `S-250`.

## 2026-10-19, afternoon -- the Windows updater, beta 19

The operator asked for automatic updates on Windows to be built while the Mac added its image
to beta 18, chose the version shape drafted for `S-72`, a Windows update key on the PC, a
release as beta 19 once tested, and the update test on their own install with the profile kept.

- **A version of Stedding's own on Windows** (`S-72`, patch 0073): `tooling/win/build.ps1`
  writes `<milestone>.<100 × major + minor>.<patch>.<beta n, 999 for a release>` into the
  checkout's `chrome/VERSION` (beta 19 is 156.2.0.19), with Chromium's version on a
  `CHROMIUM_VERSION` line for the user agent, the client hints, the Web Store, the component
  updater, extensions' minimum version and About (`ChromiumVersionTest`).
- **The updater** (`S-215`, patch 0073; updates Up14 to Up22): `stedding::AppUpdater` on
  Windows reads `updates/appcast-windows.xml`, checks the feed's and the installer's Ed25519
  signatures against a Windows key of its own (ADR 0026; `tooling/win/update-key.ps1`), runs
  the installer hidden beside the running copy and offers the restart in the sidebar's pill.
  `tooling/win/publish-appcast.ps1` signs and writes the feed; `tooling/win/update-n1.ps1` is
  the n-1 check.
- **The n-1 check on the installed copy:** a build of 156.2.0.18 installed over beta 18 as an
  upgrade, found beta 19 on a local feed, installed it beside itself (`InstallerError` 30), and
  showed the pill 25 seconds after launch; a real click restarted it into 156.2.0.19 in about
  two seconds with its tabs. `out\win-release\chrome.exe` asked nothing (Up21).
- **Beta 19's checks:** release unit 951 of 951, browser 341 of 341. The installer as a user
  gets it (a repair, uninstalls keeping the profile, beta 18 fresh, beta 19 over it, a fresh
  install), `chrome.dll` matching. The core-loop script passed every step, its parts run one
  per task: run after another part, a part's window came up with no page visible for a minute
  (`S-248`; trap 116's busy-machine reading of beta 18 may be this). `win-checks`: 951 and 341
  with no DCHECK or dangling pointer; ASan: 951 and 341 with no report.
- **Published** from the PC (`v0.2.0-beta.19`, the Windows installer; the downloaded asset
  matched its checksum), and offered through `updates/appcast-windows.xml`, which the
  installed beta 19 then read from GitHub, verified, and answered "up to date". CI first
  refused patch 0073 for spelling out the pin in code (check-repo's version check, which runs
  on tracked files only, so it passed before the commit); fixed in comments and test values,
  `chrome.dll` rebuilt byte for byte. The macOS image is the Mac's to add.

## 2026-10-19, late morning -- beta 18 from the PC

The operator asked for S-244 to be fixed, everything pushed, and, when all was done and tested,
a new version released.

- **S-244.** A toast of the whole window sits under the infobars while any is up and follows
  them (toolbar T38); seen on the installed build with the restore bar up.
- **The checks build before the release** (`win-checks`, 33 minutes from 0071's objects) stopped
  on two faults a release build does not check (S-245: dark pages forgot an edge reading that
  was never made; S-246: with vertical tabs off the strip measured its spinner against a
  transparent ground) and on a test that painted a view inside a widget; all fixed in patch
  0072. A Space test missed an accelerator while another test held the foreground; it joins
  the Windows serial list (trap 115).
- **Beta 18.** Version 0.2.0-beta.18. Release build: unit 939 of 939, browser 340 of 340.
  The installer as a user gets it: a repair over the installed build, an uninstall that kept
  the profile, a fresh install, `chrome.dll` matching each time. From the installed copy: the
  welcome flow on a new profile, light and dark windows, and the core-loop script, every step;
  its keyboard and drag parts first failed at their setup while the ASan build linked (trap
  116) and passed on a quiet machine. `win-checks` then 939 and 340 clean, and ASan 939 unit
  and 340 browser tests with no report.
- **Published** from the PC with the Windows installer; the macOS image, its notes and the
  update feed are the Mac's to add.

## 2026-10-19, morning -- patch 0072 on the PC: the Windows-only failures, the essentials card

The operator asked for patch 0072 to be built and tested on the PC, this round's Windows-only
failures (S-242) found product or test with evidence, the installed-build checks of S-228,
S-231, S-233 and S-234 run with real input, and, mid-way, for the essentials cards to lose the
green-ish edge they wore ("must be like Arc").

- **S-242: every failure a test fault.** Pixel reads came back transparent because on Aura a
  browser test draws nothing unless it asks (trap 113); with `EnablePixelOutput()` Windows
  draws a darkened page #121212 and captures it so. Windows labels Chromium's menu row with its
  mnemonic. The quiet install test allowed browser sign-in, which no Stedding build does, and
  Chromium's account check reached accounts.google.com there. The elision test's Space name
  fitted Segoe UI. `NumberBadgeTest` lost its keys to other tests' windows in the parallel leg
  (trap 115): it and three more run one at a time on Windows. `LocalRowLinesTest` failed only
  over SSH (trap 114); the browser keeps the host line. The S-230 unit test failed on both
  machines because its restarted mock client kept no address. The pixel waits now say the
  colour they last read.
- **The essentials card (S-243, tabs R32).** A frosted tile with no edge, white at 35% in light
  and 9% in dark; the edge had been Chromium's Material outline, which took the Space's hue.
- **Installed build.** Patch 0072 installed over beta 17 as a repair, `chrome.dll` matching the
  build. `s173-live.ps1 -Part tst9` passed every step in two minutes (S-228, S-231 and S-233
  closed). The network service runs in its sandbox, and a local development server, ws:// and
  wss:// to 127.0.0.1, a Tailscale peer by address and by name and the internet all connect
  (S-234; the PC has no Hyper-V or WSL adapter). Found: a toast covers an infobar's text (S-244).
- **Evidence.** The PC's release build of the final tree: unit 939 of 939, browser 339 of 339
  (250 four at a time, 89 one at a time). The Mac has not run the changed tests.

## 2026-10-18 night to 2026-10-19 -- installed builds, four features and the defects (patch 0072)

The operator asked for S-173's runs on installed builds, every open defect fixed, dark pages,
apps from pages, local development tabs marked as in Arc, a mark on Spaces with their own
session, a quieter Archived row and Clear line, the network service sandbox on Windows, and a
README with a feature list at the top, new pictures and an animation; then went to sleep with
"finish all".

- **Installed builds (S-173).** The Mac's signed, notarized image was dragged to /Applications
  in Finder and opened through Gatekeeper's prompt; the Windows installer repaired beta 17 in
  place (`chrome.dll` matching the build). The core loop passed every step but the first on
  both; the first found S-229 (a restored row's title lost), and a re-read of the three earlier
  dev-build runs found it there too. The runs also found S-228, S-230 to S-233, and harness faults
  fixed the same night (`docs/features/acceptance.md` Runs).
- **Defects.** S-55 closed (three launches on the PC, none restarting the network service);
  S-66 read in full on both machines (every crash of a real build ties to a fixed item); S-220,
  S-221, S-227, S-229, S-230, S-231 and S-232 fixed; S-228 decided (Windows keeps Ctrl+Esc).
- **Features (patch 0072).** Dark pages (`docs/features/dark-pages.md`), apps made from pages
  (`web-apps.md`), local development tabs (`local-tabs.md`), the session mark (`sessions.md`
  S32 to S34, `spaces.md` B38), the sidebar's quiet controls (`sidebar.md` Y27), and the Windows
  network service sandbox (`windows.md` N15). The research behind each is in the specs' notes.
- **Evidence.** On the Mac's release build of the final tree: unit 952 of 952 and Stedding's
  browser suite 442 of 442 (358 and the 84 serial) pass; one unit test added later,
  `TabRestoreServiceImplWithMockClientTest.SetWindowTabsExtraDataOutlivesTheRun`, fails (S-230).
  On the PC's release build: unit 932 of 933 and browser 412 of 422; the failures are S-242,
  and `DefaultsTest.TheNetworkServiceRunsInItsSandbox` passed. Not run this round: the checks
  and ASan builds.
- **What Chrome does that Stedding does not.** A comparison of Chrome 156's code, Chrome's
  field-trial configuration of the day and both installed browsers found, among others, that
  Chrome Stable most likely runs the Windows network sandbox off (S-234 corrected), and filed
  the rest as the next round's rows S-236 to S-241.
- **Media.** Every README still was taken again from the signed build, with stills for this
  round's features, and the animation recorded with `tooling/readme/`.

## 2026-10-18, evening -- the checks still owed (patch 0071)

The operator asked to finish every row of the BACKLOG's "Checks still owed". Each row was split
into its checks; where a check could be a test, the test goes through the user's path, and where
it found a fault, the fix came with it. What needs a real build, the PC or the owner is said in
each row. The round's code and tests are patch 0071, at the end of the series.

- The core loop (`S-173`): TST-6's script is `docs/features/acceptance.md`, thirteen steps and a
  table for the runs; TST-7's drags are browser tests in the open sidebar and in the rail; TST-8
  found a row selected before its folder collapsed still in the selection the verbs took, and ⇧⌘C
  on a split alone copying both panes; TST-9 found a window that stops being active leaving the
  ⌃⇥ run open, and the core chords go through the window as keys (shortcuts Z7).
- Spaces and their jars: a session cookie in a Space's jar comes back after a restart (sessions
  S31), a Space pin taken to another window keeps its pin and home, replaced contents come back
  from the crash bubble's Restore (`S-147`); every deletion of a Space asks first and names its
  tabs, each Settings bin is named for its Space, and another window's new or deleted Space
  reaches the title row (`S-148`); Rename Space edits in the title row, and in a small dialog on
  the rail (`S-149`); a Space's last tab leaving for another window wakes no other Space's tab
  (`S-150`).
- Restored tabs and the product path (`S-174`): the verbs on restored tabs; tests through the
  window for the command bar, isolation, archive, import, toolbar and page colour, settings,
  welcome and privacy, which found Escape leaving nothing focused, a Blank Window's isolation
  rows doing nothing, a tab archived the moment it was left and an idle time that restarted at
  every launch and stood still in a sleep, a second Arc import adding history visits again and
  missing a tab added to a known folder, the bookmark bar staying after the conversion, a loading
  tab keeping the last tab's row colour, and the width slider snapping a dragged width to a tick;
  the cut list's tests deleted with their citations; three tests that pinned a bug inverted with
  their fixes (the archive's idle time, a Markdown link's brackets, an unnamed Space's export).
- Rows seen only live (`S-128`) have their tests. They found a folder's rows touching in the
  rail, a white page's focused field and dropdown drawn #F0F0F0, the end of a reload dropping a
  white row to the window's ground, and every string that names the product reading English in
  every language: the product-name rewrite changed the English and left each translation under
  its old fingerprint, where grit no longer found it. `tooling/brand/product_name.py` moves them.
- Partial rows (`S-129`, `S-141`): tests for A8's Stay case, F17's restarts, R6's full-screen
  video, I13, B33's splits and groups (a shared group drew another Space's row again), T11 (its
  first choice read `Chromium&#39;s timing`), T27 (the sidebar's downloads button is bound to the
  action and hands a download over at once) and M9; the rail's favicons follow the density, the
  hover-expanded rail draws the essentials grid, Tab reaches Clear, and a short window cuts no row
  off.
- Full screen on the Mac (`S-154`): a tab switch re-themes the row, and a hovered rail no longer
  moves the back button. The owner reported two more, both fixed: a one-pixel line under the
  address row, macOS 26's title-bar scroll pocket (`S-223`), and the Clear line under the
  traffic lights with the row sliding in on demand (`S-224`).
- Found and fixed: `S-222`, deleting a Space that another window was showing stopped the
  browser, release builds too; `S-225`, a split whose contents a Space's own session replaced
  came back as two tabs after the crash bubble's Restore (Chromium's session helper writes
  replaced contents with no split or group); and a Space rename left open when the sidebar
  collapsed stayed open in the rail, one chip wide, which the owner saw on the screen during a
  test run (`S-149`).
- The cuts (`S-172`) are confirmed in unit tests on a mock clock; their runs on a real build are
  owed. `S-163` waits on the owner's administrator write, with its steps written.
- The owner's choices of the day: every deletion of a Space asks first; the archive's idle time
  is wall-clock time, so a night asleep counts; a deleted Space's jar is wiped at once and its
  directory goes at the next start; the command bar lists the active Space's tabs first; ⌘W on a
  pin shows a row of its Space, never an essential; the tab menu keeps its shipped order.
- Tooling: `tooling/capture-state --page` opens a chrome:// page with no input (`S-47`, closed
  earlier the same day); `tooling/drive` gains a `screen` step, the display rather than the
  window, and the bracket keys; `tooling/check-repo tests` checks partial rows and backticked
  citations of any suite the series defines; `tooling/dev`'s filters follow the deleted and new
  unit tests, and the two real full-screen tests run one at a time on the Mac.

Tests: on the Mac's release build of 156.0.8078.36 with patch 0071, 855 unit tests, 20
component tests and 248 browser tests (188 in the parallel leg, then 60 one at a time), all
passing, and the 115 tests of Chromium's tab suites. `TabStripViewLayoutTest` was in no
`tooling/dev` filter, so the round added it to `sidebar`. Seen failing against the code
without its fix: the two full-screen tests (`S-223`, `S-224`), the rename left open through a
collapse, `S-222`'s crash and `S-225`'s split; the drafted tests' predicted red runs were not
made. The Mac's full browser suite last ran before the round's last two fixes below; the
tests they touch ran again and passed.

On the PC, from the same tree, `win-release`, `win-checks` and `win-asan`: 843 unit tests on
each of the first two, all passing (run over SSH: from the PC's hidden scheduled task three
tests on mock time timed out, trap 99), and 293 browser tests on each of the three, passing
but for `SidebarFormsTest.FullScreenIsEdgeToEdge`, whose infobar container keeps its height
after its last bar goes in most Windows runs (`S-227`), and one `NumberBadgeTest` case that
failed once on `win-release` and passed alone twice. The PC found three faults the Mac had
not: a read of the page's top edge before the page painted came back transparent and the row
showed it as black, at every reload and, on the ASan build, for good in a private window
(`S-226`, fixed); the row of a pin dropped back from another window stayed under the Clear line
because the view drew it before the model filed the pin, and nothing told it after (fixed:
the model announces a pin it files from what a tab carried); and the test of the core chords
typed an "l" into the bar, the event generator's own character (trap 98). ASan (`S-106`), the series through 0070 on the PC: the unit suite clean;
in the browser suite one AddressSanitizer report, a test's own (it held the Space chips across
a theme change the page's colour brought mid-collapse; fixed in 0071), and one test that never sees a
private window's row take the page's colour on that build alone (`S-226`). A second run, on
0071's code, had no sanitizer report at all.

Checked on the Mac's release build, with the real pointer and keys: the core-loop script
three times (13 of 13), the drags of TST-7 in the open sidebar and the rail, the keys of
TST-9; the kill, the crash bubble's Restore and a relaunch; the half-typed form across a move,
an isolation change and an essential; every delete question and every rename; ⌘W on pins with
an essential in the window; the command bar's order; the tab menus of the three kinds of row;
the About page in German, French and Japanese; both full-screen looks and both full-screen
defects; S-129's looks; a sleeping tab left asleep (`S-150`). Three faults found that way:
a rename left open when the sidebar collapsed (the owner saw it on the screen during a test
run), an unnamed Space's rename field showing nothing of its name, and Settings' shortcut notes
speaking of "this round". Not done: the core loop on an installed build and on Windows, the
density, grid and short-window captures of `S-141` (tests cover them), the timed runs of
`S-172`, and the owner's items (`S-65`, `S-48`, `S-51`, `S-50`, `S-163`, the owner's day of
`S-173`, VoiceOver, Win+V). A clipboard manager (Maccy) takes ⇧⌘C from every app while it
runs, as Arc takes ⌥⌘N.

## 2026-10-18, later -- defect round

The open defects after beta 17 were researched one by one, each root cause read on the 156
tree, and fixed together in patch 0070, a round patch at the end of the series, each with its
test; the soft checks' change (ADR 0024) is patch 0069.

- Spaces and windows (`S-145`, all seven parts): an essential taken out of the essentials
  joins the Space on screen, and a Space pin made an essential stops being one (SPC-15); a
  switch from an essential lands on the Space's own tab (SPC-16); going to a tab from the
  command bar shows and wakes no other tab on the way, and going to an essential keeps the
  Space (CMD-14); a tab made active from outside the sidebar brings its Space on screen and
  so ends Focus (SPC-17); a tab dragged out, or moved to a new window, opens that window on
  its Space and keeps its jar (SPC-22; ⌘N unchanged, open for the owner, windows G6); a Space
  the session saved comes back by its id, an unnamed one included (SPC-25); the switcher
  changes form without rebuilding its chips (SPC-28). An essential matches every "@Space"
  filter in the command bar, and a tab chosen inside a collapsed folder leaves it collapsed.
- Motion: the Space being left slides out as the new one comes in, after a swipe too
  (`S-146`; the owner's own look is still owed); the rail no longer opens over the page two
  seconds after a collapse with the toggle (`S-219`).
- Pins (`S-142`): a loose tab never splits the pinned run, and another Space's rows never
  push this Space's pins under the Clear line (TAB-24); ⌘W, a row's close button and a middle
  click share one rule, and outside a normal window with Spaces ⌘W closes a pinned tab
  (TAB-25, CMD-24); a home taken before the first load is settled, once, on the page of the
  same host it landed on (TAB-26); the bookmark conversion hides the bar only when it made
  something (WEB-11). WIN-15's one-time default and a cap on the ⌘T conversion wait on the
  owner. A tab pinned while selected comes back selected after a restart, a fix in
  Chromium's own session code, so Chromium's pin had it too (`S-212`).
- The owner's choices: the Clear line shows wherever rows follow it, with no pins and in a
  private window too (`S-138`); Move to Space takes a tab out of every folder it is in
  (`S-139`, folders F37); a skipped engine step records DuckDuckGo as the choice, so
  Chromium's chooser no longer follows the welcome flow, and a second pick no longer reaches
  Chromium's choice check, which would have stopped the browser (`S-134`); on the Mac the
  split is ⌃⌘N, with Chromium's ⌥⌘N kept beside it (`S-79`); a soft check logs and writes a
  dump without crashing in a build without DCHECKs, as in an official build (ADR 0024).
- Folders and rows: Move Up and Down pass rows the user cannot see, the folder header is a
  named button that answers the left button and the keyboard, its drop highlight takes the
  sidebar's colours, and Alphabetize's order has a restart test (`S-140`); a sleeping
  favicon stays dimmed, and a hover draws nothing of its folder (`S-143`); the ⌘ numbers go
  when the window stops being active, ⌘1–9 read the badges' list, and the badges follow the
  Animate preference (`S-144`); a tab group's title and the Clear line's word draw grayscale
  text (`S-214`).
- Explained: `S-213` was the test binary's build graph, not the page: off the Mac it did not
  depend on the packed resources, so a checks build of the tests alone served a stale
  welcome page, and a `data_deps` line fixes it (not reproduced at the 156 pin: the four
  welcome tests passed three runs in three on `win-checks`). `S-218` was the Windows
  driver's arrow keys, sent without the extended-key flag (HANDOFF trap 93); with the flag,
  Ctrl+Alt+→ and ← change Space from the address bar on the release build, driven on the PC,
  and the item is closed. `S-66`: this Mac holds no report of the browser process, and macOS
  had kept nothing from before 2026-10-10; the PC's reports and the owner's machine are still
  to read. `S-55`, `S-71` and `S-72` gained notes and drafts and wait as before.
- Filed: `S-220`, an upstream unit test run on 2026-10-15 that left a profile's folders in
  the real data folder.

Tests: on the Mac's release build of 156.0.8078.36, 863 unit tests, 20 component tests and 164
browser tests (125 in the parallel leg, then 39 one at a time), all passing, and the 115 tests
of Chromium's tab suites. Each new test was run against the product code from before the round,
the tests kept: the 8 unit tests and 25 browser test runs (one test in two countries) that test
a fix failed, and the two coverage tests (S-139's keys, S-140's Alphabetize) passed, as they
should. Five tests that call what the fixes add could not be built against the old code and
were not run that way (S-139's unit test, SPC-22's, TAB-26's unit test, S-143's hover test and
S-144's badge test). With the old welcome code, a second engine pick logged Chromium's `Check
failed: choice_location != ChoiceMadeLocation::kChoiceScreen` and went on, because of patch
0069; without it that line stops the browser. On the PC the same day, with the series synced:
`win-release` 850 unit tests (three timed out in the leg and passed when run again) and the
browser suite, all passing but `SidebarFormsRtlTest.TheRightHandEdge`, flaky there (`S-221`);
`win-checks` 850 unit tests and the whole browser suite, 154 tests then 40 one at a time, with
no DCHECK, which closes `S-214`'s question. The round's hover re-check (`S-219`) stopped two
hover tests there that play the pointer, since it asks where the real pointer is; it is the
Mac's alone now, where the toggle sits past the rail, and the tests let the collapse's last
layout land first. On the Mac's release build, checked by hand with the real pointer and
keyboard: `S-219`, `S-212`, `S-79`, `S-134`, `S-138`. The Windows step of
`SpaceSwitchTest.CommandsChordsAndTheLastTab` (Ctrl+Alt+arrows from the address bar) passed on
both. Not done: the by-hand check of the other items on a real build (`S-218`'s drive on the PC
is done), VoiceOver and Narrator on the folder header, the owner's look at the slide, ASan.

## 2026-10-18 -- beta 17 released from both platforms, the first update through the feed

Google had paused Chrome 156's early rollout on 16 October, and the operator first chose to
wait for it, then, with Google's full release of 156 planned for 20 October, to release now
on 156.0.8078.36. `v0.2.0-beta.17` went out from tag commit `afdd047` (series of 68 patches):
the Mac's signed and notarized DMG first, then the Windows installer from the PC into the
same release, then `updates/appcast.xml` (`ce31bdf`), which offers it to installed beta 16
copies: the first update anyone receives through the feed (`S-74`, closed).

- **The Mac:** the release build with the version set: 855 unit, 20 component, 132 browser
  and 115 rebase tests, green with no retries; signed and notarized; `verify-build`
  (offline) passed, full screen included, and so did `syspolicy_check distribution`.
- **The PC, driven from the Mac over SSH:** the same tree. On the exact build, in the
  operator's desktop session, 842 unit tests and 124 browser tests passed, one browser test
  only on its own: a folder test that presses Ctrl+Shift+E missed the active window while
  four ran at once, and now runs one at a time (`tooling/dev`). An earlier run, with the
  session disconnected, had three Space tests out of time and three pointer tests failing;
  they passed again, the pointer tests once the operator had connected the session. The
  installer was run as the user: over the build installed for testing (a repair), an
  uninstall that kept the profile, a fresh install, the installed `chrome.dll` the build's
  each time; one launch of the installed build drew the window and opened the thank-you
  page for 0.2.0 beta 17.
- **Tried as a user gets it:** both images downloaded from the release match their
  checksums; the quarantined DMG mounts and Gatekeeper accepts its app as notarized
  Developer ID, the ticket stapled. The feed served by raw.githubusercontent.com is the
  commit's byte for byte, its signature verifies, and the downloaded image verifies against
  the feed's `edSignature`. Then a copy of the released beta 16, pointed at a test profile,
  updated itself from the real feed: the pill after about 50 seconds, the release's image
  installed at the quit, and the new version ran, notarized, with the profile's `Last
  Version` 156. The site's rebuild was triggered.
- **The browser test counts in the notes of betas 15 to 17 were the leg's two counts added
  up** ("N tests for all" and the serial ones among them): 132 on the Mac and 124 on the PC
  this time, not 165 and 158. The notes and this log say so now (trap 88).
- Not done: ASan (`S-106`), `components_unittests` on Windows, the rollback path tried for
  real (ROADMAP M7).

## 2026-10-16, evening -- the pin moves to 156.0.8078.36

The operator asked for Chromium's latest stable, `npm audit` fixed, and updates that will
also work on Windows and Linux; then, with the Mac's disk freed, for the move built on the
Mac too and checked until nothing was broken.

- **The pin and the series:** `tooling/update-pin --to 156.0.8078.36` on both machines,
  M156's newest stable-channel build that day (ADR 0007; `S-217`). The Mac's milestone sync
  wanted 100 GB free, which the operator made. `git rebase --onto` the new pin needed hand
  merges in 27 of the 68 patches, then the port to M156's rebuilt sidebar region view and the
  rest that only the compiler finds (HANDOFF trap 92); every fix went into the patch that
  owns its lines. The PC's source is the Mac's tree byte for byte, branding aside. The
  same evening, at 20:04 UTC, Google took M156's early stable to 0% on the Mac and
  Windows (156.0.8078.35 had gone to 0.5% of stable users on 2026-10-14; 156.0.8078.36,
  the pin, has been listed at 0% since then), so Chrome's stable channel serves
  155.0.8059.85 alone, and `tooling/check-pin` reports the pin as ahead of a pulled
  rollout.
- **The suites, on the exact builds:** the Mac 855 unit tests (Stedding's suites count what
  they counted on 155; Chromium's own cases in the legs went from 394 to 383), 20 component,
  132 browser and 115 rebase tests; the PC 842 unit, 124 browser and 114 rebase tests. All
  passed. On the PC's checks build (DCHECKs and the dangling-pointer detector) the unit
  tests passed, and 110 of the 124 browser tests stopped at a window's first paint on one
  DCHECK: three of Stedding's sidebar labels drew subpixel text onto M156's new content-area
  layer, which is not opaque (trap 92). With subpixel text off there, as on the sidebar's
  other rows, the run stopped only on `S-214`'s two older DCHECKs and reported no dangling
  pointer, and the suites passed again on both release builds. On Windows the same change
  takes the colour fringes off the Archived row's text, which beta 16 has too.
- **The window, against beta 16:** `verify-build` passed, full screen included. 13 window
  states captured beside a copy of the released beta 16 (`capture-state --build b16ref`:
  the sidebar at rest, three Spaces with pins and folders, Space pins, the command bar, the
  rail, light, dark and grey, the welcome flow's four steps, the new tab page) differ only
  in a throbber's frame and the shuffled engine list. Driven with the real
  pointer and keyboard on the Mac (tabs, the tab menu, the command bar, Spaces, the rail,
  full screen, a drag) and on the PC (the same, with Ctrl in place of ⌘). Stedding's own
  pages (its Settings section four screens down, Settings, About, Archived), driven through
  the address bar because `capture-state` cannot open them (trap 92), are beta 16's pixel
  for pixel, but for About's Chromium number and its update check, which only a
  team-signed build runs. A profile beta 16 made with three Spaces, an essential and nested
  folders opens in the 156 build exactly as it does in beta 16. Two faults showed, and
  beta 16 has both: Ctrl+Alt+→ does nothing while the address bar has focus on Windows
  (`S-218`), and on the Mac the sidebar sometimes slid out again after a collapse with its
  toggle (`S-219`).
- **Install and update:** on the PC the installer ran in its upgrade mode over an installed
  beta 16, a real upgrade now that the version goes from 155 to 156; the installed
  `chrome.dll` is the build's. On the Mac the released beta 16, pointed at a local signed
  feed, updated itself to the 156 build through Sparkle: the pill in about twenty seconds,
  the new version running a second after the press, the tab and the profile kept (HANDOFF,
  "The updater").
- **The network:** a fresh profile's network log, six minutes with a window, beside the
  same run of beta 16: the 156 build asked for the hosts beta 16 asks for (component
  updates, the Safe Browsing list, network time) and nothing else, Google's push service
  and account check included. Beta 16 went on to download components; the 156 build could
  not, because this Mac's firewall held its connections (trap 85). The same hold made the
  ad hoc build's quit take 10 s after a few Settings pages, which M156's new shutdown
  watchdog ends with a local dump; a Developer-ID-signed copy of the build quit in 2 s.
- **Updates on Windows and Linux:** designed, not built (ADR 0023): the browser's own
  updater on Windows after `S-72` (`S-215`), the package system on Linux (`S-216`).
- **The site:** `npm audit` is clean in `stedding.dev` (`e91d529`: sharp 0.35.5,
  source-map-js 1.2.2, smol-toml 1.9.1); the built site is byte for byte what it was, and its
  checks passed.
- **Docs:** the README and the user pages still named beta 14 and "the next release" for
  what betas 15 and 16 shipped; they name them now.
- Not done: ASan (`S-106`), `components_unittests` on Windows, notarization of a 156 build,
  a real update through the real feed (the next release is the first that can be one).

## 2026-10-16, midday -- beta 16 released from both platforms, and the first update feed

The operator asked for the round to be pushed, built and tested on Windows over SSH, and
released for both platforms. `v0.2.0-beta.16` went out from tag commit `8c5360b`, the series
of 68 patches: the Mac's signed and notarized DMG first, then the Windows installer from the
PC into the same release, then `updates/appcast.xml` (`ea37536`), the feed's first entry.
Beta 16 is the first release built with the updater, so installed copies of it find
themselves up to date; the first update anyone receives is from beta 16 to the release after
it (`S-74`).

- **The PC, driven from the Mac over SSH:** its checkout holds the same tree as the Mac's.
  The release build's suites ran in the operator's desktop session through temporary
  scheduled tasks, deleted after: 852 unit tests (the first run had two Space tests time out;
  each passed three runs in three alone, and the whole run passed again) and 124 browser
  tests. The installer was run in its upgrade mode over the beta 15 install, after a backup:
  the installed `chrome.dll` is the build's, the profile is where it was, and one launch of
  the installed build drew the window, the sidebar and the address row. The uninstall and
  clean-install modes were not run for this release.
- **The Mac:** the release build with the version set, signed and notarized; 865 unit, 20
  component and 132 browser tests on the exact build; `verify-build` (offline, without its
  full-screen check) and `syspolicy_check distribution` passed. After publishing, both
  images were downloaded from the release and matched their checksums; the DMG, marked as
  quarantined the way a browser marks a download, mounted, and Gatekeeper accepted the app in
  it as notarized Developer ID with its ticket stapled. The image itself is not signed, as
  before; the app is.
- **The feed:** `tooling/publish-appcast --push` signed the image and the feed. The copy
  raw.githubusercontent.com serves is byte for byte the commit's, its signature verifies,
  and the downloaded image matches the `edSignature` the feed gives it. The site's rebuild
  was triggered and its download page offers beta 16.
- Not done for this release: use by hand with the real pointer and keyboard on either
  platform, ASan (`S-106`), `components_unittests` on Windows, a real update through the real
  feed (the next release is the first that can be one). The pin, 155.0.8059.12, is behind the
  stable channel's 155.0.8059.85, as the notes say.

## 2026-10-16 -- Stedding updates itself on the Mac, and says thank you (patch 0068)

The operator asked for automatic updates like Arc's and for pages on stedding.dev that
thank people and ask them to sponsor the project, after the install and after each update;
they chose Sparkle 2, on by default, and both pages. Patch 0068 and ADR 0022 hold it
(`docs/features/updates.md` Up1-Up13).

- The updater: Sparkle 2.10.0 (`tooling/fetch-sparkle`) driven by the browser as its user
  driver, from a feed in this repository signed with the project's EdDSA key; "New Stedding
  Version Available" at the sidebar's foot, About, the command bar and Stedding › Check for
  Updates…; a switch in Settings › Stedding › Updates that stops every request. Only a
  team-signed bundle runs it. `tooling/publish-appcast` offers a release.
- The thank-you pages: `/thanks/` and `/thanks/updated/` on stedding.dev (the site's
  `87cfd6a`), which run no analytics and set no cookie; on the live site a browser's request
  for them gets no Cloudflare beacon while the home page's does.
- Found on the way, on the Windows checks build: patch 0067's `AltGrChords` held its window's
  widget by a raw pointer that dangled at every window's close, and crashed one test at
  shutdown in the release build two runs in four; it now holds it weakly (folded into 0067,
  trap 91). Two older failures there are filed (`S-213`, `S-214`).

- The n-1 check on the Mac (docs/HANDOFF.md, "The updater"): two copies of one build signed
  with the Developer ID, the older fed a local signed feed. Ten seconds after launch it
  fetched the feed and the image; about twenty seconds in the pill showed; a press quit it
  cleanly and opened the newer copy in its place, with the test tab back. Check for Updates…
  opened About with "Stedding is up to date". A feed edited after signing was refused before
  any download, and an image swapped under a valid feed downloaded and was not installed.
  The first live check showed the pill from edge to edge of the sidebar; it now keeps the tab
  rows' column, with a test that failed without that.
- Sparkle's helpers come signed ad hoc, which `codesign` replaces only with `--force`; the
  signer now takes those signatures off before signing them (`parts.py`).

Tests: on the Mac's release build 865 unit tests, 20 component tests and 132 browser tests;
on the PC's, from the same tree, 852 unit tests and 124 browser tests; all passing. On the
PC's checks build only the two filed failures (four tests).

## 2026-10-15, night -- the review's remaining items, and a new default favicon (patch 0067)

The operator asked for `S-179` to `S-189` to be fixed too, and for Chromium's grey default
favicon to be replaced, from Tabler's icons. Patch 0067 holds the fixes, each with a test;
the favicon is branding.

- Sessions: a Space's sessionStorage comes back after a restart and with a reopened tab
  (`S-179`, sessions S28); the crash bubble's Restore keeps a Blank Window's own Spaces and
  puts the window it joins on the Space its session showed (S29).
- Workers and notifications: a site in a Space with cookies of its own can show
  notifications at all. Chromium's permission rule for app and guest partitions had blocked
  them in every such Space; the new test found it. The window a Space's worker opens is
  made in its jar and Space, and a notification's click reaches the worker that showed it
  (`S-180`, S30).
- The rest: a restored tab's saved Space is read once (`S-181`); a pinned split sits above
  the Clear line (`S-182`); the Arc import's repeated Space and bounded reads (`S-183`); the
  welcome flow's late answer, bookmarks file and swatch (`S-184`, `S-186`, `S-187`); sleep and
  the archive spare drafts, PDFs and DevTools, and a new sleep delay re-times running timers
  (`S-185`); the archive page lists closed windows' and splits' tabs and filters by a Space's
  id (`S-187`); the WebUI handlers drop a malformed message (`S-188`); on Windows a Ctrl+Alt
  chord made with the left Alt runs on an AltGr layout (`S-189`).
- The favicon: Tabler's `world-www`, which the operator chose from ten candidates, in
  Chromium's two greys (`S-211`); seen in the dark sidebar of the Mac's build.
- Filed: `S-212`, a tab pinned while selected that the session does not keep as selected.
- The first draft added to headers much of the tree includes and cost about 11,800 build
  steps on each machine; the fixes moved into narrow headers and `.cc` files (trap 90).

Tests: on the Mac's release build, 852 unit tests, 20 component tests and 125 browser tests
(33 of them one at a time after the rest); on the PC's, from the same sources and in the
operator's desktop session, 839 unit tests and 118 browser tests (84 four at a time, then 34 one
at a time); all passing. Every new test failed with its fix taken out: two passes on the Mac,
since the crash restore's two halves and the worker's can only fail one at a time, and the
Windows chord and note tests on the PC; the AltGr digit test is a guard, which passes either
way. Not done: use by hand with the real pointer and keyboard, a real AltGr keyboard layout,
a DCHECK build, ASan. No push, no release.

## 2026-10-15, evening -- beta 15 released, both platforms from the Mac

The operator asked for a Windows build and a release of everything. `v0.2.0-beta.15` went out
from tag commit `fe36b0a`, the series of 66 patches: the Mac's signed and notarized DMG first,
then the Windows installer from the PC into the same release.

- **The PC, driven from the Mac over SSH** (the operator's yes for `win11` as `esali`): its
  checkout held 0001 to 0064 exactly (its export matched the repo's), so 0065 and 0066 went on
  with `git am`, and the export matched again; the build supervisor ran detached through WMI
  with the paths it needs set by a launcher (5 minutes, incremental). The suites ran in the
  operator's desktop session through a temporary scheduled task at normal priority (trap 67),
  deleted after: 829 unit and 145 browser tests, the row drags passing too. The new tab group
  header test failed there on its no-fill check, because the PC's pointer sat over the test
  window; the test now keeps its window away from the pointer (patch 0066), and the rerun
  passed. The installer was tested over the beta 14 install after a backup: the installed
  `chrome.dll` is the build's, the profile kept; one launch of the installed build captured.
- **The Mac:** the release build with the version set, signed and notarized, `verify-build`
  (offline) and `syspolicy_check distribution` passed; 845 unit, 20 component and 118 browser
  tests on the exact build. After publishing, both images were downloaded from the release and
  matched their checksums, and Gatekeeper accepted the app in the downloaded DMG as notarized.
- Not done for this release: use by hand with the real pointer and keyboard on either platform,
  a DCHECK build, ASan (`S-106`); `components_unittests` is not built on Windows.

## 2026-10-15, afternoon -- the review's filed items fixed, and a tab group's header (patch 0066)

The operator asked for the review's filed items, `S-201` to `S-209`, to be fixed too. Patch
0066 holds them, each with a test:

- Routing: a typed address no longer spends another app's external-open mark (`S-201`); a
  Chrome shortcut file opened from Finder opens its target as any link from another app
  (`S-202`); host routes take IPv6 literals and a scheme's default port (`S-203`).
- Keyboard and screen readers: the welcome flow keeps the focus through a redraw that changes
  the focused button's label or disables it (`S-204`); Clear is a focusable button (`S-205`).
- Data: a deleted Space's jar stays on a pending list until its wipe has finished, and the
  next window finishes a wipe a quit cut short (`S-206`); Undo keeps a tab that was in no
  tab group out of one, so its folder comes back (`S-207`); a new profile after a failed
  profile move makes its own keychain key (`S-208`).
- Tests that could not fail now can (`S-209`), three upstream HTTPS-First tests the series'
  default broke expect it, and both they and Chromium's tab group header tests run with the
  suite.
- The operator's screenshot of a test window showed an unnamed tab group as a blank bar in
  the group's colour; the header is a row now, as a folder's is: a dot in the group's colour,
  the title, or the tab count when unnamed (`S-210`, folders F36).

Tests, the Mac's release build: 845 unit tests (Chromium's tab group header tests among them),
20 component tests, 118 browser tests (33 of them one at a time after the rest), all passing. Every
new test failed with its fix taken out. No release.

## 2026-10-15 -- a code review of the whole series (patch 0065)

The operator asked for the series to be searched for bugs and the finds tested. It was read
area by area, read-only: eighteen areas, then the fixes themselves
(`docs/history/review-2026-10-15.md`). A finding counted only when it was traced in the code,
and each was read again before it was fixed or filed.

- Fixed in patch 0065, each with a test: two crashes in the tab views and the tab model
  (closing one pane of a split, or a window holding a split, `S-190`; grouping a tab inside a
  folder, which any extension can do, `S-191`), the Arc import's crash on a blocked login
  (`S-192`), a deleted Space's wipe under pages still open in its jar (`S-193`), Autofill's
  server queries (`S-194`), three command-bar faults (`S-195`), Shift on the Mac's Restore
  Folder (`S-196`), a stacked split's corners (`S-197`), the export's file name (`S-198`), a
  folder close's place lost in a sleep (`S-199`), and two tests that read a freed bar (`S-200`).
- Filed: `S-179` to `S-189` and `S-201` to `S-209`. Root causes traced for `S-71`, `S-140`,
  `S-142`, `S-144`, `S-145` and `S-146`, each with the fix and the test it needs.
- The checkout held an older 0062 and lacked 0063 and 0064; it was moved to the series with
  84 files rewritten instead of hundreds (trap 89).

Tests, the Mac's release build: 788 unit tests, 20 component tests, 116 browser tests four at
a time and 33 one at a time, all passing. Every new test failed with its fix taken out; the
split close and the grouping crashed. An earlier run of the suite, under a load average near
100 from another job on the machine, had three browser failures (the undo toast in
`AddressBandTest`, two shutdowns over 30 seconds, trap 66); each passed alone, and the last
run passed whole. No release.

## 2026-10-14, evening -- the day reviewed: a folder closed in part, a Shift-click, the tooling

The operator asked for every doc brought up to date, the day's work reviewed, its bugs fixed and
everything pushed. Four reviews read the day again: the docs, the tooling, the product code of
patch 0063 afresh, and S-137.

- `S-137` fixed: a folder that Close Folder's Tabs left open, because a tab of it is in another
  Space, takes its closed rows back in their places, whether it comes back whole or one row at a
  time from its submenu, in any order (folders F19, F20). The first design counted the tabs the
  close took as well, so a single row came back too far down; its review found that, and the
  close now records the survivors before each tab, and a row goes after them and after the rows
  of the same close already back.
- A Shift-click on Restore Folder put the first tab in a new window and the rest in the old one;
  all of them follow the first now. Both new browser tests failed on the code before the fixes.
- Tooling: `tooling/dev test browser` on the Mac would have stopped before running anything (a
  Windows-only fixture on the serial list); `check-repo`'s test parser counted tests a patch only
  showed as context (574 now, as a strict replay counts); the build-settings check requires
  `ffmpeg_branding` too; `tooling/status` sees every build folder.
- Docs: five new BACKLOG rows claimed things missing that the code has (S-145, S-153, S-164,
  S-174, S-176), and a dozen lines elsewhere were stale after the afternoon's moves; all fixed.

Tests: 764 unit tests on both Windows builds, the new ones included; each new browser test
failed on the code before its fix. The remote session was disconnected all evening, so the
browser suite ran without a desktop: everything passed but the three drag tests, which need
one, and on the checked build three cookie-jar tests failing at exit and one full-screen step,
which failed the same with the evening's code taken out (trap 59). Those were green with the
session connected that afternoon. `tooling/fold-fix` can now replace the folded patch's
message (`STEDDING_FOLD_MESSAGE`), and `STEDDING_TEST_LOG` keeps both browser legs.

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
Tests: on the final code, on both the release and the DCHECK build (DCHECKs and the dangling-pointer detector), 930 of 930 unit tests and 233 of 233 browser tests. Each new test was run against the code without its fix and failed: `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, `FolderTabsTest.AFolderRestoredFromAnotherWindowKeepsItsOrder`, `FolderTabsTest.AFolderComesBackInOrderToAShortWindow`, the shown-tab check in `FolderTabsTest.AFolderHoldingASplitComesBackWhole`, `SpaceSwitchTest.FindingTheDropTargetLightsNoChip`, `SpaceSwitchTest.AChipShowsItsNameOnce`, `SidebarFormsTest.TheRestoreBarLeavesAPagesFullScreen` and `TabDropTest.AChipRebuiltMidDragStillTakesTheDrop`. `TabDropTest.*` passed 8 runs in a row after the chip fix. Used by hand on the Windows release build: the floating Space name alone over a chip after a two-second rest, no tooltip window; the restore bar gone in F11 and in a video's own full screen and back after each; a split of a folder's two tabs inside the folder; a folder holding a split and a tab, closed, its window left shorter than its place, restored with ⇧⌘T from a second window, whole and in order, the split first and shown. The macOS build is not run (`S-178`). The 930 of 930 and 233 of 233 are that morning's counts; that afternoon, patch 0064 merged the tests named here: `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, `SpaceSwitchTest.FindingTheDropTargetLightsNoChip` and `SpaceSwitchTest.AChipShowsItsNameOnce` kept those names, `FolderTabsTest.AFolderRestoredFromAnotherWindowKeepsItsOrder`, `FolderTabsTest.AFolderComesBackInOrderToAShortWindow` and the shown-tab check in `FolderTabsTest.AFolderHoldingASplitComesBackWhole` are now `FolderTabsTest.AFolderComesBackInOrder`, `SidebarFormsTest.TheRestoreBarLeavesAPagesFullScreen` is now `SidebarFormsTest.FullScreenIsEdgeToEdge`, and `TabDropTest.TheChipUnderADraggedRowIsLit` with `TabDropTest.AChipRebuiltMidDragStillTakesTheDrop` are now `TabDropTest.ChipDropsMoveLightAndSurviveARebuild`, which calls `TheChipLightsAndGoesDark`.

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
