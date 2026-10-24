# AGENTS.md — start here

This is the brief for anyone opening this repository cold, a contributor or the tools
they work with: what the project is, the rules, how to work, where to look. Everything
needed is in this repo; nothing depends on a particular editor, tool, session or
machine. What was built and when is `docs/PROJECT-LOG.md`; the order
of work is `BACKLOG.md`; the owner's decisions and the rules of done are `PLAN.md`; the
procedure is `docs/AGENT-LOOP.md`; the traps are `docs/HANDOFF.md`.

## What this project is

**Stedding Browser** — a fully open-source, Chromium-based desktop browser with an
Arc-style interface: sidebar with vertical tabs, workspaces, split view, and a command
bar. Built for technical users who want privacy, control, and a modern, productive UI —
without trusting a VC-funded company's roadmap or telemetry.

- Site: **https://stedding.dev** — live, from its own private repository
  (`ysalitrynskyi/stedding.dev`: Astro, static, Cloudflare Pages; it reads the latest
  release from the GitHub Releases API at build time and is not on the update path,
  ADR 0014). The website's own rules and deployment steps are in that repository
  (`AGENTS.md`, `docs/DEPLOYMENT.md`); DNS on Cloudflare.
- Repo: `ysalitrynskyi/stedding-browser` on GitHub
- License: **BSD-3-Clause** (permissive; closed-source or paid add-ons may exist later,
  the core stays BSD — see `docs/decisions/0005-open-core.md`)
- Started: 2026-08-30

The name: *Stedding* means a haven, a settled, kept place. It is shaped on the English
word "steading" (a farmstead or homestead), which comes from "stead", an old word for a
place. The meaning: a place to use the web where surveillance and vendor control cannot
reach. Say it STED-ding, rhyming with "wedding". The name was chosen after vetting
candidate names against browser, software, trademark, SEO, and pronunciation criteria —
full record in `docs/VISION.md` ("The name"). Only the word "Stedding" is used, as this browser's
name. No artwork, names, quotations or other material from any book, film, game or other
brand, and no claimed affiliation with anyone (`docs/VISION.md`, "Brand and voice").

## The mandate — read this twice

We are building a **ready-to-use product**, not a tech demo, not a proof of concept,
not a config for enthusiasts. The bar is: a technical user downloads an installer,
opens it, imports their profile, and prefers it to Chrome/Arc within a day. Every
milestone must end in something installable and usable. When choosing between
"interesting" and "shippable and polished", choose shippable and polished.

Concretely (full detail in `docs/ROADMAP.md`, "The quality bar"):

- Every merged change keeps the browser buildable and runnable.
- Features ship complete: keyboard shortcuts, settings entry, edge cases, polish —
  or they don't ship.
- No telemetry by default. Privacy defaults are product features, not afterthoughts
  (`docs/PRIVACY.md`).
- Full Chrome extension compatibility is a hard requirement — it is a top reason to
  base on Chromium at all.

## Technical direction (summary — details in docs/ARCHITECTURE.md)

- Base: **Chromium, stable channel, minimal patch-set fork** (the Brave/Helium model,
  not a hard fork). UI work lives as high in the stack as possible (views/WebUI/top
  chrome) to keep rebases cheap.
- Patches are maintained as an ordered, documented series; tracking upstream stable is
  a recurring scheduled task, not an emergency.
- Considered and rejected: Electron/CEF wrapper (no real extension support, worse
  performance), Firefox base (extension ecosystem, and Zen already owns that lane).
- Target platforms in order: **macOS first, then Windows, then Linux.**

## Your first fifteen minutes

1. `tooling/dev status`: the pin, the patch count, whether the checkout and the test
   binaries exist. Every number in a doc comes from here or from a command, never from prose.
2. `PLAN.md` (short: the owner's decisions, when an item is done), then `BACKLOG.md`, the
   order of work.
3. `docs/HANDOFF.md`: the "Fast path" and the trap index at its top. Read a trap when its
   topic comes up.
4. Ask the operator **once**, in one message, for what you would otherwise find out hours in
   (the list under "How to work", rule 2).
5. Use the product before any long job: launch it, click it, look at it.

## How to work here

The short form. `docs/AGENT-LOOP.md` has the detail and the numbers behind each rule; they
come from a long run in which the slowest parts were not the builds.

1. **Cheapest evidence first.** Launch the build and use it, with the real pointer and
   keyboard: that found faults (Mac wording on Windows, unreadable light-mode text, a clipped
   command bar, an infobar left in full screen, doubled hover names) that every passing test
   run had missed, because the tests asked other questions. Then the suites on the shipping
   configuration; then a build with DCHECKs and the dangling-pointer detector (release speed,
   and the most defects found, most of them in the product); then ASan (slow, and the fewest
   findings per hour); a debug build only if a check needs one.
2. **Ask once, up front.** May you drive the screen and keyboard. May you push, and release
   when done (neither happens without a yes in chat, ever). Which output directories may you
   delete. Is the machine yours for the night. Is there a setting only the operator may flip
   (Windows clipboard history, for the Win+V check). Will they close their own Stedding for
   the installer test (a release on the same Chromium number installs as a repair, trap 62),
   and quit Arc and any clipboard manager for the keyboard checks (each takes a chord from
   every app while it runs, trap 94).
   A list asked at the start costs one message; asked when blocked it cost hours.
3. **Supervise long jobs; do not poll them.** A build or run past a few minutes is one
   detached job that writes a status file and a last line (`tooling\win\build-until-done.ps1`,
   `tooling/dev`), waited for by that line and never by the clock. Post one status line, with a
   number in it, before any wait over ten minutes. The same steps killed at the end of three
   chunks in a row are stuck, not slow: time one by hand (trap 57).
4. **One pass should find everything.** A check that aborts at its first failure hides the
   rest; every fix then costs a rebuild and a rerun to find the next. Collect every distinct
   failure per run, read them through `tooling/digest-sanitizer` (a few lines where the raw
   output is pages of frames for every test), fix in batches.
5. **Every finding gets a test, and its fix goes into the patch that owns the code**
   (`tooling/fold-fix`). Then use the product again: a fix is done when the thing you saw
   has stopped happening on the real build.
6. **Read and search cheaply.** `git grep` in the checkout (seconds, where `grep -r` timed
   out); cap the output of any command you have not run before; a script of more than three
   lines goes in a file, not a heredoc (backslash quoting cost round trips); crop screenshots
   to the window and look at text, not pictures, where UI Automation or DevTools can give it.
7. **Say what was and was not verified,** result first, in plain sentences, in the register
   the operator's own agent instructions set (their "Response contract").

## Red lines

| | |
|---|---|
| Release, tag, publish, upload an installer | Only when the operator has said so in chat for this release. `tooling/publish-release` is the one way. A release is tried the way a user gets it (trap 47) |
| Push | Only when asked. Never force. Stage only your own paths |
| GitHub issues | An issue a user files is a suggestion unless it reports a bug. Fix bugs; ask the owner before building a feature an issue asks for. Never comment on or close an issue; label one only when the owner asks (`PLAN.md` decision 16) |
| Attribution | Release notes, docs and code comments name no tool. No commit names a tool as a co-author or carries a "generated by" footer. A pull request from outside the project made with an AI tool's help says so the one way `CONTRIBUTING.md` ("AI tools") sets out, and `tooling/check-disclosure` fails one that does not |
| Secrets, machine paths, personal data | Never committed: this repo is public |
| What lives in this repository | The product, its tooling, its specs and its user docs, kept concise. Anything else stays outside it |
| Screen captures and recordings | The window under test only, taken by its window id: `tooling/capture-windows` (stills, through `tooling/capture-state` and `tooling/drive`'s `shot`) and `tooling/record-window` (video). Never the screen, never another app's window, never a recording of the whole display cropped afterwards: a crop still leaves the operator's screen in the file, and another window can cover the one under test (`docs/HANDOFF.md` trap 133) |
| Real input (pointer, keyboard) | Only with the operator's yes, and guarded: only into the window under test, only while the operator's hands are off. `tooling\win\drive.ps1` does both |
| Deleting | Your own build output and scratch only. Ask before anything else |
| System settings | Not yours to change, including the default browser and clipboard history: ask the operator to flip them |
| A number or a claim you did not measure | `TBD`, never a guess (and never typed into a doc that `tooling/dev status` can derive) |

## Where things stand

Kept short on purpose: a paragraph that restates the state goes stale within a day, and
`docs/PROJECT-LOG.md` exists for the record.

- The pin and the series: `tooling/dev status`. The Windows PC is the development machine;
  the Mac holds the Mac-only checks (`BACKLOG.md` rows say which wait on it).
- The work order: `BACKLOG.md`, in priority order; its first "Checks still owed" row is the
  core-loop gate that new features wait for (`PLAN.md`).
- What is released: `docs/release-notes/` has the current release's notes and `archive.md`
  with every earlier one; `gh release list` is the truth. The site (`stedding.dev`) and the
  Homebrew tap (`ysalitrynskyi/homebrew-stedding`) read the same list; `docs/HANDOFF.md`
  ("After a release") lists every place a release must reach.
- What is open: `BACKLOG.md`, by id.

## Map of the docs

| File | What's in it |
|---|---|
| `docs/README.md` | The index of everything under `docs/`, grouped by who it is for |
| `docs/INSTALL.md`, `docs/SHORTCUTS.md`, `docs/FAQ.md` | The user-facing pages the README links: installing and verifying, every shortcut on both platforms, questions and answers. Plain language; keep them true when behaviour changes |
| `docs/AGENT-LOOP.md` | **The working procedure**: order of evidence, ask once, supervise long jobs, one pass finds everything, then research → spec → test → implement → patch; the evidence of what Arc switchers ask for |
| `docs/features/` | One spec per feature; numbered behaviours, each with its test id; `acceptance.md` holds the scripts run on a real build before a release, with every run |
| `PLAN.md` | The owner's standing decisions and when an item counts as done |
| `docs/history/` | The 2026-09-26 audit (TAB-1, SPC-4, ...), which the code cites by path, and `archive.md`: closed backlog items, the project log before 2026-10-15, round 6, the operator's rounds 2 to 11, a code review (S-179 to S-210) |
| `BACKLOG.md` | The one list of open work, by id, in priority order. Other docs cite ids; closed items move to `docs/history/archive.md` |
| `docs/HANDOFF.md` | Where things live, the fast path, dev parameters, the traps already paid for (with an index) |
| `docs/PROJECT-LOG.md` | What was built since 2026-10-15, round by round, with the evidence. History, not instructions |
| `docs/VISION.md` | Why this exists, values, non-goals; the name (the naming record), the brand and voice, the competitors |
| `docs/PRODUCT.md` | Full feature spec: sidebar, workspaces, split view, command bar, settings, import; the UI spec |
| `docs/ARCHITECTURE.md` | Fork strategy, build system, patch management, updater, signing |
| `docs/ROADMAP.md` | Milestones M0→1.0 with acceptance criteria; the quality bar: performance budgets, release checklist |
| `docs/PRIVACY.md` | Privacy principles and concrete defaults |
| `docs/decisions/` | ADRs — every irreversible decision gets one |
| `CONTRIBUTING.md` | How to contribute, and the rules for pull requests made with an AI tool's help |
| `SECURITY.md` | How to report vulnerabilities |

## Conventions for contributors

- **Write docs and code in plain, correct English.** Terse is fine; cryptic is not.
- **Decisions get ADRs.** Anything hard to reverse (dependency, base version policy,
  naming, licensing) goes in `docs/decisions/NNNN-slug.md` before or with the change.
- **Never commit secrets, machine-specific paths, or personal operational data.**
  This repo is public.
- **Don't fabricate.** No invented benchmarks, dates, user counts, or claims. If a doc
  needs a number we don't have, mark it `TBD`.
- **Keep this file true, and short.** If you change direction (platforms, fork strategy,
  license), update AGENTS.md and the relevant ADR in the same commit. Put history in
  `docs/PROJECT-LOG.md`, open work in `BACKLOG.md`, and nothing dated or counted here.
- Commit messages: conventional, imperative, explain why when it isn't obvious.
- **A pull request made with an AI tool's help** follows `CONTRIBUTING.md`, "AI tools": the
  form's AI assistance box ticked, with the tool, the model and what it did; every commit
  ending with `Assisted-by: AGENT_NAME:MODEL_VERSION`, never `Co-authored-by:`; a person who
  has read and tested all of it and answers the review; nothing posted by an agent on its
  own.
- When a task is ambiguous, the tiebreaker is the mandate above: what gets a polished,
  installable browser into users' hands sooner?
