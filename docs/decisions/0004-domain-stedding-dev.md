# 0004 — Canonical domain: stedding.dev

Status: Accepted. The site is not the download host or the update path: release files are GitHub Releases, and the feeds in `updates/` are served from GitHub (ADR 0014, ADR 0022, ADR 0023).
Date: 2026-08-30

## Context

The project needed one canonical domain.

- **stedding.dev** — available, and registered. DNS is on Cloudflare.
- **steddingbrowser.com** — available. Ranking follows the pages and the links, not an exact-match name.
- **stedding.top** — cheap, and .top is widely used for spam. A bad fit for a page people download a browser from.
- **stedding.com, stedding.app, and stedding.co** — already registered by other parties.

The same note is under [The name](../VISION.md#the-name).

## Decision

**stedding.dev** is the canonical domain: https://stedding.dev. It is short, the TLD fits a technical audience, and the .dev zone is on the HSTS preload list, so the site is HTTPS-only.

## Consequences

- The site is its own repository. It links to the releases. It is not on the update path ([ADR 0014](0014-github-releases-as-update-channel.md)).
- The Mac feed is `updates/appcast.xml` ([ADR 0022](0022-sparkle-updates-the-mac.md)). The Windows feed is `updates/appcast-windows.xml` ([ADR 0023](0023-updates-on-windows-and-linux.md), [ADR 0026](0026-a-windows-update-key.md)).
- Product docs are in this repository.
- Hosting has to present a valid certificate. Plain HTTP is not available on .dev.
- stedding.com is not this project's. Some typed traffic goes elsewhere. Buying it is not part of this decision.
- Another domain is registered only to redirect here.
- The site's registrar and DNS accounts stay locked (two-factor authentication, a transfer lock). Updates do not use them.
