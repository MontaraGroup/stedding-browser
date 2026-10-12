# Documentation

Everything under `docs/`, grouped by who it is for.

## For users

| Document | Contents |
|---|---|
| [INSTALL.md](INSTALL.md) | Installing on macOS and Windows, verifying the checksum, updating, uninstalling, where your data lives |
| [SHORTCUTS.md](SHORTCUTS.md) | Every keyboard shortcut, macOS and Windows, and where Stedding differs from Chromium |
| [FAQ.md](FAQ.md) | Questions and answers, including Independent session |
| [PRIVACY.md](PRIVACY.md) | The privacy principles and every network connection the browser makes |
| [release-notes/](release-notes/) | What each release changed, with checksums |

## About the project

| Document | Contents |
|---|---|
| [VISION.md](VISION.md) | Why this exists, values, explicit non-goals |
| [ROADMAP.md](ROADMAP.md) | Milestones from zero to 1.0, with acceptance criteria and where each stands |
| [PRODUCT.md](PRODUCT.md) | The full feature specification, Arc parity and what goes beyond it, each feature with its home |
| [COMPETITORS.md](COMPETITORS.md) | Arc, Dia, Zen, Helium, Vivaldi, Brave, Thorium — and the gap Stedding fills |
| [EVIDENCE.md](EVIDENCE.md) | What Arc switchers actually ask for, with counts |
| [NAMING.md](NAMING.md) | How the name was chosen |
| [BRAND.md](BRAND.md) | Name meaning, voice, taglines, trademark hygiene |
| [QUALITY.md](QUALITY.md) | The "ready-to-use" bar: performance budgets, release checklist |
| [UI-SPEC.md](UI-SPEC.md) | The measured match to Arc's interface: the targets and the values Stedding ships |
| [ARC-ROUND2.md](ARC-ROUND2.md) | The ledger of what real use turned up on each build, round by round, and what changed |
| [../BACKLOG.md](../BACKLOG.md) | The one list of open work |

## For contributors

| Document | Contents |
|---|---|
| [../AGENTS.md](../AGENTS.md) | Start here: the project, the rules, how to work, the red lines |
| [../PLAN.md](../PLAN.md) | The order of work until Phase 1 is done; the status blocks are at the top |
| [HANDOFF.md](HANDOFF.md) | The fast path, where things live, the dev parameters, the traps already paid for (with an index) |
| [AGENT-LOOP.md](AGENT-LOOP.md) | The working procedure: ask once, order of evidence, supervise long jobs, one pass finds everything, then the loop for one change |
| [PROJECT-LOG.md](PROJECT-LOG.md) | What was built, round by round, with the evidence: history, not instructions |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Fork strategy, the build, patch management, branding, updater, signing, measured numbers |
| [features/](features/) | One specification per feature: each behaviour, its test and whether it is built, partial or planned. The definition of done |
| [decisions/](decisions/) | Architecture decision records |
| [ROUND6-PLAN.md](ROUND6-PLAN.md) | Round 6, the Zen-mods review: the plan and how each part landed |
| [perf/](perf/) | How to measure the performance budgets, and the one comparison so far (2026-09-02, Chromium 153; nothing current) |
| [../tooling/README.md](../tooling/README.md) | The build, capture and release scripts |
| [../branding/README.md](../branding/README.md) | The mark, the palette, and how the assets are generated |
| [../CONTRIBUTING.md](../CONTRIBUTING.md) · [../SECURITY.md](../SECURITY.md) | How to contribute; how to report a vulnerability |

`images/` holds the captures the docs show, each from the build it was taken on: the
`ui-*.png` measurements are beta 7's, the Windows captures beta 5's, and the README's
`readme/` captures mostly beta 8's. `tooling/check-geometry` re-measures the ones the
interface spec depends on.
