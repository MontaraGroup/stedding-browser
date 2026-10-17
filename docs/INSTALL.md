# Installing Stedding

Stedding ships as beta pre-releases on the
[Releases page](https://github.com/ysalitrynskyi/stedding-browser/releases). Each
release carries a file for each platform it was built for, and a SHA-256 checksum for
each. Not every release has both: take the newest one with a file for your platform.

The macOS image is signed with the project's Developer ID and notarized by Apple from
beta 10 on, so it opens like any other app. The Windows installer is **not code-signed
yet**, which means one SmartScreen prompt (`S-56` in [BACKLOG.md](../BACKLOG.md)). The Mac
version updates itself from beta 16 on, the first release built with its updater; Windows
has no automatic updates yet (`S-215`).

## macOS (Apple silicon)

Requirements: a Mac with an M-series chip (M1 or later) and macOS 13 or later. Intel
Macs are not supported yet.

1. Download `Stedding-<version>-arm64.dmg` from the latest release and check its
   checksum ([below](#verifying-the-download)).
2. Open the DMG and drag **Stedding** into **Applications**.
3. Open Stedding. macOS checks Apple's notarization once and opens it.

### Verifying the download

The release notes list a SHA-256 for each file. In Terminal:

```bash
shasum -a 256 ~/Downloads/Stedding-<version>-arm64.dmg
```

The number must match the one in the notes exactly.

### Where your data is

Your profile — tabs, Spaces, history, passwords, extensions — lives in
`~/Library/Application Support/Stedding`. **Export Space…** in Settings → Stedding →
Spaces writes a Space to a file you can keep or move to another machine. Saved passwords
are encrypted with a key kept in the macOS keychain under the name "Stedding Safe
Storage".

Coming from beta 8 or earlier: those builds kept the profile in
`~/Library/Application Support/Chromium` and the key in "Chromium Safe Storage". The
first launch of a later build copies the profile into Stedding's own folder, if that
folder holds no profile yet, and leaves the old one as it was; if another browser is using
the old folder then, Stedding asks you to **Quit** and close it, or to **Start a New
Profile**. It copies the key once too, so macOS may ask one time for access to the
Chromium item. Keep the old folder until you have checked that your tabs and Spaces came
across.

### Updating

From beta 16 on, the Mac version updates itself: once a day it looks for a new
version on GitHub, downloads it in the background, and shows **New Stedding Version
Available** at the bottom of the sidebar; click it to restart into the new version, or just
quit, and it installs then. **Stedding › Check for Updates…** looks at once. To stop it, turn
off **Update Stedding automatically** in Settings › Stedding › Updates; it then makes no
update request at all. After each update Stedding opens one thank-you page on stedding.dev,
which the switch beside it turns off ([features/updates.md](features/updates.md),
[PRIVACY.md](PRIVACY.md)).

Before then, or by hand: download the new DMG and drag Stedding over the old one in
Applications; it opens with no extra step. Your profile is untouched.

### Uninstalling

Move Stedding from Applications to the Trash. To remove your data as well, delete
`~/Library/Application Support/Stedding` and the "Stedding Safe Storage" item in
Keychain Access.

## Windows (x64)

Requirements: Windows 10 or 11, 64-bit.

1. Download `Stedding-<version>-win-x64.exe` from the latest release.
2. Run it. If SmartScreen shows "Windows protected your PC", click **More info**, then
   **Run anyway**. This is needed once.
3. Stedding installs for the current user only, into `%LOCALAPPDATA%\Stedding`, with no
   administrator prompt, over an earlier version if there is one.

### Verifying the download

```
certutil -hashfile Stedding-<version>-win-x64.exe SHA256
```

The number must match the one in the release notes.

### Where your data is

The profile is under `%LOCALAPPDATA%\Stedding\User Data`. Export works as on macOS.

### Updating and uninstalling

Close Stedding, then run the new installer over the old version; the profile is kept. When
the new release is on the same Chromium number as the one installed (the release notes
name it) the installer repairs in place and cannot replace the files of a running
Stedding, so it has to be closed. Uninstall from **Settings → Apps**, as with any app.

### What the Windows preview does not have yet

The Windows build is a preview: the full interface, Arc's keyboard mapped to Ctrl and
Alt, the name and icon, and a per-user installer. Still open: little windows for links
from other apps (they open as tabs), signing, and automatic updates (`S-56`); the
two-finger Space swipe (`docs/history/plan-2026-09-26.md` TAB-31); and importing from Arc, whose Windows files
Stedding does not read yet (`S-81`).

## First start

The first window opens the welcome flow, six steps, each one skippable (five before beta
14, which added step 4):

1. Choose a search engine.
2. Import from Arc (on a Mac), or through Chromium's importer from Safari (bookmarks) or
   Firefox (bookmarks and history) on macOS, and from Firefox, Internet Explorer or the old
   Edge on Windows. Chrome, Brave and the new Edge cannot be imported yet.
3. Pick the colour scheme (system, light or dark) and a Space colour.
4. Choose how Stedding behaves: whether idle tabs are archived (Never until you choose),
   whether the closed sidebar shrinks to icons or hides, and whether a Space sleeps after
   you leave it.
5. Set Stedding as the default browser if you want.
6. See the keys worth knowing.

Each choice can be changed later in Settings. If you skip the search engine step,
Chromium's own "Choose your search engine" dialog opens on the first page (`S-134`).

## Linux

Not yet. Linux follows the Windows port ([docs/ROADMAP.md](ROADMAP.md), M9).
