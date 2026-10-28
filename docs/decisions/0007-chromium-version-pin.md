# 0007 — Chromium version pin: newest stable, single source of truth

Status: Accepted
Date: 2026-08-30

## Context

[ADR 0003](0003-chromium-minimal-patch-fork.md) chose Chromium stable as the base. The pin is which build the patch series sits on. A pin that lags means a larger rebase, and it means shipping known vulnerabilities ([ROADMAP.md](../ROADMAP.md#the-quality-bar), security).

## Decision

Pin to the newest build on Chromium's stable channel for the platforms we ship. The only copy is [`tooling/chromium-version`](../../tooling/chromium-version). [`tooling/lib.sh`](../../tooling/lib.sh) reads it. [`tooling/check-repo`](../../tooling/check-repo) `version` fails if any file that is not documentation hard-codes the version. Documentation may quote the pin.

At or below 1% of a platform's stable users, a build is a partial rollout (early stable, or a respin being tried). [`tooling/check-pin`](../../tooling/check-pin) names it and leaves the pin. The pin follows that build once it reaches more than 1% of users. The verdict follows Mac stable, the first platform we ship ([ADR 0006](0006-platform-order-macos-first.md)). Windows uses the same pin. Linux is consulted so a point release on our milestone is seen when a Mac rollout is pulled. Extended stable is out.

Moving the pin is its own commit. The file records the tag, the milestone, the upstream commit, the channel and the date. The pin stays back only for a named, fixed blocker, written in that commit.

On 2026-10-28 the owner merged M157's stable cut, 157.0.8103.31, into main before Mac stable served it. The file records the channel as beta. `tooling/check-pin` reports `ahead` until Mac stable serves an M157 build to more than 1% of users. Google's schedule puts M157 on stable on 2026-11-03. The published release, 0.3.0 beta 22, was built on Chromium 156.0.8078.48. The pin still moves to the build Mac stable serves once that build is past 1% ([BACKLOG.md](../../BACKLOG.md) S-278).

A security update on stable is a rebased release within 7 days when the fix is in the wild, and within 14 days otherwise ([ROADMAP.md](../ROADMAP.md#the-quality-bar)). `tooling/check-pin` runs daily. The `upstream` workflow opens one issue while the pin is not current, and closes it when the pin is current.

## Consequences

One file answers which Chromium a checkout is on. Rebases stay small, which is the point of the series in ADR 0003. A pin ahead of Mac stable is work in the tree. Shipping it is a separate step.
