# 0023 — Updates on Windows and Linux

Status: Accepted. Windows signatures use a key of their own: [ADR 0026](0026-a-windows-update-key.md). Linux is not shipped ([BACKLOG.md](../../BACKLOG.md) S-216).
Date: 2026-10-16

## Context

[ADR 0022](0022-sparkle-updates-the-mac.md) updates the Mac from a signed feed. Windows needs the same quiet: no window of the updater's own. WinSparkle reads a Sparkle feed and shows windows of its own. Chromium can place a newer install beside a running one and swap it in at the next start (`new_chrome.exe`). Two releases on one Chromium pin need distinct installer versions, or the second install is a repair while Stedding is running.

Chromium's upgrade detector does not run in these builds. It polls the installed version only with `enable_update_notifications`, which `chrome/browser/buildflags.gni` sets to `is_chrome_branded`, so `UpgradeDetectorImpl::Init` never creates its `InstalledVersionPoller`. No patch in the series turns that flag on.

## Decision

Windows uses the browser's own updater, behind `stedding::AppUpdater`, on `stedding.updates.automatic` (patch 0073). On the Mac's schedule — a launch check when the last one is more than an hour old, then every six hours (patch 0078, updates Up14) — it reads `updates/appcast-windows.xml` through Chromium's network stack, downloads a later per-user installer, checks the installer's length and its Ed25519 signature, and runs it hidden while the browser is open. The updater then sets its own ready state (`State::kReady`). The sidebar shows "New Stedding Version Available". A click restarts into the new version. About, the command bar and the Settings switch are the Mac's ([updates](../features/updates.md)).

The Windows installer version is `<milestone>.<100 × major + minor>.<patch>.<beta>`, with 999 for a release. 0.2.0-beta.19 on Chromium 156 is 156.2.0.19 (patch 0073, S-72). The first field stays Chromium's milestone. The user agent and client hints keep Chromium's version (updates Up22).

Windows signatures use a key of their own ([ADR 0026](0026-a-windows-update-key.md)). `updates/appcast.xml` stays the Mac's feed.

Linux, when it ships, is updated by its package system: a signed apt or dnf repository for a `.deb` or `.rpm`, and Flathub for a Flatpak. The browser downloads nothing, and the Settings switch is not shown. The pill cannot follow the upgrade detector, for the reason above. S-216 either turns that detector on or checks with Stedding's own code. A self-contained build (an AppImage or a tarball), if M9 ships one, uses the Windows updater and a feed of its own. Which formats ship is M9 ([ROADMAP.md](../ROADMAP.md)).

The thank-you pages follow the version that last ran, on every platform (updates Up9, Up10).

## Consequences

A Windows install requests its feed on that schedule. [PRIVACY.md](../PRIVACY.md) names the request. Apt and dnf repositories, if they ship, need an OpenPGP key of the project's, kept as the EdDSA keys are.

WinSparkle remains a fallback only if this updater proves too costly to keep. It would bring its own windows.
