# 0002 — License: BSD-3-Clause

Status: Accepted
Date: 2026-08-30

## Context

The license had to be chosen before the first public commit. Relicensing later needs every contributor's consent. The core had to stay open, sit cleanly on Chromium's BSD-3-Clause license and the other licenses in that tree, leave room for a closed or paid add-on (ADR 0005), and limit implied endorsement.

Copyleft (the GPL family) was rejected: it fights a permissive upstream and would reach those add-ons. MIT was the alternative.

## Decision

The project is licensed under **BSD-3-Clause**, the same license as Chromium. The text is [LICENSE](../../LICENSE).

Clause 3 is why this and not MIT. Neither the copyright holder's name nor the contributors' names may be used to endorse or promote a derived product without written permission.

## Consequences

- Anyone may use, modify, redistribute, and sell the code, including in a proprietary product.
- A closed or paid add-on may link against the core. What stays in the core is [ADR 0005](0005-open-core.md).
- Patches sit on a tree under the same license.
- Clause 3 is not a trademark registration. Use of the name is [Brand and voice](../VISION.md#brand-and-voice).
- Once outside contributions are in, relicensing is not practical.
