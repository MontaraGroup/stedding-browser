# 0007 — Chromium version pin: newest stable, single source of truth

Status: Accepted
Date: 2026-08-30

## Context

ADR 0003 chose Chromium stable as the base. That settles the *channel*, not the
*pin*: at any moment several stable versions exist at once. On 2026-08-30 the Mac
stable channel carried three live milestones — M153 (`153.0.8010.12`, rolling out),
M152 (`152.0.7977.65`), and M151 (`151.0.7922.176`, extended stable). A fork has to
say which one it builds, where that answer is written down, and when it moves.

Getting this wrong is expensive in a specific way: the patch series is rebased
against the pin, so a pin that lags means every rebase carries more upstream drift,
and — per the security gate in `../ROADMAP.md` ("The quality bar") — a lagging pin means shipping known
vulnerabilities.

## Decision

**Pin to the newest version on the Chromium stable channel for our platforms**, held
in exactly one place: `tooling/chromium-version`. Every script and build reads the pin
from that file, and `tooling/check-repo version` fails if any non-documentation file
hard-codes a version. Prose may quote the current pin where it aids the reader; code
and configuration may not, because those are what silently go stale.

- The initial pin is `153.0.8010.12` (M153).
- Security point releases move the pin on the timetable in `../ROADMAP.md` ("The quality bar") (7 days
  for in-the-wild exploits, 14 otherwise).
- **Early stable waits for the rollout.** Google ships the next milestone to a small
  share of stable users about a week before the full rollout. The pin moves to a build
  once it reaches more than 1% of a platform's stable users; until then
  `tooling/check-pin` names it as a partial rollout with its share and reports the pin
  current. The same holds for a respin on our own milestone. (Amended 2026-09-24, the
  owner: "always latest one", and the pin went from M153 straight to the M155
  early-stable build. Amended again 2026-10-23, the owner: a milestone almost nobody
  runs yet is not worth a six-hour rebuild of both machines; M157 waits for its
  rollout, about a week after early stable. On 2026-10-28 the owner had M157's stable
  cut, 157.0.8103.31, prepared and merged before the rollout, so `tooling/check-pin`
  reports the pin `ahead` until Mac stable serves M157.)
- **Extended stable is not our channel.** It trades feature currency for enterprise
  change-management we do not need, and it eventually stops receiving fixes.
- Moving the pin is always its own commit, recording the version, the upstream
  commit, and the result of applying the patch series.
- The pin may be held back only for a named, fixed blocker, recorded in the commit
  that holds it. "Not got to it yet" is not a blocker.

## Consequences

- One grep answers "what are we built on"; provenance is checkable from any build.
- Adopting a milestone during its rollout means occasionally hitting bugs the wider
  population has not — acceptable pre-1.0, and the alternative is a permanent lag.
- Rebases are frequent and small rather than rare and large, which is the whole
  premise of the minimal patch series in ADR 0003.
- We inherit upstream's deprecation timing rather than deferring it, so patches that
  depend on soon-to-be-removed upstream surfaces break early, when they are cheap
  to fix.
