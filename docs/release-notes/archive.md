# Release notes archive

Notes of earlier releases, newest first. Each release's page on GitHub carries the same notes and its downloads.

## Stedding 0.3.0 beta 20

Settings that breathe. On Chromium 156.0.8078.48.

### Changed

- **Settings › Stedding, tidied.** Every row has room around it and says what it does in one
  short line. Export, sync and the Arc import have a card of their own, **Sync and import**,
  and each Space names its **Independent session** switch.
- **Sync through a folder works with any folder** your computers share: iCloud, Dropbox,
  Syncthing, Nextcloud, a network share. The note that a folder seems unsynced no longer
  shows for Syncthing, Nextcloud, ownCloud, MEGA, Seafile, Synology Drive, Proton Drive,
  Tresorit, pCloud or Resilio folders.

### Fixed

- The Shortcuts list showed a grey disc beside every key instead of its remove button.

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.20-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.20-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
30c48338ac0a78d88a603ec0c8e563cb4a1bc880f038ca5df0b626267612bb6d  Stedding-0.3.0-beta.20-arm64.dmg
78a183c4064a38cb3bf2ef80235563e90815e548aaf9a54cfe6e34cde19574ab  Stedding-0.3.0-beta.20-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1248 unit and 56 component tests; 605 browser tests,
and 150 one at a time) and on Windows, in the release build and the build with DCHECKs (each
1243 unit tests; 565 browser tests, and 156 one at a time): all passed. The AddressSanitizer
build was not run this round. The new Settings page was looked over in the built app, every
card and every line. Apple's distribution check passed the signed app, and Gatekeeper accepted
it from the downloaded image. On Windows the installer went over an installed beta 19, after an
uninstall that kept the profile, and the installed program is the one the tests ran. From the
published feeds, a copy of beta 19 on the Mac offered this version 48 seconds after launch, and
an installed beta 19 on Windows had it 20 seconds after launch and was on it after a restart.

## Stedding 0.3.0 beta 19

Settings in cards, a quieter essential, and pinned tabs that drag where you expect. On
Chromium 156.0.8078.48.

### New

- **Settings › Stedding in cards.** Sidebar, Tabs, Peek and little windows, Spaces, Pages and
  menus, Privacy, Updates and Shortcuts each have a card, and their names at the top of the
  page jump to them.
- **Mark pinned tabs that left their page**, in Settings › Stedding › Tabs and the command
  bar. It is off: an essential that moved away from its page no longer shows a dot or a reset
  button. **Reset to Pinned Page** stays on the tab's menu (#36).

### Fixed

- With no tabs under the pinned ones, a pinned tab dragged onto the New Tab row stayed pinned.
  Now it leaves the pinned tabs (#41).
- In a Space with no pinned tabs, a tab dragged to the top did not become pinned (#41).
- Turning off a Space's own session in Settings did not ask when only apps used it, and never
  named them. It now asks the same question as the Space's menu.
- With **Open a peek with** set to a held press, a press held to select text followed by
  Enter on a link opened a peek.
- The sidebar's text shifted a shade when a page's colour arrived.
- A separator could vanish after the second restart.
- A form that sends its search in the address went out with the wrong Space's cookies.
- An essential of one Space, closed, came back in another Space.
- **@Space** in the command bar listed another Space's own essentials.
- Folders and split views offered separator items they cannot use.

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.19-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.19-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
7e60b9533d3ffda16f73b036c500f7aa112c458591b0774e763ff0b84d455d08  Stedding-0.3.0-beta.19-arm64.dmg
76a0be430965cc0229ae79388768bd2000a5e18fb265070db71c027099153ba0  Stedding-0.3.0-beta.19-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1248 unit and 56 component tests; 605 browser tests,
and 150 one at a time) and on Windows, in the release build and the build with DCHECKs (each
1243 unit tests; 565 browser tests, and 156 one at a time). On Windows all passed. On the Mac
one keyboard test failed once while a system prompt held the focus, and passed three times of
three on its own. The AddressSanitizer build was not run this round. Each fix has a test that
failed before it. Apple's distribution check passed the signed app, and Gatekeeper accepted
it from the downloaded image. On Windows the installer went over an installed beta 18, after an
uninstall that kept the profile, and the installed program is the one the tests ran. From the
published feeds, a copy of beta 18 on the Mac offered this version 71 seconds after launch, and
an installed beta 18 on Windows had it 20 seconds after launch and was on it after a restart.

## Stedding 0.3.0 beta 18

Separators in the sidebar, a calmer palette, and Peek that explains itself. On Chromium
156.0.8078.48.

### New

- **Separators.** Right-click a tab or a pinned tab in a Space and choose **Add Separator
  Above** to draw a faint line over it; **Remove Separator** takes it away (#19).
- **Peek explains itself.** The first peeks carry a one-line note: what a peek is, that
  **Open as Tab** keeps the page, and a link to its setting. The welcome's question says the
  same.

### Changed

- **A neutral palette.** A Space's colour tints the sidebar and nothing else: Settings, menus
  and the command bar keep neutral colours. The light look's ground is a soft grey.
- **The command bar's rows light up under the pointer.**
- **Sync through a folder names the folders that work**: one iCloud Drive, OneDrive, Dropbox
  or Google Drive keeps. Settings says so when the chosen folder is not one of them (#38).

### Fixed

- A link Shift-clicked on an essential that belongs to one Space opened with another Space's
  cookies.
- The History and Downloads panels could stop at their first page.
- A tab moved to another Space from its menu is now the tab you see there.
- In a private window the command bar no longer offers to search your history.
- A malformed Arc sidebar file could freeze the import.

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.18-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.18-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
d9eb16f659424cdbd584b0d33de5fa68c5e82ae2f7edeba1c2640c6e644424ca  Stedding-0.3.0-beta.18-arm64.dmg
d313bb40a55edebd9b863c286079919ec1a1c2446e7fa58cac7ada87db938d66  Stedding-0.3.0-beta.18-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1244; 598, and 149 one at a time) and on Windows, in
the release build, the build with DCHECKs and the AddressSanitizer build (each 1239 unit tests;
558, and 155 one at a time). Under AddressSanitizer all passed; the release build failed one
test and the DCHECK build three, and run again all but two passed. Those two caught the
sidebar's text colour shifting a shade when a page's colour arrives, which comes next
(`S-316`). A review of the code by another model found 19 issues: 15 are fixed here, each
with a test seen failing first. Apple's distribution check passed the signed app, and
Gatekeeper accepted it from the downloaded image. On Windows the installer went over an
installed beta 17, was uninstalled keeping the profile and installed again. From the published
feeds, a copy of beta 17 on the Mac offered this version 75 seconds after launch, and an
installed beta 17 on Windows had it 25 seconds after launch and was on it after a restart.

## Stedding 0.3.0 beta 17

No Google sign-in prompt on Windows, a tidier sidebar foot, and a command bar you can see on
white pages. On Chromium 156.0.8078.48.

### Changed

- **An even sidebar foot.** History moves up to the end of the Archived line, which is now
  smaller and quieter. The row below has Downloads at one end, **+** at the other, and your
  Spaces centred between them.

### Fixed

- Stedding on Windows no longer asks you to sign in to Google at the first start (#38). It
  happened on computers with Google's OAuth environment variables set. Stedding has no
  browser sign-in; signing in to Google's websites works as before.
- The command bar has a shadow and an edge, so it stands out over a white page (#37).
- Moving focus with F6 could crash on Windows.

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.17-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.17-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
e7fa67f2a643bf87d994362b3ff1e5f11797489fdf67e9a27971eed95832a6f2  Stedding-0.3.0-beta.17-arm64.dmg
b81f2a275c617b8cc2c4ff13c0bcb99c2eaa08dc1bb4938e17622ee42feba0a6  Stedding-0.3.0-beta.17-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1239; 663, and 185 one at a time) and on Windows, in
the release build, the build with DCHECKs and the AddressSanitizer build (each 1234 unit tests;
624, and 192 one at a time). On Windows an installed 0.3.0 beta 16 opened Google's sign-in on a
fresh profile with the OAuth variables set, and this build opens the welcome with or without
them. Apple's distribution check passed the signed app, and Gatekeeper accepted it from the
downloaded image. On Windows the installer went over an installed 0.3.0 beta 16, was
uninstalled keeping the profile and installed again. From the published feeds, a copy of beta 16
on the Mac downloaded this version and offered it 45 seconds after launch, and an installed
beta 16 on Windows had it 25 seconds after launch and was on it after a restart.

## Stedding 0.3.0 beta 16

Peek you can tune, History and Downloads in the sidebar, the sidebar on the right, links
without trackers, and shortcuts you can change. On Chromium 156.0.8078.48.

### New

- **Peek, your way.** Settings › Stedding › **Open a peek with**: a click, or a press held for
  0.3 s or 0.5 s, so a plain click opens the link in the pinned tab. Or turn Peek off. The
  first start asks too.
- **History and Downloads in the sidebar**, searchable, where the tab list is (⌘Y, ⌥⌘L on the
  Mac; Ctrl+H, Ctrl+J on Windows).
- **The sidebar on the right**, from Settings, the sidebar's menu or the command bar.
- **Links without trackers.** `utm_` and similar tracking parameters come off the links you
  open; sites you name keep theirs.
- **Shortcuts you can change** in Settings › Stedding › Shortcuts.
- **Site controls in the page's info panel**: copy the link or title, mute, camera and
  microphone, clear the site's data.
- **Import from Dia and from Safari's export file**, and **Export all Spaces** in one file.
- **Sync the sidebar through a folder you pick** (iCloud Drive, OneDrive, a network share),
  with no account and no server.
- **Ad and tracker blocking**, off until you turn it on in Settings › Stedding › Privacy.
- The sidebar's text is 14 unless you choose another size; the first start offers the sizes.

### Fixed

- The sidebar width slider no longer jumps while you drag it (#34).
- Pinned tabs stay above the Clear line while you drag a tab over a folder (#33).
- In macOS full screen, a hidden address row no longer leaves an empty grey band at the top.
- Tabs brought in by an import or a sync are kept when you quit straight after.

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.16-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.16-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
680382034385734511d4efb539585e73755d9ecd9fd5c4aa92e54b146843bed8  Stedding-0.3.0-beta.16-arm64.dmg
d899db904f44ac08ffb0c079e75788c49d27fb00fdf0547c94b74ca131cf13b3  Stedding-0.3.0-beta.16-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1238; 661, and 185 one at a time) and on Windows, in
the release build and the build with DCHECKs (1233; 622, and 192 one at a time). Apple's
distribution check passed the signed app, and Gatekeeper accepted it from the downloaded image.
On Windows the installer went over an installed 0.3.0 beta 15, was uninstalled keeping the
profile and installed again; an installed beta 15 then found this version in the published
feed and was on it after a restart.

## Stedding 0.3.0 beta 15

Any emoji and any colour for your Spaces, a friendlier first start, and four sidebar fixes.
On Chromium 156.0.8078.48.

### New

- **Edit Space.** Right-click a Space and choose **Edit Space…** (or **Edit** in Settings ›
  Stedding › Spaces) to give it any emoji and any colour: one colour for both looks, or one
  for light and one for dark.
- **A new first start.** A welcome screen, the steps named along the top, and pictures to
  choose light or dark from.

### Fixed

- A tab can be dropped above the first tab in the list; it turned into a pin (#26).
- A tab can be dropped at any place inside an open folder, not only on its header (#27).
- A link opened from an essential no longer pushes your pinned tabs below the Clear line (#29).
- Closing a tab goes back to the tab you used before, an essential included (#30).

### Install

- **macOS** (Apple silicon, macOS 13 or later): `Stedding-0.3.0-beta.15-arm64.dmg`, signed and
  notarized. Open it and drag Stedding to Applications.
- **Windows** (10 and 11, x64): `Stedding-0.3.0-beta.15-win-x64.exe`, installs for you alone.
  It is not signed yet: in SmartScreen click **More info**, then **Run anyway**, once.

Installed copies update themselves (Mac from 0.2.0 beta 16, Windows from 0.2.0 beta 19).

### Checksums (SHA-256)

```
0430359553b029c327c32b4fbb69ed702207710db79f12e3dd7d0b993294ed0d  Stedding-0.3.0-beta.15-arm64.dmg
9343d416a167646e7d44a1ee650fb58863cd0ac297d1d2ad3b5dc9027afbac83  Stedding-0.3.0-beta.15-win-x64.exe
```

### Known limits

- The Windows installer is unsigned (`S-56`).
- Netflix, Disney+ and Spotify's web player do not play yet (`S-270`).
- Chromium 156's built-in list of sites that must load over HTTPS lapses on 13 December 2026;
  a release on a newer base comes before then.

### How it was checked

Every unit and browser test on the Mac (1048; 532, and 150 one at a time) and on Windows, in
the release build, the build with DCHECKs and the AddressSanitizer build (1043; 494, and 157
one at a time), but for one address-row test that times out now and then under AddressSanitizer
(`S-302`). Apple's distribution check passed the signed app. The installer went over an
installed 0.3.0 beta 14, and on both platforms beta 14 updated itself to this version, first
from a local signed feed, then from the real one.

## Stedding 0.3.0 beta 14

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). A first start that asks plainly to be your default browser.

### What changed since 0.3.0 beta 13

- **The first start asks to be your default browser, plainly.** Its fifth step had a small
  "Set as default" button on an otherwise empty page. It now has one large button, **Make
  Stedding my default browser**, under a line saying what it does (the links you click in mail,
  chat and other apps open in Stedding) and over a line saying how the system answers and that
  you can change it back. Once Stedding is the default, the button says so, with a check.
- **Each step of the first start has its own icon** beside its title, and a wider Next button.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (87 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1044 of 1044 unit
  tests and 523 of 523 browser tests (150 of them one at a time after the rest), with no
  retries, among them `WelcomeFlowTest.TheDefaultStepAsksWithOneLargeButton` (the button's
  words, its size against the footer's Next, the state once Stedding is the default, and a
  glyph on each of the six steps) and the rest of the welcome flow's suite.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 13, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, showed **New Stedding Version Available** 29 seconds after launch; a press of it
  relaunched the copy as this version within a second.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 13, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 26 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1039 of 1039 unit tests and 485 of 485 browser tests (157 one at a time
  after the rest), the welcome flow's among them; its six steps, captured through DevTools,
  show the new default-browser button and the step glyphs.
- The build with DCHECKs and the dangling-pointer detector: 1039 unit and 485 browser tests,
  with no DCHECK and no dangling pointer.
- The AddressSanitizer build: 1039 unit and 485 browser tests, with no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 13 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 13, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 26 seconds after launch; pressing
  it (through UI Automation) restarted into this version, About reading 0.3.0-beta.14 and up to
  date.
- After it was published, through the real feed: the installed 0.3.0 beta 13 found this
  version on GitHub, showed the pill 25 seconds after launch and restarted into it, About
  reading 0.3.0-beta.14 and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.14-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.14-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.14-arm64.dmg
97ab9a9f98bcd3bfaf3afcefd82c0da698458376bac56811e81cb57466dd21b2  Stedding-0.3.0-beta.14-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.14-win-x64.exe SHA256
c3bd9b245e4f91a7c8ac253ba3bb509dc3f9e35fdf49d6425969b2d2343ec8e6  Stedding-0.3.0-beta.14-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 13

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). A drag into the essentials that shows where the tab goes, Google Pay kept
out of a Space with its own session, and Arc's sidebar, history and passwords on Windows.

### What changed since 0.3.0 beta 12

- **A tab dragged into the essentials becomes a card on the way.** Drag a tab's row up over the
  essentials and it turns into a card under the pointer; the other cards move apart to show
  where it will land, and the list closes up behind it. Drag an essential down onto the list and
  it turns into a row, and the rows part to make room for it, as in Arc (GitHub issue 16). Until
  now the essentials lit up and a thin bar marked the place in the list. With no essentials yet,
  drag a row up to the sidebar's top row to make the first one.
- **Google Pay stays out of a Space with its own session.** The window Google Pay opens to pay
  always used the browser's shared cookies, so a checkout in a Space with its own session
  offered the Google account signed in elsewhere (GitHub issue 25). A Space with its own session
  is now offered no payment app, and the site falls back to its own checkout.
- **Import from Arc on Windows.** Arc's Spaces, essentials, pinned tabs, folders, tabs, history
  and passwords now come across on Windows too, from the welcome flow, Settings or the command
  bar's **Import from Arc**, when Arc for Windows is installed. The passwords are read with your
  Windows account's own key, so nothing asks. This is new, and was checked against a real Arc
  for Windows install, its history and a saved password included; tell us if anything is
  missing.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (87 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1044 of 1044 unit
  tests and 522 of 522 browser tests (150 of them one at a time after the rest), with no
  retries.
- Each change's own test: `PinnedRunTest.ADraggedTabTurnsIntoACardAndBack` (the card under the
  pointer and the room made for it, the row hidden and the list closed up; the row in line with
  the rows, the rows parted and no bar; dragged back, the copy gone and the row drawn again),
  with `PinnedRunTest.ADragTakesATabIntoTheEssentialsAndOut`;
  `SpacePaymentsTest.ASpaceWithItsOwnJarIsOfferedNoApp`, which failed with the fix turned off
  ("the Space was offered the shared jar's payment app"); and the Arc importer's tests, among
  them `ArcDataImporterTest.UnsealsAValueSealedOnWindows` and
  `ArcDataImporterTest.ReadsLoginsSealedOnWindows`.
- On the release build, with the real pointer: a row dragged up to the sidebar's top row with no
  essentials became a card under the pointer and the first essential; a row dropped on the first
  quarter of an essential's card landed before it while the cards parted; an essential dragged
  between two rows became a row there while the rows parted, with no bar; a row taken up over the
  essentials and brought back stayed a row.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 12, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, showed **New Stedding Version Available** 29 seconds after launch; a press of it
  relaunched the copy as this version within a second, on the "Updated" thank-you page.
- The full suites above ran again on this release's final series after the last fix, with the
  same results, and the image, its signature and its notarization were made from that series.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 12, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 29 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1039 of 1039 unit tests, among them the Arc importer's four Windows-only
  tests (Arc's key in Local State unsealed with DPAPI, its folder found in its Store package),
  and 484 of 484 browser tests (155 one at a time after the rest).
  `ArchiveUnreadSessionTest.AQuitsWindowAnUnreadSessionLeftIsArchived` timed out once in an
  earlier pass of this release and passed in this one; run alone three times it passed twice
  and once hung at its process's exit (`S-297`).
- The build with DCHECKs and the dangling-pointer detector: 1039 unit and 484 browser tests,
  with no DCHECK and no dangling pointer. An earlier pass of it found the Arc import looking for
  Arc's Windows package on the UI thread, which may not wait on the disk; that is fixed in this
  release.
- The AddressSanitizer build: 1039 unit and 484 browser tests, with no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 12 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 12, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 26 seconds after launch; pressing
  it (through UI Automation) restarted into this version within five seconds.
- After it was published, through the real feed: the installed 0.3.0 beta 12 found this
  version on GitHub, showed the pill 20 seconds after launch and restarted into it in 2
  seconds, About reading 0.3.0-beta.13 and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.13-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.13-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.13-arm64.dmg
3980d2f0e3d7cf380f0a09801227ebe0b151dcb83e1f01c17554d7cadf3415f5  Stedding-0.3.0-beta.13-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.13-win-x64.exe SHA256
09b0cbf738eea40a1c045f877b12b481d98b996fb7584c7f9057d908dade008b  Stedding-0.3.0-beta.13-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 12

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). An address field that is one shape in every state, a tab drag that
leaves the address row alone, and a "Continue where you left off" bar that closes.

### What changed since 0.3.0 beta 11

- **The address field is the whole row in every state.** Hovered, the field's tint ran from
  the address to its right edge, while focus and the suggestions took the whole row (GitHub
  issue 14). The field now spans the row hovered, focused, edited and with its suggestions
  open, and a click anywhere in it, its empty left part too, puts you in the address, which
  still keeps its place. That empty part used to move the window; the window still moves from
  the gaps between the buttons, the edges of the row and the sidebar's top row.
- **A tab drag leaves the address row alone.** Since beta 11 a dragged tab no longer opens
  first, but while it was dragged the address row's site button, its Copy Link and star
  buttons, its colour and the back and forward buttons showed the dragged tab. They now stay
  with the page on screen until the drop.
- **"Continue where you left off" closes.** Its close button, and any other infobar's
  between the address row and the page, was taken by the window as part of its title bar, so
  a click there did nothing and the bar came back at every start (GitHub issue 24). It
  now closes, and it shows Stedding's mark instead of Chromium's logo, as the browser's other
  prompts do.
- **The site button looks at rest when it is.** With only its icon, it no longer sits in a
  grey circle that read as a hover; with its text, "Not Secure", it keeps its pill.
- **"Not Secure" is centred.** Its warning sign sat lower than its text; both are now on the
  pill's middle.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (87 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 520 of 520 browser tests (150 of them one at a time after the rest), with no
  retries.
- Each fix's own test failed on the code before it and passes now:
  `TabDropTest.APressWaitsAndADragKeepsThePage` (now checking the address row's address, chip,
  page buttons, colour and back button mid-drag; before, the row described the dragged tab),
  `AddressBandTest.TheFieldIsWholeInEveryState` (before, the field's empty part was the title
  bar) and `SidebarFormsTest.TheRestoreBarClosesFromItsButton` (before, the window took the
  close button's press). `AddressBandTest.AChipCentresItsIconAndText` holds the chip's icon and
  text inside it on its middle; before, its icon was laid out 24 DIP tall in a 21 DIP chip.
- On the release build, with the real pointer: an unloaded tab dragged past the one on screen
  left the address row as it was, before, during and after the drag; a click on an infobar's
  close button closed it; hovered and focused, the field's tint and ring ran across the whole
  row, and a click on its empty left part focused the address, which kept its place; the site
  button alone had no circle at rest, and "Not Secure" measured on its pill's middle.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 11, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, showed **New Stedding Version Available** 25 seconds after launch; a press of it
  relaunched the copy as this version within two seconds, on the "Updated" thank-you page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 11, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 28 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1035 of 1035 unit tests and 482 of 482 browser tests (155 one at a time
  after the rest).
- The build with DCHECKs and the dangling-pointer detector: 1035 unit and 482 browser tests,
  with no DCHECK and no dangling pointer. The AddressSanitizer build: every unit and browser
  test, with no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 11 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 11, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 26 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds, About reading "Stedding
  0.3.0-beta.12" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 11 found this
  version on GitHub, showed the pill 20 seconds after launch and restarted into it in 2
  seconds, About reading 0.3.0-beta.12 and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.12-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.12-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.12-arm64.dmg
5de6afaf3b11e8f90ae50def021fccf6c0bf8b30d3ac64d04d5cc432062645b6  Stedding-0.3.0-beta.12-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.12-win-x64.exe SHA256
b254da9d74866c3a1414ce3b4b03a615e8008fda732674f66042d0dc4e340bdb  Stedding-0.3.0-beta.12-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 11

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Essentials that take their clicks again, an address that keeps its place,
a tab drag that leaves the page alone, new tabs at the top as a setting, and twelve Space
colours.

### What changed since 0.3.0 beta 10

- **Essentials take their clicks again.** Since the essentials became one row of cards (0.3.0
  beta 7), that row sits beside the address row, where the window treated a press as a drag of
  its title bar: a click on a card in the top row moved the window and never opened the card,
  and with a single row none of them worked (GitHub issue 23). Every card, row and button
  there now takes its own press; the empty part of the strip there is still the title bar.
- **The address no longer jumps when you click it.** At rest the address sits centred on the
  page; a click into the field moved it to the field's left edge (GitHub issue 14). It now
  keeps its place while you edit it, until what you type no longer fits.
- **Pressing a tab to drag it no longer opens it first.** A press on a tab that is not on
  screen now waits: let go and it opens, as a click; drag it and the page on screen stays
  there for the whole drag. Dropped back in the list, or into the essentials, the tab moves and
  the page you were on stays; dropped on the page, it makes the split as before. Before, the
  dragged tab's page showed until the pointer reached the page.
- **New tabs at the top, if you like.** Settings › Stedding › Tabs › **Open new tabs at the top
  of the list** opens Cmd-T and + New Tab right under + New Tab, above your older tabs, so the
  pinned tabs stay in view (GitHub issue 22). Off by default.
- **Twelve Space colours.** Spaces now choose from twelve colours instead of five: Slate, Plum,
  Green, Clay, Rose, Blue, Violet, Teal, Coral, Indigo, Pink and Cyan, taken from Radix Colors
  and Tailwind's palettes. A Space that had one of the old five colours takes its new neighbour
  of the same hue, and a Space imported from Arc takes the colour nearest its theme's hue.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (87 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 517 of 517 browser tests (149 of them one at a time after the rest), with no
  retries.
- Each fix's own test failed on the code before it and passes now:
  `SidebarFormsTest.TheSlidOutSidebarsEssentialsTakeTheirPress` (the essentials' press was the
  title bar's), `AddressBandTest.TheAddressKeepsItsPlaceWhenEdited`,
  `TabDropTest.APressWaitsAndADragKeepsThePage` and `PinnedRunTest.NewTabsOpenAtTheTopWhenAsked`.
- On the signed app, with real pointer and keys: a tab pressed and dragged above the one on
  screen moved there while the page stayed on example.com throughout; a click into the address
  left it where it was; a click at the top edge of an essential's card opened its page; with the
  new setting on, Cmd-T opened its tab under + New Tab; the Space menu offered the twelve
  colours. While a tab is dragged, the address row's security chip and page buttons show the
  dragged tab's state, and come back at the drop (`S-290`, not fixed in this release).
- The update itself, from the release people have: a copy of the released 0.3.0 beta 10, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, showed **New Stedding Version Available** 28 seconds after launch; a press of it
  relaunched the copy as this version within a second, on the "Updated" thank-you page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 10, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 29 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1035 of 1035 unit tests and 478 of 479 browser tests (154 one at a time
  after the rest). In the serial leg `SidebarClickTest.ACloseKeepsTheListWhereItIs` failed once
  at its premise (the list had not scrolled to the 31st tab), then passed five runs in five
  alone and in the build with DCHECKs (`S-291`).
- The two pinned-run drag tests failed on every run that evening, with another application's
  window maximized over the screen: the drag's search for the window under the pointer passed
  over the test's window, which the system's occlusion tracker still counted covered, so the
  tab tore off and the drag cancelled. The test helper now takes its window out of that count
  (`S-281`, closed); with it the pinned-run tests, the press-and-drag test and the horizontal
  strip's passed twice over, 50 runs without a failure. The browser itself did not change.
- The build with DCHECKs and the dangling-pointer detector: 1035 unit and 479 browser tests,
  with no DCHECK and no dangling pointer. The AddressSanitizer build: every unit and
  browser test, with no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 10 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 10, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 26 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds, About reading "Stedding
  0.3.0-beta.11" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 10 found this
  version on GitHub, showed the pill 25 seconds after launch and restarted into it in 2
  seconds, About reading 0.3.0-beta.11 and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.11-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.11-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.11-arm64.dmg
9c9d774d08f257c037195d3dd8ea7429166f7c19e0a5ca62942c13aa7cc9648e  Stedding-0.3.0-beta.11-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.11-win-x64.exe SHA256
a61e976d777435d3ab561d59db0a866d34af1f11f1f743d7553d85f70ab8a069  Stedding-0.3.0-beta.11-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 10

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). The Windows updater no longer stalls while the browser is busy.

### What changed since 0.3.0 beta 9

- **Windows: updates download while the browser is busy.** The update's download ran at the
  lowest priority, so while something kept the browser busy, such as a tool reading the window
  through UI Automation, it stopped after its first 6 MB and GitHub ended it three minutes
  later; the next try came six hours later (an hour since beta 9). It now downloads at normal
  priority. The release checks of 0.3.0 beta 7, 8 and 9 found it, each time the first update
  through GitHub failed. A screen reader reads the window the same way and has not been tried
  with this yet. The Mac is not affected.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (86 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 658 of 658 browser tests (146 of them one at a time after the rest), with no
  retries.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 9, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within two seconds, on the "updated"
  thank-you page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 9, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 32 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The fix's own test, `WinAppUpdaterTest.TheInstallerDownloadIsNotLeftToIdleTime`, failed with
  the download at IDLE and passes at LOW, with the other 16 updater tests.
- The fix where it failed: a build of it labelled 0.2.9-beta.1, installed and checked the way
  beta 7, 8 and 9 had failed (UI Automation reading the window every five seconds), found
  0.3.0 beta 9 on GitHub, showed the pill 25 seconds after launch and restarted into it in 2.
  Before the fix the same check had failed five times in seven that night.
- The release build: 1033 of 1033 unit tests and 624 of 625 browser tests (151 one at a time);
  the other, the drag of a tab onto an essential's card, timed out once at its first drop and then
  passed five runs in five alone, and in both builds below (`S-281`).
  The build with DCHECKs and the dangling-pointer detector: 1033 unit and 625 browser tests,
  with no DCHECK and no dangling pointer. The AddressSanitizer build: every unit and
  browser test, with no AddressSanitizer report, the chip test that timed out in beta 9's
  run among them (`S-280`, fixed in this release's tests).
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 9 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 9, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 203 seconds after launch (beta 9
  still downloads at the old priority); pressing it (through UI Automation) restarted into this
  version in 4 seconds, About reading "Stedding 0.3.0-beta.10" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 9, which still
  downloads at the old priority, found this version five minutes after publishing and its
  download failed, even with no UI Automation reading its window; it tries again within the
  hour. The fixed build labelled 0.2.9-beta.1, checked nineteen minutes after publishing with
  UI Automation reading its window, installed this version, showed the pill 25 seconds after
  launch and restarted into it in 2, About reading 0.3.0-beta.10.

### Install

#### macOS

`Stedding-0.3.0-beta.10-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.10-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.10-arm64.dmg
c0a9000a0ad8b562b2d90e829d922d9d4cefec99165bd03822834ada6255adaf  Stedding-0.3.0-beta.10-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.10-win-x64.exe SHA256
3cb424fe083d8aa61d052cef53b9ee58e98e6c7752c2d11ccf85f384916b424f  Stedding-0.3.0-beta.10-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 9

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). One fix to the Windows updater.

### What changed since 0.3.0 beta 8

- **Windows: a failed update download tries again within the hour.** Right after the last two
  releases were published, the first update checks on Windows found the new version but did not
  install it (most likely its download was refused so soon after publishing), and then waited
  six hours to check again. A download that fails now tries again
  within the hour, as a check that cannot reach the update server already did. The Mac is not
  affected.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (86 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 658 of 658 browser tests (146 of them one at a time after the rest), with no
  retries.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 8, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within a second, on the "updated" thank-you
  page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 8, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 28 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The fix's own test, `WinAppUpdaterTest.AFailedDownloadTriesAgainWithinTheHour` (a download
  refused once, then the next check within the hour installs), failed before the fix and passes
  with it, with the other 15 updater tests.
- The release build: 1033 of 1033 unit tests and 625 browser tests (151 one at a time), with no
  retries. The build with DCHECKs and the dangling-pointer detector: the same, with no DCHECK
  and no dangling pointer. The AddressSanitizer build: every unit test and 624 of the 625
  browser tests, with no AddressSanitizer report; the other, a check that every chip fits the
  address field, timed out waiting for two page-action buttons to show, and run alone three
  times it passed twice and timed out once (a test race on that slow build, `S-280`).
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 8 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 8, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 192 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.9" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 8 found this version
  on GitHub, but its download stalled and failed three minutes later, with Chromium's log on:
  "Stedding update: The new version could not be downloaded." That was the fault 0.3.0 beta
  10 fixes (`S-279`): it happened while the check read the window through UI Automation, and
  with that reading replaced by a file check the same copy installed this version in 20
  seconds and restarted into it in 2.

### Install

#### macOS

`Stedding-0.3.0-beta.9-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.9-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.9-arm64.dmg
64a51f27db21d474e06f3cc9591641500f364901cdab9e324acdbbc8e84ddc59  Stedding-0.3.0-beta.9-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.9-win-x64.exe SHA256
69ce8e7eec0c5d6fef9616b70abc60e370cf41746641248e7678ac78d27cb326  Stedding-0.3.0-beta.9-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 8

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). A tab now goes into the essentials, and out, by a drag.

### What changed since 0.3.0 beta 7

- **Drag a tab into the essentials, and out.** As in Arc, a tab dragged up over the essentials
  lights them, and dropped there it becomes an essential, before the one it was dropped on or
  after the last; several selected tabs go together. An essential dragged down into the list
  shows the line where it will land and stops being an essential there: under the Clear line it
  is a tab, above it a pinned tab of the Space. Before, it took the tab's menu. Asked for in
  GitHub issue 16.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (86 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 658 of 658 browser tests (146 of them one at a time after the rest), with no
  retries. A first run failed two hover tests because a live check had left the real pointer
  over the place test windows open; `tooling/dev` now moves it aside first on the Mac too.
- The release build used with a real pointer, on a copy of its own: a tab dragged up onto an
  essential's card lit the essentials and became an essential there; an essential dragged down
  between two tabs showed the line there and became a tab in that place.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 7, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within a second, on the "updated" thank-you
  page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 7, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 29 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1033 of 1033 unit tests and 625 browser tests (151 one at a time), with no
  retries. The build with DCHECKs and the dangling-pointer detector, and the AddressSanitizer
  build: the same, with no DCHECK, no dangling pointer and no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 7 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 7, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 192 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.8" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 7 found this version
  on GitHub, showed the pill 25 seconds after launch and, pressed, restarted into it in 2
  seconds with its tabs back, About reading 0.3.0-beta.8 and up to date. A first try, five
  minutes after publishing, read the new feed but showed no pill in 20 minutes, as beta 7's
  first try had (`S-279`).

### Install

#### macOS

`Stedding-0.3.0-beta.8-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.8-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.8-arm64.dmg
72e186f6172b2390fc2385b46e90172e70818141e88d569104b82206a424dd0a  Stedding-0.3.0-beta.8-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.8-win-x64.exe SHA256
5b203129263ba014126cdc8b41cafd3330796600d28e637611493849d0e79934  Stedding-0.3.0-beta.8-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 7

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Little windows come to Windows, and the essentials make room for more.

### What changed since 0.3.0 beta 6

- **Little windows on Windows.** A link you open from another app (mail, chat, a document)
  opens in a small window of its own, as on the Mac and as in Little Arc, when Stedding is your
  default browser. **Ctrl+O** moves the page into your main window, **Ctrl+Shift+O** into a
  split, and **Escape** closes it. Settings → Stedding → **Open links from other apps in a small
  window** turns it off, and a site with a rule in Settings → Stedding → Spaces still opens in
  its Space. On Windows the little window keeps Windows' own title bar.
- **Links from other apps go to their Space on Windows too.** Settings → Stedding → Spaces →
  **Open links from other apps in** now applies on Windows, as it did on the Mac.
- **Essentials make room for more.** The essentials grid puts more on a row before it takes
  another row, as Arc's does: up to four sit on one row; past four they make two rows of
  narrower tiles (five make three and two, eight make four and four), and a third row comes
  only when a tile would get narrower than the sidebar's rail. Before, it was two to a row
  however many you had, so eight essentials took four rows. Asked for in GitHub issue 15.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (85 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 656 of 656 browser tests (145 of them one at a time after the rest), with no
  retries.
- The release build used on a copy of its own with three, six and ten essentials: one row of
  three; two rows of three; two rows of five.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 6, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within a second, on the "updated" thank-you
  page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 6, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 28 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1033 of 1033 unit tests and 623 browser tests (150 one at a time), with no
  retries. The build with DCHECKs and the dangling-pointer detector: the same, with no DCHECK
  and no dangling pointer. The AddressSanitizer build: every unit test and 622 of the 623
  browser tests, with no AddressSanitizer report; the other, a check of the address row's
  colour over a grey page, ran out of time once and passed three times in a row when run
  again on its own.
- The release build on a scratch profile, handed a link the way Windows hands one from
  another app: the link opened in a small window of its own over the main one, with Windows'
  title bar and **Open in Stedding** beside the address.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 6 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 6, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 192 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.7" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 6 found this version
  on GitHub, showed the pill 20 seconds after launch and, pressed, restarted into it in 2
  seconds with its tabs back, About reading 0.3.0-beta.7 and up to date. A first try, minutes
  after publishing, had found it 10 seconds after launch but not finished downloading it in
  the five minutes the check waits.

### Install

#### macOS

`Stedding-0.3.0-beta.7-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.7-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.7-arm64.dmg
9c4381831a1db2e3c69225d466146361dc82c73682a2f60c796c44f1578316a3  Stedding-0.3.0-beta.7-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.7-win-x64.exe SHA256
49bc8ac849fa911558782c83abe265b39c0a961db8388bc47ff9c75d193913fb  Stedding-0.3.0-beta.7-win-x64.exe
```

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). The little window keeps Windows' title bar; the
  two-finger Space swipe changes one Space when the fingers have gone far enough, without the
  Mac's list that follows them, and has not yet been tried on a real touchpad
  (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 6

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Two fixes from beta 5 and a setting asked for in GitHub issue 8.

### What changed since 0.3.0 beta 5

- **Every new Space can have its own session.** Settings → Stedding → Spaces → **Give every
  new Space its own session**: a Space you add from then on keeps its own sign-ins, cookies and
  essentials, as if you had turned on **Independent session** for it. Turning the setting on
  asks whether the Spaces you already have should get their own too, and says how many open
  pages would reload; **New Spaces Only** leaves them as they are. Each Space's own switch
  still changes it. Off by default. Asked for in GitHub issue 8.
- **Dragging a tab into the pinned tabs pins it.** A tab dragged from under the Clear line up
  among the pinned tabs becomes a pinned tab where you drop it, and the pinned tabs around it
  stay pinned; dropped on the line itself, it joins the end of the pinned tabs. A pinned tab
  dragged down among the other tabs stops being pinned. The line moves during the drag to show
  where the tab will land. Before, the dragged tab stayed unpinned and the last pinned tab
  showed under the line.
- **The Copy Link button lets go of its highlight.** After a click, its round highlight stayed
  on with the pointer gone; it now fades as the pointer leaves. Reported in GitHub issue 11.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (84 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build: 1042 of 1042 unit
  tests and 653 of 653 browser tests (143 of them one at a time after the rest), with no
  retries.
- The release build used with a real pointer, on a copy of its own: a tab dragged between two
  pinned tabs joined them there, every pinned tab above the line; a pinned tab dragged below the
  line stopped being pinned; the Copy Link button lit under the pointer, showed its check mark
  after a click and had no highlight once the pointer left; the new setting asked about one
  Space with one open page, **Turn On for All** gave that Space its own session, and a Space
  added with "+" came with one.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 5, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within a second, on the "updated" thank-you
  page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 5, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 32 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build: 1033 of 1033 unit tests and 619 browser tests (148 one at a time), with no
  retries. The build with DCHECKs and the dangling-pointer detector: the same, with no DCHECK
  and no dangling pointer. The AddressSanitizer build: the unit tests and every browser test but one, with one
  AddressSanitizer report, in a new test (it held an object the button makes again); the test
  was fixed, and this round's suites then passed under it twice, with no report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 5 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 5, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 192 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.6" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 5 found this version
  on GitHub, showed the pill 25 seconds after launch and, pressed, restarted into it in 2
  seconds with its tabs back, About reading 0.3.0-beta.6 and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.6-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.6-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.6-arm64.dmg
abe6ebe9550a96b10614a05023ce765eee7c640cddfb152745adeeced31e73c5  Stedding-0.3.0-beta.6-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.6-win-x64.exe SHA256
7a30699f11b3aeaefc4482502cd06791d227cfc4426d3438380ea17128c4c711  Stedding-0.3.0-beta.6-win-x64.exe
```

The macOS image is 179.3 MB and the Windows installer 168.1 MB, both built on 2026-10-22 from
the series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-270`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 5

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Three requests from GitHub issues, a tab's use in its hover card, drags
that were missing, and fixes to the sidebar the owner asked for after beta 4.

### What changed since 0.3.0 beta 4

- **A Copy Link button.** At the address field's right end, just before the star: a click
  copies the page's link without its tracking parameters, as ⇧⌘C (Ctrl+Shift+C) does, and an
  Option-click (Alt-click on Windows) copies it as a Markdown link. Settings → Stedding → Pages
  and menus → **Show the Copy Link button** hides it. Asked for in GitHub issue 11.
- **What a tab uses, in its hover card.** Rest the pointer on a tab: after 2 seconds its hover
  card shows, at its foot, how much memory, CPU and network the tab is using, read again every
  second while the card stays, or "Asleep" for a tab asleep. Nothing is measured until then.
- **Essentials of a Space's own.** In a Space with an **Independent session**, a tab you add to
  the essentials is that Space's own: it stays signed in with the Space's session, and it shows
  in that Space alone, which shows only its own essentials. Turn the session off and they become
  the Space's pinned tabs; delete the Space and they go where its tabs go. Elsewhere essentials
  are shared by every Space, as before. The warning that pinning such a tab signed it out, and
  its setting, are gone: there is nothing left to warn of. Asked for in GitHub issue 8.
- **The New Tab row lights up under the pointer.** The "+ New Tab" row at the top of the list
  takes the tab rows' hover and pressed look, so it reads as a button. Asked for in GitHub
  issue 12.
- **Drag a tab to another Space.** Drag a row onto another Space's icon in the row at the
  bottom of the sidebar and hold it there for half a second: the window switches to that Space,
  the tab comes along, and you drop it where you want it in that Space's list, as in Arc. A drop
  on the icon, or beside it, moves the tab there at once, as before.
- **Folders into folders.** Drag a folder by its header onto another folder's header to put it
  inside, or between the rows of an open folder to put it there. A nested folder's header drags
  too, out of its folder or into another.
- **Closing a tab no longer jumps the list.** After a close, Stedding shows the tab you used
  before it only while its row is in view; when that row is scrolled out of the sidebar, it shows
  the tab below instead, so the list stays where it is. It scrolled to the tab used before, often
  at the top.
- **Room below the last tab.** A list taller than the sidebar now scrolls past its last row by
  half its height, so the last tabs can come up from the bottom edge.
- **A pinned tab goes back to its page.** Closing a pinned tab sends it back to the page it was
  pinned with, and its row now shows that page's title at once; it kept showing the last page's
  until the tab was opened again. A tab pinned on the New Tab page takes the first page it opens
  as its home, so it has one to go back to.
- **A link's tab opens just below its page.** A link opened in a new tab sits right below the
  page it came from, at the same depth; it was drawn a level to the right, which read as a
  move. Settings → Stedding → Tabs → **Show tabs under the tab that opened them** brings the
  indent back.
- **Folders no longer look grey.** A folder's header keeps its colour whatever its tabs do;
  after a relaunch, which loads only the tab on screen, every folder had looked asleep.
- **A crash with animations off.** With reduced motion on, or over a remote desktop
  connection, a tab group's header dragged out of the window and back could crash the browser.
- **A link from a pinned folder keeps the folder pinned.** A link opened from a tab inside a
  folder that sits in a folder of the pinned tabs left the new tab in that folder and so unpinned
  the whole folder. The new tab now goes to the top of the tabs under the line, as from any pin.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (83 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build of this version:
  1041 of 1041 unit tests and 650 of 650 browser tests (143 of them one at a time after the
  rest), with no retries.
- The release build used with a real pointer and keyboard, on a copy of its own: the Copy Link
  button, a 40-tab list scrolled past its end, the hover card's line ("15.7 MB · CPU 0% · 0
  B/s" on an idle page), a close with the earlier tab out of view, a pinned tab sent home, a
  row held on another Space's chip, and the New Tab row's hover. Two faults found there are
  fixed in this release: after a wheel scroll, a hover card still waiting to show came up for
  a row the list had carried away, and that row kept its hover.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 4, with a
  bundle id of its own and pointed at a local signed feed offering a Developer-ID-signed copy of
  this build, fetched it and showed **New Stedding Version Available** 25 seconds after launch;
  a press of it relaunched the copy as this version within a second, on the "updated" thank-you
  page.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed (its network check left out, `--offline`); Apple's `syspolicy_check distribution`
  passed it, and it is notarized and stapled.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 4, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 28 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build, the build with DCHECKs and the dangling-pointer detector, and the
  AddressSanitizer build, each run in the operator's desktop session: 1032 of 1032 unit tests
  and 616 browser tests (148 one at a time) on each, with no retries, no DCHECK, no dangling
  pointer and no AddressSanitizer report. The checks and AddressSanitizer builds found the tab
  group crash above, now fixed. One new test failed on all three: it scrolled to an offset past
  the list's end, which Windows does not clamp at once; it now scrolls to the end, and
  `SidebarClickTest.*` then passed 22 of 22 on each.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 4 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 4, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 26 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 3 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.5 · Chromium 156.0.8078.48" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 4 found this version
  on GitHub, showed the pill 25 seconds after launch and, pressed, restarted into it in 2
  seconds with its tabs back, About reading 0.3.0-beta.5 and up to date. Its first try, two
  minutes after the feed was pushed, saw no update: GitHub serves the feed with five minutes'
  cache.

### Install

#### macOS

`Stedding-0.3.0-beta.5-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.5-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.5-arm64.dmg
650f90b266e88e54d04a1f9d8c509f428fcce4c89ef6a7715a0b682ae585addb  Stedding-0.3.0-beta.5-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.5-win-x64.exe SHA256
11fe3cf92ab6b0d8fd20bb19b92db0b7d269a8d7315dd92758b8ce310597e70d  Stedding-0.3.0-beta.5-win-x64.exe
```

The macOS image is 179.3 MB and the Windows installer 168.1 MB, both built on 2026-10-22 from
the series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 4

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Three choices that had waited for a decision, and a fix for screen
readers on Windows.

### What changed since 0.3.0 beta 3

- **⌘N (Ctrl+N) opens on the Space you are in.** A new window shows the Space of the window
  you pressed it in, as a window a tab is dragged or moved to already did. It always opened on
  your first Space. A window opened with no window to come from, such as the Dock's New Window
  with none open, still shows the first.
- **A way back to the bookmark bar.** After **Turn Bookmarks into Pinned Tabs** the sidebar
  stands for your bookmarks, and the bookmark bar and the star are hidden; until now there was
  no way to bring them back. Settings → Stedding → Tabs → **Show the bookmark bar and the
  star** turns them on again in every window at once; the bar then follows **Show bookmarks
  bar** as in Chrome.
- **Turn Bookmarks into Pinned Tabs asks first above 50 bookmarks.** Each bookmark becomes a
  pinned tab, so a large collection became hundreds of rows with one command. Above 50 it now
  names how many it would add, counting only those not already pinned, and waits for **Turn
  into Pinned Tabs** or **Cancel**. Up to 50 it converts at once, as before.
- **Folders with Narrator on Windows.** A screen reader on Windows opens and closes a folder
  through UI Automation's Expand and Collapse, which the folder header turned down, so Narrator
  could not open or close a folder. It now can. Found by a UI Automation check of beta 3's
  folder header.

### For Mac users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the
command bar looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 and later look for this version when they start and
every six hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From
beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (82 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build of this version:
  1022 of 1022 unit tests and 615 of 615 browser tests (132 of them one at a time after the
  rest), with no retries. The first run of the browser tests failed one drag test,
  `TabDropTest.ARailRowDraggedOntoThePageLeavesTheRail`, five times in five alone: it had moved
  its window under the machine's own resting pointer, whose events then met the drag the test
  sent. The test now keeps its window clear of that pointer; it and the other 17 drag tests
  pass, and the whole browser run above came after the change. The new tests:
  `SpaceSwitchTest.CmdNOpensOnTheSpaceItIsPressedIn`,
  `CommandBarActionsTest.TheSettingsRowBringsTheBarAndTheStarBack`,
  `CommandBarActionsTest.ManyBookmarksAskBeforeTurningIntoPins` and
  `FolderViewTest.TheHeaderOpensAndClosesThroughExpandAndCollapse`.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 3,
  pointed at a local signed feed offering a Developer-ID-signed copy of this build, fetched it
  9 seconds after launch and showed **New Stedding Version Available**; a press of it
  relaunched the copy as this version within 2 seconds, with the "updated" thank-you page open.
  The copy needed a bundle id of its own: with the real one, it found the update the operator's
  own Stedding had downloaded and was waiting to install, and did not check
  (`docs/HANDOFF.md`, trap 124).
- `tooling/verify-build` on the signed app: the page, WebGL and video decoding passed (its
  network check left out, `--offline`); Apple's `syspolicy_check distribution` passed it.
- After it was published, through the real feed: a copy of the released 0.3.0 beta 3, on a
  profile of its own, found this version on GitHub and showed **New Stedding Version
  Available** 49 seconds after launch (not pressed: the Mac's relaunch would open the operator's
  own profile, `docs/HANDOFF.md` trap 117).

On Windows 11, on the same series:

- The release build, the build with DCHECKs and the dangling-pointer detector, and the
  AddressSanitizer build, each run in the operator's desktop session: 1013 of 1013 unit tests
  and 581 of 581 browser tests (444 four at a time, then 137 one at a time) on each, with no
  retries, no DCHECK, no dangling pointer and no AddressSanitizer report. The drag tests were
  run again on all three after the change above: 18 of 18 on each.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 3 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 3, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 31 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.4 · Chromium 156.0.8078.48" and up to date.
- After it was published, through the real feed: the installed 0.3.0 beta 3 found this version
  on GitHub, showed the pill 45 seconds after launch and, pressed, restarted into it in 4
  seconds with its tabs back, About reading 0.3.0-beta.4 and up to date.
- The folder header through UI Automation, as Narrator reads it, on the installed beta 3 and
  then this version: a button named for the folder, with Expand and Collapse; on beta 3
  Collapse failed, on this version Collapse and Expand close and open the folder.

### Install

#### macOS

`Stedding-0.3.0-beta.4-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.4-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.4-arm64.dmg
f066c7871e45bf795158d28e201b84b654b64b7f2bdf626b5011ef55372f0ad9  Stedding-0.3.0-beta.4-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.4-win-x64.exe SHA256
1adc8aba8db0367b477b8a5ceeb6d603151094e8384af3783541c09b2d77e955  Stedding-0.3.0-beta.4-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.1 MB, both built on 2026-10-22 from the
series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).
- VoiceOver and Narrator themselves were not run on this release; the folder header was
  checked through the accessibility interfaces they read (`S-140`).

## Stedding 0.3.0 beta 3

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). A fix found by the checks run after 0.3.0 beta 2.

### What changed since 0.3.0 beta 2

- **The address row's colour on a slow or busy machine.** The row takes its colour from the
  top of the page it shows. When a page had only just appeared and the machine was slow to
  draw it, that look at the page could come too early and was dropped; with nothing else due,
  the row kept the page's declared colour (or, in a split, both parts did) until you scrolled
  or the page changed. A look that comes too early is now tried again shortly. Found by the
  AddressSanitizer run of beta 2, whose slow build hit it two times in five.

### For Mac users

With automatic updates on, 0.3.0 beta 2 looks for this version when it starts and every six
hours; 0.2.0 beta 16 to 0.3.0 beta 1 look once a day. **Check for Updates** in the command bar
looks at once.

### For Windows users

With automatic updates on, 0.3.0 beta 2 looks for this version when it starts and every six
hours, and 0.2.0 beta 19 to 0.3.0 beta 1 once a day; each installs it by itself. From beta 18 or
earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (80 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build of this version:
  1021 of 1021 unit tests and 610 of 610 browser tests (130 of them one at a time after the
  rest), with no retries. `PageColourRowTest.AReadWithNoSurfaceYetIsTriedAgain` makes the first
  eight reads of a page's top find no surface: it fails without the fix and passes with it.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 2,
  pointed at a local signed feed offering a Developer-ID-signed copy of this build, showed
  **New Stedding Version Available** 27 seconds after launch; a press of it relaunched the copy
  as this version in 3 seconds, with the "updated" thank-you page open.
- `tooling/verify-build` on the signed app: the page, WebGL and video decoding passed (its
  network check left out, `--offline`); Apple's `syspolicy_check distribution` passed it.

On Windows 11, on the same series:

- The release build, the build with DCHECKs and the dangling-pointer detector, and the
  AddressSanitizer build, each run in the operator's desktop session: 1012 of 1012 unit tests
  and 576 of 576 browser tests (441 four at a time, then 135 one at a time) on each, with no
  retries, no DCHECK, no dangling pointer and no AddressSanitizer report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 2 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 2, on a scratch profile and pointed at a local
  feed signed with the project's key, showed the restart pill 20 seconds after launch; pressing
  it (through UI Automation) restarted into this version in 2 seconds with both tabs back, About
  reading "Stedding 0.3.0-beta.3 · Chromium 156.0.8078.48" and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.3-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.3-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.3-arm64.dmg
51e7ff3f6b403f3de1c33b5f43155ccbebb1e4278eebbb8cd3881c84e9faec87  Stedding-0.3.0-beta.3-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.3-win-x64.exe SHA256
ce8175d00a120e0a0f7e39983ea90770e144e620be5b810198b9c378008a9e32  Stedding-0.3.0-beta.3-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.1 MB, both built on 2026-10-22 from the
series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 2

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Quieter defaults and sooner updates, child tabs, a cleaner split row, a
Space row that fits a narrow sidebar, and Arc's folders of folders.

### What changed since 0.3.0 beta 1

- **New versions are found sooner** (the owner's decision of 2026-10-21). With automatic updates
  on, Stedding now looks for a new version when it starts, unless it looked in the past hour,
  and every six hours while it runs, on the Mac and on Windows; until now it looked once a day,
  so a release could wait most of a day to be offered. It never looks more often than once an
  hour, however often it is opened. With automatic updates off it does not look at all, and
  **Check for Updates** still looks at once.
- **Quieter by default.** The toast offering Undo after a close, the "Opened in <Space>" notice
  and the note on how to leave a full screen you started are off until you turn them on in
  Settings → Stedding; ⇧⌘T (Ctrl+Shift+T) still reopens closed tabs, and a page that fills the
  screen by itself, such as a video, still says how to leave. The warning that pinning a tab out
  of a Space with its own sign-ins signs it out stays on.
- **A split's address row** gives each page its own part, ending at that page's edge, with the
  window's background between them as between the pages below; the two colours had met in a soft
  blend that looked smudged where a dark page met a light one.
- **The Space icons at the bottom of the sidebar** get closer together and then smaller as the
  sidebar narrows, before any of them turns into a dot: eight Spaces keep their icons in a much
  narrower sidebar than before, and the **+** no longer drops out of a narrow one.
- **Folders show no number when collapsed**, as in Arc; the count of their tabs read as noise
  beside the names.
- **Child tabs.** A link you open in a new tab (a middle click, ⌘-click or Ctrl+click, or a page
  opening one itself) now sits indented under the page it came from, a grandchild a level
  further. Close a parent and its children move up into its place; the tree comes back after a
  restart. Essentials and pinned tabs keep their links beside the rows. Settings → Stedding →
  Tabs → **Show tabs under the tab that opened them** turns it off.
- **Import from Arc keeps folders of folders.** An Arc folder that held only other folders came
  across as its folders a level up; it is now a folder with its folders inside, in Arc's order.

### For Mac users

With automatic updates on, a Mac on 0.2.0 beta 16 or later is offered this version within a day
(those versions still look once a day); **Check for Updates** in the command bar looks at once.

### For Windows users

With automatic updates on, 0.2.0 beta 19 or later installs this version by itself within a day
(those versions still look once a day). From beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (80 patches on 156.0.8078.48):

- `tooling/dev test unit` and `tooling/dev test browser` on the release build of this version:
  1021 unit tests and 606 browser tests (127 of them one at a time after the rest). One browser
  test, `HoverCardPictureTest.ARowOffScreenShowsAPictureOfItsPage`, failed once after 33
  seconds in the one-at-a-time leg; it passed three times in three alone and its suite 24 times
  in 24, and the sweep before it had passed it.
- Child tabs on the release build, opened through DevTools with no pointer: a page's two
  windows sat a level under it and a window one of them opened under that one, until a window
  opened by a page in the background showed Chromium naming the tab on screen as its opener; that
  is fixed in this release, with a test. Captures of the split row and of the Space row at five
  sidebar widths, both ends of the row 21.5 DIP from the sidebar's edges within two DIP.
- A real import from Arc, read from copies of both profiles: every Space, every tab and every
  history row came across; the folders of folders it found are fixed in this release.
- The update itself, from the release people have: a copy of the released 0.3.0 beta 1,
  pointed at a local signed feed offering a Developer-ID-signed copy of this build, showed
  **New Stedding Version Available** 27 seconds after launch; a press of it relaunched the copy
  as this version in 2 seconds, with the "updated" thank-you page open.
- `tooling/verify-build` on the signed app: the page, WebGL and video decoding passed; its
  network check was left out (`--offline`), as this Mac's outgoing firewall holds a newly signed
  build's first connections. Apple's `syspolicy_check distribution` passed it as ready for
  distribution.

On Windows 11, on the same series:

- On the release build of this version, run in the operator's desktop session: 1012 of 1012
  unit tests and 574 of 574 browser tests (440 four at a time, then 134 one at a time), with no
  retries. Two tests that need the desktop to themselves, `MakeAppTest.EnterInTheDialogAddsTheApp`
  (Return in a dialog) and `TabDropRtlTest.*` (drags), had failed only when run four at a time,
  passing alone; they now run one at a time with the others of their kind.
- The build with DCHECKs and the dangling-pointer detector: 1012 of 1012 unit tests and 574 of
  574 browser tests, with no DCHECK and no dangling pointer.
- AddressSanitizer, run after the release: 1012 of 1012 unit tests and 573 of 574 browser tests,
  with no report. `PageColourRowTest.AnEdgeReadBegunBeforeTheSwitchIsDropped` waited for a late
  read of the page's edge that the slow build had already finished; the test now starts the read
  itself (a test change only).
- The installer was run for real, as the user, after a backup of the install and its profile:
  over an installed 0.3.0 beta 1 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed 0.3.0 beta 1, on a scratch profile and pointed at a local
  feed signed with the project's key, read the feed and downloaded this installer, installed it
  beside itself, and showed the restart pill 20 seconds after launch. Pressing it (through UI
  Automation) restarted into this version in 2 seconds with both tabs back; About read
  "Stedding 0.3.0-beta.2 · Chromium 156.0.8078.48" and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.2-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.2-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.2-arm64.dmg
c1e3d95044219c9daabef4f6a3ffa6ca6ff3f1e31e5366cb7934357538985d69  Stedding-0.3.0-beta.2-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.2-win-x64.exe SHA256
bb85bd37c933555457087767e4119a3c6208d4660c1626631ffe52b112680afa  Stedding-0.3.0-beta.2-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.1 MB, both built on 2026-10-21 from the
series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).
- Back on a child tab's first page does not yet return to the tab that opened it, and a
  parent's children do not fold away with it (`docs/features/tabs.md` R60).

## Stedding 0.3.0 beta 1

Chromium **156.0.8078.48**, Chrome 156's stable release, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). The first of the 0.3 series: beta 21 of 0.2 plus the owner's notes on it,
a fix for tabs given on the command line, and what a review and a Windows pass found.

### What changed since 0.2.0 beta 21

- **Closing a pinned tab works the Arc way.** ⌘W, its ✕, a middle click or the tab menu's Close
  always unload a pinned tab or an essential and send it back to its pinned address, keeping it
  in place; a page that asks "Leave site?" still asks first. Before, a pin in use stayed loaded
  and the menu's Close removed it.
- **Folders in the pinned tabs.** Drag a folder over the line into the pinned tabs, to any place
  among them, or use **Pin Folder** on its menu; **Unpin Folder** takes it back. A pinned folder
  moves among the pins as a pinned tab does, a bar showing where it will land.
- **A folder is renamed only from its name.** A double click on the folder's name edits it in a
  field as wide as the name, with the name in it; a double click elsewhere on the header opens
  or closes the folder. An empty, narrow edit field could appear instead.
- **The collapsed sidebar follows the row height setting.** At Compact and Dense its icons,
  cards and gaps shrink as the open sidebar's rows do.
- **Favicons stay within a site.** A page of the same site that names no icon keeps the site's
  favicon, instead of the empty globe; a page of another site never borrows one.
- **Every button in the address row shows a hover**, on any page colour, light or dark; the
  extensions button and pinned extensions included.
- **Chips in the address field fit**, the AI Mode button among them.
- **A double click anywhere empty at the window's top** zooms or minimizes the window as the
  system setting says, on the Mac and on Windows.
- **An extension's own window over a full-screen browser** opens right there on the Mac, such
  as a password manager's passkey prompt, rather than on the desktop.
- **Switch Spaces with the mouse** (GitHub issue 10). Over the sidebar or its icons, scroll
  sideways: a mouse's tilt wheel, or Shift with the wheel, moves one Space for each notch, to
  the right for the next one. On Windows a touchpad's two-finger sideways scroll moves one
  Space for each swipe, and Ctrl with the wheel does it too (over the page it still zooms).
  Scrolling up and down still scrolls the tabs.
- **The little window gets a way into the main window** (Mac). A link from another app still
  opens in a small window, which now has no title bar: its traffic lights sit in Stedding's own
  address row, in the page's colour, light or dark as the main window is. **Open in Stedding**
  at the row's right end, in the page's right-click menu, in the File menu (⌘O) or as Show as
  Tab moves the page into a tab of the main window, as it was, without a reload; **Open in
  Split View** (⇧⌘O) puts it beside the tab you are on. With no main window open, one opens.
  (Asked for in GitHub issue 9.)
- **Smoother motion.** The sidebar's collapse, expand and hover overlay ease out evenly, the
  Space switch no longer hitches at its start, and hidden controls and the address bar's hidden
  popups are left out of each frame.
- **Fixes:**
  - Tabs given on the command line, or opened from other apps at launch, could fail to load
    (`S-251`): the browser dropped the connections it had opened ahead for them.
  - A tab dragged from the collapsed sidebar onto the page makes the split; the sidebar no
    longer opens under the drag.
  - Tabs restored asleep at launch draw asleep.
  - The collapsed sidebar shows hover cards.
  - Windows: Escape during the Ctrl+Alt+E extension cycle no longer sends the window to the
    back.
  - In right-to-left languages, the split drop highlight lights the half the drop takes, and
    the Spaces' emoji sit centred.
  - Windows: a possible crash when a split was dragged to a new window.
  - A crash when vertical tabs were turned on just as a tab dragged in the tabs on top was
    settling back into place (`S-253`).

### For Mac users

With automatic updates on, a Mac on 0.2.0 beta 16 or later is offered this version within a day; **Check
for Updates** in the command bar looks at once.

### For Windows users

With automatic updates on, 0.2.0 beta 19 or later installs this version by itself within a day.
From beta 18 or earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (77 patches on 156.0.8078.48):

- `tooling/dev test all` on the release build of this version: 1008 unit tests, 56 component
  tests and 468 browser tests (127 of them one at a time after the rest). One browser test
  overran the 30 seconds a test's shutdown may take, with no task running, and passed five
  times in five when run again (`S-257`).
- By hand on release builds, with the real pointer and keyboard: folders renamed only from
  their names and pinned by a drag or the menu, kept across a relaunch; the rail at every row
  height; favicons kept within a site; a pinned tab and an essential closed by ⌘W, ✕ and the
  menu, playing sound or asking "Leave site?"; the row's hovers and a pinned extension; the
  window's top as its title bar; an extension's window over full screen; a tab dragged from the
  rail onto the page; ten launches with five addresses on the command line, all loaded; tabs
  restored asleep; the split row's two colours; Spaces switched with a sideways scroll; the
  little window's Open in Stedding, with and without a main window. What those checks found is
  fixed in this release, each with a test.
- The update itself, from the release people have: a copy of the released 0.2.0 beta 21,
  pointed at a local signed feed offering a Developer-ID-signed copy of this build, showed
  **New Stedding Version Available** 27 seconds after launch; a press of it relaunched the copy
  as this version, with the "updated" thank-you page open.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed; its network check was left out (`--offline`), as this Mac's outgoing firewall holds a
  newly signed build's first connections. Apple's `syspolicy_check distribution` passed it as
  ready for distribution.

On Windows 11, on the same series:

- On the release build of this version, run in the operator's desktop session: 999 of 999
  unit tests and 561 of 561 browser tests (429 four at a time, then 132 one at a time), with
  no retries.
- The build with DCHECKs and the dangling-pointer detector: 999 of 999 unit tests and 561 of
  561 browser tests, with no DCHECK and no dangling pointer.
- AddressSanitizer: 999 of 999 unit tests and 561 of 561 browser tests, with no report.
- By hand on the installed 0.2.0 beta 21 and on release builds of this round, with the real
  pointer and keyboard: the split by drop, the most recently used tab after a close, what loads
  at launch, the sleep timer, the hover pictures, Ctrl+Alt+E with the address row hidden, the
  split row's colours, the tab strip on top and the rail's glyphs; then the faults that pass
  found (the rail drag, Escape with Ctrl+Alt held, the slept look at launch, the rail's hover
  card), fixed and seen again, and the address bar's dropdown after a collapse and a resize.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over the installed 0.2.0 beta 21 (an upgrade), then an uninstall that kept the profile, then
  a fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and
  the profile stayed.
- The update itself: the installed 0.2.0 beta 21, on a scratch profile and pointed at a local
  feed signed with the project's key, read the feed and downloaded this installer 10 seconds
  after launch, installed it beside itself, and showed the restart pill at 20 seconds.
  Pressing it (through UI Automation) restarted into this version in 2 seconds with both tabs
  back; About read "Stedding 0.3.0-beta.1 · Chromium 156.0.8078.48" and up to date.

### Install

#### macOS

`Stedding-0.3.0-beta.1-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.3.0-beta.1-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.3.0-beta.1-arm64.dmg
0ca31dc34483286491696ab5cd255ff08ca14ff5476d9be886b7022eb5b97c3b  Stedding-0.3.0-beta.1-arm64.dmg

certutil -hashfile Stedding-0.3.0-beta.1-win-x64.exe SHA256
ccbcfc34b9df2a6a977be227f2d6d6fcf57e1ec6ae666553e4bbc2a2fc8e628d  Stedding-0.3.0-beta.1-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.1 MB, both built on 2026-10-21 from the
series this tag carries.

### Known limits

- Builds on Chromium 156 lose Chromium's built-in list of sites that must load over HTTPS on
  13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe changes one Space when the
  fingers have gone far enough, without the Mac's list that follows them, and has not yet been
  tried on a real touchpad (`docs/history/plan-2026-09-26.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).

## Stedding 0.2.0 beta 21

Chromium **156.0.8078.36**, the same base as betas 17 to 20, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Beta 20 plus six features from the backlog, one of them asked for on
GitHub, a cleaner look for splits, tabs on top and the collapsed sidebar, Chrome's own security
defaults, and a round of fixes.

### What changed since beta 20

- **Drag a tab onto the page to make a split.** Drag a row from the sidebar, the rail or the
  tab strip over the page: the half it will take lights up, and dropping it there puts the two
  pages side by side, the dropped one active. A tab no longer tears off into a window of its own
  while the pointer is inside the window: drag it outside the window, or use **Move Tab to New
  Window**. (Asked for in GitHub issue 7.)
- **Closing a tab shows the one you used before it**, in the same Space, rather than its
  neighbour; Sleep Tab chooses the same way.
- **At launch only the selected tab loads.** Every other restored tab comes back asleep and
  loads when you open it. Settings → Stedding → "On startup, load" can load the essentials too,
  or the whole Space.
- **Tabs can sleep on their own.** Settings → Stedding → "Put tabs to sleep after" (Never by
  default). The command bar has **Sleep Other Tabs** and **Sleep Other Tabs in This Space**.
  When the computer runs short of memory, Chromium's own tab discarding now keeps Stedding's
  rules: never a tab on screen, playing sound, in picture in picture or using the camera or
  microphone, and a split sleeps whole.
- **Hover a tab to see its page** on the Mac too, as on Windows: a small picture of the page in
  the tab's card, kept in memory only, never written to disk or sent anywhere.
- **With the address row hidden, its controls are in the command bar.** A row per extension,
  the media controls and site information; **⌘E** (Ctrl+Alt+E on Windows) cycles through the
  extensions, letting go runs the chosen one, and Escape (on the Mac also ⌘. while ⌘ is held)
  runs none. On the Mac, Find's "Use Selection for Find" keeps its menu row without ⌘E.
- **A split's address row is in both pages' colours.** Over each pane, the row takes that
  page's own colour, as wide as the pane, with a soft blend over the gap between them; before,
  the whole row took the colour of one pane.
- **Tabs on top look like the sidebar's.** With vertical tabs off, every tab in the strip is a
  rounded pill, a split is two pills side by side, each as wide as any other tab so its title
  is not cut short, and the strip's buttons and dividers no longer use Chrome's blue.
- **The collapsed sidebar lines up.** The Spaces' emoji, the "+" buttons and every other icon
  in the rail stand on one centre line, and the open sidebar's icons sit on the favicons'
  column.
- **Chrome's security defaults.** Certificates are checked as Chrome checks them: a public
  certificate must be in the public Certificate Transparency logs, and Google's own sites accept
  only the keys Google pinned. Stedding sends none of the certificate reports Chrome sends with
  this. Features Chrome has turned on for all its users, but which reach other Chromium browsers
  only when their code changes, are on too (`docs/ARCHITECTURE.md`, "De-Googling stance").
- **Fixes:**
  - The toolbar's download button could stay hidden when the tab strip handed downloads back
    to it.
  - Closing a tab whose page was asking "Leave site?" could leave the sidebar holding a pointer
    to the closed tab.
  - A row moved into a new folder from its menu could stay highlighted, with its close button,
    until clicked.
  - The Space chips' shortcuts (⌃3, ⌃4, ⌃6, ⌃8, ⌃9) drew as "…" while ⌘ was held.
  - The windows of a quit stay in the archive and ⇧⌘T when the next launch does not reopen them.
  - An app's uninstall box no longer runs its two sentences together.
  - **Return** in the Add to Dock box adds the app, as its Add button does.
  - A tab sent to the background just as Dark Pages was turned on could show its page's old
    light colour in the address row when selected again.
  - Windows: uninstalling leaves no PDF handler entry behind, and the updater checks and runs
    an update's installer on one locked file, retries within the hour when offline, and keeps a
    failed install's log.

### For Mac users

With automatic updates on, a Mac on beta 16, 17 or 20 is offered beta 21 within a day; **Check for
Updates** in the command bar looks at once. Stedding's helper processes now start the way
Chrome's do: if you use an outgoing firewall such as LuLu, it may ask once more about
"Stedding Helper" processes.

### For Windows users

With automatic updates on, beta 19 or 20 installs beta 21 by itself within a day. From beta 18 or
earlier, install this one by hand once.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (76 patches):

- `tooling/dev test all` on the release build of this version: 997 unit tests, 56 component
  tests and 407 browser tests (102 of them one at a time after the rest), green, with no
  retries.
- The new features by hand on a release build, with the real pointer and keyboard: a tab
  dragged onto the page from the open sidebar, the rail and the tab strip made a split on the
  half that lit, and an essential made none; ⌘W showed the tab used before; at launch only the
  selected tab loaded, and the whole-Space choice loaded the Space; Sleep Other Tabs slept what
  it names; the hover card showed the page; ⌘E opened the extension rows; and Add to Dock made
  an app with its Dock tile, removed again from chrome://apps. What that check found is fixed
  in this release, each with a test.
- The update itself, from the release people have: a copy of the released beta 20, pointed at
  a local signed feed offering a Developer-ID-signed copy of this build, read the feed,
  downloaded the image, and showed **New Stedding Version Available** 28 seconds after launch; a press of it relaunched the copy as this version, with its tab back and the
  "updated" thank-you page open.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed; its network check was left out (`--offline`), as this Mac's outgoing firewall holds a
  newly signed build's first connections. Apple's `syspolicy_check distribution` passed it as
  ready for distribution.

On Windows 11, on the same series:

- On the release build of this version, run in the operator's desktop session: 988 of 988
  unit tests and 491 of 491 browser tests (384 four at a time, then 107 one at a time), with
  no retries.
- The build with DCHECKs and the dangling-pointer detector: 988 of 988 unit tests and 491 of
  491 browser tests, with no DCHECK and no dangling pointer.
- AddressSanitizer: 988 of 988 unit tests and 491 of 491 browser tests, with no report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over the installed beta 20 (an upgrade), then an uninstall that kept the profile, then a
  fresh install. Each time the installed `chrome.dll` was this build's, byte for byte, and the
  profile stayed.
- The update itself: the installed beta 20, on a scratch profile and pointed at a local feed
  signed with the project's key, read the feed and downloaded this installer 10 seconds after
  launch, installed it beside itself, and showed the restart pill at 20 seconds. Pressing it (through UI
  Automation) restarted into this version in 2 seconds with both tabs back; About read "Stedding
  0.2.0-beta.21 · Chromium 156.0.8078.36" and up to date.

### Install

#### macOS

`Stedding-0.2.0-beta.21-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.2.0-beta.21-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.2.0-beta.21-arm64.dmg
5b173e57cdee4c77a4d3ae44671e758c6785ce0cf3e62d95b03dbb019accac32  Stedding-0.2.0-beta.21-arm64.dmg

certutil -hashfile Stedding-0.2.0-beta.21-win-x64.exe SHA256
f1c8d94ea8983d0a8d05302d2c0c7abddb5fd55a81f06c6fd12cc2e9895fa410  Stedding-0.2.0-beta.21-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.1 MB, both built on 2026-10-20 from the
series this tag carries.

### Known limits

- **The base is Chrome 156's early-stable build**, as in betas 17 to 20; Chrome 156's full
  release is not in this one. Builds on this base lose Chromium's built-in list of sites that
  must load over HTTPS on 13 December 2026; a release on a newer base will come before then.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); the two-finger Space swipe does nothing yet (`PLAN.md`
  TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- On the Mac, when Stedding is started with several addresses at once, some of the tabs
  after the first may not load; beta 20 does the same, and the cause is being
  looked for (`S-251`).
- Netflix, Disney+ and Spotify's web player do not play: Widevine is not built (`S-241`).
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).

## Stedding 0.2.0 beta 20

Chromium **156.0.8078.36**, the same base as betas 17 to 19, a **macOS image** (Apple silicon,
signed and notarized) and a **Windows x64 preview** (unsigned), with Stedding's patch series
(`patches/README.md`). Both platforms again in one release: for the Mac it is the first since
beta 17 and carries everything betas 18 and 19 brought to Windows; for Windows it is beta 19
plus the fixes of a review of that work, and the first version a Windows copy gets through its
own updater.

### What changed since beta 19

- **Restored tabs no longer come back as crashed pages.** A change made after beta 19 had
  brought back an old fault, in which a tab the Arc import added unloaded came back from a
  restart as a crashed page; it never reached a release, and the page state a tab is restored
  with is now kept free of the number that set it off (`docs/features/import.md` I26).
- **The undo toast lands where it should.** A toast that appeared as the infobars came or went
  could stay where they had been; it now settles under them, or under the address row, and
  closing a window with a toast showing is safe.
- **The Windows updater is sturdier.** One check runs at a time, a stalled connection gives up
  after a minute (two hours for the download), the installer's file name is checked, a quit
  during an install no longer waits for it, and the downloaded installer is removed before the
  browser exits.
- **Windows sends Chromium's version everywhere the web or Google's services can see it**, as
  intended in beta 19, now also to the Web Store page, with a Google image search, to Safe
  Browsing, and in the check of which root certificates apply.

### For Mac users, coming from beta 17

Everything betas 18 and 19 brought, on the Mac for the first time:

- **Dark pages.** One switch turns every website dark, drawn dark from the first frame: the
  moon button at the right end of the address row, **⌥⇧⌘D**, the command bar, **View › Dark
  Pages**, or Settings → Stedding → Pages and menus. A site with a dark theme of its own uses
  it, photos and video keep their colours, the browser's own pages are never darkened, and
  **Darken this site** on the page's right-click menu keeps one site light.
- **Apps made from pages.** **File › Add to Dock…** turns any page into an app of its own, in
  its own window and in the Dock, keeping the session of the Space it was made in.
- **Local development tabs.** A tab on this computer's own server (`localhost`, `127.0.0.1`)
  wears a dashed yellow and black tape round its row while it is the active one, and shows its
  host and port under its title at the Comfortable density.
- **A mark on Spaces with their own session.** A Space with an Independent session shows a
  small cookie mark on its chip, its title row, the menus and Settings, and pinning a tab out
  of it says the tab leaves the session, with Undo.
- **Essentials are tiles with no outline**, as Arc draws its favourites, and the Archived row
  and the Clear line sit back in a softer shade until you point at them.
- **Fixes:** a restored row keeps its page's title; the command bar no longer lists an open
  tab a second time as Archived, and ⇧⌘T no longer reopens the last session's windows as
  second copies; a tab dropped on a folder's icon in the collapsed rail goes into the folder;
  deleting a Space that another window showed no longer stops the browser; every deletion of a
  Space asks first; strings that name the browser are translated again; skipping the welcome
  flow's engine step no longer brings up Chromium's engine chooser; a toast no longer covers
  an infobar's text; **⌃⌘N** splits the current tab with a new one, as ⌥⌘N does.

A Mac on beta 16 or 17 with automatic updates on is offered beta 20 within a day; **Check for
Updates** in the command bar looks at once.

### For Windows, coming from beta 19

Nothing to do: with automatic updates on, beta 19 finds beta 20 within a day, installs it in
the background, and offers the restart at the bottom of the sidebar. From beta 18 or earlier,
install this one by hand once; later versions arrive by themselves.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (73 patches):

- `tooling/dev test all` on the release build of this series: 964 unit tests, 56 component
  tests and 361 browser tests (84 of them one at a time after the rest), green, with no
  retries. The restore test failed on the change it caught, and the toast test failed on the
  Mac until its fix; both pass, the toast test three runs in three on its own.
- The update itself, from the release people have: a copy of the released beta 17, pointed at a
  local signed feed offering a Developer-ID-signed copy of this build, read the feed nine
  seconds after launch, downloaded the image, and showed **New Stedding Version Available** at
  25 seconds; a press of it relaunched the copy as this version 13 seconds later, with its tab
  back and the "updated" thank-you page open.
- `tooling/verify-build` on the signed app: the page, WebGL, video decoding and full screen
  passed; its network check was left out (`--offline`), as this Mac's outgoing firewall holds a
  newly signed build's first connections. Apple's `syspolicy_check distribution` passed it as
  ready for distribution.

On Windows 11, on the same series:

- On the release build of this tag, the version set, run in the operator's desktop session:
  951 of 951 unit tests and 341 of 341 browser tests (251 four at a time, then 90 one at a
  time), with no retries.
- The build with DCHECKs and the dangling-pointer detector: 951 of 951 unit tests and 341 of
  341 browser tests, with no DCHECK and no dangling pointer.
- AddressSanitizer: 951 of 951 unit tests and 341 of 341 browser tests, with no report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over the installed beta 19 (an upgrade), then an uninstall that kept the profile, then a fresh
  install. Each time the installed `chrome.dll` was this build's, byte for byte, and the profile
  stayed.

### Install

#### macOS

`Stedding-0.2.0-beta.20-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.2.0-beta.20-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. Stedding may stay open; the new version takes
over the next time it starts. It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any
app. Windows 10 and 11, x64.

### Checksums

```
shasum -a 256 Stedding-0.2.0-beta.20-arm64.dmg
46bc9ed4ed94f6d790270778a2d5d8f10903f92ac8db5db9e8c6cd96fa76ba85  Stedding-0.2.0-beta.20-arm64.dmg

certutil -hashfile Stedding-0.2.0-beta.20-win-x64.exe SHA256
c0c910481a4e5c3d9582d0189cae3c39c5615a2e0719baebfdcea40df287c603  Stedding-0.2.0-beta.20-win-x64.exe
```

The macOS image is 179 MB and the Windows installer 168.0 MB, both built on 2026-10-19 from the
series this tag carries.

### Known limits

- **The base is Chrome 156's early-stable build**, as in betas 17 to 19; Chrome 156's full
  release, scheduled for 20 October, is not in this one.
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry, the PDF
  handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- **Add to Dock** and **Install page as app…** have not yet been tried by hand (`S-235`); their
  tests pass.
- The Windows updater: what a review left for later is listed in `S-249`; none of it lets an
  installer run that the project's key did not sign.
- The network sandbox on Windows was not tried with a Hyper-V, WSL or VMware network adapter
  (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).

## Stedding 0.2.0 beta 19

Chromium **156.0.8078.36**, the same base as betas 17 and 18, a **Windows x64 preview**
(unsigned) and Stedding's patch series (`patches/README.md`). Beta 18 plus one thing, on Windows:
**Stedding now updates itself on Windows**, as it has on the Mac since beta 16. Nothing in this
release changes the Mac version, and it is Windows only: the Mac's next image is beta 20's.

### What changed since beta 18

- **Automatic updates on Windows.** Once a day Stedding looks for a new version on GitHub,
  downloads the installer in the background, checks its signature, installs it beside the
  running copy, and shows **New Stedding Version Available** at the bottom of the sidebar; click
  it to restart into the new version, or just quit, and the next start is the new one. **Check
  for Updates** in the command bar looks at once, the About page shows what it is doing, and
  **Update Stedding automatically** in Settings › Stedding › Updates turns it off; it then makes
  no update request at all. The request carries no cookies, no identifier and nothing about the
  computer; the list of versions and every installer are signed with the project's Windows key
  and checked before they are used (`docs/PRIVACY.md`, ADR 0026).
- **Each Windows release has a version of its own.** Beta 19 installs as 156.2.0.19, above beta
  18's 156.0.8078.36, so a new release installs as an upgrade, and Stedding no longer has to be
  closed first: a release installed while it runs takes over at its next start. About names both:
  "Stedding 0.2.0-beta.19 · Chromium 156.0.8078.36". Websites, extensions, the Web Store and the
  component updater still see Chromium's own version.

### For Windows, coming from beta 18 or earlier

Install this one by hand, once: download it and run it. Stedding may stay open; the new version
takes over the next time it starts. From beta 19 on, later versions arrive by themselves. Your
profile, in `%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On Windows 11, on the series this tag carries (73 patches):

- On the release build of this tag, the version set, run in the operator's desktop session:
  951 of 951 unit tests and 341 of 341 browser tests (251 four at a time, then 90 one at a time),
  with no retries.
- The update itself, end to end, on the installed copy (`docs/HANDOFF.md`, "The updater
  (Windows)"): a build of the same tree as 156.2.0.18, installed over beta 18 with the profile
  kept, was pointed at a local copy of the update list offering this installer. About ten seconds
  after launch it read the list, downloaded the installer, checked it and installed it beside itself,
  and 25 seconds after launch the sidebar showed **New Stedding Version Available**. A real click
  restarted it into 156.2.0.19 in about two seconds, with its tabs back, and About read
  "Stedding 0.2.0-beta.19 · Chromium 156.0.8078.36". A build run from its output folder, not
  installed, asked for nothing.
- The build with DCHECKs and the dangling-pointer detector: 951 of 951 unit tests and 341 of
  341 browser tests, with no DCHECK and no dangling pointer.
- AddressSanitizer: 951 of 951 unit tests and 341 of 341 browser tests, with no report.
- The installer was run for real, as the user, after a backup of the install and its profile:
  over the copy the update had made (the same version, so a repair), then an uninstall that kept
  the profile, beta 18 installed fresh, this installer over beta 18 (the path a user takes once,
  an upgrade), another uninstall that kept the profile, and a fresh install. Each time the
  installed `chrome.dll` is this build's, byte for byte, and the profile stayed.
- Used from the installed copy, with the real pointer and keyboard: the core-loop script
  (`docs/features/acceptance.md`) passed every step: the thirteen steps of the loop, a restart
  included, the four drags onto a folder and a Space chip in the open sidebar and the rail, and
  the nineteen keyboard steps. Run right after another part in one go, a part's window came up
  with no page visible for a minute and its setup went wrong: two drags failed in both such runs,
  and five keyboard steps in one. Each part passed on its own. That is the test runner's fault,
  filed as `S-248`.

### Install

#### Windows

`Stedding-0.2.0-beta.19-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one, and updates itself from then on. It is **not signed**: SmartScreen shows "Windows
protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings →
Apps, as any app. Windows 10 and 11, x64.

### Checksum

```
certutil -hashfile Stedding-0.2.0-beta.19-win-x64.exe SHA256
14fe9dc863cff1942582c698e49485c3b30eca31e2c8257a3dda66c02c92cb39  Stedding-0.2.0-beta.19-win-x64.exe
```

The Windows installer is 168.0 MB, built on 2026-10-19 from the commit this tag points to.

### Known limits

- **The base is Chrome 156's early-stable build**, as in betas 17 and 18; Chrome 156's full
  release, scheduled for 20 October, is not in this one.
- Windows copies of beta 18 and earlier have no updater: install beta 19 by hand once.
- Not yet seen on a real Windows update: an update through the real list on GitHub rather than a
  local copy, which the release after this one will be, and the thank-you page after an update
  (`S-247`).
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry, the PDF
  handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- **Install page as app…** has not yet been tried by hand on Windows (`S-235`); its tests pass.
- The network sandbox was not tried with a Hyper-V, WSL or VMware network adapter (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).

## Stedding 0.2.0 beta 18

Chromium **156.0.8078.36**, the same base as beta 17, a **Windows x64 preview** (unsigned) and
Stedding's patch series (`patches/README.md`). Beta 17 plus four new features and three rounds
of fixes: dark pages for every website, apps made from pages, local development tabs marked as
Arc marks them, and a mark on the Spaces that keep their own session. This release is Windows
only: the Mac got this work with beta 20, and a Mac on beta 17 is offered beta 20.

### What changed since beta 17

- **Dark pages.** One switch turns every website dark, with Chromium's own automatic dark mode,
  drawn dark from the first frame: the moon button at the right end of the address row,
  **Ctrl+Alt+Shift+D** (⌥⇧⌘D on the Mac), the command bar, or Settings → Stedding → Pages and
  menus.
  A site with a dark theme of its own uses it; photos, video and canvases keep their colours;
  the browser's own pages are never darkened. Keep one site light with **Darken this site** on
  the page's right-click menu, or darken only the sites you list, in Settings.
- **Apps made from pages.** **Install page as app…** in the app menu (Add to Dock on the Mac)
  turns any page into an app of its own, in its own window, keeping the session of the Space
  it was made in.
- **Local development tabs.** A tab on this computer's own server (`localhost`, `127.0.0.1`)
  wears a dashed yellow and black tape round its row while it is the active one, and at the
  Comfortable density shows its host and port under its title.
- **A mark on Spaces with their own session.** A Space with an Independent session shows a
  small cookie mark on its chip, its title row, the menus, Settings and the command bar, and
  pinning a tab out of it says that the tab leaves the session, with Undo.
- **Essentials are tiles with no outline**, as Arc draws its favourites: a soft frosted tile in
  light and in dark. The outline they had took the Space's colour.
- **Quieter controls.** The Archived row and the Clear line sit back in a softer shade until
  you point at them.
- **On Windows the network service runs in its own sandbox.** A local development server,
  secure local sockets and a VPN (Tailscale) were checked to work with it.
- **Fixes:**
  - Deleting a Space that another window was showing could stop the browser.
  - After a restart a row kept its page's title; some came back reading the address's file.
  - After a relaunch the command bar no longer lists an open tab a second time as "Archived",
    and Ctrl+Shift+T no longer reopens the last session's windows as second copies.
  - A tab dropped on a folder's icon in the collapsed rail goes into the folder.
  - Every deletion of a Space asks first and names its tabs; Rename Space edits in the title
    row.
  - Strings that name the browser are translated again; they read English in every language.
  - Skipping the welcome flow's engine step no longer brings up Chromium's own "Choose your
    search engine" dialog, and a second pick no longer stops the browser.
  - A toast no longer covers an infobar's text; it sits under the infobars.
  - On Windows a hidden address row leaves no line across the top of the page, and the
    infobar area closes when its last bar goes.
  - An essential taken out of the essentials joins the Space on screen; a switch from an
    essential lands on the Space's own tab; a tab dragged into a new window keeps its Space
    and its session.
  - A tab archived the moment it was left, an idle time that restarted at every launch, a
    second Arc import that added history twice, the bookmark bar staying after its conversion,
    and Escape leaving nothing focused are fixed.

### For Windows, coming from beta 17

Close Stedding, then run the installer. Your profile, in
`%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On Windows 11, on the series this tag carries (72 patches):

- On the release build of this tag, the version set, run in the operator's desktop session:
  939 of 939 unit tests and 340 of 340 browser tests (250 four at a time, then 90 one at a
  time), with no retries.
- The build with DCHECKs and the dangling-pointer detector: 939 of 939 unit tests and 340 of
  340 browser tests, with no DCHECK and no dangling pointer. Its first run stopped on two
  faults a release build does not check, both fixed in this release: turning dark pages on
  forgot a page's edge reading it had never made, and with vertical tabs off the tab strip
  measured a loading tab's spinner against no colour. One Space test there missed an
  accelerator while another test held the foreground; it passes alone, and it now runs one at
  a time.
- AddressSanitizer: 939 of 939 unit tests and 340 of 340 browser tests, with no report.
- The installer was run for real, as the user, with Stedding closed, after a backup of the
  install and its profile: over the build installed for testing (the same Chromium number, so
  a repair), then an uninstall that kept the profile, then a fresh install. Each time the
  installed `chrome.dll` is this build's, byte for byte, and the profile stayed.
- Used from the installed copy, with the real pointer and keyboard: a new profile opens the
  welcome flow; a light and a dark window draw the sidebar, the rows and the address row; the
  core-loop script (`docs/features/acceptance.md`) passed every step: the thirteen steps of
  the loop, a restart included, the four drags onto a folder and a Space chip in the open
  sidebar and the rail, and the nineteen keyboard steps, with the undo toast under the
  infobar. Two of its parts first failed at their setup while a build ran, the browser taking
  no key for a minute after its launch; on a quiet machine they passed.

### Install

#### Windows

`Stedding-0.2.0-beta.18-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first.** It is **not signed**: SmartScreen shows "Windows
protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings →
Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows yet: a
later beta is installed over this one.

### Checksum

```
certutil -hashfile Stedding-0.2.0-beta.18-win-x64.exe SHA256
6c578159e18e5a3ca728cdeea8304b2e87d68340f915407c7307353f3095a911  Stedding-0.2.0-beta.18-win-x64.exe
```

The Windows installer is 168.0 MB, built on 2026-10-19 from the commit this tag points to.

### Known limits

- **The base is Chrome 156's early-stable build**, as in beta 17; Chrome 156's full release,
  scheduled for 20 October, is not in this one.
- No automatic updates on Windows yet (`S-215`).
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry, the PDF
  handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md` TAB-31).
- On Windows Ctrl+Esc belongs to the Start menu, so it cannot cancel a Ctrl+Tab run: hold Ctrl
  and press Shift+Tab back to the first tab instead (`docs/SHORTCUTS.md`).
- **Install page as app…** has not yet been tried by hand on Windows (`S-235`); its tests pass.
- The network sandbox was not tried with a Hyper-V, WSL or VMware network adapter (`S-234`).
- While Arc is running it takes Arc's own shortcuts from every app; quit Arc if a Stedding
  shortcut opens Arc instead (`S-79`).

## Stedding 0.2.0 beta 17

Chromium **156.0.8078.36**, a **macOS image** for Apple silicon (signed and notarized), a
**Windows x64 preview** (unsigned) and Stedding's patch series (`patches/README.md`). Beta 16
on Chrome 156: the same browser, moved to Chromium's next milestone and checked against beta
16 screen by screen.

This is the first release that reaches people by itself: a Mac running beta 16 finds it
within a day and offers it at the bottom of the sidebar.

### What changed since beta 16

- **Chromium 156.** Beta 16 was built on 155.0.8059.12, Chrome 155's early-stable build,
  without the security fixes of its later builds. This release is built on 156.0.8078.36,
  the build of Chrome 156 that Google released to a small share of its users on 14 October.
- **On Windows, the Archived row's text** is drawn as the sidebar's other rows are, without
  the colour fringes it had.
- Everything else looks and works as in beta 16: the sidebar, the Spaces, the command bar,
  the rail, full screen, Settings, About and the Archived page were compared with beta 16's
  on the same steps.

### For macOS, coming from beta 16

Nothing to do. Within a day beta 16 finds this version, downloads it in the background and
shows **New Stedding Version Available** at the bottom of the sidebar: click it, or just quit,
and it installs, with your tabs back. **Stedding › Check for Updates…** looks at once. After the
update Stedding opens one thank-you page on stedding.dev. Updating by hand works as before:
drag the new **Stedding** over the old one in Applications.

### For macOS, coming from beta 15 or earlier

Drag the new **Stedding** over the old one in Applications, this once. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is. From here on Stedding updates
itself.

### For Windows, coming from beta 16

Close Stedding, then run the installer. Your profile, in
`%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (68 patches):

- `tooling/dev test all` on the exact build, the version set: 855 unit tests, 20 component tests
  and 132 browser tests (33 of them one at a time after the rest), and the 115 tests of Chromium's
  tab suites, green, with no retries.
- Beside a copy of the released beta 16, on this series' build before the version was set:
  13 window states captured the same but for a throbber's frame and the shuffled engine list;
  Stedding's Settings section, Settings, About and the Archived page, driven on both, the same
  but for About's version and its update check; a profile beta 16 made, with three Spaces, an
  essential and nested folders, opened the same; the tabs, the tab menu, the command bar, the
  Spaces, the rail, full screen and a drag used with the real pointer and keyboard. A fresh
  profile's network log, beside beta 16's, asked for no host that beta 16 does not ask for.
- The update itself: the released beta 16, pointed at a local signed feed, updated itself to a
  Developer-ID-signed copy of that build through Sparkle: the pill showed in about twenty
  seconds, the new version was running a second after the press, and the tab and the profile
  were kept. The first update through the real feed is this release.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and H.264 + AAC
  decoding real frames, and full screen, all passed; its network check was left out
  (`--offline`): this Mac's outgoing firewall holds a newly signed build's first connections
  until someone answers it. Apple's `syspolicy_check distribution` passed it as ready for
  distribution.

On Windows 11, on the same series:

- On the release build of this tag, the version set, run in the operator's desktop session:
  842 of 842 unit tests and 124 browser tests, 123 of them in one run; the 124th, a folder test
  that presses Ctrl+Shift+E, missed the active window while four tests ran at once and passed
  three runs in three on its own. An earlier run on the same build, with the desktop session
  disconnected, had three Space tests run out of time and three pointer tests fail; the Space
  tests passed when run again, and the pointer tests once the session was connected.
- The build with DCHECKs and the dangling-pointer detector, on this series before the version
  was set: the unit tests passed, and the browser tests stop only on two older tests (`S-214`).
  Its first run on Chromium 156 stopped 110 browser tests on one DCHECK: the Archived row, the
  Space chips and the update pill drew subpixel text onto the sidebar's new layer. That is
  fixed in this release, and it is what took the colour fringes off the Archived row.
- The installer was run for real, as the user, with Stedding closed, after a backup of the
  install and its profile: over the build installed for testing (the same Chromium number, so a
  repair), then an uninstall that kept the profile, then a fresh install. Each time the installed
  `chrome.dll` is this build's, byte for byte. The upgrade from beta 16, from 155 to 156, ran
  on 16 October with a build of this series before its last fix. One launch of the installed build, on a throwaway profile,
  drew the window, the sidebar and the address row, and opened the thank-you page for 0.2.0
  beta 17.

On neither platform was this build run under AddressSanitizer (`S-106`).

### Install

#### macOS

`Stedding-0.2.0-beta.17-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.2.0-beta.17-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first.** It is **not signed**: SmartScreen shows "Windows
protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings →
Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows yet: a
later beta is installed over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.17-arm64.dmg
7c93e06c5d5a759904f37cd8a22b2a0b6cb306e901c14a5ce95bbff1cfa1edef  Stedding-0.2.0-beta.17-arm64.dmg
```

The macOS image is 179 MB, built on 2026-10-18 from the commit this tag points to; the app in
it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

```
certutil -hashfile Stedding-0.2.0-beta.17-win-x64.exe SHA256
5e5b861a01fa75c3be101c27bf4efdddae07fb34aabb9986dce31c166e6b5bdf  Stedding-0.2.0-beta.17-win-x64.exe
```

The Windows installer is 167.8 MB, built on 2026-10-18 from the commit this tag points to.

### Known limits

- **Chrome 156 is paused upstream.** On 16 October Google took Chrome 156's early rollout to
  0% of its users; its schedule puts Chrome 156's full release on 20 October, and the next
  Stedding release moves to that build.
- No automatic updates on Windows yet (`S-215`).
- On Windows the installer is unsigned (`S-56`). Little windows and links from other
  applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry, the PDF
  handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md` TAB-31).
- On Windows, Ctrl+Alt+→ does not move to the next Space while the address bar has the focus;
  click the page first (`S-218`).
- Skipping the welcome flow's engine step leaves no default chosen, and Chromium's own "Choose
  your search engine" dialog then opens over the first page, with a globe for every engine
  (`S-134`).
- On the Mac, ⌃1–⌃9 collide with Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable. The rail's names under
  VoiceOver and a Mac under the IncognitoModeAvailability policy are not checked yet
  (`PLAN.md` WIN-3, CMD-7).
- No AddressSanitizer run of this series yet (`S-106`); the Windows build with DCHECKs stops in
  two tests on one older fault (`S-214`).
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).

## Stedding 0.2.0 beta 16

Chromium **155.0.8059.12**, a **macOS image** for Apple silicon (signed and notarized), a
**Windows x64 preview** (unsigned) and Stedding's patch series (`patches/README.md`). Beta 15
plus two rounds: **Stedding now updates itself on the Mac**, and the fixes for the items the
code review of 2026-10-15 left open.

This is the first version with the updater. Install it by hand once, as before; the versions
after it arrive by themselves.

### What changed since beta 15

- **Automatic updates on the Mac.** Once a day Stedding looks for a new version on GitHub and
  downloads it in the background. When it is ready, **New Stedding Version Available** appears
  at the bottom of the sidebar: click it and Stedding restarts into the new version with your
  tabs back, or just quit and it installs then. **Stedding › Check for Updates…**, the About
  page and the command bar's **Check for Updates** look at once. Every update is signed with
  the project's own key and checked before it is installed, and the check sends nothing that
  identifies you (`docs/PRIVACY.md`). To stop it, turn off **Update Stedding automatically** in
  Settings › Stedding › Updates; Stedding then makes no update request at all. Windows has no
  updater yet.
- **A thank-you page.** After a fresh install, when the welcome flow ends, and after each
  update, Stedding opens one page on stedding.dev that says thank you and asks whether you
  would sponsor the project on GitHub. The page loads nothing from anywhere else and sets no
  cookie; **Show a thank-you page after an update**, in the same group, turns the update's off.
- **Spaces with their own cookies:**
  - a page's session storage (a half-written form, a draft) comes back after a restart and
    with a reopened tab;
  - sites in such a Space can show notifications at all, which they could not, and a click on
    one reaches the page and the Space that showed it; a window a site's service worker opens
    opens in that Space, with its cookies.
- **After a crash:** Restore puts each window back with its own Spaces, a Blank Window's
  included, on the Space it showed.
- **Also fixed:** a pinned split sits above the Clear line; a Space Arc names twice imports as
  one Space, across imports too; the welcome flow keeps a choice you clicked while it was
  still loading, opens a file chooser for a bookmarks file, and tints the first Space with
  the colour you pick; sleeping tabs and the archive leave a page with an unsaved edit or a PDF
  alone, sleep leaves a tab DevTools is attached to, and a new sleep delay applies to tabs
  already waiting; the Archived page lists the tabs of closed windows and splits; Stedding's
  own pages ignore a malformed message instead of ending the browser; on Windows, a Ctrl+Alt
  shortcut made with the left Alt works on a keyboard layout with AltGr (Polish Programmers
  and others), while AltGr still types.
- **A new default page icon:** a page without an icon of its own shows a globe with "www"
  instead of Chromium's grey one.

### For macOS, coming from beta 15

Drag the new **Stedding** over the old one in Applications, this once. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is. From here on Stedding updates
itself.

### For Windows, coming from beta 15

Close Stedding, then run the installer: this release has the same Chromium number as beta 15,
so Windows installs it as a repair of the same version, which needs Stedding closed (`S-72`).
Your profile, in `%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (68 patches):

- `tooling/dev test all` on the exact build, the version set: 865 unit tests, 20 component tests
  and 132 browser tests (33 of them one at a time after the rest), green, with no retries.
- The updater, end to end, on two copies of this series' build signed with the Developer ID
  (the n-1 check in `docs/HANDOFF.md`, "The updater"): the older one found the newer one on a
  local signed feed ten seconds after launch and downloaded it, "New Stedding Version
  Available" appeared, and a press of it quit the older one cleanly and opened the newer one
  in its place with its tab back. Check for Updates… opened About with "Stedding is up to
  date". A feed changed after it was signed was refused before any download, and a different
  image under a valid feed was downloaded and not installed. The first update through the
  real feed comes with the next release: beta 15 has no updater.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and H.264 + AAC
  decoding real frames, all passed. Its full-screen check was skipped (the Mac was in use) and
  its network check left out (`--offline`): this Mac's outgoing firewall holds a newly signed
  build's first connections until someone answers it. Apple's `syspolicy_check distribution`
  passed it as ready for distribution.
- This build was not used by hand with the real pointer and keyboard.

On Windows 11, on the same series:

- On the release build of this tag, the version set, run in the operator's desktop session:
  852 of 852 unit tests and 124 of 124 browser tests (90 four at a time, then 34 one at a time).
  In the first unit run two Space tests ran out of time; each passed three runs in three on
  its own, and the whole unit run passed when it was run again. `components_unittests` is not
  built on Windows.
- The build with DCHECKs and the dangling-pointer detector found a pointer that patch 0067's
  AltGr handler left dangling at every window's close, which crashed one test at shutdown in
  the release build two runs in four; it is fixed in this release. That build still shows two
  older faults, filed as `S-213` and `S-214`.
- The installer was run for real, as the user, with Stedding closed, over the beta 15 install
  on the Windows PC (the same Chromium number, so a repair), after a backup of the install and
  its profile: the installed `chrome.dll` is this build's, byte for byte, and the profile is
  where it was. One launch of the installed build, on a throwaway profile, drew the window,
  the sidebar and the address row.
- Not used by hand with the real pointer and keyboard on Windows.

On neither platform was this build run under AddressSanitizer (`S-106`).

### Install

#### macOS

`Stedding-0.2.0-beta.16-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later.

#### Windows

`Stedding-0.2.0-beta.16-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first** (see above). It is **not signed**: SmartScreen shows
"Windows protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from
Settings → Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows
yet: a later beta is installed over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.16-arm64.dmg
8ba2c692f13d07348043486923786bf0c53fd6d9beb736931b4724a6e7133df1  Stedding-0.2.0-beta.16-arm64.dmg
```

The macOS image is 178 MB, built on 2026-10-16 from the commit this tag points to; the app in
it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

```
certutil -hashfile Stedding-0.2.0-beta.16-win-x64.exe SHA256
22cf3de9c3a8a169522fcc7d7c065bc143b8812517a8e5d6b8a0ff061bc34d62  Stedding-0.2.0-beta.16-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-10-16 from the commit this tag points to.

### Known limits

- **Chromium is behind.** This release is built on 155.0.8059.12; the stable channel now
  serves 155.0.8059.85, whose security fixes it does not carry, and Chromium 156 is rolling
  out. The next release moves the pin.
- No automatic updates on Windows yet (`S-74`).
- On Windows the installer is unsigned (`S-56`), and over beta 15, which has the same Chromium
  number, it installs as a repair that needs Stedding closed (`S-72`). Little windows and links
  from other applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry,
  the PDF handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md`
  TAB-31).
- Skipping the welcome flow's engine step leaves no default chosen, and Chromium's own "Choose
  your search engine" dialog then opens over the first page, with a globe for every engine
  (`S-134`).
- On the Mac, ⌃1–⌃9 collide with Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable. The rail's names under
  VoiceOver and a Mac under the IncognitoModeAvailability policy are not checked yet
  (`PLAN.md` WIN-3, CMD-7).
- No AddressSanitizer run of this series yet (`S-106`); the Windows build with DCHECKs shows two
  older faults (`S-213`, `S-214`).
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).

## Stedding 0.2.0 beta 15

Chromium **155.0.8059.12** (stable), a **macOS image** for Apple silicon (signed and
notarized), a **Windows x64 preview** (unsigned) and Stedding's patch series
(`patches/README.md`). Beta 14 plus three rounds of fixes and a code review of the whole
series: two ways to close the browser by accident are gone (closing one pane of a split, and
grouping a tab that sits in a folder), Stedding no longer calls Google at startup or asks
Google's Autofill server about the forms you see, deleting a Space no longer wipes the data
of a page still open in it, and a folder you close comes back as one, in order.

### What changed since beta 14

- **Two crashes fixed.** Closing one pane of a split, or a window that held a split, closed
  the browser; so did grouping a tab that sits inside a folder, which any extension can do
  (`chrome.tabs.group`), as can Add Tab to New Group on Chromium's full tab menu. Importing
  from Arc closed it too when Arc's saved passwords held a blocked site with a username, as
  older Arc data can.
- **Privacy:**
  - nothing calls Google at startup: the push service is left alone until a site asks for it,
    and nothing asks Google which accounts your cookies hold;
  - Autofill no longer asks Google's server about every form a page shows, which sent each
    form's signature and the page's address;
  - deleting a Space whose cookies were kept apart waits to wipe them until no page still uses
    them (a form with unsaved changes, a popup), and a wipe that a quit interrupted is finished
    the next time a window opens;
  - Settings → Privacy and security → Security says that Safe Browsing does not work in
    Stedding yet.
- **Folders:** Close Folder's Tabs puts the folder in Recently Closed, and in the Mac's
  History menu, as one entry; Restore Folder and Ctrl+Shift+T (⇧⌘T) bring it back in its
  order and place, also when only part of it was closed, and with Shift held into a new
  window. A split made of a folder's tabs stays in the folder.
- **Split view:** the two pages start right under the address row, a narrow gutter apart,
  with no band of the window between them; a split switched to stacked redraws its corners.
- **The sidebar:** Chromium's tab groups show as rows, a dot in the group's colour and its
  name, or its tab count when it has none, where an unnamed group was a blank coloured bar;
  **Clear** can be reached with Tab and screen readers; a Space chip shows its name once.
- **The command bar:** a typed keyword search opens only the engines the bar offers (no AI
  scopes, and in a private window not your history); a setting changed from the bar stays
  chosen; a late answer no longer moves Enter to another page.
- **Links and routes:** a Chrome shortcut file opened from Finder opens like any link from
  another app (in a little window, or in the Space chosen for such links); an address you type
  no longer takes the place of a link another app is opening at the same moment; host routes
  match IPv6 addresses and the scheme's default port.
- **Private windows:** Back, Forward and Reload sit on the page's colour, where they sat on
  the bare window.
- **Also fixed:** "Continue where you left off" hides in full screen; the welcome flow keeps
  the keyboard focus when a button's label changes; Export Space writes into the folder you
  chose whatever the Space is called; the toast's Undo keeps a tab out of a tab group made
  meanwhile, so its folder comes back; on the Mac, a new profile started after a profile
  move that could not happen makes a keychain key of its own, and while a hidden sidebar
  opens, the address row stays clear of the window's traffic lights.

### For macOS, coming from beta 14

Drag the new **Stedding** over the old one in Applications. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is.

### For Windows, coming from beta 14

Close Stedding, then run the installer: this release has the same Chromium number as beta 14,
so Windows installs it as a repair of the same version, which needs Stedding closed (`S-72`).
Your profile, in `%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On macOS 27 on Apple silicon, on the series this tag carries (66 patches):

- `tooling/dev test all` on the exact build, the version set: 845 unit tests, 20 component tests
  (the keychain, account-check and search legs) and 118 browser tests (33 of them one at a time
  after the rest), green, with no retries.
- A code review of the whole series on 2026-10-15 (`docs/history/archive.md#the-code-review-of-2026-10-15`) found
  what patches 0065 and 0066 fix. Every new test was run against the code without its fix and
  failed; the two crash tests crashed.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and H.264 + AAC
  decoding real frames, and full screen over a themed page, all passed. Its network check was
  left out (`--offline`): this Mac's outgoing firewall holds a newly signed build's first
  connections until someone answers it. Apple's `syspolicy_check distribution` passed it as
  ready for distribution.
- The new tab group header was looked at in a test window of this code. This build was not
  used by hand with the real pointer and keyboard.

On Windows 11, on the same series:

- On the release build of this tag, the version set, run in the operator's desktop session:
  829 of 829 unit tests and 111 of 111 browser tests (77 four at a time, then 34 one at a time),
  the row drags among them. The first unit run had two failures, both the new tab group
  header test's check that the header has no fill: the PC's own pointer sat over the test's
  window, so the header showed its hover tint. The test now keeps its window away from the
  pointer, and the rerun passed. `components_unittests` is not built on Windows.
- The installer was run for real, as the user, with Stedding closed, over the beta 14 install
  on the Windows PC (the same Chromium number, so a repair), after a backup of the install and
  its profile: the installed `chrome.dll` is this build's, byte for byte, and the profile is
  where it was. One launch of the installed build, on a throwaway profile, drew the window,
  the sidebar and the address row.
- Not used by hand with the real pointer and keyboard on Windows.

On neither platform was this build run with DCHECKs and the dangling-pointer detector, or under
AddressSanitizer (`S-106`).

### Install

#### macOS

`Stedding-0.2.0-beta.15-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later. There are no automatic updates yet (`S-74`): a newer Stedding is
dragged over this one.

#### Windows

`Stedding-0.2.0-beta.15-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first** (see above). It is **not signed**: SmartScreen shows
"Windows protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from
Settings → Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows
yet: a later beta is installed over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.15-arm64.dmg
f13bcb52dabd0195fb9f73e915205f1459b7d7d814dec55d87a3ca2ac35123c9  Stedding-0.2.0-beta.15-arm64.dmg
```

The macOS image is 177 MB, built on 2026-10-15 from the commit this tag points to; the app in
it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

```
certutil -hashfile Stedding-0.2.0-beta.15-win-x64.exe SHA256
b91f5fa244c45e4167aaf0bfc7383fc6059327d77053fec985bac29a5579334b  Stedding-0.2.0-beta.15-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-10-15 from the commit this tag points to.

### Known limits

- No automatic updates yet (`S-74`).
- On Windows the installer is unsigned (`S-56`), and over beta 14, which has the same Chromium
  number, it installs as a repair that needs Stedding closed (`S-72`). Little windows and links
  from other applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry,
  the PDF handler's ProgId (`S-71`); the two-finger Space swipe does nothing yet (`PLAN.md`
  TAB-31).
- Skipping the welcome flow's engine step leaves no default chosen, and Chromium's own "Choose
  your search engine" dialog then opens over the first page, with a globe for every engine
  (`S-134`).
- On the Mac, ⌃1–⌃9 collide with Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable. The rail's names under
  VoiceOver and a Mac under the IncognitoModeAvailability policy are not checked yet
  (`PLAN.md` WIN-3, CMD-7).
- No AddressSanitizer run of this series yet (`S-106`).
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).
- The code review of 2026-10-15 left open items in `BACKLOG.md` (`S-179` to `S-189`), among
  them a Space's sessionStorage not kept across a restart (`S-179`) and a Space's service
  workers and notifications acting in the wrong cookie jar (`S-180`).

## Stedding 0.2.0 beta 14

Chromium **155.0.8059.12** (stable), a **macOS image** for Apple silicon (signed and
notarized), a **Windows x64 preview** (unsigned) and Stedding's patch series
(`patches/README.md`). Beta 13 plus two rounds of the operator's requests: nothing is archived
unless you choose it, the welcome flow asks how Stedding should behave, and thirteen backlog
items, among them Undo after closing tabs, Site Search chips and inline completion in the
command bar, and Collapse Pinned Tabs. Beta 13 had no macOS image, so on the Mac this one
brings its changes too: the sidebar can hide completely, new pins go to the bottom, the
sidebar resizes from its edge, and the settings read in sections (beta 13's notes).

### What changed since beta 13

- **Nothing is archived unless you choose it.** Idle tabs used to close into the Archived view
  after 12 hours; now the default is Never. A profile that never changed the setting stops
  archiving after this update; one that chose a time keeps it. A 7-day choice is new.
- **The welcome flow asks how Stedding should behave**, in a new step: archive idle tabs or
  not (Never preselected), shrink the sidebar to icons or hide it completely, and whether a
  Space puts its tabs to sleep after you leave it (Never preselected). Each search engine in
  its first step shows its own mark instead of a globe.
- **Undo after closing tabs.** Ctrl+W, a row's close button, Close Other Tabs, Clear and the
  like show a toast, "“Inbox” closed" or "3 tabs closed", with Undo, which brings them back in
  their Space and folder. Settings → Stedding → Tabs → **Offer Undo after closing tabs** turns
  it off. Toasts now sit in the page under the address row, not over it.
- **The command bar:**
  - typing completes to a site from your history, the rest selected; Enter goes there;
  - type the start of a site's name and press **Tab**: it becomes a chip, and the search
    goes to that site (the sites are Chromium's own search engine settings);
  - **Clear Site Cookies and Reload** (Ctrl+Alt+Shift+R / ⌥⇧⌘R), in a Space's own cookie jar
    when it has one;
  - **Close Duplicate Tabs**, listed while the Space has a duplicate;
  - **New Documents**: a blank Google Doc, Sheet, Slides or Form, Notion page, Figma file,
    GitHub repository or gist, Word, Excel or PowerPoint document (type "new").
- **Folders:** Ctrl+Shift+E (⇧⌘E) collapses every folder of the Space, or expands them all;
  a folder's menu has **New Tab in Folder** and **Alphabetize**; a collapsed folder shows how
  many tabs it holds.
- **Pins:** **Edit Pinned Address…** on a pin's menu; a middle click on a pin sends it home;
  **Collapse Pinned Tabs** on the Space's menu or in the command bar hides the Space's pins
  (the selected one stays), per Space.
- **Keys:** Ctrl+M (⌃M on the Mac) mutes or unmutes the tab; Ctrl+Alt+Shift+P (⌥⇧⌘P) toggles
  picture in picture on the page's video.
- **The sidebar:** resting on its edge draws a thin bar, and a double click there returns it
  to its default width; a middle click on its empty space opens the command bar; Settings →
  Stedding → Sidebar → **Page flush against the window** drops the margin and the rounded
  corners around the page.
- **Settings → Stedding → Pages and menus** has a switch for the link address shown at the
  window's corner on hover.
- **Fixed:** hovering the address bar drew a second, lighter pill behind the address whose
  edge cut the first letter, and the hover band started at the row's far left; it now runs
  from the site-info chip to the star. A folder sorted by Alphabetize kept drawing its old
  order.
- **Only in the macOS image**, from the Mac's own pass on this series after the Windows
  installer was built: with the sidebar hidden, the traffic lights sit on the address row's
  bar, where they sat on a dark patch of the window beside it; the sidebar that slides in
  from the window's edge has the open sidebar's top row, where its row stood a little taller;
  a toast, such as Undo after ⌘W, starts right under the address row, where it crossed the
  line beneath it; and in the welcome flow, an answer that arrives late (the Arc check, the
  list of browsers to import from) no longer takes the keyboard focus off the control that
  had it. The sidebar's row and the welcome flow's focus are in code Windows shares, and its
  next build has them.

### For macOS, coming from beta 12

Drag the new **Stedding** over the old one in Applications. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is. Beta 13 had no macOS image, so
its notes hold for this update as well; the sidebar still shrinks to icons when it closes
until you choose otherwise.

### For Windows, coming from beta 13

Close Stedding, then run the installer: this release has the same Chromium number as beta 13,
so Windows installs it as a repair of the same version, which needs Stedding closed (`S-72`).
Your profile, in `%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On macOS 27 on Apple silicon, on the series at commit `2e48d01`: this tag's 61 patches, with
the Mac's fixes folded into 0059 and 0060.

- `tooling/dev test all` on the exact build: 918 unit tests, 19 component tests (the keychain and
  search legs) and 214 browser tests, green, with no retries.
- The first pass found two faults in the hidden sidebar, the lights' patch and the slid-in
  row's height, and four tests that assumed Windows or raced on the Mac
  (`docs/HANDOFF.md`, traps 79 to 81); a later run found the welcome flow's focus on the page
  after a late answer, in four runs of five; the live pass found the undo toast 6 points over
  the line under the address row. Each product fix has a test:
  `WindowButtonsTest.HiddenTheLightsSitOnTheRowsBar`,
  `SidebarFormsTest.TheLeadingEdgeSlidesItInOverThePage` and
  `WelcomeFlowTest.ALateAnswerKeepsTheFocus` failed before their fixes, and
  `AddressBandTest.AToastLeavesTheAddressReadable` now checks the toast's edge, which the
  same measurement put 6 points over the line before its fix.
- Used with the real pointer and keyboard on fresh profiles, on the release build: the
  sidebar hidden from the command bar, its leading edge sliding it in and out as a hand moves
  the pointer, ⌘S opening and closing it, the toggle naming ⌘S, and with it hidden the traffic
  lights on the address row's bar over a page with a theme colour; ⌃M muting a tab; ⌥⇧⌘R
  clearing the site's cookie before its reload; a folder made from the command bar, ⇧⌘E
  collapsing it (its count on the header) and expanding it; ⌘W's undo toast, right under the
  address row once fixed; the welcome flow's behaviour step, fitting, with Never and Shrink to
  icons chosen. Not tried by hand on the Mac: ⌥⇧⌘P, Site Search chips, New Documents, Close
  Duplicate Tabs, Collapse Pinned Tabs, and the sidebar edge's bar and double click.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and H.264 + AAC
  decoding real frames, and full screen over a themed page, all passed. Its network check was
  left out (`--offline`): this Mac's outgoing firewall holds a newly signed build's first
  connections until someone answers it, and the check timed out behind it. Apple's
  `syspolicy_check distribution` passed it as ready for distribution.

On Windows 11 with Visual Studio 2022, on the series this tag carries (patches 0060 and 0061 on
beta 13's 59):

- Used with the real pointer and keyboard on fresh profiles: the welcome flow's six steps and
  the behaviour step's choices written to the profile; the address bar's hover band; the
  sidebar edge's bar, a drag and the double click back to the default width; the page flush
  on and off; Ctrl+W's toast and its place under the address row; the command bar's new rows;
  a middle click on the sidebar's empty space; a Site Search chip; the New Documents rows;
  Collapse Pinned Tabs and Expand. That use found the toasts covering the address row, fixed
  before this build. Not tried by hand: picture in picture by key, the Edit Pinned Address
  dialog, the folder verbs, Clear Site Cookies on a site you are signed in to.
- The suites, collected in one pass per round and fixed in batches: the first pass found one
  compile error and four faults (the folder's drawn order among them); afterwards both suites
  passed on the release build and on a build with DCHECKs and the dangling-pointer detector:
  904 unit tests and 213 browser tests each. On the release build of this tag, with the version set: 904 of 904 unit tests and 212 of 213 browser tests; the other, `SleepInUseTest`, stopped at its known race typing into a page field and passed three times out of three on its own.
- The installer was run for real, as the user, with Stedding closed, over the beta 13 install on the Windows PC (the same Chromium number, so a repair). It exited 0 and kept the profile, the Start menu shortcut and the uninstall entry; the installed `chrome.dll` was byte for byte the one built, carries the version 0.2.0-beta.14, and opened its window on a fresh profile.

### Install

#### macOS

`Stedding-0.2.0-beta.14-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later. There are no automatic updates yet (`S-74`): a newer Stedding is
dragged over this one.

#### Windows

`Stedding-0.2.0-beta.14-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first** (see above). It is **not signed**: SmartScreen shows
"Windows protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from
Settings → Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows
yet: a later beta is installed over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.14-arm64.dmg
103484513a427828fe5f9dc4ba2b1895b5989e8644227642f6cc856ffecc076d  Stedding-0.2.0-beta.14-arm64.dmg
```

The macOS image is 177 MB, built on 2026-10-12 from the series at commit `2e48d01`; the app in
it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

```
certutil -hashfile Stedding-0.2.0-beta.14-win-x64.exe SHA256
f9fe8fe3ceb2880c9e980168bd72deb7a1ead262b92a5d7f033b21db870224e8  Stedding-0.2.0-beta.14-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-10-12 from the commit this tag points to.

### Known limits

- No automatic updates yet (`S-74`).
- On Windows the installer is unsigned (`S-56`), and over beta 13, which has the same Chromium
  number, it installs as a repair that needs Stedding closed (`S-72`). Little windows and links
  from other applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry,
  the PDF handler's ProgId (`S-71`); the restore infobar stays in full screen (`S-69`); the
  two-finger Space swipe does nothing yet (`PLAN.md` TAB-31).
- Skipping the welcome flow's engine step leaves no default chosen, and Chromium's own "Choose
  your search engine" dialog then opens over the first page, with a globe for every engine
  (`S-134`).
- On the Mac, ⌃1–⌃9 collide with Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable. The rail's names under
  VoiceOver and a Mac under the IncognitoModeAvailability policy are not checked yet
  (`PLAN.md` WIN-3, CMD-7).
- No AddressSanitizer run of this series yet (`S-106`).
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).
- A Space chip shows its name twice after a drag (`S-70`).

## Stedding 0.2.0 beta 13

Chromium **155.0.8059.12** (stable), a **Windows x64 preview** (unsigned) and Stedding's patch
series (`patches/README.md`). Beta 12 plus the operator's pass on it: the sidebar can hide
completely, new pins go to the bottom, the sidebar resizes from its edge, and the settings read
in sections. This tag has no macOS image: its changes reached the Mac with beta 14's
(2026-10-12).

### What changed since beta 12

- **The sidebar can get out of the way completely.** Settings → Stedding → Sidebar → **When
  the sidebar closes: Hide it completely**. Ctrl+S (⌘S) then hides it, and the page and the
  address row fill the window edge to edge, with no border and no rounded corners. Rest the
  pointer at the window's left edge and the sidebar slides back over the page; move away and
  it slides off again. Ctrl+S brings it back for good. "Shrink to icons" stays the default.
  The command bar's actions (Ctrl+Shift+P) have **Hide Sidebar**, **Collapse Sidebar to
  Icons** and **Show Sidebar**.
- **New pinned tabs go to the bottom of the pinned list,** in the order you pin them; they
  went to the top. An unpinned tab moves to the top of the tabs under the Clear line;
  unpinning one from the middle used to leave the pins below it looking like ordinary tabs.
- **The sidebar resizes from its edge.** The pointer turns into the resize cursor right up to
  the page's edge; it only did so a little inside the sidebar.
- **Settings → Stedding reads in sections:** Sidebar first (how it closes, its width, the tab
  row height, the text size, hovering), then Tabs, Pages and menus, Privacy, Spaces and
  Shortcuts. The tab row height was called "Sidebar density".
- **Full screen is edge to edge.** F11 and a video's own full-screen button no longer leave a
  thin border of the window's colour around the page.
- **Smaller fixes:** the selected tab's globe is visible again in dark mode; the sidebar's
  button and the command bar name Ctrl+S, not Ctrl+Shift+L (which did nothing); the icon rail
  has no empty gap under its button; the screenshot notice says "Show in folder" on Windows;
  the shortcut list no longer lists Peek's keys while Peek is off.

### For Windows, coming from beta 12

Close Stedding, then run the installer: this release has the same Chromium number as beta 12,
so Windows installs it as a repair of the same version, which needs Stedding closed (`S-72`).
Your profile, in `%LOCALAPPDATA%\Stedding\User Data`, stays where it is.

### How it was checked

On Windows 11 with Visual Studio 2022, on the series this tag carries (patch 0059 on beta 12's
58):

- Used with the real pointer and keyboard on fresh profiles, in dark and light, in a restored
  and a maximized window: the new settings row, Ctrl+S to each form, the window's left edge
  and the screen's, a click on a row of the slid-in sidebar, Space switches while hidden, F11
  and full screen, pins in every order, and the resize cursor measured across the seam (it
  now runs from 12 px inside the sidebar to the page's edge, and a drag from the gutter
  resizes). That use found the faults listed under the smaller fixes, and two in the new form
  itself, all fixed before this build.
- A review of the whole change before it was cut found eight more, none a crash (among them
  the edge opening a sidebar while F11 showed none, and right-to-left layouts mirrored the
  wrong way); all fixed, with tests.
- A build with DCHECKs and the dangling-pointer detector on ran both suites. All 822 unit tests
  passed; three of the 171 browser tests stopped on one fault: closing the welcome flow left
  the dialog holding a pointer to its page after the page was gone. Nothing used the pointer,
  so no build crashed on it, but it is the kind of fault that turns into one. The fix is in
  patch 0015, and on the rebuilt DCHECK build all 171 browser tests passed.
- `tooling/dev test unit` and `tooling/dev test browser` on the release build, with that fix: all
  822 unit tests and all 171 browser tests passed.
- The installer was run for real, as the user, with Stedding closed, on the Windows PC: its
  first build over the beta 12 install (the same Chromium number, so a repair), and this one,
  rebuilt with the fix above, over that. Each exited 0 and kept the profile, the Start menu
  shortcut and the uninstall entry, and each time the installed `chrome.dll` was byte for byte
  the one built. On the first, the About page read "Stedding 0.2.0-beta.13 · Chromium
  155.0.8059.12", and the installed build, on a fresh profile, hid its sidebar and slid it back
  in from the window's edge; this one opened on a fresh profile with its welcome flow.

### Install

#### Windows

`Stedding-0.2.0-beta.13-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first** (see above). It is **not signed**: SmartScreen shows
"Windows protected your PC" — click **More info**, then **Run anyway**, once. Uninstall from
Settings → Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows
yet: a later beta is installed over this one.

#### macOS

No macOS image in this drop.
[Beta 14](https://github.com/ysalitrynskyi/stedding-browser/releases/tag/v0.2.0-beta.14)'s
`Stedding-0.2.0-beta.14-arm64.dmg` carries these changes to the Mac, signed and notarized.

### Checksum

```
certutil -hashfile Stedding-0.2.0-beta.13-win-x64.exe SHA256
cc582f0110f9cabfd002e1aa07c7bad3cbdf5b46a7b5f7f081a0efe5e955aba7  Stedding-0.2.0-beta.13-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-10-11 from the commit this tag points to.

### Known limits

- No automatic updates yet (`S-74`).
- On Windows the installer is unsigned (`S-56`), and over beta 12, which has the same Chromium
  number, it installs as a repair that needs Stedding closed (`S-72`). Little windows and links
  from other applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry,
  the PDF handler's ProgId (`S-71`); the restore infobar stays in full screen (`S-69`); the
  two-finger Space swipe does nothing yet (`PLAN.md` TAB-31). The Windows clipboard history
  (Win+V) was not looked at.
- The hidden sidebar reached the Mac with beta 14, with two fixes the Mac's own pass found
  (beta 14's notes).
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).
- Every search engine in the welcome flow's first step shows a globe for an icon (`S-77`).
- A Space chip shows its name twice after a drag (`S-70`).

## Stedding 0.2.0 beta 12

Chromium **155.0.8059.12** (stable), the **macOS image** (Apple silicon, signed and
notarized) and a **Windows x64 preview** (unsigned), Stedding's patch series
(`patches/README.md`). Beta 11 plus the things its own live pass logged instead of fixing,
now fixed. The Windows installer joined the release later the same day, built on the Windows
PC from the series at commit `abc3cd4`: the tag's, plus the welcome flow's keys step fitted to
Windows (below) and changes to tests only. Beta 11 had no Windows installer, so its changes
reach Windows with this one; its notes list them.

### What changed since beta 11

- **Switching Space no longer squeezes the list.** The new Space's rows used to open from
  nothing for the first moment of the slide; they now arrive in their places and only the
  list slides in.
- **⌘T on an empty New Tab uses that tab.** With a fresh New Tab page in front, what you open
  from ⌘T goes into it, as in Arc, instead of opening a second tab beside an empty one. A tab
  with a page in it keeps its page.
- **The Clear line shows on every Space colour.** On a tinted Space the line between the
  pinned tabs and the rest had all but disappeared.
- **The welcome flow fits.** A step with more below than the dialog shows now fades out at
  the bottom until you scroll to its end (the import step does when Arc is installed), and
  the keys step fits without scrolling. It no longer teaches ⌘O, which belongs to Peek, and
  Peek is off for now.
- **Settings → Stedding → Shortcuts** notes that Arc, while it runs, takes ⌥⌘N from every app
  for its Little Arc window.
- **On Windows the welcome flow's keys step fits too.** Windows spells its keys out
  (Ctrl+Alt+Shift+2), and four of the step's rows wrapped and ran it 44 px under its footer;
  the list now takes the dialog's width. Windows is also no longer told that a two-finger swipe
  changes Space: the swipe works on the Mac only so far. The macOS image does not carry this
  change and does not need it; its step fits.

### For macOS, coming from beta 11

Drag the new **Stedding** over the old one in Applications. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is. From beta 10 or earlier, the
notes of beta 11 and beta 10 hold as well.

### How it was checked

On macOS 26 on Apple silicon, on the series this tag carries:

- `tooling/dev test all` on the exact build: 831 unit tests (Chromium's own suites around what
  the series touches among them), 19 component tests (the keychain and search legs) and 160
  browser tests, green.
- Each fix has a test that failed before it: `SpaceSwitchTest.ASwitchPutsTheRowsInPlaceAtOnce`
  (the rows started at no height), `CommandBarViewTest.AnUntouchedNewTabTakesWhatIsTyped`,
  `ClearLineTest.TheLineIsTheRowsTextColour`, `WelcomeFlowTest.*` (the keys step ran 16 px
  under its footer) and `ShortcutReferenceTest.ArcsSplitKeyNoteIsPresent`.
- Seen on the release build: on a copy of a large Arc-imported profile, a switch to a Space of
  ten rows with every row in place 10 ms after it, and the Clear line visible on a tinted
  Space; on a fresh profile, ⌘T into the first New Tab leaving one row, the welcome flow's
  import step fading into its footer and its keys step fitting, and the Arc note in Settings.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and H.264 + AAC
  decoding real frames, full screen over a themed page and navigation, all passed; Apple's
  `syspolicy_check distribution` passed it as ready for distribution.

On Windows 11 with Visual Studio 2022, on the series at commit `abc3cd4`:

- `tooling/dev test unit` and `tooling/dev test browser` on the exact build: 817 unit tests,
  green, and 157 of the 161 browser tests (the four others are below). The first run found the
  welcome flow's keys step under its footer, fixed above; the click tests run at a display
  scale of 1 now, because at 150 % Chromium's test event generator misplaces a click
  (`docs/HANDOFF.md` trap 68).
- The installer was run for real, as the user, with Stedding closed, over an install of this
  series built an hour earlier, whose own installer had gone in over beta 10 (both the same
  Chromium number, so repairs). Both exited 0 and kept the profile, the Start menu shortcut
  and the uninstall entry; afterwards the installed `chrome.dll` and `resources.pak` were byte
  for byte the ones built, and the installed build opened a page on a fresh profile.
- Not done on Windows for this drop: the four tests that drag a row, which need the window in
  the foreground and so could not run unattended (trap 67; they pass on the Mac on this
  series), and a pass with the real pointer and keyboard. What changed since beta 10 was seen
  live on the Mac (above, and in beta 11's notes).

### Install

#### macOS

`Stedding-0.2.0-beta.12-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later. There are no automatic updates yet (`S-74`): a newer Stedding is
dragged over this one.

#### Windows

`Stedding-0.2.0-beta.12-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first.** This build has the same Chromium number as beta 10, which
the installer reads as a repair of the same version, and a repair cannot replace the files a
running Stedding holds (`S-72`). It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any app.
Windows 10 and 11, x64. There are no automatic updates on Windows yet: a later beta is installed
over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.12-arm64.dmg
73cbca904988718a638407f914d0ca7568fdfcdb9c7118f50d8fd1d30adb7842  Stedding-0.2.0-beta.12-arm64.dmg
```

The macOS image is 177 MB, built on 2026-10-02 from the commit this tag points to; the app
in it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

```
certutil -hashfile Stedding-0.2.0-beta.12-win-x64.exe SHA256
8e935c52ce0842fe443d0ff0b521d9f18e5e2793823d056107b662400d64a5bc  Stedding-0.2.0-beta.12-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-10-02 from the series at commit
`abc3cd4`.

### Known limits

- No automatic updates yet (`S-74`).
- On Windows the installer is unsigned (`S-56`), and over beta 10, which has the same Chromium
  number, it installs as a repair that needs Stedding closed (`S-72`). Little windows and links
  from other applications open as tabs (`S-56`); uninstalling leaves one harmless registry entry,
  the PDF handler's ProgId (`S-71`); the restore infobar and the card's border stay in full
  screen (`S-69`); a window under about 900 px with the sidebar open leaves the address field
  little room (its own minimum), so widen the window or collapse the sidebar (Ctrl+S); the
  two-finger Space swipe does nothing yet (`PLAN.md` TAB-31). The Windows clipboard history
  (Win+V) was not looked at.
- While Arc is running it takes ⌥⌘N from every app, so ⌥⌘N opens Arc instead of a split; quit
  Arc, or use **New Split View with Current Tab** on a tab's right-click menu (`S-79`).
- Every search engine in the welcome flow's first step shows a globe for an icon (`S-77`).
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second desktop
  exists; the Spaces menu keeps the commands reachable.
- The rail's names under VoiceOver and a Mac under the IncognitoModeAvailability policy are
  not checked yet (`PLAN.md` WIN-3, CMD-7). In dark mode a page with no icon shows a faint
  globe on the active row (`S-73`). A Space chip shows its name twice after a drag (`S-70`).

## Stedding 0.2.0 beta 11

Chromium **155.0.8059.12** (stable), the **macOS image** (Apple silicon, signed and
notarized), Stedding's patch series (`patches/README.md`). This beta is the owner's report
on beta 10 and what a pass over the Mac build with the real pointer and keyboard found
after it. This tag has no Windows installer: the fixes here are in the shared series,
and they reached Windows with beta 12's installer (2026-10-02).

### What changed since beta 10

- **Tabs select on a click again, in long lists.** With a long list the sidebar's empty
  bottom bar sat hidden over the rows, and the window read every press there as a drag of
  the window: a click worked once and then got stuck. Rows click in the open sidebar and
  in the collapsed rail.
- **Tabs brought over from Arc load after a restart.** They came back as crashed pages: a
  tab the import made without loading it saved a value the next start rejected.
- **Collapsing the sidebar keeps the address bar.** ⌘S used to hide the address row with
  the sidebar, which read as the address bar disappearing. The row stays now; Settings →
  Stedding → "Hide the address row with the sidebar" brings the old behaviour back, and
  ⇧⌘D shows or hides the row on its own.
- **The address row is the colour of the page's top edge, exactly.** Many sites draw their
  colour with a layer the page's declared colour knows nothing of (a saturated purple site,
  a sign-in page in dark mode); the row now reads the colour the page draws along
  its top, then the declared colour. It is read in the right colour space, so a saturated
  page and its row match to the unit, and full screen does the same with one hairline
  under the row.
- **The Space swipe follows your fingers.** The Space's title and list move with a
  two-finger swipe across the sidebar and fade; lifted short they spring back, lifted
  past the distance the next Space slides in from the side your fingers left.
- **Switching Space is quick with hundreds of tabs.** On a large imported profile a switch
  showed nothing for half a second; it now shows the new Space in under a tenth of a second.
- **Space chips stay icons longer.** The gaps between them close up before they turn to
  dots, so eight Spaces fit as icons in an ordinary sidebar.
- **Smaller things:** folder names are readable in light mode; the collapsed rail no
  longer draws a clipped "Clear" label.

### For macOS, coming from beta 10

Drag the new **Stedding** over the old one in Applications. Your profile, in
`~/Library/Application Support/Stedding`, stays where it is. Everything in beta 10's notes
about the move from beta 8 still holds for anyone coming from beta 8 or earlier.

### How it was checked

On macOS 26 on Apple silicon, on the series this tag carries:

- `tooling/dev test all` on the exact build: 828 unit tests (Chromium's own suites around
  what the series touches among them), 19 component tests (the keychain and search legs) and
  157 browser tests, green. The five fixes from the live pass below each have a test that
  failed without them.
- The window used with the real pointer and keyboard, on a copy of a large Arc-imported
  profile and on a fresh one: three restarts with the last session (no crashed tabs, the
  imported tabs load), clicks in the open sidebar and the rail, ⌘S, swipes short and long,
  ⌃1–⌃9, full screen in and out, the row's colour measured against the page on five pages,
  a video pin sent home with Option-click and then its own fullscreen button, Esc and the
  window's close button, the View menu's "Always Show Full URLs", the welcome flow, ⌘T,
  folders, a drag onto a folder, a split, Settings, light and dark.
- `tooling/verify-build` on the signed app: the page, WebGL 1 and 2, VP9, AV1 and
  H.264 + AAC decoding real frames, full screen over a themed page and navigation, all
  passed; Apple's `syspolicy_check distribution` passed it as ready for distribution.

### Install

#### macOS

`Stedding-0.2.0-beta.11-arm64.dmg`: check the checksum below, open the DMG, drag
**Stedding** to Applications and open it. It is signed with the project's Developer ID and
notarized by Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and
macOS 13 or later. There are no automatic updates yet (`S-74`): a newer Stedding is
dragged over this one.

#### Windows

No Windows installer in this drop. Beta 12's `Stedding-0.2.0-beta.12-win-x64.exe` carries
these changes to Windows.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.11-arm64.dmg
572688a55a61572c08ee22629b2daabc474d5d2e14df17ea98901fcd3903e4bb  Stedding-0.2.0-beta.11-arm64.dmg
```

The macOS image is 177 MB, built on 2026-10-02 from the commit this tag points to; the app
in it is signed with the project's Developer ID and notarized by Apple, the ticket stapled.

### Known limits

- No automatic updates yet (`S-74`).
- While Arc is running it takes ⌥⌘N from every app for its Little Arc window, so ⌥⌘N
  opens Arc instead of a split; quit Arc, or use **New Split View with Current Tab** on a
  tab's right-click menu (`S-79`).
- The welcome flow's import step runs under its footer when Arc is installed: scroll it to
  reach Firefox and the bookmarks file (`S-76`). Every search engine in its first step shows
  a globe for an icon (`S-77`).
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second desktop
  exists; the Spaces menu keeps the commands reachable.
- The rail's names under VoiceOver and a Mac under the IncognitoModeAvailability policy are
  not checked yet (`PLAN.md` WIN-3, CMD-7). In dark mode a page with no icon shows a faint
  globe on the active row (`S-73`). A Space chip shows its name twice after a drag (`S-70`).

## Stedding 0.2.0 beta 10

Chromium **155.0.8059.12** (stable): the **macOS image** (Apple silicon, signed and
notarized) and a **Windows x64 preview** (unsigned), Stedding's patch series
(`patches/README.md`). The Windows installer went out on 2026-09-30. The macOS image joined
it on 2026-10-01, once the Mac had built this series and proved the profile move on a real
beta 8 profile and the keychain copy with beta 8's own data (`PLAN.md` PLT-1, WEB-1).

### What changed since beta 9

- **The address bar shows the whole address, always.** A click used to leave only the bare
  host ("google.com") selected. The scheme, the host, the path, the query and the fragment are
  now there at rest and after a click; the host keeps the text colour and the rest is a step
  dimmer. It is Chromium's "Always show full URLs", on from the first launch: right-click the
  address bar to turn it off and get the bare host back.
- **The address field takes the row.** In a window 1688 px wide it was a pill of about 220 px;
  it now spans the row between the buttons, so a long address can be read, and it still gives
  way in a narrow window. At rest the address is centred on the page; it is left-aligned while
  you edit it and when it fills the field.
- **The command bar stays inside a narrow window.** At 1035 px with the sidebar open, Ctrl+T's
  bar started over the sidebar and ran past the window's edge with its corner cut off; it now
  sits inside the page with its corners.
- Everything else is beta 9's: Chromium 155 and the audit's Phase 0 fixes (its notes list them).

### For macOS, coming from beta 8

This is the first macOS image on Chromium 155, so everything in beta 9's notes is new on the
Mac as well as beta 10's address bar and command bar. And for the Mac alone:

- **Signed and notarized.** The first Stedding build signed with the project's Developer ID
  and notarized by Apple: it opens with a double-click, with no Terminal step.
- **Your profile moves to Stedding's own folder.** Up to beta 8 the Mac builds kept it in
  `~/Library/Application Support/Chromium`. The first launch copies it to
  `~/Library/Application Support/Stedding` and leaves the old folder as it was. If another
  browser is using the old folder at that moment, Stedding asks first: **Quit**, close that
  browser and open Stedding again, or **Start a New Profile** and leave the old one where it
  is. If `~/Library/Application Support/Stedding` already holds a profile (a development
  build made one), nothing is moved: quit Stedding, rename that folder, and open Stedding again.
- **Saved passwords and sign-ins come along.** The key that encrypts them is copied to the
  keychain item "Stedding Safe Storage". macOS may ask once to let Stedding use
  "Chromium Safe Storage": click **Allow**.
- **The collapsed sidebar clears the window's buttons.** The red, yellow and green buttons
  sit over the rail, centred above its rows, and no longer on the page's corner.
- **Full screen keeps no empty band at the top of the sidebar.** The sidebar's toggle sits
  on the toolbar's row, and the sidebar's rows start right under it.

### The macOS image and the tag

The tag points at the commit the Windows installer was built from. The macOS image is built
from the series at 9c9b7a7: that series plus three changes for the Mac, the question
before a launch would leave a profile behind in Chromium's folder (patch 0057), the rail's
width (patch 0039) and the full-screen toggle (patch 0057). None of them changes what Windows
does, and the Windows installer is the one built from the tag.

### How it was checked

On macOS 26 on Apple silicon, on the series above:

- `tooling/dev test all` on the exact build: 815 unit tests, with the keychain and search
  legs, and 151 browser tests, green. Each of the three Mac changes has a test that fails
  without it.
- The profile move, with the release build, on a copy of a real beta 8 profile: no Stedding
  folder; a Stedding folder holding only `Crashpad`; beta 8 running on the old folder (the
  question, **Quit**, then the move once beta 8 had quit); and a profile that Chromium itself
  made, which was left alone. The moved profile opened with its Spaces, its pinned tab, its
  last session and its extensions.
- The keychain, with the real login keychain: a fresh profile made its own
  "Stedding Safe Storage" item and never read Chromium's; a profile made by beta 8, holding a
  cookie sealed under "Chromium Safe Storage", still sent that cookie after the move, on the
  first launch and on the next.
- The window used with the real pointer and keyboard: rows of every kind clicked in the open
  sidebar and in the rail, the address bar on google.com and on a 160-character address in a
  wide window and at 1035 px, the command bar in that narrow window, the welcome flow's
  wording, light and dark, and full screen in and out.

On Windows 11 with Visual Studio 2022, on a 155.0.8059.12 checkout:

- `tooling/dev test unit` and `tooling/dev test browser` on the exact build: 802 unit tests and
  153 browser tests, green (beta 9 had 800 and 151; two of each are new), and green again on a build with
  DCHECKs and the dangling-pointer detector on (the same 802 and 153).
- The window was used with the real pointer and keyboard, on the build before the change and on
  this one: google.com and a 170-character address at rest and clicked in a window of 1688 px,
  windows of 1400, 1100, 1035 and 820 px, an http page, the suggestions dropdown, Ctrl+L, the
  About page (`Stedding 0.2.0-beta.10 · Chromium 155.0.8059.12`).
- The installer was run for real, as the user: over an installed beta 9 with Stedding closed (the same Chromium number, so a repair), it exited 0 and the installed `chrome.dll` is, byte for byte, the one built, with the profile, the Start menu shortcut and the uninstall entry kept; the installed build then opened on a fresh profile and on a copy of the real profile (its Space and last page restored, the whole address in the bar, `Last Version` unchanged). Uninstalling and installing from nothing were last run on beta 9's installer, which this one is built the same way as.

The lifetime suites under AddressSanitizer were last run on beta 9's tree. This release adds an
integer to a view and changes no ownership.

### Install

#### macOS

`Stedding-0.2.0-beta.10-arm64.dmg`: check the checksum below, open the DMG, drag **Stedding**
to Applications and open it. It is signed with the project's Developer ID and notarized by
Apple, so macOS opens it with no extra step. Apple silicon (M1 or later) and macOS 13 or
later. To update later, drag a newer Stedding over this one: there are no automatic updates
yet (`S-74`).

#### Windows

`Stedding-0.2.0-beta.10-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding install if
there is one. **Close Stedding first.** This build has the same Chromium number as beta 9, which
the installer reads as a repair of the same version, and a repair cannot replace the files a
running Stedding holds (`S-72`). It is **not signed**: SmartScreen shows "Windows protected your
PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as any app.
Windows 10 and 11, x64. There are no automatic updates on Windows yet: a later beta is installed
over this one.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.10-arm64.dmg
f1b06087fd4d7402d6c1881226b4bcb358c73ad9184e35ae6c8204a5a592a7e5  Stedding-0.2.0-beta.10-arm64.dmg
```

The macOS image is 177 MB, built on 2026-10-01 from the series at 9c9b7a7 and
notarized by Apple.


```
certutil -hashfile Stedding-0.2.0-beta.10-win-x64.exe SHA256
773f3d090a219506740446d4a139ea9bc898cd2fe88eaa0a67d6c38190719fe5  Stedding-0.2.0-beta.10-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-09-30 from the series at the commit this tag
points to.

### Known limits

- Unsigned, and no updates on Windows (`S-56`); a release on the same Chromium number as the
  installed one needs Stedding closed (`S-72`).
- Little windows and links from other applications open as tabs on Windows (`S-56`).
- Uninstalling leaves one harmless registry entry, the PDF handler's ProgId (`S-71`).
- The restore infobar and the card's border stay in full screen (`S-69`); a Space chip shows its
  name twice after a drag (`S-70`).
- A window under about 900 px with the sidebar open leaves the address field little room (its own
  minimum); widen the window or collapse the sidebar (Ctrl+S).
- The Windows clipboard history (Win+V) was not looked at: the copy-link and screenshot keys write
  the clipboard and a test reads it back.
- No automatic updates on either platform yet (`S-74`).
- On the Mac, the rail's names under VoiceOver and a Mac under the IncognitoModeAvailability
  policy are not checked yet (`PLAN.md` WIN-3, CMD-7). In dark mode a page with no icon shows a
  faint globe on the active row (`S-73`).

## Stedding 0.2.0 beta 9

Chromium **155.0.8059.12** (stable), a **Windows x64 preview**, Stedding's patch
series (`patches/README.md`). Unsigned, like the earlier betas — see *Install* below.
This release carries the Windows image alone: macOS users stay on beta 8 (Chromium
153.0.8010.53) until the Mac has built this series and proved the two things only a
Mac can (the keychain copy and the profile migration on a real beta 8 profile,
`PLAN.md` Phase 0). The Windows build depends on neither.

### What changed since beta 8 (macOS) and beta 6 (Windows)

- **Chromium 155.0.8059.12.** Google's early-stable M155 build, taken from M153 in one step
  (`docs/decisions/0007-chromium-version-pin.md`). All 57 patches applied to it with no conflict.
- **The audit's Phase 0** (`PLAN.md`): a full review of the series on 2026-09-26 found
  crashes, data loss and privacy promises that were false. This is the first release
  with the fixes (patches 0053 to 0057), each proved on a real window.
  - *Clicks.* A hovered row in the collapsed rail keeps its favicon instead of showing
    a close button where it was. A plain click on a drifted pin selects it; Alt-click
    resets it, and a reset no longer leaves the window's close button dead.
  - *Crashes.* Opening a link from a tab in a folder, dropping a link on a folder,
    switching to horizontal tabs and back, the Spaces page in Settings after its
    window closed, a folder row reading a freed folder when a window closed, "Close
    all windows" then Stay.
  - *Commands.* Clear keeps folders and opens a new tab rather than closing the
    window. Deleting the active Space shows its neighbour first and asks before it
    deletes. Sleep defaults to Never and skips a tab that is playing,
    captured, in picture-in-picture, full screen, has unsaved form input or a
    beforeunload handler.
  - *Restore.* Nested folders, collapsed folders, tab names and pins' home pages come
    back after a restart.
  - *Privacy that is now true.* HTTPS-First follows its setting (it was off while it
    said on); DuckDuckGo is the fallback engine in every region; Chrome's registry
    key for extensions is not read; Delete browsing data reaches every Space's own
    session; an isolation change reaches every window and says how many pages it
    reloads first; the adaptive notification choice is off by default with the quiet
    prompt on.
  - *Peek* is off by default while it is rebuilt.
  - The Space's list slides in from the side of the Space being entered.
- **Independent sessions and the keep-pile** (beta 7 and 8, now on Windows too): a
  Space can keep its own cookies, cache and site data; Clear Independent Session;
  `@Space` and keyword search in the command bar; Focus and Hide Other Spaces.
- **Fixed on Windows, found by using it.** The welcome flow, a tooltip and three
  command-bar rows spoke the Mac ("on this Mac", "macOS asks once", "⌘T", "⌘W"); they
  now say "this computer", "Windows opens its Default apps settings", Ctrl+T and
  Ctrl+W. In light mode the inactive rows' text was a pale grey on the sand ground,
  about 1.2:1; it is 6.5:1, and a test holds 4.5:1 in both modes.
- **Cut** (nothing called them, or the specs no longer described them): scheduled
  sidebar backups and restore from a backup (export a Space to a file still works),
  automatic turning of imported bookmarks into pins (on demand from Ctrl+T instead),
  throwaway Spaces, copy-tab and a few helpers.

### How it was checked

On Windows 11 with Visual Studio 2022, on a 155.0.8059.12 checkout:

- `tooling/dev test all` and `tooling/dev test browser`: 800 unit tests and 151 browser
  tests that click real rows in real windows, green on the release build, on a build
  with DCHECKs and the dangling-pointer detector on, and under AddressSanitizer. The
  DCHECK build found twelve defects in a tree whose suites were green; all are fixed
  (`docs/HANDOFF.md`, traps 57 and 60).
- The window was used for real with the pointer and the keyboard on a fresh profile,
  in light and in dark: every kind of row, the rail, a drag onto a folder and onto a
  Space chip, Alt+digit and Ctrl+Alt+arrows, the clean-link and Markdown-link keys, the
  screenshot keys, a video's full-screen button after a pin reset (trap 58).
- The installer was run for real, as the user, outside any sandbox: over an installed
  beta 6 (the profile kept, the old version's folder replaced); on a copy of that
  profile (its session restored, `Last Version` moved from 153.0.8010.12 to
  155.0.8059.12); uninstalled (the program, its registry entries and its Start menu
  shortcut gone, the profile kept); and installed again from nothing. A fresh profile
  opened on the welcome flow, its five steps in Windows' words, and About reads
  "Stedding 0.2.0-beta.9 · Chromium 155.0.8059.12".

### Install (required reading — unsigned build)

This build is **not signed**. The macOS steps belong to beta 8's notes; there is no
macOS image in this drop.

#### Windows

`Stedding-0.2.0-beta.9-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over an earlier Stedding
install if there is one. It is **not signed**: SmartScreen shows "Windows protected
your PC" — click **More info**, then **Run anyway**, once. Uninstall from Settings →
Apps, as any app. Windows 10 and 11, x64. There are no automatic updates on Windows
yet: a later beta is installed over this one.

### Checksum

No macOS image for this beta: the current one is beta 8's.

```
certutil -hashfile Stedding-0.2.0-beta.9-win-x64.exe SHA256
2d3f29f31f6b79f7349882b144fa880133694fc5f9708be365a36fc2c5e95d9c  Stedding-0.2.0-beta.9-win-x64.exe
```

The Windows installer is 166.6 MB, built on 2026-09-30 from the series at the
commit this tag points to.

### Known limits

- Unsigned, and no updates on Windows (`S-56`).
- Little windows and links from other applications open as tabs on Windows (`S-56`).
- Uninstalling leaves one harmless registry entry, the PDF handler's ProgId (`S-71`).
- The command bar can run past the window's right edge in a narrow window (`S-68`); the
  restore infobar and the card's border stay in full screen (`S-69`); a Space chip shows
  its name twice after a drag (`S-70`).
- The Windows clipboard history (Win+V) was not looked at: the copy-link and screenshot
  keys write the clipboard and a test reads it back.
- The Mac-only Phase 0 items (keychain, profile migration, VoiceOver, a managed-policy
  Mac) are open until the Mac builds this series.

## Stedding 0.2.0 beta 8

Chromium **153.0.8010.53** (stable), macOS **arm64**, Stedding's patch series
(`patches/README.md`). Unsigned, like the earlier betas — see *Install* below. The
Windows installer for this tag is not in this drop; it joins the same release from
the Windows PC.

### What changed since beta 7

- **Chromium 153.0.8010.53.** The security point release of 2026-09-17: sixteen
  fixes, two of them critical (a use-after-free in Dawn, a buffer overflow in WebGL).
  Beta 7 was on .48. The series is 48 patches; one (the Windows install mode)
  needed a hand merge against upstream's new "old COM ids" fields.
- **Independent sessions, second pass** (`docs/features/sessions.md`). Turning
  *Independent session* off and on again now reattaches the same jar with its
  logins; beta 7 gave the Space a fresh, empty jar each time and left the old one
  on disk. Moving a tab into or out of an isolated Space keeps its history and
  its name, and a sleeping tab stays asleep instead of waking to reload. A new
  **Clear Independent Session** row on the Space chip menu empties an isolated
  Space's cookies, site data and cache in place. A Blank Window's isolated Spaces
  keep their jars in memory only. A Space you isolated in beta 7 stays isolated.
- **Focus This Space** and **Hide Other Spaces** in the command bar now do what
  they say: the switcher shows the active chip alone, with no "+", until you leave
  Focus or show the others again (`docs/features/focus.md`, `share-coat.md`).
- **New in the command bar** (`docs/features/commandbar.md` K18–K19): `gh rust
  iterators` searches with the engine whose keyword is `gh`; `@Work rust` limits
  the open and archived rows to Spaces named Work….
- **Splits restore as a pair** and a rename applies to both panes
  (`docs/features/splits.md` J1).
- Withdrawn: the *Open in Throwaway* row. A throwaway Space came back after a
  restart with an empty jar; it returns when closing it forgets it
  (`docs/features/throwaway.md`).

The release sweep on this build: `tooling/dev test all` and `tooling/dev test upstream`
— every Stedding filter and Chromium's own suites around what the series touches —
all green. `tooling/verify-build` passed (page, WebGL 1 and 2, VP9, AV1, H.264+AAC,
navigation). The README's captures are from this build (`tooling/capture-state`).

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once the Developer
ID certificate is in the keychain). macOS calls it "damaged and can't be opened" on
a double-click, and right-click → Open does not get past that; the app is fine, the
download mark is what macOS refuses:

1. Check the checksum below, then open the DMG and drag **Stedding** to Applications.
2. In Terminal, once: `xattr -dr com.apple.quarantine /Applications/Stedding.app`
3. Open Stedding. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.
(Corrected 2026-09-19: the first version of these notes gave right-click → Open,
which does not work for this build.)

#### Windows

The Windows installer for beta 8 is not published yet. Beta 6's
`Stedding-0.2.0-beta.6-win-x64.exe` remains the current Windows preview until a
current tag gains its `.exe` from the Windows PC (`S-56`).

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.8-arm64.dmg
9f3d1ce363ceda29c3d59c2a8c5e8547945d36fb1ae57d2274a2cfddee676cb2  Stedding-0.2.0-beta.8-arm64.dmg
```

The DMG is 178 MB, built on 2026-09-18 on macOS from the commit that carries
this pin and the second pass on independent sessions.

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- ⇧⌘C reaches the browser only when no other app owns the chord system-wide (the
  Maccy clipboard manager takes it by default); the File menu row always works.
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable.
- On Windows, Ctrl+Alt with an arrow is also the display-rotation hotkey some
  Intel graphics drivers install; turn that off in the driver if the two collide.
- The Windows preview has no updates and no signature, and links from other
  applications open as tabs rather than in a little window (M8, `S-56`). Linux
  comes after (M9).

## Stedding 0.2.0 beta 7

Chromium **153.0.8010.48** (stable), macOS **arm64**, Stedding's patch series
(`patches/README.md`). Unsigned, like the earlier betas — see *Install* below. The
Windows installer for this tag is not in this drop; it joins the same release from
the Windows PC.

### What changed since beta 6

- **Chromium 153.0.8010.48.** A security point release on the same milestone as
  beta 6 (153.0.8010.12). QUALITY's clock started on 2026-09-15; this closes it.
  The series is 46 patches; toast ids in 0017 and 0027 moved past upstream's new
  `kDictationNoMicrophoneError`.
- **Independent sessions.** A Space can keep its own cookies and site data, so the
  same site can be signed into with a different account in another Space. Off by
  default; the Space chip menu, Settings → Stedding, or the command bar. Essentials
  stay shared. (`docs/features/sessions.md`, patch 0046, ADR 0019)

The release sweep on this build: `tooling/dev test all` and `tooling/dev test upstream`,
581 cases — every Stedding filter and Chromium's own suites around what the series
touches — all green. `tooling/verify-build` passed (page, WebGL 1 and 2, VP9, AV1,
H.264+AAC, navigation). Captures of the window, the command bar, the rail, a private
window and the welcome flow were taken with `tooling/capture-state` and measured
(`tooling/check-geometry`, `tooling/probes/window.json`).

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once the Developer
ID certificate is in the keychain). macOS calls it "damaged and can't be opened" on
a double-click, and right-click → Open does not get past that; the app is fine, the
download mark is what macOS refuses:

1. Check the checksum below, then open the DMG and drag **Stedding** to Applications.
2. In Terminal, once: `xattr -dr com.apple.quarantine /Applications/Stedding.app`
3. Open Stedding. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.
(Corrected 2026-09-19: the first version of these notes gave right-click → Open,
which does not work for this build.)

#### Windows

The Windows installer for beta 7 is not published yet. Beta 6's
`Stedding-0.2.0-beta.6-win-x64.exe` remains the current Windows preview until the
same tag gains its `.exe` from the Windows PC (`S-56`).

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.7-arm64.dmg
6ddd4725830f049b365e6423f634bac421b70dd61f5a508cab1811e2114956ae  Stedding-0.2.0-beta.7-arm64.dmg
```

The DMG is 178 MB, built on 2026-09-16 on macOS from the commit that carries this
pin and independent sessions.

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- ⇧⌘C reaches the browser only when no other app owns the chord system-wide (the
  Maccy clipboard manager takes it by default); the File menu row always works.
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable.
- On Windows, Ctrl+Alt with an arrow is also the display-rotation hotkey some
  Intel graphics drivers install; turn that off in the driver if the two collide.
- The Windows preview has no updates and no signature, and links from other
  applications open as tabs rather than in a little window (M8, `S-56`). Linux
  comes after (M9).

## Stedding 0.2.0 beta 6

Chromium **153.0.8010.12** (stable), macOS **arm64** and a **Windows x64 preview**,
Stedding's patch series (`patches/README.md`). Both unsigned, like the earlier
betas — see *Install* below. Beta 5 was the Windows preview alone; this release
carries everything it had.

### What changed since beta 5

Round 9 (`docs/history/archive.md#the-operators-rounds`): the operator's first three minutes in the Windows
preview, and the keyboard map it did not have.

- **Stedding's keys on Windows.** Arc's Windows keyboard: Ctrl+S collapses the
  sidebar (Save Page moves to Ctrl+Shift+S), Ctrl+D pins the tab in its Space,
  Ctrl+Shift+D shows or hides the address row, Alt+1–9 jump to a Space and
  Ctrl+Alt+←/→ step through them (Ctrl+Alt+Shift+←/→ move the tab across),
  Ctrl+Alt+↑/↓ walk the rows and Ctrl+Alt+Shift+↑/↓ move one, Ctrl+Shift+K clears
  the Space, Ctrl+Shift+C copies the link without its tracking parameters
  (Ctrl+Alt+Shift+C as Markdown; Inspect keeps F12 and Ctrl+Shift+I),
  Ctrl+Shift+2 / Ctrl+Alt+Shift+2 / Ctrl+Shift+1 are the screenshots, Ctrl+Shift+P
  opens the command bar's actions (the system print dialog is on Ctrl+Alt+P), and
  Ctrl held a moment numbers the rows. The full list is the Shortcuts block on
  chrome://settings/stedding — on Windows now too — read from the same table the
  keys are.
- **A first start without Google.** Choosing Google as the search engine keeps
  Stedding's local new tab page (Chromium's Google page opened before, on the Mac
  too); the "Google API keys are missing" bar is gone from the first window;
  Settings › Appearance no longer offers Chromium's theme picker, whose colours did
  not reach the window and whose promos pointed at the Web Store.
- **The collapsed sidebar, second look.** Its rows sit a little apart; the Space
  title shows its icon alone instead of "🏠 …"; adding Spaces while collapsed no
  longer pushes the "+" past the bottom of the window; hovering a Space no longer
  floats its name over the downloads button.

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

#### Windows

`Stedding-0.2.0-beta.6-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt, over a beta 5 install if
there is one. It is **not signed**: SmartScreen shows "Windows protected your PC" —
click **More info**, then **Run anyway**, once. Uninstall from Settings → Apps, as
any app. Windows 10 and 11, x64.

### Checksum

```
shasum -a 256 Stedding-0.2.0-beta.6-arm64.dmg
59633835eb0b03205895c111e108fa869a1aceb8703a45faa626fea9ea602d04  Stedding-0.2.0-beta.6-arm64.dmg
```

The DMG is 178 MB, built on 2026-09-10 on macOS from the commit that carries the
macOS fixes below; `tooling/publish-release --check` refused the notes until this
number matched the image.

The macOS image is built from a source three fixes ahead of the Windows installer's
(`docs/history/archive.md#the-operators-rounds`, *The Mac pass*): the first macOS build of the patches written
on Windows for beta 5 and 6 found a Windows-only colour id in the page-bar supplier
(it did not compile on the Mac) and a Space's name going into the export file name
as ASCII; and the first multi-tab capture found every inactive sidebar row and
essentials card filled near-black -- Chromium's field-trial testing config had been
hiding that fill in every beta up to 4, and beta 5 was the first build with the
config off (the Windows preview shows it too, with more than one tab). Inactive
rows are plain again. The next Windows build carries all three. The release sweep
on the Mac: `tooling/dev test all` on this build, 580 cases -- every Stedding filter and Chromium's own suites around what the series touches -- all green.

```
certutil -hashfile Stedding-0.2.0-beta.6-win-x64.exe SHA256
69c6c46053d5df9856115696bcf0ea357aa6bedebf3ceb123cffecca7fbc9695  Stedding-0.2.0-beta.6-win-x64.exe
```

The Windows installer is 165.6 MB, built on 2026-09-10 from the same commit as the
series. Each platform's image is added to this release by the machine that builds
it.

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- ⇧⌘C reaches the browser only when no other app owns the chord system-wide (the
  Maccy clipboard manager takes it by default); the File menu row always works.
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable.
- On Windows, Ctrl+Alt with an arrow is also the display-rotation hotkey some
  Intel graphics drivers install; turn that off in the driver if the two collide.
- The Windows preview has no updates and no signature, and links from other
  applications open as tabs rather than in a little window (M8, `S-56`). Linux
  comes after (M9).

## Stedding 0.2.0 beta 5

Chromium **153.0.8010.12** (stable), for the first time a **Windows x64 preview**,
Stedding's patch series (`patches/README.md`). Unsigned, like the earlier betas —
see *Install* below. This release carries the Windows image alone: macOS users
take beta 6, which has everything here and the Windows keyboard map besides.

### What changed since beta 4

Round 8 (`docs/history/archive.md#the-operators-rounds`): the series was built and run on Windows for the first
time, and what that look turned up reaches the Mac too.

- **The collapsed sidebar's rows fill the rail.** A row in the rail is a 44 DIP square
  around its favicon, the "+" row its plus alone, the sidebar's toggle on the same
  centre line. The rows were 26 DIP pills in a 62 DIP column, the plus clipped to
  10 DIP by its own inset, the toggle a few DIP right of the rows.
- **Fixed: a profile that would not open.** Quit uncleanly with the sidebar collapsed
  and the next launch aborted before a window appeared — the "Restore pages?" bubble
  asked for the hidden app-menu button before the window existed — and every launch of
  that profile died the same way until the state was cleared by hand. It opens with
  the bubble now.
- **Fixed: Chromium's experiment set was live.** Every beta so far ran with
  Chromium's field-trial testing config, a file in the tree that switches on
  hundreds of experimental features by default; nothing contacted a server for it,
  but the defaults were Google's, not this project's. Off in every build from beta 5
  (`docs/features/privacy.md` Q10). On Windows it had been showing a "launch when
  Windows starts" prompt.
- **Fixed: the About page credited "the Stedding open source project".** The line
  reads "Stedding is made possible by the Chromium open source project" again,
  the link where it always went.
- **Fixed: the address field over the buttons.** In a window under about 1000 DIP
  with the sidebar open, the field could sit over the back, forward and reload
  buttons. It keeps the row's own layout now.
- **The collapsed sidebar waits before it opens.** Resting the pointer on the rail
  expands the sidebar after 2 seconds, not at once, so a tab in the rail can be
  clicked without the sidebar opening over it; a click in the rail starts the wait
  again. The pause is a setting: 1, 2 or 5 seconds, or Chromium's own timing.
- **Windows, a preview installer.** The series runs on Windows x64
  (`docs/features/windows.md`): the Stedding window with its sidebar, Spaces,
  folders, the command bar, archive and routing; the address row under the
  window's own buttons; Windows knows the build as Stedding, with its own install
  directory, icon and registry keys beside any Chromium install; Chrome's registry
  key for third-party extensions is left unread (privacy Q9). Not yet: the
  Stedding keyboard shortcuts (Chromium's Windows chords stand in — Ctrl+T is a new
  tab, there is no Ctrl+S sidebar toggle), signing, updates. A preview, honestly
  labelled; the port continues (`docs/ROADMAP.md` M8).

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

#### Windows

`Stedding-0.2.0-beta.5-win-x64.exe` installs for the current user only, into
`%LOCALAPPDATA%\Stedding`, with no administrator prompt. It is **not signed**:
SmartScreen shows "Windows protected your PC" — click **More info**, then **Run
anyway**, once. Uninstall from Settings → Apps, as any app. Windows 10 and 11, x64.

### Checksum

No macOS image for this beta: the Mac's next image goes into beta 6.

```
certutil -hashfile Stedding-0.2.0-beta.5-win-x64.exe SHA256
475a19989c85e738307f2a73832462e965509df861395a7ccb266cf1a254852c  Stedding-0.2.0-beta.5-win-x64.exe
```

The Windows installer is 165.6 MB, built on 2026-09-09 from the same commit as the
series.

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- ⇧⌘C reaches the browser only when no other app owns the chord system-wide (the
  Maccy clipboard manager takes it by default); the File menu row always works.
- Choosing Google as the search engine switches the new tab page to Chromium's
  Google page rather than Stedding's local one (`S-45`).
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable.
- The Windows preview has no Stedding keyboard map yet (Chromium's Windows chords
  stand in), no updates and no signature (M8, `S-56`). Linux comes after (M9).

## Stedding 0.2.0 beta 4

Chromium **153.0.8010.12** (stable), macOS **arm64**, Stedding's patch series
(`patches/README.md`). Unsigned, like the earlier betas — see *Install* below.

### What changed since beta 3

Round 7 (`docs/history/archive.md#the-operators-rounds`), from the operator's look at beta 3:

- **The address row is the page.** The row is the page's own colour, not a blend — a
  white page gets a white row — with one hairline where it meets the page, and the page
  starts square under it. The star and the row's other icons take the row's contrast
  colour. The address sits centred on the row, one point smaller than Chromium's, with
  no box around it; the field is 560 DIP where the row has the room and gives the width
  back when it does not — a narrow window, or a row of extension actions.
- **The collapsed sidebar.** Its rows are centred against the page card, gutter and all.
  The sidebar's toggle takes the traffic lights' own vertical centre when it shares their
  row, and drops clear of them when it cannot.
- **Rows like Arc's, part two.** A folder carries macOS's own folder symbol and a
  semibold title, and lights up on hover like a tab. The folder header, the "+ New Tab"
  row and the Space title all sit on the tab rows' own column — the folder header had
  been indented with its children. A pinned tab that has left its page shows Arc's slash
  between the favicon and the title.
- **Move everything from Arc in one click.** The welcome flow's Arc block brings the
  sidebar — Spaces, pinned tabs, essentials, folders, tabs — and now the history and
  the saved passwords too, each a checkbox that starts checked, behind one button. The
  settings row and the ⌘T action do the same. Passwords need one macOS prompt to read
  Arc's keychain item; nothing leaves the Mac.
- **Fixed:** quitting with a folder in the sidebar could abort.
- **Fixed:** macOS's keychain panels named the browser "Chromium". The item is Stedding's
  own now; a profile from an earlier beta still reads its saved passwords.

Round 6, wave 1 (`docs/history/archive.md#round-6-plan`), plus two things from the first night on beta 3:

- **Arc's keys for Spaces.** ⌃1–⌃9 jump to a Space, ⌥⌘← / ⌥⌘→ step through them,
  ⌘D pins the tab in its Space (Bookmark This Tab keeps its menu row), ⇧⌘K clears the
  Space's unpinned tabs, ⌥⇧⌘← / ⌥⇧⌘→ move the tab one Space over and follow it.
  A **Spaces** menu in the menu bar lists all of them. Next and previous tab move to
  ⌥⌘↓ / ⌥⌘↑ (⇧⌘] and ⇧⌘[ still work); pane focus moves to F6 / ⇧F6.
- **Copy Link.** ⇧⌘C copies the page's link with `utm_*`, `fbclid`, `gclid` and their kin
  removed (a setting keeps them); ⌥⇧⌘C copies it as Markdown with a rich-text twin, so
  Slack, Notion and Docs paste a live link. Both are in the tab menu, the app menu and
  File. A toast confirms, and says when tracking was removed.
- **Rows like Arc's.** The close glyph appears only on the hovered row; the active row
  carries none. A playing essentials card keeps its favicon and shows the sound as a
  corner badge. The "+" of New Tab and of the Space switcher are proper icons.
- **The page card.** The address row sits in the same 6 DIP gutter as the card's other
  sides, with no line between the row and the page. The row takes the page's colour on
  either side of the contrast line — a dark page in light mode gives a dark row with
  light icons, the way Safari does. The link status pill lives inside the card; ⌘F
  uses the command bar's dialog colours; split panes have no blue ring.
- **Screenshots confirm.** After ⇧⌘2 / ⌥⇧⌘2 / ⇧⌘1 a toast reads "Copied · Saved to
  Downloads" with a Show in Finder button.
- **Motion follows macOS.** Reduce Motion stills Stedding's animations; a setting turns
  them off regardless.
- **Every shortcut in one place.** chrome://settings/stedding carries a Shortcuts block
  read from the same tables the menus use, including a list of where Stedding differs
  from Chromium and a note on the Mission Control collision with ⌃1–⌃9. The welcome
  flow's last step links to it.
- **About** reads "Stedding 0.2.0-beta.4 · Chromium 153.0.8010.12 (arm64)".
- **Welcome flow.** The appearance step offers the five Space colours; the choice tints
  the first Space at once, even while it is the only one.

Round 6, wave 2 (the model work under the sidebar):

- **Sleeping tabs.** A sleeping row is dimmed instead of ringed; Sleep Tab and Sleep
  Other Tabs in This Space are on the menu; a Space you leave sleeps after 15 minutes
  (a setting: never, 5, 15, 60), essentials excepted.
- **Rename a tab.** Double-click a row's title or choose Rename…; the name survives a
  restart and the command bar finds it.
- **Row numbers.** Hold ⌘ for a moment and every row you can see shows its ⌘-number;
  the Space chips show their ⌃-number. ⌘1–9 skip rows you cannot see.
- **Selection.** ⌘-click and ⇧-click select rows; every verb acts on the selection
  ("Close 3 Tabs", "Sleep 2 Tabs").
- **Stedding's tab menu.** Pin, rename, folder, split, sleep, mute, then the link, then
  closing — no sync, group, reading-list or AI rows. A setting brings Chromium's back.
- **Pinned tabs have a home.** ⌘W on a pinned tab puts it to sleep (a setting); a pin
  that navigated away shows a dot on its favicon and a click on the favicon brings the
  home page back; Reset to Pinned Page and Make This the Pinned Page are on the menu.
  A drifted essentials card shows a ↺ control while the pointer rests on it, and the
  hover card of any pin says where it is pinned and what its home is. A folder whose
  tabs all sleep dims its header.
- **Many Spaces.** When the chips no longer fit, the inactive ones become dots in their
  colour until the pointer rests on the row; drag a chip along the row, or use Move
  Left / Move Right on its menu, to reorder them.
- **Splits are one row.** Moving a split to a Space, pinning it or putting it to sleep
  takes both panes.
- **Downloads** show their progress on the sidebar's button.
- **⌃⇥ knows where you were.** A tap goes to the previous tab of the Space; hold ⌃
  and a strip shows the five most recent, ⇥ steps through them, releasing ⌃ lands.
  A setting returns ⌃⇥ to sidebar order. ⌥⇧⌘↑ / ⌥⇧⌘↓ move the row up or down,
  jumping a folder as one row and staying inside a folder.
- **Menus without Google.** The page menu drops Lens, Gemini, the QR code and
  reading mode; the app menu drops the Google account, Glic, send-to-self,
  Customize Chrome and Payment rows and gains Import, Screenshot ▸ and Spaces ▸.
  The sidebar's rows get menus for what they are — an essentials card, a pinned
  row, a plain row, a split, a folder header (rename, collapse, move the tabs out,
  close them) — and "Move to Space" lists the other Spaces. One setting brings
  Chromium's full menus back.
- **A command palette.** ⇥ in the command bar, a leading ">", or ⇧⌘P lists every
  command with its chord — Stedding's verbs first (move to a Space, pin, sleep, clear,
  the captures, the links, one row per setting), then Chromium's — and Enter runs it.
  ⌘L opens the bar with the page URL selected.
- **Sites go to their Space.** "Always Open <site> in ▸" on a tab's menu writes a rule;
  from then on a tab that opens with that site moves to its Space and the window
  follows, with a toast that undoes it. chrome://settings/stedding lists each Space's
  rules and picks the Space for links from other apps.
- **Import from Arc.** The welcome flow's import step, chrome://settings/stedding and a
  ⌘T action read Arc's sidebar file and bring over the Spaces (icon and nearest
  colour), the essentials, the pinned tabs with their home, and the folders; every
  tab arrives asleep. The summary is shown first; a second import adds nothing twice.
- **Archived.** A row above the Space switcher opens the archive: what auto-archive,
  Clear and ⌘W closed, by day, filtered by Space, searchable, each tab restorable to
  its Space (the Space comes back if it was deleted). ⌘T finds archived tabs too.
  "Keep archived tabs for 7 / 30 / 90 days" is in chrome://settings/stedding.
- **The address row goes with the sidebar.** ⌘S collapses both; the page card takes
  the whole height. ⇧⌘D brings the row back on its own (or hides it with the
  sidebar out); a localhost page always shows it. Off in chrome://settings/stedding
  keeps the row whatever the sidebar does.
- **Tracker-free by default.** Third-party cookies are blocked in normal windows
  (the eye icon in the address row allows them per site), HTTPS comes first, no web
  service is asked about a page that fails to load, permission prompts are quiet,
  Global Privacy Control is sent, and search suggestions are off until you turn them
  on. All of it is one Privacy block in chrome://settings/stedding.
- **Sidebar density.** Comfortable (Arc's measure), Compact or Dense, and a text size
  from 12 to 15, in chrome://settings/stedding or from ⌘T; every window follows at once.
- **Bookmarks are pins.** Import your bookmarks and they become pinned tabs and folders
  in your first Space; the bookmark bar and the star are gone from then on. A profile
  that already has bookmarks converts them from ⌘T.
- **Sidebar backups.** A snapshot an hour, kept for a year on a thinning schedule;
  restore one from chrome://settings/stedding without losing an open tab. Export a Space
  as a file and import a sidebar file: sharing a Space needs no account.
- **Private windows look private.** Flat graphite, no Space tint, "Private" where the
  Space title goes, no switcher, and nothing from a private window in the sidebar, the
  archive or the session.
- **Little windows.** A link from another app opens small, over your window. ⌘O puts
  the page into your Space, ⇧⌘O into a split, ⌃1–9 into a Space, Escape closes it; an
  idle one closes itself after six hours. A site with a route goes to its Space instead;
  the setting turns it off.
- **One sidebar for every window.** ⌘N opens a window with the same Spaces; rename or
  reorder one anywhere and every window follows. ⌥⇧⌘N opens a Blank Window with Spaces
  of its own.

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

### Checksum

```
shasum -a 256 Stedding-153.0.8010.12-arm64.dmg
96840027895cac7640a21b668641779b114f6c324a005f819325300b3516cfab  Stedding-153.0.8010.12-arm64.dmg
```

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- ⇧⌘C reaches the browser only when no other app owns the chord system-wide (the
  Maccy clipboard manager takes it by default); the File menu row always works.
- Choosing Google as the search engine switches the new tab page to Chromium's
  Google page rather than Stedding's local one (`S-45`).
- ⌃1–⌃9 collide with macOS Mission Control's "Switch to Desktop N" once a second
  desktop exists; the Spaces menu keeps the commands reachable.
- Windows/Linux come after macOS (`docs/ROADMAP.md`).

## Stedding 0.2.0 beta 3

Chromium **153.0.8010.12** (stable), macOS **arm64**, Stedding's patch series
(`patches/README.md`). Unsigned, like the earlier betas — see *Install* below.

### What changed since beta 2

Three things from the first look at beta 2 (`docs/history/archive.md#the-operators-rounds`, "Beta 2 feedback"):

- **The address row takes the page's colour far more often.** A page's own background
  is now the fallback when it declares no theme colour, the way Safari tints its bar:
  white over Settings or Wikipedia in light, dark over Settings in dark. A colour that
  would swallow the toolbar icons (a white page in dark mode) still leaves the row on
  the window ground.
- **The chrome:// chip fits.** "Stedding" in the address row drew as a white box with
  the mark cut off; the chip now keeps room for its icon.
- **The Space chips sit together** in the middle of the bottom row, "+" at the right,
  downloads at the left, instead of being spread across the width.

Beta 2's fixes (Space name pill, essential hover card, the ⇧⌘L mentions) are included.

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

### Checksum

```
shasum -a 256 Stedding-153.0.8010.12-arm64.dmg
a1859866b87c4e5a1837126fe14d6624691e58735cea20e9076f6cda4754768f  Stedding-153.0.8010.12-arm64.dmg
```

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- The About page still reads "Developer Build" after the Chromium version (`S-43`).
- Windows/Linux come after macOS (`docs/ROADMAP.md`).

## Stedding 0.2.0 beta 2

Chromium **153.0.8010.12** (stable), macOS **arm64**, Stedding's patch series
(`patches/README.md`). Unsigned, like beta 1 — see *Install* below.

### What changed since beta 1

A visual audit of every surface in both colour schemes (`docs/history/archive.md#the-operators-rounds`,
"Round 5 audit") found four things, all fixed:

- The Space name that floats over a hovered Space chip was drawn at the top of the
  sidebar instead of above the chip.
- The hover card of an essential (pinned) tab opened below the card, covering the
  Space title and the first rows; it now opens beside the sidebar like every other tab's.
- The welcome flow's last step listed ⇧⌘L, which does nothing. ⌘S collapses and
  expands the sidebar; the step now says so and lists ⌥⌘N for split view instead.
- The settings hint for "expand the collapsed sidebar on hover" named the same
  non-existent key.

Everything else in beta 1's notes stands; the audit's captures are the sign-off.

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

### Checksum

```
shasum -a 256 Stedding-153.0.8010.12-arm64.dmg
b4f784369663fcd679841dd2a834b9841f75c55d22185aa32fe836d4beaea39e  Stedding-153.0.8010.12-arm64.dmg
```

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- The About page still reads "Developer Build" after the Chromium version (`S-43`).
- Windows/Linux come after macOS (`docs/ROADMAP.md`).

## Stedding 0.2.0 beta 1

Second public build. Chromium **153.0.8010.12** (stable), macOS **arm64**, with
Stedding's patch series (`patches/README.md` lists it).

![Stedding](https://raw.githubusercontent.com/ysalitrynskyi/stedding-browser/main/docs/images/ui-current.png)

### What's new since 0.1.0

- **The sidebar reads like Arc's** — essentials grid, the Space's title, its pinned
  tabs, the Clear line, then "+ New Tab" and today's tabs; quiet hover and active
  pills; bare emoji for the Space row; a lone essential spans the row; the sidebar
  edge drags; a two-finger swipe across it changes Space.
- **The bar sits on the page** — the address row is the top of the page card and
  takes the page's own colour; no gap, no hairline.
- **⌘S** toggles the sidebar (Save Page moved to ⇧⌘S). **⌘T** now tells a search from
  a site the way the address bar does, and suggests history, bookmarks and open tabs.
- **Peek**: links that leave a pinned tab's site open over the page; ⌘O makes them a
  tab, ⇧⌘O a split.
- **Auto-archive**: unpinned tabs nobody has looked at for 12 hours (a setting) close
  into the recently-closed list.
- **Split view** with the tab context menu, ⌥⌘N, or a tab dragged onto the page.
- **Screenshots**: ⇧⌘2 the page, ⌥⇧⌘2 a region, ⇧⌘1 the full page; PNG in Downloads
  and on the clipboard.
- **Welcome flow** on first run: search engine, import, appearance, default browser,
  the shortcuts worth knowing.
- **Settings**: a Stedding section — peek, sidebar hover and width, archive threshold,
  new-tab options, and this window's Spaces to rename or delete.
- **Downloads** live at the sidebar's bottom-left.

### Install (required reading — unsigned build)

This build is **not signed or notarized** (a signed build follows once Apple approves
the developer enrolment). macOS will refuse a plain double-click:

1. Open the DMG, drag **Stedding** to Applications.
2. In Applications, **right-click Stedding → Open**, confirm once.
3. Every later launch is normal.

Do **not** disable Gatekeeper globally for this; the per-app step above is enough.

### Checksum

```
shasum -a 256 Stedding-153.0.8010.12-arm64.dmg
6b4f5a0857d67272c920eafd58ceb94abd4175c95b0b03adc428d8717d1095c2  Stedding-153.0.8010.12-arm64.dmg
```

### Known limits

- Unsigned/unnotarized until the Developer ID arrives; updates arrive here on Releases.
- Windows/Linux come after macOS (`docs/ROADMAP.md`).
- H.264/AAC ship (`docs/decisions/0008`); the patent licence is a 1.0 checklist item.

Issues welcome — this exists to be beaten on.
