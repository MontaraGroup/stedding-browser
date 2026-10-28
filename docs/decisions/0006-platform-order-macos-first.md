# 0006 — Platform order: macOS, then Windows, then Linux

Status: Accepted. macOS and Windows ship; Linux does not ([M9](../ROADMAP.md#m9--linux-port)).
Date: 2026-08-30

## Context

One team cannot finish three platforms at once to the bar in [The quality bar](../ROADMAP.md#the-quality-bar). The order is so installers, signing, and updates are done in sequence. Chromium supports all three. The limit is capacity.

## Decision

Platforms ship in this order:

1. **macOS.** It was the development machine, so the edit-build-test loop was fastest there, and Arc's audience was mostly there.
2. **Windows.** The largest desktop population, after a Mac build was shipping.
3. **Linux.** The most packaging work per user reached. People who want it sooner can build from source.

The order sequences installers, signing, and updates. Linux stays in the order. A feature is not written so that only macOS can have it.

## Consequences

- macOS and Windows ship in the same release and update themselves: Sparkle on the Mac ([ADR 0022](0022-sparkle-updates-the-mac.md)), Stedding's updater on Windows ([ADR 0023](0023-updates-on-windows-and-linux.md), [ADR 0026](0026-a-windows-update-key.md)). The Mac build is made on a Mac. The Windows build is made on a Windows PC.
- The Mac image is signed and notarized. The Windows installer is not signed yet (`S-56`).
- Linux is not shipped. The port is [M9](../ROADMAP.md#m9--linux-port).
- `tooling/check-pin` follows the Mac stable rollout, the first platform in this order. Windows ships on the same pin.
- Hosted workflows do not build the browser ([CI reality](../ARCHITECTURE.md#ci-reality)).
