# 0023 — Updates on Windows and Linux: the plan, and what keeps it open

Status: Accepted; partly superseded by 0026 (its "one key" rule, for Windows); corrected by the note of 2026-10-19
Date: 2026-10-16

## Context

ADR 0022 gave the Mac Sparkle and a signed feed, and beta 16 is the first release
that carries them. Windows has no updater: each release is installed over the last
by hand. There is no Linux build yet (ROADMAP M9). On 2026-10-16 the owner asked to
make sure updates will also work on Windows and Linux, and chose to settle the
design now and build nothing yet. Read for it the same day:

- WinSparkle (0.9.4, MIT), Sparkle's Windows counterpart, reads Sparkle's feed
  format and checks the same EdDSA signatures with the same keys. It shows windows
  of its own, though: its header says that even its check without UI shows the
  usual "update available" window. The Mac's updater never shows one (updates Up2).
- Chromium already notices a newer installed version while it runs
  (`chrome/browser/upgrade_detector`, polled every two hours): on Windows from the
  version `setup.exe` writes to the registry, on Linux by asking the installed
  binary for `--product-version`. On Windows the installer puts a newer version in
  a folder of its own beside a running one, and the browser swaps it in at its next
  start (`new_chrome.exe`, `upgrade_util::SwapNewChromeExeIfPresent`), the path
  Chrome's own updates take.
- The Windows installer's version is Chromium's (`chrome/VERSION`). Two releases on
  one pin carry one number, and the second installs as a repair, which fails while
  Stedding runs (`S-72`). And Chromium treats a profile last used by a higher
  version as a downgrade: when the milestone went down and a snapshot exists, the
  profile is put aside and the snapshot restored (`chrome/browser/downgrade`).

## Decision

- **One key, one feed per platform.** Every update is signed with the EdDSA key that
  signs the Mac's (ADR 0022); the private key stays on the release Mac, which signs
  the other platforms' downloads from the release. `updates/appcast.xml` stays the
  Mac's alone, because every Mac build carries its URL. Windows reads
  `updates/appcast-windows.xml`, in the same format, one entry per architecture.
- **Windows: the browser's own updater, not WinSparkle,** because it must be as
  silent as the Mac's. It sits behind `stedding::AppUpdater`, under the same setting
  (`stedding.updates.automatic`): once a day it reads the feed through Chromium's
  network stack, downloads a later per-user installer, checks its length and its
  signature (BoringSSL's Ed25519) before running it, and runs it silently while the
  browser runs. The upgrade detector then sees the new version, and the sidebar
  shows "New Stedding Version Available"; a click restarts into it. The About page
  (an `AppUpdater`-backed updater in place of `version_updater_basic.cc`), the
  command bar's rows and the Settings switch are the Mac's (`docs/features/updates.md`).
- **The Windows version numbers come first** (`S-72`). Every Windows release gets a
  higher installer version than every release before it, and the first field stays
  Chromium's milestone, so neither the installer nor the profile ever sees a number
  go down. The user agent and client hints keep reporting Chromium's real version.
  `S-72` picks the exact shape (Brave's way puts the product's numbers after the
  milestone) and records it here.
- **Linux: the package system updates Stedding.** A .deb or .rpm comes with a signed
  apt or dnf repository, a Flatpak through Flathub. The browser downloads nothing;
  the sidebar's pill appears when the upgrade detector sees the version the package
  manager installed, and the Settings switch is not shown. A self-contained format
  (an AppImage or a tarball), if M9 ships one, takes the Windows updater with a feed
  of its own. Which formats ship is M9's decision (ROADMAP).
- **The thank-you pages are already every platform's** (Up9, Up10): they follow
  the version that ran last, not the updater.

## Consequences

- Nothing changes on the Mac, and no shipped build has to change: no Windows or
  Linux build carries a feed URL yet.
- The Windows updater is `S-215`, after `S-72`; Linux packaging and its repositories
  are `S-216`, in M9. The first Windows build with the updater is installed by hand,
  as beta 16 was on the Mac.
- Windows gains a daily request to the feed, which `docs/PRIVACY.md` names when it
  ships. The apt and dnf repositories need an OpenPGP key of the project's, kept the
  way the EdDSA key is.
- WinSparkle stays the fallback if the browser's own updater proves too costly to
  keep; it would bring its own windows.

## Note, 2026-10-19: the upgrade detector does not run in Stedding

Context and Decision above say that Chromium's upgrade detector notices a newer installed
version and that the sidebar's pill follows it. In Stedding's builds it does not: the
detector polls the installed version only with `enable_update_notifications`, which
`chrome/browser/buildflags.gni` sets to `is_chrome_branded`, so `UpgradeDetectorImpl::Init`
never creates its `InstalledVersionPoller`. The text above is left as written. What was
built instead (patch 0073, `S-215`): the Windows updater takes its own path to the pill.
`stedding::AppUpdater` runs the installer beside the running copy and then reports the update
ready itself, as the Mac's does, also at a launch after an update installed and not yet
restarted into (`docs/features/updates.md` Up17); the restart is Chromium's own. Linux's
pill (`S-216`) needs the same correction: the detector turned on, or a check of Stedding's
own.
