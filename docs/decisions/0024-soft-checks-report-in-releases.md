# 0024 — Soft checks report in the builds people run, as in Chrome

Status: Accepted
Date: 2026-10-18

## Context

A plain `CHECK` stops the process everywhere. A soft check — `CHECK(..., base::NotFatalUntil::M<n>)`, `DUMP_WILL_BE_CHECK`, `DUMP_WILL_BE_NOTREACHED` — logs and writes a dump without crashing in an official build, and stops the process in every other build (`GetDumpSeverity()` in `base/check.cc`).

Published images are `release` on the Mac and `win-release` on Windows (`tooling/args/release.gn`, `tooling/args/win-release.gn`): optimised, and not official builds. `official.gn` adds PGO and ThinLTO. No published image has been built with it ([ARCHITECTURE.md](../ARCHITECTURE.md)). Which configuration must ship is still open ([BACKLOG.md](../../BACKLOG.md) S-168). A soft check that Chrome only reports was therefore a crash for Stedding's users. A second search engine chosen in the welcome flow reached `SearchEngineChoiceService::RecordChoiceMade` (S-134).

## Decision

In a build without DCHECKs, a soft check logs and writes a dump without crashing, as in an official build. Patch 0069 adds a `!DCHECK_IS_ON()` branch in `GetDumpSeverity()` that returns `LOGGING_ERROR`.

`mac-checks` and `win-checks` set `dcheck_always_on`, and those builds still stop on a soft check. A soft check whose milestone has passed is fatal in every build, as upstream.

## Consequences

The dump stays on the machine. Stedding uploads no crash reports ([PRIVACY.md](../PRIVACY.md)).

Suites on the release configuration do not stop on a soft check. One that fires there is an `ERROR` line in the log. Only the checks builds fail the process.

The hunk stays in the series until releases are official builds (S-168). A soft check that Stedding's own code reaches is still fixed. The welcome flow's later pick no longer reaches the check named above.
