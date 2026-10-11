# 0021 — Ideas from Nook and Aura: rebuilt, never copied

Status: Accepted
Date: 2026-10-11

## Context

Two open-source Arc-style browsers were read on 2026-10-11 for what they have that
Stedding lacks. Nook (`nook-browser/Nook`) is active, a WebKit browser for macOS 26 in
Swift and SwiftUI, GPL-3.0 with its name and icon reserved. Aura
(`doorhinge-apps/Aura-Browser`) is an archived iPad-first WebKit app in Swift, MPL-2.0 since
2025-06-06 (GPL-3.0 before; its rewrite has no license at all). Neither shares a line of code
with a Chromium patch series in C++, and both licenses are copyleft: GPL-3.0 would make every
Stedding binary GPL-3.0, and an MPL-2.0 file keeps its license and its source obligation, so
the core would no longer be all BSD-3-Clause (ADR 0002, ADR 0005). The owner liked a dozen of
their ideas and asked for them on the roadmap.

## Decision

**Their behaviours are rebuilt from scratch, from written descriptions; nothing of theirs is
copied.** No code, scripts, data files, shortcut tables, icons or layout constants from either
repository, nor a translation of them. Facts are taken from their primary sources instead (a
web app's own shortcut list from its own documentation).

- **Third-party pieces they use come from their original projects, each under its own
  license and with its own ADR first.** The first is the ad blocker: Brave's adblock-rust
  (MPL-2.0) as a separate component, or the blocking left to extensions, with the filter
  lists fetched at run time rather than built in (EasyList and uBlock's lists are GPL-3.0 or
  CC BY-SA). Nothing is built until that ADR is accepted.
- **AI stays out (ADR 0020):** Nook's sidebar chat, tab organizer and agent-control server
  and Aura's "Browse for Me" are not taken.
- **Boosts stay deferred (ADR 0012).** Aura's editor -- a live preview while typing, a switch
  per site in the page menu -- is the model when the threat model lets them return, with the
  CSS applied as the page starts loading rather than after it.
- **Placement:** `docs/ROADMAP.md` M10 ("Beyond parity") lists them and their acceptance
  criteria; `BACKLOG.md` S-88 to S-101 carry one item each, in priority order after automatic
  updates and the open defects. M10 runs alongside M8 and M9: each item is independent, lands behind its own spec
  row and the quality bar, and none is a condition of 1.0 except shortcut customisation,
  which `docs/PRODUCT.md` §12 already put there.
- **A second, closer read of Nook's code the same day** added S-118 to S-125 to M10 (the
  smaller things), detail to S-74 and S-88 to S-101, and items for Arc behaviour that
  `docs/PRODUCT.md` already put at 1.0 with no item yet (S-107 to S-117, S-126). It also
  read these and left them out:
  - YouTube and social-site tweaks (hiding Shorts and sponsored posts, SponsorBlock): a
    script host per site, the reason Boosts are deferred, and extensions already do it.
  - The cookie and cache inspector and its "high-risk" score: Chromium's site data pages
    cover it, and its logic is wrong.
  - The address field in the sidebar: the address row stays on the page card (toolbar T1
    to T5).
  - Daily sidebar backups: cut by the owner on 2026-09-26 (import I17, I19).
  - Essentials and history of their own per Space: essentials are shared across Spaces
    (spaces B6, ADRs 0015 and 0019).
  - Drag previews that change shape, and trackpad haptics: little value for the work.

## Consequences

- Each item gets its feature spec rows (`docs/features/`) when its work starts, with tests
  that fail first, as every feature does.
- Whoever builds one does not open the other project's files; the descriptions in
  `BACKLOG.md` and `docs/COMPETITORS.md` are enough, and keep the work clean of both
  licenses.
- The ad blocker changes `docs/PRIVACY.md`'s defaults and the network list; its ADR says how.
