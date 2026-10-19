# Feature: Shortcut reference

Status: **Z1–Z7 built** (Z1's five new rows since beta 14, Z7 since patch 0071); **Z8 partial**: written 2026-10-18 with dark pages, tests not yet run.
Owner docs: `docs/QUALITY.md` ("UX completeness"), `docs/ROADMAP.md` M6. Patches: `0016` (round 6 wave 1); `0043` (every platform); `0058` (Z3's Arc note); `0059` (Z1's list, S-82); `0060` (Z1's four new chords and Reopen Closed Tab: S-97, S-119, S-120, S-122); the defect round of 2026-10-18 (Z3: the split on ⌃⌘N, S-79); the checks round of the same day (Z7, S-173).

chrome://settings/stedding carries a read-only "Shortcuts" block: every chord Stedding
adds and every Chromium chord Stedding rebinds, read from the accelerator tables at
startup so the list cannot drift from the binary. Items that remap a chord add their
divergence row here, in their own patch; nothing is hand-typed. Remapping by the user
(`docs/PRODUCT.md` §12, 1.0) is out of scope.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Z1 | chrome://settings/stedding carries a "Shortcuts" block listing every Stedding chord (no Peek rows while Peek is off, S-82; the row chords say the ninth goes to the last row) and every Chromium chord Stedding remaps, built from the accelerator tables (the Mac's `accelerators_cocoa.mm` and `global_keyboard_shortcuts_mac.mm`, the views `accelerator_table.cc` elsewhere, Z6) at startup, never hand-typed; it is the in-product shortcut reference `docs/QUALITY.md` and `docs/ROADMAP.md` cite. Since beta 14 it lists four more Stedding chords: under "Tabs and the bar", ⇧⌘E (Ctrl+Shift+E) collapses the Space's folders or expands them all (folders F30) and ⌃M (Ctrl+M) mutes the tab or unmutes it (tabs R29); under "Page", ⌥⇧⌘R (Ctrl+Alt+Shift+R) clears the site's cookies and reloads (commandbar K24) and ⌥⇧⌘P (Ctrl+Alt+Shift+P) plays the page's video in picture in picture or brings it back (player Mp5). It also lists ⇧⌘T (Ctrl+Shift+T), Chromium's Reopen Closed Tab, which Stedding keeps as Chromium binds it: the one unchanged Chromium chord in the list, there because the undo toast's closes reopen through the same list (tabs R28). | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed` (the four new commands among them), `ShortcutReferenceTest.TheListMatchesTheProduct`, `ShortcutReferenceTest.TheMuteKeyIsNotMinimize`, `ShortcutReferenceTest.ClearingASitesCookiesIsAStrongerReload` (the Mac and Windows), `ShortcutReferenceTest.ReopenClosedTabIsListed`; capture, dark and light | built · beta 14's Mac rows are not yet built on a Mac |
| Z2 | Every remapped Chromium chord has a divergence row: the chord, what Chromium binds it to, what Stedding binds it to (⌘S and ⇧⌘S from round 5; ⌘D, ⇧⌘C, ⌥⌘↑/↓, ⇧⌘K from round 6). Items record divergences here, not in `docs/QUALITY.md`. The four chords added in beta 14 were unbound in Chromium on both platforms, so they have no divergence row: on Windows Ctrl+M (Ctrl+Shift+M stays the profile menu), Ctrl+Shift+E, Ctrl+Alt+Shift+P and Ctrl+Alt+Shift+R; on the Mac ⌃M (⌘M stays Minimize), ⇧⌘E, ⌥⇧⌘P and ⌥⇧⌘R. | `ShortcutReferenceTest.DivergenceRowsNameBothBindings` | built |
| Z3 | A note row records that ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N" once a second desktop exists (plan D5); on Windows the note is Alt's -- a tap of Alt alone still focuses the app menu, and on a keyboard with AltGr the left Alt is the one to hold (windows N13) -- and a second one says to press a Ctrl+Alt chord with Ctrl and the left Alt where AltGr types a character with it (windows N14). On the Mac the split is ⌃⌘N, the menu's chord, which Arc leaves alone; Chromium's ⌥⌘N, which Arc takes from every app for its Little Arc window while it runs, still splits otherwise, and a third note, on ⌥⌘N's row, says so and that ⌃⌘N always works (the owner's choice, 2026-10-18; BACKLOG S-79). | `ShortcutReferenceTest.SpaceKeysNoteIsPresent`; `ShortcutReferenceTest.ArcsSplitKeyNoteIsPresent` (the Mac: the split's row is ⌃⌘N, and the note on ⌥⌘N's row names Little Arc); `ShortcutReferenceTest.TheAltGrNotesNameTheLeftAlt` (Windows); capture | built |
| Z4 | The block is found by settings search ("shortcuts"); welcome step 6 (W6) links to it. The command bar's actions-mode row "Show Keyboard Shortcuts" opens chrome://settings/stedding, the page the block is on, in a new tab. | live: settings search; welcome link | built |
| Z5 | The block is read-only: remapping (`docs/PRODUCT.md` §12 "Keyboard shortcut customisation", 1.0) is not built (BACKLOG S-91). | spec row | built |
| Z6 | The reference is the platform's: chords come from `GetAcceleratorForCommandId`, which reads the Mac's menu tables there and the views accelerator table on Windows; the divergence rows name what Chromium bound on that platform (Ctrl+Shift+P was the system print dialog, Ctrl+Shift+C Inspect) and the notes are the platform's (Z3). The handler, its test and the block on chrome://settings/stedding build everywhere (windows N5, N7). | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`, `ShortcutReferenceTest.DivergenceRowsNameBothBindings`, `ShortcutReferenceTest.SpaceKeysNoteIsPresent`; live: `w10_shortcuts` (Windows, 2026-09-10) | built · no CI runs the tests (S-49) |
| Z7 | The core chords reach their commands as keys: on Windows pressed into the window, through its dispatcher, the focus manager and the accelerators, with the page's focus cleared (Alt+1–3, Ctrl+Alt+←/→, Ctrl+1–9, Ctrl+D, Ctrl+W on a Space pin, Ctrl+Shift+E, Ctrl+S, Ctrl+T then Escape, Ctrl+L then Enter); on the Mac through the key lookup a key press goes through (`CommandForKeyEvent`), ⌘W left to the live run since its menu item follows the window in front; on both, pressed on a real build by the acceptance script (docs/features/acceptance.md; docs/history/plan-2026-09-26.md TST-9). | browser, Windows and Linux: `SpaceSwitchTest.TheCoreChordsAsKeysThroughTheWindow`; browser, Mac: `SpaceKeysTest.TheCoreChordsReachTheirCommands`; live: the key runs, 2026-10-18, the Mac's release build of patch 0071 (⇧⌘C once no clipboard manager held the chord: Maccy takes it while it runs) (BACKLOG S-173) | built |
| Z8 | The Shortcuts block lists ⌥⇧⌘D (Ctrl+Alt+Shift+D), "Turn dark pages on or off", under "Page" (dark-pages Dk18). The chord was unbound in Chromium and in Stedding on both platforms (⇧⌘D is the address row's, toolbar T10; ⌥⌘D is the Dock's on the Mac), so it has no divergence row (Z2). On Windows it is in `kSteddingCtrlAltAcceleratorMap`, never the main table (HANDOFF trap 42). | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`, `ShortcutReferenceTest.DarkPagesHasAChordOfItsOwn` (the chord on both platforms; on Windows no other mapping holds it) | partial · written 2026-10-18, tests not yet run |

## Running the tests

```bash
tooling/dev test shortcuts
```

## Notes

- ⇧⌘D shows or hides the address row on its own (toolbar T10); Chromium had no
  chord on it in Stedding's tables, and Bookmark All Tabs keeps its menu item.
- Inside a little window (little E2), ⌘O sends the page into a tab (Open File
  elsewhere), ⇧⌘O into a split and Escape closes the window; ⌃⌘N is the split
  (welcome W6), and Chromium's ⌥⌘N splits too, where Arc opens a little window: a
  divergence recorded here, the decision left for later (little E5).
