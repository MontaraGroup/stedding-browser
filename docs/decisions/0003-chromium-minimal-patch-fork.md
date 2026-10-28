# 0003 — Base: Chromium stable, minimal patch-set fork

Status: Accepted
Date: 2026-08-30

## Context

The browser needs Chrome extension compatibility, native desktop performance, and a base one small team can rebase on every stable release.

- **Electron or CEF.** Rejected. Extension APIs live in Chrome's browser layer, not in the embedding APIs, and the extra runtime costs memory and speed.
- **Firefox.** Rejected. Extensions would be a WebExtensions subset, not the Chrome Web Store, and Zen Browser already ships this kind of interface on Firefox.
- **A hard fork.** Rejected. Security fixes would have to be backported here.
- **A minimal patch series on Chromium stable.** The Brave/Helium model: a vanilla checkout plus an ordered, documented series.

The same rejections are in [Rejected alternatives](../ARCHITECTURE.md#rejected-alternatives).

## Decision

Stedding is a **minimal patch-set fork of Chromium, stable channel**. UI work stays as high in the stack as possible (views, WebUI, top chrome) so patches stay small. The series is ordered and documented. Taking each new stable is scheduled work. Which build is pinned, and when it moves, is [ADR 0007](0007-chromium-version-pin.md). Layout and patch rules: [Architecture](../ARCHITECTURE.md).

## Consequences

- Chrome extension compatibility is Chromium's.
- Security fixes come by moving the pin (ADR 0007). The work is rebasing the series.
- Every patch is carried on every rebase, so a change has to be worth that. An engine patch is an ADR. The network-stack ones are [ADR 0027](0027-changes-to-the-network-stack.md).
- The checkout and the build are the cost of this base.
