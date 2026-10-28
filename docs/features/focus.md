# Feature: Focus this Space

Status: **Fc1–Fc2 built. Fc3 planned** (BACKLOG S-61).

One Space, started by the user. No model.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Fc1 | Focus hides every other Space chip and the "+" (the switcher rebuilds with the active chip alone, and a chip drag does nothing while it lasts). The Space number keys do nothing: ⌃1–9 on the Mac, Alt+1–9 on Windows (`SetActiveSpaceByIndex` returns at once). Essentials stay. The command bar’s **Focus This Space** / **Leave Focus** row is the only toggle, and it has no chord. | `SpaceModelTest.FocusHidesOtherSpaces`; browser: `SpaceSwitchTest.FocusAndTheCoatLeaveTheActiveChipAlone` | built |
| Fc2 | Any Space switch leaves Focus, including choosing a tab in another Space from ⌘T, and so does the bar’s row. A foreground route to another Space leaves Focus, because it switches Space; a background route does not. A tab of another Space made active from outside the sidebar (an extension’s `chrome.tabs.update`, a page’s `window.focus()`, a notification’s click) brings its Space on screen (spaces B3) and leaves Focus. A Space deleted in another window does the same for a window that was showing it. Decided 2026-10-18: refusing the outside activation would leave a page on screen that the sidebar hides (BACKLOG S-145). | `SpaceModelTest.FocusHidesOtherSpaces`; `SpaceWindowTest.ASpaceDeletedElsewhereMovesThisWindowToItsNeighbour`; browser: `SpaceSwitchTest.AnOutsideActivationShowsTheTabsSpace` (the switch; Focus is not asserted there) | built |
| Fc3 | Focus would be per-window session data, and it would not start on. Private and popup windows have no Focus. Today `in_focus_` starts false, the session record does not store it (`SpaceModel::Serialize`), and the command bar lists the row only in a normal window that has Spaces. | `SessionRebuildTest.FocusSurvivesRebuild` (not written) | planned · BACKLOG S-61 |
