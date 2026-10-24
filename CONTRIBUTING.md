# Contributing to Stedding Browser

Thanks for your interest. The project ships **betas** for macOS (Apple silicon), signed
and notarized, and an unsigned **Windows preview**, built from a patch series on
Chromium stable (see [README.md](README.md)). What is left of each milestone is the note
under its heading in [docs/ROADMAP.md](docs/ROADMAP.md). The open work is
[BACKLOG.md](BACKLOG.md), and `tooling/dev status` prints the live counts. That shapes
what kinds of contributions are useful right now.

## What helps now

- **Running the betas and saying what is wrong.** The fastest way to help: install the
  latest pre-release, use it for a day against whatever you use now, and open an issue
  for each thing that is worse. Most of the work so far has followed exactly this kind
  of feedback; what is open from it is in `BACKLOG.md`.
- **Ideas.** An issue that asks for a feature is read as a suggestion: the owner decides
  what is built, and an idea that is turned down is recorded in `BACKLOG.md` with the reason
  (`S-254`, essentials per Space, is one). An issue that reports a bug is fixed.
- **Discussions and issues.** Questions, critiques of the plan, prior art we missed,
  Chromium fork experience, packaging and signing knowledge — open a GitHub issue or
  discussion. Disagreement with a documented decision is welcome; argue against the
  reasoning in the relevant ADR.
- **Documentation PRs.** Fixes and improvements to anything in `docs/`, this file, or
  the README: factual errors, unclear wording, broken links, missing considerations.
  Small focused PRs are easiest to review.
- **Design input.** The feature spec (`docs/PRODUCT.md`), the ideas past Arc parity
  (`docs/ROADMAP.md` M10) and the privacy defaults (`docs/PRIVACY.md`) are living
  documents until code freezes them into behavior.
- **Build tooling.** `tooling/` runs on macOS arm64 and, through `tooling/win/`, on
  Windows x64. Fixes to the scripts, and reports of what breaks on a machine unlike
  the reference one, are useful now. Run `tooling/check-repo` and `tooling/check-shell`
  before opening a PR. CI (`.github/workflows/`) runs those two,
  `tooling/check-pin --self-test` and `tooling/check-disclosure --self-test` on every change,
  `tooling/check-disclosure` on every pull request ("AI tools" below), `tooling/apply-patches --check` when
  `patches/` or the pin changes and weekly, and `tooling/check-pin` daily against
  Chromium stable. Note that macOS ships bash 3.2, so the scripts must work there.

## Browser code

The patch series is real and per feature (`patches/README.md`; `tooling/dev status`
counts it). A change follows `docs/AGENT-LOOP.md`: a row in the feature's spec under
`docs/features/`, a failing test (a unit test for model logic, a browser test for a
click or a drag), the code in the checkout, a fixup into the
feature's patch (or a new patch for a new feature) with `Why:` and `Removable when:`
footers, `tooling/dev patch`, and a capture for anything visual. `docs/HANDOFF.md`
carries the dev parameters and the traps already paid for.

## Ground rules

- **Decisions go through ADRs.** Anything hard to reverse — dependencies, base
  version policy, licensing, naming — is recorded in `docs/decisions/NNNN-slug.md`
  before or with the change. If your proposal alters a recorded decision, the PR
  should update or supersede the ADR, not silently contradict it.
- **English.** All docs, code comments, commit messages, and issues are written in
  plain, correct English.
- **No fabrication.** No invented benchmarks, dates, user counts, or claims in any
  document. Unknown numbers are marked `TBD`.
- **This repo is public.** Never commit secrets, machine-specific paths, or personal
  operational data.
- **Do not copy code from other browsers into this repository.** Studying how another
  project solved something is encouraged; transcribing its implementation is not. The
  licences differ in ways that matter: this project is BSD-3-Clause (ADR 0002), while
  Zen Browser and Aura are MPL-2.0, Nook is GPL-3.0 and Vivaldi's UI is proprietary.
  The ideas taken from Nook and Aura are rebuilt from written descriptions, without
  opening their files (ADR 0021). MPL-2.0 is file-level
  copyleft — a file containing MPL code stays MPL and its source must be distributed —
  so pasting it here would either breach the licence or force those files out of the
  BSD core we committed to. Chromium itself is the exception and the reason: it is
  BSD-3-Clause, which is why we can build on it at all.

  In practice: read other browsers for product and architectural decisions, write our
  own implementation, and say in the commit message where an idea came from.

## AI tools

You may use an AI tool (a coding agent, a chat assistant, completion of more than a line) to
help with a pull request, an issue or a security report. These rules cover every such
contribution from outside the project, and `tooling/check-disclosure` holds pull requests to
the first two:

1. **Say so in the pull request.** Its form has an **AI assistance** section: tick one box.
   If a tool helped, name the tool and the model and say what it did (wrote the fix, wrote
   the tests, drafted the description, reviewed the change). A pull request with the section
   unanswered fails the `disclosure` check and is not reviewed.
2. **Mark every commit.** If a tool helped with the pull request, each of its commits ends
   with a trailer naming it, in the form the Linux kernel uses:

   ```
   Assisted-by: AGENT_NAME:MODEL_VERSION [OTHER_TOOLS]
   ```

   Not `Co-authored-by:`: a tool is not an author and cannot agree to the licence below. No
   "Generated with" footers or links either. Compilers, editors, formatters and spell
   checkers are not listed.
3. **A person answers for it.** You have read every line, can explain what it does and why
   without the tool, ran the checks and tests the change needs (`docs/AGENT-LOOP.md`), and
   answer review questions yourself. Write the description yourself, briefly: what changed,
   why, and how you tested it.
4. **No agent acts alone.** No pull request, issue, comment or review is posted by an agent
   without a person reading it first. An agent never signs anything for you.
5. **The copying rule above applies to what a tool writes.** No code from another project,
   whether you or a tool reproduced it.
6. **No generated images.** Screenshots and recordings come from a real build
   (`tooling/capture-windows`, `tooling/record-window`); no generated artwork, icons or video.
7. **Security reports**: say whether a tool found the issue or wrote the report, and
   reproduce it on a released build before sending it (`SECURITY.md`).

A contribution whose tool use was not disclosed, or that its author cannot explain, is
closed. These rules follow the practice of projects such as the Linux kernel, LLVM, Fedora
and Ghostty.

## Commit style

- Conventional, imperative subject line: `docs: clarify M0 acceptance criteria`,
  `fix: correct link to PRIVACY.md`.
- Keep the subject under about 72 characters.
- Add a body when the *why* is not obvious from the diff.
- End a commit an AI tool helped with in an `Assisted-by:` trailer ("AI tools" above).

## License and CLA

There is **no CLA**. By contributing you agree that your contributions are licensed
under the project's [BSD-3-Clause license](LICENSE), the same terms as the rest of
the repository.
