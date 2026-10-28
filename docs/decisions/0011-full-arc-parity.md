# 0011 — The product target is full functional parity with Arc

Status: Accepted. Boosts and Easels are deferred (ADR 0012). No bundled model (ADR 0020). Ideas past Arc are ADR 0021.
Date: 2026-08-30

## Context

[ADR 0010](0010-ride-upstream-vertical-tabs.md) left a product question. Chromium now has vertical tabs, so a sidebar alone does not define the project.

The owner set the target as full functional parity with Arc, the workflow as Arc shipped it, plus what Arc could not offer: open source under BSD, no telemetry by default, and no vendor that can discontinue it. Arc's maker put it in maintenance mode in May 2025 and moved to Dia ([VISION.md](../VISION.md#competitors)). The target does not keep moving.

## Decision

Stedding targets full functional parity with Arc as it shipped. [PRODUCT.md](../PRODUCT.md) is that inventory, taken from Arc's own documentation. It keeps Arc's names for Arc's concepts and states Stedding's beside them: Favorites are essentials, Air Traffic Control is routing, Little Arc is the little window. Trademarked branding is not reused ([VISION.md](../VISION.md#brand-and-voice)).

Where a feature needs Arc's account, sync or servers, parity is the local capability, named as such. Parity is the floor. Doing better does not justify shipping less.

## Consequences

That parity, minus what later decisions defer or refuse, is the product target. 1.0 in [ROADMAP.md](../ROADMAP.md) is the quality gate on what ships, and it adds nothing new. What is built, partial or still open is the feature spec under `docs/features/` and [BACKLOG.md](../../BACKLOG.md).

ADR 0010 stands. Upstream's vertical tabs are how the sidebar is built.
