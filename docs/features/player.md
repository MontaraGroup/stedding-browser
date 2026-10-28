# Feature: Mini player

Status: **Mp5 built. Mp1–Mp4 planned** (BACKLOG S-95).
Owner docs: `docs/PRODUCT.md` §9. Patch: 0060 (Mp5).

Picture-in-picture is meant to be a child of the page card, not Chromium's always-on-top window. No model. Until Mp1 exists, ⌥⇧⌘P opens Chromium's own window.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Mp1 | Picture in picture is `MiniPlayerView`, clipped to the card. Chromium's `VideoOverlayWindowViews` is not created in a Stedding window. | `MiniPlayerTest.UsesTheCardHostNotTheOverlayWindow` (not written yet) | planned · BACKLOG S-95 |
| Mp2 | Leaving a tab that is playing unmuted video enters Mp1. A muted tab does not. | `MiniPlayerTest.LeavingAPlayingVideoPopsOut` (not written yet) | planned · BACKLOG S-95 |
| Mp3 | A non-active unmuted audio tab shows a 44 DIP strip when no video player is up. | `MiniPlayerTest.BackgroundAudioShowsTheStrip` (not written yet) | planned · BACKLOG S-95 |
| Mp4 | Close hides the player. Back-to-tab activates the source tab and its Space. Drag stays inside the card. One player per window. | `MiniPlayerTest.ReturnActivatesTheSourceTab` (not written yet) | planned · BACKLOG S-95 |
| Mp5 | ⌥⇧⌘P (Ctrl+Alt+Shift+P on Windows) toggles picture in picture. It closes it when a page of the active row shows it. Otherwise it puts the active row's video in picture in picture, the focused pane of a split first, when the page's media session offers it: one video with sound that has played, or a page that handles the request itself. A page that never played has no session, and the key does nothing. Otherwise it closes a picture-in-picture window another tab of this window opened. The video keeps playing in the page when the window closes. The command bar's row, Enter or Exit Picture in Picture, is listed only when the key would do something (commandbar K25). Tabbed windows have it, private ones too; app windows and popups do not. Once Mp1 exists, the key opens it instead (BACKLOG S-95). | `MediaKeysTest.APageWithoutAVideoOffersNoPictureInPicture`, `MediaKeysTest.TheKeysAreCommandsOfTabbedWindows`, `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`; browser: `MediaKeysWindowTest.PictureInPictureFollowsTheKeyAndTheBar` | built |

`tooling/dev test player` runs `MediaKeysTest.*`. The browser test is separate.
