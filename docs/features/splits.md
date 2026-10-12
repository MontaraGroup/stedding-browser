# Feature: Splits

Status: **J1, J4, J6 built; J2 partial**; **J3, J5 planned** (all three open in BACKLOG S-102).
Owner docs: `docs/PRODUCT.md` §4. Patch: none of its own; each row lands with the item that implements it.

A split is one row and one unit for every sidebar verb; the model is Chromium's
split view.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| J1 | A split is one unit for the sidebar's verbs: it Space-pins together (J4) and a rename applies to every pane. Session extra data does not carry a split token: Chromium's own restore brings the pair back. | `SpaceWindowTest.SplitPanesTakeVerbsTogether` (the pin, J4), `SpaceWindowTest.SplitDoesNotRestoreFromSessionExtraData`, `SessionRebuildTest.SplitTokenIsNotReemitted`; browser: `SidebarClickTest.RenamingOnePaneNamesTheSplit` (both panes carry the name at once), `RestoreTest.TheSidebarComesBack` and its three `PRE_` steps (PLAN.md TST-4) (a split comes back whole through Chromium's own restore; a pair the user unsplit stays apart) | built |
| J2 | ⌘1–9 (tabs R19) and the ⌃⇥ strip (switcher X3) count a split as one; activating it activates the pane that was last active. | `SpaceWindowTest.RecentTabsCountASplitOnce` (the recent list; the pane that was last active is the one recorded); the ⌘1–9 half has no test | partial · the ⌃⇥ half is built; ⌘1–9 and the badges give each pane its own number (`stedding::NumberedTabs`, BACKLOG S-102, PLAN.md TAB-30) |
| J3 | ⌘W on a split: TBD. Check first what Chromium does to the other pane, then decide whether a pinned split's pane sleeps instead (pins H3) and record it here. | TBD | planned · BACKLOG S-102 |
| J4 | Move to Space, Sleep and ⌘D act on both panes together (the split is one selection, tabs R20–R22). A split sleeps as one row: Sleep Tab on the split on screen activates a visible row outside it, then discards both panes; if either pane is in use (tabs R6), neither sleeps and Sleep Tab on it is greyed. Sleep Other Tabs asked from one pane leaves the other awake, and never takes the split on screen. | SpaceWindowTest.SplitPanesTakeVerbsTogether (Move to Space and ⌘D reach both panes through `SpaceModel::SplitPeers`; the selection carries both panes, so `TabsToSleep` takes both); `SleepTabsTest.SleepTabOnTheActiveSplitSleepsBothPanes`; `SleepTabsTest.APaneInUseKeepsItsSplitAwake`; `SleepTabsTest.SleepOthersKeepsItsOwnRowAndTheScreen`. | built |
| J5 | A Space-pinned tab that joins a split leaves the pinned run for the split's row: keep or fix is TBD; the answer is a row here. | TBD | planned · BACKLOG S-102 |
| J6 | No ring around the panes: page U6–U7 (the outline colours mapped to the row-text tint; the 3 px highlight for a drop target only). | the U6 probe (page U6) | built |
