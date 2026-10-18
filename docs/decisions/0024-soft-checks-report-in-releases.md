# 0024 — Soft checks report in the builds people run, as in Chrome

Status: Accepted
Date: 2026-10-18

## Context

Chromium has two kinds of `CHECK`. A plain one stops the process everywhere. A soft one,
`CHECK(..., base::NotFatalUntil::M<n>)`, `DUMP_WILL_BE_CHECK` and `DUMP_WILL_BE_NOTREACHED`,
marks an invariant Chromium's authors are not yet sure of: in an official build it logs and
writes a dump without crashing, and in every other build it stops the process
(`base/check.cc`, `GetDumpSeverity()`), "to detect invariant violations early in
release-build testing". Chrome is an official build, so its users never crash on one.

Stedding's betas are optimised release builds that are not official ones
(`tooling/args/release.gn`; an official build adds PGO and ThinLTO, and the first one took
four hours, `docs/ARCHITECTURE.md`; which configuration ships is still open, `S-168`). So
every soft check Chromium ships is a crash for Stedding's users that it is not for Chrome's.
The defect round of 2026-10-18 found one in Stedding's own path: picking a second engine in
the welcome flow reaches
`SearchEngineChoiceService::RecordChoiceMade`'s soft check (`BACKLOG` S-134), which an
official build reports and Stedding's betas stop on. The owner's report that the browser
"crashes all the time" (`S-66`) may include others; none was proven.

## Decision

In a build without DCHECKs, a soft check logs and writes a dump without crashing, as in an
official build: one hunk in `GetDumpSeverity()` (the `!DCHECK_IS_ON()` branch), in the
series. A build with DCHECKs, the `mac-checks` and `win-checks` configurations the suites
run on, still stops on them, so the tests keep finding what they find today. A soft check
whose milestone has passed is fatal everywhere, as upstream. The owner chose this on
2026-10-18 over building the betas as official builds and over leaving them fatal.

## Consequences

- A user meets fewer crashes than before and the same as Chrome's users on Chromium's own
  code. The dump stays on the machine: Stedding uploads no crash reports
  (`docs/PRIVACY.md`).
- The release-build suites no longer stop on a soft check; only the checks builds do. A
  soft check that fires on the shipping configuration shows as an `ERROR` line in the log,
  and a release that skipped the checks suites would not see it.
- The hunk is one more upstream file in the series to carry through rebases; it goes when
  the betas are built official.
- Fixes for soft checks Stedding's own code reaches still go in, as for the welcome flow's
  second pick: reporting is not a reason to leave one firing.
