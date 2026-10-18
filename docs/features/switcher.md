# Feature: Recent-tabs switcher

Status: **X1–X5 built**.
Owner docs: `docs/PRODUCT.md` §1. Patch: 0023.

⌃⇥ walks the most recently used tabs of the active Space; a tap goes to the
previous tab, a hold shows a strip of the five most recent over the content.
⌥⌘↑/↓ traverse rows, ⌥⇧⌘↑/↓ move the active row.

On Windows every chord below is the Mac's with ⌘ read as Ctrl and ⌥⌘ as Ctrl+Alt
(Alt+1–9 for the Spaces themselves); the full map is `docs/features/windows.md` N7.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| X1 | SpaceModel keeps an activation history per Space (a closed tab leaves it; a Space switch scopes it); ⌃⇥ / ⌃⇧⇥ walk the five most recent tabs of the active Space, essentials included; Chromium's kCtrlTabMru stays off (it is global across windows and would activate Space-hidden tabs, breaking B7). | SpaceWindowTest.ActivationHistoryIsPerSpace, SpaceWindowTest.CtrlTabWalksRecentTabsOfTheActiveSpace (through `IDC_CYCLE_TO_NEXT_TAB`, beside NextTabSkipsOtherSpaces). | built |
| X2 | A tap switches to the previous tab silently. | SpaceWindowTest.CtrlTabTapGoesToPreviousTab (a tap, and Escape mid-run). | built |
| X3 | Holding ⌃ past 150 ms shows a strip of up to five favicon+title cells (Space colour dot) over the content, a layered child of BrowserView like the command bar, in the theme's dialog colours; ⇥/⇧⇥ move the highlight, releasing ⌃ commits, Escape cancels. | RecentTabsSwitcherViewTest.ReleaseCommitsEscapeCancels; live: tooling/drive holds ⌃, ⌃⇥, shot (`w2_ctrltab_strip`), release, shot. ⌃-release arrives as a `VKEY_CONTROL` key-released event through `views::EventMonitor`, the way the ⌘-hold numbers already listen (tabs R11). | built |
| X4 | ⌥⌘↑ / ⌥⌘↓ select the previous / next visible row (SelectRelativeTab already skips hidden tabs); ⌥⇧⌘↑ / ⌥⇧⌘↓ move the active row within its container, folder-aware (MoveTabRelative), and trade places with the next row on screen: rows the user cannot see -- another Space's tabs, splits and folders, a collapsed pinned run's pins -- are passed over, and with only such rows beyond it the row stays where it is. A collapsed folder or group of the active Space is a header on screen, and a row like any other. The row had traded places with a hidden neighbour, so nothing on screen moved (docs/history/plan-2026-09-26.md TAB-32, BACKLOG S-140). | TabStripModelTest.MoveTabRelativeStaysInsideItsFolder (a row inside a folder stays inside; a folder beside a row is one row to jump; Chromium's group rules apply where no folder is involved); `TabStripModelTest.MoveTabRelativePassesRowsTheUserCannotSee` (a hidden tab between two rows on screen, only hidden rows beyond, a hidden folder between two rows, a hidden tab inside a folder); browser: `SpaceSwitchTest.MoveUpAndDownPassAnotherSpacesRows` (another Space's tab, then its folder, between two rows of the Space; Move Up with only another Space's rows above moves nothing) | built · the 2026-10-18 change not yet tried on the real window |
| X5 | Setting off returns ⌃⇥ to sidebar order (IDC_CYCLE_TO_NEXT_TAB as today). | SpaceWindowTest.CtrlTabSettingOffUsesStripOrder. | built |

## Notes

- The history lives in `SpaceModel` beside `last_active_`: one vector of tab
  handles per Space, most recent first, capped at 40; the strip and ⌃⇥ read the
  first five through `RecentTabs()`. A run (`CycleRecent`, `EndCycle`,
  `CancelCycle`) freezes the list while ⌃ is down so each step goes one further
  back; the landing tab becomes the most recent when the run ends. Leaving the
  Space ends a run where it is.
- `RecentTabs()` follows the history with the Space's never-activated tabs in
  sidebar order (`SpaceWindowTest.RecentTabsFallBackToSidebarOrder`),
  so the strip always has somewhere to go, as Chrome's MRU does with creation times.
- Chromium's `kCtrlTabMru` stays off; the command controller asks
  `spaces::CycleRecentTab()` first, which declines in popup and private windows
  and when the setting is off, so those keep Chromium's strip order.
- ⌃⇥ while the command bar is open: the bar closes on the focus change and the
  run proceeds behind it. Tabs inside a collapsed folder are still in the history
  and can be reached; the strip shows them like any other cell, and the tab reached
  keeps its row under the collapsed header (folders F3). Ctrl-Tab offers only the
  Space's own tabs, and ⌘1–9 reach only rows on screen
  (`SpaceSwitchTest.NumbersAndCtrlTabReachOnlyRowsOnScreen`, BACKLOG S-139).
- The bar's actions mode carries "Go to the Most Recent Tab", a tap (K9).
