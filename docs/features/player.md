# Feature: Mini player

Status: **Mp5 built** (since patch 0060, unreleased, BACKLOG S-122); **Mp1–Mp4 planned** (BACKLOG S-95). Owner docs: `docs/PRODUCT.md` §9. Patch: 0060 (Mp5).

Picture-in-picture is a child of the page card, not Chromium's always-on-top
overlay window. No model. Until Mp1 exists, the key of Mp5 opens Chromium's
own window.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Mp1 | PiP is `MiniPlayerView`, clipped to the card. Chromium's `VideoOverlayWindowViews` is not created in a Stedding window. | `MiniPlayerTest.UsesTheCardHostNotTheOverlayWindow` (not written yet) | planned |
| Mp2 | Leaving a tab that is playing unmuted video enters Mp1. A muted tab does not auto-pop. | `MiniPlayerTest.LeavingAPlayingVideoPopsOut` (not written yet) | planned |
| Mp3 | A non-active unmuted audio tab shows a 44 DIP strip when no video player is up. | `MiniPlayerTest.BackgroundAudioShowsTheStrip` (not written yet) | planned |
| Mp4 | Close hides the player. Back-to-tab activates the source tab and its Space. Drag stays inside the card. One player per window. | `MiniPlayerTest.ReturnActivatesTheSourceTab` (not written yet) | planned |
| Mp5 | ⌥⇧⌘P (Ctrl+Alt+Shift+P on Windows) toggles picture in picture. It closes it when a page of the active row shows it. Otherwise it puts the active row's video in picture in picture, the focused pane of a split first, when the page's media session offers it: one normal player that has played with sound, or a page with its own handler for the request. A muted autoplay video, a video that never played or a page playing two videos is not offered, and the key does nothing there. Otherwise it closes a picture-in-picture window another tab of this window opened. The video plays on in the page when the window closes. The command bar's row, Enter or Exit Picture in Picture, is listed only when the key would do something (commandbar K25). Tabbed windows have it, private ones too; app windows and popups do not. Once Mp1 exists, the key opens it instead (BACKLOG S-122). | `MediaKeysTest.APageWithoutAVideoOffersNoPictureInPicture`, `MediaKeysTest.TheKeysAreCommandsOfTabbedWindows`, `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`; browser: `MediaKeysWindowTest.ThePictureInPictureKeyTogglesThePagesVideo`, `MediaKeysWindowTest.ThePictureInPictureKeyClosesItFromAnotherTab`, `MediaKeysWindowTest.TheBarOffersPictureInPictureOnlyWithAVideo` | built · not yet tried by hand; the window is Chromium's until Mp1 |

## Running the tests

```bash
tooling/dev test player
```
