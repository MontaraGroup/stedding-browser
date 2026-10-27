# Documentation

Everything under `docs/`, grouped by who it is for.

## For users

| Document | Contents |
|---|---|
| [INSTALL.md](INSTALL.md) | Installing on macOS and Windows, verifying the checksum, updating, uninstalling, where your data lives |
| [SHORTCUTS.md](SHORTCUTS.md) | Every keyboard shortcut, macOS and Windows, and where Stedding differs from Chromium |
| [FAQ.md](FAQ.md) | Questions and answers: what Stedding has that Arc did not and the reverse, updates, pinned tabs and essentials, Independent session |
| [PRIVACY.md](PRIVACY.md) | The privacy principles and every network connection the browser makes |
| [release-notes/](release-notes/) | What the current release changed, with checksums; [archive.md](release-notes/archive.md) has every earlier release's |
| [../LICENSE](../LICENSE) | The BSD-3-Clause licence: Stedding is provided as is, without warranty, and its authors are not liable for what comes of using it |

## About the project

| Document | Contents |
|---|---|
| [VISION.md](VISION.md) | Why this exists, values, non-goals; the name, the brand and voice, and the competitors (Arc, Dia, Zen, Helium, Vivaldi, Brave, Thorium) |
| [ROADMAP.md](ROADMAP.md) | Milestones from zero to 1.0, with acceptance criteria, and the quality bar: performance budgets, release checklist |
| [PRODUCT.md](PRODUCT.md) | The full feature specification, Arc parity and what goes beyond it, each feature with its home, and the UI spec: the measured match to Arc's interface |
| [../BACKLOG.md](../BACKLOG.md) | The one list of open work |

## For contributors

| Document | Contents |
|---|---|
| [../AGENTS.md](../AGENTS.md) | Start here: the project, the rules, how to work, the red lines |
| [../PLAN.md](../PLAN.md) | The owner's standing decisions and the definition of done |
| [HANDOFF.md](HANDOFF.md) | The fast path, where things live, the dev parameters, the traps already paid for (with an index) |
| [AGENT-LOOP.md](AGENT-LOOP.md) | The working procedure: ask once, order of evidence, supervise long jobs, one pass finds everything, then the loop for one change; and the evidence of what Arc switchers ask for |
| [PROJECT-LOG.md](PROJECT-LOG.md) | What was built since 2026-10-15, round by round, with the evidence: history, not instructions |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Fork strategy, the build, patch management, branding, updater, signing, measured numbers |
| [features/](features/) | One specification per feature: each behaviour, its test and whether it is built, partial or planned |
| [features/acceptance.md](features/acceptance.md) | The acceptance scripts run by hand or with the drivers on a real build before a release, the core loop first, with a table of every run |
| [decisions/](decisions/) | Architecture decision records |
| [history/](history/) | The 2026-09-26 audit and its item ids (TAB-1, SPC-4, ...), which the code cites; and [archive.md](history/archive.md): the closed backlog items, the project log before 2026-10-15, round 6's plan (R6-nn), the operator's rounds 2 to 11 and the code review of 2026-10-15 |
| [perf/](perf/) | How to measure the performance budgets, and the one comparison so far (2026-09-02, Chromium 153; nothing current) |
| [../tooling/README.md](../tooling/README.md) | The build, capture and release scripts |
| [../branding/README.md](../branding/README.md) | The mark, the palette, and how the assets are generated |
| [../CONTRIBUTING.md](../CONTRIBUTING.md) · [../SECURITY.md](../SECURITY.md) | How to contribute; how to report a vulnerability |

`images/` holds the captures the docs show, each from the build it was taken on: the
`ui-*.png` measurements are beta 7's, the Windows captures beta 5's, and the README's
`readme/` captures from 2026-10-21 to 2026-10-26, from 0.3.0 betas. `tooling/check-geometry` re-measures the ones the
interface spec depends on.
