# Feature: Motion

Status: **O1–O3 built** (O2 seen on a build on 2026-10-18, animations slowed twenty times);
**O4–O7 built** 2026-10-21 on the Mac (their Windows runs not yet made; O6 not yet seen by the
owner).
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
| O4 | Stedding's animations are measured frame by frame in a real window: for each frame the window's compositor makes while one runs, how many views the UI thread laid out and painted, how long the layout, the paint and the whole main frame took (the views' own trace events), and how many frames were begun and presented. On the Mac's release build, 2026-10-21, a 120 Hz display, twelve rows: every animation is stepped by the compositor at the display's rate, none by a 60 Hz timer; no main frame was longer than a vsync (the longest, 8.2 ms, in a sidebar collapse); the sidebar's collapse and expand begin about four frames in five of the display's (Chromium on the Mac resizes the page at every frame of them), the other motions nearly every one. The command bar, the update pill and the split drop highlight have no motion of their own: they draw at once (the bar's Show takes 5 ms). | `MotionFramesTest.*`, one "[motion]" line per animation (`--test-launcher-print-test-stdio=always` prints them for a run that passes) | built · Mac |
| O5 | A width animation lays out the views it moves and none it hides. A row's rename field and its two badges are left out of the row's layout list, not marked `kViewIgnoredByLayoutKey`, which views lays out at every layout of the parent, shown or not; the Space title row's rename field keeps no bounds while hidden. A frame of the rail's hover opening had laid out 152 views, 11 of them hidden text fields with their cursors and focus rings; now 120, and no hidden field but the switcher's, which its fill layout sizes with its chips. | `MotionFramesTest.SidebarCollapseAndExpand`, `MotionFramesTest.RailHoverOverlay`: at most one hidden text field laid out a frame (60 in 40 frames of a hover opening without the change) | built |
| O6 | In the Stedding window the sidebar's collapse and expand and the rail's hover overlay ease out (`gfx::Tween::EASE_OUT`), over Chromium's times: 350 and 400 ms on the Mac, 200 and 250 for the hover. Chromium's emphasized curve covers a third of the way in its two fastest frames, and a collapse moved 33% of the way, 88 DIP, in one frame at 120 Hz; eased out its largest step was 7 to 14%, a dropped frame included, and it starts moving in the first frame. No motion under `stedding::ShouldAnimate()` false (O2). | `MotionFramesTest.SidebarMotionsEaseOut` (the four motions' curve, and the Mac's times); `MotionFramesTest.SidebarCollapseAndExpand` logs every step | built · not yet seen by the owner |
| O7 | A Space switch keeps the Space being left (spaces B32, B35) as a recording of what its rows painted, which the compositor rasters with its other layers. It was rastered into a bitmap on the UI thread at the switch, 4.6 to 8.8 ms with ten rows, before the slide's first frame; the recording takes 0.7 ms, and the switch itself 13 to 14 ms where it took 18 to 22. | `MotionFramesTest.TheSpaceLeftIsARecordingOfItsRows` (no picture of the list in what the layer paints, and its raster shows the rows; one picture before the change); `MotionFramesTest.SpaceSlide` logs the switch's parts | built |

## Running the tests

```bash
tooling/dev test motion
tooling/dev test browser 'MotionFramesTest.*'
```
