# Project log -- what was built, in order, with the evidence

History for orientation. Nothing here is needed to do a task: `AGENTS.md` carries what is
true now, `BACKLOG.md` the order of work, `PLAN.md` the owner's decisions.
This file was the "State of the project" section of `AGENTS.md` until 2026-09-30, moved
unchanged, and is where the dated record goes from now on: an agent opening the repo cold
should not have to read four hundred lines of rounds to learn the rules.
Entries before 2026-10-15, and the older "State of the project" and hand-over sections
that closed this file, are in [docs/history/archive.md](history/archive.md), under
"Project log before 2026-10-15".


## 2026-10-28 -- Chromium 157 prepared, not released

The owner asked for the move to Chromium 157 to be prepared and not released. Google's
schedule puts M157 on the stable channel on 2026-11-03; the series sits on 157.0.8103.31, the
stable cut, on the branch `m157` (`tooling/chromium-version` and `patches/`, pushed, not merged).
The rebase changed 69 of the 110 patches and added 0111; what M157 changed under them is
`docs/HANDOFF.md` trap 134. Reviews of the whole range-diff in four parts, each by two other
reviewers, found lost braces, colliding toast ids, a dropped default and a Windows-only link
gap before the compiler did.

- Two M157 defaults are off again in patch 0074: `kUseActionsForBrowserCommands`, under which
  no Stedding command was enabled (the keyboard, the menus and the command bar did nothing),
  and `kWebAppInstallDialog`, whose new dialog Add to Dock and Install page as app are not
  built on.
- Mac: 1287 unit, 56 component, 610 browser and 116 of Chromium's tab tests (the rebase ring)
  pass. Windows: 1283 unit and 727 browser tests pass. The full runs found the two flags above
  and four tests whose assumptions M157 changed: it pins an extension when it is installed (the
  hidden-row tests now turn that off before they load one; whether Stedding should pin is
  `S-241`'s open decision), and it makes the omnibox popup's window at its first show (the
  motion test shows and hides the dropdown once before it measures). The suites those fixes
  touch were run again on both machines; both checkouts hold the same series, tree for tree.
- A last review of every fix made in the port re-enabled the long tab menu's focus rows test
  (with Stedding's short menus off), set Chromium's test of the commands flag to Stedding's
  default and listed the withdrawn toast id; left as they are: the flags page's App Menu
  Glow Up, which would turn the action updater back on (none of Stedding's commands would
  run), and Windows' install-dialog pin flag, which needs the new dialog.
- Nine upstream tests of Chromium's own sidebar header and group focus mode, which Stedding's
  window hides, are disabled with the reason; `gn check` is `S-335`.
- Release builds of it were then checked the way a user gets them. Updates: the published
  beta 22 found the 157 build in a local feed, showed the pill (29 s on the Mac through Sparkle,
  20 s on Windows), restarted into it in about two seconds and brought its tabs back, on both
  machines. The core loop's script, with the real pointer and keys, passes every step on both.
  On the Mac the same scripts and a sweep of two dozen other features ran on beta 22 and 157:
  the captures match to the pixel but for live numbers, the About line, the order of equally
  ranked history rows and the split's tab picker, which M157 opens with its first row
  highlighted (`docs/features/acceptance.md`, Runs). The Windows test install was put back to
  the published beta 22 afterwards.

## 2026-10-27 -- 0.3.0 beta 22: GitHub issues 50, 48 and 13, pull request 49

The owner asked for issue 50 with a confirmation, issue 48, and a release. Issue 50 is patch
0110 (pins H29): on a pinned tab that is not on screen the x asks *Remove this pinned tab?*
before it unpins and closes it, with Cancel as the default; on the pin on screen it stays a
minus that sleeps the tab. A review of the patch found that the answer could
arrive after the row had changed, so Remove checks the row again first, and the question closes
with its row. Released with issues 48 and 13 and pull request 49 as
[v0.3.0-beta.22](release-notes/v0.3.0-beta.22.md), on both platforms, with both update feeds.

- Mac: 1251 unit, 56 component and 610 browser tests, all green; signed, notarized, stapled,
  Apple's distribution check passed; the downloaded image matches its checksum and the feed's
  signature.
- Windows: 1246 unit and 569 browser tests; one, `AddressBandTest.TheAddressKeepsItsPlaceWhenEdited`,
  timed out twice beside three others and passed alone twice (`S-334`). The installer went over
  beta 21, after an uninstall that kept the profile and on a clean install; each time the
  installed `chrome.dll` was the tested one, and the installed build opened a window.
- The site, the Homebrew cask and both feeds offer beta 22.

## 2026-10-27 -- Pull request 49: ⌘T on a folder's last tab (S-324), released in beta 22

An outside contributor's fix for `S-324`, checked for anything hidden or malicious first (none:
its four files are docs and two patch files, no workflow, script or binary). As sent it did not
compile (`add_types` is not in `InsertTabAtIndexImpl`) and would not have fixed the bug, since
⌘T carries `ADD_INHERIT_OPENER` too; two independent read-only reviews found the same. The
branch now marks Chromium's typed-at-end case where `AddWebContents` makes it, and the insert
keeps that tab out of the opener's folder (folders F25). Its test step fails without the fix;
the Mac's full unit and browser runs pass.

## 2026-10-27 -- GitHub issues 48 and 13, released in beta 22

The owner asked for both to be built next (BACKLOG S-325, S-321); built and checked on the
Mac, not on Windows yet, and in no release.

- Issue 48: the little window has the Copy Link button, and the toast that confirms it, which
  Chromium gives to normal and app windows alone (copy-link L7, L5;
  `CopyLinkTest.ALittleWindowHasTheButtonAPopupNone`). Seen on a release build with the real
  pointer: a link handed over with `open -a` opened a little window with the button, a click put
  the clean link on the system clipboard and the toast showed.
- Issue 13: a menu under the Space row of Settings › Shortcuts lets the Spaces and the rows
  trade ⌘1–⌘9 and ⌃1–⌃9, or moves either set to ⌃⌘ (Alt+Shift on Windows) (shortcuts Z23;
  `ShortcutOverridesTest.TheNumberKeysMoveBothSets`, `ShortcutRebindTest.TheNumberKeysMoveBothSets`,
  `ShortcutSettingsTest.TheMenuMovesTheNumberKeys`). Seen on a release build with real keys:
  with the Spaces on ⌘, ⌃1 and ⌃2 chose the rows, holding ⌘ numbered no row, and the Space chip
  read ⌘1, where the first build had kept ⌃1 (fixed in the same patch).
- The hand checks found two older defects, logged as `S-326` (a little window comes back at the
  next launch as a plain popup) and `S-327` (Copy Link's check mark shows for about a tenth of a
  second, not 1.5).

## 2026-10-27 -- 0.3.0 beta 21: GitHub issues 42 to 46

The owner asked for the open issues' bugs fixed, and for Settings to say that blocking covers
requests only. Each fix has a test that failed on the build without it.

- Issue 44, a crash on "Sign in with Google": a popup or a new window opened from a tab inside a
  folder was filed into the opener's folder, in the opener's window, which left the new window's
  strip empty, and the browser stopped at `TabCollection::GetTabAtIndexRecursive`'s NOTREACHED.
  An opener in another window is no anchor now (folders F25,
  `FolderTabsTest.AWindowAFolderTabOpensHoldsItsPage`, which crashed with the reporter's line).
- Issue 43, an empty window at every launch: on the Mac, the last window closed with its close
  button while the browser ran on, then the Dock's icon opened a new tab page and left the window
  in Recently Closed, as upstream does. With "Continue where you left off", the default, the Dock
  now brings the window back (windows G9, `DockReopenTest.TheDockBringsTheLastWindowBack`; seen
  on the release build too). The reporter's "⌘Q too" is not reproduced (BACKLOG S-323).
- Issue 42, a Space switch landing on a seemingly random tab: with the tab used last in the
  Space gone, or after a launch, the switch took the Space's first tab, often a pinned tab
  asleep. It takes the tab used most recently now (spaces B3, two `SpaceWindowTest` cases).
- Issue 46: the blocker's switch says that ads a site serves itself, such as promoted posts,
  still show until element hiding is built (blocker Bk9, Bk21).
- A crash after ⌘Y and ⌘S, reported in a comment on issue 44, did not happen on the Mac by
  hand nor in a new browser test, but the same test crashed on the Windows test machine, whose
  animations are off: with the animations off a collapse ends inside its own start, and the
  slide-out the open panel held began a second motion inside it. ⌘S now waits for the panel to
  go, the strip's slide-out reaction runs a turn later, and a motion with no animator cancels
  cleanly; the test runs with the animations on and off, and with another lock holding the
  strip out (sidebar panels Pn4, BACKLOG S-322 closed).
- The archive test that cleared a loose tab opened it from the tab on screen; with the new
  switch rule that is the folder's tab used last, so the new tab joined the folder (F25). The
  test now adds its loose tab first. It showed that ⌘T on a folder's last tab, the window's
  last, opens inside the folder (BACKLOG S-324).
- Released as 0.3.0 beta 21. Mac, release build: 1250 unit, 56 component and 608 browser tests
  pass (a restore-bar test failed once, then passed three times alone and in a second full
  run). Windows, release and DCHECK builds: 1245 unit and 567 browser tests each; the installer
  went over beta 20 and kept the profile.

## 2026-10-26, late night -- 0.3.0 beta 20

Released on the owner's word: the Settings rework, the wording pass, the Shortcuts list's remove buttons and sync that names any folder. Every Mac and Windows test passed in the release and DCHECK builds (no AddressSanitizer run); the installer went over beta 19; the feeds, the site and the cask carry it, and real updates came from beta 19 on both machines (Mac 48 s, Windows 20 s).

## 2026-10-26, night -- Settings with room

The owner on beta 19's Settings page: "Super overcrowded", and too little changed. Asked how to lay it out, the owner kept one long page with more air. Every row now has room above and below its text (rows with a menu or a slider had none), about forty descriptions are one short line each where they ran two to four, the Spaces card gave its file, sync and Arc rows to a new Sync and import card with the file's buttons under its text, and each Space names its session switch (settings T13). The build tool measured free space with df, which counts only empty blocks: it read 19 GB where Finder showed 67, and refused a build with room to spare; on macOS it now reads what Finder reads, the purgeable space the system clears on demand included (`tooling/lib.sh`). Patch 0109 amended; the settings suites pass. Not released.

Then the owner: "make sure it's perfect everywhere", and whether sync is only for the big cloud apps. Every string on the page was read again (one apostrophe, "address row" throughout, sentence-case buttons, plain names for the hover delay and Chromium's ad features, command names in Shortcuts without asides), and the Shortcuts list's remove buttons, plain grey discs for want of the icon styles, show their × again. Sync works with any folder; the row now says so, and the folders of Syncthing, Nextcloud, ownCloud, MEGA, Seafile, Synology Drive, Proton Drive, Tresorit, pCloud and Resilio no longer get the "nothing seems to sync" note (sidebar-file Sf42; patch 0106).

## 2026-10-26, evening -- 0.3.0 beta 19

The owner's word after reviewing the issues: fix the known bugs, build something new, release. Two review findings were real and fixed with tests that failed first: the Settings switch for a Space's own session turned it off at once when only apps used it, never naming them (it now asks the Space menu's question, sessions S10), and a key after a held press was taken for a peek (peek P18). Two were not defects (the archive keeps a window's last tab because it is the active one; a shared essential's Open as Tab goes to the Space that shows it, P7 now says so); one stays open (S-318, where a dormant jar's notification should open). New: "Mark pinned tabs that left their page", off by default (pins H28, GitHub issue 36), and Settings > Stedding as a card per group with the groups' names at the top (settings T13, S-313). Patch 0109, folds into 0102 and 0106. Released as 0.3.0 beta 19 on both platforms and both feeds; the site and the cask follow. The Mac's full run had one failure while a system keychain prompt held the focus (a throwaway copy without --use-mock-keychain raised it); it passed 3 of 3 alone. No AddressSanitizer run this round.

## 2026-10-26 -- 0.3.0 beta 18: the owner's round, a review by another model, then fixes

The owner's requests of the day (BACKLOG Next, S-306 to S-313). Patch 0105: the active
Space's colour reached the window as Chromium's accent and seeded its whole Material palette,
so a warm Space turned Settings, menus and toggles brown and orange; it now tints the sidebar's
ground and nothing else, the light ground is a grey (Tailwind slate-300), and the welcome page
and the README's demo lose their amber; the command bar's rows light under the pointer.
Patch 0106: the first peeks carry a one-line note on what a peek is (peek P19), the welcome's
question says the same, and sync through a folder names the folders that work and notes one
nothing syncs (issue 38's follow-up, Sf42). Patch 0107: separators in the sidebar from a row's
menu (issue 19, sidebar Y45). Patch 0108 merged 106 browser tests that each started a browser
for one short check into 37 (94 s where they took 208 s), and the Mac's browser tests run four
at a time (six were slower); the Mac's whole run is about 14 minutes, from about 21. Product
text no longer compares Stedding to another browser.

A read-only review by Grok 4.7 through Cursor's command line, in eight areas, found 19 issues:
15 fixed in the patches that own the code, each with a test seen failing first (a Shift-click
on a Space's own essential sent the first Space's cookies; a malformed Arc sidebar could build
a tree doubling at every level; the History and Downloads panels stopped at their first page;
the Peek note counted in a private window's prefs; a private window offered the history
scope's chip; a moved background tab was not the one shown; a dragged separator's band and the
right sidebar's drop arrow), one refuted, the rest logged (S-314, S-315). Released as 0.3.0
beta 18 (v0.3.0-beta.18, latest), both platforms and both feeds, the cask, the site with every
picture retaken, the README's stills; the checks are in its notes.

After the release, pushed and not released: the sidebar's row text had followed the page's
colour through the toolbar's text id, a shade off whenever a page's colour arrived, which two
Windows tests had caught (S-316; the rows now start from the toolbar's text before any page
colour). Three more reviews, of the round's new code and of the specs against the code, found
a separator lost at the second restart, a Documents Backup folder taken for a synced one, a GET
form sent in the wrong jar and a closed own essential reopened in the wrong jar, all fixed with
tests that failed first; a split test added; S-317 (which row a pin's Cmd-W and Sleep Tab show)
waits for the owner, S-318 holds three findings not yet seen through the interface. The
README's animation was not recorded again: it needs the owner's own Stedding closed.

Later the same day: S-317 decided (a pin's Cmd-W and Sleep Tab follow issue 30's rule). GitHub
issue 41: with no loose tab in the Space, a pin dropped on the New Tab row's upper half stayed
in the run, and in a Space with no pin a tab dragged to the top stayed loose (a rule meant for a
private window, which has no run). Where the list ends before the line can be crossed, the row
now takes the other side halfway between its two places; a private window still has no run.
Three tests, two failing before the fix; a tab dragged onto the empty essentials of a second
Space already worked. Issues labelled; issues 13 and 40 logged as S-321 and S-320 for the owner.

## 2026-10-25, night -- 0.3.0 beta 17: issue 38, the sidebar's foot, issue 37

GitHub issue 38 (asked to sign in to Google on Windows, not on the Mac) was a real fault.
Chromium allows browser sign-in wherever an OAuth client is configured, and Google's
`GOOGLE_DEFAULT_CLIENT_ID` and `GOOGLE_DEFAULT_CLIENT_SECRET` environment variables, which
guides for Chromium builds tell people to set, configure one. Windows apps see the user's
environment and apps opened from the Mac's Finder do not. Proven on the PC: the installed
beta 16 on a fresh profile opened Stedding's welcome, and with the two variables set for that
process it opened Chromium's sign-in screen (`chrome://intro`) instead; the fixed build opens
the welcome either way. Patch 0104 never enables browser sign-in (privacy Q16) and never opens
Chromium's first run (welcome W18). The owner's note on the sidebar's foot: History moved from
the bottom row to the end of the Archived line, the line smaller and fainter; the bottom row
keeps the downloads button and the "+" at its ends and centres the Space chips on the whole
row (sidebar Y44; spacer sizes in a FlexLayout shift the chips unevenly, so the difference is
a margin, clamped to what the row can spare). Issue 37: the command bar casts a shadow and has
a hairline edge (commandbar K36). Issues 35 and 36 ask for features and wait for the owner
(`S-304`, `S-305`); issue 14's reporter says it can be closed. The ASan pass owed from beta 16
ran clean on Windows (r119), as did both of its timing fixes; F6's crash was fixed before it.
A read of this week's folder-sync and shortcut patches found no fault.

Released as 0.3.0 beta 17 (v0.3.0-beta.17, latest), both platforms, both feeds. Checked on the
release tree: Mac 1239 unit, 663 browser and 185 one at a time; Windows release, DCHECK and
AddressSanitizer builds each 1234 unit, 624 browser and 192 one at a time, all passing. The
signed app passed Apple's distribution check and Gatekeeper from the downloaded image; on a
fresh profile it opens the welcome. The Windows installer upgraded an installed beta 16,
uninstalled keeping the profile and installed again, its `chrome.dll` the tested build's. From
the published feeds a beta 16 copy on the Mac offered beta 17 in 45 seconds; on Windows the
first try, a minute after the feed was pushed, read GitHub's cached feed without it, and the
second had it in 25 seconds and was on it after a restart. The Homebrew cask names beta 17.
The site's Rebuild workflow did not start (GitHub refused the run over the account's billing),
so an empty commit rebuilt it through Cloudflare's Git integration; stedding.dev serves beta 17,
seen from outside. On the owner's home network stedding.dev now resolves to a filter that
redirects it to a safebrowse.io warning, on both machines.

## 2026-10-25, evening -- 0.3.0 beta 16 released

The day's features and the owner's notes went out as 0.3.0 beta 16 (v0.3.0-beta.16, the
repository's latest release), both platforms, both update feeds. Before it, the last open
faults were fixed: the blocker's tests read a blocked image as loaded, and a list was fetched
twice when both came in together; the right-hand sidebar's toggle sat 3 DIP above the address
row; the History panel's next page waited on a frame, and Chromium's history handler dropped a
pending callback before its receiver (a mojo DCHECK as the panel closed mid-query); the Windows
recorder test asked a page without the focus. Checked on the release tree: Mac 1238 unit tests,
661 browser tests and 185 one at a time; Windows release and DCHECK builds 1233 unit, 622
browser and 192 one at a time, all passing. The signed app passed Apple's distribution check and
Gatekeeper from the downloaded image; the Mac feed and image signatures verify. On Windows the
installer upgraded an installed beta 15, uninstalled keeping the profile and installed again,
and an installed beta 15 found beta 16 in the real feed in 25 seconds and was on it after a
restart. The site and the Homebrew cask name beta 16. Not done: the AddressSanitizer build's
tests (running when this was written), a Mac update from the real feed on a spare install, and
the new features tried by hand.

## 2026-10-25, day -- the owner's notes on Peek and the sidebar, wave 1 built

The owner's notes after trying the Peek build, each fixed in the series:

- Peek can be turned off and tuned: Settings › Stedding › "Open a peek with" offers a click,
  a press held 0.3 s or one held 0.5 s (peek P18); with a hold, a plain click follows the link
  in the pinned tab. The welcome flow asks the same question (welcome W16).
- The sidebar's text is 14 unless the user picks another size (sidebar Y2), offered on the
  welcome flow's appearance step too (W17).
- macOS full screen with the address row hidden with a collapsed sidebar showed an empty grey
  band at the top: the row now stays in full screen (toolbar T8).

Wave 1 of the features chosen that morning (S-89, S-282 slices 1 and 2, S-96, S-118, S-156,
S-101, S-88, S-98, S-91, and the Peek review's fixes) went through its first build: compile
and lint faults fixed in their own patches. A review of S-96 and S-282 found three faults,
fixed: the right-hand reveal edge under Windows' caption buttons, older sidebar files imported
again in full, and a Space's own essentials overfilling the shared row. The test runs found more, fixed in their patches: a broken list download crashed the browser in the blocker's converter; Last-Modified read in a way that DCHECKs; tabs an import makes (unloaded) were never written to the session, so a quit soon after an import lost them; a History or Downloads panel closed with the focus in the sidebar left a rail slid out; Windows' shipped Alt binding could not be stored; the blocker's list manager and the shortcuts' watch kept pointers to Local State past its end at shutdown (every browser test of a DCHECK build failed at exit on Windows); a ThreadPool runner raised from BEST_EFFORT without a thread policy; five tests that could never pass as written (a key SimulateKeyPress drops when the page leaves it, a count of navigations, a check before the page drew its slider, a page without the focus, a test sidebar with tabs at the top). Unit tests on the Mac: 1238 of 1238. Browser tests on the Mac: all but seven: six of the blocker's (a listed image still loads, a third list request, a launch test that times out; cause not found) and the right-hand sidebar's toggle, 3 DIP above the address row. Windows (release build): unit tests all pass; browser tests all but seven: the six blocker tests and `ShortcutRecordTest.TheBrowsersKeysReachTheRecorder` (Ctrl+N during recording does not reach the page in the test; not yet understood). Windows DCHECK build: unit tests all pass; browser tests the same seven, and two History panel tests crash on a mojo DCHECK when the panel goes while a history query is still pending (Chromium's handler drops its callback first). Not seen live on either platform yet. Not released.

## 2026-10-25, morning -- Peek on by default

The owner chose Peek on by default (`PLAN.md` decision 2). A fresh profile's pinned tab now
peeks a link to another site; `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay` says so, and
the switch in Settings › Stedding turns it off. Checked: every unit test on the Mac; Peek's,
the defaults', the little window's and the pinned run's browser tests on the Mac; every unit and
browser test on Windows' release and checks builds (1040; 502, and 157 one at a time). Not
released.

## 2026-10-25, night -- Peek rebuilt on the little window

The owner's next big feature, overnight and not released (`S-93`). Peek had been switched off
since the 2026-09-26 review: its overlay laid the page out 0 px tall, and a peek loaded links
as if typed, in the shared jar. It is now a little window over the pinned tab's window, its
one tab the link's page: a whole tab, so dialogs, file choosers, permissions, the popup blocker
and the address row with the site's security state work as in any tab (peek P6). The page is
made in the pin's own jar and loaded with the link's initiator, referrer and gesture (P11), and
only the user's click from the pin on screen peeks. Its row has Open as Tab (⌘O) and Open in
Split View (⇧⌘O, beside the pin; an essential's peek offers the tab alone), which move the page
without a reload (P7, P9). Escape or a click on the window closes it, and a click that lands on
the very link does not open it again (P14). Redirect links are judged by where they lead and
sign-in pages stay in the pin (P15, P16). The old overlay and its keys are gone; the setting is
back in Settings › Stedding, still off by default (`PLAN.md` decision 2). `tooling/drive` gained
`shots`, every window of the browser captured on its own.

Using it found what the suites had passed: the peek window came up at the main window's size,
22 DIP down and right, because the window sizer sets a popup's requested bounds aside on the
Mac. Little windows had the same fault from the start, never at most 1000 × 700, and both now
set their bounds once the window is made. The peek also showed with its address field focused,
which kept Escape; it now shows with its page focused. On Windows the window can take the
activation back while a peek appears (the browser is not the foreground process there under
test), which closed the peek at once, so the first 750 ms are not a click. Peek's own tests now
click by script with the user's activation, since a synthetic mouse event never reached a page
Windows' occlusion tracker counted as covered. Ctrl+Shift+O on Windows is the bookmark
manager's chord, which a little window, and so a peek, takes for the split.

Checked: on the Mac, every unit test (1045) and every browser test (539, and 150 one at a time)
on the release build, twice; Peek's browser tests again after each fix, all eight twice in a row
at the end; and, driven through the pointer and keyboard by `tooling/drive` on a copy with its
own data folder, a peek's opening, its dialog, both buttons, ⌘O, ⇧⌘O, a click on the window,
Escape, ⌘W and full screen, and with Peek off a pin that followed its link
(`docs/features/acceptance.md`, "Peek"). On Windows, the release, checks and AddressSanitizer
builds: every unit test (1040) and every browser test (501, and 157 one at a time), but for
`S-291`'s flake once on the release build; then Peek's and the little window's ten browser tests
three times on the release and checks builds; and with `tooling\win\drive.ps1`'s real pointer
and keyboard a peek's opening, Escape, a click on the window and Ctrl+O. Not tried: a real
site's redirect and sign-in links (P15 and P16 have unit tests only), an essential's peek by
hand. The owner's questions: whether Peek is on by default (`PLAN.md` decision 2), and whether
a Space pin that joins a split keeps its place in the pinned run (splits J5, `S-102`), which
Open in Split View from a peek now meets.

## 2026-10-25, after midnight -- 0.3.0 beta 15 released

Released on the owner's word: Edit Space, the welcome flow's new look, and GitHub issues 26,
27, 29 and 30 (`docs/release-notes/v0.3.0-beta.15.md`, the first notes in the shorter shape the
owner asked for). Its passes found two faults the release build's suites had passed, both
fixed before the release: Edit Space's pair set the window's colour inside the theme's walk
down the views (the DCHECK build stopped, 32 tests), and the new test's helper read the dialog's
widget after Windows had freed it (AddressSanitizer, three reports). `S-302` is new: an
address-row test that times out now and then under AddressSanitizer. From the next release
`tooling/package-dmg` signs, notarizes and staples the disk image too (tried on a copy of this
one). Both platforms updated from beta 14, through a local feed and the real one; the site and
the Homebrew cask name beta 15.


## 2026-10-24, late -- Edit Space: any emoji, any colour, one for each look

The owner asked for people to choose their own emoji and colour for a Space, one colour or one
for each of the light and dark looks, automatic by default (spaces B41–B44, `S-99`). Edit Space
is a window of its own, from the Space menu's first row and Settings' Edit button: the icon
beside the name, then an Icon tab (any emoji typed, pasted or from the system's picker, kept
whole; thirty-six to press; No Icon) and a Colour tab (One colour or Light and dark; the twelve
colours with a deeper and a softer step; a custom picker with a hex field; the sidebar pictured
in each look, a press on one choosing the look to colour). A Space keeps the dark look's colour
in the profile's list and the session, and the window takes the colour for the look it is in,
again when the look changes. A browser-modal dialog here is 448 DIP wide and no taller than its
window allows, which is why the page is split into tabs: the first layout ran under its buttons.

Seen on the Mac's release build: opened from the Space menu with the real pointer, both tabs,
Light and dark with coral for the dark look, in the light and the dark look. Tests: the new
`EditSpaceTest.*` (five), `SpaceIconTest`, the pair in `SpaceModelTest` and `SpaceRegistryTest`;
the Mac's whole sweep green (1048 unit tests, 532 and 150 browser tests). PC: the Spaces unit tests and
74 of 75 of those browser suites passed; the 75th, `SidebarClickTest.ACloseKeepsTheListWhereItIs`,
failed at its premise as `S-291` does and passed five runs alone.


## 2026-10-24, night -- three GitHub issues fixed, the issues labelled

The owner held beta 15 for more work and asked for the GitHub issues to be read and labelled.
Three bug reports, each reproduced by a browser test that failed before its fix:

- Issue 29 (`S-298`, pins H14): a link opened from an essential, with the pinned run beginning
  with a pinned folder, stayed above the run, and every pin and pinned folder was drawn under the
  Clear line until it closed. The check for a loose tab inside the run looked only for a pin of
  the list's own level right after it.
- Issue 26 (`S-299`, tabs R63): no row could be dropped in the first place under the Clear line;
  dropped there it became a pin. The side of the line was read from the dragged rows' offset,
  zero while they follow the pointer, and worked out only when the rows changed order.
- Issue 27 (`S-300`, folders F40): a tab could go into a folder only by its header, at the end;
  a row dragged within a folder left it. A row dragged over an open folder's rows now goes to the
  place the pointer shows, with the bar there, as a folder's header already did.

Issue 30 (after a close, show the tab used before, an essential included) asked to change the
rule the owner chose on 2026-10-20 (tabs R33, R35); the owner said to change it, and it is
(`S-301`). Issue 31 (Air Traffic Control) is already there as routing (`docs/features/routing.md`),
and the owner asked the reporter what is missing. Issues 23, 24 and 14 were fixed in betas 12 and 13. The open
issues carry a type, an area, a platform where one was named, and a status; six labels were
added (five areas and "platform: macos").


## 2026-10-24, evening -- betas 13 and 14, and the welcome flow's new look

0.3.0 beta 13 (the three items below) and beta 14 went out on 2026-10-24; what they changed is
in `docs/release-notes/`. Beta 14 made the default-browser step ask with one large button
(welcome W5, the owner's ask) and gave each step a glyph (W13); `S-297`'s harness wait is
serialized on Windows, its cause still open. Arc for Windows was checked against a real
install on the PC (import I27).

After beta 14 the owner asked for a better first-run screen. The flow now opens on a welcome
screen ahead of step 1 (W14): the mark, the name, what the six steps set up, a note when Arc is
on the computer, and a drawing of the window the flow sets up, with Get started and Skip setup.
The header names the six steps over short bars (W15). The appearance step's three choices are
drawings of a Stedding window in that look, tinted by the Space colour chosen below them (W4);
the default-browser step has a drawing of a link opening in Stedding beside its button (W5);
the importer rows carry marks as the engines do (W3); every control shows an amber ring with
the keyboard focus, and the mark's arch stands large and faint behind every screen. All of it
is drawn by the page in the brand's palette; nothing is fetched.

Seen on the Mac's release build: every screen captured in both looks; the real pointer and
keyboard through Get started, step 1, the Dark choice (the flow turned dark at once) and Tab
(the ring). The welcome, import and update tests that touch the flow pass (19), the new
`WelcomeFlowTest.TheFlowOpensOnAWelcomeScreen` among them; the tests that began on step 1 now
press Get started first. The PC's release build: the same 19 tests pass, and each screen in
both looks, taken through DevTools, shows the platform's words (Ctrl chords, "this computer",
Windows' Default apps) and fits, the import step aside, which runs on under its fade (W11).


## 2026-10-24 -- after beta 12: the drag into the essentials animated, Google Pay in a Space, Arc import on Windows

0.3.0 beta 11 and beta 12 went out on 2026-10-23 and 2026-10-24; what they changed is in
`docs/release-notes/`. After beta 12, in the owner's order:

- `S-289` (GitHub issue 16, pins H27): a tab dragged across the essentials' edge is a floating
  copy under the pointer, a card over the essentials and a row over the list, and the other
  container parts where the drop would land; nothing is pinned until the drop, because a pin
  change remakes the tab's view while the drag still holds it. Two traps on the way: the copy
  on the strip was cut off at the strip's top edge (it now lies on the sidebar region), and the
  last essential dragged out collapsed the grid, which moved the list under the pointer and
  ended the drop zone (the grid now keeps its height until the drop). Seen with the real
  pointer on the Mac's release build: a first essential made from the sidebar's top row, a row
  dropped before a card, an essential dropped between two rows, a row taken up and brought back.
- `S-296` (GitHub issue 25, sessions S36): a payment app's service worker and its window live in
  the profile's jar, so Google Pay in a Space with its own session offered the shared session's
  accounts. Such a Space is now offered no payment app; `SpacePaymentsTest` failed with the fix
  turned off and passes with it.
- `S-81` (import I27): Arc for Windows' files are read from its Store package, and its passwords
  unsealed with Local State's DPAPI key and AES-256-GCM; its four Windows-only tests pass on the PC
  (1039 unit tests green). Not yet run against a real install.

Beta 13's release passes found two faults in `S-81` that the release build's suites had
passed: `ArcImportTest` placed its Arc in the Mac's folder on every platform, and on the PC's
build with DCHECKs the import looked for Arc's Store package on the UI thread, which may not
block (`ImportFromArcAsync` bound the path when it posted the read). Both fixed; the lookup is
the pool's. `tooling/fold-fix` now folds a new file into a patch. Mac: 1042 unit tests, 522 and 150 browser
tests green; PC: 1035 unit tests, 484 and 155 browser tests green, before `S-81`.


## 2026-10-23, before dawn -- the Windows update that never came, 0.3.0 beta 9 and beta 10

After beta 8 the owner asked for `S-279` to be fixed and shipped, then went to sleep until 6 a.m.
Beta 9 (patch 0078): a failed download tries again within the hour, as a feed that cannot be
reached does, not six hours later (`WinAppUpdaterTest.AFailedDownloadTriesAgainWithinTheHour`,
red before the fix, green after). Its release checks repeated the failure with Chromium's log
on: "Stedding update: The new version could not be downloaded." three minutes after the check.
`curl` fetched the same installer from GitHub in four seconds, a hand-started copy updated in
ten, and the GitHub cache and Windows Defender were ruled out (Defender logged no block; the
cache answered `HIT`). A network log of the failing run (`--log-net-log`) showed the installer's
HTTP/2 stream stall after its first 6.3 MB, the stream's window, and GitHub reset it at 180
seconds (`ERR_HTTP2_PROTOCOL_ERROR`). The difference was the check itself: it read the window
through UI Automation every five seconds, and with that polling replaced by a file check the
same copy updated in 20 seconds. The request ran at IDLE, its default, so SimpleURLLoader wrote
the file on a BEST_EFFORT sequence, which starved while the browser answered UI Automation.
Beta 10: the installer downloads at LOW (`WinAppUpdaterTest.TheInstallerDownloadIsNotLeftToIdleTime`,
red at IDLE, green at LOW); a build of the fix labelled 0.2.9-beta.1, installed and checked
through the same polling against the real feed, showed the pill in 25 seconds and restarted
into beta 9 in 2 (trap 131). The local-feed check's steady 192 seconds is likely the same
stall against a server that waits (not measured). Both `publish-appcast` scripts now fetch the published image from
the release's address and compare its checksum before they write the feed.

Beta 9's `win-asan` pass also found `AddressBandTest.EveryChipFitsTheField` timing out now and
then (`S-280`): the test showed the translate action's chip, and on the slow build the translate
controller hid it again once the page's language was known. The test now takes the zoom
action's chip, and names which action stayed hidden if one does.

Released before 6 a.m. as 0.3.0 beta 9 and beta 10. Beta 9: Mac 1042 unit and 658 browser
tests; PC 1033 and 625 on `win-release` and `win-checks`, `win-asan` all but the chip test;
the installer and the local-feed update from beta 8 (pill 192 s) passed; the Mac's real feed
showed the pill in 28 seconds. Beta 10: Mac the same suites, signed, notarized, its update from
beta 9 in 25 seconds and the real feed in 32; PC `win-checks` and `win-asan` every test,
`win-release` all but `PinnedRunTest.ADragTakesATabIntoTheEssentialsAndOut` once (five in
five alone, `S-281`); the installer and the local-feed update from beta 9 (203 seconds)
passed. Through the real feed the installed beta 9 failed to download beta 10 five minutes
after publishing, this time with no UI Automation polling, so the stall is not the polling's
alone; the fixed build, nineteen minutes after publishing and with the polling, installed beta
10 in 25 seconds. Whether IDLE was the whole cause is not proven: two fixed runs passed and the
unfixed copies failed six times in eleven, every first try after a publish among them.



## 2026-10-23, small hours -- a drag into the essentials and out, 0.3.0 beta 8

Next on the owner's plan for the night: GitHub issue 16 (`S-277`), patch 0086. As in Arc, a
tab's row dragged over the essentials, or the room above the Space's title, lights the grid
(`PinnedTabContainerView::SetEssentialsDropHighlight`), and dropped there it becomes an
essential before the card under the pointer or after the last; an essential's card dragged onto
the list shows the drop bar between the rows (`UnpinnedTabContainerView::RowDropPlaceAt`) and,
dropped, stops being an essential at that place, a tab under the Clear line or a pin of the Space
over it (`SpaceModel::SetSpacePinnedInPlace`). `TabDragHandlerImpl` keeps the pointer's last
place and decides at the drop, as the drop across the Clear line does (pins H14, H27). A first
build unpinned an essential dropped on a Space's chip: only a point over the list's own scroll
view now counts as the list (`OnTheList`).

Evidence. `PinnedRunTest.ADragTakesATabIntoTheEssentialsAndOut` (a tab dropped on an
essential's card, an essential dropped under the line and one over it) is new and runs with the
other drag tests one at a time. On the Mac's release build, with the real pointer on a copy of
the app: Notes, dragged up onto Calendar's card, lit the grid and became an essential there;
Mail, dragged from the essentials down between Music and Code, showed the bar there and became a
tab in that place. The Mac's sweep: 1042 of 1042 unit tests and, at the second run, 658 of 658
browser tests (146 one at a time). The first run failed `EssentialCardTest.ACardIsAFrostedTileWithNoEdge`
and `HoverCardPictureTest.ACardShowsItsTabsUseAfterAPause`, three runs in three alone: the
live check had left the real pointer at the sidebar's height, so a test window's plain row was
hovered and filled, and a hover card's task manager ran. With the pointer moved both passed;
`tooling/dev` now parks it on the Mac as on Windows (`tooling/park-cursor`, trap 78).

The PC, on the same series: `win-release`, `win-checks` and `win-asan` each passed 1033 unit and
625 browser tests (151 one at a time), with no DCHECK, no dangling pointer and no
AddressSanitizer report. Released the same night as 0.3.0 beta 8: the Mac's app signed,
notarized and stapled, `syspolicy_check` and `verify-build --offline` passed, and a copy of the
released beta 7 updated itself to it through a local signed feed (pill after 25 seconds,
relaunch in 1). On the PC the installer upgraded an installed beta 7, uninstalled keeping the
profile and installed fresh, the installed `chrome.dll` this build's each time; the installed
beta 7 updated itself through a local feed (pill after 192 seconds, restart in 2). After
publishing, the Mac's beta 7 copy showed the pill from the real feed in 29 seconds. The PC's
installed beta 7, launched five minutes after publishing, read the new feed 10 seconds after
launch and showed no pill in 20 minutes, with no download folder left, as beta 7's first try had
done; launched again half an hour after publishing, with Chromium's log on, it downloaded and
installed at once (pill in 25 seconds, restart in 2) and logged no failure. A failed download
waits six hours for the next check: `S-279` makes it try again within the hour and asks the next
release's check to run with the log on. stedding.dev rebuilt for beta 8 through its Rebuild
workflow.


## 2026-10-22, late night -- little windows on Windows, essentials that shrink to fit, 0.3.0 beta 7

The owner asked for little windows on Windows now and for the essentials that shrink to fit
(GitHub issue 15), to see them in the morning, and said to release, push and keep going:
"make a plan so you release stuff at night". Patch 0085. On Windows a link another app hands
over arrives with `--single-argument`; `StartupBrowserCreatorImpl::Launch` now sends it to a
little window when the setting is on and the link is not routed to a Space, or to the Space for
links from other apps otherwise, as on the Mac (little E10, routing D3; `S-56`). Ctrl+Shift+O in
a little window opens the page in a split, and the setting shows on Windows' settings page. The
little window keeps Windows' title bar: the rule that lays the caption buttons on the address
row (toolbar T19) applies to normal windows only, after the first live look showed them over
**Open in Stedding**. The essentials grid puts up to four on a row, then two rows of narrower
cards, and a third row only once a card would be narrower than the rail's square (sidebar Y33;
`S-276`).

Evidence. `LittleWindowTest.ALinkFromAnotherAppOpensSmall` (Windows) and
`SidebarRailTest.TheEssentialsShrinkToFitTwoRows` (one to eight essentials) are new. The Mac's
release build: 1042 of 1042 unit tests and 656 of 656 browser tests (145 one at a time), no
retries; on a copy of its own, three, six and ten essentials made one row of three, two rows of
three and two rows of five. The PC: `win-release` and `win-checks` each passed 1033 unit and
623 browser tests (150 one at a time), with no DCHECK and no dangling pointer; `win-asan`
passed the unit tests and 622 of the 623 browser tests with no report, the other
(`PageColourRowTest.TheRowsButtonsShowAHoverAndAPress`) running out of time once at 101
seconds and passing three runs in a row alone. The release build, handed a link as Windows
hands one, opened it in a 986 by 773 window over the main one, with Windows' title bar and
**Open in Stedding**.

Released the same night as 0.3.0 beta 7: the Mac's suites on this version, the app signed,
notarized and stapled, `syspolicy_check` and `verify-build --offline` passed, and a copy of the
released beta 6 updated itself to it through a local signed feed (pill after 25 seconds,
relaunch in 1). On the PC the installer upgraded an installed beta 6, uninstalled keeping the
profile and installed fresh, the installed `chrome.dll` this build's each time; the installed
beta 6 updated itself through a local feed (pill after 192 seconds, restart in 2). After
publishing, the Mac's beta 6 copy showed the pill from the real feed in 28 seconds. The PC's
installed beta 6 found the release on its first check, 10 seconds after launch (Local State's
`stedding.updates.newest_listed` read 156.3.0.7), but had not finished the 168 MB download from
GitHub when the check gave up at five minutes; a direct download took 75 seconds just after
(beta 6's run had shown the pill 25 seconds after launch, download included). Run again with a longer wait, it showed the pill in 20
seconds and restarted into beta 7 in 2. stedding.dev no longer calls little windows Mac-only.


## 2026-10-22, night -- after beta 5: a drag across the Clear line, the Copy Link button's hover, a session for every new Space

The owner, going to sleep, asked for every GitHub issue and the plan for the next release to be
reviewed and the bugs fixed, with the Mac's pointer and the PC free to use. The two defects
first, each reproduced in a browser test before it was touched. `S-271`: nothing decided a
tab's pin when it was dropped across the Clear line, so a loose tab dropped among the pins
stayed loose and the sidebar drew the line above it, with the run's last pin under it; a pin
dropped among the loose rows stayed a pin. A row dragged across the line now takes the pin of
the side it lands on, where it lands, and the line is drawn during the drag where the drop
would leave it (pins H14). `S-273` (GitHub issue 11): the Copy Link button's press waited, as
every page action's does, for a bubble to take the button, and Copy Link opens none, so the
press's ripple and the fill with it stayed after the pointer left; the press now ends as a
button's does (copy-link L7). Both went into patch 0083, which owns both. Then the setting
promised on issue 8, `S-274`: "Give every new Space its own session", off by default, which
asks whether the Spaces that share the session should have their own too (patch 0084,
sessions S35, settings T29). Issues 14, 15 and 16 arrived after the handoff: the address
field that moves on focus is the field as specified, and essentials that shrink and a drag
into the essentials are features, so all three wait for the owner (`S-275` to `S-277`).
`tooling/check-pin` says the pin is behind: Windows' stable channel serves 157.0.8103.15 and
156.0.8078.49 to 0.5% of users (`S-278`).

Evidence. The new tests failed before their fixes (`PinnedRunTest.ARowDraggedAcrossTheLineTakesThePinThere`:
the dropped tab loose, the last pin under the line; `CopyLinkTest.TheButtonLetsGoOfItsHoverAfterAClick`:
the ink drop held at its pending state with the pointer gone) and pass after, with
`SettingsSpacesTest.EveryNewSpaceCanHaveItsOwnSession` and `SpaceRegistryTest.ANewSpaceTakesTheOwnSessionSetting`.
On the Mac's release build, with the real pointer on a copy of the app: a loose tab dragged
between two pins joined the run there, every pin over the line; a pin dragged among the loose
rows left the run; the Copy Link button lit under the pointer, showed the check mark after a
click and had no fill once the pointer left; the new setting asked "One Space still shares the
session ... One open page reloads ...", Turn On for All gave the Space its own session, and a
Space made with "+" came with one. The Mac's release sweep on the series: 1042 of 1042 unit tests and 653 of 653
browser tests (143 one at a time), no retries. On the PC, on the series before the setting's
wording fix (two strings of patch 0084 and its test's expectation): `win-release` and
`win-checks` (DCHECKs and the dangling-pointer detector) each passed 1033 unit tests and 619
browser tests (148 one at a time), with no DCHECK and no dangling pointer. `win-asan` passed the unit tests and every browser
test but one, with one AddressSanitizer report: a heap use after free in the new Copy Link
test, which held the button's ink drop while the button made a new one (its background is set
again after the click); the test now asks for it each time (patch 0083), and the product had no
report. On the final series the PC passed again: `win-release` 1033 unit and 619 browser
tests, and `win-checks` and `win-asan` the round's suites (`CopyLinkTest.*`,
`SettingsSpacesTest.*`, `PinnedRunTest.*`), with no report. The rerun under ASan then found the
new Copy Link test failing at its first step: the button makes its ink drop again when the
address row takes the page's colour, late on that build, and the new one did not know it was
hovered; and on the Mac 7 runs in 25 of it clicked a neighbour, another page action having
moved the button along the field after the load. The test now moves the pointer off and on
until the button is lit and takes the button's place at each step: `CopyLinkTest.*` passed
200 runs on the Mac, and on the PC under release, checks and twice under ASan, with no report.
Released the same night as 0.3.0 beta 6, on the owner's word ("push and release 0.3.0 beta 6
on the current pin, full cycle on both platforms"): the Mac's suites again on this version
(1042 unit, 653 browser), the app signed, notarized and stapled, `syspolicy_check` and
`verify-build --offline` passed, and a copy of the released beta 5 updated itself to it through a
local signed feed (pill after 25 seconds, relaunch in 1). On the PC, with the owner's yes to
quit the Stedding open there, the installer upgraded an installed beta 5, uninstalled keeping the
profile and installed fresh, the installed `chrome.dll` this build's each time; the installed
beta 5 updated itself through a local feed (pill after 192 seconds, restart in 2). After
publishing, both real feeds offered it: the Mac's beta 5 copy showed the pill in 32 seconds, the
PC's installed beta 5 in 25 and restarted into beta 6. stedding.dev serves beta 6, with a line
on the new setting. The PC's Stedding, quit for the installer test, is installed at beta 6 with
its profile; it was not started again.

`tooling/drive` refused every point on the Mac: a waiting notification keeps a window of
Notification Centre over the whole screen on macOS 27; the harness now lets through what is
not on the notifications' stack (trap 130).

## 2026-10-22, day -- the owner's round after beta 4, GitHub issues 8 and 11, 0.3.0 beta 5

The owner, awake, read two GitHub issues and listed what beta 4 got wrong. Patch 0083 carries
all of it as one round. Issue 11, a Copy Link button: Chromium's own Copy Link action as a page
action before the star, Option-click for Markdown, a setting to hide it (copy-link L7). Issue 8,
essentials per Space: the owner chose essentials of a Space's own only in a Space with an
Independent session, which then shows only those (ADR 0028); they stay in its session, a
restart puts them back, turning the session off makes them its pins, and the warning that
pinning signed a tab out is gone with its setting. Then the list: a close no longer jumps to the
most recent row when that row is scrolled out of view (tabs R33), a long list scrolls past its
last row by half its height (sidebar Y30), a tab dragged onto another Space's chip and held
there switches to that Space, Arc's way (spaces B12), a folder goes into another by its header
(folders F39), folders never look grey (tabs R7), a link's tab opens just below its page with
the indent off by default (settings T26), a pin sent home shows its home's title at once and a
pin made on the New Tab page takes its first page as home (pins H1, H3), and a link from a tab
in a folder nested in a pinned folder no longer unpins the folder (folders F38, which the owner
reported mid-round). Last, the hover card's resource line: after 2 seconds on a tab, its
memory, CPU and network rate, read every second (pins H25).

Three new browser tests hung or failed on the first run, all in the tests: a settle wait inside
a `RunUntil` check, a settle loop that laid out twice per frame right after a row moved into a
nested folder (the rows toggled between two heights and never settled, where at a frame's pace
they settle in 200 ms), and a Space's slide on its layer that no wait covered (HANDOFF trap
127). The real build, driven on a scratch copy, then showed two faults no test had: after a
wheel scroll, a hover card still waiting to show came up for a row the list had carried away,
pinned to the list's top edge (pins H26), and the row carried away kept its hover while the row
under the pointer had none (sidebar Y31). Both are fixed, each with a test that fails without
the fix.

The owner then asked for GitHub issue 12, a hover state on the New Tab row (sidebar Y32),
built the same day. The Windows runs found three more things. With the PC's monitor off,
Windows ran at 1024×768 and the sidebar tests failed across suites (HANDOFF trap 128); the
owner signed in over a remote desktop and the reruns came clean. A remote desktop also turns
animations off, and the checks and AddressSanitizer builds then crashed in a tab group test:
`TabGroupView` declared the callback a finished animation runs after the layout manager whose
installation can finish one at once, so it read the callback before constructing it (patch
0071, BACKLOG S-269, `FolderTabsTest.AGroupMadeWithAnimationsOffShowsItsRows`). And the new
scroll-room test asked Windows for an offset past the list's end, which Windows does not clamp
at once. The owner also asked for fewer documents: the release notes and the finished history
moved into two archives and six small documents into the ones they belong with (129 Markdown
files to 97), and nothing of the owner's own profile or machines stays in the docs or pictures.

How it was checked: the release notes of 0.3.0 beta 5 give the runs on both machines.

0.3.0 beta 5 was published that afternoon on both platforms, with both feeds, and both real
feeds checked from beta 4. Afterwards: stedding.dev gained /arc/, "Moving from Arc", for Arc's
shutdown on December 22 (the site's own repository); BACKLOG `S-270` plans Widevine, so
Netflix and the like can play, which waits on the owner's licence application to Google; and
`docs/VISION.md` records the Arc-style field after the sunset notice, with the next round's
recommended order in BACKLOG's "Next".

## 2026-10-22, night -- the owner's three open decisions, the folder header for Narrator, 0.3.0 beta 4

With the owner asleep and asking for every open item to be decided or skipped, the three
decisions the backlog had held for the owner were made, each the way its recommendation said:
⌘N opens on the Space it is pressed in (windows G6, S-145); Settings → Stedding → Tabs shows
the bookmark bar and the star again after Turn Bookmarks into Pinned Tabs (settings T27,
WIN-15's option B, S-142); and that command asks first above 50 bookmarks, naming how many it
would add (import I16, S-142). Patch 0081 carries them, each with a browser test.

S-140's Windows side was checked without real input, through UI Automation on the installed
beta 3: the folder header is a named, focusable button with Expand and Collapse, the pattern
Windows gives a control that reports itself expanded or collapsed in place of Invoke. Collapse
failed: the header answered only the press VoiceOver sends, so Narrator could not open or close
a folder. It now answers both (folders F4, folded into patch 0070, with a unit test).
UI Automation's SetFocus leaves the focus on the page for the header and for a tab row alike,
Chromium's rule for its tabs.

S-257, the browser test whose shutdown overruns 30 seconds on a busy Mac, was traced in the
code: every saved log says no task was running, so the wait is on a task queued and never
started, and Stedding posts none of the kind a Mac test reaches. Patch 0082 has the Mac's test
builds print every thread's stack when it happens again.

The Mac's sweep then failed one drag test five times in five: the S-252 guard added the night
before had moved the test's window under the machine's resting pointer, at the screen's right
edge. With the window kept clear of that pointer instead it passed every time; the test now
does that (patch 0077). The Mac's update check from beta 3 first showed no pill: the operator's
own Stedding had downloaded an update and was waiting to install it, and Sparkle, which names an
install in progress by bundle id, sent the test copies to that install instead of a check; the
copies now get a bundle id of their own (`docs/HANDOFF.md`, trap 124). A Windows-only compile
error (`near` is a macro there, trap 125) in the test's first version was fixed before the
Windows drag runs. 0.3.0 beta 4 carries 0081, 0082 and the fixes, with every suite green on the
Mac and on the three Windows builds, both installers' checks and both updaters from beta 3.

## 2026-10-22, small hours -- the checks after beta 2, and 0.3.0 beta 3

After beta 2 the Windows suites were run again in full with the one-at-a-time list fixed (green
on the release and checks builds), and AddressSanitizer was built and run, which beta 2's
notes had said was not. It found no memory error, but two page-colour tests timed out on its
slow build. One waited for a late read that had already run (a test fault; the test now starts
the read itself). The other showed a real fault: a read of the page's top edge that found no
surface to copy yet, as a page just shown on a slow machine can, was dropped with no retry, and
with nothing else due the row kept the page's declared colour, both parts of a split in two runs
of five. Reads that find no surface, or whose copy fails, are now tried again (toolbar T31,
`PageColourRowTest.AReadWithNoSurfaceYetIsTriedAgain`, failing without it). S-252 did not
reproduce with each rail row put under the real pointer by moving the test's window; the move
stays in the test. The defects still open were brought up to date: what is left is the owner's
decisions or checks that need real input or hardware. 0.3.0 beta 3 carries the fix, with every
suite green on both platforms and AddressSanitizer clean.

## 2026-10-21, night -- child tabs, the owner's Arc import checked, 0.3.0 beta 2

The owner asked, before sleeping, for every bug and check that could be done, child tabs, and a
release by morning. Child tabs came in patch 0080 (tabs R56-R59, settings T26): a link opened in
a new tab, or a page's own window, sits a level under the page it came from, the tree survives a
restart and a closed parent's children move up. Seen on a real build through DevTools, a window
opened by a page in the background nested under the tab on screen, which Chromium names as the
opener; the page that called `window.open` is the parent now, with a test. A test of the tree
across a restart had failed only because a background tab not yet loaded is not in the session
file at all. Checking a real Arc import (S-48) by reading copies of both profiles found
everything there but two folders of folders, which came out a level up; fixed in 0080 too.

The Mac's sweep of the release build passed but for one browser test that overran its 33
seconds once (S-257). On Windows, two tests that need the desktop to themselves failed only
when run four at a time and passed alone, and joined the one-at-a-time list; the checks build
had no DCHECK and no dangling pointer. Both installers, the Windows installer test and both
updaters from 0.3.0 beta 1 passed, and 0.3.0 beta 2 was released with 0078, 0079 and 0080.

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

- **The PC, driven from the Mac over SSH** (with the operator's yes): its
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
(`docs/history/archive.md#the-code-review-of-2026-10-15`). A finding counted only when it was traced in the code,
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
