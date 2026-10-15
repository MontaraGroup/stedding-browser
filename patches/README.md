# patches/

The Stedding patch series: ordered, numbered patches applied on top of the pinned
Chromium version in `../tooling/chromium-version`.

The series is organised **by feature, not by date**. A fix to Spaces amends the Spaces
patch it belongs to (`git commit --fixup=<sha>` in the checkout, then `git rebase
--autosquash`); it does not become a new patch at the end. A series that records every
toolbar-height change as its own patch is a changelog, and a changelog is what makes
the next Chromium rebase expensive. The series was squashed to one patch per
feature on 2026-09-01 (`S-11`); keep it that way: a new feature adds one patch, a fix
amends its feature's, and `tooling/dev status` is where the count lives.

The one exception: a round of operator feedback that touches many features at once lands
as one patch when its fixups would conflict with every later patch that touched the same
lines; the next rebase folds them where they belong (`docs/history/plan-2026-09-26.md`, SER-4). These are:

- 0013 (round 5), 0037 (round 7) and 0039 (round 8);
- 0040 and 0041, M8's first slice; 0042, the refresh features privacy Q10 keeps on; 0043,
  the Windows keyboard map; 0044 and 0045, round 9's first start and rail;
- 0047 and 0048, the keep-pile after Independent sessions (`S-61`);
- 0053 to 0057, the audit's Phase 0 fixes, and 0058, the owner's pass on beta 10;
- 0059, the operator's pass on beta 12: the hidden sidebar, pins, the resize edge, the
  settings sections;
- 0060, the operator's round after beta 13: Never as the archive default, the welcome
  flow's behaviour step, ten backlog items, the address band and the toasts' place;
  0061, three more: Site Search chips, Collapse Pinned Tabs, New Documents; and 0062, the
  Mac's round of 2026-10-12 and 13: a folder close as one Recently Closed entry, the lit
  chip, the extension-reload test and the quiet-start tests (its privacy code went into
  0030), a dangling pointer in the tab layout's animation maps that the Mac's checked build
  found, and the operator's three of 2026-10-13: split panes that are the page a gutter
  apart, the row kept off the traffic lights while a hidden sidebar opens, and a private
  window's row in the page's colour; 0063, the round of 2026-10-14: a split keeps its
  folder, a closed folder comes back in its order, a chip lit only once the drag says
  what it carries and kept through a rebuild, a Space's name shown once, the restore
  bar out of full screen, and that evening a folder closed in part back in its places and
  Restore Folder with Shift held in one window;
- 0064, the tests of 2026-10-14: Stedding's browser tests merged into scenarios that share a
  browser, with a `SCOPED_TRACE` per step; near-copy unit tests made table-driven; the drag
  fixtures kept above other windows. Test files only, touched by most patches since 0057,
  so one patch at the tip rather than a fixup into each;
- 0065, the code review of 2026-10-15 (`docs/history/review-2026-10-15.md`): two crashes in
  the tab model and its views (closing a split's pane, grouping a tab inside a folder), the
  Arc import's crash, a deleted Space's wipe that waits for its pages, Autofill's server
  queries off, three command-bar faults, a stacked split's corners, the export's file name,
  Shift on the Mac History menu's Restore Folder, a folder close's place kept through a
  sleep, and the tests that read a freed bar; 0066, the same review's filed items fixed:
  another app's mark and a shortcut file's target, host routes with IPv6 and default ports,
  the welcome flow's focus, Clear for the keyboard, a deleted Space's wipe finished after a
  quit, Undo kept out of a group, the keychain key after a failed move, and weak tests;
  with it, a tab group's header in the sidebar drawn as a row, not a blank coloured bar.

Patch messages cite the docs as they were when each was written: `PLAN.md`'s item ids
(TAB-1, SPC-4, ...), `docs/ROUND6-PLAN.md` and `docs/ARC-ROUND2.md` now live under
`docs/history/` (`docs/history/README.md`).

Most branding is **not** here: it is asset replacement in [../branding/](../branding/),
which costs no patches at all. A patch is the last resort, not the first.

## Rules

Enforced by `tooling/check-repo patches`, which CI runs:

- **Filename**: `NNNN-short-slug.patch`, four digits, lowercase and hyphenated.
- **Numbering**: contiguous from `0001`. Renumbering is fine; gaps are not.
- **Header**: every patch carries `Subject:`, `Why:` and `Removable when:`.

`Why:` is the reason the patch exists at all. `Removable when:` is the condition that
would let us delete it — an upstream flag landing, a feature being redesigned, a
dependency going away. A patch nobody can justify or delete is how a minimal patch set
stops being minimal.

Which upstream files a patch touches is answered by the diffstat `git format-patch`
writes under the message, so it is not restated by hand where it could drift.

## Do not edit these files

The patches are generated, not authored. The working representation is commits on the
`stedding-work` branch in the Chromium checkout:

```bash
tooling/apply-patches      # series -> commits
# edit, commit, reorder, rebase
tooling/update-patches     # commits -> series
```

Editing a `.patch` by hand puts it out of step with the branch, and the next
`update-patches` will silently overwrite your change. `apply-patches` also refuses to
rebuild a branch holding commits the series does not account for, so exporting before
re-applying is not optional.
