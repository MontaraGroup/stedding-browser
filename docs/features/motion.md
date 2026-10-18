# Feature: Motion

Status: **O1–O3 built** (O2 seen on a build on 2026-10-18, animations slowed twenty times).
Owner docs: `docs/QUALITY.md`. Patch: 0017.

One helper decides whether Stedding animates: `stedding::ShouldAnimate()` is false when
the system asks for reduced motion (Reduce Motion on the Mac, animation effects off on
Windows) or the preference `stedding.ui.animate` is off. Every Stedding
animation is gated by it, and its spec row says so.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| O1 | `stedding::ShouldAnimate()` is false when `gfx::Animation::PrefersReducedMotion()` or the preference is off; every Stedding animation (the toast, the sidebar's expand-on-hover, later the ⌃⇥ strip fade and the ⌘-badge fade) is gated by it. | `MotionTest.*` on the helper under both inputs | built |
| O2 | Upstream's expand-on-hover animation, hover-card fade and strip collapse take the same gate in the Stedding window. | a capture parameter `SteddingArcStyleWindow:reduce_motion/true` proves the still path (two shots 80 ms apart identical); 2026-10-18, the Mac's release build of patch 0071, animations twenty times slower: on, the collapse caught at 239 and 120 DIP on its way to the rail's 86; off, the rail at once and the hover's open strip at once, no width between | built |
| O3 | Setting off stills the browser regardless of macOS; on follows macOS Reduce Motion. | `MotionTest.PreferenceOffStillsIt`, `MotionTest.SystemReduceMotionStillsIt`; the default: `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault`; live toggle | built |

## Running the tests

```bash
tooling/dev test motion
```
