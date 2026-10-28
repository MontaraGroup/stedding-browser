# 0009 — macOS bundle identifier and product strings

Status: Accepted. Three upstream sites still hard-code `org.chromium.Chromium` (BACKLOG S-175).
Date: 2026-08-30

## Context

`MAC_BUNDLE_ID` in `chrome/app/theme/chromium/BRANDING` sets `CFBundleIdentifier`, and through it the helper bundles, keychain access groups, Mach service names, LaunchServices registration and the profile directory under `~/Library/Application Support`. macOS keys the profile, saved passwords and the default-browser registration to that identifier. Changing it after release makes an installed copy look like a different app. The identifier is chosen once, before anything ships.

Chromium's default is `org.chromium.Chromium`. The domain we own is stedding.dev ([ADR 0004](0004-domain-stedding-dev.md)). Apple's convention is reverse-DNS of a domain the developer controls.

## Decision

- Bundle identifier: `dev.stedding.Stedding`, the `MAC_BUNDLE_ID` in [`branding/BRANDING`](../../branding/BRANDING). Pre-release builds use this same identifier. There is no second id for betas.
- `PRODUCT_FULLNAME` and `PRODUCT_SHORTNAME`: `Stedding`. The Mac app is `Stedding.app`.
- `COMPANY_FULLNAME` and `COMPANY_SHORTNAME`: `The Stedding Authors`. There is no company.
- If the domain in ADR 0004 changes, this identifier stays. Moving it would orphan every installed copy.
- `org.chromium.extension`, `org.chromium.shortcut` and the clipboard pasteboard types stay. They are shared with other Chromium browsers ([ARCHITECTURE.md](../ARCHITECTURE.md#branding)).

## Consequences

The profile is `~/Library/Application Support/Stedding`. Saved passwords use the keychain item "Stedding Safe Storage" ([INSTALL.md](../INSTALL.md)). A profile an earlier beta left in `~/Library/Application Support/Chromium`, with the key "Chromium Safe Storage", is copied across on the first launch that finds no Stedding folder, when that profile carries Stedding's own preferences. If another browser is using the old folder, Stedding asks first (patch 0050, [windows.md](../features/windows.md) N8).

The signed Mac app uses this bundle id. The Mac image has been signed and notarized since 0.2.0 beta 10 ([ROADMAP.md](../ROADMAP.md) M7).

Three upstream files still embed `org.chromium.Chromium` and do not follow `MAC_BUNDLE_ID`. [ARCHITECTURE.md](../ARCHITECTURE.md#branding) lists them: `build/apple/tweak_info_plist.py` (the direct-launch URL scheme), `net/device_bound_sessions/unexportable_key_service_factory.cc` (a keychain group) and `content/browser/media/capture/desktop_capture_util_mac.mm` (system audio capture; [web-apps.md](../features/web-apps.md)). No patch derives them from the bundle id. Patch 0068 changes `tweak_info_plist.py` only so `CFBundleVersion` carries Stedding's version. Fixing the three is [BACKLOG.md](../../BACKLOG.md) S-175 (SER-3 in the 2026-09-26 plan).
