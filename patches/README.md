# patches/

The Stedding patch series: ordered, numbered patches applied on top of the pinned
Chromium version in `../tooling/chromium-version`. `tooling/dev status` is where
the count lives.

The series is organised by feature, not by date. A new feature adds one patch. A
fix amends the patch that owns the code, with `tooling/fold-fix` while the fix is
in the tree, or with `git commit --fixup` and `git rebase --autosquash`. A series
that records every small change as its own patch is a changelog, and a changelog
is what makes the next Chromium rebase expensive.

A round that touches many features at once is one patch when folding each part
into its owner would conflict with later patches on the same lines. Patches of
that kind are already in the series, and each message says what it covers.

0069 is not a round. It is the hunk in `base/check.cc` that lets soft checks
report instead of crash in a build without DCHECKs
([ADR 0024](../docs/decisions/0024-soft-checks-report-in-releases.md)), kept
apart so it can be dropped on its own when the releases are official builds.

The series cites docs by the paths they had when the text was written. `PLAN.md`'s
item ids (`TAB-1`, `SPC-4`, and the rest) are the audit in
[docs/history/plan-2026-09-26.md](../docs/history/plan-2026-09-26.md).
`docs/ROUND6-PLAN.md` and `docs/ARC-ROUND2.md` are sections of
[docs/history/archive.md](../docs/history/archive.md).

Icons, logos and installer images are replaced from
[../branding/](../branding/) by `tooling/apply-branding`. That copy is not a patch.

## Rules

The `patches` check in `tooling/check-repo` enforces these. CI runs
`tooling/check-repo`, which includes that check.

- **Filename**: `NNNN-short-slug.patch`, four digits, lowercase and hyphenated.
- **Numbering**: contiguous from `0001`. Renumbering is allowed.
- **Header**: every patch carries `Subject:`, `Why:` and `Removable when:`.

`Why:` is the reason the patch exists at all. `Removable when:` is the condition
that would let us delete it: an upstream flag landing, a feature being redesigned,
a dependency going away. A patch nobody can justify or delete is how a minimal
patch set stops being minimal.

Which upstream files a patch touches is the diffstat `git format-patch` writes
under the message, so it is not written out again by hand.

## Do not edit these files

The patches are generated. The working copy is commits on the `stedding-work`
branch in the Chromium checkout:

```bash
tooling/apply-patches      # series -> commits
# edit, commit, reorder, rebase
tooling/update-patches     # commits -> series
```

`tooling/dev patch` runs the export and then `tooling/check-repo`.

Editing a `.patch` by hand leaves it out of step with the branch. The next
`update-patches` replaces the numbered patches from that branch, so the edit is
lost. `apply-patches` refuses a checkout with uncommitted changes. It also
refuses to rebuild a branch that holds commits the series does not account for.
Export first, or pass `--force` to discard those commits.
