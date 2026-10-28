# History archive

Finished history in one place: the closed backlog items, the project log before 2026-10-15,
and the plans and ledgers that are done. None of it is a list of work. What is open is
[BACKLOG.md](../../BACKLOG.md), what each feature does is its spec under
[features/](../features/), and what was built lately is [PROJECT-LOG.md](../PROJECT-LOG.md).
It is kept because specs, patch messages and release notes cite the ids and rows in it, and
every id cited elsewhere resolves here: the `S-` ids of closed backlog items, round 6's
`R6-` ids and decisions, the operator rounds' round and row numbers, and the code review's
`S-179` to `S-210`.

The audit of 2026-09-26 stays a file of its own, [plan-2026-09-26.md](plan-2026-09-26.md),
because Stedding's code cites it by path. Patch messages written before 2026-10-14 cite the
other plans at their old paths: `PLAN.md`, `docs/ROUND6-PLAN.md` and `docs/ARC-ROUND2.md`.

| Where | What it was | Ids cited elsewhere |
|---|---|---|
| [plan-2026-09-26.md](plan-2026-09-26.md) (its own file) | The audit of the series of 52 patches (2026-09-26), its phases and every item it raised, with the status notes added until 2026-10-14. Was `PLAN.md` | `TAB-`, `SPC-`, `WIN-`, `CMD-`, `WEB-`, `PLT-`, `TST-`, `SER-`, `REPO-`, `DOC-` and their `-F` first-pass rows |
| [Closed backlog items](#closed-backlog-items) | The Done table of `BACKLOG.md`: every closed item and what closed it | the `S-` ids of closed rows |
| [Project log before 2026-10-15](#project-log-before-2026-10-15) | What was built, round by round, from the audit's decisions of 2026-09-26 to 2026-10-14, with the evidence, and the older "State of the project" and hand-over sections of the log | dates |
| [Round 6 plan](#round-6-plan) | Round 6 (2026-09-04 and 05): the Zen-mods review, its decisions and how each part landed as patches 0016 to 0036. Was `docs/ROUND6-PLAN.md` | `R6-01` to `R6-32`, decisions `D1` to `D11` |
| [The operator's rounds](#the-operators-rounds) | The operator's feedback rounds 2 to 11 (2026-09-01 to 10-02): what each found and how it was fixed and checked. Was `docs/ARC-ROUND2.md` | round and row numbers ("round 10, row 3") |
| [The code review of 2026-10-15](#the-code-review-of-2026-10-15) | The code review of the series of 64 patches (2026-10-15): what patch 0065 fixed, what was filed, the root causes it traced for open `BACKLOG.md` items, and the leads it could not prove | `S-179` to `S-210` |

The items of the 2026-09-26 audit that were still open on 2026-10-14 became `BACKLOG.md`
rows, each naming the ids it carries.

## Closed backlog items

| Id | Item | Closed by |
|---|---|---|
| S-335 | Sidebar width getting reset randomly by false double clicks | Closed 2026-10-28: In Chromium Views, window-level click counts track temporal and spatial proximity across consecutive presses anywhere in the window. A second click on or near the sidebar edge within 500 ms of an action elsewhere (e.g. clicking a tab's close button, a folder header, or the page gutter) carried click count 2 and triggered a false reset to default width (352 DIP). Resolved by requiring both presses to land on the handle within double-click distance and interval (`docs/features/sidebar.md` Y22; `SidebarResizeHandleTest.ASecondClickWithoutAFirstPressDoesNotResetTheWidth`, `SidebarFormsTest.TheEdgeResizesAndResetsTheWidth`). |
| S-324 | ⌘T on a folder's last tab, when it is the window's last tab, opened the new tab inside the folder | Closed 2026-10-27 by pull request 49 (from an outside contributor, corrected before the merge) in patch 0057: Chromium makes a typed tab added at the end the active tab's child only so that closing it goes back (`AddWebContents`, the "quick look-up" case), and F25 filed that child into the opener's folder. `AddWebContents` now marks that case and the insert keeps such a tab out of the folder, while links, target=_blank tabs and duplicates still join it and closing the new tab still goes back (`docs/features/folders.md` F25; `FolderTabsTest.ATabOpenedFromAFolderTabLandsInsideIt`, its new step seen failing without the fix). The pull request as sent did not compile and would not have fixed it: it read `add_types`, which the insert does not have, and ⌘T carries `ADD_INHERIT_OPENER` too. |
| S-322 | A crash after ⌘Y and then ⌘S (GitHub issue 44, a comment) | Closed 2026-10-27: with the animations off (Settings or Reduce Motion) a collapse ends inside its own start, and the slide-out the open panel held began a second motion of the strip inside it, cancelling an animator that was never made. ⌘S now waits for the panel to go, the strip's slide-out reaction runs a turn later, and a motion with no animator cancels cleanly (`docs/features/sidebar-panels.md` Pn4; `SidebarPanelsTest.CmdSWithAPanelOpenClosesItThenTheSidebar`, which crashed on the Windows test machine, whose animations are off) |
| S-319 | Two Peek findings of the fifth review (2026-10-26) | Closed 2026-10-26: (1) fixed in patch 0102 (`docs/features/peek.md` P18): a key pressed after a held press, other than a modifier, ends the press, so a press held to select text and then Enter on a focused link no longer peeks (`PeekTest.AnEnterAfterAHeldPressFollowsTheLinkInThePin`, failed before the fix); (2) meant: Open as Tab from a shared essential's peek, while the Space on screen has its own session, goes to the Space that shows the shared essentials, since the Space on screen shows none (P7 now says so). |
| S-305 | A setting to hide an essential's "moved from its page" dot and its Reset button (GitHub issue 36) | Built 2026-10-26 on the owner's word ("maybe by default, you decide"): "Mark pinned tabs that left their page", off by default, in Settings › Stedding › Tabs and the command bar (`docs/features/pins.md` H28, settings T36); the menu's Reset to Pinned Page stays. |
| S-317 | A pin's ⌘W and Sleep Tab may show an essential: which rule wins | Decided 2026-10-26 by the owner: GitHub issue 30's rule everywhere. A pin's ⌘W (pins H3) and Sleep Tab (tabs R5) show the row a close would show, the essential used last included; a Space's only row with no essential used before it still sleeps nothing. The code already did this since issue 30; H3 and R5 now say so. Raised by the third review of 2026-10-26. |
| S-301 | Closing a tab opened from an essential shows another row, not the essential (GitHub issue 30) | Changed 2026-10-24 on the owner's word (`docs/features/tabs.md` R33, R35): an essential the Space shows counts in the history of tabs used, so the tab used before comes back after a close, an essential included; until then the rule passed over essentials (the owner's choice of 2026-10-20). `SpaceWindowTest.ACloseShowsTheEssentialUsedBefore`, red with the change taken out; the close suites green on the Mac. |
| S-298 | A link opened from an essential pushes the pinned run under the Clear line (GitHub issue 29) | Fixed 2026-10-24 in patch 0070 (`docs/features/pins.md` H14): a loose tab that lands just before a pinned folder at the run's head counts as inside the run and moves to just after it a turn later, as one before a pin did; with the run beginning with a pinned folder, a link from an essential stayed above the run and every pin and pinned folder was drawn under the line until it closed. `PinnedRunTest.ALinkFromAnEssentialPassesAPinnedFolder`, red with the fix taken out; Mac green. |
| S-299 | A row cannot be dropped above the first tab under the Clear line (GitHub issue 26) | Fixed 2026-10-24 in patch 0083 (`docs/features/tabs.md` R63): the side of the line a dragged row takes is read from where the row is drawn and worked out again at every move; it was read from an offset that is zero while the row follows the pointer, so a row dropped in the first place under the line became a pin. `PinnedRunTest.ARowDroppedOnTheFirstRowTakesTheTop`, red before the fix; the line's other drops (`PinnedRunTest.ARowDraggedAcrossTheLineTakesThePinThere`) still pass; Mac green. |
| S-300 | A tab cannot be dropped at a place inside a folder (GitHub issue 27) | Fixed 2026-10-24 in patch 0083 (`docs/features/folders.md` F40): a tab's row dragged over an open folder's rows goes among them at the place the pointer shows, with the bar there, as a folder's header does (F39); before, only the header took a tab, at the folder's end, and a row dragged within a folder left it. `FolderTabsTest.ARowDraggedInAFolderTakesThePlaceShown`, red before; Mac green. |
| S-81 | Import from Arc on Windows | Built 2026-10-24 (`docs/features/import.md` I27) and shipped in 0.3.0 beta 13: Arc for Windows' Store package folder holds the sidebar and `User Data`; its passwords are unsealed with Local State's DPAPI-sealed key and AES-256-GCM. Seen whole on the PC with Arc for Windows 1.129.0.288: the welcome flow moved 1 Space, 9 tabs, 1 folder, 2 essentials, 2 history entries and 1 password, the login listed in Stedding's password manager. A value bound to Arc itself ("v20") is left out; that Arc had none |
| S-296 | Google Pay in a Space with its own session offers the shared session's Google accounts (GitHub issue 25) | Fixed 2026-10-24 in patch 0067 (`docs/features/sessions.md` S36): a payment app's service worker and the window it opens to pay live in the profile's jar; a page in a Space with cookies of its own is offered no payment app, and a site falls back to its own checkout. `SpacePaymentsTest.ASpaceWithItsOwnJarIsOfferedNoApp` failed with the fix turned off; Mac and PC green. Not seen: Google Pay's own script on a real checkout, which needs a Google account signed in inside a Space |
| S-289 | The drag into the essentials and out, animated (GitHub issue 16) | Built 2026-10-24 in patch 0086, its test in 0087 (`docs/features/pins.md` H27): a floating copy follows the pointer, a card over the essentials and a row over the list, and the other container parts where the drop would land, in place of the lit grid and the bar. `PinnedRunTest.ADraggedTabTurnsIntoACardAndBack`; seen with the real pointer on the Mac's release build; Mac and PC green |
| S-292 | The restore bar's close button does nothing (GitHub issue 24) | Fixed 2026-10-24 (`docs/features/sidebar.md` Y29): the strip between the address row and the page card is the window's title bar, and the infobars sit in it, so the window took a press on the restore bar's close button, its link or its text as the title bar's and the bar never closed; an infobar there now takes its own presses. Its icon was Chromium's logo: `vector_icons::kProductRefreshIcon`, which this bar and the browser's other prompts draw, is now the Stedding mark (`branding/vector_icons/product_refresh.icon`). `SidebarFormsTest.TheRestoreBarClosesFromItsButton`, red before the fix (HTCAPTION); a real click on an infobar's close button closed it on the Mac's release build. |
| S-293 | The address field is a different width in each state (GitHub issue 14) | Fixed 2026-10-24 on the owner's choice of the whole field (`docs/features/toolbar.md` T34, T29; sidebar Y29): hovered, focused, edited and with its suggestions, the field is the whole row, and a click on its empty start focuses the address; the hover tint had been a band from the chip to the field's right edge and the empty start the window's title bar. `AddressBandTest.TheFieldIsWholeInEveryState`, red before (the title bar); seen on the Mac's release build: the hover tint and the focus ring across the whole field, the address where it was. |
| S-294 | The site chip looks hovered at rest | Fixed 2026-10-24 (`docs/features/toolbar.md` T44): the site chip with its icon alone has no capsule at rest on the page-coloured row, only its hover and press; with its text ("Not Secure") the capsule stays. Seen on the Mac's release build. |
| S-295 | The "Not Secure" chip's icon sits low | Fixed 2026-10-24 (`docs/features/toolbar.md` T44): a chip the field makes shorter than its own height (21 DIP of 24) lays its icon and text out in the height it has; they had been laid out in 24 DIP from its top, and the warning sat 1.5 DIP below the text's middle. `AddressBandTest.AChipCentresItsIconAndText`. |
| S-290 | During a tab drag the address row's chip and page buttons follow the dragged tab | Fixed 2026-10-24 in patches 0075, 0077 and 0083 (`docs/features/tabs.md` R61): while a drag holds the page on screen, all that follows the active tab describes that page: the address row's model (address and security chip), its contents and page buttons (the page's actions stay lit, though its tab is not the active one), its colour, and the back and forward buttons; the hold's end follows the active tab again. `TabDropTest.APressWaitsAndADragKeepsThePage` now checks each of them mid-drag and after the drop, red before the fix (the address row described the dragged row's page). Seen on the Mac's release build with the real pointer. |
| S-287 | The essentials' top row moves the window (GitHub issue 23) | Fixed 2026-10-23 in patch 0077 (`docs/features/sidebar.md` Y29): the essentials' row beside the address row lay in the window's title-bar band, where the frame took a press as a drag of the window, so a card there never got its click. A card, a row or a control there now takes its own press; only the strip's empty ground there is the title bar. `SidebarClickTest.EveryEssentialTakesItsPress`, `SidebarFormsTest.TheSlidOutSidebarsEssentialsTakeTheirPress` (red before the fix: the frame answered HTCAPTION). Released in 0.3.0 beta 11. |
| S-275 | The address jumps left when the field takes focus (GitHub issue 14) | Fixed 2026-10-23 in patch 0078 (`docs/features/toolbar.md` T18): the address keeps the place it had at rest while the field is edited, until what is typed no longer fits; Chromium's layout had moved it to the field's left edge on focus. `AddressBandTest.TheAddressKeepsItsPlaceWhenEdited`, red before the fix. Released in 0.3.0 beta 11. |
| S-285 | Pressing a tab to drag it opens the tab first | Fixed 2026-10-23 in patches 0075 and 0083 (`docs/features/tabs.md` R61, `splits.md` J10): a press on a row whose tab is not on screen waits; its release selects, as a click; a drag selects the tab for the drag while the window keeps the page that was on screen, and gives that page back unless the drop made a split or changed Space. The drag's brief selection is not a visit: Ctrl-Tab's order and the Space's last tab stay. `TabDropTest.APressWaitsAndADragKeepsThePage`. Released in 0.3.0 beta 11. |
| S-288 | New tabs at the top of the list (GitHub issue 22) | Built 2026-10-23 in patch 0087 on the owner's word (`docs/features/tabs.md` R62, `settings.md` T30): Settings › Stedding › Tabs › "Open new tabs at the top of the list", off by default; on, Cmd-T and + New Tab open a tab under + New Tab, below the Space's pins and above its older tabs and folders. `PinnedRunTest.NewTabsOpenAtTheTopWhenAsked`. Released in 0.3.0 beta 11. |
| S-281 | `PinnedRunTest.ADragTakesATabIntoTheEssentialsAndOut` timed out once on the PC's release build | Cause found and fixed in the tests 2026-10-23 (patch 0077): on Windows a tab drag's search for the window under the pointer (`display::win::LocalProcessWindowFinder`) passes over a window the native occlusion tracker counts as covered. With another application's window over the whole screen, the tracker went on counting the raised test window covered, the drag found no window of its own and tore the tab off into a new window, which cancelled it; that evening both pinned-run drag tests failed every run on the PC, and passed whenever logging slowed them. `stedding::test::KeepAboveOtherWindows` now takes the window out of the tracker's count. No change to the browser. |
| S-280 | `AddressBandTest.EveryChipFitsTheField` timed out now and then under AddressSanitizer | Fixed 2026-10-23 in the test (patch 0079): it showed the translate action's chip, which the translate controller hides once the page's language is known, later than the test on a slow build; it now takes the zoom action's chip and names which action stayed hidden if one does. Passed in 0.3.0 beta 10's `win-asan` run and on the Mac. |
| S-277 | Drag a tab into the essentials, and out (GitHub issue 16) | Built 2026-10-22 in patch 0086 on the owner's word (`docs/features/pins.md` H27): a tab's row dragged over the essentials, or the room above the Space's title, lights them and becomes an essential where it is dropped; an essential dragged onto the list shows the bar where it will land and stops being one there, a tab under the Clear line or a pin of the Space over it. `PinnedRunTest.ADragTakesATabIntoTheEssentialsAndOut`. |
| S-276 | Essentials shrink to fit as more are added (GitHub issue 15) | Built 2026-10-22 in patch 0085 on the owner's word (`docs/features/sidebar.md` Y33): up to four cards on one row, then two rows, the first the fuller, a third only once a card would be narrower than the rail's square. `SidebarRailTest.TheEssentialsShrinkToFitTwoRows`; `SidebarFormsTest.AShortWindowCutsNoRowOff` now needs thirty essentials for its tall grid. Seen on the Mac's release build with 3, 6 and 10 essentials (one row of three, three and three, five and five). |
| S-274 | Every Space with its own session, as one setting (GitHub issue 8) | Built 2026-10-22 in patch 0084 (`docs/features/sessions.md` S35, `settings.md` T29): "Give every new Space its own session" in Settings → Stedding → Spaces, off by default; on, a Space added starts with its own session, and turning it on asks whether the Spaces that share one should have their own too, naming how many and how many open pages would reload; off, it changes no Space. `SpaceRegistryTest.ANewSpaceTakesTheOwnSessionSetting`, `SettingsSpacesTest.EveryNewSpaceCanHaveItsOwnSession`. Seen on the Mac's release build the same night: the row, off; switched on with one Space holding a web page, the question ("One Space still shares the session ... One open page reloads ..."), with New Spaces Only and Turn On for All. Open, for the owner: on by default for new profiles, or not (it ships off). |
| S-273 | The Copy Link button kept its hover after a click (GitHub issue 11) | Fixed 2026-10-22 in patch 0083 (`docs/features/copy-link.md` L7): a page action's press stays pending until a bubble or panel takes the button, and Copy Link opens neither, so the press's ripple, and the fill with it, stayed after the pointer had gone; the press now ends as a button's does before the action runs. `CopyLinkTest.TheButtonLetsGoOfItsHoverAfterAClick`, red before the fix (the ink drop held at its pending state). Seen on the Mac's release build with the real pointer: lit under the pointer, the check mark after the click, no fill once the pointer left. |
| S-271 | A tab dragged into the pinned run unpinned the run's last pin | Fixed 2026-10-22 in patch 0083 (`docs/features/pins.md` H14): nothing decided the pin at a drop, so a loose tab dropped among the pins stayed loose and the sidebar drew the Clear line above it, the run's last pin under it; a pin dropped among the loose rows stayed a pin. A row dragged across the line now takes the pin of the side it is dropped on, where it is dropped, and the line is drawn during the drag where the drop would leave it; between the run's last pin and the first loose row the row's middle against the line's decides. `PinnedRunTest.ARowDraggedAcrossTheLineTakesThePinThere`, red before the fix. Seen on the Mac's release build with the real pointer: a loose tab dragged between two pins joined the run there with every pin above the line, and a pin dragged among the loose rows left the run. |
| S-269 | A tab group made with animations off read a callback before it existed | Fixed 2026-10-22 in patch 0071 (`docs/features/spaces.md` B33): `TabGroupView` declared its row-visibility callback after its layout manager, whose installation can end an animation at once when animations are off (reduced motion, a remote desktop session) and run that callback. Found by the Windows checks build over a remote desktop: `FolderTabsTest.EveryLabelInTheSidebarSuitsItsGround` crashed when a dragged group header came back. `FolderTabsTest.AGroupMadeWithAnimationsOffShowsItsRows` makes the path run on every machine. |
| S-268 | A hover state on the New Tab row (GitHub issue 12) | Built 2026-10-22 in patch 0083 on the owner's word (`docs/features/sidebar.md` Y32): the "+ New Tab" row takes the tab rows' hover tint and corner radius under the pointer and the selected row's fill while pressed. `SidebarClickTest.TheNewTabRowLightsUnderThePointer`. |
| S-259 | A Copy Link button in the address field (GitHub issue 11) | Built 2026-10-22 in patch 0083 (`docs/features/copy-link.md` L7, settings T28, toolbar T46): Chromium's Copy Link action as a page action before the star; a click copies the clean link, an Option-click (Alt-click) the Markdown link; a setting, on by default, hides it. `CopyLinkTest.*`. |
| S-260 | A tab dragged onto another Space's chip and held there switches to that Space | Built 2026-10-22 in patch 0083 on the owner's choice of Arc's way (`docs/features/spaces.md` B12): half a second's rest on another Space's chip files the dragged tabs there and switches, and the drag goes on into that Space's list; a drop beside a chip takes the nearest; only the lit chip grows in the dots form. `TabDropTest.ARestOnAChipSwitchesToItsSpaceForTheDrop` and four more, `SwitcherRulesTest.ATabDropTakesTheNearestChip`. The owner: "I cannot drag tab to another space". |
| S-261 | A folder dragged into another folder | Built 2026-10-22 in patch 0083 (`docs/features/folders.md` F10, F38, F39): a header dropped on another folder's header goes into it, at its end, whole; between an open folder's rows it goes there; a nested folder's header drags too. `FolderTabsTest.AFolderDraggedOntoAFoldersHeaderGoesIntoIt` and four more, `TabStripModelTest.MoveFolderInto*`, `TabCollectionObserverTest.Folder*`. |
| S-262 | A tab list that ends against the sidebar's bottom edge | Built 2026-10-22 in patch 0083 (`docs/features/sidebar.md` Y30): a list taller than the sidebar scrolls past its last row by half its height; a list that fits does not scroll. `TabRowRulesTest.AListTallerThanItsRoomScrollsHalfItPastTheEnd`, `SidebarClickTest.AListScrollsHalfItsHeightPastItsLastRow`. |
| S-263 | A pin sent home kept its last page's title in its row | Fixed 2026-10-22 in patch 0083 (`docs/features/pins.md` H1, H3): the row is told when the pin is replaced by its home asleep, so it shows the home's title at once; a pin made on the New Tab page takes its first web page as home. `SidebarClickTest.APinSentHomeShowsItsHomeInItsRow`, `SpaceWindowTest.APinMadeOnTheNewTabPageTakesItsFirstWebPageAsHome`. |
| S-264 | A link's tab drawn a level to the right of its page | Changed 2026-10-22 in patch 0083 (the owner: "just below"): "Show tabs under the tab that opened them" is off by default (settings T26, tabs R57). |
| S-265 | Every folder looked grey | Fixed 2026-10-22 in patch 0083 (the owner's choice: never grey the header; tabs R7, folders F12): a folder whose tabs all slept, as every folder does after a relaunch, dimmed its header. `FolderRowsTest.AHeaderNeverLooksAsleep`, `FolderTabsTest.AHoverDrawsNothingOfTheFolder`. |
| S-266 | A link from a tab in a nested pinned folder unpinned the folder | Fixed 2026-10-22 in patch 0083 (`docs/features/folders.md` F38): the new tab stayed in the nested folder, which made the whole folder no longer all pins; it now leaves for the top of the rows under the line, as from any pin. `PinnedRunTest.ALinkFromANestedPinnedFolderLeavesItInTheRun`, failing without the fix. Reported by the owner on 2026-10-22. |
| S-267 | What a tab uses, in its hover card | Built 2026-10-22 in patch 0083 on the owner's ask of that day ("Memory + CPU + network after 2 s"; `docs/features/pins.md` H25): after the card has rested 2 seconds on a tab, a line at its foot gives the tab's memory, CPU and network rate, read again every second; "Asleep" for a tab asleep; no GPU figure, as one GPU process draws for every tab. Memory and CPU from Chromium's resource attribution for the tab's page alone, the network rate from its task manager, which runs only while a line is due. `TabResourceLineTest.*`, `HoverCardPictureTest.ACardShowsItsTabsUseAfterAPause`. What the task manager costs while a card rests with ~100 tabs open is not measured: TBD. |
| S-230 | The command bar lists an open tab as archived too | Done 2026-10-20 in patch 0072 (`docs/features/archive.md` A13); the PC's run it waited on came with 0.3.0 beta 2: the archive and sessions tests passed in its Windows release and checks sweeps, 2026-10-21. |
| S-220 | A test left a profile folder in the real data folder | Fixed 2026-10-19 in patch 0072: the unit test suite points the data folder at a temporary one and `tooling/dev` warns when a run leaves one in the person's folder. Checked 2026-10-21: no `test_scoped_temp_dir*` folder is left in `~/Library/Application Support/Stedding` or `Chromium`. |
| S-254 | Essentials per Space (GitHub issue 8) | Built 2026-10-22 in patch 0083, after the issue's second comment: the owner chose essentials of a Space's own for a Space with an Independent session, and only those there (ADR 0028, `docs/features/spaces.md` B6, `docs/features/sessions.md` S8, S33 withdrawn, settings T25 withdrawn). An essential pinned in such a Space stays in its session, a restart puts it back there, turning the session off makes its essentials its pins, and a deleted Space's go where its tabs go. Until then (the owner, 2026-10-21) essentials were shared by every Space, as in Arc, and pinning a tab of such a Space signed it out, with a warning. |
| S-252 | A drag test that reads the machine's real cursor | Checked 2026-10-21, night, on the series of 0.3.0 beta 2: with the test's window moved so the dragged row, then each of the other two, lay under the machine's real pointer (no real input), the step that had failed passed every time, and `TabDropTest.*` with `TabDropRtlTest.*` passed 54 of 54 in three runs. Not reproduced since; most likely closed by patch 0077's pointer changes (the pointer watcher's root location). The window move stays in the test (patch 0077), so the step always meets the case. 2026-10-22, night: it met it. In the Mac's sweep of 0.3.0 beta 4 the step failed, and 5 of 5 alone, with the machine's pointer resting at the right of the screen and the window moved under it (most of the window off the screen); with the window moved clear of that pointer instead it passed 5 of 5, and `TabDropTest.*` with `TabDropRtlTest.*` 18 of 18. The likeliest reason, not traced: macOS sends a window its own events for a pointer the window moves under, which a drag the test sends cannot share. A person's drag is the one pointer there is, so this is the test's fault, not the product's. The test now keeps its window clear of the machine's pointer and says so if it cannot (patch 0077). |
| S-253 | Turning vertical tabs back on during a drag's end crashes in Chromium's tab strip | Fixed 2026-10-21 in patch 0077: `TabStrip::Reset` now finishes the drag's end animations before the tab container leaves the window, as `~TabStrip` does (`HorizontalStripTest.VerticalTabsComeOnAsADragEnds`, crashing without the fix); passed in the Mac and Windows sweeps of 0.3.0 beta 2, the checks build included. |
| S-104 | With the address row hidden, its controls in the command bar | The second half of round 6's D10, planned with no id: while "Hide the address row with the sidebar" is on (off by default, T8), the extension actions, the media button and page info are reached from the command bar's actions mode, and ⌘E cycles the extension actions Built 2026-10-20 in patch 0075 on the owner's choices of that day; its tests pass on the Mac's release build, each failing with its product change taken out; not yet used by hand. `docs/features/toolbar.md` T39, T40, commandbar K31 to K33, shortcuts Z9; `HiddenRowControlsTest`. ⌘E is taken from Find's Use Selection for Find, which keeps its menu row. |
| S-110 | At launch, only the selected tab loads | A setting, "On startup, load": the selected tab only, or the essentials too, or the whole active Space. Every other restored tab comes back asleep and loads when it is selected, as imported tabs already do (import I3), so a large sidebar costs nothing at launch. Seen in Nook (ADR 0021: rebuilt from this description, nothing copied). Medium Built 2026-10-20 in patch 0075 on the owner's choices of that day; its tests pass on the Mac's release build, each failing with its product change taken out. Used by hand on Windows' beta 21: a restored tab came back asleep but its row, with no favicon, was drawn awake; fixed in patch 0077 (`docs/features/tabs.md` R46). `docs/features/tabs.md` R45 to R48, settings T22; `StartupLoadTest`. |
| S-111 | Tabs sleep on a timer and under memory pressure | An unpinned tab that is not on screen sleeps after an idle time the user picks (never, 5 minutes, 30 minutes, 4 hours); under memory pressure the least recently used sleep first. Never a tab on screen, playing sound, in picture in picture, or using the camera or microphone (R6's gate). With it, a **Sleep Other Tabs** row in the command bar for every Space and window. Chromium's Memory Saver, off in Stedding, is the engine to judge first. Seen in Nook (ADR 0021: rebuilt from this description, nothing copied). Medium Built 2026-10-20 in patch 0075 on the owner's choices of that day; its tests pass on the Mac's release build, each failing with its product change taken out; not yet used by hand. `docs/features/tabs.md` R39 to R44, settings T21, commandbar K34; `SleepSweepTest`, `SleepPressureTest`, `SettingsPerformanceTest`. Under memory pressure, if every background page is protected, Chromium can free nothing. |
| S-112 | Which tab is selected after the selected one closes | The Space's most recently used tab (the switcher's history, X1), then the next row, then the one above; a Space emptied this way stays empty when you come back to it. Check against Arc before building. Seen in Nook (ADR 0021: rebuilt from this description, nothing copied). Small Built 2026-10-20 in patch 0075 (`docs/features/tabs.md` R33 to R38): the Space's most recently used tab, then the row below, then the one above; essentials only when the Space has none of its own; the same choice for Sleep Tab and ⌘W on a pin. Seven unit tests failing without the change, and `SidebarClickTest.ACloseShowsTheRowUsedBefore`. Not yet used by hand. 2026-10-22, patch 0083 (the owner: a close scrolled the Space to its top): the most recent row is shown only while at least half of it is in the sidebar's view; otherwise the row below, else the one above (R33, `SpaceWindowTest.ACloseShowsTheRowUsedLastOnlyWhileItIsInView`, `SidebarClickTest.ACloseKeepsTheListWhereItIs`). |
| S-113 | Make a split by dragging a tab onto the page | Asked for in GitHub issue 7 ("drag a tab onto the page"). Dragging a sidebar row, or a tab of the horizontal strip with vertical tabs off, over the page lights its left or right half in the Space's colour; a drop makes a split with the page that was on screen, the dropped page on that half and active, and the strip is not reordered by the same drag; no window tears off inside the window. Built 2026-10-20 (J10–J15), not yet tried on a real window. Seen in Nook (ADR 0021: rebuilt from this description, nothing copied). Medium Built 2026-10-20 in patch 0075 (GitHub issue 7, a user's request): a tab dropped on the page from the sidebar, the rail or the horizontal strip makes a split, the half under the pointer lit in the Space's colour, the dropped page active; no window tears off while the pointer is inside the window; essentials, Space pins, splits, groups and browser pages refused (`docs/features/splits.md` J10 to J15; `TabDropTest`, four new tests failing without the hook). Used by hand on Windows' beta 21 and on the Mac (2026-10-21): a row dragged from the rail opened the sidebar under the drag, and the sidebar's pane names kept the sides a split first gave them; both fixed in patch 0077 (splits J10, J11, sidebar Y11), the fixed drag not yet tried by hand. |
| S-115 | A picture of the page in the hover card | Hovering a tab, pinned ones above all, shows a recent picture of its page in the hover card, taken from the tab, with no model involved (ADR 0020 puts this at 1.0). Chromium's hover-card preview images are the start. Medium Built 2026-10-20 in patch 0075 (`docs/features/pins.md` H19 to H23, `docs/PRIVACY.md`): page pictures in the hover card on the Mac too, held in memory only, about 160 KB each on a 2x screen (measured in `HoverCardPictureTest.WhatThePicturesCost`); a row reads its tab's sleep at once and an open card follows its row. Used by hand on the Mac and on Windows' beta 21: with expand-on-hover on, a row of the rail showed no card; fixed in patch 0077 (`docs/features/pins.md` H19, sidebar Y11). |
| S-214 | A label paints on a layer that is not opaque (Windows checks build) | Found 2026-10-16 on `win-checks`: `TabDropTest.ChipDropsMoveLightAndSurviveARebuild` stops on `DCHECK failed: view->layer()->fills_bounds_opaquely()` in `views::Label::PaintText` every run, and `FolderTabsTest.UndoOfAFoldersLastTabStaysOutOfAGroup` sometimes (one run in four alone), at patch 0067 already. A label with subpixel text on a translucent layer (the drag chip, the undo toast are the suspects) draws its text wrong in a release build; the fix is to switch subpixel rendering off for it or give it an opaque background. Both still stop on it at the 156 pin (2026-10-17). Fixed 2026-10-18: the label was not the chip's or the toast's but a tab group's header title, drawn as a row with no fill since patch 0066, and it and the Clear line's word no longer draw subpixel text on a layer that is not opaque (`FolderTabsTest.EveryLabelInTheSidebarSuitsItsGround`; `docs/features/folders.md` F36, `spaces.md` B17, HANDOFF trap 92); the confirmation on the Windows checks build, and the by-hand check on a real build, are still owed. Done 2026-10-20: the PC's checks build of this round's series passed every browser test (`FolderTabsTest.EveryLabelInTheSidebarSuitsItsGround` among them, no DCHECK); by hand on the installed beta 20 (ClearType, 150%), the group header's title and "1 tab" (folders F36) and the Clear word at rest and hovered (spaces B17), light and dark, draw grayscale text: the colour channels part by 0.02 or less at letter edges, where the page's own subpixel text parts by 0.61. |
| S-144 | Badges hide, and one list for ⌘1–9 | ⌘-held row numbers are not hidden when the window stops painting as active, and badges can stick after the window deactivates. ⌘9 and the row badges do not yet come from one list. ⌘9 selecting the last row is shipped (`S-82`). A split still taking two numbers is `S-102`, the split half of TAB-30. Chip numbers follow each Space's place, and a dot stays a dot, since patch 0063 (`S-70`); no test records Focus on Space 3 showing that Space's number, or overflow dots staying dots through a ⌘ hold (SPC-41). Root causes traced, with the fix and the test each needs, by the code review of 2026-10-15 (`docs/history/archive.md#the-code-review-of-2026-10-15`). Waits on code, and on a test for the chips. Fixed 2026-10-18: the badges hide when the window stops being active (TAB-30), ⌘1–9 take the badges' list, with the focused-group rule (CMD-25), the badges follow the Animate preference, and SPC-41 has its test (`NumberBadgeTest.TheNumbersAreTheKeysAndLeaveWithTheWindow`; `docs/features/tabs.md` R10, R11); the split's two numbers stay `S-102`'s, and the by-hand check on a real build is still owed. Medium 2026-10-20: by hand on the Mac's installed beta 20 the numbers leave with the window's focus, dots stay dots, ⌘9 takes the last row. New fault: with ⌘ held the third Space chip showed "…" where "⌃3" belongs (three Spaces, and the single chip under Focus on Space 3). Fixed 2026-10-20 (patch 0072): a chip showing its chord was a fixed 24 DIP, and most chords need 25 in the Mac's system font, so ⌃3, ⌃4, ⌃6, ⌃8 and ⌃9 drew as "…"; a chip showing a chord is now as wide as its text, the extra taken from its own gap so the row does not move, and the rail as wide as its widest chip (`NumberBadgeTest.EveryChordShowsWhole`, nine Spaces at every density, open and in the rail: 60 failures without the fix). |
| S-143 | Slept-row paint | A slept favicon's dim is still borrowed from TabIcon's layer and is lost on hover and theme change. A hover still rebuilds the folder glyph and creates badge layers for rows that never show a badge. Waits on code. Fixed 2026-10-18: a sleeping row's favicon dims itself in its own paint and stays dimmed through a hover, a new name and a theme change, a hover no longer draws the folder's glyph again, every folder above a row hears its sleep, and a badge's layer is made when the badge first shows (`SidebarRailTest.ASleepingRowsFaviconStaysDimmed`, `FolderTabsTest.AHoverDrawsNothingOfTheFolder`; `docs/features/tabs.md` R4, R7); the by-hand check on a real build is still owed. Small 2026-10-20: by hand on the Mac's installed beta 20 the dimming held through a hover, a rename, a Space colour change and the rail. New fault: a row inside a nested folder put to sleep from the command bar while on screen kept the active row's fill and its close button until clicked (a row outside a folder slept cleanly). Fixed 2026-10-20 (patch 0072): not sleep but hover. A row moved into a new folder from its menu, the pointer resting where the menu had been, was asked for the pointer as it was added back, against its old place in a folder not laid out yet; it took a hover the window never ended, which the active fill had hidden until the row slept. A row (and a split) added back to the window stays unhovered until the pointer next enters it (`FolderTabsTest.ARowMovedFromUnderThePointerRests`, failing all three checks without the fix). |
| S-222 | Deleting a Space that another window was showing stopped the browser | Found 2026-10-18 by `SpaceJarTest.DeletingASpaceMidRequestWipesItsJarOnce`: a window showing a Space that another window deleted moved the deleted Space's tabs before it named the Space it shows next, and a moved tab's observer asked for the active Space, which was gone; `SpaceModel::active_space()`'s `CHECK` stopped the browser, release builds too, so the betas shipped with it. Fixed 2026-10-18 in `SpaceModel::SyncWithRegistry`: the window names the Space it shows next, then moves the tabs (`SpaceSwitchTest.AnotherWindowsSpacesReachTheTitleRowAndTheTint` now holds a tab of the deleted Space on screen in the window showing it; `docs/features/spaces.md` B5); the by-hand check on a real build, and the PC's run, are still owed. Small Done 2026-10-20: by hand on the Mac's installed beta 20, Work deleted from a second window: the first window moved to Play with its tab, nothing stopped; the PC's runs of the series passed `SpaceSwitchTest.AnotherWindowsSpacesReachTheTitleRowAndTheTint` on the release, checks and ASan builds. |
| S-139 | Move to Space on a folder tab | A folder shows only in the Spaces of its tabs (F20). Write the Move to Space rule for a folder tab, and show that ⌘1–9 and Ctrl-Tab skip hidden rows and that a folder drop skips another Space's folder. A tab that is inside a folder, dropped on a chip, has no test; the chip under a drag already lights (B12, patch 0063). Waits on a decision, then code and a test. Fixed 2026-10-18 as the owner chose: Move to Space (the tab menu, the Space keys, the command bar, the switcher's menu, a drop on a chip) takes a tab, a split whole, out of every folder it is in, to just after the outermost folder, which keeps its other tabs and stays in its Space, and a new tab that lands in a folder holding another Space's tabs leaves it a turn later (`docs/features/folders.md` F37; `FolderCommandsTest.MoveToSpaceTakesATabOutOfItsFolder`, `TabDropTest.ADropPassesAnotherSpacesFolder`, `SpaceSwitchTest.NumbersAndCtrlTabReachOnlyRowsOnScreen`); the by-hand check on a real build is still owed. Medium Done 2026-10-20: by hand on the Mac's installed beta 20, a tab leaves its folder for another Space by the key, the command bar and a chip drop, and an emptied folder goes (the tab menu's route not driven). |
| S-223 | A one-pixel line under the address row in macOS full screen | Found 2026-10-18 by the owner: in full screen a one-pixel line ran under the address row across the whole window, over the sidebar, the page and the card's gutter. It was macOS 26's title-bar scroll pocket (`NSScrollPocket`), whose hard edge draws a separator: the window's separator style, a transparent title bar and the accessory's soft scroll edge (`preferredScrollEdgeEffectStyle`) do not turn it off, only the pocket's private `allowsSeparator` does. Fixed 2026-10-18: `immersive_mode_controller_cocoa.mm` sets it off whenever the title bar may lay out, guarded, so a macOS without the pocket is untouched (`WindowButtonsTest.FullScreenTitleBarDrawsNoDivider`, red before the fix; `docs/features/toolbar.md` T32); the by-hand check on a real build is still owed. Small Done 2026-10-20: by hand on the Mac's installed beta 20 in full screen: the only line is the address row's own hairline over the page, none over the sidebar or the gutter. |
| S-224 | The Clear line under the traffic lights in full screen | Found 2026-10-18 by the owner ("not always, maybe in full screen"): with View > Always Show Toolbar in Full Screen off, the sidebar gave up its own top row, as it does when the row is always shown, so its first rows, the Clear line among them, lay where the traffic lights slide in with the row. Fixed 2026-10-18: in that mode the strip keeps the window's top row, an empty box for the lights, then the toggle (`WindowButtonsTest.FullScreenWithTheRowSlidingInKeepsTheLightsBox`, red before the fix; `docs/features/sidebar.md` Y17). The empty box at rest, beside the toggle, was chosen in the round and is reported to the owner; the by-hand check on a real build is still owed. Small Done 2026-10-20: by hand on the Mac's installed beta 20 in full screen: the sidebar keeps its top row with room for the window buttons, which land in it and not on the Clear line as the row slides in. The owner's to judge: the slid-in band also covers the toggle and the Space title row. |
| S-229 | A restored tab's row lost its title after a relaunch | Found 2026-10-18 re-reading the acceptance captures: after the fixture's quit and relaunch, Page D's row read "d.html", its file name, where it had read "Page D" before the quit; Page C, never activated either, kept its title. The three dev-build runs of the same day show it too, so their step 1 was a miss. Medium Fixed 2026-10-19 (patch 0072): the session never held a page's title, because a title change alone was never written; it is now, rate limited (`docs/features/tabs.md` R31, `RestoredTitleTest`, passing on the Mac and the PC). Left: the acceptance script's step 1 on a build with the fix. Done 2026-10-20: the acceptance script's step 1 (and every other step) passes on the installed beta 20, on the Mac and on Windows; Page D keeps its title after the relaunch. |
| S-232 | In the rail, a tab dropped on a folder's glyph lands after the folder | Found 2026-10-18 by the installed-build runs: a real drag of Page A onto the folder's glyph in the rail (expand-on-hover off) left Page A as a row after the folder, on Windows (read back from the open sidebar's indent) and, by its capture, on the Mac; the browser tests that drop through the root view pass. The open sidebar's drop onto the header works on both. Medium Fixed 2026-10-19 (patch 0072): the drag's reorder passed a folder over, so a row from above jumped past it and the drop landed after it; a folder is now a reorder target, and dragging a row out of a folder no longer crashes (`TabDropTest`, now driven as a pointer drags, passing on the Mac). Left: the real drag on installed builds. Done 2026-10-20: the real rail drag onto a folder's glyph joins the folder on the installed beta 20, on the Mac (TST-7 step 6, read in the open sidebar) and on Windows (TST-7 step 3). |
| S-149 | Rename in the title row and on the rail | Blur ends a rename. A rename from the title-row menu, and one started on the rail, are not checked. Waits on a run. Done 2026-10-18: Rename Space from the title row's menu edits in the title row, and on the rail opens a small Rename Space dialog; both had used the switcher's own field, at the sidebar's foot and one chip wide in the rail. A rename left open when the sidebar collapses now ends there, keeping what was typed: its field had stayed open, squeezed into the rail's chip column, which the owner saw on the screen during a test run (red before the fix). A row too narrow to type in, as one is mid-collapse, asks in the dialog too (`docs/features/spaces.md` B16; `SidebarClickTest.ASpaceIsRenamedWhereItWasAsked`). The renames seen on the Mac's release build on 2026-10-18, where a rename left open as the sidebar collapsed was found squeezed into the rail and fixed. The PC's run on 2026-10-18 passed (`win-release`, `win-checks` and `win-asan`, `S-227` aside). Small Done 2026-10-20: by hand on the Mac's installed beta 20: rename in the title row; collapsing mid-rename keeps the name; in the rail a dialog from the Space icon and from a chip; a chip's rename edits in the switcher row. |
| S-250 | The Mac's checks build: a tab row's dangling pointer, and two slow tests | Found on 2026-10-19 by `tooling/dev test all` on `out/mac-checks` after beta 20 was published: unit 964 and components 56 clean, and 358 of 361 browser tests, each of the three intermittent (passing alone, the downloads test one run in two). (1) `SpaceJarTest.TheFirstRequestCarriesTheSpacesJar` stopped on a dangling `raw_ptr`: a `TabView` still being animated out held `tabs::TabDataObserver::tab_interface_` after `TabStripModel::CloseTabs` freed the tab, released in `TabCollectionAnimatingLayoutManager::RemoveNonAnimatingPendingDeleteViews`; upstream nulls it only when the observer saw the tab's `kDelete` detach, so the view was probably made, or its observer moved, after that notification (a row rebuilt during the close). `SteddingDownloadsTest.HorizontalTabsUseTheToolbarButton` reported the same kind of pointer at its tab-strip switch. The pointer is not read after the free, so release builds are unaffected; find where the row is made and null it there. (2) The downloads test's toolbar button was not drawn yet once in two runs on the slow build (`IsDrawn()` false after `SettleToolbar`). (3) `IsolationMarkTest.ABlankWindowAndAPrivateWindowMarkNothing` overran the 30 seconds `TaskEnvironment` allows for shutdown, with no task running. The PC's `win-checks` and ASan runs of the same tree were clean. Done 2026-10-20 (patch 0071): (1) upstream's `TabStripModel::CloseWebContentses` asked twice whether a closing tab needs its unload handlers and told the tab of its deletion only on matching answers; the answer flips 500 ms after beforeunload (`BeforeUnloadTimedOut`), and a tab missed was never told, so the row's `TabDataObserver` kept its pointer. Each closed tab is now told once (`TabStripModelTest.AClosedTabIsToldOfItsDetachOnce`, failing both ways without the fix; the space-jar test hit the pointer in 9 of 26 runs before, 13 of 13 clean after). (2) The toolbar's download button: the row is 26 DIP and the pinned buttons 28, so a container measured mid-slide never fitted and hid for good; the pinned-actions and extensions containers are measured by the row's width alone (`SteddingDownloadsTest.TheToolbarButtonAppearsWhenLaidOutPartWay`, failing 3 of 3 without the fix; under full CPU load 119 of 120 after, the miss a launcher timeout, where about one run in ten failed before). (3) did not reproduce in 15 runs. Left for the owner: whether the toolbar buttons should be 26 DIP to match the row (`docs/PRODUCT.md#ui-spec` says 28). |
| S-236 | Chrome's launched defaults that Stedding lacks | Chrome turns these on for every Stable user by server-side field trial, which Stedding never receives, so each is off in Stedding's code: random local TCP ports on the Mac (`TcpPortRandomizationMac`, with upstream fix 53bae91e8d3c), the Rust parser for structured HTTP headers (`StructuredHeadersInRust`), unload handlers no longer run (`DeprecateUnload` and `DeprecateUnloadByBucket` together, with upstream 47a2b074, so Stedding's own pages keep theirs), the Mac's Aperitif helper processes (`AperitifHelpers`: the helpers are already in the signed app; check every kind of child process starts on a signed, notarized build, and that per-app firewall rules do not ask again unexpectedly), buffered PDF painting (`PdfBufferedPaintManager`), the HTTP/3 session cache kept under memory pressure (`IgnoreQuicCryptoConfigMemoryPressure`), `CheckAutoCommitInCommitAndRollback`, `PaymentRequestRejectTooSmallWindows` (check it against the little window on a small screen) and `TabSearchCjkWordBoundary`; and static key pins for Google's own sites, a one-line branding check in `net/http/transport_security_state.cc` (the pin list is already on disk, and the check sends no reports). One patch flips the defaults, with a test per default and the network suites run with them on. Medium Done 2026-10-20 in patch 0074: StructuredHeadersInRust, DeprecateUnload and DeprecateUnloadByBucket (Stedding's chrome:// pages keep their unload handlers; upstream 47a2b074 is these flips and their test expectations), AperitifHelpers (every helper kind starts from the app bundle; check on the next signed build that per-app firewall rules ask again only once), PdfBufferedPaintManager, IgnoreQuicCryptoConfigMemoryPressure, CheckAutoCommitInCommitAndRollback, PaymentRequestRejectTooSmallWindows (a little window shrunk to its 400 by 300 floor refuses a payment request, at its usual size it holds the dialog) and TabSearchCjkWordBoundary on, and Google's static key pins off iOS; TcpPortRandomizationMac left off, its fix 53bae91e8d3c not in this pin (the next pin move). Tests: `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay`, `CertificateChecksTest.UnloggedAndUnpinnedCertificatesAreRefused`; Chromium's suites for the code: net_unittests 33,884 with three environment failures (no Python, two socket-path binds), sql_unittests 545, components_unittests 1,641 for CT and payments. |
| S-237 | Certificate Transparency enforcement | Chrome refuses a public authority's certificate that was never logged, and stops trusting some authorities after dated limits; Stedding does neither, because the switch is on only in Google-branded builds (`chrome/browser/browser_features.cc`), and 30 of the 47 dated limits in the root store had passed by 2026-10-18, so Stedding accepts certificates Chrome refuses. The log list already arrives with the certificate updates and the check sends nothing; the same switch also turns on Chrome's sampled certificate reports to Google, which must stay off. Chromium asks other browsers to tell its log team before enforcing, and worries about browsers without fast updates. Owner decision; recommended yes. Medium Done 2026-10-20 in patch 0074, on the owner's choice of the recommended scope: enforced (`kCertificateTransparencyAskBeforeEnabling` on), the audit reports off in code (`SCTReportingService::GetReportingMode` always disabled), a list over seventy days old enforcing nothing (`CertificateChecksTest.UnloggedAndUnpinnedCertificatesAreRefused`, `CertificateReportsTest.NoCertificateIsReported`, each failing with Chromium's code put back). Left for the owner: tell Chromium's CT log team that Stedding enforces, as its policy asks of other browsers (ct-policy@chromium.org). |
| S-240 | Read Chrome's field trials at every pin move | Stedding gets Chromium's code defaults only, so a feature Chrome launches by field trial reaches it only when upstream changes the default, and a broken one Chrome turns off stays on: that is how `S-236` was missed. Make it a standing step of each pin move: read the then-current Stable field-trial configuration at the pin's version and compare it with the code defaults, as a script in `tooling/`. Small Done 2026-10-19: `tooling/field-trials` reads the seed Chrome Stable downloads at the pin's milestone (mac and win, no sign-in, no identifier) and lists the features whose state there differs from the checkout's code defaults; `--seed` works offline. On the live seed of 2026-10-19: 272 features differ, 50 of them at 100% on a platform, every one `S-236` names among them. A standing step of every pin move (`docs/AGENT-LOOP.md`). |
| S-71 | Uninstall leaves the PDF handler's ProgId in the registry | Found 2026-09-30 on the beta 9 installer: `setup.exe --uninstall --force-uninstall` removes the program, the uninstall entry, `HKCU\Software\Stedding` and the Start menu shortcut and keeps the profile, and leaves `HKCU\Software\Classes\SteddingPDF.<hash>`. Harmless, and it may be what a vanilla Chromium leaves too: compare with an uninstall of a vanilla build before touching the installer The code review of 2026-10-15 traced it: uninstall removes the `.pdf` `OpenWithProgids` value but never the ProgId key (`DeleteSoftwareClassesSubkey` with `GetPDFProgId`), and a vanilla Chromium leaves its `ChromiumPDF.<hash>` key the same way (`docs/history/archive.md#the-code-review-of-2026-10-15`). A fix was drafted on 2026-10-18, the uninstaller deleting that key too (an upstream TODO) with a check in `tooling/win/test-installer.ps1`, meant to ship with `S-72`'s installer round; beta 19 went without it, and it waits. Fixed 2026-10-19 in patch 0073: the uninstaller deletes the ProgId key as well (`chrome/installer/setup/uninstall.cc`, upstream's TODO); live on the PC: this round's build installed over beta 20 and uninstalled keeping the profile left no `Stedding*` key under `HKCU\Software\Classes` (`docs/features/windows.md` N6). Ships in the next release. |
| S-249 | The Windows updater: what the review before beta 20 left | The review of patch 0073 on 2026-10-19 fixed two checks at once, the missing timeouts, the UI-thread folder, the unchecked file name, the quit held by an install, the installer left in the temporary folder, and the product's version reaching Safe Browsing, GCM, sync, OAuth, image search, DIAL, the Web Store and the root store's rules. Left, none of them a way to run an installer the key did not sign: (1) a replayed older feed can hold back updates, since the feed carries no signed date and the updater keeps no newest-seen one (sign a date, keep the newest, say so in About when stale); (2) the release key also signs test feeds and development installers, and release builds accept `--stedding-update-feed` and plain http to this computer, so a signed test feed stays a valid one (a test key, or local http only with the switch); (3) a check that fails offline counts as the day's check, as Sparkle's does, so a copy offline at launch waits a day (retry after an hour); (4) turning automatic updates off during a download still installs it; (5) a failed install deletes its own log with the installer, the evidence `S-247` needs, and a failed or cancelled download leaves its folder; (6) the installer is verified and then opened again by path, by a process of the same user only (open it once, deny writes, verify and launch on that handle). Done 2026-10-19 in patch 0073: (1) a signed feed older than one already read is refused; (2) plain http to this computer only from a test feed (a separate test key not made); (3) an offline check retries within the hour; (4) automatic updates turned off during a download install nothing; (5) a failed install's log is kept and stale download folders are cleared; (6) the installer is checked and run on one handle that denies writes. Unit tests on the PC: `WinAppUpdaterTest.*` 13 of 13 (with `UpdateFeed*` and `SteddingPrefsTest.*`, 20 of 20). Ships in the next release. |
| S-212 | A tab pinned while selected may come back unselected after a restart | Found 2026-10-15 writing `RestoreTest.ACrashRestoreKeepsEachWindowsSpaces`: an essential pinned while it was the selected tab moved to the front, and the session kept the selected index it had before the move (only a change of selected tab is written), so the restore selected the tab that had moved into that index. The test selects the pin again to get past it. Not yet seen by hand on a real restart, nor traced to whether Chromium's own pin has it. Fixed 2026-10-18 in Chromium's own session code, where a move never wrote the selected tab, so Chromium's pin had it too (`RestoreSelectionTest.ATabPinnedWhileSelectedComesBackSelected`, and `RestoreTest.ACrashRestoreKeepsEachWindowsSpaces` without the extra selection; `docs/features/pins.md` H18); checked by hand on the Mac's release build the same day (⌘D on the selected third tab, quit, relaunch: the pin came back selected); the Windows checks build passed its browser suite the same day. Low Shipped in beta 20 on both platforms. |
| S-213 | The welcome flow's test hook is missing in the Windows checks build | Found 2026-10-16 running the browser suite on `win-checks` (DCHECKs and the dangling-pointer detector) at patch 0067 and again with 0068: `WelcomeFlowTest.EachBehaviourChoiceIsWrittenAtOnce` fails and `WelcomeFlowTest.TheBookmarksFileRowAsksForAFile` stops on a `CHECK` because the page says "ReferenceError: steddingWelcomeTest is not defined" (`chrome/browser/resources/stedding_welcome/app.ts` sets it at the end of the module, so something before it throws in that build). Both pass on `win-release`. Find what throws; it may be a fault a user would meet. Both passed on `win-checks` at the 156 pin (2026-10-17, one run). Fixed 2026-10-18 on the cause found that day, not a fault of the page: off the Mac `stedding_browser_tests` did not depend on `//chrome:packed_resources`, so a checks build of the test targets alone served the welcome page of the last `chrome` built in that directory, without its hook, and a `data_deps` line now repacks it, while the welcome tests fail at once on a page without the hook (`WelcomeFlowTest.*`; `docs/HANDOFF.md`, "The Windows build"); it did not reproduce at the 156 pin (the four welcome tests passed three runs in three on `win-checks`, 2026-10-18), and the run of the fixed tests on the PC's checks build is still owed. Closed 2026-10-19: the PC's `win-checks` run of beta 20 passed every browser test, `WelcomeFlowTest.*` among them. |
| S-66 | Crashes: triage from macOS's crash reports | The owner reports that the browser "crashes all the time" (round 10, row 3). Explained and fixed since, on real builds: beta 8's full-screen abort (round 10, row 2; toolbar T24), a folder row read after it was freed when a window closed (`docs/history/plan-2026-09-26.md` TAB-8, patch 0057), and restored imported tabs killed for "bad IPC message, reason 332" (import I26, patch 0058); the audit found more by reading the code (`docs/history/plan-2026-09-26.md` section 1, item 3). Not done: the macOS crash reports themselves, gathered and tied to items. Gather what actually crashed: the reports macOS keeps in `~/Library/Logs/DiagnosticReports` (`Stedding-*.ips`, and the helpers' own), plus whatever Crashpad kept in the data folder's `Crashpad` directory. Symbolise each against the build that crashed, group them by signature, and tie every group to an item in `docs/history/plan-2026-09-26.md` or a new id. Closed when every report since beta 8 is tied to an item and those items are fixed on a real build. Partly done 2026-10-18 on the Mac, which holds no report of Stedding's browser process (macOS had deleted every report from before 2026-10-10, and the data folder's `Crashpad` held none): the reports there are test artefacts or already fixed (a test binary's dangling pointer in the tab layout, fixed in patch 0062; a helper stopped after a test deleted its profile under a browser that Chromium's chooser kept from quitting, `S-134`; the shutdown watchdog's dumps from a dev build, HANDOFF trap 85), plus one new low item, helpers of beta 16 aborting during the update tests as Sparkle moves the old app away under them, and one class of cause is addressed, soft checks, which no longer crash a build without DCHECKs (ADR 0024); the PC's reports and the owner's machine are still to read. Read in full 2026-10-18: on the Mac, Chromium's own `Crashpad/pending` (where every build wrote before patch 0050, trap 85) holds 24 dumps of Stedding's browser process; each one from an installed build ties to an item, the beta 8 full-screen abort (toolbar T24, fixed in beta 9) or the second search-engine pick (`S-134`, fixed in patch 0070 and not in a release yet), and the rest come from dev builds that no longer exist. On the PC there is no report of the installed browser at all: no Crashpad report under the installed profile or the legacy Chromium folder, no Windows Error Reporting entry or event-log error for `chrome.exe`, `setup.exe` or `mini_installer.exe`; only test binaries' crashes from earlier rounds. Closes when a release carries `S-134`'s fix. Closed 2026-10-19: beta 20 carries `S-134`'s fix on both platforms, the last item the reports tied to. |
| S-134 | Skipping the engine step brings Chromium's chooser, with a globe for every engine | Found 2026-10-11 on the Windows release build of patch 0060: skipping the welcome flow's engine step leaves no engine chosen, and Chromium's own "Choose your search engine" dialog then opens over the window on the first page, with a globe for every engine. The welcome flow's own marks (`S-77`) are drawn only in the welcome flow. For the owner: whether a skipped step should still bring Chromium's chooser. Fixed 2026-10-18 as the owner chose: skipping the engine step, or finishing without a pick, records Stedding's default, DuckDuckGo, as the choice, so Chromium's dialog no longer opens, and a second pick in the flow no longer reaches Chromium's choice check, which would have stopped the browser in Stedding's builds, none of them official (`WelcomeChooserTest.*`, `WelcomeEnginesTest.ASecondPickChangesTheEngine`; `docs/features/welcome.md` W2); checked by hand on the Mac's release build the same day (Skip on a fresh profile, then two pages loaded: no dialog; Bing, then another engine: the second pick held and the browser ran on). Shipped in beta 18 on Windows and beta 20 on the Mac. |
| S-79 | Arc, while it runs, takes ⌥⌘N | Found 2026-10-02 on the Mac: with Arc open, ⌥⌘N in Stedding (split the current tab with a new one) opens a Little Arc window and brings Arc to the front instead, because Arc registers ⌥⌘N as a shortcut that works from any app (Arc's help centre, "Little Arc"). People moving from Arc keep it running at first. The FAQ, the shortcut list and Settings' own shortcut reference say so (shortcuts Z3, patch 0058). Open: whether the split takes another default chord, or the welcome flow says it when it finds Arc running (it already detects that, W8). Fixed 2026-10-18 as the owner chose: on the Mac the split is ⌃⌘N, which the menu and every list show, and Chromium's ⌥⌘N still splits while Arc does not hold it, Windows keeping Alt+Shift+N (`ShortcutReferenceTest.ArcsSplitKeyNoteIsPresent`; `docs/features/shortcuts.md` Z3, `welcome.md` W6); checked by hand on the Mac's release build the same day, Arc running (⌃⌘N opened a split with a new pane). Shipped to the Mac in beta 20 (2026-10-19). |
| S-55 | Network service restarted at startup | The same launch logged `Network service crashed or was terminated, restarting service` at startup, once, on a fresh profile. A component build on Windows; not seen on the Mac. Find whether it is the build or the series before M8. Read 2026-10-18, not yet reproduced on the PC: most likely an artefact of that build, made before the build configurations set `disable_fieldtrial_testing_config`, whose field-trial testing config turns on the network service's sandbox on Windows, which cannot start from an output directory without the installer's permissions, so Chromium logs this line once and starts the service without the sandbox; nothing in the series starts or restarts the network service. Closed 2026-10-18 on the PC: three launches on fresh profiles, the `win-release` output folder, the same with `--enable-features=NetworkServiceSandbox`, and the installed build with it, each logged no restart and wrote no failed launch to Local State; the line came from the September build configuration, not the series. The side finding is `S-234`. |
| S-138 | The Clear line when nothing is pinned | Clear keeps folders, and ⇧⌘K keeps the window, in a normal window and a private one. The Clear line shows only between a pinned run and the other tabs, so a window with no pins, a private window included, has none. The owner decides whether it should show there. Fixed 2026-10-18 as the owner chose, the line showing whenever rows follow it, with or without pins, private windows included (`ClearSpaceTest.TheClearLineShowsWithNoPins`, `TabRowRulesTest.*`; `docs/features/spaces.md` B17); checked by hand on the Mac's release build the same day (a Space with no pins shows the line and Clear over its rows). Small Shipped in beta 20 on both platforms. |
| S-219 | The sidebar slid out again after a collapse with the toggle (Mac) | Seen 2026-10-16 in driven runs of beta 16 and the 156 build alike: after a click on the open sidebar's toggle, with the pointer left on it (outside the rail once collapsed), a capture two seconds after the click showed the sidebar drawn open over the page in two runs of four, once in each build; every other capture showed the rail: at one and four seconds in a run of each build, and every half second from 1.5 to 6 seconds in a run of the 156 build. Two seconds is the rail's hover pause, so a hover begun while the strip shrank under a still pointer may survive the collapse. Not yet seen by hand. Fixed 2026-10-18: the region view asks the hover again when its width changes during the pause, since a collapse read the hover against the last frame's wider bounds (`SidebarRailPointerTest.AClickOnTheToggleLeavesTheRailClosed`, the Mac; `docs/features/sidebar.md` Y11); checked by hand on the Mac's release build the same day (four driven runs, the pointer left on the toggle, captures at 2, 2.5 and 3 s: the rail every time, where two runs in four had slid out); the Windows checks build passed its browser suite the same day. Low Shipped to the Mac in beta 20. |
| S-221 | `SidebarFormsRtlTest.TheRightHandEdge` is flaky on the Windows release build | Seen 2026-10-18 on `win-release` after the defect round: it failed in the full browser suite and one run in three alone (the hidden right-hand sidebar either never slid in on the played pointer or never slid away after the exit; a `RunUntil` timed out), and passed on `win-checks` and on the Mac. Still flaky with the round's one hover change (`S-219`) kept to the Mac, so not that; whether it failed before the round is not known (the round's test binary is the only one built). Find the wait it loses; window activation on the remote-desktop session is a suspect, since the hover-expand does nothing while the window does not paint as active. Low 2026-10-19 (patch 0072): a test stand-in for the hover holds the reveal while the pointer is played; the test passed in the PC's release run of 2026-10-19 (one run: watch it). Closed 2026-10-19: it passed in all three of the PC's runs of beta 20 (release, checks, ASan); reopen if it fails again. |
| S-226 | A private window's row never takes the page's colour on the PC's ASan build | Found 2026-10-18 by the ASan run (`S-106`): `PrivateCoatTest.OnlyAnIncognitoWindowIsGraphiteAndItsRowTakesThePage` waits for the private window's row to take a page's colour, and it never came, twice, the second time with five-minute waits; no sanitizer report. It passed on `win-release`, `win-checks` and the Mac. Fixed 2026-10-18 with the cause found on the same PC: a read of the page's top edge before the page has painted comes back transparent, and the sampler made every pixel opaque, so it read black, which the row then showed (on every reload too, `PageColourRowTest.TheAddressAndTheRowFollowThePage` on `win-release`); a strip read back mostly transparent is now no colour (`PageTopColorTest.UniformEdge`, its "not painted yet" case; `docs/features/toolbar.md` T21). The private window's test passed on the ASan build once the fix was in. Closed 2026-10-19: the PC's ASan run of beta 20, 341 of 341 browser tests, passed it again. |
| S-227 | The infobar container keeps its height after its last bar is removed (Windows, sometimes) | Found 2026-10-18 on the PC: `SidebarFormsTest.FullScreenIsEdgeToEdge` removes the session-restore bar without animation and waits for the container to go, and on Windows it stays 56 DIP tall with no bar in it in most runs (ten of thirteen on 2026-10-18, on `win-release`, `win-checks` and `win-asan`), before and after the round's last product change (checked by building without it); on the Mac it passes. A container left that tall would be an empty band over the page. Find whether the bar's removal leaves a view or a height behind on Windows, or the test removes it while its show animation runs. Low Fixed 2026-10-19 (patch 0072): an unanimated removal now tells the container's delegate, so the browser view lays out again (`components/infobars/core/infobar_container.cc`); `SidebarFormsTest.FullScreenIsEdgeToEdge` passed on the Mac and in the PC's release run of 2026-10-19. Closed 2026-10-19: the PC's release, checks and ASan runs of beta 20 passed `SidebarFormsTest.FullScreenIsEdgeToEdge` with the rest. |
| S-225 | A split whose contents were replaced came back apart after the crash bubble's Restore | Found 2026-10-18 by `RestoreTest.ReplacedContentsComeBackFromACrashRestore`: turning on a Space's own session gives each of its tabs new contents, and Chromium's session helper writes new contents as a new tab with no split and no tab group (`SessionServiceBrowserHelper`, the replace case; upstream does the same, where little replaces a tab's contents), so the split came back as two plain tabs. Fixed 2026-10-18: the replace writes the tab's split and group for the new contents (the same test, red before the fix; `docs/features/sessions.md` S12). Shipped in beta 20 on both platforms. |
| S-248 | The Windows acceptance runner's later parts started with no page visible | Tooling (2026-10-19): Windows' foreground lock. A probe of three launches, each in a PowerShell of its own like the runner's parts, showed the first window in front (the operator idle 53 seconds) and the next two behind the foreground app, launched a second after the script's own keys, until `Drive-Focus` ran, which the fixture called only after its minute's wait. The fixture now brings the window forward before it waits and again while it does, and `Drive-Focus`'s Alt nudge waits for the operator to be idle and is marked as the script's own, so the next key no longer waits six seconds for it. The three parts in one task on the installed beta 19: each first page on screen in five to six seconds, every step passed (`docs/features/acceptance.md`) |
| S-215 | The Windows updater | Patch 0073 (2026-10-19; ADR 0023, ADR 0026, `docs/features/updates.md` Up14 to Up22): the browser's own updater behind `stedding::AppUpdater`, reading `updates/appcast-windows.xml`, signed with a Windows key of its own (`tooling/win/update-key.ps1`, `tooling/win/publish-appcast.ps1`), checking the feed and the installer before either is used, running the installer hidden and offering the restart in the sidebar's pill; About and the Settings switch on Windows too. The n-1 check on the PC passed: a build of 156.2.0.18 found beta 19 on a local feed, installed it and restarted into it on a real click, the profile intact. Beta 19 is the first release with it, installed by hand once; what was not seen live is `S-247` |
| S-72 | A second Windows release on one Chromium pin installs as a repair, which needs Stedding closed | Patch 0073 (2026-10-19): each Windows build carries Stedding's own version, `<milestone>.<100 × major + minor>.<patch>.<beta n, 999 for a release>`, written into the checkout's `chrome/VERSION` by `tooling/win/build.ps1` (0.2.0-beta.19 on Chromium 156 is 156.2.0.19), so a release installs over the one before it as an upgrade, or beside a running copy as an in-use update; what the web and Google's services see keeps Chromium's version (`CHROMIUM_VERSION`, `version_info::GetChromiumVersionNumber()`; updates Up22, `ChromiumVersionTest.PagesAndServicesSeeChromiumsVersion`). Seen on the PC: a build of 156.2.0.18 installed over beta 18 as an upgrade, and beta 19 beside it while it ran |
| S-245 | Turning dark pages on stopped a checks build | Patch 0072 (2026-10-19): found by `win-checks` before beta 18, `PageThemeColorControllerTest.ALightThemeColourIsDarkenedUnderDarkPages` and a command bar test stopping on `DCHECK failed: GetForPage(page)`: the switch forgot each page's edge read, and a page never read has none, which `PageUserData::DeleteForPage` refuses. A release build skips the check and nobody saw it; it forgets a read only when there is one now |
| S-246 | The horizontal strip's spinner was measured against no colour | Patch 0072 (2026-10-19): found by `win-checks` before beta 18, `LocalTabsHorizontalTest.TheHorizontalStripDrawsNoMark` stopping in `TabIcon::PaintLoadingAnimation` (`BlendForMinContrast` asks for an opaque background). With vertical tabs off, the tab strip gave its icons Chromium's inactive tab colour as their ground, which the Stedding window makes transparent (tabs R23), so a loading tab's spinner and an attention dot were coloured against black. The strip's ground in the Stedding window is the frame's colour now |
| S-244 | A toast covers an infobar's text | Patch 0072 (2026-10-19): a toast of the whole window sits under the infobars while any is up, and under the address row when none is, following them as they come and go; a tab's toast sat there already (`docs/features/toolbar.md` T38, `AddressBandTest.AToastSitsUnderTheInfobars`). On the Mac the test failed until the review before beta 20: a toast whose anchor changed while it slid in stayed where the slide ended; it is placed again when the slide ends, and a window closing with a toast up no longer re-anchors it |
| S-242 | This round's features fail ten browser tests on Windows | Patch 0072 (2026-10-19), every one a test fault, none in the product: Windows draws a darkened page #121212 and captures it so. On Aura a browser test draws nothing unless its fixture asks (`EnablePixelOutput()`), so every pixel the dark-page, page-colour and capture tests read was transparent (HANDOFF trap 113); Windows labels Chromium's "Install page as app…" with its mnemonic, "&Install…"; the quiet install test let the test suite's pretend OAuth client allow browser sign-in, and Chromium's account check reached accounts.google.com, which no Stedding build can make (now `allow-browser-signin=false`, as `QuietStartTest`); the elision test's Space name fitted Segoe UI; `NumberBadgeTest` lost its keys to other tests' windows in the parallel leg (trap 115; it and three more run one at a time on Windows); `LocalRowLinesTest` failed only over SSH (trap 114), and real users keep the host line (`LocalTabsTest` passes in the browser's DPI-aware process). The S-230 unit test failed on both machines because its restarted mock client kept no address. PC release build: unit 939 of 939, browser 339 of 339 |
| S-228 | Escape cannot cancel a Ctrl+Tab run on Windows: Ctrl+Esc opens the Start menu | Decided 2026-10-19 (no system-wide keyboard hook; Windows keeps Ctrl+Esc; `docs/features/switcher.md` X3 and `docs/SHORTCUTS.md` give the way back) and confirmed the same day on the installed build of patch 0072: tst9-6 (Ctrl+Esc opens the Start menu, the run keeps the tab it reached, a tap goes back) and tst9-6b (Shift+Tab back to the first tab) pass |
| S-231 | A hidden address row leaves a one-pixel line on Windows | Patch 0072 (2026-10-19): the hidden row is laid out at no height on Windows; tst9-9 passes on the installed build of patch 0072 (2026-10-19), an infobar up |
| S-233 | The Windows acceptance runner stalls at its pin step | Tooling (2026-10-19): every DevTools call has a three-second limit and the Start menu is closed when it holds the foreground; `s173-live.ps1 -Part tst9` ran through on the installed build of patch 0072 in two minutes, the pin step included, no call timing out |
| S-243 | The essentials cards had a coloured edge | Patch 0072 (2026-10-19), the owner's word ("must be like Arc, it has no border"): a card is a frosted tile with no edge, white at 35% in light and 9% in dark, a split of essentials too (`docs/features/tabs.md` R32). The edge was Chromium's outline, whose Material colour took the Space's hue. `TabRowRulesTest.AnEssentialCardStandsOffEveryGround`, `EssentialCardTest.ACardIsAFrostedTileWithNoEdge`; seen on the PC's release build in light and dark |
| S-154 | Full screen, the two looks still missing | Patch 0071 (2026-10-18): a tab switch in full screen re-themes the row, and a hovered rail no longer moves the back button (`WindowButtonsTest.ATabSwitchInFullScreenFollowsThePage`, `WindowButtonsTest.HoveringTheRailInFullScreenLeavesTheRowAlone`); both seen on the Mac's release build the same day through `tooling/drive`'s new `screen` step, with the line under the row the owner reported gone (`S-223`; `docs/features/toolbar.md` T32) |
| S-47 | An input-free settings probe | Tooling (2026-10-18; `tooling/probes/settings.json`): `tooling/capture-state --page chrome://settings/stedding` opens the page through the browser's local DevTools endpoint (`tooling/devtools-page`, a port the browser picks), with no pointer or key, so it runs while someone is at the machine; the probes moved to the toggles the first screen shows since the section was regrouped (settings T13), and all six passed on a fresh capture of the dark page. `capture-ui` no longer takes `--settle`'s value for a URL |
| S-218 | Ctrl+Alt+→ did not change Space while the address bar had focus (Windows) | Not a product defect (2026-10-18; `docs/features/spaces.md` B19, `windows.md` N7): it was found on 2026-10-16 driving the 156 build and beta 16 on the PC, and `tooling/win/drive.ps1` sent arrow keys without the extended-key flag, which Windows reports as the numeric keypad's arrow, in a text field the key of an Alt code, so the address bar kept it and the window's accelerators never saw it. With the flag, Ctrl+Alt+→ and ← change Space from the address bar on the release build (driven on the PC, 2026-10-18). The driver is fixed (`Drive-Key`); HANDOFF trap 93 says why earlier driven results for chords of Alt and an arrow from a text field are suspect; a Windows step, "Ctrl+Alt+arrows from the address bar", is added to `SpaceSwitchTest.CommandsChordsAndTheLastTab`, not yet run, the Windows build of that round being still to come |
| S-74 | Automatic updates in the app, the Mac first | Patch 0068 (2026-10-16; ADR 0022, `docs/features/updates.md`): Sparkle 2.10.0 from a signed feed in `updates/appcast.xml`, on by default with a switch in Settings, "New Stedding Version Available" at the sidebar's foot, rows in About, the command bar and the app menu, and a thank-you page after the install and after each update. Beta 16 was the first release built with it, beta 17 (2026-10-18) the first offered through the feed: a copy of the released beta 16, pointed at a test profile, updated itself to it from the real feed (the pill in about 50 s, the release's image installed at the quit, the new version notarized and running). Windows and Linux go on as `S-215` and `S-216` (ADR 0023); the Mac App Store was declined on 2026-10-01 |
| S-217 | Take 156.0.8078.36 | Pin file (2026-10-16), from 155.0.8059.12, on the owner's "update chromium to latest stable": M156's newest stable-channel build that day (ADR 0007). The rebase needed hand merges in 27 of the 68 patches, then the port to M156's rebuilt sidebar region view (HANDOFF trap 92). The Mac and the PC built the same tree. Mac: 855 unit, 20 component, 132 browser and 115 rebase tests; PC: 842 unit, 124 browser and 114 rebase tests; all passed. On the PC's checks build the browser suite stopped only on `S-214`'s two older DCHECKs, after three sidebar labels were kept from drawing subpixel text on M156's content-area layer (HANDOFF trap 92). `verify-build` passed, full screen included; 13 window states captured beside beta 16's differ only in a throbber's frame and the shuffled engine list, and Stedding's Settings section, Settings, About and Archived pages, driven on both, match but for About's version and update check; a profile beta 16 made with Spaces, an essential and folders opens the same in both; driven with the real pointer and keyboard on both machines, where it behaved as beta 16 does (two older defects found, `S-218`, `S-219`); a fresh profile asked the network for nothing beta 16 does not ask for; the PC's installer upgraded an installed beta 16 in place; the released beta 16 updated itself to this build through Sparkle, its tab and profile kept. The same evening Google took M156's early stable to 0% on the Mac and Windows (`tooling/check-pin`: ahead of a pulled rollout); Chrome's stable serves 155.0.8059.85 |
| S-211 | The default favicon was Chromium's grey globe | Branding, no patch (2026-10-15): a page with no icon of its own shows Tabler's `world-www` globe, which the operator chose from ten candidates, in Chromium's two greys for light and dark, at 16, 32 and 64 px and twice that (`branding/README.md`; `tooling/brand/favicon.py` renders it, `tooling/apply-branding` puts it in place; Tabler Icons, MIT, its licence beside the source) |
| S-179 | A Space's sessionStorage was lost at every restart, and a crash restore dropped a Blank Window's Spaces | Patch 0067 (2026-10-15): the session keeps the namespace of the partition a tab's pages live in, and the restore recreates it in the partition the tab comes back to, as ⇧⌘T does with a closed tab; after a restore, the sessionStorage left over in each Space's jar a tab came back to is deleted, as Chromium does for the shared jar. The crash bubble's Restore never puts a Blank Window into the open window: it comes back as a window of its own with its own Spaces, the next window's tabs join instead, and that window shows the Space it showed, an essential selected too (`docs/features/sessions.md` S28, S29; `RestoreTest.ASpacesSessionStorageComesBack`, `RestoreTest.ACrashRestoreKeepsEachWindowsSpaces`, the step "back in Work's jar" of `RestoreTest.ReopeningBringsBackTheFolderTheSpaceAndTheWindow`) |
| S-180 | A Space's service workers and notifications acted in the wrong jar | Patch 0067 (2026-10-15): a site in a Space with an Independent session can show notifications at all, which Chromium's rule for app and guest partitions had blocked (found by the new test); the window a worker opens (`clients.openWindow`) is made in the worker's jar and filed in that jar's Space, whatever Space is on screen; a persistent notification's id names a Space's jar, and its click and its close are dispatched into that jar (`docs/features/sessions.md` S30; `SpaceWorkerTest.AWorkerActsInItsSpacesJar`) |
| S-181 | A restored tab's saved Space came back when it moved to another window | Patch 0067 (2026-10-15): the saved Space, pin and home are read once, by the window that files the tab first (`docs/features/spaces.md` B2; `SpaceWindowTest.ARestoredTabsTagGoesWithItsFirstFiling`) |
| S-182 | A Space-pinned split was laid out under the Clear line | Patch 0067 (2026-10-15): a split whose panes are Space-pinned is a row of the pinned run (`docs/features/pins.md` H14; `PinnedRunTest.APinnedSplitSitsAboveTheClearLine`) |
| S-183 | The Arc import's edge cases | Patch 0067 (2026-10-15): an Arc Space named twice is one Space, across imports too; the history read has its filter and its cap in the query, so it stops at the cap; at most 10,000 logins are read. A pin that follows a folder in Arc's pinned run comes before the folder, which is an ordinary folder under the Clear line until `S-107` (`docs/features/import.md` I3, I22, I23; `ArcSidebarImportWindowTest.ASpaceNamedTwiceIsOneSpace`, the cap in `ArcDataImporterTest.ReadsLoginsAndUnsealsPasswords`; the history read returns the rows it returned before, so no test tells the bound) |
| S-184 | The welcome flow's behaviour step redrew an old choice over a click | Patch 0067 (2026-10-15): the profile's values, when they answer late, never draw over a choice already clicked (`docs/features/welcome.md` W12; `WelcomeFlowTest.EachBehaviourChoiceIsWrittenAtOnce`, its step "a late answer keeps a choice already made") |
| S-185 | Sleep and the archive could lose work they did not see | Patch 0067 (2026-10-15): sleep and the archive keep a tab with a `contenteditable` or `designMode` edit or a PDF, and sleep keeps a tab DevTools is attached to, as the archive did; a new sleep setting re-times a timer already running. The archive sweep cannot close a window, since it never takes the tab on screen; closing a split takes nothing out of the archive page, which lists closed splits since `S-187` (`docs/features/tabs.md` R6, `archive.md` A12, `sessions.md` S21; `SleepInUseTest.LeavingASpaceAndSleepingOthersKeepWhatIsInUse`, `SpaceModelTest.ANewSleepDelayRetimesASpaceAlreadyLeft`) |
| S-186 | The welcome flow's "Bookmarks HTML File" import did nothing | Patch 0067 (2026-10-15): the row opens the file chooser on the welcome window; Chromium's import handler takes that window when its page is no tab, where it found no browser and would have crashed (`docs/features/welcome.md` W3; `WelcomeFlowTest.TheBookmarksFileRowAsksForAFile`) |
| S-187 | The archive page and the welcome swatch read the wrong things | Patch 0067 (2026-10-15): every tab Recently Closed holds is a row, a closed window's and a split's too, and Forget on such a row forgets its close whole and says so; the Space filter goes by the Space's id; the welcome swatch tints the first Space, not the active one (`docs/features/archive.md` A9, `welcome.md` W7; `ArchivePageTest.AClosedWindowsAndSplitsTabsAreRows`, `SteddingWelcomeHandlerTest.ASwatchTintsTheFirstSpaceNotTheActiveOne`) |
| S-188 | Stedding's WebUI handlers trusted the shape of the page's messages | Patch 0067 (2026-10-15): the archive, welcome, Spaces and shortcuts handlers return on a message with the wrong count or type, where a `CHECK` ended the browser (`SteddingWelcomeHandlerTest.AMessageOfTheWrongShapeIsDropped`, `SteddingArchiveHandlerTest.AMessageOfTheWrongShapeIsDropped`; the Spaces and shortcuts handlers' returns have no test of their own) |
| S-189 | Two Ctrl+Alt chords did nothing on an AltGr layout | Patch 0067 (2026-10-15): on Windows, a Ctrl+Alt chord of the window's made with Ctrl and the left Alt runs its command where the layout's AltGr gives the key a character; AltGr still types it, and the right Alt with a digit types too (`docs/features/windows.md` N13, N14, `docs/SHORTCUTS.md`; `AltGrChordsTest.*`, which plays the keyboard's state; not tried on a real Polish (Programmers) keyboard) |
| S-210 | An unnamed tab group showed a blank bar in the sidebar | Patch 0066 (2026-10-15; the operator's screenshot of a test window): a Chromium tab group's header is a row like a folder's, a dot in the group's colour and the title in the rows' text colour, an unnamed group's tab count muted for a title, no fill but the hover tint; it was a bar filled with the group's colour, blank when unnamed (`docs/features/folders.md` F36; `TabGroupHeaderViewTest.SteddingAnUnnamedGroupShowsItsTabCount`) |
| S-201 | A typed address in a fresh tab took another app's external-open mark | Patch 0066 (2026-10-15): only the tab a link from another app makes spends its mark; an address typed into a fresh tab within the mark's ten seconds had taken it, so the typed tab went to the default Space for links from other apps and the link's own tab stayed in the active Space (`docs/features/routing.md` D3; `SpaceWindowTest.ATypedAddressLeavesAnotherAppsMark`) |
| S-202 | A Chrome shortcut file opened from Finder got neither the little window nor the default Space | Patch 0066 (2026-10-15): a `.crwebloc` is read first, and its target opens as any link from another app: small while the setting is on and no route takes it, else as a tab in the Space chosen for such links; the file's own `file://` address had been the one checked and marked (`docs/features/routing.md` D3, `little.md` E1; Mac: `ShortcutFileTest.ItsTargetOpensAsALinkFromAnotherApp`). |
| S-203 | A host route missed an IPv6 host and an address on its scheme's default port | Patch 0066 (2026-10-15): a `host` pattern takes an IPv6 literal, bracketed or not, with a port after the brackets, and a port matches the scheme's default too (`docs/features/routing.md` D1; `SpaceRouterTest.AHostRuleTakesIPv6AndADefaultPort`) |
| S-204 | The welcome flow dropped keyboard focus when the focused button's label changed | Patch 0066 (2026-10-15): every control carries a key the redraw finds it by, and one the redraw disables hands the focus to the next control; the search, import and appearance groups are named for screen readers too (`docs/features/welcome.md` W12; `WelcomeFlowTest.EachBehaviourChoiceIsWrittenAtOnce`, its last step) |
| S-205 | Clear was out of reach of Tab and VoiceOver | Patch 0066 (2026-10-15): while its label is drawn, Clear is a focusable button named Clear, run by Enter, Space or a screen reader's press, with a focus ring round the word (`docs/features/spaces.md` B17; `ClearLineTest.ClearIsAButtonTheKeyboardReaches`) |
| S-206 | A deleted Space's jar could stay on disk after a quit | Patch 0066 (2026-10-15): the jar stays on the profile's pending list until its wipe has finished, and the profile's next window finishes what a quit cut short; a jar a Space names is never wiped from the list (`docs/features/sessions.md` S17; `SpaceWindowTest.ANewWindowFinishesAWipeLeftWaiting`) |
| S-207 | Undo of a folder's last tab could put it in a group that took its place | Patch 0066 (2026-10-15): a tab that was in no group comes back in none, so the folder rebuild makes its folder again (`docs/features/tabs.md` R27; `FolderTabsTest.UndoOfAFoldersLastTabStaysOutOfAGroup`) |
| S-208 | "Start a New Profile" after a failed profile move took Chromium's keychain key | Patch 0066 (2026-10-15): the empty profile makes a key of its own, as a fresh install does, unless another launch moved the old profile in meanwhile (`docs/features/windows.md` N8; `ChromePaths.ANewProfileAfterAFailedMoveMakesItsOwnKey`) |
| S-209 | Tests that passed without what they check | Patch 0066 (2026-10-15): `ArcSidebarImporterTest.ReadsACopy` checks that a copy was read and removed; a wrong key unseals nothing in `ArcDataImporterTest.UnsealsAV10Value`; each step of `CommandBarActionsTest.EveryListedRowRuns` and `MediaKeysWindowTest.PictureInPictureFollowsTheKeyAndTheBar` stops only itself, so commandbar K9 and player Mp5 are always checked; the three upstream `HttpsFirstModeSettingsTrackerTest` tests the series' default broke expect it now, run with Stedding's suite, and the local startup histogram counts that default as on |
| S-190 | Closing one pane of a split, or a window holding a split, crashed the browser | Patch 0065 (2026-10-15): the strip's move animation made the row's layer while the row was out of the tree, and adding it to the row's new parent crashed in `Layer::Add`; the layer is made once the row is in its new parent (`docs/features/splits.md` J9; `SidebarClickTest.ClosingAPaneOfASplitKeepsTheOther`, crashed before the fix) |
| S-191 | Grouping a tab inside a folder crashed the browser | Patch 0065 (2026-10-15): the new group was made inside the folder, which holds only tabs, folders and splits, and a `CHECK` killed the browser; any extension's `chrome.tabs.group` could do it. The group goes right after the outermost folder that held the tab (`docs/features/folders.md` F35; `TabStripModelTest.GroupingATabInsideAFolderPutsTheGroupAfterIt`) |
| S-192 | The Arc import crashed on a blocked login that kept its username | Patch 0065 (2026-10-15): the password store `CHECK`s that a blocked site has no username and no password, and an older Login Data keeps the username, so the import killed the browser at every try; a blocked row is saved bare. A history row with no visit time stays out (a `DCHECK` in the history service) (`docs/features/import.md` I22, I23; `ArcDataImporterTest.ReadsLoginsAndUnsealsPasswords`, `ArcDataImporterTest.ARowWithNoVisitTimeStaysOut`) |
| S-193 | Deleting a Space wiped its jar under pages still open in it | Patch 0065 (2026-10-15): a page with unsaved changes keeps its jar until it is left (sessions S21), and a popup keeps its opener's (S11), but the wipe ran at once and took their cookies and storage. The wipe now waits while any tab of the profile's windows shows a page in the jar (`docs/features/sessions.md` S17; `SpaceJarTest.DeletingASpaceWaitsForAPageWithChanges`, `SpaceJarTest.DeletingASpaceWaitsForAPopupInItsJar`). A quit during the wait is `S-206` |
| S-194 | Autofill asked Google's server about every form | Patch 0065 (2026-10-15): Chromium's Autofill server communication is off by default; it sent each form's signature and the page's host to `content-autofill.googleapis.com`, unlisted in `docs/PRIVACY.md` (`docs/features/privacy.md` Q14; `PrivacyDefaultsTest.AutofillAsksNoServer`, failed before the fix) |
| S-195 | The command bar opened scopes it refuses and ran the wrong row after a change under it | Patch 0065 (2026-10-15): a typed `keyword query` opened a model's scope, the tabs and page scopes, and in a private window the normal profile's history; a row that keeps the bar open lost the choice when the rows above it went, and the next Enter ran another command; a late autocomplete answer kept the index and Enter opened another page (`docs/features/commandbar.md` K7, K17, K18; `CommandBarViewTest.AKeywordQueryOpensOnlyAnOfferedEngine`, `CommandBarViewTest.AToggleStaysChosenOnceItHasRun`, `CommandBarViewTest.ALateAnswerKeepsTheChosenSuggestion`) |
| S-196 | Shift ignored by the Mac History menu's Restore Folder | Patch 0065 (2026-10-15): a Shift-chosen folder close comes back in a new window, as a closed window's item does (`docs/features/folders.md` F19; `ClosedFolderTest.AShiftClickRestoresIntoANewWindow`) |
| S-197 | A split switched to stacked kept its side-by-side corners | Patch 0065 (2026-10-15): the panes' corners are redrawn when the layout changes (`docs/features/splits.md` J7; `SidebarFormsTest.TheClosedFormsLeaveThePageEdgeToEdge`, its split step) |
| S-198 | Export Space could write outside its folder | Patch 0065 (2026-10-15): the file name is the Space's name made safe, so a "/" or ".." in it (a Space imported from a file can carry one) no longer fails the export or writes elsewhere (`docs/features/import.md` I20; `SidebarBackupTest.AnExportStaysInItsFolder`) |
| S-199 | A slept tab lost its place in a folder close | Patch 0065 (2026-10-15): a sleep or a jar rebind replaces a tab's contents, and the tab's place in the close it came back from now goes with it, so the close's next row lands after it (`docs/features/folders.md` F19; `SpaceWindowTest.ReplacedContentsKeepTheirPlaceInAFolderClose`) |
| S-200 | Browser tests that read a freed command bar, and pointer tests in the parallel batch | Patch 0065 (2026-10-15): two tests read the bar again after the waits that can close it; `SpaceSwitchTest.NoSwitchEverShowsAHiddenTab` and `CommandBarActionsTest.*` run in the serial leg (`tooling/dev`) |
| S-137 | A folder closed in part came back at its end | Patch 0063 (2026-10-14, the afternoon): Close Folder's Tabs records how many of the folder's tabs it leaves before each closed tab, and the rebuild puts a returning row after those and after the rows of the same close already back, in a folder a tab in another Space kept open: whole, or one row at a time in any order; a split whole, a nested folder made again in its place (`docs/features/folders.md` F19, F20; `FolderTabsTest.AFolderClosedInPartComesBackAtItsSlots`, failed before the fix, and `FolderTabsTest.AFolderClosedInPartComesBackOneRowAtATime`). Found with it, by review: Restore Folder with ⇧ held put the first tab in a new window and the rest in the old one; all of them follow the first now (`FolderTabsTest.AFolderRestoredToANewWindowStaysTogether`, failed before the fix) |
| S-135 | A folder restored from another window came back in reverse order; a chip lit for a frame under an essential | Patch 0063 (2026-10-14): ⇧⌘T judges the order by the window the folder's tabs go back to (their own window while it is open, a new one when it is gone), not the window the command came from; where that window has fewer tabs than the folder's old place, every tab is added at its end, in the folder's order, which each tab's place in the close now records, since the list records a closing split ahead of the tabs before it (using the build found a folder's split broken by its last tab that way) (`docs/features/folders.md` F19; `FolderTabsTest.AFolderComesBackInOrder`, `ClosedFolderTest.TheClosesPlacesKeepTheFoldersOrder`); the chip under a drag is lit only once the drag has said what it carries, never at the lookup of the drop target, and a chip rebuilt during a drag, as a theme change rebuilds it, keeps its place for the drop (`docs/features/spaces.md` B12; `SpaceSwitchTest.FindingTheDropTargetLightsNoChip`, `TabDropTest.ChipDropsMoveLightAndSurviveARebuild`). Each test failed before its fix |
| S-136 | Splitting two tabs inside a folder took them out of it | Patch 0063 (2026-10-14): a split keeps the pivot tab's folder, as Chromium keeps its group, in the pivot's place; a tab of another folder joins it, and a split with a new tab keeps the tab it splits as the pivot (`docs/features/folders.md` F34, `splits.md` J8; `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, both failed before the fix) |
| S-69 | The restore infobar and the card's gutter stayed in full screen | The gutter in patch 0059 (toolbar T33); the bar in patch 0063 (2026-10-14): "Continue where you left off" asks to hide in full screen, as Chromium's default-browser bar does, and comes back after (`docs/features/toolbar.md` T33; `SidebarFormsTest.FullScreenIsEdgeToEdge`, failed before the fix) |
| S-70 | A Space chip showed its name twice | Patch 0063 (2026-10-14): the open sidebar's chip has no tooltip, the floating name being its one name; the rail's chip keeps the tooltip, and the chip's accessible name is the Space's in both (`docs/features/sidebar.md` Y14; `SpaceSwitchTest.AChipShowsItsNameOnce`, failed before the fix). With it, the Mac's ⌃N badges on the chips go by each chip's Space: with Focus on, the one chip took the first Space's number, and a dot took a glyph |
| S-54 | Google's push service at startup | Patch 0030 (2026-10-12, the Mac): the user policy invalidations asked Google's push service for a token for every profile at every launch, whether or not any policy could arrive; they wait for a connected user policy now, which a profile with no browser sign-in never has, and the push service starts on demand only (a site's push subscription, an extension's `gcm` API). Web Push is unaffected (`docs/features/privacy.md` Q11; `QuietStartTest.AFreshProfileCallsNoGoogleService`) |
| S-67 | Google's account list at startup | Patch 0030 (2026-10-12, the Mac): with browser sign-in not allowed, as in every Stedding build, the cookie manager no longer asks `accounts.google.com/ListAccounts`, which three startup readers (a session-length metric, the account investigator, the trusted vault client) triggered within a minute of every launch (`docs/features/privacy.md` Q12; `GaiaCookieManagerServiceTest.NoListAccountsWhileSigninIsNotAllowed`, `QuietStartTest.AFreshProfileCallsNoGoogleService`) |
| S-105 | The macOS image of betas 13 and 14 | Beta 14's macOS image (2026-10-12), built from the series at commit `2e48d01`, which folds in what the Mac's pass found: the hidden sidebar's traffic lights and slid-in row (patch 0059; `docs/features/sidebar.md` Y19, Y20; `WindowButtonsTest.HiddenTheLightsSitOnTheRowsBar`, `SidebarFormsTest.TheRailAndTheLeadingEdge`), and the toasts' edge on the Mac and a late answer's focus in the welcome flow (patch 0060; `toolbar.md` T35, `welcome.md` W12; `AddressBandTest.TheBandTheFieldAndAToastLeaveTheAddressReadable`, `WelcomeFlowTest.TheBehaviourStepReadsWritesAndKeepsFocus`). Beta 13 keeps no macOS image |
| S-109 | Site Search: Tab turns a site's name into a search chip | Patch 0061 (beta 14): a search engine's keyword, name or domain offers "Search <name>"; Tab makes a chip and only that engine's rows show; the @bookmarks and @history scopes only by their whole keyword. Chromium's search engine settings are the list; no AI scopes (ADR 0020) (`docs/features/commandbar.md` K27; `CommandBarViewTest.TabMakesTheSiteChip`, `CommandBarKeysTest.ASiteFromHistoryAndASearchChip`) |
| S-114 | Collapse Pinned Tabs | Patch 0061 (beta 14): from the Space menu or the command bar, per Space, kept in the registry across a restart; the selected pin keeps its row and the Clear line stays (`docs/features/pins.md` H17; `PinnedRunTest.CollapsingHidesThePinRowsButTheSelectedOne`, `PinnedRunTest.TheCollapseSurvivesARestart`) |
| S-116 | New Documents | Patch 0061 (beta 14): command bar rows for eleven services' blank documents through their .new addresses, a fixed list as Arc's (`docs/features/commandbar.md` K28; `NewDocumentsTest.*`, `CommandBarViewTest.NewDocumentRowsOpenInANewTabOfTheActiveSpace`) |
| S-130 | Auto-archive is off (Never) by default | Patch 0060 (beta 14; the owner, 2026-10-11): `stedding.archive.idle_hours` defaults to 0, Never, where it was 12, with a 7-day choice; a profile that chose a value keeps it (`docs/features/archive.md` A6; `settings.md` T2, T8; `commandbar.md` K17; `TabArchiverTest.AFreshProfileArchivesNothing`, `SettingsSpacesTest.ThePageBindsEveryControl`) |
| S-131 | A welcome step for how Stedding behaves | Patch 0060 (beta 14): "Choose how Stedding behaves", the sixth step: when idle tabs archive, what the sidebar does when it closes, when a Space left behind sleeps, each choice written at once (`docs/features/welcome.md` W12; `SteddingWelcomeHandlerTest.BehaviourChoicesAreWrittenAtOnce`, `WelcomeFlowTest.TheBehaviourStepReadsWritesAndKeepsFocus`) |
| S-132 | The address row's hover cut the first letter and started at the row's far left | Patch 0060 (beta 14; the owner's report): the hover band runs from the chip to the page actions, and the address paints no pill of its own (`docs/features/toolbar.md` T34; `AddressBandTest.TheBandTheFieldAndAToastLeaveTheAddressReadable`) |
| S-133 | Toasts covered the address row | Patch 0060 (beta 14): in the Stedding window a toast sits in the page under the address row, not half over it (`docs/features/toolbar.md` T35; `AddressBandTest.TheBandTheFieldAndAToastLeaveTheAddressReadable`) |
| S-77 | Every search engine shows a globe in the welcome flow | Patch 0060 (beta 14): each engine on the welcome flow's first step shows its initial on a colour, drawn by Stedding, nothing fetched (`docs/features/welcome.md` W2; `SteddingWelcomeHandlerTest.EachEngineHasItsOwnMark`, `WelcomeEnginesTest.EachEngineShowsItsOwnMark`). Chromium's own chooser after a skipped step is `S-134` |
| S-124 | The page flush against the window with the sidebar open | Patch 0060 (beta 14): Settings → Stedding → Sidebar → "Page flush against the window", off by default (`docs/features/sidebar.md` Y23, `settings.md` T15; `SidebarFormsTest.FlushTakesTheGutterAway`) |
| S-123 | The sidebar's edge shows where to drag, and a double click resets the width | Patch 0060 (beta 14): a bar along the edge after a 250 ms rest; a double click or tap there restores the default width (`docs/features/sidebar.md` Y22; `SidebarResizeHandleTest.*`, `SidebarFormsTest.TheEdgeResizesAndResetsTheWidth`) |
| S-122 | Mute and picture in picture by key | Patch 0060 (beta 14): ⌃M (Ctrl+M) mutes or unmutes the selected rows, both panes of a split; ⌥⇧⌘P (Ctrl+Alt+Shift+P) toggles picture in picture when the page's media session offers it; bar rows for both (`docs/features/tabs.md` R29, `commandbar.md` K25, `player.md` Mp5; `MediaKeysWindowTest.TheMuteKeyWorksFromInsideASplit`, `MediaKeysWindowTest.PictureInPictureFollowsTheKeyAndTheBar`). Picture in picture by key not yet tried on a real build |
| S-120 | Folder verbs: expand or collapse all, sort, a new tab inside | Patch 0060 (beta 14): ⇧⌘E (Ctrl+Shift+E) collapses every folder of the Space while one is open, else expands them; New Tab in Folder and Alphabetize on the header's menu; a collapsed header shows its count (`docs/features/folders.md` F30–F33, `menus.md` M7; `FolderTabsTest.ACollapsedFolderKeepsItsRows`, `FolderTabsTest.TheHeadersMenuSortsAndOpensATab`). Not yet tried on a real window |
| S-121 | Edit a pin's home address; a middle click sends it home | Patch 0060 (beta 14): Edit Pinned Address… on a pin's or an essential's menu (http and https only); a middle click sends a pin home and never closes it (`docs/features/pins.md` H15, H16, `menus.md` M7, M8; `SidebarClickTest.EditPinnedAddressOpensOverTheWindow`, `SidebarClickTest.AMiddleClickSendsAPinHomeAndClosesAPlainRow`) |
| S-119 | Clear the site's cookies and reload | Patch 0060 (beta 14): ⌥⇧⌘R (Ctrl+Alt+Shift+R) and a bar row delete the page's site cookies, in its Space's own jar when it has one, then reload (`docs/features/commandbar.md` K24, `sessions.md` S27; `SpaceJarTest.ClearingASitesCookiesStaysInThatJar`, `CommandBarActionsTest.EveryListedRowRuns`) |
| S-108 | Inline completion in the command bar | Patch 0060 (beta 14): typing completes to a site from history whose host starts with the typed text, the rest selected (`docs/features/commandbar.md` K23; `CommandBarViewTest.ASiteFromHistoryCompletesTheField`, `CommandBarKeysTest.ASiteFromHistoryAndASearchChip`) |
| S-97 | Undo after closing tabs | Patch 0060 (beta 14): a user's close of one tab or many shows a toast with Undo for 8 s, which reopens those tabs in their Space and folder; none for archive sweeps, window closes, pages closing themselves or extensions; a setting turns it off (`docs/features/tabs.md` R25–R28, R30, `settings.md` T17; `UndoCloseTest.UndoPutsThatCloseBackInPlace`, `UndoCloseTest.AFolderTabAndASplitPaneComeBackInPlace`, `UndoCloseTest.NoToastForACloseTheUserDidNotMake`) |
| S-84 | New Space pins land on top, and an unpin from the middle leaves pins under the Clear line | Patch 0059 (2026-10-10, the operator): a pin joins the end of the run and an unpin goes to the top of the tabs under the line (`docs/features/pins.md` H14; `SpaceWindowTest.PinsJoinTheEndOfTheRunAndUnpinsLeaveIt`). Seen on the real window: Row3, Row5, Row1 pinned in that order stand in that order; Row5 unpinned is the first row under "New Tab", Row1 stays a pin |
| S-85 | The sidebar resizes only a few DIP inside its edge | Patch 0059 (2026-10-10, the operator): the handle reaches over the card's gutter to the card's edge (`docs/features/sidebar.md` Y18; `SidebarFormsTest.TheEdgeResizesAndResetsTheWidth`). Measured with the real pointer: the resize cursor at x 358 to 375 against the card at 376 (358 to 369 before); a drag from the gutter widens the rows by the drag |
| S-86 | A third sidebar form: hidden, the page edge to edge | Patch 0059 (2026-10-10 and 11, the operator): "When the sidebar closes: Shrink to icons / Hide it completely", the leading edge that slides it in, the command bar's three rows, and Settings → Stedding regrouped with a Sidebar section first (`docs/features/sidebar.md` Y19, Y20; `settings.md` T13, T14; `commandbar.md` K22; `SidebarFormsTest.*`, `CommandBarActionsTest.EveryListedRowRuns`). Used on Windows in dark and light, restored and maximized, with F11 |
| S-87 | The sidebar's toggle and the bar named Ctrl+Shift+L | Patch 0059 (2026-10-10): Chromium 155 binds Ctrl+Shift+L to the sidebar as well as Stedding's Ctrl+S, and the toggle's tooltip and the command bar showed it; Ctrl+S is the one chord now (`docs/features/windows.md` N7; `SidebarFormsTest.TheClosedFormsLeaveThePageEdgeToEdge`, `AcceleratorTableTest.*`). Read on the real toggle: "Collapse tabs (Ctrl+S)" |
| S-73 | The default globe on the active row is nearly invisible in dark mode | Patch 0059 (2026-10-11): a translucent row is read over the window's ground when the default globe and single-colour favicons are coloured (`docs/features/sidebar.md` Y21; `DefaultFaviconModelTest.ATranslucentBackgroundIsReadOverTheFrame`, `TabFaviconThemingTest.ATranslucentRowIsReadOverTheFrame`). Measured on Windows: the active row's globe (95,99,104) on (68,91,111) before, (152,158,164) after, in dark; light mode unchanged |
| S-82 | The in-browser shortcut list is behind the product | Patch 0059 (2026-10-10): no Peek rows while Peek is withdrawn, the row chords say the ninth goes to the last row, and the sidebar's row names its closed forms (`docs/features/shortcuts.md` Z1; `ShortcutReferenceTest.TheListMatchesTheProduct`). Seen on the settings page, light mode |
| S-83 | The screenshot toast says "Show in Finder" on Windows | Patch 0059 (2026-10-10): "Show in folder" off the Mac, Chromium's download wording (`docs/features/screenshot.md` C5, `docs/features/windows.md` N10; `SteddingStringsTest.TheCaptureToastSaysShowInFolderOffTheMac`). Read from the string; the toast itself not seen on screen |
| S-17 | Signing and notarisation on the Mac | Beta 10's macOS image (2026-10-01), the first one signed with the Developer ID and notarized, after patch 0051's fixes to Chromium's signer (`docs/HANDOFF.md`, trap 49); betas 11 and 12 the same, through `tooling/sign-release`, `tooling/package-dmg --app` and `syspolicy_check` ("Release channel"). Never in this repository: the certificate, the password, the team id. Windows signing is `S-56`, the updater `S-74` |
| S-80 | The incoming rows open from collapsed during a Space switch | Patch 0058 (2026-10-02): the switch snaps the list's rows to their new layout and only the list moves (`docs/features/spaces.md` B37, `SpaceSwitchTest.ASwitchPutsTheRowsInPlaceAtOnce`, which saw the rows start at no height). Seen on a copy of the owner's profile: ten rows already in place 10 ms after the switch |
| S-78 | ⌘T from an empty New Tab page leaves that page behind | Patch 0058 (2026-10-02): an untouched New Tab page that is not pinned takes what the bar opens (`docs/features/commandbar.md` K21, `CommandBarViewTest.AnUntouchedNewTabTakesWhatIsTyped`). Seen on a fresh profile: one row after ⌘T, a second tab on the next ⌘T |
| S-76 | The welcome flow's steps run under its footer | Patch 0058 (2026-10-02): a step that runs on fades out at its bottom until it is scrolled to the end (welcome W11), and the keys step no longer lists Peek's ⌘O, which made it run 16 DIP under (W6); `WelcomeFlowTest.*`. Seen on a fresh profile with Arc installed: the import step's cards fade into the footer, the keys step fits |
| S-63 | The address row's colour in full screen | Patch 0058: in full screen the overlay paints the row in the page's colour (toolbar T32, 2026-10-01), read in sRGB (T31) and with one hairline under it (2026-10-02). Seen on a copy of the owner's profile: full screen over a white page, a red header and a purple layer, the row's pixel the page's |
| S-68 | The command bar runs past the window's right edge in a narrow window | Patch 0057 (2026-09-30): `CommandBarView::UpdateBounds` keeps the bar inside the page card with 16 DIP each side and it follows the window while it is open; `CommandBarTest.TheBarStaysInsideANarrowWindow` (`docs/features/commandbar.md` K20). At 1035 px with the sidebar open the old bar started over the sidebar and was cut at the window's edge; the new one sits in the card with its corners (Windows, real window). |
| S-64 | Take 155.0.8059.12 | Pin file (2026-09-24), from 153.0.8010.53 straight to M155's early-stable build: the owner wants the newest stable-channel build (ADR 0007, amended). The ordered rebase needed hand merges in 24 of 51 patches, then the Bedrock port: every Stedding surface that held a `Browser` holds a `BrowserWindowInterface` (HANDOFF trap 50). 609 feature and upstream tests green, `verify-build` green, full screen included |
| S-62 | Take 153.0.8010.53 | Pin file (2026-09-18, the day after the point release with sixteen security fixes shipped), 49 patches on it: 0041 merged by hand against upstream's `old_elevator_iids`/`old_tracing_service_iids` (Stedding's GUIDs, empty old-id lists), 0028's restore call takes the new `std::optional` (fixup). `tooling/sync-chromium --point-release` for the room (`docs/HANDOFF.md`, trap 45). `tooling/dev test all` and `test upstream` green, `tooling/verify-build` passed, the README's captures, Mac `v0.2.0-beta.8`. The Windows image of this tag is `S-56`. |
| S-52 | Take 153.0.8010.48 | Pin file, 46 patches rebased (toast ids in 0017/0027 past `kDictationNoMicrophoneError`), `tooling/dev test all` and `test upstream` 581 green, captures measured, Mac `v0.2.0-beta.7` (2026-09-16). Windows image of this tag is `S-56`. |
| S-60 | Independent Space sessions | Patch 0046 (2026-09-16): opt-in per Space, cookies and site data in a `StoragePartition` so the same site can be signed into twice (`docs/features/sessions.md` S1–S12, ADR 0019). Menu, Settings → Stedding, command bar. Essentials stay shared. |
| S-45 | Google's new tab page when Google is the chosen engine | Patch 0044 (2026-09-10): `NewTabURLDetails::ForProfile` returns the local third-party page for every provider, Google included (`docs/features/new-tab.md` N1, `docs/history/archive.md#the-operators-rounds` round 9 row 2) |
| S-53 | The rail's tab pill | Patch 0039, second pass (2026-09-08): a rail row's width is decided in the unpinned container's layout; 3 DIP of padding in the rail in every container and in `TabView::CollapsedWidth`, a 44 DIP square around a 22 DIP favicon (`docs/features/sidebar.md` Y8, `docs/history/archive.md#the-operators-rounds` round 8 row 6) |
| S-46 | Round 7: the operator's look at beta 3 | `docs/history/archive.md#the-operators-rounds` round 7 (2026-09-05): the row in the page's colour (toolbar T15–T18); the rail centred and its toggle clear of the traffic lights (sidebar Y6–Y7); Arc's folder and drifted-pin rows (folders F12, pins H12); the folder quit crash (F12); Arc's history and passwords in one click (import I6, I21–I23, welcome W8). Patches 0037 and 0038, with a second pass the same evening. Shipped in `v0.2.0-beta.4` |
| S-42 | Space colour on the welcome flow | Patch 0018: the five Space swatches on the appearance step tint the first Space at once (`docs/features/welcome.md` W7) |
| S-41 | Download progress on the sidebar button | Patch 0021: the ring and the started animation on the bottom-left button (`docs/features/toolbar.md` T14, capture `w2_download_ring`) |
| S-44 | Round 6: Zen mods and beyond | Every wave landed, 2026-09-05: patches 0016–0036 (`docs/history/archive.md#round-6-plan` carries the landing note per part; each spec its rows); the gaps each spec names stay as `gap` rows |
| S-43 | About page version label | chrome://settings/help reads "Stedding <VERSION> · Chromium <pin> (arm64)" through `stedding::AboutVersionString` and a `stedding_version` GN argument `tooling/build-chromium` writes from `VERSION` (patch 0018); settings T10, verified live 2026-09-05 |
| S-40 | Capture toast | `ToastId::kSteddingCaptureSaved` on Chromium's toast framework, "Copied · Saved to Downloads" with Show in Finder, dialog colours (patch 0017); screenshot C5–C6, verified live 2026-09-05. Off the Mac the button says "Show in folder" since patch 0059 (`S-83`) |
| S-38 | Fullscreen toolbar over the sidebar | `SteddingBrowserViewLayout::CalculateTopContainerLayout` insets the overlay's toolbar by the strip width while immersive fullscreen is on (patch 0002); ARC-ROUND2 round 4 |
| S-18 | Proprietary-codecs licensing decision | Decided 2026-08-31 (ADR 0008, Accepted): ship H.264/AAC in every configuration; the licence itself is a 1.0 release-checklist item (`docs/ROADMAP.md#the-quality-bar`), not a code gap |
| S-36 | Sidebar and Spaces settings rows | Sidebar hover (T6), width slider applied live (T7), auto-archive threshold (T8, patch 0011), Spaces list with rename and delete (T9, patch 0012); the rest in patch 0010, the archiver in 0011 |
| S-37 | Perf budgets on the first vanilla pair | Noise, not the series: on the deterministic local list the pair reads cold +2.3%, warm −2.0%, memory +0.0% (`docs/perf/README.md`); the live list's swings were third-party frames. Re-measure the next official build the same way before a release |
| S-39 | Space tint on the sidebar ground, neutral new tab page | Blend in `stedding_color_mixer` and `SteddingWindowBackground` (patch 0007); spaces B11 |
| S-9 | Operator retest: fullscreen URL width | Retested by capture on the 2026-09-02 release build in real fullscreen (⌃⌘F): the omnibox stays at its cap, centred, unfocused and focused (`docs/history/archive.md#the-operators-rounds` round 2, #1). Since beta 10 the field takes the row and shows the whole address (toolbar T28–T30) |
| S-10 | Operator retest: pill site icon | Same capture: the pill's site icon renders clean at 2× (`docs/history/archive.md#the-operators-rounds` round 2, #4) |
| S-31 | Vanilla `official` build at the pin, measured with the same harness (tree deleted 2026-09-02 for disk; rebuild with `tooling/dev build vanilla chrome --budget 60` from the detached pin) | `docs/perf/README.md` "The comparison": vanilla vs Stedding back to back, overheads against the QUALITY budgets. `tooling/args/vanilla.gn`; built under `--budget 60` |
| S-35 | Promote a peek into a split | ⇧⌘O and an "Open in Split" button hand the page to `chrome::AddWebContents` with `NEW_SPLIT_VIEW`; Chromium 153's split view pairs it with the source tab (peek P9, patch 0009). Off with Peek since 2026-09-26 (`S-14`) |
| S-8 | Popup windows have no Spaces: unit test | `PopupSpaceTest.PopupWindowsHaveNoSpaces` (spaces B14). The SEGV was the test constructing a second Browser by hand; the fixture's typed constructor (`BrowserWithTestWindowTest(Browser::TYPE_POPUP)`, as `TestWithBrowserView` does for hosted apps) builds a popup cleanly |
| S-34 | Peek for links that open a new tab from a pinned tab | One check at the top of `chrome::Navigate()`; `PeekNewTabTest.*` (peek P8, patch 0009). Off with Peek since 2026-09-26 (`S-14`) |
| S-15 | Settings surface | chrome://settings/stedding, first in the menu, three toggles backed by `stedding_prefs.h`; `docs/features/settings.md` (patch 0010) |
| S-33 | New tab page: a setting to hide the shortcut row | The "Stedding" settings section's third toggle (new-tab N5) |
| S-14 | Peek | Links leaving a pinned tab's site open over the window; Escape/click dismiss, ⌘O promotes the same page into a tab. `docs/features/peek.md`, `PeekNavigationThrottle` + `PeekView` (patch 0009). Since 2026-09-26 Peek is off and hidden until it is rebuilt (`PLAN.md` decision 2; `docs/history/plan-2026-09-26.md` CMD-4); the rebuild is `S-93` |
| S-28 | A Stedding new tab page | The local page carries a "Press ⌘T…" hint, no Chrome Web Store tile, theme ground; `docs/features/new-tab.md`, `tooling/probes/ntp.json` (patch 0003) |
| S-32 | Branding leftovers in chrome://settings | "About Stedding" (branding now rewrites `settings_chromium_strings.grdp`); the Stedding mark replaces Chromium's glyph in the omnibox chip, app menu and WebUI (`branding/vector_icons`, one hunk in `cr_elements/icons.html.ts`); helper processes were already "Stedding Helper" |
| S-4 | Folder variant in the tab-strip mojom | `Folder {id, title, is_collapsed}` in the data model union; converter and utilities handle it; folder window verified live (patch 0008) |
| S-29 | De-Google chrome://settings | "You and Google" and "AI in Chrome" hidden; landing route falls through to Autofill (patch 0003) |
| S-30 | Import entry in the app menu | Already present: app menu → Bookmarks and lists → Import Bookmarks and Settings |
| S-13 | Performance baselines from `out/official` | `docs/perf/2026-09-02-official.json` + `docs/perf/README.md`: cold 0.63 s, warm 0.77 s, 5.7 GB / ~107 processes for the ten-site list. Overheads need the vanilla half (`S-31`) |
| S-20 | Folder drop highlight | `tooling/drive` `dragstart`/`dragmove`/`shot`/`dragend`: the hovered header paints its rounded highlight mid-drag; drop lands the tab inside |
| S-16 | Import from Chrome / Arc / Firefox | Closed as written on 2026-09-01: Chromium's importer lists the installed browsers it supports (Firefox seen) and imports history, bookmarks, autofill; a menu entry is `S-30`. Corrected 2026-09-26: on macOS it supports Safari and Firefox, not Chrome, Brave or the new Edge (`PLAN.md` decision 8; the Chromium-family importer is WEB-15, Phase 2, and `S-101`); Arc comes through Stedding's own importer (`docs/features/import.md`) |
| S-27 | Sidebar collapse button | Keep: it is Arc's sidebar toggle in the same corner; only the tab-group/tab-search combo was foreign |
| S-7 | Command bar across Spaces (test) | `CommandBarViewTest.*` (spaces B13) |
| S-26 | First-run search engine chooser | Chromium's own shuffled choice screen, built into the Chromium-branded build, worldwide, shown over the local new tab page even with a non-Google default (patch 0003). Verified live on a fresh profile |
| S-12 | `capture --assert` | `tooling/assert-capture` + `tooling/probes/window.json`, 14 probes; first run caught three square content corners (upstream's glass-mode radii made the "set if empty" guard never fire) |
| S-21 | De-Google the new tab page and omnibox | DuckDuckGo is the prepopulated default, and chrome://newtab is always Chromium's local third-party page -- a provider's own new-tab URL (DuckDuckGo's remote chrome_newtab) is never used (patch 0003). No "Ask Google", no AI Mode |
| S-22 | Essentials as a grid of cards | two cards per row at the sidebar width, a lone card stays card-sized (patch 0002) |
| S-23 | Sidebar top row | Chromium's tab-group/tab-search combo and the hairline under it are gone; the toolbar's profile avatar too (patch 0002) |
| S-24 | Default Space chip glyph | an un-iconed Space shows a glyph from the menu's list (patch 0004) |
| S-5 | New Tab row | Above the unpinned tabs, under the Clear line; the bottom "+" pill is gone. The row opens the command bar (patch 0002) |
| S-25 | The typed text as a command bar row | The bar shows the typed text as an "Open"/"Search" row (patch 0005) |
| S-3 | Live restart check for Spaces and folders through a real quit | `tooling/drive` scenario: quit via AppleEvent, three relaunches, list intact (spaces B9) |
| S-6 | Session-compaction audit | Found the bug: the rebuild dropped every Stedding extra-data command; fixed by the rebuild provider registry plus writing the Space list on the first insert (`SessionRebuildTest.*`, `FolderSessionTest.RebuildReemitsFolderPaths`) |
| S-19 | Live drag/click/key harness as a tool | `tooling/drive` + `tooling/drive-window.py` |
| S-11 | Squash the patch series into per-feature patches | 45 chronological patches → 8 feature patches (tabs, ui, sign-in, spaces, commandbar, updater, colours, folders); final tree byte-identical; old branch kept as `stedding-work-pre-squash` |
| S-2 | Drag a tab onto a folder header to move it in | patch 0008, `folder_drag_target_unittest.cc` (folders F7–F9), verified live by synthetic drag |
| S-1 | Spaces core semantics: membership on insert, active tab follows the switch, empty Space opens a tab, delete moves tabs | patch 0004, `space_model_window_unittest.cc` (spaces B1–B8) |

## Project log before 2026-10-15

### 2026-10-14, evening -- the day reviewed: a folder closed in part, a Shift-click, the tooling

The operator asked for every doc brought up to date, the day's work reviewed, its bugs fixed and
everything pushed. Four reviews read the day again: the docs, the tooling, the product code of
patch 0063 afresh, and S-137.

- `S-137` fixed: a folder that Close Folder's Tabs left open, because a tab of it is in another
  Space, takes its closed rows back in their places, whether it comes back whole or one row at a
  time from its submenu, in any order (folders F19, F20). The first design counted the tabs the
  close took as well, so a single row came back too far down; its review found that, and the
  close now records the survivors before each tab, and a row goes after them and after the rows
  of the same close already back.
- A Shift-click on Restore Folder put the first tab in a new window and the rest in the old one;
  all of them follow the first now. Both new browser tests failed on the code before the fixes.
- Tooling: `tooling/dev test browser` on the Mac would have stopped before running anything (a
  Windows-only fixture on the serial list); `check-repo`'s test parser counted tests a patch only
  showed as context (574 now, as a strict replay counts); the build-settings check requires
  `ffmpeg_branding` too; `tooling/status` sees every build folder.
- Docs: five new BACKLOG rows claimed things missing that the code has (S-145, S-153, S-164,
  S-174, S-176), and a dozen lines elsewhere were stale after the afternoon's moves; all fixed.

Tests: 764 unit tests on both Windows builds, the new ones included; each new browser test
failed on the code before its fix. The remote session was disconnected all evening, so the
browser suite ran without a desktop: everything passed but the three drag tests, which need
one, and on the checked build three cookie-jar tests failing at exit and one full-screen step,
which failed the same with the evening's code taken out (trap 59). Those were green with the
session connected that afternoon. `tooling/fold-fix` can now replace the folded patch's
message (`STEDDING_FOLD_MESSAGE`), and `STEDDING_TEST_LOG` keeps both browser legs.

### 2026-10-14 -- fewer tests, a faster run, the plan into the backlog (patch 0064)

The operator asked to cut the number of tests radically without losing quality, to make the
runs faster, and to clear the repo of what is outdated. Every test was read against the specs
before anything moved: three reviews of the browser tests, two of the unit tests, one of
Chromium's own suites in the sweep, one of the docs and the tooling.

What the time went on: all unit tests took 13 s; the browser suite took 208 s, one test at a
time; a build after an edit takes one to two minutes. So the cut that saves time is in the
browser tests, and the unit tests were cut for clarity only.

- Browser tests, 233 to 103: tests that shared a setup are one scenario, each old test a step
  under a `SCOPED_TRACE` with its expectations kept and the state put back between steps;
  tests whose checks another test already made are gone. 73 run four at a time and 30 one at a
  time (`SERIAL_BROWSER_TESTS`): the drags, hovers and keys, the clipboard, picture-in-picture,
  a page that must paint for its colour, a command bar held across a wait. The suite takes about
  65 s on the release build and 130 s on the checked one.
- Unit tests, 930 to 760: Chromium's suites over code the series changes only at its edges
  moved to `tooling/dev test rebase` (`TabTest`, `TabContainerTest`, `TabStripTest`), and
  `ThemeServiceTest`, over code the series does not change, left the sweep (476 to 336 of
  Chromium's). Stedding's own 454 to 424: duplicates deleted, near-copies made tables, and
  different behaviours kept as separate tests, since a unit test costs nothing to run.
- Checks that could not fail were tightened on the way: a context menu's rows asserted present
  before hidden, the tab strip internals page showing the folder, a link drop below a folder's
  last row and on a collapsed folder, the settings page's address loading in the profile's jar,
  the isolation question skipping pins and sleeping tabs, the emptied nested folder going.
- The merges were reviewed three more times against the old tests: thirteen findings (three
  tests deleted without a real cover and brought back, a wait made shorter, steps that leaned on
  the step before), all fixed before the runs below.
- Parallel runs found what the serial ones hid (trap 88): a tab drag asks Windows which window is
  under each point and a new test window is not always in front, so the agent's own window took
  the drop (the drag fixtures now keep their window above others); a command bar closes when its
  window loses focus, and two tests held a pointer to it across a wait.
- The one product change: the hidden sidebar's test path reveals without the frame painting
  active, as it already did without the real cursor (patch 0059).

The docs: the 2026-09-26 plan, round 6's plan and the operator's rounds 2 to 11 moved to
`docs/history/`; `PLAN.md` is now the owner's decisions and when an item is done;
`BACKLOG.md` is the order of work, its rows `S-138` to `S-177` carrying the 225 items of the
old plan still open, by root cause, and `S-178` the Mac's half of this round. The roadmap's
status table, stale within days, is gone; the contradictions a review found between the docs,
the ADRs and the tooling are fixed (codecs, the updater, the development machine, Nook's
extensions, the idle-network run). Tooling: `tooling/status` sees the Windows builds,
`check-repo` keeps every build configuration's shared settings and reads a renamed test's
declaration whole, the build supervisor defaults to 12 jobs, `verify-build` requires H.264.

Tests: on `win-release` and on `win-checks` (DCHECKs and the dangling-pointer detector), 760
unit tests and 103 browser tests, both suites green twice on each build and the browser suite
green four times more on the release build. Not run: the Mac (`S-178`), `components_unittests`
(not built on Windows), ASan (`S-106`).

### 2026-10-14 -- a split keeps its folder, a folder comes back in order, five small defects (patch 0063)

The operator asked for `S-135`, `S-136` and the other small defects known, tested thoroughly.
Each root cause was traced through the code before its fix, the whole diff was reviewed against
its callers, each new test was run against the code without its fix and failed, and the build
was used by hand. One patch, 0063, as the rounds before it.

A split made of a folder's tabs stays in the folder (folders F34, splits J8): Chromium gathers
the tabs by strip index, and a folder's first and last slots resolve in its parent; they now
gather into the pivot tab's folder, as into its tab group, and a split with a new tab keeps the
tab it splits as the pivot. ⇧⌘T, or the Mac's History menu, from another window brought a folder
back reversed, the order judged by the command's window while the tabs go back to their own
(folders F19). Using the build found more in the same place: with the folder's own window left
shorter than the folder's old place, the tabs restored first grew the window past it, and a later
tab went back at that place, in front of them and, in one case, between a split's panes, which
broke the split. Chromium records a closing split before any tab of the close, so the list does
not hold a folder in its order; the close now marks each tab's place, and a folder whose place is
past its window's end comes back at the end, in order. The chip under a drag was lit at the lookup
of the drop target, before the drag said it carried an essential (spaces B12). A Space chip in the
open sidebar showed its floating name and a tooltip (sidebar Y14, `S-70`); the Mac's ⌃N badges on
the chips went by position, wrong with Focus on, and put a glyph on a dot. "Continue where you
left off" stayed across a page's full screen (toolbar T33, `S-69`).

`TabDropTest.TheChipUnderADraggedRowIsLit` failed one run in three or four, before this round as
after. Logging found a product race, not the machine (compare trap 77): a theme change rebuilt
the Space chips during the drag, a new chip had no bounds until the next paint, the drag's next
move found no chip under the pointer, and the release dropped nothing. A rebuilt chip now keeps
its old bounds until the row is laid out (`TabDropTest.AChipRebuiltMidDragStillTakesTheDrop`).
Left as `S-137`: a folder closed in part, a tab of it in another Space, comes back at the
folder's end. The three sidebar hover tests of trap 78 failed once more, after a live check
left the cursor mid-screen: the parking trap 78 credited to "the PC's suite scripts" lived in
uncommitted scripts, and `tooling/dev` now parks it on Windows
(`tooling/win/park-cursor.ps1`).
Tests: on the final code, on both the release and the DCHECK build (DCHECKs and the dangling-pointer detector), 930 of 930 unit tests and 233 of 233 browser tests. Each new test was run against the code without its fix and failed: `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, `FolderTabsTest.AFolderRestoredFromAnotherWindowKeepsItsOrder`, `FolderTabsTest.AFolderComesBackInOrderToAShortWindow`, the shown-tab check in `FolderTabsTest.AFolderHoldingASplitComesBackWhole`, `SpaceSwitchTest.FindingTheDropTargetLightsNoChip`, `SpaceSwitchTest.AChipShowsItsNameOnce`, `SidebarFormsTest.TheRestoreBarLeavesAPagesFullScreen` and `TabDropTest.AChipRebuiltMidDragStillTakesTheDrop`. `TabDropTest.*` passed 8 runs in a row after the chip fix. Used by hand on the Windows release build: the floating Space name alone over a chip after a two-second rest, no tooltip window; the restore bar gone in F11 and in a video's own full screen and back after each; a split of a folder's two tabs inside the folder; a folder holding a split and a tab, closed, its window left shorter than its place, restored with ⇧⌘T from a second window, whole and in order, the split first and shown. The macOS build is not run (`S-178`). The 930 of 930 and 233 of 233 are that morning's counts; that afternoon, patch 0064 merged the tests named here: `TabStripModelTest.SplittingTwoTabsOfAFolderKeepsTheSplitThere`, `FolderTabsTest.ASplitOfAFoldersTabsStaysInIt`, `SpaceSwitchTest.FindingTheDropTargetLightsNoChip` and `SpaceSwitchTest.AChipShowsItsNameOnce` kept those names, `FolderTabsTest.AFolderRestoredFromAnotherWindowKeepsItsOrder`, `FolderTabsTest.AFolderComesBackInOrderToAShortWindow` and the shown-tab check in `FolderTabsTest.AFolderHoldingASplitComesBackWhole` are now `FolderTabsTest.AFolderComesBackInOrder`, `SidebarFormsTest.TheRestoreBarLeavesAPagesFullScreen` is now `SidebarFormsTest.FullScreenIsEdgeToEdge`, and `TabDropTest.TheChipUnderADraggedRowIsLit` with `TabDropTest.AChipRebuiltMidDragStillTakesTheDrop` are now `TabDropTest.ChipDropsMoveLightAndSurviveARebuild`, which calls `TheChipLightsAndGoesDark`.

### 2026-10-13 -- the Mac's round checked on Windows (patches 0030, 0062)

The Mac's round (the entry below) pulled onto the PC: the branch rebuilt from patch 0030 on out
of the patch files with git plumbing alone, so only the files that differ were written, and its
export matched the pulled series byte for byte. A read of the round for the PC found three
faults, fixed in 0062 with tests that failed before: a split inside a folder was left behind
by Restore Folder and ⇧⌘T, being its own split entry (folders F19); Recently Closed kept the
old folder ids after a rebuild, so no folder showed ⇧⌘T's chord (TAB-13); a normal window's
colour supplier was freed with its window, and its address could come back as a private
window's, which would then take the normal window's cached provider (private V9). Left as
`S-135`: the order of a folder restored from another window, and a chip lit for one frame for
an essential. The quiet-start tests (`QuietStartTest.*`, the two Google calls) ran in the
Windows browser suite. Tests: on both the release and the DCHECK build, 928 of 928 unit tests and 226 browser tests: everything passed but the two new folder tests, whose first versions were wrong (one built its split after the folder, which takes the split out of it; one asked a menu with no window for its chord), and which pass on both builds as corrected. Four sidebar hover tests and a Guest-window colour test failed once with the real cursor over where test windows open and passed with it parked (trap 78).

### 2026-10-12 and 13 -- two privacy leaks, Phase 0's last code items, and the operator's three (patches 0030, 0062)

The operator asked for the two startup calls to Google (`S-54`, `S-67`) and the Phase 0
items with code left (TAB-13, SPC-4, WEB-5, CMD-1), pushed without a release and tested
properly. Every fix has a test that failed with the fix taken out.

- **Google's push service** (privacy Q11; patch 0030). The user policy invalidations
  (`UserFmRegistrationTokenUploader`) asked the push service for a token for every
  profile at every start, managed or not; they wait for a connected user policy now,
  which a profile with no browser sign-in never has. `QuietStartTest.GooglesPushServiceStaysOff`.
- **The Google account check** (privacy Q12; patch 0030). Three startup readers -- a
  session-length metric, the account investigator, the trusted vault client -- made the
  cookie manager ask `accounts.google.com/ListAccounts`; it no longer asks where browser
  sign-in is not allowed, as in every Stedding build. Browser tests pretend an OAuth client
  exists, so the test puts itself where the build is (`--allow-browser-signin=false`, trap
  84), and a control test shows the stand-in server does see the check where sign-in is
  allowed.
- **The network record.** A fresh profile of the fixed release build, five minutes
  headless and ten with a window, beside the same runs of the installed beta 10: the
  account check is gone (beta 10 asked it in both runs); neither build reached the push
  service in these runs, so that part rests on its browser test (`PRIVACY.md`).
- **Safe Browsing in Settings** (privacy Q13, PLAN.md WEB-5; patch 0030): Settings →
  Security says it does not work, above the modes.
- **A folder close as one Recently Closed entry** (PLAN.md TAB-13, folders F19; patch 0062).
  Not a new kind of entry in Chromium's restore code: Close Folder's Tabs marks each tab
  with the close's batch and the folder's name, which the tab's record keeps; the app
  menu's Recently Closed and the Mac's History menu show a batch as one item, and Restore
  Folder and ⇧⌘T bring the folder back. A batch close records every tab at the same index,
  so ⇧⌘T restores newest first, undoing the closes in turn (oldest first reversed the
  folder). The list keeps an entry per tab, so Undo and the Archived view are unchanged.
- **The lit chip** (PLAN.md SPC-4, spaces B12; patch 0062), seen live with the real
  pointer: over the chip a disc of its Space's colour, back over the list dark, dropped
  dark with the row in that Space.
- **The extension-reload test** (PLAN.md CMD-1, F61; patch 0062).
- **The series.** The privacy code folded into 0030 by plumbing (32 commits rewritten);
  the rest conflicted with the archive and test layouts of 0058 to 0061, so it is one new
  patch, 0062, under the operator-round exception. A Mac checked configuration,
  `tooling/args/mac-checks.gn`, and a Mac-only unit filter table in `tooling/dev` (trap
  80's case: `HistoryMenuBridgeTest` exists only on the Mac).
- **Tests**: on the release build with every change of the round in, 941 of 941 unit tests,
  20 of 20 component tests (the account-check test among them) and 225 of 225 browser tests,
  in one run at a load near 10. An earlier run, before the operator's three, had six sidebar
  tests crash at "CompleteShutdown took more than 30 seconds" with the Mac at a load of 100 to
  400 (trap 66); they passed on their own once it fell. Each new test also ran on its own.
- **Seen live** with the real pointer and keyboard on fresh profiles: the lit chip (above);
  Settings → Security's note above the Safe Browsing modes; a folder of three tabs closed from
  its header's menu, the Mac's History menu holding it as one item, "New Folder - 3 Tabs",
  with Restore Folder and its tabs in order, and ⇧⌘T bringing the folder back with its first
  tab shown. That look found the unnamed folder's item reading " - 3 Tabs": the close now
  records the name the header shows (`FolderTabsTest.AnUnnamedFolderKeepsItsHeadersName`,
  red before the fix).
- **The checked build** (`tooling/args/mac-checks.gn`, DCHECKs and the dangling-pointer
  detector; the Mac's first). Its first run passed 922 of 922 unit tests and 20 of 20 component
  tests, and 11 browser tests crashed with the detector's report: the tab layout's animation
  maps (`TabCollectionAnimatingLayoutManager`) kept raw pointers to rows destroyed outright, a
  folder closed or a window restored. The manager forgets a child now when its host loses it
  (`TabCollectionAnimatingLayoutManagerTest.AChildDestroyedOutrightLeavesNoPointerBehind`,
  which crashed with the report before the fix). With every change of the round in, the
  checked build passed 941 of 941 unit tests, 20 of 20 component tests and 225 of 225 browser
  tests, with no dangling-pointer report.
- **The operator's three** (2026-10-13; patch 0062). Each test failed with its fix taken out.
  - *Split view* (splits J7): Chromium padded each pane 5 DIP for its ring, so a band of the
    mat ran between the address row and both pages and the pages were 20 DIP apart. A pane
    is the page itself now: measured on the release build, the pages start under the row's
    1 DIP hairline (a 6 DIP band before), lie 6 DIP apart and keep the card's 6 DIP gutter
    to the window's edge (11 before); with the sidebar hidden, 6 DIP apart and edge to edge.
    `SidebarFormsTest.SplitPanesAreThePageAGutterApart`.
  - *The traffic lights on Back and Forward* (sidebar Y19). The operator saw it in a test
    window. Every steady form cleared the lights in seven live repros; capturing the test
    windows a few times a second found it: while a hidden sidebar opens, or the closed form
    changes between the rail and nothing, the strip is narrower than the lights, and the
    row started right after the strip, under them, for seconds on the loaded Mac (trap 86).
    The row's contents now start past the lights while the strip is narrower than the rail.
    `WindowButtonsTest.OpeningAHiddenSidebarKeepsTheRowOffTheLights` steps the animation by
    hand (13 steps under the lights without the fix); live, Cmd-S toggled six times over an
    orange page and captured about ten times a second: the seven frames with a strip narrower
    than the rail all had Back at 127 pt, past the lights.
  - *Back, Forward and Reload with no ground* (private V9, half of PLAN.md WIN-6). A private
    or Guest window has no Space model, which owns the page's colour, so its row was never
    painted and the buttons sat on the bare window ground. `BrowserWindowFeatures` owns the
    colour for those windows; in a private window the row's supplier takes the colour key's
    one slot, marked to stand for the private mark, so the window stays graphite.
    `PrivateCoatTest.APrivateWindowsRowTakesThePagesColour`,
    `SteddingColorMixerTest.AMarkedSupplierStandsForThePrivateMark`; live, a private window
    over the incognito page, an orange page and a white one: the row in each page's colour,
    the buttons on it, the ground graphite.

### 2026-10-12 -- the Mac's pass on betas 13 and 14 (beta 14's macOS image)

Betas 13 and 14 went out from the PC with no macOS image (`S-105`). The Mac pulled, applied the
61 patches, built the release configuration, ran its suites and used the build; its fixes were
folded into 0059 and 0060, and the signed, notarized DMG joined `v0.2.0-beta.14`.

- **Two faults in the hidden sidebar** (sidebar Y19, Y20; patch 0059). With the sidebar hidden,
  the address row's page-coloured bar started where the row's contents start, right of the
  traffic lights, which sat on a patch of the window's dark ground; `PageBarSurface` now starts
  the bar at the window's edge (`WindowButtonsTest.HiddenTheLightsSitOnTheRowsBar`, red before
  the fix). The sidebar slid in from the window's edge drew its top row 40 DIP high where the
  open one is 38: a hidden strip was given no address-row height and fell back to the toolbar
  buttons' own insets (`SidebarFormsTest.TheLeadingEdgeSlidesItInOverThePage`). The second is
  in code Windows shares.
- **The welcome flow's focus** (welcome W12; patch 0060). Every late answer (the Arc check, the
  importer's list, the default-browser check, an import's progress) redraws the whole flow, and
  the redraw dropped the keyboard focus onto the page; on the Mac
  `EachBehaviourChoiceIsWrittenAtOnce` caught it in four runs of five. The redraw now gives the
  focus back to the same control (`WelcomeFlowTest.ALateAnswerKeepsTheFocus`, red before the
  fix; then all six welcome tests five times each, 30 of 30).
- **The toasts' place** (toolbar T35; patch 0060). Seen live: ⌘W's undo toast crossed the line
  under the address row by 6 DIP. Over the page, Chromium places a toast `kShadowBlur` above its
  anchor's bottom, the room its border's shadow takes; on the Mac the window server draws the
  shadow, the border has no inset (measured: the toast's top at 65 against the row's 71), and
  the toast's body started that much above the row. The toast now starts as far above as its
  border's own inset, nothing on the Mac; `AddressBandTest.AToastLeavesTheAddressReadable`
  checks the visible edge, and the live toast sits right under the line.
- **Tests that assumed Windows or raced on the Mac**: the hidden form's address row starts right
  of the lights on the Mac; the undo toast was measured while its window was still moving (trap
  81); a `RunUntil` check that waited inside itself never returned on the Mac (trap 79); a
  rename test clicked while the rows still grew; and the strings test had no Mac case, so its
  filter stopped the whole sweep (trap 80).
- **Tests**: the final build, `tooling/dev test all`: 918 of 918 unit tests, 19 of 19 component
  tests and 214 of 214 browser tests, no retries, with another job's processes holding the
  load near 110 (trap 66 did not bite).
- **Seen live** with the real pointer and keyboard on fresh profiles, on the release build: the hidden form
  from the command bar, its leading edge in and out, ⌘S, the toggle naming ⌘S, the lights on
  a themed page's bar; ⌃M, ⌥⇧⌘R (the page's cookie gone at its reload), a folder from the
  command bar and ⇧⌘E both ways; ⌘W's toast before and after its fix; the welcome flow's
  behaviour step. Not tried by hand: ⌥⇧⌘P, Site Search, New Documents, Close Duplicate Tabs,
  Collapse Pinned Tabs, the edge's bar.
- **Signed and notarized**: Apple accepted the app, `spctl` reads it as a notarized Developer ID
  app and `syspolicy_check distribution` as ready for distribution; `tooling/verify-build` on
  the signed app: the page, WebGL, the three codecs and full screen passed; its network check ran
  offline, because this Mac's outgoing firewall held the new build's first connections for an
  answer and the check timed out behind it. The DMG's sha256 is `10348451…cc076d`; beta 13's notes now send
  the Mac to beta 14.

### 2026-10-12 -- beta 14 released (patches 0060 and 0061)

`v0.2.0-beta.14`, the Windows installer first (unsigned; the Mac adds its image after its own
pass, `S-105`). Before the cut: a docs pass over every Markdown file, cutting history and stale
notes; the row-numbers setting's sub-label corrected to "the first eight rows you can see, and
9 to the last one" (folded into 0061). The release build with the version set: 904 of 904 unit
tests, 212 of 213 browser tests, the other the known `SleepInUseTest` race, three of three
alone. Four sidebar hover tests failed once with the real cursor resting over where test windows
open, and passed with it parked in the screen's corner (trap 78). The installer ran over beta 13
as a repair with Stedding closed, the installed `chrome.dll` matching the build
(`docs/release-notes/archive.md#stedding-020-beta-14`).
### 2026-10-11 -- three more items (patch 0061, beta 14)

The operator asked for the next three, fast. Three small items in different parts of the code
were built together without building in between, then built and tested once.

- **Site Search** (S-109, commandbar K27): typing a search engine's keyword, name or domain
  offers "Search <name> — Tab"; Tab makes a chip and only that engine's rows show. The list is
  Chromium's own search engine settings. The first cut offered the @bookmarks and @history
  scopes by name, which took "bo" and "hi", and Tab with them, from the actions, and a leading
  "@" from the Space filter (K19); the scopes now need their whole keyword.
- **Collapse Pinned Tabs** (S-114, pins H17): from the Space menu or the command bar, per
  Space, kept across a restart; the pins hide by the one row rule and the selected pin keeps
  its row.
- **New Documents** (S-116, commandbar K28): command bar rows for eleven services' blank
  documents through their .new addresses, a fixed list as Arc's.
- **Tests**: one build of both configurations and the suites in one pass, after the Site Search fix: 904 of 904 unit tests and 213 of 213 browser tests on the release build, the same on the DCHECK build with no DCHECK or dangling report. Seen with the real keyboard on the release build: the Bing chip and its search row, the New Documents rows under "new g", and a collapsed run hiding its pin with the Clear line kept, then expanded again.
- **A machine fault, not the code**: three drag tests (`TabDropTest.*`) began failing on the
  release build between two runs an hour apart; the same three failed on patch 0060's own code
  rebuilt for the check, which had passed them at noon, so the cause is this PC's state (trap
  77), not the round. The DCHECK build passed them in the same round.

### 2026-10-11 -- the operator's round after beta 13 (patch 0060, beta 14)

After beta 13 the operator asked that auto-archive not run by default, a welcome step to ask
about it and the like, ten backlog items that are not hard, built and tested together, and a
fix for the address row's hover. All of it is one new patch, 0060 (the operator-round
exception in `patches/README.md`). It went out in beta 14 with patch 0061.

- **Auto-archive off by default** (S-130; archive A6, settings T2 and T8, commandbar K17):
  `stedding.archive.idle_hours` defaults to 0, Never, where it was 12, and a 7-day choice joins
  Settings, the command bar's row and the welcome step. A profile that never changed the
  setting stops archiving on update; one that chose a time keeps it.
- **A sixth welcome step, "Choose how Stedding behaves"** (S-131; welcome W12), after Light or
  dark: archive (Never by default, up to 7 days), what the sidebar does when it closes (Shrink
  to icons by default, or Hide it completely), and a Space's sleep after you leave it (Never by
  default, up to an hour). It shows the current values and writes each choice at once.
- **The search engines' marks** (S-77): each engine in the welcome flow's first step shows its
  initial on a colour, Stedding's own drawing; nothing is fetched. A public Chromium checkout
  ships no engine images, so every engine had drawn the default globe.
- **The sidebar**: "Page flush against the window" in Settings → Stedding → Sidebar, off by
  default, for no gutter and square corners beside an open sidebar (S-124; sidebar Y23,
  settings T15); a thin bar along the edge after a rest, and a double click or tap there for
  the default width (S-123, Y22); a middle click on the sidebar's empty ground opens the
  command bar (part of S-125, Y24).
- **Tabs and media**: Ctrl+M mutes or unmutes the selected rows, both panes of a split, and
  Ctrl+Alt+Shift+P toggles picture in picture on the page's video when its media session offers
  it (S-122; tabs R29, commandbar K25, player Mp5). After a user's close, of one tab or many, a
  toast offers Undo, which reopens exactly those in their Space and folder; none for archive
  sweeps, window closes, pages that close themselves or extensions; a switch in Settings →
  Stedding → Tabs turns it off (S-97; tabs R25 to R28 and R30, settings T17).
- **Folders and pins**: Ctrl+Shift+E collapses every folder of the Space while one is open,
  else expands them all; a folder header's menu gains New Tab in Folder and Alphabetize; a
  collapsed header shows its tab count (S-120; folders F30 to F33, menus M7). Edit Pinned
  Address… on a pin's or an essential's menu, and a middle click sends a pin home (S-121; pins
  H15 and H16, menus M7 and M8).
- **The command bar**: inline completion to a site from history (S-108, K23); Clear Site
  Cookies and Reload, Ctrl+Alt+Shift+R, in the Space's own jar when it has an independent
  session (S-119; K24, sessions S27); Close Duplicate Tabs, listed only while the Space has a
  duplicate (part of S-125, K26). Also from S-125, a switch for the link address shown at the
  window's corner on hover (page U9, settings T16); S-125 stays open for its other parts.
- **The address row's hover** (S-132, toolbar T34), the operator's report: with the address
  gathered on the page's middle in a field that takes the row, hovering painted the field's
  translucent colour twice, a lighter pill whose rounded edge cut through the first letter, and
  the band began at the row's far left where nothing is. Now the band runs from the chip to the
  page actions and the address paints no pill of its own; while editing, Chromium's whole field
  stands (`AddressBandTest.*`).
- **Seen on the release build with the real pointer and keyboard** (Windows): the six welcome
  steps with the engines' marks, the behaviour step fitting with Never chosen, and "1 day" and
  "Hide it completely" written to the profile and shown in Settings; the flush page on, then
  off again; the address row's band from the chip to the star, with no pill; the edge's bar, a
  drag from 328 to 398 px and a double click back to 328; Ctrl+W's toast with Undo; the command
  bar's "Mute Tab" and "Clear Site Cookies and Reload" rows with their keys, and no Close
  Duplicate Tabs without a duplicate; a middle click on the sidebar's ground opening the bar,
  a non-client press that no test reaches.
- **Not checked live**: picture in picture by its key, the Edit Pinned Address dialog, the
  folder verbs and the count, Clear Site Cookies on a real signed-in site, inline completion
  with real history. The Mac has built none of 0060.
- **Found by that use, and fixed**: Chromium's toasts sat half over the line under the address
  row, which is thinner than Chromium's toolbar, so the Undo toast hid the address for 8 s
  after every close. In the Stedding window a toast now sits in the page under the row, as in
  full screen (S-133, toolbar T35), and the toast was seen there afterwards.
- **Found by the suites, and fixed**: after Alphabetize, and after any move inside a folder, the
  drawn rows kept their old order: the folder's view lays its rows out in view order, while a
  move reorders only the node's children; the folder now puts its rows in the folder's order
  before it lays out (folders F31). The address band's own test kept a pointer to the window
  past its end (the dangling-pointer detector). `RenameFieldWatcherTest`'s field had no
  accessible name, which the accessibility paint check stops whenever its window paints in
  time (a latent test fault, folded into patch 0057). The right-to-left edge test failed once
  on the release build and passed three times out of three alone.
- **Found, not fixed**: skipping the welcome flow's engine step leaves no default chosen, and
  Chromium's own "Choose your search engine" dialog then opens over the first page with a
  globe for every engine (S-134, for the owner; `PLAN.md` WEB-13, WEB-F41).
- **Tooling**: `-Wunsafe-buffer-usage` stops a test that indexes a plain C array in a loop
  (trap 73); the DCHECK build ran out of commit at 22 jobs and built at 16 (trap 74).
- **Tests**: one build of everything, then the suites in one pass on both builds. The first
  pass found one compile error (trap 73) and four faults (above); the second, after the fixes:
  on the release build 882 of 882 unit tests and 209 of 209 browser tests, and the same 882 and
  209 on the DCHECK build with the dangling-pointer detector, with no DCHECK or dangling report.
  No ASan run (`S-106`), and nothing of 0060 on a Mac.

### 2026-10-10 and 11 -- the operator's pass on beta 12: the hidden sidebar (patch 0059)

The operator asked for a third sidebar form and named three faults; the PC built each, used it
with the real pointer and keyboard, and fixed what that use found before calling it done.

- **The hidden form** (`docs/features/sidebar.md` Y19): "When the sidebar closes: Shrink to
  icons / Hide it completely" (`stedding.sidebar.closed_form`). Hidden, the strip takes no width
  and the page card no gutter or corner, the address row runs edge to edge, and the pointer
  resting at the window's leading edge slides the sidebar in over the page. The command bar has
  "Show Sidebar", "Collapse Sidebar to Icons" and "Hide Sidebar" (K22).
- **Pins** (pins H14): a pin joins the end of the run; an unpin goes to the top of the tabs under
  the Clear line instead of splitting the run, which showed the pins below it as unpinned.
- **The resize edge** (Y18): the handle reaches over the 6 DIP gutter to the card's edge.
- **Settings** (settings T13, T14): the page in sections, Sidebar first; the width, tab row
  height and text size were already there, mid-list.
- **Found by using it, fixed**: the hidden strip's rows painted over the page (child layers its
  bounds did not clip); an empty band under the rail's toggle, older than this round, from a
  hidden combo button still counted (Y20); the selected row's globe at 1.4:1 in dark (S-73, Y21);
  Chromium 155's Ctrl+Shift+L in the toggle's tooltip and the bar (S-87); F11 and a video's full
  screen keeping the card's gutter (S-69's gutter half, toolbar T33). From the backlog: S-82,
  S-83.
- **The roadmap** (`docs/ROADMAP.md`): brought up to date (a state table; M5 is partly done, not
  done; M4's command bar did not replace the address row), and a milestone M10 for ideas read in
  Nook and Aura, rebuilt and never copied (ADR 0021; `BACKLOG.md` S-88 to S-101;
  `docs/VISION.md#competitors`).
- **Tooling**: the build supervisor ends with SUPERVISOR_EXIT=6 when `build.ps1` refuses to
  start (trap 70); `Drive-VisibleRect` for aiming at a window's real edge (trap 69); a firewall
  prompt holding the foreground is the operator's to answer (trap 71).
- **A review before the cut** read the diff and found eight faults, none a crash (the edge
  opening a sidebar F11 hid, right to left on the wrong side, two macOS full-screen layouts, a
  DIP past the window at fractional scales, mixed selections, two Mac paths); all fixed.
- **Tests**: unit 822 of 822; browser 170 of 171, the one failure a focus race at typing into a
  page's field (`SleepInUseTest`), which passed alone three times out of three. Then the DCHECK
  build with the dangling-pointer detector (`out\win-checks`): 822 unit tests passed, and three
  browser tests stopped on one fault, the welcome dialog holding its page's view past its widget
  (folded into patch 0015, trap 72); after the fix all 171 passed, and on the release build all
  822 unit tests and all 171 browser tests passed. No ASan run of 0058 and 0059 yet (`S-106`); the Mac has not built 0059 (`S-105`).
- **Beta 13** (2026-10-11): the Windows installer of this series, run as the user as a repair
  over the installed beta 12 before it was cut (`docs/release-notes/archive.md#stedding-020-beta-13`); the
  macOS image is the Mac's to add after its own pass.

### 2026-10-02 -- round 11 seen live, and beta 11

Patch 0058 (the owner's report on beta 10) had passed its tests without anyone looking at
it; the Mac then used the release build with the real pointer and keyboard on a copy of the
owner's profile and on a fresh one.

- **Round 11's live column, filled in** (`docs/history/archive.md#the-operators-rounds`): three restarts of the copy with
  no "reason 332" and the imported tabs loading; rows clicked in the open sidebar and the rail;
  ⌘S keeping the address row; the swipe following the fingers; the eight Spaces as icons; the
  row's colour against the page on five pages and in full screen. TAB-3's and WIN-29's Mac
  halves passed too (`PLAN.md`).
- **Five faults found and fixed in 0058**, each with a test that failed first: the page's top
  read in the display's colour space (Display P3) and painted as sRGB (toolbar T31); a Space
  switch that showed nothing for half a second on the owner's profile, because the Space's tint
  re-themed every row and each row laid the whole list out again and redrew its folder glyph
  (spaces B36, found with `sample`, HANDOFF trap 65); a second line under the row in full screen
  (T32); the rail's Clear label clipped to "lear" (B17); folder names nearly invisible in light
  mode (folders F12). Logged instead: S-76 to S-80.
- **Two things about the harness**: the round 11 swipe helper set the event's line delta, which
  makes macOS report eight times the travel (trap 63), and Arc takes ⌥⌘N from every app while
  it runs (trap 64, `S-79`).
- **Beta 11**, the macOS image of this series, signed and notarized; Windows stays on beta 10's
  installer until the PC builds this tag.
- **Beta 12** the same day: what the pass had logged, fixed in 0058 with tests that failed first
  and seen on the rebuilt app -- the rows in place on a Space switch (S-80), ⌘T into an empty
  New Tab (S-78), the welcome flow fitting or fading (S-76), the Clear line on tinted Spaces, and
  Arc's ⌥⌘N in Settings' shortcut notes. The browser suite crashed at the harness's 30-second
  shutdown limit while other jobs held the Mac at a load of about 400 with swap full, and passed
  once the load fell; a sweep is only read on a quiet machine.
- **Beta 12 for Windows**, built on the PC and driven from the Mac over SSH. Its browser suite
  found the welcome flow's keys step 44 px under its footer on Windows, where the chords are
  spelled out; fixed in 0058, and Windows is no longer taught the Space swipe, which works on
  the Mac only. Two lessons about running the suite unattended: a scheduled task in the
  operator's session can run it at normal priority, but its windows cannot take the foreground
  a drag needs (trap 67); and at a display scale of 150 % Chromium's event generator scales a
  click twice, so sixteen click tests had been testing the generator (trap 68). The installer
  went into beta 12 beside the Mac's DMG: unit 817 of 817, browser 157 of 161, the four drag tests the only failures.

### 2026-10-01 -- the Mac's half of beta 10

The Mac took the PC's series as it was, re-exported byte for byte from the Mac checkout (a
re-apply by plumbing rewrote only the 39 files the PC had changed, so the rebuild took half an
hour), and the suites passed on it before anything changed. Then:

- **The migration, proven and fixed.** On a made-up profile the release build lost the move for
  good when another browser held Chromium's folder: it started an empty profile, and no later
  launch moved anything. The system's alert now asks first (patch 0057). On a clone of the
  owner's real beta 8 profile in a scratch home (`CFFIXED_USER_HOME`) the move then held in all
  four cases: no Stedding folder, a folder holding only `Crashpad`, beta 8 running on the old
  folder (the alert, **Quit**, then the move), and a profile from the official Chromium 157
  snapshot (left alone). `PLAN.md` PLT-1 is ticked.
- **The keychain, with the real login keychain.** No macOS prompt came up on this Mac. A fresh
  profile made its own "Stedding Safe Storage" item; a profile beta 8 itself made, with a cookie
  sealed under Chromium's key, still sent the cookie after the move and on the next launch.
- **The owner's eye.** The collapsed rail put the zoom button on the page's corner (the Mac's
  rail is 80 DIP now, patch 0039, sidebar Y16), and full screen left an empty band at the top
  of the sidebar (its toggle sits on the overlay's toolbar row, patch 0057, sidebar Y17).
- **Signing.** The first run to reach the end showed Chromium's signer deleting the notarized
  app when packaging is off (patch 0051). Beta 10's macOS image is the first Stedding signed
  with the Developer ID and notarized by Apple, and it went into the existing beta 10 release.
- **Tooling on macOS 26.** `tooling/drive-window.py` refused every click, because the Dock is
  one transparent full-screen window there now; `tooling/capture-state` has light and dark seeds.

### 2026-09-29 to 2026-09-30 -- the Windows PC takes over

The Windows build machine picked the work up from the Mac on 2026-09-29 (Ryzen 9 5900XT, 32 GB) with the pin at 155.0.8059.12 and 57 patches, and in two days did what the Mac's 2026-09-28 pass could not: built the series on Windows, ran it under sanitizers, and used the product with the real pointer and keyboard.

- **2026-09-29.** `tooling/sync-chromium` got a Windows mode (18 minutes). The first full build died of memory at 32 jobs and finished at 20 to 26 (trap 54). Everything compiled but three test files (a narrow literal passed to `FilePath::Append`, a local named `far`, a Mac-only path key), and the suites passed once the tests that assumed the Mac were corrected (unit 798 of 798, browser 150 of 150 with five Windows-only tests added; trap 55). No product bug turned up on Windows.
- **2026-09-30, sanitizers.** A DCHECK build with the dangling-pointer detector (3 h 20 min) and an ASan build (trap 57: its assembler never finished until `malloc_context_size=0`) found twelve defects in a tree whose suites were green (trap 60): a light-mode contrast bug, the quiet/adaptive permission defaults, a dangling Clear line and New Tab row after the switch to horizontal tabs, views without an accessible name, and the tests' own lifetimes. All are folded into patches 0030, 0042, 0043, 0047 and 0057. Final tree: release 800 of 800 unit, 151 of 151 browser; DCHECKs and the dangling-pointer detector the same; ASan: unit 800 of 800, browser 151 of 151.
- **2026-09-30, real use.** With the owner's leave, `tooling\win\drive.ps1` drove a fresh profile with the real pointer and keyboard (trap 58): the Mac's words on Windows in the welcome flow, a tooltip and three command-bar rows (fixed); light-mode row text (fixed); three more faults logged as S-68 to S-70. Every click on every kind of row selected its tab (8 of 8 open, 7 of 7 in the rail).
- **2026-09-30, beta 9.** `v0.2.0-beta.9` (https://github.com/ysalitrynskyi/stedding-browser/releases/tag/v0.2.0-beta.9), the Windows installer alone on Chromium 155.0.8059.12, published from this PC; macOS stays on beta 8 until the Mac has built the series and proved the keychain copy and the profile migration. The installer was run as the user over beta 6, on a copy of its profile, uninstalled and installed again (`tooling/win/test-installer.ps1`); the unit sweep and the browser suite passed on the exact image (800 of 800, 151 of 151). Open after it: S-68 to S-71, Win+V's own list, the Mac-only Phase 0 items, signing and updates (S-56).
- **2026-09-30, beta 10.** `v0.2.0-beta.10` (https://github.com/ysalitrynskyi/stedding-browser/releases/tag/v0.2.0-beta.10), the Windows installer on the same Chromium 155.0.8059.12 as beta 9, after the operator's screenshot of the address bar: the field was a pill of about 220 px in a window of 1688 and a click left only the bare host selected. Now the whole address shows always (Chromium's "Always show full URLs" registered on), the host in the text colour and the rest a step dimmer, and the field takes the row with the address gathered on the page's centre (toolbar T28 to T30, PLAN.md WIN-29); the command bar stays inside a narrow window (S-68, K20). Because the file version is the pin's, it installs as a repair and needs Stedding closed (S-72, trap 62). Built on the operator's word although PLAN.md would have queued it. The gates: 802 unit and 153 browser tests on the exact build and again on a build with DCHECKs and the dangling-pointer detector on (3 h 49 min from nothing, still the long pole); the installer run over the installed beta 9 as a repair, with the operator's Stedding closed (the file version is the pin's, so it replaced `chrome.dll` in place); the installed build opened on a fresh profile and on a copy of the real one. AddressSanitizer was not re-run: the change adds an integer to a view.
- **2026-09-30, the method.** The owner asked what the work did inefficiently. `AGENTS.md` and `docs/AGENT-LOOP.md` were rewritten around the answer (ask once, order of evidence, supervise long jobs, one pass that finds every failure), `docs/HANDOFF.md` gained the fast path and a trap index, and the machine-wide agent notes got a *Long jobs* section.

### 2026-09-26 to 2026-09-29 -- the audit, the owner's decisions and patch 0057

- **The audit (2026-09-26).** Sixteen review units read every file the series of 52 patches
  changed, each twice; 353 root-cause clusters stood after verification, every one a reading
  of the code, nothing built or run. It became `PLAN.md`, whose section 1 keeps the verdict
  as written. The owner answered its questions the same day (the decisions at the top of
  `PLAN.md`): horizontal tabs stay, Peek off until rebuilt, sleep at Never, every cut approved.
- **Patch 0057 (2026-09-28 and 29).** Patches 0053 to 0056 had claimed the plan done without
  being built. 0057 finished Phase 0's code and proved it on a real build of the pin: on the
  series pushed on 2026-09-29, `stedding_browser_tests` 146 of 146 and the unit sweep 809 of
  809, with real windows throughout (clicks on every kind of row and the rail, drags onto
  folder headers and Space chips, Space switches by every path, three restarts, the cookie jar
  of every way a tab opens, the archive, little windows, the sleep gate, search defaults,
  HTTPS-First, the private coat, the horizontal strip) and each change seen to fail with its
  fix taken out. The items it closed are ticked in `PLAN.md` section 4.
- **Found and fixed on the way:** a folder row reading a freed folder as a window closed (a
  crash, TAB-8); closing a Space's last tab briefly activating another Space's tab (spaces
  B4); Settings' sidebar-hover switch bound to a preference M155 renamed; a Space chip taking a
  tab group's header; a restored Blank Window following the Spaces; `tooling/capture-state`
  never capturing, because Chromium made the app frontmost (trap 29); a command bar row that
  turned Peek on; new tabs made during a Space switch filed in the Space being left.
- **Left for others:** the owner's own steps, a Windows build, the sanitizer builds,
  VoiceOver, the Keychain prompts and the owner's decisions; `PLAN.md`, "Where Phase 0
  stands", tracks each.

### State of the project, up to 2026-09-28

**Feature work is well past M1** — the milestone ladder in `docs/ROADMAP.md` is
being executed out of order on purpose, chasing operator feedback on real
builds. The patch series sits on the pin; unsigned beta pre-releases go to
GitHub Releases. `tooling/dev status` prints the real counts (patches, tests
per feature, pin); do not type them here.

What "working" means here: **a behaviour is done when its "Done when" check passes
on a real build** (`PLAN.md` §2). A green unit test alone proves nothing about what a
user sees, and captures prove pixels only: the old rule ("shipped when its test is
green") let broken basics ship, such as rows that would not select on click. The
September 2026 audit of the whole series is `PLAN.md`; it lists what is broken in
each feature below and the order of repair.

Built, by the old measure (each has open findings in `PLAN.md`):

- Arc-proportioned sidebar: essentials row, per-Space pins, Clear line,
  44 px rows, 18 px favicons; floating content card; centred bare-host URL;
  33 px toolbar.
- **Spaces**: switcher with floating hover names, per-Space tint, context-menu
  icon/rename/colour/delete, drag-tab-onto-Space, persistence (`decisions/0015`).
  Core semantics — membership on open, active tab follows the switch, delete
  moves tabs — landed as patch 0004 with `space_model_window_unittest.cc`.
- **Folders with nesting**: create from tab context menu, drop a dragged tab
  on a folder header (patch 0008), collapse, inline rename, session
  persistence; the close-path use-after-free is fixed and regression-tested.
- **⌘T command bar** across Spaces, also behind the sidebar's New Tab row.
  Stedding colours (sand light, blue→plum gradient dark). Codecs verified.
  Sign-in promo removed; DuckDuckGo default search; the new tab page is
  local (hint line, no Web Store tile) and the omnibox has no Google entry
  points; chrome://settings has no Google or AI sections and carries the
  Stedding mark. Mac updater stubbed
  (no Keystone) pointing at GitHub Releases.
- **Peek**: switched off, and its setting hidden, while its host is rebuilt
  (`PLAN.md` CMD-9, CMD-10; `docs/features/peek.md`).
- **Settings**: a "Stedding" section first in chrome://settings, one control
  per Stedding preference, plus the window's Spaces to rename or delete
  (`docs/features/settings.md`).
- **Auto-archive**: unpinned tabs outside folders that nobody has looked at
  for 12 hours (a setting) close into the recently-closed list
  (`docs/features/archive.md`).
- **Round 5 Arc parity** (`docs/history/archive.md#the-operators-rounds`): the bar sits on the page and
  takes its colour, the Space title heads the list with its pinned run and
  the Clear line, ⌘S toggles the sidebar, ⌘T classifies and suggests,
  downloads at the bottom-left, the sidebar edge drags, a swipe changes Space.
- **Screenshots**: ⇧⌘2 the page, ⌥⇧⌘2 a region, ⇧⌘1 the full document; PNG
  to Downloads and the clipboard (`docs/features/screenshot.md`).
- **Welcome flow**: `chrome://stedding-welcome` over a profile's first window:
  search engine, import, appearance, default browser, shortcuts
  (`docs/features/welcome.md`).
- **Round 6, wave 1** (`docs/history/archive.md#round-6-plan`, patches 0016–0018): Arc's keys for
  Spaces (⌃1–9, ⌥⌘←/→, ⌘D pins, ⇧⌘K clears, ⌥⇧⌘←/→ moves the tab) and a
  Spaces menu in the menu bar; ⇧⌘C copies a clean link, ⌥⇧⌘C a Markdown one;
  the close glyph only on hover, alerts as a corner badge on essentials; the
  shortcut reference in chrome://settings/stedding; the status pill and the
  find bar inside the card, no ring around split panes; the capture and
  copy-link toasts; motion follows macOS Reduce Motion and a setting; the
  About line reads "Stedding <VERSION> · Chromium <pin>"; Space swatches on
  the welcome flow; the address row takes the page colour on either side of
  the contrast line (toolbar T7) and sits in a 6 DIP gutter like the card's
  other three sides.
- **Round 6, wave 2** (patches 0019–0025): sleeping tabs with one dimmed look,
  Sleep Tab / Sleep Others and a Space that sleeps after the user leaves it;
  rename in place that survives restore; row numbers while ⌘ is held; verbs
  that act on the selection with plural labels; Stedding's short tab menu
  with Chromium's behind a setting; Arc's pinned-tab lifecycle (a home URL,
  ⌘W sleeps, the drifted dot, the favicon reset, the menu rows, peek reads
  the stored site); the switcher's overflow dots and Move Left / Move Right;
  download progress on the sidebar button; the command bar's actions mode
  (⇥, a leading ">", ⇧⌘P: Stedding's own commands with their chords, ⌘L
  with the URL selected); ⌃⇥ through the Space's most recent tabs with a hold-to-see
  strip, ⌥⇧⌘↑/↓ moving the row folder-aware; the page and app menus without
  Google's rows, Import, Screenshot and Spaces in the app menu, a menu per
  row kind and for the folder header, Move to Space; a chip drag reorders
  the Spaces; a split's panes take a Space, a pin and a sleep together.
- **Round 6, wave 4** (patches 0034–0036, complete): private windows wear a
  different coat (`docs/features/private.md`); the little window for links
  from other apps (`docs/features/little.md`); one sidebar for every window
  through the SpaceRegistry (`docs/features/windows.md`, ADR 0016); ADR 0016 (the SpaceRegistry)
  and the specs for the little window and one sidebar for every window
  are written (`docs/features/little.md`, `docs/features/windows.md`).
- **Round 6, wave 3** (patches 0026–0033, complete): Import from Arc — Spaces,
  essentials, pins and folders from Arc's sidebar file, every tab unloaded
  (`docs/features/import.md`); routing — a site opens in the Space it is
  routed to, with a toast that undoes it (`docs/features/routing.md`); the
  archived view — what auto-archive, Clear and a close left behind, by day
  and Space, restorable (`docs/features/archive.md` A7–A11); the address
  row hides with the sidebar, ⇧⌘D shows it on its own
  (`docs/features/toolbar.md` T8–T12); the tracker-free defaults and the
  Privacy block (`docs/features/privacy.md`, ADR 0017); sidebar density
  presets and a text size (`docs/features/sidebar.md`); imported bookmarks
  become pins on demand from ⌘T, and a Space exports to a file in the importer's
  format and imports back (`docs/features/import.md` I13–I20; the hourly backups
  were cut in patch 0055).
- **Round 7** (2026-09-05, `docs/history/archive.md#the-operators-rounds`; patches 0037 and 0038, with a
  second pass the same evening on the operator's replies): the row is the page's
  colour exactly, square under it, the address centred on the row in a field with
  no chrome around it, 560 DIP where the row has the room and shrinking when it
  does not (toolbar T15–T18); the collapsed rail centred and the sidebar's toggle
  on the traffic lights' own centre (sidebar Y6–Y7); Arc's folder row — macOS's
  own folder symbol, the header, the New Tab row and the Space title on the tab
  rows' column — and the drifted-pin row (folders F12, pins H12); the folder quit
  crash; the keychain item under Stedding's own name (import I24); Arc's history
  and passwords in one click from the welcome flow (import I6, I21–I23, welcome
  W8). Two of Chromium's own suites had been red since patch 0002 because nothing
  ran them: they now assert what this fork does (`docs/HANDOFF.md`, trap 31).

- **Round 8** (2026-09-08, `docs/history/archive.md#the-operators-rounds`; patch 0039): the series built
  and ran on Windows for the first time -- nine `FilePath` portability fixes, then
  the operator's look at it, in four passes the same day. The address row under
  Windows' caption buttons with their glyphs in its colour and the buttons on the
  row's centre line; the focused bar and the dropdown in the page's colour; the
  row's colour surviving a reload; the rail's rows 44 DIP squares, centred, the
  switcher stacked, the hover overlay opaque. Three of them reach the Mac: a
  profile killed while collapsed crashed on every launch (the crashed-session
  bubble, toolbar T23), the address field could sit over the back button in a
  narrow window (toolbar T18), and the rail itself. Chrome's registry key for
  extensions is no longer read (privacy Q9). Verified on captures the tooling
  took itself with no focus and no input (`tooling/win/capture.ps1`, trap 36);
  the card measures the mac's geometry to the pixel. Not a port (M8, `S-56`):
  branding and the macOS chrome are `is_mac`.
- **M8, first slice** (2026-09-09; patches 0040–0041, ADR 0018): the collapsed
  rail expands on hover after a pause the user sets, 2 s by default, a click in
  the rail restarting it (sidebar Y11, settings T11); Windows knows the build as
  Stedding -- the name, the icon, `%LOCALAPPDATA%\Stedding`, its own registry
  keys, COM classes and sandbox prefix, so it lives beside a Chromium install
  (windows N3–N4); `tooling/apply-branding` runs under Git for Windows and the
  product-name rewrite reaches every locale; `tooling/win/build.ps1`,
  `package-installer.ps1` and a `publish-release` that joins a release across
  platforms make Chromium's `mini_installer` the Windows image, built, installed
  and uninstalled on the build machine (windows N6) and published with beta 5 as
  a preview. Chromium's field-trial testing config is off in every build from
  now on and the 2026 refresh it carried is on by decision (privacy Q10, patch
  0042). Still to come: little windows and links from other applications;
  unsigned; no updates (`S-56`).

- **Round 9** (2026-09-09, `docs/history/archive.md#the-operators-rounds`; patches 0043–0045): the
  operator's first three minutes in the Windows preview. Arc's keyboard for
  Windows -- ⌘ read as Ctrl, ⌥⌘ as Ctrl+Alt, Alt+1–9 for the Spaces (windows
  N7) -- with the shortcut reference reading the platform's own table on every
  platform (shortcuts Z6) and the settings and welcome strings in the
  platform's words; the local new tab page for Google too (`S-45` closed), no
  API-keys infobar (welcome W9), no Chromium theme picker (settings T12); the
  rail's rows 6 DIP apart, the Space title its glyph alone, the switcher's
  stack measuring itself so a Space added in the rail keeps the "+" on
  screen, no floating name over the downloads button (sidebar Y12–Y14).
  Published as beta 6 from Windows.

- **The Mac pass on beta 6** (2026-09-10, `docs/history/archive.md#the-operators-rounds`, *The Mac pass*):
  the checkout had been deleted for disk and was re-synced (HANDOFF trap 44); the
  first macOS build of the Windows-written patches needed a guard on a Windows-only
  colour id and a UTF-8 export file name (fixups into 0039); the first multi-tab
  capture showed every inactive sidebar row filled -- Chromium's field-trial
  testing config had been hiding that in every beta up to 4, and beta 5 was the
  first build with it off (privacy Q10) -- so the mixer pins inactive rows
  transparent (tabs R23, fixup into 0042); the release sweep grew
  `tooling/dev test upstream` and seven of Chromium's own cases now assert what
  this fork does. The macOS image joined beta 6 that day; the README's captures
  are from it.
- **Independent sessions and the keep-pile** (2026-09-16 to 18; patches 0046–0048,
  ADR 0019, ADR 0020; `docs/features/sessions.md`): a Space can keep its own
  cookies, cache and site data in a Chromium `StoragePartition` -- the chip menu's
  check item, a toggle in Settings → Stedding, a row in ⌘T -- with essentials on
  the shared jar, a moved tab rebound with its history and name (asleep stays
  asleep), Clear Independent Session on the chip menu, the jar wiped when the
  Space goes, and off-then-on reattaching the same jar. With it: keyword search
  and `@Space` in ⌘T, a split that renames as one (Chromium itself restores the
  pair), host and host-suffix routes, Focus and Hide Other Spaces. The 2026-09-18
  audit of those two patches (HANDOFF trap 46) found seven helpers with tests and
  no surface; patch 0055 cut them.

Released: `v0.2.0-beta.4` (2026-09-05, published from this repo with
`tooling/publish-release`), unsigned (M7 waits on Apple). It carries rounds 5,
6 and 7, the round-7 second pass included. Published from Windows: `v0.2.0-beta.5`
(2026-09-09, round 8 and M8's first slice, the Windows preview installer alone)
and `v0.2.0-beta.6` (`docs/release-notes/archive.md#stedding-020-beta-6`, 2026-09-10, round 9:
the Windows keyboard map, the first start, the rail); the DMG and its checksum in
the notes were the Mac's to add to beta 6, and it did on 2026-09-10 -- after
re-syncing a checkout that had been deleted for disk (`docs/HANDOFF.md`, trap 44),
with two fixups into patch 0039 that the first macOS build of the Windows-written
patches turned up (`docs/history/archive.md#the-operators-rounds`, *The Mac pass*). Beta 5 stays a
Windows-only preview. Signing: the Developer ID certificate and the notary profile
exist since 2026-09-23, and the signer works end to end (`S-17`, patch 0051).
The pin is 155.0.8059.12 (2026-09-24, `S-64`: Google's early-stable build of M155,
taken straight from M153 because the owner wants the newest stable-channel build,
ADR 0007); `tooling/dev status` counts the series on it. `v0.2.0-beta.8` is the Mac image of the
previous pin, 153.0.8010.53, and `v0.2.0-beta.7` (153.0.8010.48) the one before. Outstanding:
`BACKLOG.md`. First vanilla perf comparison is in
`docs/perf/README.md`: on the deterministic page list every QUALITY budget is
met (cold +2.3%, warm −2.0%, memory +0.0% over vanilla).


### The hand-over note of 2026-09-28 (summary)

The note left on the Mac before the PC took over said: read `docs/HANDOFF.md`, then
`PLAN.md`; nothing is released until Phase 0 is done, and the profile migration and the
keychain copy are proven on a real beta 8 profile first; the sanitizer runs wait for a
second output directory; never edit the checkout while a build runs, and never inject input
while someone is at the machine. All of it was done or replaced in the days after: the
sanitizer runs on the PC on 2026-09-30, the migration and keychain on the Mac on 2026-10-01,
releases from beta 9, and real input with the operator's yes through a guarded driver
(`docs/HANDOFF.md`, trap 27).

## Round 6 plan

**Round 6 — Zen mods and beyond: the plan**

> **History.** The record of round 6 (2026-09-04 and 05), kept because the patches of that
> round (0016–0036), most feature specs and ADRs 0016 and 0017 cite its parts by id (R6-nn,
> D1–D11). It is not a list of work: what is still open from it is a row in its feature's
> spec under `docs/features/`, and the order of work is `PLAN.md` and `BACKLOG.md`. Some
> things it planned were cut on 2026-09-26 (`PLAN.md`, decision 4: the sidebar backups of
> R6-29 and the little window's idle close of R6-30 among them), the Space sleep timer's
> default of 15 minutes became Never (decision 3), and Peek is off until it is rebuilt
> (decision 2).

Date: 2026-09-04. Status: **complete** (2026-09-05): every wave landed as patches 0016–0036; the landing note under each part says what changed on the way. Backlog row: `S-44` (done).

This is the plan for round 6 of Stedding: the round that mines the 77 community mods
of Zen Browser (https://zen-browser.app/mods/, fetched 2026-09-04) for the needs they
reveal, adds what Arc parity still lacks, and turns the result into numbered behaviours
with test ids, the way every feature spec in `docs/features/` is written. A behaviour
here is a plan until its test is green on the pinned tree (`docs/AGENT-LOOP.md`).

How it was produced, in one line: a workflow ran eight evaluators over the 77 mods
(each mod: the need behind it, what Stedding has, evidence from the tree, a proposal that
is better than the mod), three idea lenses that each wrote ten ideas beyond the catalogue,
three judges that scored the 84 candidates the synthesis listed (score, verdict, reason),
one synthesis that folded 107 candidates into 24 plan items and 60 skips, one
completeness critic that read the synthesis against PRODUCT.md, QUALITY.md, PRIVACY.md
and the tree, and then the orchestrator's decisions (D1–D11 below), which override the
synthesis where they differ.
Every number in this file comes from that material or from the repo; where the material
is silent the cell says TBD.

### How it was worked

The round's rules, kept for the citations below. One item at a time through the loop
(`docs/AGENT-LOOP.md`), each item's rows copied into its feature spec as `planned` before
its failing test. Round 6's patches started at 0016, one per item family, numbered in
landing order, with fixups only into round-6 patches (D11). A row shipped without a test
was a `gap` with an `S-` id in `BACKLOG.md`; rows marked `draft` were written from the
critic's text and checked against Arc before their failing test. Rule 7: every new surface
was captured in dark and light with a probe (QUALITY; critic #30) and named a VoiceOver
role and a keyboard-only path in its spec before it was `built` (QUALITY accessibility
gate; critic #31). Paths below are relative to the Chromium checkout or to this repo, and
`file:line` numbers were read on the pinned tree on 2026-09-04.

### Decisions

The orchestrator's decisions. Each overrides the synthesis JSON where they differ; the
reason follows the decision.

**D1 — Waves, not one list.** The synthesis delivered 24 items in one order with a dense conflict graph (every item names the files it shares with others). Round 6 ships in four waves. **Wave 1** (small, high value, no ADR): the shortcut reference block in chrome://settings/stedding (critic #6) first, because items cite it; then plan items 2, 9 (with the audio-badge bug folded in, critic #8), 5, 19, 20, 21, 24, S-43 (About version label) and S-42 (a five-swatch Space colour on the welcome appearance step). **Wave 2**: items 1, 3, 4, 6 (with critic #1 Space-scoped Close Others / Clear Below, #14 the tab-group chords removed in the same hunk, #15 four menus), 7, 8, 10, 14 (with critic #10 Space reorder by dragging a chip plus a menu Move left/right), a new `splits.md` spec (critic #5), a selection rule (critic #4), S-41. **Wave 3**: items 11 (with critic #19's mapping rules), 12, 13, 18, 22, 23, plus two new items: imported bookmarks become pinned tabs and folders (critic #3) and sidebar backups/export/restore sharing item 11's file format (critic #7). **Wave 4** (needs an ADR first): 15, 16 (the ADR must say a registry Space can carry a profile id, critic #9), 17. Reason: wave 1 settles the hunks the M-sized items pile onto (IsChildVisible, the colour mixer, the accelerator tables) and gives every later item one place to record a divergence; wave 2 is the model work the other specs cite (selection, splits, the command bar's action variant); wave 3 needs rows from waves 1–2 (the importer records home URLs through H1, the archive needs Clear inside SpaceModel through B20, the hidden address row needs actions mode); wave 4 changes ownership (a profile-level registry, popups as little windows, OTR gating in browser_window_features.cc) and starts with an ADR. The three backlog rows S-41, S-42, S-43 had no owner in the synthesis (critic #11); they have one now.

**D2 — ⌘L opens the command bar (K12).** ⌘L opens the bar prefilled with the page URL selected; Escape returns to the page; the address row stays as the page's top (the operator's round-5 design, ARC-ROUND2 round 5 #5) and a click on its URL text also opens the bar. Item 18's T9 (a floating omnibox pill summoned by hover or ⌘L) is dropped; T8, T10 and T11 stay. Reason: critic #2. PRODUCT §3 says the bar "opens targeting the current tab's URL" on ⌘L and that there is no always-visible URL bar at 1.0; items 1 and 18 were both built around ⌘L staying on the omnibox, so T9 was work 1.0 would delete. The skipped "Cleaned URL bar" and "Add new tab urlbar icon" also hinged on this route.

**D3 — Multi-select is one cross-cutting rule.** When more than one row is selected (⌘-click, ⇧-click), every verb acts on the selection (close, pin, move to Space, sleep, mute, move to folder, archive) and menus show plurals ("Close 3 Tabs"); rename is the exception. The rule is written once (R6-20) and each item's spec cites it instead of restating it. Reason: critic #4. PRODUCT §12 lists multi-select as [1.0]; item 6's menu showed no plurals and items 1, 2 (⌘D), 5, 7 and 12 all said "the active tab"; TabMenuModel already reads selection_model() (tab_menu_model.cc:111), so the cost is in the specs, not the model.

**D4 — ⌘D on an essential is a no-op; Space chords are off where there are no Spaces.** ⌘D on an essentials (Chromium-pinned) tab does nothing and the menu row is disabled; ⌃1–9, ⇧⌘K and the Space commands are disabled in private and popup windows. Reason: critic #13. B21 said nothing about the essentials tier while F8 already refuses folders for pins; a no-op with a disabled row is the answer that loses nothing. Popup windows have no Spaces (B14) and private windows will have none (V2), so the controller must say so or the chords act on a model that is not there.

**D5 — ⌃1–⌃9 and Mission Control: no remap.** ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N" once a second desktop exists. The Spaces menu rows (B23) make the chords discoverable and reachable when macOS eats them, and the shortcut reference notes the collision (Z3); nothing is remapped now. Reason: critic #12. Arc ships the same chords and its users hit the same collision; remapping is PRODUCT §12 [1.0] and out of round 6 (Z5).

**D6 — Item 1 details.** ⇥ with text typed filters that text to actions (Arc), ⇧⇥ goes back; Escape in actions mode returns to tabs mode and a second Escape closes; private and popup windows list Chromium's actions only; a row whose target is absent (Move to Space for an essential, a peek open) is hidden; dropdown preferences appear as cycling rows ("Archive after: 12 hours ▸"). Reason: critic #16. K8–K11 covered the empty-bar entry only; "one on/off row per stedding.* preference" could not express the archive hours, sleep minutes or density dropdowns.

**D7 — Row numbers (item 4).** Essentials cards show the number in a corner badge, the collapsed rail beside the icon; a split row counts as one; sleeping rows are numbered like the rest. Reason: critic #17. R11 placed the badge in the close-button slot, which essentials cards (a grid) and the collapsed rail do not have; the split and sleeping cases were unsaid.

**D8 — Pinned lifecycle (item 8).** A click on a drifted essential activates it and the reset appears on hover (Arc); ⌘W on the last visible tab of a Space that holds only pins sleeps it and the Space shows its new-tab row (B4): intended. Reason: critic #18. An essentials card is icon-only, so H5's "favicon column" is the whole card and a click would have reset instead of activated. The critic's unsure line asks for a side-by-side check in Arc before H5/H10 are written; H10 records that check as the first step.

**D9 — Arc import (item 11).** Split-view items become split rows, archived items go to the archive (item 13), the per-Space profile binding is dropped and named in the import summary; the importer reads a copy of the file and warns if Arc is running; windowTheme maps to the nearest Stedding swatch; favorites are capped at 12; a second import is idempotent, keyed by Arc's item id. Reason: critic #19. Arc's sidebar JSON holds those three item kinds beyond tabs, lists and containers; Arc rewrites the file while running; nothing in the tree caps essentials.

**D10 — Extension actions, the media button and page info when the row is hidden (item 18).** They live in the command bar's actions mode; ⌘E cycles extension actions as PRODUCT §12 says; page info opens from the URL text in the bar. Reason: critic #20. T8 removes the row those controls sit in; Arc parks extensions in its sidebar; with D2 the bar is where the URL text is, so page info follows it.

**D11 — Not implementing now.** This document is the hand-off. Implementation follows `docs/AGENT-LOOP.md` per item (spec row → failing test → build → capture → patch), one new patch per wave-1/2 item family with numbering continuing from 0016, and fixups only into the round-6 patches. Reason: `docs/HANDOFF.md` trap 13 (the 2026-09-04 fold: an autosquash into an old patch conflicted, the abort left the branding stash unpopped and every later build made `Chromium.app`) and the round-5 fold itself (commit `d307cc6`, `git log --grep='round 5'`): fixups into the old patches conflicted with later patches touching the same lines, so that round became one new patch; a round-6 patch has no such history.

### Waves

Ids are `R6-NN` in wave order. Plan-item numbers (1–24) are the synthesis's; the map:

| Plan item | Id | | Plan item | Id | | Plan item | Id |
|---|---|---|---|---|---|---|---|
| 1 | R6-11 | | 2 | R6-02 | | 3 | R6-12 |
| 4 | R6-13 | | 5 | R6-04 | | 6 | R6-14 |
| 7 | R6-15 | | 8 | R6-16 | | 9 | R6-03 |
| 10 | R6-17 | | 11 | R6-22 | | 12 | R6-23 |
| 13 | R6-24 | | 14 | R6-18 | | 15 | R6-30 |
| 16 | R6-31 | | 17 | R6-32 | | 18 | R6-25 |
| 19 | R6-05 | | 20 | R6-06 | | 21 | R6-07 |
| 22 | R6-26 | | 23 | R6-27 | | 24 | R6-08 |

Effort is the synthesis's (S/M/L). "Source" names the mod or idea and the judges' average
over three scores (Appendix C). Status is `planned` for every row until its test is green.

#### Wave 1 — small, high value, no ADR

| Id | Name | Source | Effort | Setting | Shortcut | Status |
|---|---|---|---|---|---|---|
| R6-01 | Shortcut reference block in chrome://settings/stedding | critic #6 (QUALITY.md "UX completeness" 1, ROADMAP.md M6 scope) | S | a "Shortcuts" block (no preference) | none (it lists them) | planned |
| R6-02 | Arc's keyboard for Spaces | idea "Arc's keyboard for Spaces" (judges 8.67, build×3) | S (M with the Spaces menu) | none | ⌃1–9; ⌥⌘←/→; ⌥⌘↑/↓; ⇧⌘K; ⌘D; ⌥⇧⌘←/→ | planned |
| R6-03 | Close glyph only on hover or focus (Arc's active row) | mod "Only Close On Hover" (judges 7.33, build×3); Improved Collapsed Tabs' rail rule (R3); the audio-badge bug from Bigger Mute Button, Audio Indicator Enhanced and Audio TabIcon Plus (critic #8) | S | none | none | planned |
| R6-04 | ⇧⌘C copies a clean link, ⌥⇧⌘C a Markdown link with a rich-text twin | idea "⇧⌘C copies the URL, ⌥⇧⌘C copies a Markdown link with a rich-text twin, and the bar says Copied" (judges 6.67, build×2, maybe×1) + idea "Copy clean link on Shift-Cmd-C, Markdown on Option-Shift-Cmd-C" (judges 6.67, skip×1, build×2), merged; Zen Context Menu's tracking strip | S | stedding.copy.strip_tracking | ⇧⌘C; ⌥⇧⌘C | planned |
| R6-05 | No ring around split panes | mod "NoHighlightSplit" (judges 6.33, build×3) | S | none | none | planned |
| R6-06 | Card-native link status pill and find bar colours | mod "Floating Status Bar" (judges 5.67, skip×1, build×2); mod "Better Find Bar" (judges 5, skip×1, maybe×1, build×1): the mixer mapping and edge alignment; idea "Card-native find bar and link status" (judges 5.67, build×1, maybe×2): the pill; the find-bar reposition and the three-way setting dropped; Custom Statusbar (critic #33) | S | none | ⌘F | planned |
| R6-07 | Capture toast on Chromium's toast framework (S-40) | mod "smaller zen toast popup" (judges 6, build×3); backlog S-40 | S | none | none | planned |
| R6-08 | Motion follows the system | idea "Motion follows the system" (judges 5.67, build×2, maybe×1) | S | stedding.ui.animate | none | planned |
| R6-09 | About page version label (S-43) | backlog S-43 (round 5 audit, 2026-09-04) | S | none | none | planned |
| R6-10 | Space colour on the welcome flow (S-42) | backlog S-42; mod "Zen Colored Picker" (judges 5.33, build×1, maybe×1, skip×1): the five-swatch part | S | welcome step 3 swatches | none | planned |

##### Wave 1 — landing notes (2026-09-04)

Decisions taken while implementing, where the rows above left room or the tree
said otherwise. Each is also in the item's spec.

- **R6-01.** The model (`stedding::ShortcutReference()`) lives beside its handler in
  `chrome/browser/ui/webui/settings/stedding_shortcuts_handler.cc`, Mac-only, and reads
  chords through `GetDefaultMacAcceleratorForCommandId` (both Mac tables, one call). The
  peek's ⌘O / ⇧⌘O are view accelerators, not commands, so they moved into
  `chrome/browser/ui/views/peek/peek_accelerators.h` and the model reads them from there.
  One divergence row carries a literal chord: ⇧⌘D, which Stedding binds to nothing (B21).
  The "Show keyboard shortcuts" ⌘T action waits for R6-11 as planned.
- **R6-02.** Chromium's Mac build bound pane focus to ⌥⌘↑/↓ only; those keys now traverse
  tabs, so F6 / ⇧F6 were added for pane focus, as on the other platforms (B19 says so).
  `SpaceModel::SetSpacePinned` moves a newly pinned tab under the Clear line itself, so
  the context menu and ⌘D share one path. The Spaces menu's pin row reads "Pin Tab in
  This Space", shows a check while pinned and is disabled on an essential
  (`BrowserNativeWidgetMac::ValidateUserInterfaceItem`, B28). `spaces::SpaceCommandState`
  keeps Space N enabled only while N Spaces exist (B23) through a callback into the
  command updater. Strings for the menu bar needed real ids: `chrome/app/stedding_strings.grdp`
  is the one part for every Stedding string (HANDOFF trap 14).
- **R6-03.** The rules are pure functions (`stedding_tab_row_rules.cc`), tested as
  `TabRowRulesTest.*`; the layout asks them. The close slot is reserved on every expanded
  row, not only the active one, so no row's title ever re-elides on hover. The badge is the
  alert indicator at the card's bottom-right corner, 2 DIP in; click-to-mute keeps
  upstream's width rule.
- **R6-04.** `chrome::CopyURL` now routes through `stedding::CopyLink`, so the app menu,
  the tab menu and ⇧⌘C all strip and toast. The Markdown twin writes the text plus an
  anchor through `ScopedClipboardWriter::WriteHyperlink`. Title: the page title, else the
  host. Inside a peek both chords copy the peek's page (the peek view owns them).
- **R6-07.** Placement (critic #21): Chromium's anchor stays, top-centre of the page card,
  straddling the bar/card seam; Arc's bottom placement would need a second anchor view and
  is not worth a hunk in `ContentsContainerView` now. A toast's colours come from the
  dialog surface; the "Show in Finder" action reveals the last saved capture.
- **R6-08.** `stedding::ShouldAnimate(prefs)` gates `BrowserAnimationController` (every
  sidebar motion), the toast's entry and exit, and the tab hover card; the hover card's
  gate is static in upstream, so it honours the system and the capture parameter but not
  the preference. The welcome page's two CSS transitions follow `prefers-reduced-motion`.
- **R6-09.** `tooling/build-chromium` writes `stedding_version = "<VERSION>"` into
  `args.gn`; a buildflag header carries it; the About line keeps the "(arm64)" suffix.
- **Live checks, 2026-09-05.** ⌃2, ⌥⌘→/←, ⌘D and ⇧⌘K verified through `tooling/drive`
  (Space 2 activated, the pin moved under the Clear line, Clear kept the pin). ⇧⌘C could not
  be verified by keystroke on the operator's Mac: the clipboard manager Maccy owns ⇧⌘C as a
  global hotkey there, so the chord never reaches any browser (Arc's ⇧⌘C loses the same way).
  Copy Link was verified through the File menu instead (the link came back stripped). The
  chord stays ⇧⌘C for Arc parity; the copy-link spec records the collision.
- **The card gutter (operator, 2026-09-05 01:10).** "Make sure the distance from the top to
  the address bar is the same as the right and bottom borders, and a little smaller": one
  parameter, `card_gutter` (6 DIP, was 8 at the right and bottom and 0 at the top), insets the
  card on three sides and moves the address row down by it; the find bar follows.
- **T7 (toolbar).** Landed with wave 1: `PageBarColorSupplier` on the window's colour key.
  Verified live in light mode: a page with a dark `theme-color` turns the row dark with light
  icons and URL text; example.com keeps a light row with dark icons.
- **R6-10.** The welcome page is not a tab, so `stedding::WelcomeHost` (WebContents user
  data set by the dialog) is how its handler reaches the window's `SpaceModel`; the five
  colours moved to `chrome/browser/ui/spaces/space_colors.h` so the switcher and the flow
  share them. Step 5 gained ⌃1–9, ⌘D/⇧⌘K and ⇧⌘C rows and the link to the reference.

- **Gutter follow-up (2026-09-05, morning).** The first build put the address row 12 DIP
  down with its bottom 6 DIP clipped: `CalculateTopContainerLayout` lays the toolbar out
  in the top container's own coordinates, so insetting `visual_client_area` at the top
  moved both the container and the toolbar inside it (the same double offset the strip
  inset already corrected for x). The container now starts at the window's top edge and
  grows by the gutter. The 1 DIP line between the row and the page
  (`MultiContentsView`'s top separator, `kColorToolbarContentAreaSeparator`) is off under
  the Stedding card: it ran across the gutters as a light hairline on the mat. Measured
  on `tooling/probes/window.json` (23 probes): row from y=6, page from y=38, mat 6 DIP on
  the left, right and bottom, no line.
- **The plus glyphs (operator, 2026-09-05 01:15).** "Replace the + sign too, looks too
  small and weird now." The New Tab row and the switcher's new-Space button drew a text
  "+"; both are `vector_icons::kAdd2Icon` now (the wider Material plus; `kAddIcon` from
  `chrome/app/vector_icons` has shorter arms), the row's at the favicon size in the
  favicon column, the switcher's at the chip glyph size plus 2, both in the row/label
  secondary colour.
- **Seen on the way.** With Google chosen on the welcome flow's first step the new tab
  page becomes Chromium's first-party page (Google logo, Gmail/Images, "Customize
  Stedding"), not the local third-party page S-21 promised for every provider. Logged as
  S-45; not part of round 6.

- **Live checks, 2026-09-05 (second pass, every wave-1 surface).** Through
  `tooling/drive` with the operator away: the link status pill inside the card (U1), the
  hovered row's close glyph and the active row without one (R1), a playing essentials
  card's corner badge in dark and light (R18), ⌥⇧⌘→ moving the tab and following it
  (B22), the Spaces menu with Space 7–9 disabled past the count (B23), the shortcut
  reference in dark and light with the divergence rows and the Mission Control note
  (Z1–Z3), settings search finding it and the welcome link opening it (Z4), the About
  line in both modes (T10), the ⌘F bubble in dialog colours at the card's right edge in
  both modes (U3–U4), a split with no Material ring (U6, U8), the capture toast (C5) and
  the "Link copied, tracking removed" toast (L5), github.com in light mode with a dark
  row and light icons (T4/T7), the welcome swatches (W7's UI). Three things the pass
  found: the reference named ⇧⌘] against "Focus the next pane" because `ChordFor`
  returns the menu's binding first (fixed: divergence and tab rows read the table's
  ⌥⌘↓/↑ through `TableChordFor`, with a test); choosing a swatch on a fresh profile
  tinted nothing, because the ground only took a Space colour once a second Space
  existed (spaces B31: a chosen colour tints a lone Space too, `Space::color_chosen`,
  persisted); and ⌥⌘N from the harness never reached the window, which was not key on
  the two-URL runs (grey traffic lights) — the Tab menu path opened the split, so the
  harness, not the chord, is suspect (HANDOFF trap 15).
- **Motion O2 stays partial.** Two shots 80 ms apart after ⌘S or ⇧⌘2 were identical in
  every mode: neither the strip collapse nor the toast shows an intermediate frame at
  the harness's sampling, so the capture cannot tell the gate. The gate is unit-tested
  (`MotionTest`) and the call sites are reviewed; a frame-level proof needs a faster
  capture path.

##### Wave 2 — landing notes (2026-09-05)

- **Order of landing.** Parts A–E of the wave went into the checkout together on
  2026-09-05 after wave 1's commit: R6-13 R10 (⌘1–9 skip hidden rows), R6-14 M5–M6
  (Close Others / Clear Below stay inside the Space; the tab-group chords are gone),
  R6-15 R4–R6, R8 (the slept look, Sleep Tab / Sleep Others, a Space sleeps 15 minutes
  after the user leaves it, the dropdown), R6-21 T14 (download progress on the sidebar
  button), R6-20 R20–R22 (verbs act on the selection, plural labels), R6-16 H1–H9 (the
  home URL, ⌘W sleeps a pin, the drifted dot, favicon reset, the menu rows, peek reads
  the stored site), R6-17 R14–R17 (rename in place: `stedding::TabName` on the
  WebContents, preferred by `TabUIHelper::GetTitle()`, written as session extra data
  and re-emitted on rebuild), R6-14 M1, M4 (the short menu is a separate
  `TabMenuModel::BuildStedding`, so a rebase cannot leak a hidden row into it).
- **Parts F and G, same night.** R6-13 R11–R13, R19: a `ui::EventMonitor` on the
  window watches the ⌘ key (modifier-only presses never reach a view); 250 ms later
  every visible row shows its number in the close slot (cards and the rail: a corner
  badge, the pure rule `NumberBadgePlacementFor`), the Space chips show ⌃N in place of
  their glyph, an 80 ms fade under the motion gate, any chord or the key-up hides
  them; `stedding::NumberedTabs` is the one list ⌘N and the badges share. R6-18: at
  overflow (`SwitcherOverflows`, the same metrics the row uses) the inactive chips are
  6 DIP dots in their Space colour until the pointer rests on the row; Move Left /
  Move Right on the Space menu reorder through `SpaceModel::MoveSpace`, persisted
  with the Spaces; the chip drag (B27's pointer path) is a later pass.
- **Live checks, 2026-09-05 (05:15–05:35).** The short menu with every disabled row
  greyed for the row it opened on (M1); rename in place with the field over the title
  (R14); ⌘-click selection with plural labels (R20–R21); the row numbers, the card's
  corner number and ⌃N on the chips while ⌘ is held, gone on release (R11, R19); a
  slept row at 55 % (R4); the drifted pin's dot and the favicon reset (H4–H5); twelve
  Spaces as dots that grow back under the pointer (B24–B25); the four new settings
  rows (R8, R12, M4, H9). Four things the pass taught: a right-click activates the row
  it opens on, so Sleep Tab now takes the active row after activating the nearest
  visible neighbour (R5 reworded); the switcher only hears hover on its children
  with `SetNotifyEnterExitOnChild`; an off-site link on a pin peeks (P1) rather than
  drifting it, so the drift check uses a same-site link; and the machine's input
  source reached the harness's typing (HANDOFF trap 18). The sidebar's own
  background menu (Chromium's: Bookmark All Tabs…, Unpin Tab Search, Turn off Auto
  Expanding Tabs) is untouched — a row for R6-14 M3's pass.
- **Part H, R6-11 (actions mode), the same morning.** The bar gains a second mode:
  ⇥ in the bar, a leading ">", or ⇧⌘P (`IDC_STEDDING_COMMAND_PALETTE`, in the
  not-in-main-menu table and the shortcut reference). The list is Stedding's verbs
  first — Move Tab to <Space> (one row per other Space, none for an essentials tab),
  Pin/Unpin to This Space, Move Tab to New Folder, Sleep Tab, Clear This Space,
  Next/Previous Space, New Space, the three captures, Copy Link (plain and Markdown),
  Collapse or Expand the Sidebar, Show Keyboard Shortcuts, one on/off row per boolean
  preference and one cycling row per dropdown (K17) — then every visible, enabled
  item of `BrowserActions`' registry with its label and chord. Chords for Stedding's
  rows come from the window's accelerator provider (the BrowserView; tests inject
  one). ⌘L opens the bar with the page URL selected (K12); Escape leaves actions
  mode, a second Escape closes (K14); private and popup windows list Chromium's
  actions only (K15). Not yet: "Archive idle tabs now" (the archiver has no window
  accessor), "Rename tab" from the bar (the row's view is the strip's), the
  address-row click of K12, and extension actions (K11 covers later commands).
  The live check found two things the unit tests could not: the field must claim
  ⇥/⇧⇥ from the Mac focus manager (HANDOFF trap 20) and the panel must resize on
  every rebuild path; both fixed, ⌘T-then-⇥ shows seven rows with a scroll
  indicator, ⌘L shows the URL selected. Patch 0022; 18 bar and shortcut tests.
- **Part I, R6-12 (⌃⇥), the same morning.** `SpaceModel` keeps an activation
  history per Space (X1); ⌃⇥ / ⌃⇧⇥ walk the five most recent tabs of the active
  Space through `spaces::CycleRecentTab` ahead of Chromium's `kCtrlTabMru` (off),
  a tap is one step (X2), a ⌃ held past 150 ms shows the strip — a layered child
  of the BrowserView with favicon, title and the Space's colour per cell, the
  position highlighted; ⌃ up commits, Escape cancels, a mouse press or a key
  without ⌃ commits (X3). ⌥⇧⌘↑/↓ move the row within its container: a row inside
  a folder stays inside, a folder beside a row is jumped as one row, and moves
  that touch no folder keep Chromium's group rules, so its tests stay green (X4).
  The setting `stedding.tabs.ctrl_tab_mru` (on) returns ⌃⇥ to strip order when
  off (X5); the shortcut reference lists the four chords and the divergence; the
  bar carries "Go to the Most Recent Tab". The recent list counts a split once
  (splits J2, the ⌃⇥ half). Patch 0023.
- **Part J, R6-14 (the menus), the same morning.** The page menu hides Lens, the
  Gemini rows, the QR code and reading mode under the short-menus setting (M2);
  the app menu hides the Google account, Glic, send-to-self, Customize Chrome and
  Payment rows, the tab-groups and reading-list submenus and the bookmarks-bar and
  side-panel rows, and gains Import, a Screenshot submenu and a Spaces submenu
  after Downloads (M3); the tab menu shows the rows that apply to the row's kind
  through a visibility question the collection controller answers, a split row
  arranges its panes, and the folder header gains Rename, Collapse or Expand, Move
  Tabs Out and Close Folder's Tabs (M7); "Move to Space" lists the other Spaces
  after Rename (M1's missing row). Patch 0024. Not taken: Move to Folder ▸ with
  existing folders (M1, TBD), and a browser test of the built app menu (the model
  needs a real window; the id set is unit-tested and the menu captured).
- **Part K, the small rows, the same morning.** A folder dims once every tab
  inside sleeps (tabs R7); a pin's hover card carries "Pinned in <Space> · home
  <host>" on its domain row (pins H8); a drifted essentials card shows a ↺ control
  in its corner while the pointer rests on it, and a click loads home (H10); the
  last pin's close has its test (H11); the bar's tab rows step aside while a peek
  is open (commandbar K16). Also in patch 0024: the sidebar's background menu loses
  its Google and pin rows, the short tab menu carries extension rows again, and the
  app menu's new submenus enable themselves.
- **Part L, the last of wave 2, the same morning.** A Space chip dragged along
  the switcher row lands on the nearest chip's place and the model moves it (B27,
  `SwitcherDropIndex`); a split's panes take a Space, a pin and a sleep together
  (splits J4, `SpaceModel::SplitPeers`); the download ring on the sidebar's button
  has its capture (T14). Patch 0025.
- **Part N, routing (R6-23).** `spaces::SpaceRouter` over `stedding.spaces.routes`
  and `external_default`; a routed insert or a typed address in a fresh tab moves
  the tab and the window follows a turn later; links from other apps are marked
  in `openStartupTabsReplacingNTP:`; the toast undoes; the tab menu's "Always
  Open <site> in ▸" and the settings page's per-Space rules and dropdown
  (routing D1–D6, D5 partial). Patch 0027. Not taken: "Route sites here…" on the
  Space menu and "Sort open tabs by these rules now" (D5's second pass), and the
  multi-window question (critic #26, TBD until R6-31).
- **Part M, wave 3 opens (R6-22).** Import from Arc: `ParseArcSidebar` reads
  Arc's sidebar file into a plan and `ApplyArcImport` applies it (Spaces with icon
  and nearest swatch, twelve essentials at most, Space-pinned tabs with their
  home, lists as folders, every tab a discarded restored entry), read through a
  copy, idempotent on Arc's ids, with the profile binding named in the summary
  (import I1–I4, I8–I12); rows on the welcome flow and the settings page, and a
  bar action. Patch 0026. Not taken: I5 (the 400-tab budget run), I6 (history and
  passwords), I7 (splits and the archive, which wait for J1 and A8).
- **Part O, the archived view (R6-24).** A mark on the closing tab and the Space
  name in the closed tab's data (A8), `chrome://stedding-archive` behind an
  Archived row above the switcher and a bar action (A7), the page's day groups,
  Space filter, search and Restore that re-creates a missing Space (A9), archived
  rows in the bar (A10), the retention dropdown and the list's cap at 500 (A11).
  Patch 0028. Not taken: restore acting on the page's own selection (TBD in the
  plan), and Floating History's Library panel.
- **Part P, the address row (R6-25).** `stedding::AddressRow`, owned by the
  window's Space model, answers `BrowserView::IsToolbarVisible`: the row hides
  with the sidebar (T8), a localhost page keeps it (T11), ⇧⌘D overrides until the
  sidebar changes (T10), the setting off keeps today's behaviour (T12); the
  command id lives in `stedding_command_ids.h` to spare the rebuild. Patch 0029.
  Not taken: T13 (extension actions, the media button and page info in the
  bar's actions mode, D10) and the permission-chip question; T9 stays dropped.
- **Part Q, the Privacy block (R6-26).** ADR 0017; the registered defaults
  flipped where Chromium registers them (cookies, HTTPS-First, error pages, quiet
  prompts, search suggestions); Global Privacy Control as a local-state
  preference that turns Chromium's `GlobalPrivacyControlForce` feature on where
  chrome://flags become switches; the Privacy block with one row per preference
  (Q0–Q8). Patch 0030. Not taken: the rest of PRIVACY.md's to-do table
  (translate, preloading, network time, the component endpoint, API keys), each
  still a line there (critic #22).
- **Part R, sidebar density (R6-27).** The layout constants read a process-wide
  preset and text size filled from local state (`SidebarDensity`); a change
  re-lays out every window through a theme change and a toolbar-size change;
  two dropdowns under the width slider and three bar actions (Y1–Y5). Patch 0031.
  Not taken: a density case in the window probe file (the captures carry the
  measure for now).
- **Part S, bookmarks to pins (R6-28).** `NodesFromBookmarks` and the importer's
  new `ImportNodesAsPins`; the conversion after an import that brought bookmarks
  (the welcome flow names its window through `WelcomeHost`), the bar and the star
  hidden by `stedding.bookmarks.converted`, the welcome line, the bar action
  (I13–I16). Patch 0032. Not taken: an offer on start for a profile with
  bookmarks (the action is the answer, I16).
- **Part T, sidebar backups (R6-29).** `SnapshotSidebar`, `PlanToJson` in Arc's
  shape, the hourly scheduler per window with PRODUCT §1's retention, restore as
  a merge through the importer, export of a Space to Downloads and import of a
  file through a dialog, in settings and the bar (I17–I20). Patch 0033. Not
  taken: a tab's user-given name across a restore (it comes back as the title),
  and one snapshot per profile rather than per window (R6-31).
- **Part U, wave 4 opens with the private coat (R6-32).** The mixer reads
  Chromium's incognito key (dark, grayscale) and paints graphite with no tint; no
  Space model or archiver for a private window, so the title row reads "Private"
  with the incognito glyph over the same New Tab row and Clear line, there is no
  switcher and nothing private is recorded; the window title says so (V1–V3,
  V6). Patch 0034. V4 dropped: the address row keeps the avatar button hidden,
  and the coat, the title row and the window title already say it. V5 dropped:
  the private new tab page is Chromium's own. Wave 4's ADR for the registry (0016) is written; the
  little window (R6-30) and the registry (R6-31) follow.
- **Part V, the little window (R6-30).** A popup-type window marked little,
  centred over the last-active window, for links from other apps with no route;
  ⌘O / ⇧⌘O / ⌃1–9 / Escape and the bar's "Open in <Space>" move the same
  WebContents into the window's Spaces; the archiver closes an idle one after six
  hours; the setting and the shortcut rows (E1–E5). Patch 0035. Not taken: E1's
  thin bar of its own (Chromium's popup bar serves), a VoiceOver label for it.
- **Part W, the registry (R6-31), the last of the round.** `SpaceRegistry`
  (KeyedService, `stedding.spaces.registry`); every normal window's model mirrors
  it and forwards its mutators; the first window seeds it from its session; a
  Blank Window opts out (G0, G1, G3–G5). Patch 0036. Not taken: ghost rows and
  the click that moves a pinned tab between windows (G2), one backup per
  profile.
- **Not in this pass.** R6-19's other J rows (J1, J3, J5, J6 keep their rows for
  the splits pass), the menus' Move to Folder ▸ with existing folders, G2, the
  little window's own bar (E1), and T13.

##### R6-01 · Shortcut reference block in chrome://settings/stedding

- Source: critic #6 (QUALITY.md "UX completeness" 1, ROADMAP.md M6 scope).
- Effort: S.
- Setting: a "Shortcuts" block (no preference).
- Shortcut: none (it lists them).
- Spec: docs/features/shortcuts.md (new; Z series).

| Id | Behaviour | Test | State |
|---|---|---|---|
| Z1 | chrome://settings/stedding carries a "Shortcuts" block listing every Stedding chord and every Chromium chord Stedding remaps, built from the accelerator tables (accelerators_cocoa.mm, global_keyboard_shortcuts_mac.mm, accelerator_table.cc) at startup, never hand-typed; it is the "in-product shortcut reference" QUALITY.md and ROADMAP.md cite and nothing implements today (critic #6: only the two citations exist). | a unit test that every IDC_STEDDING_* command with an accelerator appears in the block's model; capture, dark and light | planned · draft |
| Z2 | Every remapped Chromium chord has a divergence row: the chord, what Chromium binds it to, what Stedding binds it to (⌘S/⇧⌘S from round 5; ⌘D, ⇧⌘C, ⌥⌘↑/↓, ⇧⌘K, ⇧⌘D and later chords from the items below). Items record divergences here, not in QUALITY.md. | the model test asserts the divergence set; each item that remaps a chord adds its row in its own patch | planned · draft |
| Z3 | A note row records that ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N" once a second desktop exists (D5). | model test; capture | planned · draft |
| Z4 | The block is found by settings search ("shortcuts") and, once R6-11 lands, by the ⌘T action "Show keyboard shortcuts"; welcome step 5 (W6) links to it. | live: settings search; ⌘T | planned · draft |
| Z5 | Remapping (PRODUCT §12 "Keyboard shortcut customisation" [1.0]) is out of scope for round 6; the block is read-only. | spec row | planned · draft |

Rows drafted by the orchestrator from the critic's text; confirm each against Arc before its failing test.

Files: chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/webui/settings/ (a handler that walks the accelerator provider); chrome/browser/ui/cocoa/accelerators_cocoa.mm and chrome/browser/global_keyboard_shortcuts_mac.mm (read only); docs/features/shortcuts.md (new); docs/ROADMAP.md#the-quality-bar and docs/ROADMAP.md keep their citations.

Patch: new (D11); the first round-6 patch since every later item cites it.

Conflicts: R6-02, R6-04, R6-25 add divergence rows; R6-11 adds the ⌘T action.

From the critic: #6 (this item), #12 (Z3), #29 (whether the mac-only tables are deliberate is TBD and belongs in Z2's wording).

##### R6-02 · Arc's keyboard for Spaces — plan item 2

- Source: idea "Arc's keyboard for Spaces" (judges 8.67, build×3).
- Effort: S (M with the Spaces menu).
- Setting: none (the judges dropped the 'Use Arc's shortcuts' fallback toggle: the accelerator tables are static singletons; the divergences go in the shortcut reference instead).
- Shortcut: ⌃1–⌃9 Space N; ⌥⌘←/→ previous/next Space; ⌥⌘↑/↓ previous/next tab (was IDC_FOCUS_PREVIOUS/NEXT_PANE at global_keyboard_shortcuts_mac.mm:158-159); ⇧⌘K Clear; ⌘D Pin to This Space (was IDC_BOOKMARK_THIS_TAB, accelerators_cocoa.mm:56); ⌥⇧⌘←/→ move tab one Space over.
- Spec: docs/features/spaces.md (B18–B23, B28–B30).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. ⌘D and ⌥⇧⌘←/→ act on the selection.

| Id | Behaviour | Test | State |
|---|---|---|---|
| B18 | ⌃1…⌃9 activate Space N in switcher order (SpaceModel::SetActiveSpace(spaces()[n-1]->id())); N past size() is a no-op. | SpaceModelTest.SetActiveSpaceByIndexIgnoresOutOfRange, a command-controller test that IDC_STEDDING_SPACE_9 is disabled with three Spaces. | planned |
| B19 | ⌥⌘← / ⌥⌘→ activate the previous / next Space through SwitchToNeighbour (no wrap, same path as the swipe B15); tab traversal moves to ⌥⌘↑ / ⌥⌘↓ (⇧⌘] / ⇧⌘[ kept), F6 keeps pane focus. | SpaceModelTest.SwitchToNeighbour* (exists); live: tooling/drive key ⌥⌘→ then read the switcher. | planned |
| B20 | ⇧⌘K runs Clear on the active Space through SpaceModel::ClearUnpinnedTabs, the collector moved out of VerticalTabStripRegionView::ClearCurrentSpaceTabs so the line and the key share one path; Space-pinned tabs survive. | SpaceModelTest.ClearUnpinnedTabsKeepsPins. | planned |
| B21 | ⌘D toggles Pin to This Space (CommandSpacePin/Unpin); Bookmark This Tab and Bookmark All Tabs keep their menu rows and lose their chords (recorded in the QUALITY.md shortcut reference as a deliberate divergence: pinned tabs replace bookmarks, PRODUCT §1). | SpaceWindowTest.CmdDTogglesSpacePin. | planned |
| B22 | ⌥⇧⌘← / ⌥⇧⌘→ move the active tab one Space over and follow it (SetSpaceForTab then SetActiveSpace). | SpaceWindowTest.MoveTabToNeighbourSpaceFollowsIt. | planned |
| B23 | A "Spaces" menu in the menu bar lists Next Space, Previous Space, Clear This Space and Space 1…Space 9 with their chords (static items in main_menu_builder.mm; the controller enables Space N only when N ≤ size()). | capture of the menu; welcome step 5 and the settings hint list ⌃1–9 and ⇧⌘K. | planned |
| B28 | ⌘D on an essentials (Chromium-pinned) tab is a no-op and the menu row is disabled (D4; F8 refuses folders for pins the same way). | SpaceWindowTest.CmdDOnAnEssentialIsANoOp; TabMenuModelTest row state | planned · D4 |
| B29 | ⌃1–⌃9, ⇧⌘K, ⌥⌘←/→, ⌥⇧⌘←/→ and the Spaces menu rows are disabled in private and popup windows (no Spaces there: B14, V2). | a command-controller test on a TYPE_POPUP browser (the PopupSpaceTest fixture) and on an off-the-record browser | planned · D4 |
| B30 | ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N" once a second desktop exists; the Spaces menu (B23) keeps the commands reachable and the shortcut reference notes it (Z3); no remap in round 6 (D5). | spec row; Z3 | planned · D5 |

Rows B18, B19, B20, B21, B22, B23 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/app/chrome_command_ids.h (IDC_STEDDING_SPACE_1..9, _SPACE_NEXT, _SPACE_PREVIOUS, _CLEAR_SPACE, _TOGGLE_SPACE_PIN, _MOVE_TAB_TO_NEXT/PREVIOUS_SPACE after 55102; mirror in chrome/browser/ui/actions/chrome_action_id.h per the LINT.ThenChange); chrome/browser/global_keyboard_shortcuts_mac.mm (lines 129-130, 158-159); chrome/browser/ui/cocoa/accelerators_cocoa.mm (line 56, 104); chrome/browser/ui/browser_command_controller.cc; chrome/browser/ui/spaces/space_model.h/.cc (new ClearUnpinnedTabs); chrome/browser/ui/views/frame/vertical_tab_strip_region_view.cc (ClearCurrentSpaceTabs ~1422 becomes a call); chrome/browser/ui/cocoa/main_menu_builder.mm; chrome/browser/ui/spaces/space_model_unittest.cc, space_model_window_unittest.cc; chrome/browser/resources/stedding_welcome/app.ts (step 'keys'); docs/features/spaces.md; docs/ROADMAP.md#the-quality-bar (shortcut reference).

Patch: new (D11); the synthesis pointed at: Patch 0004 (model) and 0013 (keys). Fixups go into round-6 patches only.

Conflicts: 1 (command ids, controller, mac shortcut table), 3 and 4 (same two accelerator files and browser_command_controller.cc), 5 (chrome_command_ids.h, accelerators_cocoa.mm), 8 (space_model.h/.cc, CommandSpacePin), 18 (accelerators_cocoa.mm ⇧⌘D).

From the critic: #12 (D5, B30), #13 (D4, B28–B29), #29 (mac tables only: TBD, see R6-01), #6 (B21's divergence row goes to Z2, not QUALITY.md).

##### R6-03 · Close glyph only on hover or focus (Arc's active row) — plan item 9

- Source: mod "Only Close On Hover" (judges 7.33, build×3); Improved Collapsed Tabs' rail rule (R3); the audio-badge bug from Bigger Mute Button, Audio Indicator Enhanced and Audio TabIcon Plus (critic #8).
- Effort: S.
- Setting: none (Arc's default).
- Shortcut: none.
- Spec: docs/features/tabs.md (new; R1–R3, R18).

| Id | Behaviour | Test | State |
|---|---|---|---|
| R1 | Under stedding::kArcStyleWindow the close button is laid out only while the row is hovered or its close button has keyboard focus; the active row carries no permanent glyph (today IsChildVisible returns active_ \|\| hovered_or_focused at tab_view_vertical_layout.cc:192). Confirmed against the Arc reference by side-by-side capture before the change. | TabViewVerticalLayoutTest.ActiveUnhoveredHidesClose, HoveredShowsClose, FocusedShowsClose. | planned |
| R2 | The close slot stays reserved on the active row so the title does not re-elide when the glyph appears. | TabViewVerticalLayoutTest.TitleWidthUnchangedByHover. | planned |
| R3 | Essentials cards and the collapsed rail never show the close glyph (⌘W and the menu close). | TabViewVerticalLayoutTest.PinnedAndCollapsedNeverShowClose. | planned |
| R18 | A playing or muted essentials card keeps its favicon and shows the alert as a corner badge (today TabViewVerticalLayout::IsChildVisible hides icon_ while the alert shows, so a playing essential loses its site icon); a click on the badge mutes; a right-click on a silent tab's row offers Mute Site (CommandToggleSiteMuted); the badge works on a split row (PRODUCT §1 "Audio indicator and mute" [1.0]). | TabViewVerticalLayoutTest.PlayingEssentialKeepsItsFavicon; live: tooling/drive on a page with audio, capture in dark and light | planned · critic #8 |

Rows R1, R2, R3 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/views/tabs/common/tab_view_vertical_layout.cc (IsChildVisible 173-192); chrome/browser/ui/views/tabs/common/tab_view.cc (UpdateHovered already invalidates layout); a unit test beside chrome/browser/ui/views/tabs/common/tab_view_browsertest.cc; docs/features/tabs.md.

Patch: new (D11); the synthesis pointed at: Patch 0013. Fixups go into round-6 patches only.

Conflicts: 7 (same IsChildVisible hunk for the slept row), 4 (the ⌘-held badge takes this slot), 23 (row metrics).

From the critic: #8 (R18, folded here by D1 instead of a later fixup), #30 (capture both modes with a probe).

##### R6-04 · ⇧⌘C copies a clean link, ⌥⇧⌘C a Markdown link with a rich-text twin — plan item 5

- Source: idea "⇧⌘C copies the URL, ⌥⇧⌘C copies a Markdown link with a rich-text twin, and the bar says Copied" (judges 6.67, build×2, maybe×1) + idea "Copy clean link on Shift-Cmd-C, Markdown on Option-Shift-Cmd-C" (judges 6.67, skip×1, build×2), merged; Zen Context Menu's tracking strip.
- Effort: S.
- Setting: chrome://settings/stedding toggle 'Copy links without tracking parameters' (stedding.copy.strip_tracking, on).
- Shortcut: ⇧⌘C copy URL (from IDC_DEV_TOOLS_INSPECT; ⌥⌘C keeps Inspect); ⌥⇧⌘C copy as Markdown (unbound in Chromium).
- Spec: docs/features/copy-link.md (new; L1–L6).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. The plural form of a copy (one line per selected tab, or the active tab only) is TBD.

| Id | Behaviour | Test | State |
|---|---|---|---|
| L1 | ⇧⌘C copies the page URL; ⌥⌘C keeps Inspect Element (both chords map to IDC_DEV_TOOLS_INSPECT today, global_keyboard_shortcuts_mac.mm:156-157), recorded in the shortcut reference. | an accelerator-table test that ⇧⌘C resolves to IDC_COPY_URL. | planned |
| L2 | Tracking parameters are removed before the copy when the setting is on: utm_*, fbclid, gclid, dclid, msclkid, mc_eid, mc_cid, igshid, _hsenc, _hsmi, mkt_tok, yclid, twclid, ref_src, and si on youtube.com; the table lives in one file. Never applied to navigation. | CleanLinkTest.StripsEachFamily, CleanLinkTest.KeepsUnknownParameters. | planned |
| L3 | ⌥⇧⌘C (IDC_STEDDING_COPY_MARKDOWN_LINK) writes `[title](clean url)` as text and an anchor as HTML on the same pasteboard, so Slack, Notion and Docs paste a live link. | CopyUrlTest.PlainMarkdownAndHtmlFlavours reads the clipboard. | planned |
| L4 | Both appear in the tab context menu (CommandCopyURL exists; a Markdown sibling joins it), the app menu and the command bar. | TabMenuModelTest row set (item 6). | planned |
| L5 | Chromium's ToastId::kLinkCopied confirms; it reads 'Link copied, tracking removed' when something was stripped. | live capture through tooling/drive. | planned |
| L6 | Setting off copies the URL verbatim. | CopyUrlTest.SettingOffCopiesVerbatim. | planned |

Files: chrome/app/chrome_command_ids.h (IDC_COPY_URL 34071; new IDC_STEDDING_COPY_MARKDOWN_LINK; mirror in chrome_action_id.h); chrome/browser/global_keyboard_shortcuts_mac.mm (156-157); chrome/browser/ui/cocoa/accelerators_cocoa.mm; chrome/browser/ui/browser_command_controller.cc (IDC_COPY_URL case 1485); chrome/browser/ui/browser_commands.cc (CopyURL); new chrome/browser/ui/stedding/clean_link.h/.cc + unittest; chrome/browser/ui/tabs/tab_menu_model.cc; chrome/browser/ui/toasts/api/toast_id.h (kLinkCopied, existing); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; new docs/features/copy-link.md.

Patch: new (D11); the synthesis pointed at: Patch 0013 plus a new privacy patch shared with item 22. Fixups go into round-6 patches only.

Conflicts: 2 (chrome_command_ids.h, accelerators_cocoa.mm, global_keyboard_shortcuts_mac.mm, browser_command_controller.cc), 6 (tab_menu_model.cc), 21 (toast style), 1 (action rows).

From the critic: #24 (⇧⌘C inside a peek, the Markdown title's source, L5's anchor in a peek: TBD, decide in the spec before the failing test), #6 (L1's divergence row goes to Z2).

##### R6-05 · No ring around split panes — plan item 19

- Source: mod "NoHighlightSplit" (judges 6.33, build×3).
- Effort: S.
- Setting: none.
- Shortcut: none.
- Spec: docs/features/page.md (new; U6–U8).

| Id | Behaviour | Test | State |
|---|---|---|---|
| U6 | kColorMultiContentsViewActiveContentOutline and kColorMultiContentsViewInactiveContentOutline map in stedding_color_mixer.cc to the row-text tint at 0x18 (the selected-row value) so light, dark and Space tint follow; Arc draws no ring, and the page-coloured bar (T3) says which pane is active. | a probe on a split capture (tooling/probes/window.json, a split case) at the pane edge: no Material outline luma. | planned |
| U7 | The 3 px highlight (ContentsContainerOutline::UpdateState(is_active, is_highlighted)) stays for the drag-and-drop target only. | existing split browsertests unchanged. | planned |
| U8 | The inactive pane's mini toolbar is captured against Arc in the same pass and left alone unless it clashes (a separate row if it changes). | capture. | planned |

Files: chrome/browser/ui/color/stedding_color_mixer.cc; chrome/browser/ui/views/frame/contents_container_outline.h/.cc (UpdateState 41); chrome/browser/ui/views/frame/contents_container_view.cc (UpdateBorderAndOverlay 199); chrome/browser/ui/views/frame/multi_contents_view.cc (SetHighlightActiveContentsView, patched in 0002); tooling/probes/window.json; new docs/features/page.md.

Patch: new (D11); the synthesis pointed at: Patch 0007. Fixups go into round-6 patches only.

Conflicts: 17, 20, 21 (stedding_color_mixer.cc).

From the critic: #30 (a split capture, dark and light, with the probe U6 names).

##### R6-06 · Card-native link status pill and find bar colours — plan item 20

- Source: mod "Floating Status Bar" (judges 5.67, skip×1, build×2); mod "Better Find Bar" (judges 5, skip×1, maybe×1, build×1): the mixer mapping and edge alignment; idea "Card-native find bar and link status" (judges 5.67, build×1, maybe×2): the pill; the find-bar reposition and the three-way setting dropped; Custom Statusbar (critic #33).
- Effort: S.
- Setting: none.
- Shortcut: ⌘F (existing).
- Spec: docs/features/page.md (U1–U5).

| Id | Behaviour | Test | State |
|---|---|---|---|
| U1 | In Stedding mode the link status bubble is a pill inside the card: inset 8 DIP from the card's left and bottom edges, radius = height/2 on all four corners (StatusView::OnPaint drops the per-corner special-casing and kBubbleCornerRadius 4), background and text from kColorStatusBubble* mapped in stedding_color_mixer.cc to the card surface and secondary text, a hairline in the toolbar-separator tint. Chromium's slide-away-from-the-mouse (kMousePadding) and expand-on-hover stay. | a hovered-link probe in tooling/probes/window.json (tooling/drive hovers a link, shot): pill luma at the inset, card corner still rounded beneath. | planned |
| U2 | The pill never touches the card edge at any window size, including immersive fullscreen. | capture at 1400×880 and in ⌃⌘F. | planned |
| U3 | kColorFindBarBackground / Foreground / MatchCount / ButtonIcon* map to the dialog colours the command bar uses (K6), so the ⌘F bubble follows light, dark and the Space tint instead of GM3 grey. | a colour probe on a ⌘F capture, dark and light. | planned |
| U4 | The find bubble's right edge aligns with the content card's right edge (BrowserView::GetFindBarBoundingBox inset by the 8 DIP gutter, T2). | probe. | planned |
| U5 | No position, width, checkbox or hide settings: Arc has one placement for each and shows the hovered link. | spec row. | planned |

Files: chrome/browser/ui/views/status_bubble_views.cc (StatusView::OnPaint 485, Reposition 802, GetPreferredHeight 824, kBubbleCornerRadius 67, kMousePadding 71); chrome/browser/ui/color/stedding_color_mixer.cc (kColorStatusBubble* and kColorFindBar* ids from chrome/browser/ui/color/chrome_color_id.h 204-209, 927-931); chrome/browser/ui/views/find_bar_view.cc; chrome/browser/ui/views/find_bar_host.cc (GetDialogPosition); chrome/browser/ui/views/frame/browser_view.cc (GetFindBarBoundingBox 1200); chrome/browser/ui/stedding_ui_metrics.h/.cc (a status-bubble inset param); tooling/probes/window.json; docs/features/page.md.

Patch: new (D11); the synthesis pointed at: Patches 0002 and 0007. Fixups go into round-6 patches only.

Conflicts: 17, 19, 21 (stedding_color_mixer.cc), 18 (the find bar anchors under a row that can now be hidden: U4 must handle the zero-height container).

From the critic: #33 (Custom Statusbar closes here: the knobs are dropped, U1 is the one look), #30 (hovered-link and ⌘F captures in both modes), #20 (R6-25 hides the row; the synthesis's conflict note, not the critic, says U4 must handle the zero-height container).

##### R6-07 · Capture toast on Chromium's toast framework (S-40) — plan item 21

- Source: mod "smaller zen toast popup" (judges 6, build×3); backlog S-40.
- Effort: S.
- Setting: none.
- Shortcut: none.
- Spec: docs/features/screenshot.md (C5–C7).

| Id | Behaviour | Test | State |
|---|---|---|---|
| C5 | closed as: after ⇧⌘2 / ⌥⇧⌘2 / ⇧⌘1 a toast reads 'Copied · Saved to Downloads' with an action 'Show in Finder', raised from the shared ending in screenshot_capture.cc (clipboard, then Downloads) through a new ToastId registered in toast_service.cc (ToastSpecification::Builder(icon, body) + AddActionButton + AddCloseButton); a thumbnail rides in the icon slot if the specification's image model allows it, else the capture icon. | live: tooling/drive ⇧⌘2, shot within 2 s shows the toast; none after 6 s. | planned |
| C6 | ToastView's colours are overridden in stedding_color_mixer.cc so the toast matches the window (dialog colours, text-tinted, readable in light and dark); hover pauses the dismiss (Chromium's behaviour). This is the one style for every later Stedding toast (D4's undo, L5's confirmation). | colour probe on the capture. | planned |
| C7 | No toast for a ⌘-clicked link: the sidebar row is the feedback, as in Arc. | spec row. | planned |

Files: chrome/browser/ui/toasts/api/toast_id.h; chrome/browser/ui/toasts/api/toast_specification.h (Builder 22, AddActionButton 36, AddCloseButton 31); chrome/browser/ui/toasts/toast_service.cc (the registration list at 86-134); chrome/browser/ui/toasts/toast_controller.h (MaybeShowToast 105, GetAnchorView 158); chrome/browser/ui/toasts/toast_view.cc; chrome/browser/ui/stedding/screenshot/screenshot_capture.cc (the shared ending at 78); chrome/browser/ui/color/stedding_color_mixer.cc; docs/features/screenshot.md (C5–C7); BACKLOG.md (S-40 to Done).

Patch: new (D11); the synthesis pointed at: Patch 0014 and 0007. Fixups go into round-6 patches only.

Conflicts: 12 (D4's undo toast wants this style), 5 (L5 reuses kLinkCopied and this style), 17, 19, 20 (stedding_color_mixer.cc).

From the critic: #21 (placement: Chromium anchors top-centre under the toolbar, Arc bottom-centre of the content; TBD, decide once before C6 declares the style for every later toast, and R6-25 removes the anchor view), #34 (thumbnail and "Show in Finder" are in C5; Arc's bottom placement is the #21 question).

##### R6-08 · Motion follows the system — plan item 24

- Source: idea "Motion follows the system" (judges 5.67, build×2, maybe×1).
- Effort: S.
- Setting: chrome://settings/stedding toggle 'Animate the sidebar and overlays (follows macOS Reduce Motion)' (stedding.ui.animate, on).
- Shortcut: none.
- Spec: docs/features/motion.md (new; O1–O3).

| Id | Behaviour | Test | State |
|---|---|---|---|
| O1 | One helper, stedding::ShouldAnimate(): false when gfx::Animation::PrefersReducedMotion() or the preference is off; every Stedding animation (the ⌃⇥ strip fade X3, the ⌘-badge fade R11, the toast, a future peek slide or command bar fade) is gated by it and its spec row says so. | a unit test on the helper under both inputs. | planned |
| O2 | Upstream's expand-on-hover animation (AnimateExpandOnHover), hover-card fade and strip collapse take the same gate in the Stedding window. | a capture parameter SteddingArcStyleWindow:reduce_motion/true proves the still path (two shots 80 ms apart identical). | planned |
| O3 | Setting off stills the browser regardless of macOS; on follows macOS Reduce Motion. | SteddingPrefsTest default; live toggle. | planned |

Note (synthesis): Lands with the first Stedding animation (item 3 or 4), not as a standalone patch.

Files: new chrome/browser/ui/stedding/motion.h/.cc + unittest; ui/gfx/animation/animation.h (ShouldRenderRichAnimation 81, PrefersReducedMotion 102, read only); chrome/browser/ui/views/frame/vertical_tab_strip_region_view.h (AnimateExpandOnHover 247); chrome/browser/ui/views/peek/peek_view.cc; chrome/browser/ui/views/commandbar/command_bar_view.cc; chrome/browser/ui/views/spaces/space_switcher_view.cc; chrome/browser/ui/stedding_ui_metrics.h/.cc (reduce_motion param); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; new docs/features/motion.md; docs/ROADMAP.md#the-quality-bar.

Patch: new (D11); the synthesis pointed at: Patch 0013 plus 0010. Fixups go into round-6 patches only.

Conflicts: 3, 4, 21 (their fades call the helper), 14 (space_switcher_view.cc), 22 and 23 (settings page, prefs).

From the critic: none directly; the "cut-off-only hover card" rule from the skipped "One motion setting" idea is noted for a later pass.

##### R6-09 · About page version label (S-43)

- Source: backlog S-43 (round 5 audit, 2026-09-04).
- Effort: S.
- Setting: none.
- Shortcut: none.
- Spec: docs/features/settings.md (T10; settings.md and toolbar.md each have a T series already, so R6-25's T10 is toolbar's and this one is settings'; an existing collision, not this plan's to fix).

| Id | Behaviour | Test | State |
|---|---|---|---|
| T10 | chrome://settings/help reads "Stedding <VERSION> · Chromium <pin>" with no "(Developer Build)" modifier; `VERSION` and `tooling/chromium-version` are the sources (today the modifier comes from Chromium's channel string for non-official builds). | a unit test on the version-string formatter; capture of the About page, dark and light | planned · draft |

Rows drafted by the orchestrator from the backlog row (critic #11 named it ownerless); confirm against Arc before the failing test.

Files: chrome/browser/ui/webui/settings/ (the About page's version string; find the seam that reads the channel string) and the branding strings; docs/features/settings.md; BACKLOG.md (S-43 to Done).

Patch: new (D11).

Conflicts: none.

From the critic: #11 (no owner in the plan; this row is the owner).

##### R6-10 · Space colour on the welcome flow (S-42)

- Source: backlog S-42; mod "Zen Colored Picker" (judges 5.33, build×1, maybe×1, skip×1): the five-swatch part.
- Effort: S.
- Setting: welcome step 3 swatches.
- Shortcut: none.
- Spec: docs/features/welcome.md (W7 closed).

| Id | Behaviour | Test | State |
|---|---|---|---|
| W7 | closed as: step 3 (appearance) shows the five Space swatches the switcher menu offers (kNewSpaceColors) and choosing one tints the first Space at once through SpaceModel::SetSpaceColor; Skip leaves the default. No colour pad (HANDOFF trap 6 rules out the BubbleDialogDelegateView subclass the mod would need). | live: tooling/drive <fresh> --stedding-welcome, choose the third swatch, read the sidebar-ground probe (B11's tint); SteddingWelcomeHandler unit test for the message | planned · D1 |

Rows drafted by the orchestrator from the backlog row (critic #11 named it ownerless); confirm against Arc before the failing test.

Files: chrome/browser/resources/stedding_welcome/app.ts (step "appearance"); chrome/browser/ui/webui/stedding_welcome/stedding_welcome_handler.cc; chrome/browser/ui/views/spaces/space_switcher_view.cc (kNewSpaceColors, read only); docs/features/welcome.md; BACKLOG.md (S-42 to Done).

Patch: new (D11); the synthesis pointed at 0015.

Conflicts: R6-02 and R6-13 also edit welcome step 5 (a different step).

From the critic: #11 (owner; the Zen Colored Picker skip says five swatches is the ask).

#### Wave 2 — the model work the specs cite

| Id | Name | Source | Effort | Setting | Shortcut | Status |
|---|---|---|---|---|---|---|
| R6-11 | Command bar actions mode (⇥ after ⌘T, or ⇧⌘P) | idea "Command bar actions mode" (judges 9, build×3) | M | none | ⇥ in an empty ⌘T bar; ⇧⌘P; ⌘L (D2) | planned |
| R6-12 | ⌃⇥ most-recent switcher with a hold-to-see strip | idea "⌃⇥ most-recent switcher with a hold-to-see strip, and Arc's ⌥⌘↑/↓ travel keys" (judges 7.33, build×3); mod "Better CtrlTab Panel" (judges 5.33, skip×1, maybe×2), merged | M | stedding.tabs.ctrl_tab_mru | ⌃⇥ / ⌃⇧⇥; ⌥⌘↑/↓; ⌥⇧⌘↑/↓ | planned |
| R6-13 | ⌘1–9 count what you can see; hold ⌘ to see row numbers | idea "Hold ⌘ to see row numbers, and ⌘1–9 that count what you can see" (judges 7, build×3); mod "Tab Numbers" (judges 5.33, skip×1, maybe×2), merged | M (the fix alone is S and ships first) | stedding.sidebar.hold_cmd_numbers | ⌘1–9; ⌘ held | planned |
| R6-14 | Context menus with Stedding's verbs first and Google's gone | idea "Context menus with Stedding's verbs first and Google's gone" (judges 6.67, build×3); mods Zen Context Menu and Cleaner Bookmark Menu, merged | M | stedding.menus.short | none new | planned |
| R6-15 | Sleeping tabs: one unloaded look, 'Sleep' as a verb, per tab and per Space | idea "Sleeping tabs" (judges 7, build×3); mods Better Tab Indicators, Tab title fixes, Ghost Tabs, Better Unloaded Tabs, merged | M | stedding.spaces.sleep_minutes | none; ⌘T "Sleep tab" | planned |
| R6-16 | Arc's pinned-tab lifecycle: a home URL, ⌘W sleeps, the favicon resets | idea "Arc's pinned-tab lifecycle" (judges 8.33, build×3); idea "Pinned tabs have a home" (judges 6.33, maybe×2, build×1): "Set pinned URL to this page" and the hover-card line merged, the thumbnail dropped; mods Hidden Reset Button, No pinned tab reset btn, Only Reset On Hover, Remove Tab X part (a), merged | M | stedding.pins.close_sleeps | ⌘W on a pinned row | planned |
| R6-17 | Inline tab rename that survives restore | idea "Inline tab rename that survives restore" (judges 7.33, build×3); idea "Rename a tab in place" (judges 6, skip×1, build×1, maybe×1), merged: the TabUIHelper placement chosen over a SpaceModel map | M | none | double-click; ⌘T "Rename tab" | planned |
| R6-18 | Space switcher overflow: inactive chips shrink to dots | mod "Hide Inactive Workspaces" (judges 6.33, build×2, maybe×1) | M | none | none | planned |
| R6-19 | Splits as a unit (splits.md) | critic #5 (PRODUCT §4 "Split View"); ARC-ROUND2 round 5 #8 and peek P9 for what exists | S (spec and tests; the model is Chromium 153's split view) | none | none new | planned |
| R6-20 | Multi-select rule | D3; critic #4 (PRODUCT §12 "Multi-select tabs" [1.0]); TabMenuModel already reads selection_model() (tab_menu_model.cc:111) | S | none | ⌘-click, ⇧-click | planned |
| R6-21 | Download progress on the sidebar button (S-41) | backlog S-41 (toolbar; round 5 item 12) | S | none | none | planned |

##### R6-11 · Command bar actions mode (⇥ after ⌘T, or ⇧⌘P) — plan item 1

- Source: idea "Command bar actions mode" (judges 9, build×3).
- Effort: M.
- Setting: none.
- Shortcut: ⇥ in an empty ⌘T bar; ⇧⌘P (unbound in Chromium on mac; the tab-group chords ⌃⌘C/P/W/X/Z, global_keyboard_shortcuts_mac.mm:166-174, are untouched; the synthesis and critic #14 wrote ⌥⌘ for them, but the entries set command_key and cntrl_key in global_keyboard_shortcuts_mac.h).
- Spec: docs/features/commandbar.md (K8–K17).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. Move to Space, Pin/Unpin, Sleep and Move to Folder rows act on the selection.

| Id | Behaviour | Test | State |
|---|---|---|---|
| K8 | In an empty bar, ⇥ (or a leading ">") switches to actions mode: rows are commands, not tabs; ⇧⌘P opens the bar already in actions mode. | CommandBarViewTest.TabFiltersToActions, CommandBarViewTest.ShiftCmdPOpensInActionsMode. | planned |
| K9 | The action list is Chromium's own registry (every ActionItem under BrowserActions::root_action_item() with text, icon, accelerator) plus Stedding's rows: Move tab to <Space> (one row per SpaceModel::spaces()), Pin/Unpin to This Space, Move to New Folder, Clear this Space, Archive idle tabs now (TabArchiver::Sweep), Capture page/region/full document, Toggle sidebar, New Space, Rename tab, and one on/off row per stedding.* preference. | CommandBarViewTest.ActionRowsListSpacesAndCaptures. | planned |
| K10 | Rows fuzzy-match on label; the accelerator is drawn at the right of the row from the window's AcceleratorProvider; Enter runs chrome::ExecuteCommand or ActionItem::InvokeAction. | CommandBarViewTest.MoveToSpaceRowMovesTheTab (asserts through SpaceModel::SpaceForTab), CommandBarViewTest.ActionRowsCarryAccelerators. | planned |
| K11 | Every later feature that adds a command adds its row here; the empty actions state reads "No matching command" (never a blank panel). | capture, dark and light. | planned |
| K12 | ⌘L opens the bar prefilled with the page URL, selected; Escape returns to the page unchanged; a click on the address row's URL text opens the bar the same way. The address row stays the page's top (the operator's round-5 design, ARC-ROUND2 round 5 #5); the K7 row says that Enter navigates this tab (the cue the skipped "Add new tab urlbar icon" asked for). | CommandBarViewTest.CmdLPrefillsTheUrlSelected; live: ⌘L, Escape, URL unchanged | planned · D2 |
| K13 | ⇥ with text already typed filters that text against actions (Arc); ⇧⇥ returns to tabs mode with the text kept. | CommandBarViewTest.TabWithTextFiltersActions | planned · D6 |
| K14 | Escape in actions mode returns to tabs mode; a second Escape closes the bar. | CommandBarViewTest.EscapeLeavesActionsModeThenCloses | planned · D6 |
| K15 | In private and popup windows the actions list holds Chromium's actions only: no Space, pin, folder or archive rows (B14, V2). | a CommandBarViewTest on a TYPE_POPUP browser | planned · D6 |
| K16 | A row whose target is absent is hidden: Move to Space for an essentials tab, tab-scoped rows while a peek is open. | CommandBarViewTest.RowsWithoutATargetAreHidden | planned · D6 |
| K17 | A dropdown preference appears as one cycling row ("Archive after: 12 hours ▸"): Enter advances to the next value and the row re-reads. | CommandBarViewTest.DropdownPrefRowCycles | planned · D6 |

Rows K8, K9, K10, K11 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/views/commandbar/command_bar_view.h (Result gains an action variant); chrome/browser/ui/views/commandbar/command_bar_view.cc (UpdateResults, RebuildRows, GoTo); chrome/browser/ui/views/commandbar/command_bar_view_unittest.cc; chrome/browser/ui/browser_actions.h (root_action_item); chrome/browser/ui/actions/chrome_action_id.h; chrome/browser/ui/browser_command_controller.cc; chrome/browser/ui/spaces/space_model.h; chrome/browser/ui/archive/tab_archiver.h (Sweep); chrome/browser/global_keyboard_shortcuts_mac.mm (⇧⌘P); docs/features/commandbar.md.

Patch: new (D11); the synthesis pointed at: Patch 0005. Fixups go into round-6 patches only.

Conflicts: Every item below that adds a command-bar action (2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 24) lands its row through this Result variant; items 2 and 5 also edit global_keyboard_shortcuts_mac.mm and browser_command_controller.cc.

From the critic: #2 (D2, K12), #16 (D6, K13–K17), #20 (D10: extension actions, the media button and page info live here when the row is hidden, R6-25 T13), #32 ("New Documents" as a ⌘T action: not taken into round 6, no decision), #31 (VoiceOver role and keyboard path for the actions list: name them in the spec before "built").

##### R6-12 · ⌃⇥ most-recent switcher with a hold-to-see strip — plan item 3

- Source: idea "⌃⇥ most-recent switcher with a hold-to-see strip, and Arc's ⌥⌘↑/↓ travel keys" (judges 7.33, build×3); mod "Better CtrlTab Panel" (judges 5.33, skip×1, maybe×2), merged.
- Effort: M.
- Setting: chrome://settings/stedding toggle '⌃⇥ cycles the most recently used tabs' (stedding.tabs.ctrl_tab_mru, on).
- Shortcut: ⌃⇥ / ⌃⇧⇥ (accelerator_table.cc:91-93, IDC_CYCLE_TO_NEXT/PREVIOUS_TAB); ⌥⌘↑/↓ and ⌥⇧⌘↑/↓ (bound with item 2).
- Spec: docs/features/switcher.md (new; X1–X5).
- Selection: not affected (⌃⇥ activates one tab).

| Id | Behaviour | Test | State |
|---|---|---|---|
| X1 | SpaceModel keeps an activation history per Space (a closed tab leaves it; a Space switch scopes it); ⌃⇥ / ⌃⇧⇥ walk the five most recent tabs of the active Space, essentials included; Chromium's kCtrlTabMru stays off (it is global across windows and would activate Space-hidden tabs, breaking B7). | SpaceModelTest.ActivationHistoryIsPerSpace, SpaceWindowTest.CtrlTabWalksRecentTabsOfTheActiveSpace (beside NextTabSkipsOtherSpaces). | planned |
| X2 | A tap switches to the previous tab silently. | SpaceWindowTest.CtrlTabTapGoesToPreviousTab. | planned |
| X3 | Holding ⌃ past 150 ms shows a strip of up to five favicon+title cells (Space colour dot) over the content, a layered child of BrowserView like the command bar, in the theme's dialog colours; ⇥/⇧⇥ move the highlight, releasing ⌃ commits, Escape cancels. The ⌃-release detection (flagsChanged arriving as a modifier key event) is prototyped first. | RecentTabsSwitcherViewTest.ReleaseCommitsEscapeCancels; live: tooling/drive holds the key, shot, releases. | planned |
| X4 | ⌥⌘↑ / ⌥⌘↓ select the previous / next visible row (SelectRelativeTab already skips hidden tabs); ⌥⇧⌘↑ / ⌥⇧⌘↓ move the active row within its container, folder-aware (MoveTabRelative). | TabStripModelTest.MoveTabRelativeStaysInsideItsFolder. | planned |
| X5 | Setting off returns ⌃⇥ to sidebar order (IDC_CYCLE_TO_NEXT_TAB as today). | SpaceWindowTest.CtrlTabSettingOffUsesStripOrder. | planned |

Files: chrome/browser/ui/spaces/space_model.h/.cc (history beside last_active_); chrome/browser/ui/browser_commands.cc (CycleToMruTab 1525, GetGlobalMruTab 495 left alone; a Stedding path); chrome/browser/ui/browser_command_controller.cc (IDC_CYCLE_TO_NEXT_TAB); chrome/browser/ui/tabs/tab_strip_model.cc (SelectRelativeTab 4155, MoveTabRelative 4196); new chrome/browser/ui/views/switcher/recent_tabs_switcher_view.h/.cc modelled on chrome/browser/ui/views/commandbar/command_bar_view.cc; chrome/browser/global_keyboard_shortcuts_mac.mm; chrome/browser/ui/accelerator_table.cc; chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/spaces/space_model_unittest.cc, space_model_window_unittest.cc; new docs/features/switcher.md.

Patch: new (D11); the synthesis pointed at: Patch 0004 (history) plus a new switcher patch. Fixups go into round-6 patches only.

Conflicts: 2 (accelerator files, browser_command_controller.cc, space_model), 4 (browser_commands.cc, space_model_window_unittest.cc), 24 (the strip's fade goes through the motion gate), 1 (a 'Switch to recent tab' action row).

From the critic: #23 (a split is one cell: R6-19 J2; tabs inside collapsed folders, ⌃⇥ while a peek or the bar is open, and a tap-only fallback if flagsChanged never reaches Views: TBD in the spec before X3's prototype), #30 (strip capture, dark and light, with a probe), #31 (VoiceOver role for the strip: TBD).

##### R6-13 · ⌘1–9 count what you can see; hold ⌘ to see row numbers — plan item 4

- Source: idea "Hold ⌘ to see row numbers, and ⌘1–9 that count what you can see" (judges 7, build×3); mod "Tab Numbers" (judges 5.33, skip×1, maybe×2), merged.
- Effort: M (the fix alone is S and ships first).
- Setting: chrome://settings/stedding toggle 'Show row numbers while ⌘ is held' (stedding.sidebar.hold_cmd_numbers, on).
- Shortcut: ⌘1–⌘9 (existing, IDC_SELECT_TAB_0.. and IDC_SELECT_LAST_TAB); ⌘ held alone shows the badges; ⌃1–9 badges reuse item 2's chords.
- Spec: docs/features/tabs.md (R10–R13, R19).
- Selection: not affected (⌘N activates one row).

| Id | Behaviour | Test | State |
|---|---|---|---|
| R10 | chrome::SelectNumberedTab and SelectLastTab skip TabStripModel::IsTabHidden tabs (Space predicate, collapsed folders) and count in sidebar order: essentials, the Space-pinned run, then the rest; ⌘9 is the last visible tab. Today IsTabSelectable (browser_commands.cc:549) never asks IsTabHidden, so ⌘2 in Space B can activate a tab of Space A. | SpaceWindowTest.NumberedTabSkipsOtherSpaces, SpaceWindowTest.LastTabIsLastVisible (hidden tabs first in the strip). | planned |
| R11 | Holding ⌘ for 250 ms shows a 1–9 badge in the close-button slot of the first nine visible rows and a ⌃N badge on each Space chip; the badges fade in over 80 ms (motion gate, item 24) and vanish on key-up; favicons never move. Modifier-only presses reach the strip through a ui::EventMonitor on the browser widget. | TabViewVerticalLayoutTest.NumberBadgeTakesTheCloseSlotWhileCmdIsHeld; live: tooling/drive holds ⌘, shot, releases. | planned |
| R12 | Setting off leaves the fix (R10) and removes the badges. | SteddingPrefsTest default; live toggle. | planned |
| R13 | Welcome step 5 and the settings hint list ⌘1–9. | capture. | planned |
| R19 | Essentials cards show the number in a corner badge and the collapsed rail beside the icon; a split row counts as one number (R6-19 J2); sleeping rows are numbered like the rest (D7). | TabViewVerticalLayoutTest.NumberBadgeOnCardsAndRail; capture of the grid, the rail and a split, dark and light | planned · D7 |

Rows R10, R11, R12, R13 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/browser_commands.cc (SelectNumberedTab 1548, SelectLastTab 1569, IsTabSelectable 549); chrome/browser/ui/tabs/tab_strip_model.h (IsTabHidden 520); chrome/browser/ui/spaces/space_model_window_unittest.cc; chrome/browser/ui/views/tabs/common/tab_view_vertical_layout.cc (close slot); chrome/browser/ui/views/tabs/common/tab_view.cc; chrome/browser/ui/views/spaces/space_switcher_view.cc; chrome/browser/ui/views/frame/vertical_tab_strip_region_view.cc (event monitor); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/resources/stedding_welcome/app.ts; new docs/features/tabs.md.

Patch: new (D11); the synthesis pointed at: Patch 0004 (fix) and 0013 (badges). Fixups go into round-6 patches only.

Conflicts: 3 (browser_commands.cc, space_model_window_unittest.cc), 7 and 9 (tab_view_vertical_layout.cc close slot), 14 (space_switcher_view.cc), 24 (fade), 2 (welcome step 5).

From the critic: #17 (D7, R19), #1 (the Close Others fix is M5 in R6-14, not here), #30 (badge captures), #31 (badges are visual only; the chord is the keyboard path).

##### R6-14 · Context menus with Stedding's verbs first and Google's gone — plan item 6

- Source: idea "Context menus with Stedding's verbs first and Google's gone" (judges 6.67, build×3); mods Zen Context Menu and Cleaner Bookmark Menu, merged.
- Effort: M.
- Setting: chrome://settings/stedding toggle 'Short context menus (hide Chromium's sync, Google and AI items)' (stedding.menus.short, on).
- Shortcut: none new; the menu shows item 2's, 5's and 7's chords.
- Spec: docs/features/menus.md (new; M1–M7).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. M7 carries the plural labels.

| Id | Behaviour | Test | State |
|---|---|---|---|
| M1 | Tab menu order: Pin to This Space / Add to Essentials / Rename… / Move to Space ▸ / Move to Folder ▸ (existing folders, then New Folder) / Add to Split / Sleep Tab / Mute Site — Copy Link / Copy as Markdown — Close / Close Others / Clear Below; every item shows its chord. Send to your devices, Glic, reading list, tab groups and move-to-window are gone unless the setting says otherwise. | TabMenuModelTest.SteddingOrder asserts the exact command list for both states of the toggle, so a rebase cannot reintroduce CommandSendTabToSelf, CommandAddToReadLater or CommandGlic*. | planned |
| M2 | Page menu loses Lens, Search Google for image/video frame, Generate QR code, Reading mode and Glic; 'Search <default engine> for …' stays. | RenderViewContextMenuTest row set (a later pass if the file's size argues for it; judges accepted keeping the page menu for a second round). | planned |
| M3 | App menu loses Manage Google account, Open Glic, Send tab to self, Customize Chrome and Payment methods; gains Import…, Screenshot ▸ (the three captures) and Spaces ▸. The Bookmarks and lists submenu keeps Import Bookmarks and Settings and the manager, loses the bookmarks-bar submenu and the side-panel entry. | AppMenuModelTest.SteddingRows. | planned |
| M4 | The Chromium set returns with the toggle (on = Stedding's short menu; the row is worded so 'on' is the default per settings T2). | TabMenuModelTest.SteddingOrder (off branch). | planned |
| M5 | Close Others and Clear Below act inside the active Space and skip tabs inside collapsed folders: TabStripModel::GetIndicesClosedByCommand never asks IsTabHidden today, so both would close tabs in other Spaces (critic #1; same family as R10). | TabStripModelTest.CloseOthersStaysInsideTheSpace, TabStripModelTest.ClearBelowSkipsHiddenTabs | planned · critic #1 |
| M6 | The tab-group chords (⌃⌘C/P/W/X/Z, global_keyboard_shortcuts_mac.mm:166-174; the synthesis and critic #14 wrote ⌥⌘, but the entries set command_key and cntrl_key in global_keyboard_shortcuts_mac.h) are removed in the same hunk that hides the group rows, so a rebase cannot re-expose a hidden feature by keyboard (critic #14; item 1 called them "untouched"). | an accelerator-table test that none of the five resolves to a group command; Z2 records the removal | planned · critic #14 |
| M7 | Beyond the plain row (M1), four more menus: the essentials card (Remove from Essentials; no Move to Space, no folder), the folder header, the split row (R6-19), the Space-pinned row (Unpin, Reset to Pinned Page, Make This the Pinned Page). With a multi-selection every label takes the plural ("Close 3 Tabs", "Move 3 Tabs to ▸", R6-20). | TabMenuModelTest.SteddingOrder asserts all five command lists and the plural labels | planned · critic #15, D3 |

Rows M1, M2, M3, M4 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/tabs/tab_menu_model.cc (Build, ~424-500); chrome/browser/ui/tabs/tab_strip_model.h (ContextMenuCommand 794-830: new CommandMoveToSpace, CommandMoveToFolder, CommandCopyMarkdownLink, CommandSleepTab, CommandClearBelow); chrome/browser/ui/tabs/tab_strip_model.cc (ExecuteContextMenuCommand); chrome/browser/ui/views/tabs/common/tab_strip_collection_controller.cc; chrome/browser/ui/toolbar/app_menu_model.cc; chrome/browser/ui/toolbar/bookmark_sub_menu_model.cc; chrome/browser/renderer_context_menu/render_view_context_menu.cc (M2, later pass); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; new docs/features/menus.md.

Patch: new (D11); the synthesis pointed at: Patches 0001/0004/0008 fixups. Fixups go into round-6 patches only.

Conflicts: 5 (tab_menu_model.cc Copy rows), 7 (Sleep Tab row), 8 (pin rows, Reset to pinned page), 10 (Rename… row), 12 (Always open <site> in ▸ row), 2 (⌘D hint on the pin row). Land this after 5, 7, 8, 10, 12 have added their rows, or land the order first and let each add into it.

From the critic: #1 (M5), #14 (M6), #15 (M7), #4 (D3, R6-20), #34 (chords drawn in the menu plus plural verbs: M1 and M7).

##### R6-15 · Sleeping tabs: one unloaded look, 'Sleep' as a verb, per tab and per Space — plan item 7

- Source: idea "Sleeping tabs" (judges 7, build×3); mods Better Tab Indicators, Tab title fixes, Ghost Tabs, Better Unloaded Tabs, merged.
- Effort: M.
- Setting: chrome://settings/stedding dropdown 'Put a Space to sleep after leaving it: Never / 5 min / 15 min / 1 hour' (stedding.spaces.sleep_minutes, default 15; an int pref like stedding.archive.idle_hours).
- Shortcut: none; 'Sleep tab' is a ⌘T action and a context-menu row.
- Spec: docs/features/tabs.md (R4–R8).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. Sleep Tab acts on the selection.

| Id | Behaviour | Test | State |
|---|---|---|---|
| R4 | A discarded row (TabData::is_tab_discarded) draws its favicon greyscale at 45% and its title at 55% alpha of the row's text colour (so Space tints and light mode follow) and hides the close glyph until hover; Chromium's discard ring is not drawn in the Stedding window. It returns to full strength on activation without extra plumbing (SetData → UpdateColors). | TabViewTest.DiscardedRowDimsTitleAndIcon asserts the title colour alpha on a discarded WebContents; capture of a restored session before and after loading. | planned |
| R5 | Tab context menu 'Sleep Tab' and 'Sleep Other Tabs in This Space' (new ContextMenuCommand entries beside CommandSpacePin) and matching ⌘T actions call resource_coordinator::TabLifecycleUnitExternal::DiscardTab with the external reason; the active tab is never slept. | TabStripModelTest.SleepOthersInSpaceSkipsActiveAndOtherSpaces with a fake lifecycle unit. | planned |
| R6 | 'Put a Space to sleep after leaving it' (Never / 5 min / 15 min / 1 h): a timer started from SpaceModel::Observer::OnActiveSpaceChanged, cancelled on return; essentials are exempt (SetAutoDiscardable(false)); Space-pinned tabs sleep too. | SpaceSleepTest.TimerSleepsLeftSpaceExceptEssentials. | planned |
| R7 | A folder whose every tab sleeps dims its header the same way. | capture. | planned |
| R8 | Setting: the dropdown above; the look itself has no switch (it is one visual state of the row). | SteddingPrefsTest default. | planned |

Files: chrome/browser/ui/views/tabs/tab/tab_icon.cc (SetDiscarded 167, PaintDiscardRingAndIcon 371); chrome/browser/ui/views/tabs/common/tab_view.cc (UpdateColors, SetData); chrome/browser/ui/views/tabs/common/tab_view_vertical_layout.cc (IsChildVisible 149-192 for the close glyph); chrome/browser/ui/views/tabs/vertical_tab_style_views.cc (CalculateTargetColors); chrome/browser/ui/views/tabs/common/folder_view.cc; chrome/browser/ui/tabs/tab_data.h (is_tab_discarded 62); chrome/browser/ui/tabs/tab_menu_model.cc; chrome/browser/ui/tabs/tab_strip_model.h/.cc; chrome/browser/resource_coordinator/tab_lifecycle_unit_external.h (DiscardTab 41, SetAutoDiscardable 38); chrome/browser/ui/spaces/space_model.h/.cc; chrome/browser/ui/views/commandbar/command_bar_view.cc; chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; docs/features/tabs.md.

Patch: new (D11); the synthesis pointed at: Patch 0013 plus 0004. Fixups go into round-6 patches only.

Conflicts: 8 (needs this look for a slept pinned tab: build R4 before item 8's H3), 9 and 4 (tab_view_vertical_layout.cc IsChildVisible), 6 (tab_menu_model.cc, tab_strip_model.h), 11 (the importer inserts unpinned tabs discarded, so they wear this look), 23 (tab_icon.cc, tab_view.cc).

From the critic: #27 (sleeping a tab that is in a split: R6-19 J4; the essentials card's slept look and the rail's dimmed icon: TBD rows before R4 is built; R6's timer per window vs per registry: decided with R6-31), #30 (captures both modes).

##### R6-16 · Arc's pinned-tab lifecycle: a home URL, ⌘W sleeps, the favicon resets — plan item 8

- Source: idea "Arc's pinned-tab lifecycle" (judges 8.33, build×3); idea "Pinned tabs have a home" (judges 6.33, maybe×2, build×1): "Set pinned URL to this page" and the hover-card line merged, the thumbnail dropped; mods Hidden Reset Button, No pinned tab reset btn, Only Reset On Hover, Remove Tab X part (a), merged.
- Effort: M.
- Setting: chrome://settings/stedding toggle '⌘W on a pinned tab puts it to sleep instead of closing it' (stedding.pins.close_sleeps, on).
- Shortcut: ⌘W (existing IDC_CLOSE_TAB, new semantics on pinned rows); ⌘D pins (item 2).
- Spec: docs/features/pins.md (new; H1–H11).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. Reset to Pinned Page and Make This the Pinned Page act on the selection; ⌘W sleeps every selected pinned row.

| Id | Behaviour | Test | State |
|---|---|---|---|
| H1 | Both pin tiers record a home URL at pin time: SpaceModel::SetSpacePinned(tab, true) stores handle → GURL (space_pinned_ becomes a map), and Chromium's pinned bit flipping on (OnTabStripModelChanged) records it for essentials. | SpaceModelTest.PinRecordsHomeUrl. | planned |
| H2 | The home URL is written to per-tab session extra data beside stedding.spacepin through SessionExtraDataForTab and re-emitted by AppendRebuildCommands, so it survives a rebuilt session log (HANDOFF trap 4). | SessionRebuildTest.PinnedUrlSurvivesRebuild; live: tooling/drive quit and relaunch three times. | planned |
| H3 | ⌘W (IDC_CLOSE_TAB) on a Space-pinned or essentials tab sleeps it instead of closing (item 7's look; activation moves to the next visible row in the Space); a sleeping pinned tab is left alone; removal is Unpin. | SpaceWindowTest.CloseOnPinnedTabSleepsIt, SpaceWindowTest.CloseOnSleepingPinnedTabIsANoOp. | planned |
| H4 | When the tab's committed URL differs from home (origin or path), TabIcon paints a 5 DIP 'navigated away' dot at the favicon's corner (the attention-indicator geometry); it clears when the tab is home again. | TabIconTest.NavigatedAwayDot; capture. | planned |
| H5 | A click on the favicon column of a pinned tab (not the row) loads home; ⌥-click also reloads. | live: tooling/drive click on the favicon of a drifted pin, URL read back. | planned |
| H6 | Tab context menu 'Reset to Pinned Page' and 'Make This the Pinned Page'; both are ⌘T actions. | TabMenuModelTest row set (item 6). | planned |
| H7 | Peek reads the stored home URL's eTLD+1 as the pinned site (P2), so a drifted pin stops peeking the wrong site. | ShouldPeekTest.UsesTheStoredPinnedSite. | planned |
| H8 | The hover card of a pinned tab gains a line 'Pinned in <Space> · home <host>' (no thumbnail). | capture. | planned |
| H9 | Setting off returns ⌘W to closing (Unpin implied). | SpaceWindowTest.CloseSleepsSettingOffCloses. | planned |
| H10 | A click on a drifted essentials card activates it; the reset control appears on hover of the card (Arc), and a click on it loads home (D8). The critic's unsure line asks for a side-by-side check in Arc before H5 and H10 are written; do it first. | live: tooling/drive click on a drifted card (activates), hover, click the reset (URL read back) | planned · D8 |
| H11 | ⌘W on the last visible tab of a Space that holds only pins sleeps it and the Space shows its new-tab row (B4): intended (D8). | SpaceWindowTest.CloseOnLastPinnedTabSleepsItAndShowsTheNewTabRow | planned · D8 |

Rows H1, H2, H3, H4, H5, H6, H7, H8, H9 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/spaces/space_model.h (space_pinned_ 202, kSessionTabSpacePinKey 43) and .cc (SetSpacePinned 517, SessionExtraDataForTab 470, AppendRebuildCommands, OnTabStripModelChanged); chrome/browser/sessions/stedding_session_rebuild.h; chrome/browser/ui/spaces/tab_space_restore_data.h/.cc; chrome/browser/ui/browser_commands.cc (CloseTab 1415); chrome/browser/ui/browser_command_controller.cc (IDC_CLOSE_TAB 785); chrome/browser/ui/views/tabs/tab/tab_icon.cc (PaintAttentionIndicatorAndIcon 337); chrome/browser/ui/views/tabs/common/tab_view.cc; chrome/browser/ui/views/tabs/common/tab_view_vertical_layout.cc (favicon column hit test); chrome/browser/ui/tabs/tab_menu_model.cc; chrome/browser/ui/views/peek/peek_navigation_throttle.cc; chrome/browser/ui/views/tabs/hovercard/tab_hover_card_bubble_view.cc; chrome/browser/ui/spaces/space_model_unittest.cc, space_model_window_unittest.cc, session_rebuild_unittest.cc; chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; new docs/features/pins.md; docs/features/peek.md (P2 note).

Patch: new (D11); the synthesis pointed at: Patch 0004 and 0009. Fixups go into round-6 patches only.

Conflicts: 7 (the slept look, tab_icon.cc, tab_view.cc; land 7's R4 first), 2 (space_model, ⌘D), 3 (space_model.h), 6 (menu rows), 11 (the importer records savedURL as home through SetSpacePinned), 16 (space_model split into a registry later).

From the critic: #18 (D8, H10–H11), #32 ("Collapse Pinned Tabs" as a row here or in R6-02: not taken into round 6, no decision), #5 (a pinned split: R6-19 J1, J3).

##### R6-17 · Inline tab rename that survives restore — plan item 10

- Source: idea "Inline tab rename that survives restore" (judges 7.33, build×3); idea "Rename a tab in place" (judges 6, skip×1, build×1, maybe×1), merged: the TabUIHelper placement chosen over a SpaceModel map.
- Effort: M.
- Setting: none.
- Shortcut: none (double-click); 'Rename tab' in ⌘T.
- Spec: docs/features/tabs.md (R14–R17).
- Selection: rename is the exception to R6-20; it acts on the clicked row only (D3).

| Id | Behaviour | Test | State |
|---|---|---|---|
| R14 | Double-click a row's title (the favicon is the reset control, H5), the context menu 'Rename…' or the ⌘T action swaps the title for a views::Textfield in the same slot, prefilled and selected, the way FolderView::BeginRename/EndRename does; Enter commits, Escape cancels, an empty string restores the page title. | TabRenameTest.EnterCommitsEscapeCancelsEmptyRestores; live: tooling/drive double-click. | planned |
| R15 | The custom title lives in TabUIHelper (GetTitle prefers it), so the row, the hover card, the command bar and the ⌃⇥ strip read it; ⌘T matches the custom name first and the page title second. | CommandBarViewTest.MatchesCustomTitle. | planned |
| R16 | The title is written as per-tab session extra data under stedding.title and re-emitted by a rebuild provider (AddSessionRebuildProvider), so it survives a rebuilt session log. | SessionRebuildTest.TitleSurvivesRebuild. | planned |
| R17 | Names persist for every tab, whatever the tier, and survive pin/unpin; essentials keep theirs for the hover card. | TabRenameTest.NameSurvivesPinToggle. | planned |

Files: chrome/browser/ui/views/tabs/common/folder_view.cc (BeginRename 157, EndRename 166, the pattern); chrome/browser/ui/views/tabs/common/tab_view.cc (UpdateTitle ~1080-1089); chrome/browser/ui/views/tabs/tab/tab_title.cc; chrome/browser/ui/tab_ui_helper.h (GetTitle 55); chrome/browser/ui/tabs/tab_menu_model.cc; chrome/browser/ui/tabs/tab_strip_model.h (ContextMenuCommand); chrome/browser/sessions/stedding_session_rebuild.h; chrome/browser/ui/spaces/tab_space_restore_data.h (per-tab extra-data pattern); chrome/browser/ui/views/commandbar/command_bar_view.cc; docs/features/tabs.md.

Patch: new (D11); the synthesis pointed at: Patch 0013 plus the session-rebuild registry (0004). Fixups go into round-6 patches only.

Conflicts: 6 (tab_menu_model.cc, tab_strip_model.h), 8 (extra data and rebuild provider, tab_view.cc), 1 and 3 (command bar and switcher read the title), 23 (tab_title.cc).

From the critic: #25 (a split renames as a unit: R6-19 J1; rename from ⌘T while the sidebar is collapsed, and telling the user that an essentials rename only reaches the hover card: TBD rows before R14 is built), #30 (textfield capture, dark and light), #31 (keyboard path: the ⌘T action; VoiceOver role of the textfield: TBD).

##### R6-18 · Space switcher overflow: inactive chips shrink to dots — plan item 14

- Source: mod "Hide Inactive Workspaces" (judges 6.33, build×2, maybe×1).
- Effort: M.
- Setting: none (always on).
- Shortcut: none.
- Spec: docs/features/spaces.md (B24–B27).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| B24 | When the chips (24 DIP, kChipGap 12) would exceed the row, inactive chips shrink to 6 DIP dots in their Space colour while the active chip keeps its glyph; the '+' and downloads button never move. Confirm against the Arc reference first (unsure whether Arc collapses to dots at overflow; fix the dot size after the capture). | SpaceSwitcherViewTest.OverflowShrinksInactiveChips on measured widths at 352 and 126 with 12 Spaces. | planned |
| B25 | Hovering the row grows them back while the pointer is there, with no layout shift outside the row; the name pill and the swipe (B15) keep working. | SpaceSwitcherViewTest.HoverRestoresChipsWithinTheRow; live capture at 12 Spaces. | planned |
| B26 | Below the overflow threshold nothing changes (B11 holds). | existing B11 capture unchanged. | planned |
| B27 | A Space chip dragged along the row reorders the switcher; the Space menu offers Move Left / Move Right as the keyboard path (SpaceModel gains MoveSpace); the order persists (B9) and ⌃N follows it (B18). PRODUCT §2 [1.0]; critic #10. | SpaceModelTest.MoveSpaceReordersAndPersists; live: tooling/drive drags a chip past its neighbour, reads the switcher | planned · critic #10 |

Rows B24, B25, B26 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: chrome/browser/ui/views/spaces/space_switcher_view.cc (Rebuild 168, kChipGap 47) and .h; chrome/browser/ui/views/tabs/vertical/vertical_tab_strip_bottom_container.cc (row host); new chrome/browser/ui/views/spaces/space_switcher_view_unittest.cc beside space_drag_target_unittest.cc; docs/features/spaces.md.

Patch: new (D11); the synthesis pointed at: Patches 0004 and 0013. Fixups go into round-6 patches only.

Conflicts: 4 (⌃N badges on the chips), 12 (the Space menu in space_switcher_view.cc), 11 (a 16-Space import hits this at once: land before or with 11), 17 (no chips in private windows).

From the critic: #10 (B27), #34 (the name pill on a dot hover, not only on chips: part of B25), #30 (12-Space capture, dark and light).

##### R6-19 · Splits as a unit (splits.md)

- Source: critic #5 (PRODUCT §4 "Split View"); ARC-ROUND2 round 5 #8 and peek P9 for what exists.
- Effort: S (spec and tests; the model is Chromium 153's split view).
- Setting: none.
- Shortcut: none new.
- Spec: docs/features/splits.md (new; J series).

| Id | Behaviour | Test | State |
|---|---|---|---|
| J1 | A split is one row in the sidebar and one unit for the sidebar's verbs: it pins, Space-pins, renames (R6-17) and restores as one row, both pages coming back paired. | SplitRowTest.PinRenameAndRestoreKeepThePair (name TBD) | planned · draft |
| J2 | ⌘1–9 (R6-13 R19) and the ⌃⇥ strip (R6-12 X3) count a split as one; activating it activates the pane that was last active. | SpaceWindowTest.NumberedTabCountsASplitOnce; RecentTabsSwitcherViewTest.SplitIsOneCell | planned · draft |
| J3 | ⌘W on a split: TBD. Check first what Chromium 153 does to the other pane, then decide whether a pinned split's pane sleeps instead (R6-16 H3) and record it here before H3 is built. | TBD | planned · draft |
| J4 | Move to Space, Sleep and ⌘D act on both panes together (the split is one selection under R6-20). | SpaceWindowTest.MoveToSpaceMovesBothPanes; TabStripModelTest.SleepAppliesToBothPanes | planned · draft |
| J5 | A Space-pinned tab that joins a split leaves the pinned run for the split's row (noted, not changed, in the round-5 audit): keep or fix is TBD; the answer is a row here. | TBD | planned · draft |
| J6 | No ring around the panes (R6-05 U6–U7); Chromium's split browsertests stay green. | existing split browsertests; the U6 probe | planned · draft |

Rows drafted by the orchestrator from the critic's text; confirm each against Arc before its failing test.

Files: docs/features/splits.md (new); chrome/browser/ui/views/tabs/common/split_tab_view.cc (read first: CalculateVerticalLayout); chrome/browser/ui/tabs/tab_strip_model.h; the tests named by R6-12, R6-13, R6-16 and R6-20; docs/features/peek.md (P9 cites J1).

Patch: no patch of its own: each J row lands in the item that implements it (R6-12, R6-13, R6-16, R6-17, R6-20).

Conflicts: R6-12, R6-13, R6-15, R6-16, R6-17, R6-20, R6-23 all cite a J row.

From the critic: #5 (this spec; J1, J3), #23 (J2), #25 (J1), #27 (J4).

##### R6-20 · Multi-select rule

- Source: D3; critic #4 (PRODUCT §12 "Multi-select tabs" [1.0]); TabMenuModel already reads selection_model() (tab_menu_model.cc:111).
- Effort: S.
- Setting: none.
- Shortcut: ⌘-click, ⇧-click.
- Spec: docs/features/tabs.md (R20–R22).

| Id | Behaviour | Test | State |
|---|---|---|---|
| R20 | ⌘-click adds a row to the selection and ⇧-click extends it (Chromium's selection model); a selected row keeps the round-5 selected tint; a selection never spans Spaces because hidden rows cannot be selected. | existing Chromium selection tests; capture | planned · D3 |
| R21 | With more than one row selected, every verb acts on the selection: close, pin and unpin (both tiers), Move to Space, Move to Folder, Sleep, Mute, archive, Copy Link (form TBD, R6-04). Rename is the exception and acts on the clicked row. Menu labels take the plural ("Close 3 Tabs", "Move 3 Tabs to ▸"). | TabMenuModelTest.PluralLabelsForASelection; TabStripModelTest.SpacePinAppliesToTheSelection | planned · D3 |
| R22 | Chords act on the selection the same way (⌘W, ⌘D, ⌥⇧⌘←/→); a ⌘T action from the bar acts on the selection when the bar was opened with one. | SpaceWindowTest.CmdDPinsTheSelection; CommandBarViewTest.ActionAppliesToTheSelection | planned · D3 |

Rows drafted by the orchestrator from the critic's text; confirm each against Arc before its failing test.

Files: chrome/browser/ui/tabs/tab_menu_model.cc (selection_model() at 111); chrome/browser/ui/tabs/tab_strip_model.h/.cc (ExecuteContextMenuCommand over the selection); chrome/browser/ui/browser_commands.cc; chrome/browser/ui/spaces/space_model.cc (SetSpaceForTab, SetSpacePinned over a set); docs/features/tabs.md.

Patch: lands with R6-14 (the labels) and R6-02 (the chords) in their patches; no patch of its own.

Conflicts: R6-02, R6-04, R6-11, R6-14, R6-15, R6-16, R6-23 cite it.

From the critic: #4 (this rule), #34 (plural verbs).

##### R6-21 · Download progress on the sidebar button (S-41)

- Source: backlog S-41 (toolbar; round 5 item 12).
- Effort: S.
- Setting: none.
- Shortcut: none.
- Spec: docs/features/toolbar.md (T14).

| Id | Behaviour | Test | State |
|---|---|---|---|
| T14 | The bottom-left downloads button shows Chromium's progress ring and the download-started animation; today both target the toolbar button, which appears at the top right during a download. | live: tooling/drive starts a download, a capture within 1 s shows the ring on the sidebar button and no toolbar button; capture dark and light | planned · draft |

Rows drafted by the orchestrator from the backlog row (critic #11 named it ownerless); confirm against Arc before the failing test.

Files: chrome/browser/ui/views/tabs/vertical/vertical_tab_strip_bottom_container.cc (the button, round 5 item 12); chrome/browser/ui/views/download/ (the toolbar button's ring and animation, to be pointed at the sidebar button); docs/features/toolbar.md; BACKLOG.md (S-41 to Done).

Patch: new (D11); the synthesis pointed at 0013.

Conflicts: R6-18 (the bottom row), R6-32 (no chips in private windows).

From the critic: #11 (owner).

#### Wave 3 — data-bearing features on top of waves 1 and 2

| Id | Name | Source | Effort | Setting | Shortcut | Status |
|---|---|---|---|---|---|---|
| R6-22 | Import from Arc (StorableSidebar.json): Spaces, pins, folders, favorites | idea "Import from Arc" (judges 8.33, build×3) | M | button "Import from Arc…"; welcome row | none; ⌘T "Import from Arc" | built (0026) |
| R6-23 | Air Traffic Control: route sites to Spaces | idea "Air Traffic Control" (judges 7.33, build×3) | M | per-Space Routes list; stedding.spaces.external_default | none | built (0027) |
| R6-24 | Archived view: what auto-archive and Clear closed, restorable to its Space | idea "Archived view" (judges 7.33, build×3); Floating History's Library panel deferred to grow around this data layer | M | stedding.archive.keep_days | none; ⌘T "Show archived tabs" | built (0028) |
| R6-25 | The address row hides with the sidebar; ⇧⌘D shows it on its own | idea "The bar goes with the sidebar" (judges 7, build×2, maybe×1); mod "Hide Toolbar" (judges 6, maybe×2, build×1), merged: ⇧⌘D, the localhost exception | M (T8 first; T10 and T13 are the second half) | stedding.toolbar.hide_with_sidebar | ⌘S; ⇧⌘D | built (0029), T13 open |
| R6-26 | Tracker-free defaults as one Privacy block | idea "Tracker-free defaults as one settings block" (judges 7.67, build×3); mod "No Top Sites" (judges 5.67, build×1, maybe×2): the kSearchSuggestEnabled default flip merged as Q7 | M (Q4 is the M-sized piece; the rest is default flips) | Privacy block (Chromium prefs + stedding.privacy.gpc) | none | built (0030) |
| R6-27 | Sidebar density presets with one text-size step | idea "Sidebar density presets with one text-size step" (judges 6, maybe×3); mods Customize Font Size, Tab Text Size, Lean's compact rows, merged | M | stedding.sidebar.density; stedding.sidebar.text_size | none | built (0031) |
| R6-28 | Imported bookmarks become pinned tabs and folders | critic #3 (PRODUCT §1 "No bookmarks" [1.0]); the Bookmark Toolbar Tweaks, Lean and Cleaner Bookmark Menu leftovers | M | import step wording (TBD) | none | built (0032) |
| R6-29 | Sidebar backups, export and restore | critic #7 (PRODUCT §1 "Sidebar backups" [1.0]; EVIDENCE.md #2 "restore that never loses a tab", #5 sync 475 upvotes) | M | "Restore sidebar…" and "Export Space…" in chrome://settings/stedding | none; ⌘T actions | built (0033) |

##### R6-22 · Import from Arc (StorableSidebar.json): Spaces, pins, folders, favorites — plan item 11

- Source: idea "Import from Arc" (judges 8.33, build×3).
- Effort: M.
- Setting: none (a button 'Import from Arc…' in the Stedding section; the welcome row).
- Shortcut: none; ⌘T action 'Import from Arc'.
- Spec: docs/features/import.md (new; I1–I12).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| I1 | spaces::ArcSidebarImporter parses ~/Library/Application Support/Arc/StorableSidebar.json (sidebar.containers[].spaces: id, title, customInfo.iconType.emoji_v2, windowTheme; containerIDs resolve pinned/unpinned containers; items: itemContainer, list (childrenIds → nested folders), tab (savedURL, savedTitle); topAppsContainerIDs → essentials) into a read-only plan. | ArcSidebarImporterTest.ParsesFixture with a fixture of two Spaces, a nested folder and two favorites. | planned |
| I2 | The plan is summarised ('16 Spaces, 210 pinned tabs, 44 folders') before anything is applied; Skip applies nothing. | live on the welcome flow. | planned |
| I3 | Apply: SpaceModel::AddSpace/SetSpaceIcon/SetSpaceColor; TabStripModel::SetTabPinned for essentials; SpaceModel::SetSpacePinned for the pinned run (which records the home URL, H1); TabStripModel::AddToNewFolder recursively for lists (F2 nesting); unpinned tabs inserted and discarded at once (TabLifecycleUnitExternal::DiscardTab) so 400 tabs cost no memory. | ArcSidebarImporterTest.AppliesFixtureToTheModel asserts the Space list, pins, folder tree and discard state. | planned |
| I4 | Entry points: an 'Arc' row on welcome step 2 when the file exists (WelcomeHandler detects it; checkboxes for Spaces and pinned tabs / unpinned tabs), 'Import from Arc…' in chrome://settings/stedding, and a ⌘T action. | live: tooling/drive <fresh> --stedding-welcome. | planned |
| I5 | Memory and warm-start after a 400-tab import stay inside the QUALITY budgets (a strip holding 400 hidden TabViews is the risk). | tooling/measure/harness.py warm and memory legs on the imported profile. | planned |
| I6 | Phase two, a TYPE_CHROMIUM-shaped importer for Arc's User Data/Default History and Login Data, is a separate row and patch. | none yet (gap). | planned |
| I7 | Arc split-view items become split rows (R6-19 J1); archived items go to the archive (R6-24 A8) with their Space and folder path and a reason of "import". | ArcSidebarImporterTest.SplitsBecomeSplitRowsAndArchivedItemsGoToTheArchive | planned · D9 |
| I8 | The per-Space profile binding is dropped and named in the import summary (I2). | ArcSidebarImporterTest.SummaryNamesDroppedProfileBindings | planned · D9 |
| I9 | The importer reads a copy of StorableSidebar.json (Arc rewrites the file while running) and warns when Arc is running. | ArcSidebarImporterTest.ReadsACopy; live with Arc open | planned · D9 |
| I10 | windowTheme maps to the nearest of the five Stedding swatches (kNewSpaceColors). | ArcSidebarImporterTest.ThemeMapsToTheNearestSwatch | planned · D9 |
| I11 | Favorites are capped at 12 essentials (nothing in the tree caps essentials); where the rest go is TBD and the summary counts them. | ArcSidebarImporterTest.FavoritesCapAtTwelve | planned · D9 |
| I12 | A second import is idempotent: Arc's item id is stored with the tab and nothing already present is created again. | ArcSidebarImporterTest.SecondImportAddsNothing | planned · D9 |

Rows I1, I2, I3, I4, I5, I6 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Files: new chrome/browser/ui/spaces/arc_sidebar_importer.h/.cc + arc_sidebar_importer_unittest.cc with a fixture JSON; chrome/browser/ui/spaces/space_model.h (AddSpace 110, SetSpaceIcon 130, SetSpaceColor 129, SetSpacePinned 164); chrome/browser/ui/tabs/tab_strip_model.h (AddToNewFolder 696, SetTabPinned 506); chrome/browser/resource_coordinator/tab_lifecycle_unit_external.h (DiscardTab); chrome/browser/ui/webui/stedding_welcome/stedding_welcome_handler.cc (RegisterMessages 33); chrome/browser/resources/stedding_welcome/app.ts (step 'import', 27-37); chrome/browser/ui/webui/settings/stedding_spaces_handler.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/views/commandbar/command_bar_view.cc; chrome/browser/importer/importer_list.cc and components/user_data_importer/common/importer_type.h (I6 only); new docs/features/import.md; docs/features/welcome.md (W3/W8).

Patch: new (D11); the synthesis pointed at: Patch 0015 (welcome) plus a new import patch. Fixups go into round-6 patches only.

Conflicts: 8 (SetSpacePinned records the home URL; land after 8 or record it here too), 7 (inserted tabs wear the slept look), 12 and 16 (space_model.h, stedding_spaces_handler.cc), 14 (16 imported Spaces overflow the switcher: land 14 before or with this).

From the critic: #19 (D9, I7–I12), #7 (the plan format is R6-29's file format), #34 (the round-trip export makes the import strictly better than Arc's own).

##### R6-23 · Air Traffic Control: route sites to Spaces — plan item 12

- Source: idea "Air Traffic Control" (judges 7.33, build×3).
- Effort: M.
- Setting: chrome://settings/stedding: per-Space Routes sub-list in the Spaces list; dropdown 'Open links from other apps in' (stedding.spaces.external_default, default: the active Space).
- Shortcut: none.
- Spec: docs/features/routing.md (new; D1–D6).
- Selection: the multi-select rule R6-20 (D3) applies to every verb here; the spec cites it and does not restate it. "Always open <site> in ▸" from a multi-selection writes one rule per site (TBD).

| Id | Behaviour | Test | State |
|---|---|---|---|
| D1 | A pure-function SpaceRouter over the profile pref stedding.spaces.routes (entries {match: site\|contains\|equals, pattern, space}) plus stedding.spaces.external_default (the Space for links from other apps); a matching route wins over the default, as in Arc. | SpaceRouterTest.MatchTable. | planned |
| D2 | On insert of a tab that has a URL, and on the first navigation of a fresh tab (the seam in chrome::Navigate() beside MaybePeekInsteadOfNewTab), a match moves the tab with SetSpaceForTab and switches Space when the open was foreground. Session-restored tabs are never routed (B2). | SpaceWindowTest.InsertedTabFollowsRoute, SpaceWindowTest.RestoredTabIsNotRouted. | planned |
| D3 | Links from other apps (application:openURLs: → openStartupTabsReplacingNTP:) are tagged so external_default applies. | live: `open -a Stedding https://…` lands in the chosen Space. | planned |
| D4 | A 4-second toast 'Opened in Work · Undo' (item 21's style) returns the tab. | live capture; SpaceWindowTest.UndoMovesTheTabBack. | planned |
| D5 | Rules are made in place: tab context menu 'Always open <site> in ▸ <Spaces>' writes a site rule (eTLD+1, no regex); the Space menu offers 'Route sites here…'; the Spaces list in chrome://settings/stedding gains a Routes sub-list per Space with add/remove and 'Sort open tabs by these rules now' (second pass). | SpaceRouterTest.RuleFromTabIsSiteScoped; live. | planned |
| D6 | Pinned tabs keep peeking; routing applies to new tabs only, and peek precedes routing. | ShouldPeekTest.PeekPrecedesRoutes. | planned |

Files: new chrome/browser/ui/spaces/space_router.h/.cc + space_router_unittest.cc; chrome/browser/ui/spaces/space_model.cc (OnTabStripModelChanged, SetSpaceForTab 480); chrome/browser/ui/navigator/browser_navigator.cc (the peek check at 1112); chrome/browser/app_controller_mac.mm (openStartupTabsReplacingNTP: 560/1256, application:openURLs:); chrome/browser/ui/tabs/tab_menu_model.cc; chrome/browser/ui/views/spaces/space_switcher_view.cc (Space menu, ExecuteCommand 314); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/webui/settings/stedding_spaces_handler.cc; chrome/browser/ui/spaces/space_model_window_unittest.cc; new docs/features/routing.md.

Patch: new (D11); the synthesis pointed at: Patch 0004 plus a new routing patch. Fixups go into round-6 patches only.

Conflicts: 21 (the undo toast; ship with Chromium's default ToastView if 21 is not in yet), 15 (external links: the little window opens unless a route matches, so 12 lands first), 6 (tab_menu_model.cc), 11 and 16 (space_model, stedding_spaces_handler.cc), 14 (space_switcher_view.cc menu), 8 (peek precedence).

From the critic: #26 (multi-window: which window external_default names, and a route whose site is Space-pinned in the target Space (duplicate or activate the pin): TBD until R6-31; the critic's unsure line asks whether Arc routes such a match into the pin, check side by side first), #21 (D4's undo toast takes R6-07's style).

##### R6-24 · Archived view: what auto-archive and Clear closed, restorable to its Space — plan item 13

- Source: idea "Archived view" (judges 7.33, build×3); Floating History's Library panel deferred to grow around this data layer.
- Effort: M.
- Setting: chrome://settings/stedding dropdown 'Keep archived tabs for: 7 days / 30 days / 90 days' (stedding.archive.keep_days, default 30).
- Shortcut: none; ⌘T action 'Show archived tabs' (⌘Y stays History).
- Spec: docs/features/archive.md (A7 closed, A8–A11).
- Selection: restore from the page acts on the page's own selection (TBD).

| Id | Behaviour | Test | State |
|---|---|---|---|
| A7 | closed as: an 'Archived' row at the foot of the tab list, above the switcher row, opens chrome://stedding-archive (a WebUI built like stedding_welcome_ui.cc). | live capture. | planned |
| A8 | One ArchiveTab() helper, called by TabArchiver::Sweep and by SpaceModel::ClearUnpinnedTabs (item 2), records Space name, folder path and reason (auto \| clear) in the tab's TabRestoreService extra_data (sessions::tab_restore::Tab::extra_data) rather than a second store; Chromium's list keeps ⇧⌘T working. | TabArchiverTest.SweepRecordsSpaceAndReason, SpaceModelTest.ClearRecordsReason. | planned |
| A9 | The page groups by day, filters by Space, searches, and 'Restore to <Space>' re-creates the Space if it is gone (AddSpace, then SetSpaceForTab); 'Clear archive' empties it. | ArchivePageTest.RestoreRecreatesAMissingSpace; live. | planned |
| A10 | CommandBarView::UpdateResults merges a third source labelled 'Archived', so ⌘T finds a tab whether open or archived; choosing one restores to its Space. | CommandBarViewTest.ArchivedRowRestoresToItsSpace. | planned |
| A11 | Retention: 'Keep archived tabs for 7 / 30 / 90 days' bounds what the page shows. | ArchivePageTest.RetentionFiltersOldEntries. | planned |

Files: chrome/browser/ui/archive/tab_archiver.h/.cc (Sweep 44); new chrome/browser/ui/archive/archive_tab.h/.cc (the helper); components/sessions/core/tab_restore_types.h (extra_data 77, read only); chrome/browser/ui/views/frame/vertical_tab_strip_region_view.cc (the Archived row); new chrome/browser/ui/webui/stedding_archive/ on the pattern of chrome/browser/ui/webui/stedding_welcome/stedding_welcome_ui.cc; chrome/browser/ui/webui/chrome_web_ui_configs.cc; chrome/browser/ui/views/commandbar/command_bar_view.cc (UpdateResults 247); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/archive/tab_archiver_unittest.cc; docs/features/archive.md (A7 closed, A8–A11 added).

Patch: new (D11); the synthesis pointed at: Patch 0011. Fixups go into round-6 patches only.

Conflicts: 2 (Clear moves into SpaceModel::ClearUnpinnedTabs; the reason hook goes there), 1 (command bar source), 15 (little windows archive through the same helper), 17 (the archiver skips OTR windows).

From the critic: #28 (⇧⌘T already restores to the tab's Space through RestoreSpaceFromExtraData, browser_tabrestore.cc:90: A8 rides that path and adds the folder path; the "Archived" row in the collapsed rail is an icon, captured dark and light), #30, #31 (the archive page is WebUI: keyboard and VoiceOver come from the DOM; say so in the spec).

##### R6-25 · The address row hides with the sidebar; ⇧⌘D shows it on its own — plan item 18

- Source: idea "The bar goes with the sidebar" (judges 7, build×2, maybe×1); mod "Hide Toolbar" (judges 6, maybe×2, build×1), merged: ⇧⌘D, the localhost exception.
- Effort: M (T8 first; T10 and T13 are the second half).
- Setting: chrome://settings/stedding toggle 'Hide the address row with the sidebar' (stedding.toolbar.hide_with_sidebar, on), under the sidebar rows.
- Shortcut: ⌘S (existing collapse); ⇧⌘D toggle the row (from IDC_BOOKMARK_ALL_TABS, accelerators_cocoa.mm:104); ⌘L opens the command bar (D2, K12), it no longer reveals the row.
- Spec: docs/features/toolbar.md (T8–T13).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| T8 | When the strip collapses (⌘S, IDC_TOGGLE_VERTICAL_TABS_COLLAPSE) and the setting is on, SteddingBrowserViewLayout::CalculateTopContainerLayout returns a zero-height container: the content card takes the full height with its radius and 8 DIP gutters, and SteddingWindowBackground::PaintPageBar paints nothing. Immersive fullscreen is unchanged (T6; the overlay owns the row) and IsToolbarVisible()==false is the path already exercised there, so every anchor (bubbles, permission prompts, find bar, extension popups) is re-verified against it. | tooling/probes/window.json 'content top == window top when collapsed'; a layout unit test for the zero-height container. | planned |
| T9 | Resting the pointer in the top 6 DIP for 250 ms floats the row as a pill over the card's top edge (T3/T4 colour rules); ⌘L summons it focused with the full URL; Escape or focus loss retracts it. | live: tooling/drive hover at y=2, shot; ⌘L, type, Escape. | dropped (D2): ⌘L opens the command bar (K12); no floating pill |
| T10 | ⇧⌘D (Arc's 'Full URL in Toolbar') toggles the row for the window independently of the sidebar: with the sidebar expanded and the row hidden, or the sidebar collapsed and the row shown; IDC_BOOKMARK_ALL_TABS loses its chord (recorded). | layout unit test; live. | planned |
| T11 | localhost pages always show the row (Arc's Developer Mode). | live on http://localhost. | planned |
| T12 | Setting off keeps the row on regardless of the sidebar (today's behaviour); ⇧⌘D still works. | SteddingPrefsTest default; live. | planned |
| T13 | When the row is hidden, extension actions, the global media button and page info live in the command bar's actions mode (R6-11); ⌘E cycles extension actions (PRODUCT §12); page info opens from the URL text in the bar (D10). Permission chips: TBD. | CommandBarViewTest.ExtensionActionsListedWhenTheRowIsHidden; live: ⌘E with two extensions; page info from the bar | planned · D10 |

Rows T8, T9, T10, T11, T12 are verbatim from the synthesis (T9's behaviour and test as written; its State is D2's); the rest were added by the decisions named in their State.

Files: chrome/browser/ui/views/frame/layout/stedding_browser_view_layout.h/.cc (CalculateTopContainerLayout 55-102, ConfigureTopContainerBackground 104); chrome/browser/ui/views/frame/layout/browser_view_tabbed_layout_impl.cc; chrome/browser/ui/views/frame/browser_view.cc (IsToolbarVisible 3042); chrome/browser/ui/views/frame/top_container_view.cc (the immersive reveal path); chrome/browser/ui/views/frame/stedding_window_background.cc (PaintPageBar 106); chrome/browser/ui/views/frame/vertical_tab_strip_region_view.h (SetCollapsedStateUpdatedCallback 152); chrome/browser/ui/stedding/theme/page_theme_color_controller.cc; chrome/app/chrome_command_ids.h (IDC_STEDDING_TOGGLE_ADDRESS_ROW), chrome/browser/ui/cocoa/accelerators_cocoa.mm (71, 104), chrome/browser/ui/browser_command_controller.cc; chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; tooling/probes/window.json; docs/features/toolbar.md (T8–T13).

Patch: new (D11); the synthesis pointed at: Patches 0002 and 0013. Fixups go into round-6 patches only.

Conflicts: 2 and 5 (accelerators_cocoa.mm, chrome_command_ids.h, browser_command_controller.cc), 17 (stedding_window_background.cc), 20 (find bar and status bubble positions come from the same layout), 1 (a 'Toggle address row' action).

From the critic: #2 (D2: T9 dropped), #20 (D10: T13; the split mini-toolbars with no row above them: TBD), #30 (T8 captured dark and light with the probe named), #6 (T10's divergence row goes to Z2).

##### R6-26 · Tracker-free defaults as one Privacy block — plan item 22

- Source: idea "Tracker-free defaults as one settings block" (judges 7.67, build×3); mod "No Top Sites" (judges 5.67, build×1, maybe×2): the kSearchSuggestEnabled default flip merged as Q7.
- Effort: M (Q4 is the M-sized piece; the rest is default flips).
- Setting: chrome://settings/stedding 'Privacy' block: one toggle per row above (Chromium prefs for Q1–Q3, Q5–Q7; stedding.privacy.gpc for Q4). The Chromium-pref rows are exempt from settings T2's default-on rule because they are not stedding.* prefs; the block's wording makes each default the protective one.
- Shortcut: none.
- Spec: docs/features/privacy.md (new; Q0–Q8).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| Q0 | ADR 0017 records the default flips PRIVACY.md already promises (third-party cookies above all, with the site-breakage answer: Chromium's eye icon and per-site allow stay). | the ADR exists. | planned |
| Q1 | Third-party cookies blocked in normal windows: kCookieControlsMode defaults to kBlockThirdParty (cookie_settings.cc registers kIncognitoOnly today). | a network probe through tooling/drive on a page embedding a cross-site frame: no third-party Set-Cookie honoured; a default-pref test. | planned |
| Q2 | HTTPS-First balanced mode on (browser_ui_prefs.cc:231 registers false). | default-pref test; live: http://example.com upgrades. | planned |
| Q3 | 'Ask a web service about navigation errors' off (profile_network_context_service.cc:651 registers kAlternateErrorPagesEnabled true). | default-pref test; a failed navigation makes no request (network probe). | planned |
| Q4 | Global Privacy Control sent (Sec-GPC: 1 and navigator.globalPrivacyControl): a new pref stedding.privacy.gpc (on) read where the request header is assembled and by the Blink runtime feature GlobalPrivacyControl (runtime_enabled_features.json5:3395). | live: a page that echoes request headers shows Sec-GPC: 1; off removes it. | planned |
| Q5 | Quiet permission prompts on for notifications and geolocation (quiet_notification_permission_ui_state.cc). | default-pref test. | planned |
| Q6 | Topics, Protected Audience and Attribution pinned off (privacy_sandbox_prefs.cc) and the Privacy Sandbox settings page hidden in page_visibility.ts. | default-pref test; settings capture. | planned |
| Q7 | Search suggestions off by default (kSearchSuggestEnabled at profile.cc:340), the PRIVACY.md line 209 to-do; the Stedding row reads 'Send what you type to the search engine for suggestions' (off), and the ⌘T bar's empty query already shows no suggestions. | SteddingPrefsTest for the default; live: ⌘L, type, no suggest request (network probe). | planned |
| Q8 | Each of Q1–Q7 is one row in the Privacy block, each bound to exactly one preference, and each default is a docs/features/privacy.md row with its probe. | tooling/probes/settings.json. | planned |

Files: components/content_settings/core/browser/cookie_settings.cc (59/80); chrome/browser/ui/browser_ui_prefs.cc (231); chrome/browser/net/profile_network_context_service.cc (651); chrome/browser/permissions/quiet_notification_permission_ui_state.cc; components/privacy_sandbox/privacy_sandbox_prefs.cc; services/network/public/cpp/header_util.cc (Sec-GPC allowlist 150) and the request-header producer behind the Blink flag; third_party/blink/renderer/platform/runtime_enabled_features.json5 (3395); chrome/common/chrome_features.cc (kHttpsFirstBalancedModeAutoEnable); chrome/browser/profiles/profile.cc (340); chrome/browser/ui/stedding/stedding_prefs.h/.cc (a RegisterPrivacyDefaults run after Chromium's registration, SetDefaultPrefValue to keep upstream hunks near zero); chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/resources/settings/page_visibility.ts; chrome/browser/extensions/api/settings_private/prefs_util.cc; new docs/features/privacy.md; new docs/decisions/0017-tracker-free-defaults.md; docs/PRIVACY.md.

Patch: new (D11); the synthesis pointed at: New privacy patch (shared with item 5's clean-link table) plus 0010. Fixups go into round-6 patches only.

Conflicts: 5 (the same privacy patch and settings section), 23 and 24 (stedding_page.html.ts, stedding_prefs), 17 (PRIVACY.md).

From the critic: #22 (PRIVACY.md's own to-do table is only half covered: translate, preloading (net.network_prediction_options), network time, the component-updater endpoint, dummy API keys: each gets a Q row or a one-line reason in privacy.md, TBD; Q1's site-breakage answer is a visible row in the block, not only in the ADR).

##### R6-27 · Sidebar density presets with one text-size step — plan item 23

- Source: idea "Sidebar density presets with one text-size step" (judges 6, maybe×3); mods Customize Font Size, Tab Text Size, Lean's compact rows, merged.
- Effort: M.
- Setting: chrome://settings/stedding dropdown 'Sidebar density: Comfortable (default) / Compact / Dense' (stedding.sidebar.density, local state) and dropdown 'Sidebar text size: 12 / 13 / 14 / 15' (stedding.sidebar.text_size, default 12).
- Shortcut: none.
- Spec: docs/features/sidebar.md (new; Y1–Y5).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| Y1 | 'Sidebar density: Comfortable / Compact / Dense' sets rows 44/36/30 DIP, favicon slot 18/16/16, essentials card 50/40/34; the Stedding layout constants (kVerticalTabHeight, kVerticalTabPinnedHeight, kTabFaviconSize, kVerticalTabCornerRadius) read a local-state pref through a process-wide cache the way they read the feature params now, and the strip re-lays out live like the width slider (T7). Comfortable is today's measured Arc match, untouched. | a layout unit test for the three metric sets; tooling/probes/window.json gains a density case so the numbers are measured. | planned |
| Y2 | 'Sidebar text size' 12–15 pt applies to tab titles, the Space title row, folder headers, the '+ New Tab' row and the Clear line; the row height is max(preset, line height + insets) so nothing clips. | TabViewTest.TitleFontFollowsThePref; capture at 12 and 15. | planned |
| Y3 | Folder headers, the Space title row, the New Tab row and the Clear line take the same row height so Dense looks even. | capture at Dense. | planned |
| Y4 | ⌘T actions 'Sidebar density: …' for each preset. | CommandBarViewTest row set. | planned |
| Y5 | The essentials grid, toolbar and command bar do not move. | probes unchanged for those regions. | planned |

Files: chrome/browser/ui/layout_constants.cc (kVerticalTabHeight ~156, kVerticalTabPinnedHeight ~158); chrome/browser/ui/stedding_ui_metrics.h/.cc (kVerticalTabHeight 31, kVerticalTabPinnedHeight 37, kTabFaviconSize 69); chrome/browser/ui/views/tabs/common/tab_view_vertical_layout.cc; chrome/browser/ui/views/tabs/tab/tab_title.cc; chrome/browser/ui/views/tabs/common/tab_view.cc; chrome/browser/ui/views/tabs/common/folder_view.cc; chrome/browser/ui/views/tabs/common/tab_strip_view.cc (kSpaceTitleRowHeight 49); chrome/browser/ui/views/tabs/common/clear_tabs_separator.cc; chrome/browser/ui/views/frame/vertical_tab_strip_region_view.cc (UpdateSpaceTitle 1346); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; tooling/probes/window.json; new docs/features/sidebar.md.

Patch: new (D11); the synthesis pointed at: Patches 0002 and 0013. Fixups go into round-6 patches only.

Conflicts: 7, 9, 10 (tab_view.cc, tab_view_vertical_layout.cc, tab_title.cc), 17 (tab_strip_view.cc), 22 and 24 (settings page, prefs). Not parity; judges: after the parity rows above.

From the critic: none directly; #30 (a density case in the probe file is already Y1).

##### R6-28 · Imported bookmarks become pinned tabs and folders

- Source: critic #3 (PRODUCT §1 "No bookmarks" [1.0]); the Bookmark Toolbar Tweaks, Lean and Cleaner Bookmark Menu leftovers.
- Effort: M.
- Setting: import step wording (TBD).
- Shortcut: none.
- Spec: docs/features/import.md (I13–I16).

| Id | Behaviour | Test | State |
|---|---|---|---|
| I13 | Bookmarks imported on welcome W3 or from chrome://settings/importData become Space-pinned tabs in the active Space: each bookmark folder a folder (F1/F2 nesting), each bookmark a Space-pinned tab inserted discarded (I3), the bookmark-bar root first. | BookmarksToPinsTest.FolderTreeBecomesPinnedFolders | planned · draft |
| I14 | After the conversion the bookmark bar (⇧⌘B, the new tab page's bar), the star in the location bar and the Bookmarks submenu are hidden; Import Bookmarks and Settings stays reachable from the app menu (S-30, M3). | capture of the new tab page and the app menu; AppMenuModelTest.SteddingRows | planned · draft |
| I15 | The import step says what happens ("Bookmarks become pinned tabs and folders", with a count); Skip leaves the bookmark model as Chromium filled it, and whether the bar stays hidden then is TBD. | live on the welcome flow | planned · draft |
| I16 | A profile that already holds bookmarks when it upgrades: TBD (a one-time offer on the next start, or a ⌘T action "Turn bookmarks into pinned tabs"). | TBD | planned · draft |

Rows drafted by the orchestrator from the critic's text; confirm each against Arc before its failing test.

Files: chrome/browser/ui/webui/settings/import_data_handler.cc (the seam after the import completes); components/bookmarks (read only); chrome/browser/ui/spaces/space_model.h (SetSpacePinned, H1 records the home URL); chrome/browser/ui/tabs/tab_strip_model.h (AddToNewFolder); chrome/browser/ui/toolbar/bookmark_sub_menu_model.cc; chrome/browser/ui/views/location_bar/ (the star); chrome/browser/ui/bookmarks/bookmark_bar_controller.cc (IsShowingNTP shows the bar on the new tab page); chrome/browser/resources/stedding_welcome/app.ts; docs/features/import.md; docs/features/welcome.md (W3).

Patch: new (D11), after R6-22 (shares the importer's apply path) and R6-16 (H1).

Conflicts: R6-22 (apply path), R6-16 (home URL), R6-14 (M3 trims the Bookmarks submenu), R6-15 (inserted tabs wear the slept look).

From the critic: #3 (this item), #33 (Bookmark Toolbar Tweaks closes here).

##### R6-29 · Sidebar backups, export and restore

- Source: critic #7 (PRODUCT §1 "Sidebar backups" [1.0]; EVIDENCE.md #2 "restore that never loses a tab", #5 sync 475 upvotes).
- Effort: M.
- Setting: "Restore sidebar…" and "Export Space…" in chrome://settings/stedding.
- Shortcut: none; ⌘T actions.
- Spec: docs/features/import.md (I17–I20).

| Id | Behaviour | Test | State |
|---|---|---|---|
| I17 | Stedding writes a JSON snapshot of the sidebar (Spaces with name, icon, colour, order; essentials; the per-Space pinned runs with home URLs (H1); folders with nesting; custom titles (R15)) into the profile directory on the schedule PRODUCT §1 gives; local only, deleted with the profile. | SidebarBackupTest.SnapshotCarriesEveryField; a schedule test with a mock clock | planned · draft |
| I18 | The file is R6-22's plan format, so an export is an import in reverse and a restore applies through ArcSidebarImporter's apply path (I3, I12 idempotence). | SidebarBackupTest.RoundTripIsIdentity | planned · draft |
| I19 | "Restore sidebar…" lists snapshots by time; a restore never closes an open tab; whether it merges into or replaces the current sidebar is TBD and the row says which. | SidebarBackupTest.RestoreClosesNothing; live | planned · draft |
| I20 | "Export Space…" writes one Space in the same format and "Import sidebar…" reads a file back: the file-based answer to sync, with no account (PRIVACY.md). | SidebarBackupTest.ExportOneSpaceImportsBack | planned · draft |

Rows drafted by the orchestrator from the critic's text; confirm each against Arc before its failing test.

Files: chrome/browser/ui/spaces/arc_sidebar_importer.h/.cc (the plan type and apply path from R6-22); new chrome/browser/ui/spaces/sidebar_backup.h/.cc + unittest; chrome/browser/ui/webui/settings/stedding_spaces_handler.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; chrome/browser/ui/views/commandbar/command_bar_view.cc (actions); docs/features/import.md; docs/PRODUCT.md (§1).

Patch: new (D11), after R6-22.

Conflicts: R6-22 (plan format), R6-16 (home URLs), R6-17 (titles), R6-31 (the registry becomes the source once it exists).

From the critic: #7 (this item), #34 (the round trip).

#### Wave 4 — needs an ADR first

| Id | Name | Source | Effort | Setting | Shortcut | Status |
|---|---|---|---|---|---|---|
| R6-30 | Little window: links from other apps open small | idea "Little window" (judges 6.33, build×1, maybe×2); judges: effort closer to L, needs 12 and 21 first | L | stedding.little.enabled; shares stedding.spaces.external_default | ⌘O / ⇧⌘O / Esc / ⌃1–9 inside | built (0035), E1 partial |
| R6-31 | One sidebar for every window (SpaceRegistry) — needs an ADR first | idea "One sidebar for every window" (judges 6.33, maybe×2, build×1); judges: L, needs its ADR and a design pass before an estimate | L | none | ⌘N; ⌥⇧⌘N | built (0036), G2 open |
| R6-32 | Private windows wear a different coat | idea "Private windows wear a different coat" (judges 8, build×3); mod "Private Mode Highlighting" (judges 6, skip×1, build×1, maybe×1), merged: the avatar badge back for OTR | M | none | ⇧⌘N | built (0034) |

##### R6-30 · Little window: links from other apps open small — plan item 15

- Source: idea "Little window" (judges 6.33, build×1, maybe×2); judges: effort closer to L, needs 12 and 21 first.
- Effort: L.
- Setting: chrome://settings/stedding toggle 'Open links from other apps in a small window' (stedding.little.enabled, on); shares stedding.spaces.external_default with item 12.
- Shortcut: ⌘O / ⇧⌘O / Escape inside the window (as peek); ⌃1–9 inside it; no chord to open one (see E5).
- Spec: docs/features/little.md (new; E1–E5).
- Selection: not affected (one page per little window).

| Id | Behaviour | Test | State |
|---|---|---|---|
| E1 | A link from another application opens a stedding::LittleWindow, a TYPE_POPUP browser (no Spaces, B14) with a thin bar: back/forward/reload, centred host, 'Open in ▸ <Space>' from the last-active normal window's SpaceModel, and Pin; unless an Air Traffic Control route matches (route wins, D3). | LittleWindowTest.ExternalUrlOpensLittleWindow, LittleWindowTest.MatchingRouteSkipsIt. | planned |
| E2 | ⌘O moves the WebContents into the last-active window's active Space (InsertWebContentsAt then SetSpaceForTab, no reload); ⇧⌘O into a split with its active tab; Escape closes; ⌃1–9 inside it send the page to Space N. The verbs mirror PeekView::PromoteToTab/PromoteToSplit. | LittleWindowTest.PromoteMovesContentsIntoSpace, LittleWindowTest.CtrlDigitSendsToSpaceN. | planned |
| E3 | TabArchiver gets a per-window threshold: little windows archive at 6 hours (stedding.little.idle_hours) against 12 for tabs. | TabArchiverTest.LittleWindowUsesItsOwnThreshold. | planned |
| E4 | Setting off opens external links as ordinary tabs in external_default (D3). | LittleWindowTest.SettingOffOpensATab. | planned |
| E5 | Chord: none in this cut. ⌥⌘N stays split (welcome W6 advertises it); the divergence from Arc's ⌥⌘N is recorded in the shortcut reference with a decision to make later. | shortcut reference row. | planned |

Note (synthesis): Effort is honest at L: popup chrome is Chromium's, and a custom thin bar with an Open-in-Space menu is more than the peek verbs. Spec and capture the bar against Little Arc before building.

Files: new chrome/browser/ui/views/little/little_window.h/.cc + unittest; chrome/browser/app_controller_mac.mm (openStartupTabsReplacingNTP: 560/1256); chrome/browser/ui/startup/startup_browser_creator_impl.cc; chrome/browser/ui/views/peek/peek_view.h (PromoteToTab 77, PromoteToSplit 81, the pattern); chrome/browser/ui/browser_window/internal/browser_window_features.cc (TYPE_NORMAL gates 276-279); chrome/browser/ui/archive/tab_archiver.h/.cc (IdleThreshold 63); chrome/browser/ui/stedding/stedding_prefs.h/.cc; chrome/browser/resources/settings/stedding_page/stedding_page.html.ts; new docs/features/little.md; docs/PRODUCT.md (§5).

Patch: new (D11); the synthesis pointed at: New patch. Fixups go into round-6 patches only.

Conflicts: 12 (routing decides before the little window; app_controller_mac.mm), 13 (tab_archiver), 17 (browser_window_features.cc), 21 (toast on promote), 2 (⌃1–9 handling inside a popup).

From the critic: #29 (chords inside the popup: mac tables), #30 (the bar captured dark and light with a probe), #31 (VoiceOver role of the thin bar: TBD), #26 (which window "last-active" means: R6-31).

##### R6-31 · One sidebar for every window (SpaceRegistry) — needs an ADR first — plan item 16

- Source: idea "One sidebar for every window" (judges 6.33, maybe×2, build×1); judges: L, needs its ADR and a design pass before an estimate.
- Effort: L.
- Setting: none.
- Shortcut: ⌘N (existing); ⌥⇧⌘N New Blank Window (unbound in Chromium on mac).
- Spec: docs/features/windows.md (new; G0–G5); docs/decisions/ (the registry ADR).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| G0 | ADR 0016 beside 0015: the Space list, order, metadata, essentials and per-Space pinned entries move to a profile-level SpaceRegistry (KeyedService); SpaceModel stays per window with only the active Space and tab membership, observing the registry. Written and accepted before code. | the ADR exists. | planned |
| G1 | ⌘N (and a tab dragged out through tab_drag_controller.cc) opens a window showing the same Spaces, essentials and pinned rows. | SpaceWindowTest.SecondWindowSeesTheSameSpaces. | planned |
| G2 | A pinned tab is a real tab in one window at a time; other windows show its row as a ghost (muted favicon, 'in another window' on hover); click moves the WebContents here (DetachTabAtForInsertion then InsertDetachedTabAt, no reload), ⌥-click focuses the window that has it. | SpaceWindowTest.PinnedTabMovesBetweenWindowsOnClick. | planned |
| G3 | The registry serialises to profile prefs (stedding.spaces.registry); per-window extra data keeps active Space and memberships so the B9 rebuild path is unchanged; settings T9 reads the registry. | SessionRebuildTest with two windows; SpaceRegistryTest.RoundTrip. | planned |
| G4 | 'New Blank Window' (⌥⇧⌘N, app menu) opens a window that opts out of the registry: Arc's Blank Window. | SpaceWindowTest.BlankWindowHasItsOwnSpaces. | planned |
| G5 | The registry ADR states that a registry Space can carry a profile id (PRODUCT §2 "Per-Space Profiles" [1.0]; the Container Halo and Colored container tab mods are the demand signal), so the model does not preclude it; nothing in this item binds a profile (critic #9, D1). | the ADR text; SpaceRegistryTest.RoundTrip carries an empty profile id | planned · critic #9 |

Rows G0, G1, G2, G3, G4 are verbatim from the synthesis; the rest were added by the decisions named in their State.

Note (synthesis): Effort is L and the estimate is not credible until G0 is done; schedule after the S/M items above.

Files: new chrome/browser/ui/spaces/space_registry.h/.cc + unittest; chrome/browser/ui/spaces/space_model.h/.cc; chrome/browser/ui/browser_window/internal/browser_window_features.cc (276-279); chrome/browser/ui/views/spaces/space_tab_visibility_controller.h/.cc; chrome/browser/ui/views/tabs/dragging/tab_drag_controller.cc; chrome/browser/sessions/stedding_session_rebuild.h; chrome/browser/ui/webui/settings/stedding_spaces_handler.cc; chrome/app/chrome_command_ids.h, chrome/browser/ui/cocoa/accelerators_cocoa.mm (⌥⇧⌘N); new docs/decisions/0016-space-registry.md; new docs/features/windows.md; docs/PRODUCT.md (§10).

Patch: new (D11); the synthesis pointed at: Patch 0004 becomes two. Fixups go into round-6 patches only.

Conflicts: Every item that edits space_model.h/.cc (2, 3, 8, 11, 12) and stedding_spaces_handler.cc (11, 12); 8's home URL and 11's importer target the registry once it exists, so land those first against SpaceModel and migrate in this item.

From the critic: #9 (G5), #26 (multi-window routing questions from R6-23 are answered here), #27 (R6's timer per window vs per registry), #29.

##### R6-32 · Private windows wear a different coat — plan item 17

- Source: idea "Private windows wear a different coat" (judges 8, build×3); mod "Private Mode Highlighting" (judges 6, skip×1, build×1, maybe×1), merged: the avatar badge back for OTR.
- Effort: M.
- Setting: none (nothing to turn off; Chromium's per-extension 'Allow in Incognito' stays).
- Shortcut: ⇧⌘N (existing).
- Spec: docs/features/private.md (new; V1–V6).
- Selection: not affected.

| Id | Behaviour | Test | State |
|---|---|---|---|
| V1 | An off-the-record window (BrowserWidget::IsIncognitoBrowser; ThemeService::GetColorProviderKey already forces dark + grayscale at theme_service.cc:712-716, which AddSteddingColorMixer today paints as the same navy) paints a flat graphite ground in both schemes: no gradient, no Space tint; the mat, the page bar and the command bar follow through the mixer. | tooling/probes/window.json run with --incognito, dark and light (a probe at the sidebar ground and at the mat). | planned |
| V2 | The Space title row (TabStripView::SetSpaceTitle) reads 'Private' with the incognito glyph and opens no menu; the switcher row shows no chips and no '+'; the window title carries ' - Private'. | capture; PopupSpaceTest-style unit test that a private window has one Space and no switcher. | planned |
| V3 | SpaceModel and TabArchiver are not created for OTR windows (browser_window_features.cc:276-279 gates on TYPE_NORMAL only today), so the archiver never closes a private tab and nothing private reaches the sidebar model or session extra data. | TabArchiverTest.SkipsOffTheRecordWindows, SpaceWindowTest.PrivateWindowHasNoSpaceModel. | planned |
| V4 | Chromium's avatar badge ('Incognito' pill) is shown again for OTR profiles only (patch 0002's toolbar hunk hides avatar_ for every window). | capture. | planned |
| V5 | The local new tab page adds one line under the hint: 'Private window: history, cookies and site data are forgotten when the last private window closes'. | tooling/probes/ntp.json --incognito. | planned |
| V6 | Peek and its promotion into a split stay inside the private window. | PeekViewTest.PromotionStaysInThePrivateWindow. | planned |

Files: chrome/browser/ui/views/frame/stedding_window_background.cc; chrome/browser/ui/color/stedding_color_mixer.cc (AddSteddingColorMixer 37-44); chrome/browser/ui/views/frame/browser_widget.cc (IsIncognitoBrowser 591, colour key 356/530); chrome/browser/themes/theme_service.cc (GetColorProviderKey 705, read only); chrome/browser/ui/views/tabs/common/tab_strip_view.cc (SetSpaceTitle 271); chrome/browser/ui/views/spaces/space_switcher_view.cc; chrome/browser/ui/browser_window/internal/browser_window_features.cc (276-279); chrome/browser/ui/archive/tab_archiver.cc; chrome/browser/ui/views/toolbar/toolbar_view.cc (the avatar_ hunk from patch 0002); chrome/browser/resources/new_tab_page_third_party/new_tab_page_third_party.html; tooling/probes/window.json; new docs/features/private.md; docs/PRIVACY.md.

Patch: new (D11); the synthesis pointed at: Patches 0002, 0007, 0004, 0011. Fixups go into round-6 patches only.

Conflicts: 18, 19, 20, 21 (stedding_color_mixer.cc, stedding_window_background.cc), 14 (space_switcher_view.cc), 13 and 15 (tab_archiver, browser_window_features.cc), 16 (window features).

From the critic: #30 (V1 is already a probe run in both modes), #31 (the "Private" title row: a VoiceOver label, TBD), #13 (B29 disables the Space chords here).

### Not now

The 60 candidates the synthesis skipped, with its reason verbatim, grouped by why. A
candidate under "merged" has a part of it inside a plan item; the rest is not built. Where
a decision moved a skip, the note says so.

#### Merged into a plan item (30)

| Candidate | Synthesiser's reason | Now |
|---|---|---|
| Pinned tabs have a home (idea) | Merged into plan item 8: 'Set pinned URL to this page' and the hover-card home line taken; the kTabHoverCardImages thumbnail dropped (capture on every tab hide is a memory-budget question). | R6-16 |
| Hidden Reset Button | Merged into plan item 8 (H7: peek reads the stored pinned URL's site); the hover flip is extra motion the dot plus favicon click already covers. | R6-16 |
| No pinned tab reset btn | Merged into plan item 8; nothing distinct once the favicon is the only control. | R6-16 |
| Only Reset On Hover | Merged into plan item 8 ('Make This the Pinned Page' wording kept as H6). | R6-16 |
| Remove Tab X | Part (a) is plan item 8's pinned semantics; the 'Never' dropdown is a knob Arc lacks and plan item 9 already quiets the row. | R6-16, R6-03 |
| Rename a tab in place (idea) | Duplicate of plan item 10; the TabUIHelper placement was chosen over a SpaceModel map. | R6-17 |
| Private Mode Highlighting | Merged into plan item 17 (V4, the avatar badge back for OTR); the nine colour options and three toggles are not a product decision. | R6-32 |
| Hide Toolbar | Merged into plan item 18 (T10 ⇧⌘D, T11 localhost exception) rather than a second toggle. | R6-25 |
| Copy clean link on Shift-Cmd-C (idea) | Merged into plan item 5 (its tracking-parameter table, the YouTube 'si' rule, ⌥⌘C keeping Inspect, the kLinkCopied toast). | R6-04 |
| Better CtrlTab Panel | Merged into plan item 3; same design, and kCtrlTabMru is global and Space-blind so cannot be reused. | R6-12 |
| Tab Numbers | Merged into plan item 4; the favicon-slot badge loses site identity, so the close-slot form is used. | R6-13 |
| Zen Context Menu | Merged: curation into plan item 6, the tracking strip into plan item 5; thirty hide-switches are the clutter to avoid. | R6-14, R6-04 |
| Cleaner Bookmark Menu | Merged into plan item 6 (M3 trims the Bookmarks submenu) and plan item 2 (⌘D moves to Pin); the rest waits for import-to-pinned. | R6-14, R6-28 |
| Better Tab Indicators | The active look was decided in round 5; the dim half is plan item 7's R4. | R6-15 |
| Tab title fixes | The dim is plan item 7, the 13 px title is a step of plan item 23; nothing separate. | R6-15, R6-27 |
| Ghost Tabs | Merged into plan item 7 (R4, R7 folder dimming); Memory Saver is off in this tree so a dim without the Sleep verb would seldom show. | R6-15 |
| Better Unloaded Tabs | Merged into plan item 7 (Unload/Sleep verb and dim); its own toggle would duplicate Memory Saver's switch. | R6-15 |
| Customize Font Size | Merged into plan item 23 (one validated size, rows follow) instead of four free-form CSS strings. | R6-27 |
| Tab Text Size | Duplicate of Customize Font Size; merged into plan item 23. | R6-27 |
| Lean | Compact rows fold into plan item 23; the bookmark bar removal waits for import-to-pinned (Chromium shows the bar on the NTP regardless of kShowBookmarkBar); the bottom row stays as the drop and swipe surface. | R6-27, R6-28 |
| Better Find Bar | avg 5.0, build×1: the mixer mapping and edge alignment are taken into plan item 20 (U3, U4); the position, width and checkbox prefs are dropped. | R6-06 |
| Card-native find bar and link status (idea) | avg 5.67, build×1: the status pill is plan item 20; the find-bar reposition and the three-way link-status setting are dropped until a capture against Arc asks for them. | R6-06 |
| No Top Sites | avg 5.67, build×1: the kSearchSuggestEnabled default flip is plan item 22's Q7; masking providers in components/omnibox is upstream surface for a behaviour the field-trial defaults already give. | R6-26 |
| Bigger Mute Button | avg 5.67, build×1 (below both thresholds). The one verified bug — a playing essentials card loses its favicon because IsChildVisible hides icon_ while the alert shows — is worth a fixup into plan item 9's IsChildVisible hunk later (favicon plus a corner badge); the 'Mute Tab' menu row exists as CommandToggleSiteMuted. | R6-03 (D1: the favicon bug is R18, not a later fixup) |
| Audio Indicator Enhanced | avg 5.0, build×0: same badge-over-favicon fix as Bigger Mute Button; below threshold. | R6-03 (R18 is the same fix) |
| Audio TabIcon Plus | avg 5.0, build×1: same layout fix; below threshold, see Bigger Mute Button. | R6-03 (R18 is the same fix) |
| Improved Collapsed Tabs | avg 5.33, build×1: the rail's never-lay-out-close rule is taken as plan item 9's R3; the alert badge waits with the audio cluster; the rail itself is a Chromium state Arc lacks. | R6-03 |
| Add new tab urlbar icon | avg 4.33: the ambiguity it cues does not exist until ⌘L routes into the command bar; add the edit/new-tab mode in the K7 row as part of that change. | R6-11 (D2 lands ⌘L in the bar; the mode cue is in K12) |
| Zen Colored Picker | avg 5.33, build×1: as written it subclasses BubbleDialogDelegateView, which HANDOFF trap 6 says cannot be done outside Views in this tree; S-42 only needs the five swatches on the welcome step; a Skia colour pad is a later luxury. | R6-10 (D1: the five swatches on the welcome step) |
| Super Sleek UI | avg 4.67, maybe×3: only the scrim behind the command bar is Arc (one layer call, PeekView has one to reuse) and can ride plan item 1; the most-visited tiles contradict Arc's empty bar; edge-to-edge is rightly refused. | R6-11 (the scrim only, if it rides) |

#### Below threshold (score or effort; nothing taken now) (14)

| Candidate | Synthesiser's reason | Now |
|---|---|---|
| Floating History | avg 5.67, maybe×3: Arc's Library at the bottom-left is [1.0] but L effort; plan item 13 builds the archive data layer it needs first, and the Library grows around it later. | grows around R6-24 later |
| Quietify | avg 4.0, maybe×1: an animated equaliser adds motion where a static badge does the job. | — |
| Media in the sidebar (idea) | avg 5.67, maybe×3: an L bundle whose favicon-replacement rule contradicts the badge design, and 'video follows you' leans on browser-initiated auto-PiP that upstream still ships as a dry run; split and spec first. | — |
| Pimp your PiP | avg 4.67: the auto pop-out is the Arc behaviour and belongs with the media idea; the overlay restyle touches an actively churned upstream window. | — |
| Smaller Compact Mode | avg 5.33, maybe×3: the third 'hidden' sidebar state is Arc's ⌘S but lives in Chromium's VerticalTabStripStateController and expand-on-hover overlay, both under active upstream development; decide after plan item 18 has landed and been retested. | decide after R6-25 |
| Cleaned URL bar | avg 5.33, build×1: PRODUCT routes ⌘L into the command bar at 1.0, which makes the omnibox popup transient; the mixer hunk only if ⌘L stays on the omnibox, and no blur setting. | D2 makes the omnibox popup transient |
| Tab Preview Enhanced | avg 5.33, build×1: the hover-card colour mapping and radius are a cheap mixer hunk to ride along a later theme pass; enabling kTabHoverCardImages means thumbnail capture on every tab hide and must be measured against the memory budget first. | — |
| SuperPins | avg 5.33, build×1: only the width-derived column count survives (a one-line change in the pinned_tab_container_view.cc hunk, probe at two widths); fold into Big Essentials when that is measured. | — |
| Big Essentials | avg 5.0, maybe×3: measure the icon against the Arc reference first; a crisp larger icon needs a large-favicon fetch threaded into TabData through upstream's favicon pipeline (M with rebase surface); try drawing the 32 px favicons Chromium already fetches before the LargeIconService route. | — |
| HidePlugins | avg 5.0, maybe×3: the puzzle container also hosts the site-access request chip and anchors popups, extensions are a hard requirement, and a default-off pref breaks settings T2; needs a design answer, and the toolbar may hide anyway under plan item 18. | R6-25 may hide the toolbar anyway |
| Animations Plus | avg 4.0: easing polish that must wait for plan item 24's gate; the one real gap, a folder-header hover tint, is a two-line fix worth doing on its own. | after R6-08 |
| One motion setting, and hover cards that speak only when the title was cut off | avg 4.67: overlaps plan item 24; the three-way scale reaches many upstream files for what macOS Reduce Motion already provides; the cut-off-only hover-card rule is the good part, noted for a later pass. | overlaps R6-08 |
| Clickable Scrollbar | avg 4.33: Arc's sidebar scrollbar is also an overlay, the change lands in the shared upstream RoundedScrollBar, and the macOS 'Show scroll bars' preference already covers the 'always' case; marginal gain. | — |
| Vertical Split Tab Groups | avg 3.33: Chromium already stacks the pair at narrow widths and round 5 #8 accepted the one-row form; an accent bar for a rare width is cosmetic. | — |

#### Not Arc (parity says no, or only after parity) (14)

| Candidate | Synthesiser's reason |
|---|---|
| Disable Status Bar | avg 3.33, skip×3: Arc shows the hovered link; a remove-toggle for a useful indicator. The restyle is plan item 20. |
| A search engine per Space | avg 4.33: not parity, and the omnibox keyword-mode route is a hack over upstream autocomplete; the command-bar half is the only coherent part, after parity. |
| Reader: Chromium's immersive reading mode | avg 5.33, maybe×3: the engine is there (kImmersiveReadAnything on) but de-Googling its WebUI, removing HaTS and suggest-mode, and proving Read Aloud fetches nothing is a privacy audit plus WebUI CSS work on an actively developed feature; not parity. |
| Quiet titles | avg 5.0, maybe×3: stripping '(3)' counts is calm but rewrites every title and can hide information; needs the formatter table checked against real titles before a verdict, and only as a toggle after parity. |
| Quiet: one switch for sound, notifications and counts | avg 3.67: invented scope beyond parity; holding web notifications inside PlatformNotificationServiceImpl is invasive and ⌥⌘Q sits one key from ⌘Q. |
| Load Bar | avg 4.0: Arc's loading cue is the sidebar spinner; a per-tick repaint of the top container needs measuring and it adds a toggle and a moving element to the calm bar; the mute-orange hijack is exactly the noise to avoid. |
| Glass sidebar, riding upstream | avg 3.67: kGlassFrame is off, experimental and macOS-26-only with hit-testing caveats in upstream's own comments; Arc never blurred; must clear the memory and latency budgets; wait for upstream. |
| Transparent Zen | avg 3.0, skip×3: duplicate of Glass sidebar; the images, logo and animation bundle is not Arc and not Stedding. |
| sleek border | avg 3.33: Arc's card is borderless and the mixer removes the hairline on purpose; the contrast-gated corner case is tiny and adds page-colour plumbing into MultiContentsView for little value; revisit with toolbar T7. |
| Zen Back Forward | avg 3.0, skip×3: Arc shows both arrows with forward dimmed; an off-by-default toggle for a non-Arc behaviour breaks the settings convention. |
| Back Fwd Always Hidden | avg 2.67, skip×3: same need with a three-way dropdown and a history submenu to compensate; toolbar T1–T5 are settled. |
| Compact tabs title | avg 3.0, skip×3: monogram badges decorate a Chromium-only rail Arc lacks, plus a setting; the hover card already disambiguates. |
| Custom uiFont | avg 1.33, skip×3: Arc uses the system font, the candidate itself says do not ship, and a blanket typeface override is the re-skin VISION rules out. |
| Disable Rounded Corners | avg 1.0, skip×3: the card is the product's identity, Arc has no such option, and the radius is already a dev parameter for captures. |

#### Not applicable here (nothing to build, or cannot be done in this tree) (2)

| Candidate | Synthesiser's reason |
|---|---|
| Tidy Popup | avg 3.33: macOS context menus are native NSMenu and round 4 signed off the views bubbles; a menu-colour mixer pass can ride a later theme pass but earns no patch. |
| Trackpad Animation | avg 1.0, skip×3: Chromium's history-swipe overlay already exists and Arc uses the same one; nothing to build. |

### Appendix A — every Zen mod

All 77 mods from the catalogue, alphabetical. "Has" is the evaluator's verdict on what
Stedding already has (yes / partial / no / n/a). "Disposition" is an `R6-NN` id, `built`
(already in the tree), or "not now" with the reason in a few words; the 23 mods the
synthesis listed nowhere are closed the way the critic's #33 says. "Key evidence" is a
one-line condensation of the evaluator's evidence field (paraphrased, not quoted).

| Mod | Need | Has | Disposition | Key evidence |
|---|---|---|---|---|
| Add new tab urlbar icon | When one text field serves both 'edit this tab's URL' and 'open a new tab', the user needs a visible mode cue so Enter does not replace the wrong page. | partial | R6-11 (K12 cue, D2) | The two modes sit on different surfaces today (⌘T bar, ⌘L omnibox); the ambiguity arrives with ⌘L in the bar. |
| Animations Plus | Hover and selection colour changes should ease instead of snapping, so the chrome feels alive and less flickery. | partial | not now: waits on the R6-08 gate | Rows and toolbar buttons already ease through GlowHoverController and ink drops; the command bar's chosen row and the folder header hover do not. |
| Audio Indicator Enhanced | See at a glance which sidebar tab is playing and mute it in one click, without the favicon disappearing under the speaker icon on essentials or icon-only tabs; a more polished indicator (hover-to-mute in place, muted state coloured). | partial | R6-03 (R18) | IsChildVisible hides a pinned tab's favicon while the alert shows, so a playing essential loses its icon; no spec row covers the indicator. |
| Audio TabIcon Plus | See at a glance which tab is playing or muted in every tab state (unfocused, discarded) and choose which side the indicator sits on. | partial | R6-03 (R18) | Same layout gap: in the 56 DIP rail the alert takes the single slot; Chromium's AlertIndicatorButton already mutes on click. |
| Back Fwd Always Hidden | Reclaim toolbar space and noise for users who navigate with mouse side buttons, trackpad swipe or ⌘[ / ⌘] and never click the arrows. | partial | not now: Arc shows both arrows | Only a forward-button pref exists (browser.show_forward_button) and it is not a settings toggle here; side buttons already navigate at content level. |
| Better Active Tab | The active tab must be unmistakable at a glance, even when the selected/hover tints or a theme wash the active background out. | yes | built (round 5 #4) | The active row is Arc's filled pill (text colour at 0x24 in dark, white card in light), captured in both modes; an accent bar would be drift. |
| Better CtrlTab Panel | A visible, well-styled Ctrl+Tab switcher over the recently used tabs (Firefox's MRU ctrlTab panel with previews), not a blind jump in strip order. | no | R6-12 | PRODUCT §1 [1.0] and unbuilt: ⌃⇥ is IDC_CYCLE_TO_NEXT_TAB in strip order; kCtrlTabMru is global across windows, Space-blind and draws nothing. |
| Better Find Bar | A ⌘F find bar that reads as part of the window: floating, in the browser's own colours, placeable, with the extra option checkboxes hideable. | partial | R6-06 (U3, U4) | Chromium's find bar is already a floating bubble, but kColorFindBar* are GM3 grey and stedding_color_mixer.cc does not map them. |
| Better Letterboxing | Firefox's resistFingerprinting letterboxing (viewport rounded to fixed sizes with grey margins) looks ugly in Zen; the mod rounds the letterboxed viewport and tints the margins with the accent gradient. | n/a | not now: Firefox-only | Chromium has no letterboxing and no resistFingerprinting; the rounded card on a mat already exists (patch 0002). |
| Better Tab Indicators | See at a glance which row is active (a coloured border) and which tabs are unloaded (dimmed title). | partial | R6-15 (R4) | The active look was settled in round 5; only the discard ring marks an unloaded tab and the title is never dimmed (TabView::UpdateColors). |
| Better UniExtBtn | The extensions toolbar button should not look foreign next to the extension icons; swap it for the browser's own mark or a custom image. | n/a | not now: cosmetic | The button already draws through kColorToolbarButtonIcon like its neighbours; Arc uses a puzzle piece too. |
| Better Unloaded Tabs | Tell at a glance which sidebar rows are not loaded (they will be slow on click and cost no memory), so unloaded tabs read differently from live ones. | partial | R6-15 | TabData::is_tab_discarded reaches the row only as the favicon ring; UpdateColors never looks at the discard state. |
| Big Essentials | Essentials are icon-only cards, so the icon must be big enough to recognise without a label: a 32 px icon with 16 px padding and a grid that fits more cards per row on a wide sidebar. | partial | not now: measure against Arc first | Cards are 50 DIP with an 18 DIP favicon fetched at 16 DIP×scale, so scaling blurs; Arc's icons are roughly 20–22 px in ~44 px cards. |
| Bigger Mute Button | See which sidebar tab is playing sound and mute it in one click, even when the sidebar is collapsed to icons or the tab is an essentials card. | partial | R6-03 (R18) | Upstream does most of it; the verified bug is the essentials card losing its favicon while the alert shows. |
| Bleeding Corners Fix | No light fringe at the rounded corners of the page: Zen rounds the page with CSS border-radius on a container, and the page's html background bleeds through the anti-aliased edge; the mod adds a clip-path at some GPU cost. | yes | built; add a corner probe (critic #33) | Corners are compositor clips (SetIsFastRoundedCorner), not CSS; the page cannot draw outside the mask; window.json probes the corners. |
| Bookmark Toolbar Tweaks | A bookmarks bar that stays out of the way: centred, icon-only, transparent, auto-hidden until hover or omnibox focus. | n/a | R6-28 | PRODUCT §1 "No bookmarks" is unbuilt: BookmarkBarView, ⇧⌘B and the new-tab-page bar are untouched by the series. |
| Cleaned URL bar | The address-bar dropdown should look like a floating frosted panel that matches the rest of the sidebar-style chrome, with a chosen-row colour that is not a saturated accent block. | partial | not now: omnibox popup transient (D2) | The ⌘T bar already is the frosted panel (K6); the ⌘L omnibox popup is untouched Chromium. |
| Cleaner Bookmark Menu | The bookmarks menu should be a list of bookmarks, not a management panel (sidebar, search, show-all, toolbar toggles). | partial | R6-14 (M3), R6-28 | The equivalent is the app menu's "Bookmarks and lists" submenu, untouched and relied on for import (S-30). |
| Clickable Scrollbar | The sidebar's tab list scrollbar is a thin overlay that is hard to see and grab; the user wants a real, clickable, draggable scrollbar when the sidebar is expanded (the mod switches scrollbar-width from thin to auto; its second rule, disabling window dragging on the toolbox, is a Firefox quirk). | partial | not now: overlay is Arc's too | Both sidebar lists use tabs::RoundedScrollBar, a 5 DIP overlay thumb with no track click; no spec row covers sidebar scrolling. |
| Colored container tab | See which container (isolated cookie jar / identity) the active tab belongs to. | no | not now: profiles ADR (R6-31 G5) | Chromium has no containers; the parity item is PRODUCT §2 "Per-Space Profiles" [1.0], and SpaceModel holds name, colour and icon only. |
| Compact tabs title | In the icon-only (collapsed) sidebar, tabs with the same favicon (five GitHub PRs, three Docs) are indistinguishable; show the first 1-3 title characters so they can be told apart without hovering. | partial | not now: rail is not Arc | The collapsed rail hides titles; the only disambiguation is the hover card; Arc has no icon-only mode. |
| Container Halo | See a tab's container identity on every row, active or not, as a full outline rather than Firefox's hairline. | no | not now: profiles ADR (R6-31 G5) | Same: no containers; identity in Stedding is the Space, shown on the ground (B11), not on a row border. |
| Custom MenuButton | Replace the app-menu (hamburger) button's glyph with the browser's own icon or a user-supplied image so the control reads as 'the browser' rather than a generic menu. | n/a | not now: cosmetic | BrowserAppMenuButton keeps kMoreVertIcon; Arc has no in-toolbar menu button at all. |
| Custom Statusbar | Tune the link-URL readout's radius, margin, border thickness and text/border/background colours (including gradients). | no | R6-06 (U1; knobs dropped) | status_bubble_views.cc is vanilla; the knobs conflict with QUALITY and settings T2's one-switch rule. |
| Custom uiFont | Use a personal typeface (serif or any installed family, with an optional text shadow) across the browser chrome. | no | not now: system font is Arc's | Every views label takes the platform font through ChromeTypographyProvider; no pref; parity does not ask for it. |
| CustomCursor | Personalise the pointer over the browser with a preset or a cursor image pulled from a URL or base64 string. | n/a | not now: Firefox-only | userChrome.css cursor rule; Chromium takes the system pointer; the mod fetches its cursor image over the network. |
| Customize Font Size | Readable sidebar text for the individual user: the workspace title, tab titles, the find bar and the footer icons each get a free-form font-size string. | no | R6-27 (Y2) | Tab titles are a Label at the default 12 pt; the Clear label is a hard-coded 11 pt; row height is a feature param, not a pref. |
| Disable Rounded Corners | Square content corners for people who find the rounded web-view card fussy; the readme also claims a GPU saving from dropping Zen's clip-path. | partial | not now: the card is the identity | The 12 DIP radius is already a dev parameter (contents_corner_radius); Chromium rounds through a layer clip, so the GPU claim does not carry. |
| Disable Status Bar | Remove the URL bubble that pops up at the bottom-left of the page on link hover: it flickers on pointer sweeps and covers page content in the corner. | no | not now: Arc shows the hovered link | status_bubble_views.cc untouched; one bubble per contents view; no pref anywhere. |
| DoubleClickless | No accidental new tabs from double- or middle-clicking empty space in the tab sidebar. | n/a | not now: cannot occur here | The vertical strip opens no tab on blank double- or middle-clicks; only tab_view.cc (middle-click close) and folder_view.cc (rename) handle those. |
| Extensions List | Find an extension by name in the extensions popup instead of guessing from an icon grid. | yes | built | ExtensionsMenuMainPageView is already a vertical list of icon, name, pin and site-access rows. |
| Floating History | History as a quick, themed panel over the window, toggled in place with a search field, instead of a full chrome://history tab. | no | not now: Library grows on R6-24 | ⌘Y opens chrome://history as a tab; the History side panel is off (kByDateHistoryInSidePanel) and Chrome-styled; archive A7 is the gap. |
| Floating Status Bar | The hovered-link URL readout should look like part of a rounded floating page card, not a square bar welded into the window corner. | no | R6-06 | StatusView rounds one corner with radius 4 and sits flush at the card's bottom-left, drawing over the rounded corner; no round-4/5 capture hovered a link. |
| Ghost Tabs | Tell unloaded (discarded) tabs and folders from live ones at a glance, so the user knows which rows will reload on click. | partial | R6-15 (R4, R7) | Memory Saver is off in this tree; the discard ring never dims titles or folders; Stedding's answer to stale tabs is the archive. |
| Hidden Reset Button | A pinned tab that has drifted from its pinned page should be one click from returning to it, without a permanent extra button on the row: hide the reset control behind the favicon and reveal it on hover. This is Arc's 'navigated away' indicator plus favicon-click reset. | no | R6-16 (H7) | Neither pin tier stores a URL; peek decides by the tab's current site, not a stored pinned site. |
| Hide Extension Name | On an extension's own page Firefox's identity box prints the extension's name as a label in the URL bar, taking width from the URL; the user wants only the icon. | n/a | not now: Chromium shows no label | On chrome-extension:// pages the chip is only the puzzle icon; the real gap is the inverse (the id shown as the host). |
| Hide Inactive Workspaces | A Space switcher row that stays tidy with many Spaces: show the active one, reveal the rest on hover. | partial | R6-18 | SpaceSwitcherView::Rebuild lays every chip at 24 DIP with a 12 DIP gap and no overflow rule; chips clip at about eight Spaces. |
| Hide Toolbar | Reclaim the address row: hide the toolbar/navbar entirely, reveal it on hover at the top edge with an animation, and choose this in settings (three preferences: enable, animate, top separation). | no | R6-25 (T10, T11) | T1–T6 keep a 33 DIP row always on; PRODUCT §3 records Arc's model as no always-visible URL bar with ⌘⇧D to reveal one. |
| HidePlugins | Hide the extensions puzzle-piece toolbar button; extensions are reached from the menu and the toolbar stays bare. | no | not now: needs a design answer | ExtensionsToolbarDesktop hides the container only with no extensions installed; it also hosts the site-access chip and anchors popups. |
| Improved Collapsed Tabs | With the sidebar collapsed to a rail, still see which tab is active and which plays audio, not close tabs by accident, and get a hint of the title. | partial | R6-03 (R3) | In the rail the layout shows exactly one child in the order close, alert, icon, so hovering the active tab swaps its icon for the close glyph. |
| Lean | Reclaim sidebar rows and toolbar width: show secondary chrome (bottom buttons, translate and page-action icons, the bookmarks bar, the workspace indicator) only on hover, drop the zoom icon, move pinned extensions into the sidebar. | partial | R6-27, R6-28 | Most of the density is baseline already; the bottom row stays as the drag and swipe surface; the bookmark bar still exists. |
| Left close button | Not closing a tab by accident when an expand-on-hover sidebar unfolds under the pointer (Zen with the sidebar on the right: the close button lands under the cursor). | n/a | not now: sidebar is left-only | Expand-on-hover unfolds rightwards, so the pointer lands on the favicon column, not the close glyph. |
| Left Side Glance Buttons | Zen's Glance (its peek) floats its action buttons in a container at one edge of the window; the mod moves them to the other edge for left-sidebar or left-handed layouts. | n/a | not now: Zen-specific layout | Peek keeps its three actions in a 44 DIP header inside the card, each with a key (P7, P9). |
| Load Bar | See page-load progress at the content edge (a sidebar favicon throbber is tiny) and see at once that the current tab is muted. | partial | not now: Arc's cue is the spinner | Loading shows only as the TabIcon throbber and the reload/stop button; nothing paints load progress in top chrome. |
| NavBar Margin | Breathing room above and below the address row; Zen's compact nav bar feels cramped. | yes | built (33 DIP row, T1–T5) | The row is 25 + 3 + 3 DIP measured against Arc and sits on the card since round 5. |
| No pinned tab reset btn | A pinned tab has a home URL and a way back to it, but the affordance should not be a hover button cluttering every pinned row (Zen's .tab-reset-button); the user wants the reset without the noise. | no | R6-16 | No pinned URL exists in SpaceModel; PRODUCT §1 lists the favicon reset and the navigated-away indicator as [1.0]. |
| No Sidebar Scrollbar | A tab list without a permanent scrollbar taking width and attention, but still scrollable. | yes | built | TabStripView::SetScrollViewProperties gives both lists an overlay RoundedScrollBar that takes no width at rest. |
| No Top Sites | Focusing the empty address bar should not push a list of top sites or suggestions at you: a calm bar, and no surprise history on a shared screen. | partial | R6-26 (Q7) | The ⌘T bar stops autocomplete on an empty query; the ⌘L omnibox's most-visited and zero-suggest providers are off by feature default or need Google. |
| NoHighlightSplit | In split view, no coloured outline around the active pane; the two panes should read as equal cards. | no | R6-05 | ContentsContainerOutline paints a 1 px kColorSysOutline ring on the active pane; stedding_color_mixer.cc does not touch the ids. |
| Old navigation buttons | Undo Zen's restyled back/forward/reload glyphs and get Firefox's stock buttons back. | n/a | not now: Firefox-only | Stedding keeps Chromium's back, forward and reload; the Arc reference shows the same three glyphs. |
| Only Close On Hover | Quiet rows: no permanent close glyph on the active tab; the close control appears only under the pointer. | no | R6-03 | IsChildVisible shows the close button when active_ \|\| hovered_or_focused, so the active row always carries the glyph; Arc shows it on hover only. |
| Only Reset On Hover | A pinned tab that has drifted from its pinned page should offer a way back without a permanently visible button cluttering the active row. | no | R6-16 (H6) | No pinned URL exists; same-site drift (a GitHub pin on a PR page) has no way back. |
| Pimp your PiP | A picture-in-picture window that looks like Arc's mini player: no button discs, close and back-to-tab in the corners, a full dim on hover, a thin progress bar that thickens on hover. | partial | not now: with the media idea, later | VideoOverlayWindowViews already has the controls; the auto pop-out is browser-initiated auto-PiP, still a dry run upstream. |
| Private Mode Highlighting | Make a private (incognito) window unmistakable at a glance: a coloured toolbar, a border around the page and an icon, so nobody types into the wrong window. | no | R6-32 (V4) | Stedding removes both incognito cues: the mixer paints the same navy for every dark key and patch 0002 hides the avatar for every window. |
| Quietify | An obvious, pleasant 'this tab is playing sound' signal: an animated equaliser in place of the favicon while audio plays, a flat-bars glyph when muted, click to mute; in the collapsed sidebar the favicon comes back on hover with the indicator shrinking to a corner badge. | partial | not now: a static badge suffices | AlertIndicatorButton shows a static speaker with a 200 ms fade; the throb exists for recording only. |
| Remove Tab X | Stop accidental closes: no close glyph on tab rows (all, or only pinned ones); close by middle-click or ⌘W instead. | partial | R6-16 (H3), R6-03 | Space-pinned rows still show × on hover and pressing it closes the tab outright; Arc unloads and keeps the entry. |
| Secret Theme | A joke: enable it and wait for something silly to happen. | n/a | not now: a joke | The readme says it is a joke; VISION's craft bar rules out gags. |
| Sidebar Expand on Hover | Keep the sidebar as a favicon rail and expand it when the pointer rests on it, with control over widths, expand and collapse delays, animation speed, essentials shown vertically in the rail, faded sleeping tabs and a hidden workspace header. | yes | built (settings T6, T7) | Settings T6 binds vertical_tabs.expand_on_hover_enabled; T7 sets the width; the rail shows one essential per row. |
| sleek border | A faint 1 px semi-transparent hairline around the URL field and the page container so edges read as edges without a heavy frame, a stronger border on hover, and a darker focused omnibox popup. | partial | not now: the card is borderless | The mixer removes the toolbar/content hairline on purpose; the omnibox hover tint (T5) is the affordance the mod wants. |
| Smaller Compact Mode | When the sidebar is hidden and slides in on hover, make the floating panel shorter (vertically centred, 70vh) and let it be narrower than the default minimum. | partial | not now: decide after R6-25 | ⌘S collapses to Chromium's 56 DIP rail, never to nothing; Arc's ⌘S hides the sidebar completely. |
| smaller zen toast popup | Transient notices that do not shout: small, translucent, out of the way, readable on hover. | no | R6-07 | Stedding shows no toasts; Chromium 153's toast framework is unused; the background-tab toast has no counterpart (the sidebar row is the feedback). |
| Super Sleek UI | A denser window: most-visited grid when the address field is empty, a pop-out focused address field that dims the page, a shorter toolbar, no gutters or rounded corners around the page, no border on the unfocused address field. | partial | not now: the scrim may ride R6-11 | The 33 DIP toolbar and no omnibox pill are done; nothing dims the page behind the ⌘T bar; edge-to-edge is refused. |
| SuperPins | Control the density and look of the essentials grid and pinned rows: card width, gap, column count, essentials-as-icons vs rows, position, borders and backgrounds, lazy restore of pinned tabs, dimming of unloaded tabs, favicon and workspace icon sizes, when the separator shows. | partial | not now: column count with Big Essentials | Only the width-derived column count survives (clamp(children, 1, 2) in pinned_tab_container_view.cc). |
| Tab Numbers | See which number Cmd-1..Cmd-9 will hit so keyboard jumps are reliable; numbers must count only essentials plus the active workspace's tabs. | no | R6-13 | No numbers anywhere, and SelectNumberedTab never asks IsTabHidden, so ⌘3 in Space B can activate an unseen tab of Space A. |
| Tab Preview Enhanced | The tab hover card should look native to the browser: the same (Space-tinted) ground, rounded like the rest of the window, a padded thumbnail, no hard border. | partial | not now: measure memory first | Hover cards are Chromium's GoogleGrey900/white and images are off on macOS (kTabHoverCardImages); enabling them captures a thumbnail on every tab hide. |
| Tab Text Size | Readability and density: change the sidebar's text size for tab titles, the workspace (Space) header and folder labels without editing a theme. | no | R6-27 (Y2) | Title, Space title and folder labels read no preference; row height is a feature param. |
| Tab title fixes | Tab titles at 13 px instead of Zen's 11, and tabs that are not loaded (restored but pending, or unloaded) visibly dimmer (icon and title at about 55%) so live tabs stand out at a glance. | partial | R6-15, R6-27 | Default 12 pt with no setting; session-restored tabs are created discarded and the state reaches the view but never dims the title. |
| Tidy Popup | Popup menus and panels that look current: rounded panel, separators rendered as whitespace instead of lines, compact rounded item rows with a strong hover colour, and an optional custom hover colour. | partial | not now: native NSMenu on macOS | Every Stedding context menu is a native NSMenu (MenuRunner routes CONTEXT_MENU to Cocoa); views bubbles were signed off in round 4. |
| TitleBarButton UI Tweaks | On custom-frame platforms the minimize/maximize/close buttons should be smaller, rounded and hover-tinted to match a rounded, tinted UI, with a red close hover. | n/a | not now: native traffic lights | macOS uses native caption buttons; Chromium draws its own only on Windows and Linux, and there is no Windows build yet. |
| Trackpad Animation | Physical feedback for two-finger history swipes: the page nudges and scales with the gesture, with tunable easing and shadows. | partial | built | ChromeRenderWidgetHostViewMacHistorySwiper drives HistoryOverlayController natively; Arc uses the same overlay. |
| Transparent Zen | A window the desktop blurs through (macOS vibrancy), plus a bundle: custom ground colour, background image, empty-tab logo, push-or-mask compact sidebar, tab-switch, URL-bar and trackpad animations with a smoothness preset. | no | not now: Arc never blurred | The ground is painted opaque by SteddingWindowBackground, matching Arc; upstream's kGlassFrame is off and macOS-26-only. |
| Vertical Split Tab Groups | A split's sidebar row is cramped with two tabs side by side at sidebar width; the user wants the pair stacked, with a marker showing they are one item. | partial | not now: one row accepted (round 5 #8) | SplitTabView already stacks the pair at narrow widths; only the together-marker is missing. |
| Winter Spirit | Seasonal decoration: animated snowflakes drifting over the window background, with size and speed knobs. | n/a | not now: seasonal cosmetic | A tiled-PNG overlay; nothing in PRODUCT, UI-SPEC or the Arc reference. |
| Zen Back Forward | Fewer dead controls: hide the back and forward buttons while they cannot do anything. | no | not now: Arc shows both arrows | ToolbarView only toggles enabled state; SetForwardButtonVisibility exists and nothing calls it; toolbar T1–T5 follow Arc. |
| Zen Colored Picker | When choosing a workspace or theme colour, see the real spectrum (a rainbow pad with a grid/frame) instead of a washed-out gradient, so you know what you are picking. | partial | R6-10 (five swatches) | Colours come from five named swatches in the chip menu; the model accepts any SkColor; no reusable colour chooser on Mac. |
| Zen Context Menu | Shorter page and tab context menus: hide items the user never uses, drop icons and separators, tint menus with the workspace colour, reorder the tab menu, prefer copying a tracking-free link. | partial | R6-14, R6-04 (L2) | The tab menu is Chromium's full list plus Stedding's three rows; the page menu is untouched by any patch. |
| Zen Minimal Exit Menu | On Windows/Linux, replace the boxy native minimise/maximise/close buttons with macOS-style coloured circles that suit a sidebar browser. | n/a | not now: macOS first, native | The traffic lights are native; the Windows/Linux frame files are untouched; the mod disables itself on macOS. |

### Appendix B — ideas beyond the catalogue

The 30 ideas from the three lenses (ten each), with the judges' average and the
disposition. Effort and value are the lens's own.

| Lens | Idea | Need | Effort / value | Judges | Disposition |
|---|---|---|---|---|---|
| 1 | Sidebar density presets with one text-size step | No compact mode or text-size control; every row kind has its own hard number. | M / 4 | 6 (maybe×3) | R6-27 |
| 1 | Sleeping tabs: a readable unloaded look plus 'Sleep' as a verb, per tab and per Space | A discarded tab shows only a thin favicon ring; no way to put a tab or a left Space to sleep. | M / 5 | 7 (build×3) | R6-15 |
| 1 | Arc's pinned-tab lifecycle: ⌘W sleeps a pinned tab, the favicon resets it | ⌘W deletes a Space pin; no pinned URL is stored, so no favicon reset and no navigated-away dot. | M / 5 | 8.33 (build×3) | R6-16 |
| 1 | Hold ⌘ to see row numbers, and ⌘1–9 that count what you can see | SelectNumberedTab never asks IsTabHidden, so ⌘N can hit a hidden Space; nobody can learn which row is 3. | M / 4 | 7 (build×3) | R6-13 |
| 1 | ⌃⇥ most-recent switcher with a hold-to-see strip, and Arc's ⌥⌘↑/↓ travel keys | ⌃⇥ walks strip order; ⌥⌘↑/↓ change pane focus invisibly; moving a tab is fn+⌃⇧↑ on a laptop. | M / 5 | 7.33 (build×3) | R6-12 |
| 1 | Inline tab rename that survives restore | PRODUCT §1 "Rename tab" [1.0]; Chromium has no custom title; folders already have the textfield pattern. | M / 4 | 7.33 (build×3) | R6-17 |
| 1 | Card-native find bar and link status | ⌘F drops Chrome's find box under the toolbar and the link status bubble sits square in the card's rounded corner. | M / 3 | 5.67 (build×1, maybe×2) | R6-06 (the pill; the find reposition and the three-way setting dropped) |
| 1 | Media in the sidebar: mute on the row, a now-playing strip, and video that follows you | The speaker competes with the close glyph; the media button lives top-right; Arc pops video out when you leave the tab. | L / 4 | 5.67 (maybe×3) | not now: an L bundle; split and spec first (the badge is R6-03 R18) |
| 1 | Context menus with Stedding's verbs first and Google's gone | The tab, page and app menus still carry Google, Glic, sync and group items that do nothing here. | M / 4 | 6.67 (build×3) | R6-14 |
| 1 | One motion setting, and hover cards that speak only when the title was cut off | Every strip insert, hover glow and hover card animates and obeys only macOS Reduce Motion. | S / 3 | 4.67 (maybe×2, skip×1) | not now: overlaps R6-08; the cut-off-only hover-card rule noted for a later pass |
| 2 | Import from Arc: Spaces, pinned tabs, folders and favorites from StorableSidebar.json | An Arc switcher's whole working life is one local JSON file; rebuilding Spaces by hand is the reason to close the DMG. | M / 5 | 8.33 (build×3) | R6-22 |
| 2 | Arc's keyboard for Spaces: ⌃1–⌃9 to a Space, ⌥⌘←/→ previous/next Space, ⌥⌘↑/↓ tabs, ⇧⌘K Clear, ⌘D pin | Every Space gesture exists except the keyboard; ⌃2 does nothing and ⌥⌘→ selects the next tab. | S / 5 | 8.67 (build×3) | R6-02 |
| 2 | Command bar actions mode: ⇥ after ⌘T (or ⇧⌘P) lists every Stedding and Chromium command with its key | QUALITY gates every feature on the bar, yet the bar lists tabs and omnibox suggestions only. | M / 5 | 9 (build×3) | R6-11 |
| 2 | Air Traffic Control: route sites to Spaces, with the rule made from the tab you are holding | PRODUCT §2 [1.0]; a GitHub link from Slack lands in whichever Space is active. | M / 4 | 7.33 (build×3) | R6-23 |
| 2 | Little window: links from other apps open small, with Move to Space, ⌘O and ⇧⌘O | A link from Mail becomes a full tab in the last window's active Space; Little Arc is not Peek (EVIDENCE.md). | M / 4 | 6.33 (build×1, maybe×2) | R6-30 |
| 2 | Pinned tabs have a home: navigated-away dot, favicon click resets, 'Set pinned URL to this page', hover card with a thumbnail | Neither pin tier remembers a URL; same-site drift leaves a pinned tab elsewhere for good. | M / 4 | 6.33 (maybe×2, build×1) | R6-16 (merged; the thumbnail dropped) |
| 2 | Archived view: what auto-archive and Clear closed, per Space, with the reason, restorable to its Space and searchable from ⌘T | The sweep and Clear drop tabs into the recently-closed list, which forgets Space, folder and reason. | M / 4 | 7.33 (build×3) | R6-24 |
| 2 | Rename a tab in place: double-click the title, persisted across restarts, shown in the sidebar and matched by ⌘T | PRODUCT §1 [1.0]; nothing in the tree renames a tab. | M / 4 | 6 (skip×1, build×1, maybe×1) | R6-17 (merged) |
| 2 | ⇧⌘C copies the URL, ⌥⇧⌘C copies a Markdown link with a rich-text twin, and the bar says Copied | IDC_COPY_URL has no mac chord and ⇧⌘C opens DevTools; no Markdown copy; no feedback. | S / 4 | 6.67 (build×2, maybe×1) | R6-04 |
| 2 | One sidebar for every window: ⌘N opens a window on the same Spaces, essentials and pinned tabs | SpaceModel is per window, so ⌘N yields a lone "Space 1" with no essentials; reads as data loss. | L / 4 | 6.33 (maybe×2, build×1) | R6-31 |
| 3 | The bar goes with the sidebar | ⌘S collapses the strip but the 33 DIP page bar stays, so the hidden state is still chrome. | M / 5 | 7 (build×2, maybe×1) | R6-25 (T9 dropped by D2) |
| 3 | Private windows wear a different coat | A private window has the same ground and chips; Spaces, tint and the archiver all run in it. | M / 4 | 8 (build×3) | R6-32 |
| 3 | Reader: Chromium's immersive reading mode, made Stedding's | Reading mode ships behind ⌥⌘R with Google fonts, a HaTS survey and voice downloads; no entry point. | M / 4 | 5.33 (maybe×3) | not now: not parity; a privacy audit plus WebUI work on an active feature |
| 3 | Tracker-free defaults as one settings block | PRIVACY.md promises defaults the tree does not have (third-party cookies, HTTPS-First, error-page lookups, GPC). | M / 5 | 7.67 (build×3) | R6-26 |
| 3 | Copy clean link on Shift-Cmd-C, Markdown on Option-Shift-Cmd-C | PRODUCT §1 lists copy URL and Markdown [1.0]; CopyURL writes the URL verbatim, tracking parameters included. | S / 4 | 6.67 (skip×1, build×2) | R6-04 (merged) |
| 3 | A search engine per Space | A Work Space on Kagi and a Personal Space on DuckDuckGo; neither Arc nor Zen offers it. | M / 3 | 4.33 (maybe×2, skip×1) | not now: not parity; the omnibox keyword route is a hack over upstream autocomplete |
| 3 | Quiet titles | Rows read "(3) Slack \| Acme"; every count is a pull at the start of every row. | S / 3 | 5 (maybe×3) | not now: after parity, as a toggle; check the formatter against real titles first |
| 3 | Quiet: one switch for sound, notifications and counts | Focus means no tab plays and no site notifies; today that is a mute click per tab. | M / 3 | 3.67 (maybe×1, skip×2) | not now: invented scope; holding notifications is invasive and ⌥⌘Q sits beside ⌘Q |
| 3 | Glass sidebar, riding upstream | Transparent Zen is the most-installed mod; Chromium 153 carries kGlassFrame off by default. | M / 3 | 3.67 (maybe×1, skip×2) | not now: kGlassFrame is off, experimental, macOS-26-only; Arc never blurred |
| 3 | Motion follows the system | QUALITY requires respecting reduce motion; nothing in the series checks it. | S / 2 | 5.67 (build×2, maybe×1) | R6-08 |

### Appendix C — judges

The three judges' scores merged by candidate, highest average first. Verdicts are
build / maybe / skip in judge order; a dash means that judge did not score it. The 23
mods the synthesis listed nowhere were not judged (Appendix A closes them).

| Candidate | Average | Judge 1 | Judge 2 | Judge 3 | Scores |
|---|---|---|---|---|---|
| Command bar actions mode: ⇥ after ⌘T (or ⇧⌘P) lists every Stedding and Chromium command with its key | 9 | build | build | build | 9, 9, 9 |
| Arc's keyboard for Spaces: ⌃1–⌃9 to a Space, ⌥⌘←/→ previous/next Space, ⌥⌘↑/↓ tabs, ⇧⌘K Clear, ⌘D pin | 8.67 | build | build | build | 9, 9, 8 |
| Arc's pinned-tab lifecycle: ⌘W sleeps a pinned tab, the favicon resets it | 8.33 | build | build | build | 9, 8, 8 |
| Import from Arc: Spaces, pinned tabs, folders and favorites from StorableSidebar.json | 8.33 | build | build | build | 9, 8, 8 |
| Private windows wear a different coat | 8 | build | build | build | 8, 8, 8 |
| Tracker-free defaults as one settings block | 7.67 | build | build | build | 8, 7, 8 |
| Air Traffic Control: route sites to Spaces, with the rule made from the tab you are holding | 7.33 | build | build | build | 8, 7, 7 |
| Archived view: what auto-archive and Clear closed, per Space, with the reason, restorable to its Space and searchable from ⌘T | 7.33 | build | build | build | 8, 7, 7 |
| Inline tab rename that survives restore | 7.33 | build | build | build | 8, 7, 7 |
| Only Close On Hover | 7.33 | build | build | build | 7, 7, 8 |
| ⌃⇥ most-recent switcher with a hold-to-see strip, and Arc's ⌥⌘↑/↓ travel keys | 7.33 | build | build | build | 8, 7, 7 |
| Hold ⌘ to see row numbers, and ⌘1–9 that count what you can see | 7 | build | build | build | 7, 7, 7 |
| Sleeping tabs: a readable unloaded look plus 'Sleep' as a verb, per tab and per Space | 7 | build | build | build | 7, 7, 7 |
| The bar goes with the sidebar | 7 | build | maybe | build | 8, 6, 7 |
| Context menus with Stedding's verbs first and Google's gone | 6.67 | build | build | build | 7, 7, 6 |
| Copy clean link on Shift-Cmd-C, Markdown on Option-Shift-Cmd-C | 6.67 | skip | build | build | 5, 7, 8 |
| ⇧⌘C copies the URL, ⌥⇧⌘C copies a Markdown link with a rich-text twin, and the bar says Copied | 6.67 | build | build | maybe | 8, 6, 6 |
| Hide Inactive Workspaces | 6.33 | build | build | maybe | 7, 7, 5 |
| Little window: links from other apps open small, with Move to Space, ⌘O and ⇧⌘O | 6.33 | build | maybe | maybe | 7, 6, 6 |
| NoHighlightSplit | 6.33 | build | build | build | 6, 6, 7 |
| One sidebar for every window: ⌘N opens a window on the same Spaces, essentials and pinned tabs | 6.33 | maybe | build | maybe | 7, 7, 5 |
| Pinned tabs have a home: navigated-away dot, favicon click resets, 'Set pinned URL to this page', hover card with a thumbnail | 6.33 | maybe | build | maybe | 6, 7, 6 |
| Hide Toolbar | 6 | maybe | build | maybe | 6, 7, 5 |
| Private Mode Highlighting | 6 | skip | build | maybe | 5, 7, 6 |
| Rename a tab in place: double-click the title, persisted across restarts, shown in the sidebar and matched by ⌘T | 6 | skip | build | maybe | 5, 7, 6 |
| Sidebar density presets with one text-size step | 6 | maybe | maybe | maybe | 6, 6, 6 |
| smaller zen toast popup | 6 | build | build | build | 6, 6, 6 |
| Bigger Mute Button | 5.67 | build | maybe | maybe | 6, 6, 5 |
| Card-native find bar and link status | 5.67 | build | maybe | maybe | 6, 6, 5 |
| Floating History | 5.67 | maybe | maybe | maybe | 6, 6, 5 |
| Floating Status Bar | 5.67 | skip | build | build | 5, 6, 6 |
| Hidden Reset Button | 5.67 | skip | build | maybe | 5, 7, 5 |
| Media in the sidebar: mute on the row, a now-playing strip, and video that follows you | 5.67 | maybe | maybe | maybe | 6, 6, 5 |
| Motion follows the system | 5.67 | build | build | maybe | 6, 6, 5 |
| No Top Sites | 5.67 | build | maybe | maybe | 6, 6, 5 |
| Better CtrlTab Panel | 5.33 | skip | maybe | maybe | 5, 6, 5 |
| Cleaned URL bar | 5.33 | maybe | maybe | build | 5, 5, 6 |
| Improved Collapsed Tabs | 5.33 | maybe | maybe | build | 5, 5, 6 |
| Reader: Chromium's immersive reading mode, made Stedding's | 5.33 | maybe | maybe | maybe | 6, 5, 5 |
| Smaller Compact Mode | 5.33 | maybe | maybe | maybe | 6, 5, 5 |
| SuperPins | 5.33 | maybe | maybe | build | 5, 5, 6 |
| Tab Numbers | 5.33 | skip | maybe | maybe | 5, 6, 5 |
| Tab Preview Enhanced | 5.33 | maybe | build | maybe | 5, 6, 5 |
| Zen Colored Picker | 5.33 | build | maybe | skip | 6, 6, 4 |
| Audio Indicator Enhanced | 5 | skip | maybe | maybe | 4, 6, 5 |
| Audio TabIcon Plus | 5 | skip | maybe | build | 4, 5, 6 |
| Better Find Bar | 5 | skip | maybe | build | 4, 5, 6 |
| Better Tab Indicators | 5 | skip | maybe | maybe | 4, 6, 5 |
| Big Essentials | 5 | maybe | maybe | maybe | 5, 5, 5 |
| HidePlugins | 5 | maybe | maybe | maybe | 5, 5, 5 |
| Quiet titles | 5 | maybe | maybe | maybe | 4, 5, 6 |
| Zen Context Menu | 5 | skip | maybe | skip | 5, 6, 4 |
| Better Unloaded Tabs | 4.67 | skip | maybe | skip | 5, 5, 4 |
| Lean | 4.67 | maybe | maybe | skip | 5, 5, 4 |
| No pinned tab reset btn | 4.67 | skip | maybe | skip | 4, 6, 4 |
| One motion setting, and hover cards that speak only when the title was cut off | 4.67 | maybe | maybe | skip | 5, 5, 4 |
| Only Reset On Hover | 4.67 | skip | maybe | skip | 4, 6, 4 |
| Pimp your PiP | 4.67 | maybe | maybe | skip | 5, 5, 4 |
| Super Sleek UI | 4.67 | maybe | maybe | maybe | 5, 4, 5 |
| A search engine per Space | 4.33 | maybe | maybe | skip | 5, 4, 4 |
| Add new tab urlbar icon | 4.33 | maybe | maybe | skip | 5, 5, 3 |
| Clickable Scrollbar | 4.33 | maybe | maybe | skip | 5, 5, 3 |
| Customize Font Size | 4.33 | skip | maybe | skip | 4, 5, 4 |
| Remove Tab X | 4.33 | skip | maybe | skip | 4, 5, 4 |
| Tab Text Size | 4.33 | skip | maybe | skip | 4, 5, 4 |
| Tab title fixes | 4.33 | skip | maybe | skip | 4, 5, 4 |
| Animations Plus | 4 | maybe | maybe | skip | 4, 4, 4 |
| Cleaner Bookmark Menu | 4 | skip | maybe | skip | 4, 5, 3 |
| Load Bar | 4 | skip | maybe | maybe | 3, 4, 5 |
| Quietify | 4 | — | maybe | — | 4 |
| Ghost Tabs | 3.67 | skip | maybe | skip | 3, 4, 4 |
| Glass sidebar, riding upstream | 3.67 | maybe | skip | skip | 4, 3, 4 |
| Quiet: one switch for sound, notifications and counts | 3.67 | maybe | skip | skip | 4, 3, 4 |
| Disable Status Bar | 3.33 | skip | skip | skip | 3, 3, 4 |
| sleek border | 3.33 | skip | maybe | skip | 3, 4, 3 |
| Tidy Popup | 3.33 | skip | maybe | skip | 3, 4, 3 |
| Vertical Split Tab Groups | 3.33 | skip | maybe | skip | 3, 4, 3 |
| Compact tabs title | 3 | skip | skip | skip | 3, 3, 3 |
| Transparent Zen | 3 | skip | skip | skip | 3, 3, 3 |
| Zen Back Forward | 3 | skip | skip | skip | 3, 3, 3 |
| Back Fwd Always Hidden | 2.67 | skip | skip | skip | 3, 2, 3 |
| Custom uiFont | 1.33 | skip | skip | skip | 1, 1, 2 |
| Disable Rounded Corners | 1 | skip | skip | skip | 1, 1, 1 |
| Trackpad Animation | 1 | skip | skip | skip | 1, 1, 1 |

### Appendix D — the critic, verbatim

The completeness critic's output, unchanged, with one disposition line after each
numbered point (adopted as a decision, folded into an item, or declined with the reason).

> RESULT:
>
> 1. [correction, bug] "Close Other Tabs" / "Close Tabs to the Right" are not Space-scoped: `TabStripModel::GetIndicesClosedByCommand` (`/Users/Shared/chromium/src/chrome/browser/ui/tabs/tab_strip_model.cc:3605`) never asks `IsTabHidden`, so item 6's kept "Close Others" and new "Clear Below" close tabs in other Spaces and inside collapsed folders. Same family as R10; add `TabStripModelTest.CloseOthersStaysInsideTheSpace` to item 4 or 6.
>
> → Disposition: folded into R6-14 (M5); test named there.
>
> 2. [missing, [1.0]] ⌘L into the command bar (PRODUCT §3): items 1 and 18 both build around the omnibox keeping ⌘L (T9 floats a pill for it) while PRODUCT removes the URL bar at 1.0. Decide now as K12 (⌘L opens the bar prefilled with the URL selected; Escape returns) or record the divergence; otherwise item 18 T9 is work that 1.0 deletes.
>
> → Disposition: adopted as D2 (R6-11 K12; R6-25 T9 dropped).
>
> 3. [missing, [1.0]] Imported bookmarks → pinned tabs and folders (PRODUCT §1). Welcome W3 imports bookmarks into a model nothing shows except Chromium's bar on the new tab page and the star in the location bar; item 11 covers Arc only. Add: each bookmark folder becomes a Space-pinned folder tree, then hide the bar, the star and the Bookmarks submenu (closes the "Lean"/"Cleaner Bookmark Menu" leftovers).
>
> → Disposition: adopted: new item R6-28.
>
> 4. [missing, [1.0]] Multi-select (PRODUCT §12): ⌘/⇧-click then act. Item 6's menu shows no plurals ("Close 3 Tabs", "Move 3 Tabs to ▸"), and items 1, 2 (⌘D), 5, 7, 12 all say "the active tab". `TabMenuModel` already reads `selection_model()` (tab_menu_model.cc:111); specify selection semantics once and cite it from each item.
>
> → Disposition: adopted as D3: new item R6-20; each item cites it.
>
> 5. [missing, [1.0]] Split view as a unit (PRODUCT §4): no item pins, Space-pins, renames or restores a split as one row, and no item names a split rule for ⌘W (8), ⌘D (2), rename (10), ⌘N counting (4), ⌃⇥ cells (3), Sleep (7), Move to Space (1/12). One "splits.md" spec, referenced by each.
>
> → Disposition: adopted: new spec R6-19 (splits.md), cited by R6-12, R6-13, R6-15, R6-16, R6-17, R6-20.
>
> 6. [missing] The in-product shortcut reference (QUALITY.md:102, ROADMAP.md:201) does not exist (grep: only the two citations), yet items 2, 5, 15, 18 "record divergences in the shortcut reference". Ship it first: a Shortcuts block in chrome://settings/stedding generated from the accelerator tables, with divergence rows; remapping (PRODUCT §12 [1.0]) later.
>
> → Disposition: adopted: new item R6-01, first in wave 1.
>
> 7. [missing, [1.0]] Sidebar backups (PRODUCT §1; EVIDENCE #2 "restore that never loses a tab"): periodic JSON snapshots of Spaces/pins/folders on Arc's schedule, "Restore sidebar…" in settings. Make the file item 11's plan format so import/export round-trip; it is also Export Space ([1.0]) and the honest file-based answer to sync (475 upvotes).
>
> → Disposition: adopted: new item R6-29, sharing R6-22's file format.
>
> 8. [correction] Bigger Mute Button's verified bug (a playing essentials card loses its favicon: `IsChildVisible` hides `icon_`) is a shipped defect against PRODUCT "Audio indicator and mute [1.0]", not a "later fixup". Fold into item 9's `IsChildVisible` hunk: favicon plus corner badge, click mutes, right-click mutes a silent tab, works in a split.
>
> → Disposition: adopted (D1): folded into R6-03 as R18.
>
> 9. [missing, [1.0]] Per-Space Profiles (PRODUCT §2): absent. The two undispositioned container mods (Container Halo, Colored container tab) are the demand signal. At minimum item 16's ADR 0016 must say a registry Space can carry a profile id so the model does not preclude it.
>
> → Disposition: adopted (D1): R6-31 G5; the ADR must say a registry Space can carry a profile id.
>
> 10. [missing] Space reorder by dragging a chip (PRODUCT §2 [1.0]): not built (`SpaceModel` has no MoveSpace, space_model.h) and not planned. Add B27 to item 14, with the Space menu "Move left/right" as the keyboard path.
>
> → Disposition: adopted (D1): R6-18 B27.
>
> 11. [missing] Backlog rows S-41 (download progress on the sidebar button), S-42 (Space colour on welcome; the "Zen Colored Picker" skip says five swatches is the ask), S-43 (About version) have no owner in the plan; 21 closes S-40 only.
>
> → Disposition: adopted (D1): R6-09 (S-43), R6-10 (S-42), R6-21 (S-41).
>
> 12. [under-spec, 2] ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N", on by default once a second desktop exists; Arc users hit this. Record in the reference and welcome step 5, and give the Spaces menu rows so the chords are discoverable when eaten.
>
> → Disposition: adopted as D5 (R6-02 B30, R6-01 Z3).
>
> 13. [under-spec, 2] ⌘D on an essential (Chromium-pinned) tab: refuse, unpin to Space-pin, or no-op (F8 refuses folders for pins; B21 says nothing). ⇧⌘K and ⌃1–9 in a private window (V2: no Spaces) must be disabled in the controller.
>
> → Disposition: adopted as D4 (R6-02 B28, B29).
>
> 14. [under-spec, 6] Item 6 hides tab groups from the menu but leaves the group chords live (⌥⌘P/C/W/X/Z, global_keyboard_shortcuts_mac.mm:169-178, called "untouched" in item 1). Remove them in the same hunk or a rebase re-exposes a hidden feature by keyboard.
>
> → Disposition: adopted (D1): R6-14 M6.
>
> 15. [under-spec, 6] Four menus, not one: essentials card (Remove from Essentials, no Move to Space, no folder), folder header, split row, Space-pinned row (Unpin, Reset to Pinned Page, Make This the Pinned Page). M1 lists only the plain row.
>
> → Disposition: adopted (D1): R6-14 M7.
>
> 16. [under-spec, 1] ⇥ with text already typed (Arc filters to actions from any state; ⇧⇥ back), Escape in actions mode (back to tabs or close), the row set in private and popup windows, actions with no target (essentials in "Move to Space", a peek open), and dropdown prefs (archive hours, sleep minutes, density) that "one on/off row per stedding.* preference" cannot express.
>
> → Disposition: adopted as D6 (R6-11 K13–K17).
>
> 17. [under-spec, 4] R11's badge slot on essentials cards (grid, no close slot) and in the collapsed rail; whether a split row counts as one ⌘N or two; sleeping rows numbered the same.
>
> → Disposition: adopted as D7 (R6-13 R19).
>
> 18. [under-spec, 8] An essentials card is icon-only, so H5's "favicon column" is the whole card: a click on a drifted essential would reset instead of activate. Arc activates and shows the reset on hover; say which. H3 with a Space holding only pins: ⌘W sleeps the last visible tab and B4 opens a new tab — intended?
>
> → Disposition: adopted as D8 (R6-16 H10, H11); the side-by-side check in Arc comes first.
>
> 19. [under-spec, 11] Arc's sidebar JSON also holds split-view items, archived items and the per-Space profile binding: say each is mapped or dropped. Arc rewrites the file while running: read a copy and warn if Arc is open. Map `windowTheme` to the nearest Stedding swatch; cap favorites at 12 (nothing in the tree caps essentials); make a second import idempotent (Arc item id as the key).
>
> → Disposition: adopted as D9 (R6-22 I7–I12).
>
> 20. [under-spec, 18] Where extension actions (⌘E cycles them, PRODUCT §12 [1.0]), the global-media button, page-info and permission chips live when the row is hidden; Arc parks extensions in the sidebar. T9 in immersive fullscreen (the overlay owns the row) and the split mini-toolbars with no row above them.
>
> → Disposition: adopted as D10 (R6-25 T13); the split mini-toolbars stay TBD.
>
> 21. [under-spec, 21] Toast placement: Chromium anchors top-centre under the toolbar, Arc bottom-centre of the content; decide once, since C6 declares this the style for every later toast, and item 18 removes the anchor view.
>
> → Disposition: open: TBD in R6-07 (decide the placement once, before C6).
>
> 22. [under-spec, 22] PRIVACY.md's own to-do table is only half covered: translate off, preloading (`net.network_prediction_options`) off, network time off, component-updater endpoint, dummy API keys. Say each is in the Q block or why not; Q1 (third-party cookies) needs the site-breakage row visible in the block, not only the ADR.
>
> → Disposition: open: TBD in R6-26 (a Q row or a one-line reason per PRIVACY.md to-do).
>
> 23. [under-spec, 3] What a split is in the strip (one cell or two), tabs inside collapsed folders (hidden: skipped or listed), ⌃⇥ while a peek or the command bar is open, and the strip's ⌃-release prototype needs a fallback if `flagsChanged` never reaches Views (a tap-only mode).
>
> → Disposition: partly: the split is R6-19 J2; the rest TBD in R6-12 before X3's prototype.
>
> 24. [under-spec, 5] ⇧⌘C inside a peek copies the peek's URL (Arc does; the peek has no address row); the Markdown title uses item 10's custom name or the page title — say which; L5's toast in a peek anchors where.
>
> → Disposition: open: TBD in R6-04.
>
> 25. [under-spec, 10] Rename a split row as a unit; rename from ⌘T while the sidebar is collapsed (no slot for the textfield: expand first or edit in a bubble); essentials rename only reaches the hover card, say so in the UI.
>
> → Disposition: partly: the split is R6-19 J1; the collapsed-sidebar and essentials cases TBD in R6-17.
>
> 26. [under-spec, 12] Multi-window (16): routes are per profile but external_default names a Space in which window; a route whose site is Space-pinned in the target Space: open a duplicate or activate the pin.
>
> → Disposition: open: TBD, answered with R6-31 (multi-window) and checked in Arc first (the critic's unsure line).
>
> 27. [under-spec, 7] Sleeping a tab that is in a split (Chromium may refuse to discard); the essentials card's slept look (card alpha) and the collapsed rail's dimmed icon are unnamed; R6's timer per window vs. per registry after 16.
>
> → Disposition: partly: the split is R6-19 J4; the slept looks TBD in R6-15; the timer scope decided with R6-31.
>
> 28. [under-spec, 13] ⇧⌘T already restores to the tab's Space (`browser_tabrestore.cc:90`, `RestoreSpaceFromExtraData`); A8 should ride that path and add the folder path, which it does not restore today. The "Archived" row in the collapsed rail (icon), dark and light.
>
> → Disposition: folded into R6-24 as implementation guidance (A8 rides RestoreSpaceFromExtraData).
>
> 29. [cross-cutting] Every new chord lands only in the mac tables (accelerators_cocoa.mm, global_keyboard_shortcuts_mac.mm); M8 Windows redoes all of it. Bind cross-platform ids in accelerator_table.cc with platform modifiers where possible, or state that the mac tables are deliberate.
>
> → Disposition: open: TBD; R6-01 Z2 states whether the mac tables are deliberate before the first keyboard patch.
>
> 30. [cross-cutting] Light/dark and fullscreen captures are named for 7, 9, 14, 20, 21 but not for the new surfaces in 3 (strip), 4 (badges), 10 (textfield), 13 (archive WebUI), 15 (little-window bar), 18 (pill); QUALITY requires both plus a probe for each.
>
> → Disposition: adopted as a rule (How it was worked, rule 7): every new surface captured dark and light with a probe.
>
> 31. [cross-cutting] No item names a VoiceOver role or a keyboard-only path (QUALITY accessibility gate): the ⌃⇥ strip, ⌘-held badges, inline rename, the archive page, the little-window bar, the Space chips as dots.
>
> → Disposition: adopted as a rule (How it was worked, rule 7): a VoiceOver role and keyboard path per new surface before "built".
>
> 32. [missing, cheap] "New Documents" (PRODUCT §7 [1.0]): one URL pref and a ⌘T action "New document" in item 1; "Collapse Pinned Tabs" (§1 [1.0]): a collapsible pinned run, one row in item 8 or 2.
>
> → Disposition: declined for round 6: neither "New Documents" nor "Collapse Pinned Tabs" is in the decisions; both stay PRODUCT §7/§1 [1.0] items for a later round.
>
> 33. [completeness] 23 catalogue mods are in neither list; close them: Container Halo, Colored container tab → per-Space profiles (9); Bookmark Toolbar Tweaks → no bookmark bar (3); Bleeding Corners Fix → add a probe for the anti-aliased ring at the card corners over a white page in dark mode (window.json has none); Sidebar Expand on Hover → already settings T6; Custom Statusbar → item 20; Better Active Tab → settled in round 5 #4; Firefox-only or cosmetic, skip with one line each: Left close button, Left Side Glance Buttons, DoubleClickless, Hide Extension Name, Extensions List, Better Letterboxing, No Sidebar Scrollbar, NavBar Margin, Old navigation buttons, TitleBarButton UI Tweaks, Zen Minimal Exit Menu, Custom MenuButton, Better UniExtBtn, CustomCursor, Secret Theme, Winter Spirit.
>
> → Disposition: adopted: Appendix A closes all 23 the way this point says.
>
> 34. [better than the mod] Item 21: give the capture toast a thumbnail and "Show in Finder" plus Arc's bottom placement; item 14: the name pill on a dot hover, not only on chips; item 6: chords drawn in the menu (already planned) plus plural verbs (4); item 11: the round-trip export (7) makes Stedding's Arc import strictly better than Arc's own, which imports nothing from Arc.
>
> → Disposition: partly: thumbnail and Show in Finder are in C5 (placement is #21); the name pill on dots joins B25; chords plus plurals are M1/M7 with R6-20; the round trip is R6-29.
>
> unsure: Arc's exact behaviour for a click on a drifted Favorite (activate vs. reset) and whether Arc routes an ATC match into an existing pinned tab — confirm by side-by-side in Arc before writing H5 and D2.

Disposition of the unsure line: the two checks are the first step of R6-16 (H10) and R6-23 (D2); neither test is written before Arc is looked at side by side.

## The operator's rounds

> **History.** The ledger of the operator's feedback rounds 2 to 11 (2026-09-01 to
> 2026-10-02): what each round found, what was fixed and how it was checked. Rounds 8 to 11
> follow in the order they were written, not by number. It is kept because feature specs,
> patches and release notes cite its rounds and rows. It is not a list of open work: what
> stayed open went to `PLAN.md` and `BACKLOG.md`. The operator's passes after round 11 (on
> beta 12, patch 0059, and after beta 13, patches 0060 and 0061) have no round here; they are
> in `docs/PROJECT-LOG.md`.

### Round 2 — operator feedback from the first DMG (2026-09-01)

Nine defects from real use, windowed and fullscreen, compared against Arc
fullscreen. Each gets fixed and verified by capture; this file tracks status.

| # | Defect | Plan | Status |
|---|---|---|---|
| 1 | Fullscreen: URL bar full width again | Could not reproduce: the cap holds in --start-fullscreen (289 pt) and through a real ⌘L focus cycle (465 pt, centred). What the screenshots show is consistent with the 460 cap filling a modest window; the cap is now 380 (patch 0002). Retested 2026-09-02 in real fullscreen by capture: holds, centred, focused and not | done |
| 2 | Space switcher broken | **Fixed** — 28 DIP chips spread across the full width, + at the end; hover floats the Space's name in a pill above the chip with no layout shift, verified by synthetic hover (patch 0004) | done |
| 3 | Tab favicons repeat | **Fixed** — DrawImageInt tiled a 16 px bitmap into the 18 px slot (SkTileMode::kRepeat on src/dest mismatch); source rect is now the image's own size, verified crisp at zoom (patch 0002) | done |
| 4 | Site icon clipped in pill | Not reproducible after the tiling fix; pill renders clean at zoom. Retested 2026-09-02 in real fullscreen by capture: clean | done |
| 5 | One rounded corner looks odd | **Fixed** — the card floats on a mat with all four corners rounded, via MultiContentsView's own layout so the web layer stays in step; orphaned floating corners silenced (patch 0002) | done |
| 6 | Help page error code 0 | **Fixed** — Stedding mac updater stub reports a plain disabled state; Keystone was never shipped (patch 0006) | done |
| 7 | Folders | **Deferred to its own milestone, with the map drawn.** Research confirmed nothing constructs a FOLDER today, and true nesting means threading a folder id through TabStripCollection::MoveTabsRecursive/GetMovePosition the way TabGroupId is — invariant-heavy model surgery that should not ride a ten-fix batch. The group-creation pipeline to mirror is recorded in the research; groups remain the interim container. *Since: built in round 3, below (patch 0008, ADR 0013).* | planned |
| 8 | Clear line position | **Fixed** — Clear lives on TabStripView's pinned/unpinned separator, which now shows whenever both exist (patch 0004) | done |
| 9 | Pin tiers | **Fixed** — Chromium pin = essentials (grid, global); new per-Space pin in SpaceModel, persisted and restored, Clear skips it, tab context menu carries Pin/Unpin to This Space (patch 0004) | done |

Method: no fix is done until a capture shows it.


### Round 3 — folders and colours (operator request, 2026-09-01)

| Item | State |
|---|---|
| Colours | **Done** (patch 0007) — light #C8B377; dark a #21263A→#31243A top-left→bottom-right gradient painted once by `SteddingWindowBackground` on BrowserView, with sidebar, top container and mat invisible over it so it reads as one surface. Both modes verified by pixel probe and capture |
| Folders: create | **Done** (patch 0008) — tab context menu → Move Tab to New Folder; `TabStripModel::AddToNewFolder` wraps `MoveTabsToNewFolderRecursive`, which attaches through the same primitive as detached groups |
| Folders: nest | **Done** — a folder made from a tab already in a folder nests inside it; verified by capture (outer folder holding a tab + a nested folder holding its own tab) and by the model unit test |
| Folders: header/collapse/rename | **Done** — chevron+name header one tab-row tall, click collapses (hidden from Ctrl+Tab via the IsTabHidden contract, nested included), double-click renames in place |
| Folders: persistence | **Built, unit-verified** — per-tab folder ancestry in session extra data, rebuilt after restore through the same AddToNewFolder path; `FolderSessionTest.RebuildsNestedFoldersFromParkedPaths` covers the nested round trip. A live restart check is pending a real menu-quit: SIGTERM from this harness does not reliably flush Chromium's session files, which is a harness limit, not a product path |
| Folders: drag-into | Not built — moving into folders is menu-driven this round; drag targets on folder rows are the natural follow-up |

Known interim: the tab-strip mojo API maps FOLDER to its plain-container
variant until the mojom grows a Folder type (recorded in patch 0008).


### Round 4 — visual audit (2026-09-02)

A pass over every surface by capture on the release build, dark mode first.

| Item | State |
|---|---|
| Hovered / selected tab rows turned Material blue | **Fixed** (patch 0007) — hover and select tint with the row's own text colour at a low alpha; measured (50, 52, 71) on the navy ground instead of (29, 73, 116) |
| Command bar: saturated blue chosen row, tiny type, fixed near-black panel | **Fixed** (patch 0005) — theme dialog colours, text-tinted highlight, +3 pt type, 44 px rows |
| Space menu: bare emoji rows, colour names without swatches | **Fixed** (patch 0004) — "🏠 Home" style labels, a circle swatch beside each colour; the first attempt used a generator-backed icon and crashed Cocoa's menu controller, so the swatch is a plain image |
| Tab-strip background menu offered "Show Tabs Horizontally" and Google's feedback link | **Fixed** (patch 0001) — Google's feedback link gone in Stedding mode; Collapse and auto-expand stay. The horizontal-tabs switch came back on 2026-09-28: the owner keeps horizontal tabs as a mode (`PLAN.md`, decision 1), so every menu offers it again and the mode now keeps Spaces, pins and folders (spaces B34, menus M8–M9) |
| Light mode: settings header and About page showed Chromium's own small logo (the 1x/2x scaled assets live in `default_{100,200}_percent/chromium/`, outside the directory branding covered) | **Fixed** (branding) — the mark rasterised at 16/32 px for 1x and 2x, plus a "Stedding" wordmark for the payment sheet; verified in light |
| Light mode audit: tab rows, hover tint, command bar, Space menu, settings, peek | All hold in light; captures 2026-09-02 |
| Fullscreen: nav buttons sit over the sidebar column instead of over the content | **Fixed** (patch 0002) — in immersive fullscreen the layout starts the overlay's toolbar where the strip ends; captured in real fullscreen (⌃⌘F): nav buttons right of the sidebar, omnibox centred over the content |
| Space tint lands on the page (the new tab page goes plum) rather than on the sidebar as Arc does | **Fixed** (patch 0007) — the active Space's colour blends into the window ground; the new tab page keeps a neutral ground; verified with two Spaces in dark and light |
| Light mode: hairline between toolbar and the content card | **Fixed** (patch 0007) — separator takes the toolbar colour |


### Round 4 sign-off (2026-09-02, release build, captures via `tooling/drive`)

Every surface looked at in both modes; "holds" means no defect found against
`docs/PRODUCT.md#ui-spec` and the Arc reference at 2× zoom.

| Surface | Dark | Light | Verdict |
|---|---|---|---|
| Window ground, sidebar, mat, content card corners | captured | captured | holds; probes 14/14 |
| Tab rows: active, inactive, hover, selected, favicon, close glyph | captured | captured | holds after the neutral hover/select tint |
| "+ New Tab" row, essentials grid, Clear line | captured | captured | holds |
| Tab context menu, strip background menu | captured | captured | holds; no horizontal-tabs or feedback items |
| Space switcher: chips, hover name pill, context menu (icons, swatches) | captured | captured | holds; menu no longer crashes |
| Space tint (two Spaces) on the ground; new tab page neutral | captured | captured | holds |
| Command bar: panel, field, rows, chosen row | captured | captured | holds |
| New tab page: hint line, shortcuts, neutral ground | captured | captured (earlier in the day) | holds |
| Peek: card, header, buttons, scrim | captured | captured | holds |
| chrome://settings: Stedding section, landing page, header logo, About | captured | captured | holds; logo branded in both modes |
| Fullscreen: toolbar placement, omnibox cap, pill icon | captured | — | holds after patch 0002's overlay inset |
| Toolbar/content hairline | — | captured | gone |

Not changed on purpose: the light-mode sand (`#C8B377`) is the operator's
colour choice (round 3); a softer sand is a one-constant change in patch 0007
if ever wanted.


### Round 5 — operator feedback on beta 1 (2026-09-03)

Sixteen items from real use, against Arc side by side. Each is fixed and verified by
capture or test before it is marked done; the release that carries them is
`v0.2.0-beta.1` (`docs/release-notes/`).

| # | Item | Status |
|---|---|---|
| 1 | First-run screen: a Stedding welcome flow (search engine, import, appearance, default browser, shortcuts) | **Fixed** (patch 0015) — `chrome://stedding-welcome` in a child window over a profile's first window; five steps with Skip and Back; verified live 2026-09-03: engines listed outside the chooser regions too, Light applied at once, Skip records the flow, Quit works with it open, no return on relaunch. `--stedding-welcome` forces it, `--no-first-run` suppresses it |
| 2 | ⌘T treated random text as a URL | **Fixed** (patch 0013) — the omnibox classifier decides; verified live: "dfsfsfsdfdsfcvv3233" searches DuckDuckGo |
| 3 | ⌘S toggles the sidebar; Save Page moves to ⇧⌘S | **Fixed** (patch 0013) — verified live |
| 4 | Tab hover/selected/active highlights | **Fixed** (patch 0013) — every state a tint of the row's text colour; active a translucent pill in dark, white card in light; favicon column widened to the 18 px icon |
| 5 | Address row must sit on the page and take its colour | **Fixed** (patch 0013) — no gap above the content card, a bar in the page's theme colour painted by the window background when the page declares one that suits the colour scheme (github.com in dark), the ground otherwise (example.com); transparent omnibox; verified live 2026-09-03; see `docs/features/toolbar.md` |
| 6 | Space icons: no discs, centred emoji, like Arc | **Fixed** (patch 0013) — bare 16 px emoji, inactive at 50 %, even spacing |
| 7 | Pin to this Space showed nothing; Clear line missing | **Fixed** (patch 0013) — the pinned run sits under the Space title with the Clear line beneath it, then "+ New Tab", then the rest; verified live |
| 8 | Split view like Arc | **Verified** (Chromium 153 split view, no Stedding code) — a tab's context menu "Add Tab to New Split View" pairs it with the active tab, the panes take the card look, the sidebar shows the pair as one row; ⇧⌘O promotes a peek into a split (peek P9); checked live 2026-09-03 |
| 9 | Screenshots | **Fixed** (patch 0014) — ⇧⌘2 the visible page, ⌥⇧⌘2 a dragged region, ⇧⌘1 the full document; PNG to Downloads and the clipboard; verified live 2026-09-03 (2064×1678, a 600×400 crop, 2064×7712 for the Wikipedia main page). ⇧⌘3–6 are macOS's own screenshot keys and never reach an application, hence the other two keys; `docs/features/screenshot.md` |
| 10 | Fullscreen: sidebar toggle below the address row | **Partly** (patch 0013) — the strip's top row is now as compact as windowed; the 33 DIP above it is the macOS immersive overlay, outside the window's content view (`docs/features/toolbar.md` T6) |
| 11 | General design drift from Arc | addressed by 4–7, 12–16 |
| 12 | Downloads at the bottom-left | **Fixed** (patch 0013) — a downloads button at the left of the Space row (icon and tooltip from `kActionShowDownloads`, a press runs the toolbar controller's `InvokeUI`, so the bubble opens above the button; the anchor is resolved lazily because the sidebar is built before the download controller exists); verified live 2026-09-03 |
| 13 | Space name above the tabs | **Fixed** (patch 0013) — icon + name row above the pinned tabs once there are two Spaces; click opens the Space menu |
| 14 | One pinned essential took half the row | **Fixed** (patch 0013) — a lone card spans the row, two share it |
| 15 | Sidebar edge cannot be dragged | **Fixed** (patch 0013) — 12 DIP handle at the strip's right edge; verified live by dragging to 260 |
| 16 | Swipe on the sidebar switches Spaces | **Fixed** (patch 0013) — two-finger horizontal swipe, no wrap; `SpaceModelTest.SwitchToNeighbour*` |

### Round 5 audit (2026-09-04, release build, every surface in dark and light)

Captured through `tooling/drive` on a profile with an essential, a Space-pinned tab,
two Spaces, a folder, a split, and a peek: the window, the command bar (empty and
typed), the tab and Space context menus, a chip hover, a tab hover with its card,
peek, the collapsed sidebar, the app menu, a narrowed sidebar, the settings and
About pages, and macOS fullscreen. Then the same in light.

Passed as they are: everything above except the four below.

| Found | Fix |
|---|---|
| The Space name pill drew at the top of the sidebar on chip hover: the switcher now sits in the bottom row, and the pill was placed with row-relative bounds. | Converted into the sidebar's coordinates first (patch 0013). |
| An essential's hover card opened below the card, over the Space title and the first rows (Chromium's placement for pinned tabs). | Every vertical tab's card opens beside the sidebar (patch 0013, `TabView::GetAnchorPosition`). |
| Welcome step 5 and the settings hint named ⇧⌘L, which is bound to nothing. | ⌘S is the collapse key; the step lists ⌥⌘N (split) instead (patches 0013, 0015). |
| The About page says "Developer Build" after the Chromium version. | Open as `S-43`. |

Noted, not changed: with two Spaces the light ground blends the Space colour at 22%,
which turns sand olive under the default slate; the round-4 sign-off accepted it. A
Space-pinned tab that joins a split leaves the pinned run for the split's row.

### Beta 2 feedback (2026-09-04)

Three things from the operator's first look at beta 2, each fixed and captured:

| Found | Fix |
|---|---|
| "Everything in the address bar is broken or doesn't fit": the chrome:// chip ("Stedding") drew as a white box with the mark cut off. The 25 DIP location bar left the chip 15 DIP tall around a 16 DIP icon. | The chip's vertical padding is 2 (Chromium's 5), so it keeps 21 DIP (patch 0013, `layout_constants.cc`). |
| "Not changing colour like Arc": only pages with a `theme-color` coloured the row; chrome://settings, Wikipedia and most sites left it on the ground. | The page's own background is the fallback (`WebContents::GetBackgroundColor`), the way Safari tints its bar; the scheme-match rule stays (toolbar T3/T4). |
| "Spaces very weirdly centred at the bottom": the chips were spread evenly across the row. | Chips sit together in the middle with a fixed gap, "+" at the right, downloads at the left (spaces B11). |

### Round 9 — the operator's look at the Windows preview (2026-09-09)

Three minutes of clicking in the installed beta 5 on Windows, and the keyboard map it
did not have. Six findings from the operator, the rest from the pass that followed the
same night; every fix verified on captures the tooling took itself with no focus and
no input (trap 36), the keyboard map by the reference page it feeds and the unit tests
written for it (not yet run on a Windows runner, `S-49`). Patches 0043 (the keyboard
map and the shortcut reference on every platform), 0044 (the first start) and 0045
(the rail). Published as beta 6 from Windows.

| # | Found | Fix |
|---|---|---|
| 1 | No Stedding keys on Windows: Chromium's chords stood in (the notes said so). | Arc's Windows keyboard in the views accelerator table (windows N7, patch 0043): Ctrl+S the sidebar, Ctrl+D the pin, Ctrl+Shift+D the address row, Alt+1–9 the Spaces, Ctrl+Alt+←/→ between them and Ctrl+Alt+Shift+←/→ the tab across, Ctrl+Alt+↑/↓ the rows and Ctrl+Alt+Shift+↑/↓ their move, Ctrl+Shift+K Clear, Ctrl+Shift+C the link and Ctrl+Alt+Shift+C as Markdown, Ctrl+Shift+2 / Ctrl+Alt+Shift+2 / Ctrl+Shift+1 the screenshots, Ctrl+Shift+P the palette, Ctrl+Alt+Shift+N a Blank Window; Ctrl held shows the row numbers. Chromium refuses Ctrl+Alt in that table (AltGr), so the Ctrl+Alt rows go in past its check the way its debug map does (trap 42). The shortcut reference reads the platform's table and its block is on chrome://settings/stedding on Windows (shortcuts Z6); the settings sub-labels and the welcome flow say Ctrl where they said ⌘. |
| 2 | The first window opened on Google's search page, with a "Google API keys are missing. Some functionality of Stedding will be disabled" bar over it. | Google had been chosen on the welcome flow, and for Google alone Chromium's first-party page stood in for the local one (`S-45`, open since 2026-09-05): the local third-party page for every provider now (new-tab N1). The infobar is gone: the keys are for Google's services (welcome W9). Patch 0044. |
| 3 | Collapsed, the tabs were a little too close to each other. | The rail's rows sit 6 DIP apart, not the open sidebar's 2 (sidebar Y12, patch 0045). |
| 4 | Hovering a Space in the rail floated its name over the downloads button. | No floating name in the rail; the chip's tooltip names the Space (sidebar Y14). |
| 5 | Adding Spaces while collapsed pushed the "+" past the window's bottom; open and collapse again and it was fine. | The switcher's stack kept a fixed height that counted every chip full while the inactive ones were dots, and the row it sits in kept a height set by hand at construction and at each collapse. The stack measures itself, dots and all, and the row takes its height from its layout, with the switcher's flex (the open row's width) off in the rail -- left on, a BoxLayout hands the row everything under the Archived row (sidebar Y13, trap 43). |
| 6 | Collapsed, the Space's icon at the top had "…" after it. | The title row is its glyph alone in the rail, centred and a size up; the name comes back with the open sidebar (sidebar Y13). |
| 7 | Choosing a theme "as the browser suggests" changed nothing much, and a popup in it drew white text on a white ground ("You can find older colors in the Chrome Web Store"). | That was Chromium's Customize Chrome panel behind the "Theme" row of Settings › Appearance, whose colours barely reach a window the Space tints and whose promos point at the Web Store, one as a toast the panel styles itself. The row is hidden (settings T12); the plain toast ground takes the dialog colour in the mixer too. Patch 0044. |
| 8 | Found in the pass: the reference's ⇧⌘D row said "unbound" on the Mac, where ⇧⌘D shows the address row (toolbar T10). | The row names the address row on both platforms, from the table (shortcuts Z2). |
| 9 | Found in the pass: Chromium's tab-group chords (Alt+Shift+C/P/X/Z/W) were live on Windows while the group rows are hidden (menus M6). | Linux's alone now, as the Mac's were removed with the rows. |
| 10 | Found in the pass: the tab menu showed no chord beside Pin to This Space, Copy Link or Copy Link as Markdown -- on the Mac too -- while Close had its Ctrl+W. | The verbs map to the browser commands their keys are bound to (`ContextMenuCommandToBrowserCommand`), which is where the menu reads chords from (menus M1; patch 0043). |

**The Mac pass, 2026-09-10.** Beta 6 was published from Windows with the source
built there alone, and the Mac had no checkout that morning (`docs/HANDOFF.md`, trap
44). Once re-synced, the seven patches written on Windows (0039–0045) were built for
macOS for the first time. One did not compile: `kColorCaptionButtonOnToolbar`, which
round 8 hands the page-bar supplier for the caption glyphs (row 9), is declared for
Windows alone in `chrome_color_id.h`; the row and its test line are guarded. In the
same patch a Space's name went into the export file name through `AppendASCII`, which
DCHECKs on anything outside ASCII on a debug build and mangles it on Windows; the name
is UTF-8 through `FilePath::FromUTF8Unsafe` now. Both are fixups into 0039, exported
by `tooling/update-patches` on the Mac, which also replaced the seven hand-assembled
patch files (CRLF headers, no diffstat) with the exporter's own. The first multi-tab
capture then showed every inactive row and essentials card filled near-black, which
no beta had shown. Not the Windows patches: beta 4's own app draws the same fill when
run with `--disable-field-trial-config`, so Chromium's testing config had been hiding
the Material inactive-row colour in every beta up to 4 and the first build with it
off (privacy Q10, beta 5) showed it -- on Windows too, unnoticed with one tab. The
Stedding mixer pins the inactive row transparent, a fixup into 0042 with its test
(tabs R23). The release sweep then ran Chromium's own suites around what the series
touches (trap 31), widened to `BrowserViewTest` and the toolbar, menu and search
suites: eight cases were red, none of them a bug in the product. Three `TabTest`
cases and `BrowserViewTest.BrowserView` read Chromium's horizontal tab and the
customize-chrome action under the 2026 refresh, which patch 0042 turns on in code
where upstream's tests never see it; `TabStripModelTest.CreateGroupSetsVisualData`
expects the label map's colour order where the refresh uses its own; and the two
`BrowserViewTest` find-bar cases expect the bar under the location bar where
Stedding hangs it from the card (page U4, since round 6); and
`BrowserViewTest.WindowTitleOmitsLowMemoryUsage` dereferenced the horizontal tab
strip, which an Arc window does not have (ADR 0010) -- a crash the test wrapper had
been swallowing, since a crash prints no FAILED line; the wrapper reports crashes and
timeouts now. Each case now asserts what this build does or skips with the reason,
as fixups into 0039, 0042 and the look patch, and `tooling/dev test upstream` runs
the whole set so the next release cannot skip it. The macOS image of beta 6
carries all of it; the Windows installer, built before, does not, and the next
Windows build picks it up from the series.

### Round 8 — the first Windows build (2026-09-08)

The series built for Windows for the first time -- M8 in `docs/ROADMAP.md` had not
started -- on the operator's PC, with Visual Studio 2026 Build Tools and Windows SDK
10.0.28000 installed for it. Nine portability errors first, all one cause; then the
operator's look at the running window: five things, and two more found while
capturing them. Every fix was verified on captures the tooling took itself
(a `SendInput` driver with a foreground check, after a
launch where the browser stayed behind and the clicks landed in the operator's own
app), at 1400x880 with a device scale factor of 1 so the mac probes run on them
unchanged: 20 of `tooling/probes/window.json`'s 23 pass, the three others being state
or platform, and the card's edges, gutters and 12.00 DIP corner are the mac's to the
pixel. Patch 0039. The operator's reply the same afternoon -- the rail's pill
still narrow, no address bar in the rail -- and a startup crash found on the way
are rows 6 to 8, in the same patch; those captures were taken with no focus and
no input at all (`PrintWindow`, HANDOFF trap 36), with the operator at the
machine.

| # | Found | Fix |
|---|---|---|
| — | `base::FilePath::Append("Default")` and seven more did not compile: `FilePath` is `std::wstring` on Windows. | `FILE_PATH_LITERAL`, `FromUTF8Unsafe`, `AppendASCII`, `AsUTF8Unsafe` in the Arc importers, the sidebar backups and the screenshot file name. Nothing changes on the Mac (windows N1). |
| 1 | The window's own buttons are on the right on Windows, and the address row ran under them. | The row stops short of the frame's trailing exclusion, the card's exposed top-right corner rounds, and with the row hidden the empty top container keeps the caption strip's height -- from the rail the window could not be closed at all (toolbar T19, windows N2). |
| 2 | Clicking the address bar turned it dark. | Focused, the location bar borrows the results dropdown's background, which the page-bar supplier never set. The dropdown follows the page too, in the bar's contrast colour (toolbar T20). |
| 3 | Reloading a white page turned the row dark and left it so. | A new Page starts with no colour and the WebContents announces a background only when it differs from the last one it sent, so white reloading to white is never announced. The controller keeps its colour while the page loads and re-reads the Page at first paint and at load end (toolbar T21). |
| 4 | Collapsed, the icons were small and sat left in the column, and the Space switcher ran out of the rail and drew its "+" over the page. | The toggle, the New Tab and Archived rows centre in the rail a size up, the Archived row as its icon alone; the switcher stacks its chips in a column and the downloads button stacks above it -- all keyed on the width being drawn, not the collapse state, after a first cut centred the toggle in the hover overlay (sidebar Y8, Y9). The collapsed tab's own pill stays 25 DIP wide: `S-53`. |
| 5 | Hovering the rail expanded it, and the page showed through every row. | The strip's background, invisible so the window's gradient shows through (trap 8), is visible exactly while the strip is collapsed by state and drawn wider than the rail (sidebar Y10). |
| 6 | The rail's tab pill was still 26 DIP wide in the 62 DIP column, the "+" above it clipped to 10 DIP, the toggle 3.5 DIP right of the rows' centre. | The width a rail row gets is decided in the unpinned container's layout, not the strip's, which is why the first cut changed nothing. Every container's side padding is 3 DIP in the rail, keyed on the width being laid out, and `TabView::CollapsedWidth` says the same 44, so a rail row is a 44 DIP square around a 22 DIP favicon, centred in the rail plus the gutter; the "+ New Tab" row is its plus alone at that width, unclipped; the button containers sit on the same column, so the toggle centres with the rows (sidebar Y8; S-53 closed). |
| 7 | In the rail there was no address bar at all: the row hidden with the sidebar (T8) left an empty 35 DIP band under the caption buttons. | The rule keeps the row while the frame's own buttons sit over its column -- Windows' caption buttons, the trailing exclusion -- since the strip exists whatever the sidebar does; the toggle still wins (toolbar T22, `AddressRowRulesTest.KeptUnderTheCaptionButtons`). macOS is unchanged. |
| 8 | A profile killed while the sidebar was collapsed never opened again: `Check failed: element` in `AppMenuButton::GetAnchor` on every launch. | The crashed-session "Restore pages?" bubble anchors to the app menu button before the window is shown; with the row hidden the button is not drawn, and the fallback anchor is a tracked element the tracker does not know until the widget is visible. The button anchors such a bubble to the top container instead (toolbar T23, HANDOFF trap 35). Found on the round's own test profile, which the driver had killed; a Mac in the rail is the same path. |
| 9 | The row stopped short of the caption buttons and its end read as a cut corner beside them (the operator's second reply). | The bar runs on under the buttons to the card's edge -- the contents still stop short -- with the card's top-right corner rounded as on the Mac; the buttons paint their glyphs in the bar's contrast colour through the page-bar supplier, and the address field centres on the bar rather than on the contents' width (toolbar T19, T18). Looked at across scales 1, 1.25, 1.5 and 2, a narrow window and a maximised one (`w8_matrix`). |
| 10 | Found in that look: in a 900 DIP window with the sidebar open the address field sat over the back, forward and reload buttons. | Round 7's centring (toolbar T18) read the two spacers' bounds after the layout had dropped them -- hidden, at the origin -- for want of width, and clamped the field to x 0; with the reserve for the caption buttons the row reached that state at ordinary widths. The field keeps the layout's position when the spacers are gone. Read off the laid-out bounds through a temporary layout dump, which is how a views layout question gets answered on a build with no test runner (HANDOFF trap 37). |
| 11 | An "Action required" chip on the app menu, taller than the row (the operator's third reply). | Chromium's registry loader reads Google Chrome's own key, `Software\Google\Chrome\Extensions`, whatever the branding; Adobe's installer had put its Acrobat extension there, and the browser was fetching it from Google's update server and asking. The provider is gone on Windows (privacy Q9, HANDOFF trap 38). The chip itself, for the errors that are real, is the toolbar buttons' height (toolbar T25). |
| 12 | The caption buttons sat higher than the row's centre. | They stretched from the window's top edge to the frame's height; they now centre on the row's centre line at their own height (toolbar T19). |

### Round 7 — the operator's look at beta 3 (2026-09-05)

Six things from real use, and a crash found while capturing them. Each is fixed,
tested and captured without a hand on the machine: `tooling/capture-ui` with feature
params for the state, and an AppleEvent quit (the operator was at the keyboard, and a
synthetic key that missed the browser once landed in their chat — `docs/HANDOFF.md`,
trap 27).

| # | Found | Fix |
|---|---|---|
| 1 | The address row was a different colour from the page: even a plain white page got a grey row (the page colour was blended 85% over the ground). | The row is the page's colour exactly, with one hairline where it meets the page (toolbar T15: `PageBarColorSupplier`, `PaintPageBar`). |
| 2 | The page's top corners were rounded under the row, showing the row's colour through them wherever a page's header is not its theme colour. | Square top corners on the content whenever the row shows; the row keeps the card's rounded top (toolbar T16). |
| 3 | The address text sat off-centre and the star was nearly invisible; then, on the fix: "still too short, make the font smaller", and "no margin before en.wikipedia.org — remove that background, and make sure it shrinks when a user has many plugins". | The star and the row's page actions take the bar's own colours (T17). The field is 560 DIP on the row's centre with no background at all, the address centred in it one point smaller than Chromium's, the page actions at its right edge, and the flex rule gives the width back when the toolbar is tight (T5, T18). |
| 4 | Collapsed, the rail's rows sat a little left of centre, the toggle sat too low, and the toggle could pass under the traffic lights; then, on the fix: "the icon is too low, not vertically aligned with the close button". | The rail centres its rows against the card's edge, and the toggle takes the traffic lights' own vertical centre on the caption row, clear of them when it must sit below (Y6, Y7). |
| 5 | Folders did not look like Arc's; then, on the fix: "why did + New Tab and folders move right? change the folder icon". | Arc's folder row: macOS's own "folder" symbol in the favicon column, a semibold title, no chevron, and the header, the New Tab row and the Space title row all on the tab rows' own 8 DIP column — the folder header had been indented with its children since patch 0008 (F12, Y3). |
| 6 | Moving from Arc should be one click. | The welcome flow's Arc block moves Spaces, pins, folders, tabs, history and passwords with one button; the settings row and the ⌘T action move everything too (import I6, I21–I23, patch 0038). |
| — | Quitting with a folder in the sidebar aborted (`bad_variant_access`): the page-colour re-theme ran inside the tab strip's close-all notification and reached a folder header whose folder was already gone. | The re-theme is posted after the change and skipped while the window empties; the header gives no folder for a node that is not one (folders F12). |
| — | macOS asked for a keychain and named the product "Chromium" during an import. | The keychain item is Stedding's own, with the Chromium item as a fallback so an earlier beta's passwords still decrypt (import I24). |


### Round 10 — the operator's look at beta 8 (2026-09-19)

The first time anyone installed a release the way a user does: downloaded through a
browser, dragged to Applications, opened. Two of the three findings were waiting there
for every user of every Mac beta so far; the third turned up while fixing them.

| # | Found | Fix |
|---|---|---|
| 1 | "Stedding.app is damaged and can't be opened. You should move it to the Trash." on the first launch of the downloaded image. | Not damage and not the download (the checksum matched): the app carries only the ad-hoc signatures the linker leaves, which seal no resources, and macOS says that about a quarantined app. Right-click → Open, which every page of ours gave, cannot get past that dialog. `INSTALL.md`, the README, the FAQ, the notes of beta 7 and beta 8, the site's download card and the line `package-dmg` prints now give the step that works -- `xattr -dr com.apple.quarantine` on the one app, after the checksum (`docs/HANDOFF.md`, trap 47). Signing (`S-17`) removes the step. |
| 2 | "it crashes on launch after a sec". | Full screen. macOS moves the top container into an overlay widget of its own, and the window background converted the toolbar's bounds into the browser view anyway: a CHECK, so full screen over any page with a theme colour aborted the browser, and the operator's restored session had a full-screen window (toolbar T24, trap 48). The bar is painted only while the toolbar and the card are in the window's own widget. `tooling/verify-build` now opens the browser full screen over a themed page, so the state is entered on every release sweep. |
| — | Found while reproducing 2: the Mac builds kept the profile in `~/Library/Application Support/Chromium`, which any Chromium on the same Mac shares -- one process singleton between two browsers, and passwords sealed with the other's keychain key -- while `INSTALL.md` promised Stedding's own folder. | macOS uses `~/Library/Application Support/Stedding`, as Windows uses `%LOCALAPPDATA%\Stedding`. A profile an earlier build left in Chromium's folder is cloned across on the first launch that finds no folder of Stedding's own, and only when that profile carries Stedding's own preferences; Chromium's folder is left as it was (windows N8, patch 0050). |
| 3 | "browser is full of bugs.. even tabs are unselectable. you can click them, hover works, but doesnt select. when collapsed - same and looks weird. crashes all the time.. no animation for scroll between spaces at all" (2026-09-24). | Taken apart: **crashes** -- the only report since the fix is beta 8 in /Applications with the full-screen abort of row 2. **Collapsed looks weird** -- in the rail a folder's rows kept their indent, so icons left the column and a nested folder's glyph, 28 DIP into a 44 DIP column, was clipped into a different icon; the rail now puts every row on one column and a folder header is its glyph alone (folders F13). **No animation between Spaces** -- there was none: the rows swapped in one frame. The list now slides in from the side of the Space being entered (spaces B32, patch 0052). **Unselectable tabs** -- open: the click path reads right in the code, so it needs a real click in a test window to see what takes it. The same day the pin went to 155.0.8059.12 (BACKLOG S-64). *Since: found and fixed in round 11, row 1 (`PLAN.md` TAB-1, `BACKLOG.md` S-65).* |

### Round 11 — the owner's Mac pass on beta 10 (2026-10-01)

The owner used beta 10 on their own profile, an Arc import with eight Spaces and long lists,
and the Mac then drove a copy of it with real input. Patch 0058, with the click fix folded into
0057. Built; the new unit and browser tests pass. On 2026-10-02 the Mac used the release build
with the real pointer and keyboard on a copy of the owner's profile and on a fresh one: the last
column says what was seen, and rows 7 to 11 are what that pass found, fixed in the same patch.

| # | Found | Fix | Seen live |
|---|---|---|---|
| 1 | Tabs would not select: "worked 1 time and now stuck". | The sidebar's empty bottom bar was hidden under the long list but kept its old bounds over the rows, and the window read that as caption, so every press became a window drag (PLAN.md TAB-1). Only a showing container counts now. | yes: rows click on the owner's copy; again on 2026-10-02, in the open sidebar and in the rail |
| 2 | The address bar disappears when everything is collapsed. | "Hide the address row with the sidebar" is off by default (toolbar T8, T12). | yes, 2026-10-02: after ⌘S the row stays, clear of the traffic lights |
| 3 | A swipe changes Space with no animation. | The title and the list follow the fingers; the lift switches or springs back; the next Space slides in (spaces B35). | yes, 2026-10-02: the list follows, a short swipe springs back, a long one switches and the next Space slides in; the old list stood still for a quarter second first on the owner's profile, fixed (row 8) |
| 4 | The Space chips turn to dots too early. | The gaps close up to 4 DIP first (spaces B24). | yes, 2026-10-02: the owner's eight Spaces as icons |
| 5 | Some icons in the address row look low. | Measured: every icon is centred in the row to half a DIP; the row sits 6 DIP below the window's top (T2), while the traffic lights and the sidebar toggle centre about 6 pt higher. The owner said that is fine if so; left as it is. | measured |
| 6 | The row is not always the page's colour; sometimes none. | The colour the page draws along its top edge first (T31); the page's colour in full screen too (T32). | yes, 2026-10-02, with row 7's fix: a purple site, a dark sign-in page, a purple layer, a red header scrolled away, and full screen over white, red and purple, the row's pixel the page's |
| — | Found on the owner's copy: restored tabs died with "Terminating renderer for bad IPC message, reason 332". | Unloaded imported tabs saved sequence numbers of -1 with the session; content now writes and reads them as 0 (import I26). | yes, 2026-10-02: three launches with the last session restored, no "reason 332" in any log, the imported tabs load |
| 7 | Found 2026-10-02: on saturated pages the row was a step off the page's colour (a purple site: a row of (47, 28, 158) over (50, 27, 165)). | The page's top is read back in the display's colour space, Display P3, and was painted as if it were sRGB; the strip is read as sRGB now (toolbar T31). | yes: equal to the unit on four pages |
| 8 | Found 2026-10-02: on the owner's profile a Space switch showed nothing for half a second, and a swipe's lift held the old list still. | The Space's tint re-themes every row of every Space, and each row set its font again, which laid the whole list out once per row, and drew its folder's glyph from macOS's symbol again. A row sets its font only when it changes and the glyph is drawn once (spaces B36). | yes: ⌃4 shows the new Space by 60 ms (450 to 700 before) |
| 9 | Found 2026-10-02: in full screen a second, darker line under the row's hairline. | Chromium's separator for its slide-in toolbar is not drawn for Stedding's window (toolbar T32). | yes: one hairline |
| 10 | Found 2026-10-02: in the rail the Clear line's label was drawn clipped to "lear". | In the rail's column the line is drawn alone, with no label and no press (spaces B17). | yes |
| 11 | Found 2026-10-02 on a fresh profile: in light mode a folder's name and glyph were nearly invisible (1.95:1). | They take the rows' own text colour (folders F12). | yes: 6.8:1, as the rows |

The same pass, with the real pointer and keyboard on the release build, also closed the Mac halves
of two items: TAB-3 (in the rail a click on a drifted Space pin keeps its page, an Option-click
sends it home, and straight after it the video's own fullscreen button and Esc work, a ⌘-click
adds a row to the selection and the red button closes the window) and WIN-29 (View → Always
Show Full URLs checked; google.com's whole address at rest and after a click, in a field of
about 1180 DIP in a window of 1688). A human-style pass on a fresh profile (the welcome flow,
⌘T, a folder, a drag onto it, a split, Settings, light and dark) found rows 10 and 11 and four
things logged rather than fixed: the welcome steps running under the footer (S-76), a globe for
every search engine (S-77), ⌘T leaving an empty New Tab behind (S-78) and Arc taking ⌥⌘N while
it runs (S-79); the switch's row animation is S-80.

After beta 11, the same day, the items that pass had logged were fixed in 0058 too, each with a
test that failed first, and seen on the rebuilt app: the rows take their places at once on a
Space switch (spaces B37, S-80: ten rows in place 10 ms after the switch); ⌘T from an untouched
New Tab page opens there (commandbar K21, S-78); the welcome flow's steps fade out at the bottom
while there is more below and the keys step, without Peek's ⌘O, fits (welcome W6, W11, S-76);
the Clear line is the rows' text colour at a quarter strength, visible on a tinted Space (spaces
B17); and Settings' shortcut reference names Arc's ⌥⌘N (shortcuts Z3, S-79 stays open for the
chord itself). The search engines' icons (S-77) wait for the owner: they need images Chromium
builds do not carry.

## The code review of 2026-10-15

A read-only review of the whole series, area by area, on the pin 155.0.8059.12 with patches
0001 to 0064. Each area was read against its specs (`docs/features/`) and `BACKLOG.md`, and a
finding counted only when it was traced in the code, with the lines quoted. Every finding was
then read again in the checkout before it was fixed or filed; some were wrong, and some were
already in `BACKLOG.md`, and neither kind is listed here. What was fixed became patch 0065, each
fix with a test; what was not is a `BACKLOG.md` row. Line numbers below are the checkout's with
the 64 patches applied.

The areas: patches 0062 and 0063; patches 0059 to 0061; the test suite and patch 0064; lifetime
and threading in Stedding's own code; the privacy promises; macOS code and the window frame;
the root causes of the open defects; Space isolation and storage; sessions and restore; the
command bar; importers and file parsing; patches 0053 to 0058; auto-archive and sleep; the tab
model; routing, the little window and Peek; Windows code; the WebUI pages and their handlers;
keyboard and accessibility; and, last, the fixes themselves.

### Fixed in patch 0065

| Id | What | Spec | Test |
|---|---|---|---|
| `S-190` | Closing one pane of a split, or a window holding a split, crashed the browser in `Layer::Add`: the row's layer for its move was made while the row was out of the tree | splits J9 | `SidebarClickTest.ClosingAPaneOfASplitKeepsTheOther` |
| `S-191` | Grouping a tab inside a folder (an extension's `chrome.tabs.group`, or the full tab menu) made the group inside the folder, and a `CHECK` killed the browser | folders F35 | `TabStripModelTest.GroupingATabInsideAFolderPutsTheGroupAfterIt` |
| `S-192` | The Arc import killed the browser on a blocked login that kept its username, and a history row with no visit time failed a `DCHECK` | import I22, I23 | `ArcDataImporterTest.ReadsLoginsAndUnsealsPasswords`, `ArcDataImporterTest.ARowWithNoVisitTimeStaysOut` |
| `S-193` | Deleting a Space wiped its jar under a page with unsaved changes, and under a popup in that jar | sessions S17 | `SpaceJarTest.DeletingASpaceWaitsForAPageWithChanges`, `SpaceJarTest.DeletingASpaceWaitsForAPopupInItsJar` |
| `S-194` | Autofill asked `content-autofill.googleapis.com` about every form | privacy Q14 | `PrivacyDefaultsTest.AutofillAsksNoServer` |
| `S-195` | The command bar opened scopes it refuses through a typed keyword; a row that keeps the bar open lost the choice; a late autocomplete answer moved Enter to another page | commandbar K7, K17, K18 | `CommandBarViewTest.AKeywordQueryOpensOnlyAnOfferedEngine`, `CommandBarViewTest.AToggleStaysChosenOnceItHasRun`, `CommandBarViewTest.ALateAnswerKeepsTheChosenSuggestion` |
| `S-196` | The Mac History menu's Restore Folder ignored Shift | folders F19 | `ClosedFolderTest.AShiftClickRestoresIntoANewWindow` |
| `S-197` | A split switched to stacked kept its side-by-side corners | splits J7 | `SidebarFormsTest.TheClosedFormsLeaveThePageEdgeToEdge` (its split step) |
| `S-198` | Export Space could write outside its folder for a name with "/" or ".." | import I20 | `SidebarBackupTest.AnExportStaysInItsFolder` |
| `S-199` | A slept or rebound tab lost its place in the folder close it came back from | folders F19 | `SpaceWindowTest.ReplacedContentsKeepTheirPlaceInAFolderClose` |
| `S-200` | Two browser tests read a command bar the waits could free; two pointer tests ran in the parallel batch | -- | the tests themselves; `tooling/dev`'s serial list |

### Filed

`S-179` sessionStorage of an isolated Space and a crash restore's Spaces; `S-180` service
workers and notifications in the wrong jar; `S-181` a restored tab's stale Space data in another
window; `S-182` a Space-pinned split under the Clear line; `S-183` the Arc import's edge cases;
`S-184` the welcome behaviour step's late answer; `S-185` work sleep and the archive cannot see;
`S-186` the welcome flow's Bookmarks HTML row; `S-187` the archive page and the welcome swatch;
`S-188` WebUI handlers that trust a message's shape; `S-189` Ctrl+Alt chords on an AltGr layout;
`S-201` a typed address taking another app's external-open mark; `S-202` a `.webloc` from
Finder; `S-203` host routes and IPv6; `S-204` the welcome flow's focus; `S-205` Clear and the
keyboard; `S-206` a deleted Space's jar after a quit; `S-207` Undo of a folder's last tab;
`S-208` the keychain key after a failed profile move; `S-209` tests that pass without what they
check. `S-161` gained the unnamed choice groups of the welcome flow. `S-201` to `S-209`, and the
unnamed groups, were fixed the same day in patch 0066, each with a test that fails without its fix.
`S-179` to `S-189` were fixed that evening in patch 0067 (`BACKLOG.md`, Done), with the default
favicon replaced (`S-211`).

### Root causes of open items

#### `S-140` (TAB-32): Move Up and Move Down swap with a hidden neighbour

Work tabs W1 and W2 with a hidden Home tab between them: Move Next on W1 asks the folder-aware
plan, which returns nothing for a plain neighbour, and the fallback swaps W1 with the hidden tab
at the next strip index, so the Work rows do not change. `PlanRelativeMoveInFolder`
(`components/tabs/impl/tab_strip_collection.cc:1234`), `MoveTabRelative`
(`chrome/browser/ui/tabs/tab_strip_model.cc:4434`). Fix: in Stedding's block of
`MoveTabRelative`, walk past `IsTabHidden` tabs to the next visible row in the same container.
Test: a Home tab between two Work tabs; one Move Next makes the Work rows trade places.

#### `S-140`: a folder header toggles on any button and has no name

A right or middle click toggles the folder; the header is a plain `views::View` with no role,
no focus and no name; the only named control is the hidden rename field
(`chrome/browser/ui/views/tabs/common/folder_view.cc:97`, `:104`, `:158`). Fix: toggle on the
left button only; make the header a focusable button named by the folder's title. Test: a right
click leaves the folder as it was; the header's accessible name is the title.

#### `S-140` (TAB-22): the folder's glyph and title take the tab-foreground colour

Glyph, title and the slept tint come from `kColorTabForegroundInactiveFrameActive` (the code's
own comment measures 1.95:1 on light mode's sand), and the drop highlight is a fixed white
(`folder_view.cc:52`, `:424`). Fix: the sidebar's text and highlight colours. Test: with a
light sidebar, the title's colour is the sidebar's text colour.

#### `S-142` (TAB-24, SPC-34): a tab inside the pin run pushes later pins under the line

The Clear line goes above the first child that is not Space-pinned, before the visibility check,
so a hidden tab of another Space counts, and `IsSpacePinned` means any Space's pin
(`unpinned_tab_container_view_layout.cc:325`; the predicate at
`vertical_tab_strip_region_view.cc:1368`). A tab opened from the first of two pins lands inside
the run and nothing moves it out (`space_model.cc:2099`, `MoveToSpacePinBoundary`, is not called
from `OnTabStripModelChanged`). Fix: skip hidden children when placing the line; move a non-pin
that lands inside the active Space's run to just after it. Test: two Work pins with a Home tab
between them stay above the line; a tab opened from the first pin lands below.

#### `S-142` (TAB-25, CMD-24): ⌘W, the hover X and a middle click do not share a rule

With `stedding.pins.close_sleeps` on (the default), ⌘W sleeps a pin and a second ⌘W on a
sleeping pin does nothing; the hover X closes it; a middle click goes home (pins H16).
`CloseActionFor` ignores the window type, so ⌘W in a pinned web-app window sleeps the tab
(`chrome/browser/ui/stedding/pin_lifecycle.cc:79`, `:98`, `:178`;
`browser_commands.cc:1457`; `browser_tab_strip_model_delegate.cc:537`). Fix: one helper for ⌘W
and the X, closing outside a normal window with Spaces; a no-op becomes a close. Test: ⌘W on a
pinned tab in a web-app window closes it.

#### `S-142` (TAB-26): a pin's home is the address at pin time, even one not yet committed

Pinning stores the last committed URL, or else the visible one, and nothing revises it after the
first commit; `HasDriftedFromHome` compares origin and path, so `http` to `https` reads as drift
(`space_model.cc:1909`, `:2128`, `:1953`; `pin_lifecycle.cc:70`). Fix: replace a home recorded
before commit once, at the first commit. Test: a pin of an address that redirects shows no drift
after the first load.

#### `S-144` (TAB-30): the number badges stay up after the window stops being active

Badges hide on a ⌘ or Ctrl key-up this window receives, or when the view leaves the widget; on
the Mac, ⌘-Tab sends the key-up to the other app, and the 250 ms timer can show the badges in
the background (`vertical_tab_strip_region_view.cc:714`, `:824`, `:841`). Fix: when the window
stops painting as active, stop the timer and hide the badges. Test: deactivate with the badges
up; every badge is hidden.

#### `S-144` (CMD-25): ⌘1–8 and the badges are two walks

The badges number the tabs that are not hidden (`tab_numbers.cc:12`); ⌘1–8 walk
`IsTabSelectable`, which adds a focused-group check (`browser_commands.cc:1599`, `:586`). Fix:
⌘1–8 and ⌘9 activate `NumberedTabs()[index]`. Test: with a focused group, badge 1 and ⌘1 are the
same tab.

#### `S-145` (SPC-15): unpinning an essential leaves it filed in its old Space

Pin a tab in Space 1, switch to Space 3, unpin it: `OnTabPinnedStateChanged` changes the
essential homes but not the tab's Space, so the tab disappears from Space 3; ⌘T on an essential
switches to the Space it was filed in (`space_model.cc:1953`, `:1498`;
`command_bar_view.cc:1700`). Fix: on unpin, file the tab in the active Space; on becoming an
essential, drop its Space-pin home; `GoToTab` does not switch for a pinned tab. Test: unpinned
in Space 3, the tab stays in Space 3 and active.

#### `S-145` (SPC-16): a switch from an essential never reaches the Space's own tab

An essential is in every Space, so `EnsureActiveSpaceHasAVisibleTab` returns at once and the
"a tab of its own wins" step never runs: ⌃2 from the Gmail essential stays on Gmail
(`space_model.cc:759`, `:1825`, called from `SettleAfterSwitch` at `:675`). Fix: from an
essential, still prefer the target Space's own last tab. Test: from an essential, a switch to
Work lands on Work's last tab.

#### `S-145` (CMD-14): going to a tab wakes the Space's remembered tab first

Choosing tab B in a Space whose remembered tab A is asleep switches Space first, which activates
A (and loads it), and then B (`command_bar_view.cc:1708`; `space_model.cc:665`, `:772`). Fix:
`SetActiveSpace` takes the tab that should end up active. Test: A asleep, choose B; A stays
asleep.

#### `S-145` (SPC-17): an outside activation does not switch Space

`chrome.tabs.update({active: true})` on a hidden Space's tab activates it and leaves the window
on the old Space; the posted switch exists only for an inserted tab
(`space_model.cc:883`, the `kInserted` branch returns at `:922`). Fix: post the same switch when
the active tab becomes a tab of another Space. Test: that call makes the tab's Space active.

#### `S-145` (SPC-22): a new window does not open on the Space the command came from

Drag-out, Move to New Window and a new window carry no Space: the window seeds against the
registry and lands on its first Space, and the arriving tab is filed there
(`create_browser_window.h:173`; the only writer is `session_restore.cc:1330`;
`browser_init_state.cc:39`; `space_commands.cc:34`; `space_model.cc:169`, `:309`). Fix: put the
source Space's id on the create params and make it the new window's active Space before the tab
is filed. Test: a tab dragged out of Work opens a window on Work.

#### `S-145` (SPC-25): a restored unnamed Space is dropped

Seeding skips a restored Space with no name, no icon and no chosen colour, then rebuilds from the
registry alone, so a "+" Space the session restored but the pref list missed is lost and its tabs
join the active Space (`space_registry.cc:22`; `space_model.cc:156`, `:171`, `:309`, `:329`).
The window is a kill between the session's flush and the prefs'. Fix: seed every restored Space
by id; skip bare defaults only in a window that was not restored. Test: an unnamed Space with
two tabs, the session flushed and the prefs not, survives a relaunch.

#### `S-145` (SPC-28): the switcher rebuilds its chips under the pointer

`Layout` changes the switcher's form as soon as the animated width crosses the rail's, and that
rebuilds every chip while the pointer is over them (`vertical_tab_strip_region_view.cc:855`,
`:2264`; `space_switcher_view.cc:266`). Fix: change form when the animation ends. Test: during a
width animation the chips stay the same views.

#### `S-146` (SPC-27): the outgoing Space's rows do not slide

`SlideInSpaceList` snaps the new Space's rows into place and slides that one list in; nothing
draws the rows that leave (`vertical_tab_strip_region_view.cc:1463`). Fix: snapshot the
outgoing rows to a second layer and slide it out. Test: both layers' transforms during a switch.

#### `S-71`: uninstall never deletes the PDF ProgId key

Uninstall removes the HTML and app ProgIds with `DeleteSoftwareClassesSubkey`; for the PDF one
it removes only the `.pdf` `OpenWithProgids` value, so `HKCU\Software\Classes\SteddingPDF.<hash>`
stays, as `ChromiumPDF.<hash>` stays after a vanilla uninstall
(`chrome/installer/setup/uninstall.cc:607`, `:619`, `:746`). Fix:
`DeleteSoftwareClassesSubkey(root, install_static::GetPDFProgId(browser_entry_suffix))` beside
the HTML one. Test: `tooling/win/test-installer.ps1` finds the key gone after an uninstall.

### Leads not proven

Each needs a run, or more reading, before it is a defect.

- Lifetime: `FolderSessionService::RebuildFromRestoredTabs` keeps raw `FolderTabCollection*`
  pointers while moves can peel a folder that empties; the hover-expand click handler is not
  removed in `RemovedFromWidget`.
- Isolation: `chrome.windows.create` with `setSelfAsOpener`, a prerender handed to
  `PlaceOpenedContents`, `blob:` and `filesystem:` navigations, downloads, and a split whose
  panes are in two Spaces were not traced to their jar; a discard's rebind is a turn late, so a
  tab activated in that turn shows the profile's jar briefly.
- Routing: a cross-jar navigation cancelled and the tab dragged to another window in the same
  turn would drop the address; the remake of an opener-less tab depends on
  `kPwaNavigationCapturing`, on by default.
- Sleep and the archive: a silent receive-only video call, a select-only form or a chosen file,
  and an upload in flight are not "in use"; a sweep during a tab drag was not tried.
- The command bar: Enter during IME composition; a provider answer arriving after Shift-Tab.
- Keyboard: dismissing a toast with an action can leave the page with no focus on the Mac;
  Mute, Clear and the folder chord can be taken by a page (as `S-90` for ⌘S, D, T, K);
  VoiceOver focus on a row inside a folder that collapses.
- Windows: a real AltGr layout, since `S-189` was fixed against a test that plays the keyboard;
  the caption glyphs'
  contrast if the native mixer runs after the page-bar colours.
- Linux, before a Linux build ships: the Hunspell dictionary download, which the Mac and
  Windows do not make.
- Tests: `CommandBarKeysTest.ASiteFromHistoryAndASearchChip`'s loop may not run; a chip drag
  test outside the serial list.
