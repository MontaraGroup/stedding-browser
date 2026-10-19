# Feature: Recent-tabs switcher

Status: **X1, X2, X4, X5 built**; **X3 partial**: built before, the Windows way out written
2026-10-18, tests not yet run. On Windows Ctrl+Esc stays the Start menu's and a run is backed
out with Shift+Tab (X3, BACKLOG S-228); that way out is written into the Windows run but not
yet run on the PC. Linux (KDE's Ctrl+Esc) planned.
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
| X3 | Holding ⌃ past 150 ms shows a strip of up to five favicon+title cells (Space colour dot) over the content, a layered child of BrowserView like the command bar, in the theme's dialog colours; ⇥/⇧⇥ move the highlight, releasing ⌃ commits, Escape cancels. A window that stops being active (⌘-Tab, a click into another window), which takes ⌃'s release elsewhere, ends the run where it is, on the tab it reached, as a release does, and the next ⌃⇥ starts a new run: the strip had stayed over the page and the next ⌃⇥ went on from the old run (docs/history/plan-2026-09-26.md TST-9; 2026-10-18). On Windows Ctrl+Esc is the shell's own hot key for the Start menu, and Windows takes the chord before any window hears it: Escape pressed in a run, Ctrl still down, opens the Start menu, and the window, losing the foreground, ends the run on the tab it had reached, as any window that stops being active does (the installed build, 2026-10-18; BACKLOG S-228). Stedding leaves the chord to Windows: taking it back would need a system-wide low-level keyboard hook (`WH_KEYBOARD_LL`) on every run. Chromium sets one only while a full-screen page holds the Keyboard Lock (`ui::KeyboardHook::CreateModifierKeyboardHook`), and only at the page's request; a hook on every Ctrl+Tab would see every key pressed anywhere while the run lasts, which security software can flag (decided in the 2026-10-18 round; a hook was written that night and removed unbuilt). A run on Windows is backed out with the keys it already has. Ctrl still held, Shift+Tab steps back (or Tab on, wrapping round) to the first cell, the tab the run began on, and letting go ends the run there with the recent order as it was before the run, as Escape leaves it: a run's steps are not recorded as uses. Or Ctrl let go on the tab reached and Ctrl+Tab tapped goes back to the first tab too, but the tab reached then counts as used and comes next in the recent order. After Ctrl+Esc the Start menu is closed first (Escape), then Ctrl+Tab is tapped. **Linux:** under KDE Plasma Ctrl+Esc opens System Activity, which may end a run the same way; not looked at (planned). | unit: `RecentTabsSwitcherViewTest.ReleaseCommitsEscapeCancels`, `RecentTabsSwitcherViewTest.SteppingBackToTheFirstTabIsLikeEscape` (two steps on and two back, Shift pressed and let go with Ctrl held, neither ending the run, then Ctrl let go: on the first tab, the order as before; Tab on past the last cell, round to the first: the order as before, where counting the steps as uses would have changed it; Ctrl let go on the tab reached, then a tap: back on the first tab, the tab reached next in the order); browser: `NumberBadgeTest.CtrlTabEndsWithTheKeyOrTheWindow` (⌃ down and up as a keyboard's, where the strip's monitor hears them: a tap, a hold that Tab steps and the release commits, Escape sent straight into the window (from a real keyboard on Windows the shell takes it), the window going inactive mid-run, and Ctrl+Shift+Tab twice back to the first tab, Shift down and up as keys of their own on Windows and Linux, then Ctrl let go: on the first tab, and the next tap goes where it went before the run). live: tooling/drive holds ⌃, ⌃⇥, shot (`w2_ctrltab_strip`), release, shot; Windows: `tooling/acceptance/win/s173-live.ps1` tst9-6 (Ctrl held, Tab, Ctrl+Esc, Ctrl let go: the run keeps the tab it reached; the Start menu closed with Escape, a Ctrl+Tab tap goes back to the first tab) and tst9-6b (Ctrl held, Tab twice, Shift+Tab twice, Ctrl let go: back on the first tab, the browser in front), not yet run (TBD). ⌃-release arrives as a `VKEY_CONTROL` key-released event through `views::EventMonitor`, the way the ⌘-hold numbers already listen (tabs R11). | partial · written 2026-10-18, tests not yet run (the Windows way out: the unit and browser tests compiled on the Mac; tst9-6 and tst9-6b not yet run on the PC); the rest built before; Linux/KDE planned |
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
