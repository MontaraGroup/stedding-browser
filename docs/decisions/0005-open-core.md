# 0005 — Open core: the browser stays BSD forever

Status: Accepted
Date: 2026-08-30

## Context

Keeping a browser current costs money. The license ([ADR 0002](0002-license-bsd-3-clause.md)) leaves room for a paid add-on, so the boundary had to be written down before anyone relied on the project. There is no paid product, and none is on the path to 1.0 ([Out of scope for this ladder](../ROADMAP.md#out-of-scope-for-this-ladder)).

## Decision

Stedding is **open core**.

- The browser — everything needed to build, install, and use the product in [PRODUCT.md](../PRODUCT.md) — stays **BSD-3-Clause**. A feature that is in the core does not move behind a paywall or a closed license.
- A closed or paid feature is allowed only as a separate add-on or service, clearly labeled, and not bundled so that refusing it makes the core worse.
- If a capability is table stakes for a browser, it belongs in the core.

This is the boundary. It is not a product plan.

## Consequences

- The core staying open is a dated promise.
- A later paid add-on does not need a new license for the core.
- A feature is either core (BSD, in this repository) or an add-on (separate; it may be closed or paid). If it is unclear, it is core.
- A fork may ship the core commercially. That is the license.
