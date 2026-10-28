# 0012 — Boosts and Easels are deferred, not dropped

Status: Accepted
Date: 2026-08-31

## Context

[ADR 0011](0011-full-arc-parity.md) set full functional parity with Arc as the target. Two of Arc's features are large, and neither is browsing itself.

- **Boosts** restyle a site: colour and type, custom CSS and JavaScript, and **Zap**, which hides a clicked element on that site.
- **Easels** are whiteboards of drawings, text and captures, kept as pinned tabs.

Boosts is a script host. User JavaScript per site needs a threat model before any code. Chrome extension compatibility is a hard requirement ([AGENTS.md](../../AGENTS.md)). Stylus covers per-site CSS, Violentmonkey covers per-site JavaScript, and uBlock Origin's element picker covers Zap.

## Decision

Boosts and Easels are deferred past the first releases. They stay in [PRODUCT.md](../PRODUCT.md), marked deferred, with this ADR as the reason. They are not cancelled.

The rest of the parity inventory stands, including Spaces, Peek, the command bar, Air Traffic Control, split view, the archive, and the sidebar and tab model.

They return when either of these is true:

1. The features people stay in Arc for meet the quality bar, and there is capacity to spend. Spaces, the command bar and Peek have since shipped ([ROADMAP.md](../ROADMAP.md); Peek in 0.3.0 beta 16, [BACKLOG.md](../../BACKLOG.md) S-93). This condition is the quality bar and the capacity.
2. Users show that the extension answer is not enough.

For Boosts, the threat model comes before any implementation. When they return, the editor is a live preview while typing and a switch per site in the page menu ([ADR 0021](0021-ideas-from-nook-and-aura.md)).

## Consequences

Until this is revisited, parity with Arc is parity minus Boosts and Easels. Per-site styling and scripting are extensions. Page capture is its own feature and is not part of this deferral ([ROADMAP.md](../ROADMAP.md#deferred-with-the-intent-to-return)).
