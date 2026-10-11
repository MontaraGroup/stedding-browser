# Feature: Shortcut reference

Status: **Z1–Z6 built** (round 6, `docs/ROUND6-PLAN.md` R6-01; Z6 round 9, every platform).
Owner docs: `docs/QUALITY.md` ("UX completeness"), `docs/ROADMAP.md` M6. Patches: `0016` (round 6 wave 1); `0043` (every platform); `0058` (Z3's Arc note); `0059` (Z1's list, S-82).

chrome://settings/stedding carries a read-only "Shortcuts" block: every chord Stedding
adds and every Chromium chord Stedding rebinds, read from the accelerator tables at
startup so the list cannot drift from the binary. Items that remap a chord add their
divergence row here, in their own patch; nothing is hand-typed. Remapping by the user
(`docs/PRODUCT.md` §12, 1.0) is out of scope.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Z1 | chrome://settings/stedding carries a "Shortcuts" block listing every Stedding chord (no Peek rows while Peek is off; they left on 2026-10-10, S-82; the row chords say the ninth goes to the last row) and every Chromium chord Stedding remaps, built from the accelerator tables (the Mac's `accelerators_cocoa.mm` and `global_keyboard_shortcuts_mac.mm`, the views `accelerator_table.cc` elsewhere, Z6) at startup, never hand-typed; it is the in-product shortcut reference `docs/QUALITY.md` and `docs/ROADMAP.md` cite. | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`, `ShortcutReferenceTest.TheListMatchesTheProduct`; capture, dark and light | built |
| Z2 | Every remapped Chromium chord has a divergence row: the chord, what Chromium binds it to, what Stedding binds it to (⌘S and ⇧⌘S from round 5; ⌘D, ⇧⌘C, ⌥⌘↑/↓, ⇧⌘K from round 6). Items record divergences here, not in `docs/QUALITY.md`. | `ShortcutReferenceTest.DivergenceRowsNameBothBindings` | built |
| Z3 | A note row records that ⌃1–⌃9 collide with macOS Mission Control "Switch to Desktop N" once a second desktop exists (plan D5); on Windows the note is Alt's -- a tap of Alt alone still focuses the app menu -- and a second one says what AltGr does to a Ctrl+Alt chord. On the Mac a third, on ⌥⌘N's row, says that Arc, while it runs, takes that chord from every app for its Little Arc window, and what to do instead (backlog S-79, 2026-10-02). | `ShortcutReferenceTest.SpaceKeysNoteIsPresent`; `ShortcutReferenceTest.ArcsSplitKeyNoteIsPresent` (the Mac: Arc's Little Arc chord); capture | built |
| Z4 | The block is found by settings search ("shortcuts"); welcome step 5 (W6) links to it. The ⌘T action "Show Keyboard Shortcuts" opens it. | live: settings search; welcome link | built |
| Z5 | The block is read-only: remapping (`docs/PRODUCT.md` §12 "Keyboard shortcut customisation", 1.0) is not built (BACKLOG S-91). | spec row | built |
| Z6 | The reference is the platform's: chords come from `GetAcceleratorForCommandId`, which reads the Mac's menu tables there and the views accelerator table on Windows; the divergence rows name what Chromium bound on that platform (Ctrl+Shift+P was the system print dialog, Ctrl+Shift+C Inspect) and the notes are the platform's (Z3). The handler, its test and the block on chrome://settings/stedding build everywhere (windows N5, N7). | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed`, `ShortcutReferenceTest.DivergenceRowsNameBothBindings`, `ShortcutReferenceTest.SpaceKeysNoteIsPresent`; live: `w10_shortcuts` (Windows, 2026-09-10) | built · the tests pass on the Mac and on Windows (the unit sweep, last on Windows 2026-10-11); no CI runs them (S-49) |

## Running the tests

```bash
tooling/dev test shortcuts
```

- ⇧⌘D shows or hides the address row on its own (toolbar T10); Chromium had no
  chord on it in Stedding's tables, and Bookmark All Tabs keeps its menu item.
- Inside a little window (little E2), ⌘O sends the page into a tab (Open File
  elsewhere), ⇧⌘O into a split and Escape closes the window; ⌥⌘N stays the split
  (welcome W6), where Arc opens a little window: a divergence recorded here, the
  decision left for later (little E5).
