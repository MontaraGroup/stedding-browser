# Feature: Focus this Space

Status: **Fc1–Fc2 built**; **Fc3 planned** (BACKLOG S-61). Owner: spaces. Patch: 0048.

One Space, one world, user-started. Not a therapist. No model.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Fc1 | Focus hides every other Space chip and the "+" (the switcher rebuilds with the active chip alone and chip drag is off while it lasts). ⌃1–9 do nothing while it lasts. Essentials stay. The command bar's **Focus This Space** / **Leave Focus** row is the verb. | `SpaceModelTest.FocusHidesOtherSpaces`; `SwitcherRulesTest.ShareCoatHidesOtherChips`; live: the bar's row | built |
| Fc2 | Any Space switch leaves Focus -- choosing a tab in another Space from ⌘T among them -- and so does the bar's row, the only toggle. A routing hit leaves Focus and follows the rule. So does a tab of another Space made active from outside the sidebar (an extension's `chrome.tabs.update`, a page's `window.focus()`, a notification's click), which brings its Space on screen (spaces B3). That was decided on 2026-10-18 over Focus refusing the activation, which would leave a page on screen that the sidebar hides (BACKLOG S-145). | `SpaceModelTest.FocusHidesOtherSpaces`; the outside activation's switch: browser `SpaceSwitchTest.AnOutsideActivationShowsTheTabsSpace` (Focus is not asserted there) | built |
| Fc3 | Focus is per-window session extra data; it does not start on. Private and popup windows have no Focus. | `SessionRebuildTest.FocusSurvivesRebuild` (not written yet; Focus is not saved today) | planned · BACKLOG S-61 |
