# Feature: Share coat

Status: **Sc1 and Sc3 built. Sc2 planned** (BACKLOG S-61). Owner: spaces. Patch: 0048.

Hide Other Spaces stops painting the other Spaces. The user turns it on and off. Nothing turns it on by itself.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Sc1 | With the coat on, the switcher draws only the active chip. No "+" and no inactive names. The command bar's **Hide Other Spaces** / **Show Other Spaces** row puts it on and takes it off. | browser: `SpaceSwitchTest.FocusAndTheCoatLeaveTheActiveChipAlone`; live: the bar's row | built |
| Sc2 | Auto-arm when a tab in this window captures a window or display; disarm when capture ends. Setting `stedding.spaces.hide_others_while_sharing`, default on. | `ShareCoatControllerTest.CaptureArmsAndDisarms` (not written) | planned · BACKLOG S-61 |
| Sc3 | With the coat on, the command bar lists tabs and archived rows from the active Space only. | `CommandBarViewTest.ShareCoatFiltersToTheActiveSpace`; browser: `CommandBarTest.HidingOtherSpacesHidesThemFromTheBar` | built |
