# 0025 — An app made from a page keeps the session of its Space

Status: Implemented in patch 0072. Behaviour: `docs/features/web-apps.md` Wa11–Wa15. That spec’s decision 2 is this rule.
Date: 2026-10-18

## Context

A page can become an app (`docs/features/web-apps.md`). Chromium opens an app window in the profile’s shared cookie jar. A Space can keep a session of its own (ADR 0019): its pages live in a storage partition named by the Space’s token. Without a record of that partition, an app made from a page in the Space would open in the shared jar.

## Decision

An app keeps the session of the Space it was made in.

The install records the jar of the tab it was made from (`stedding.apps.jars`: app id to the Space’s partition name). A tab in the shared jar records nothing. Every page the app opens without an opener is created in that jar while a Space still keeps that partition with its own session on. When the Space is deleted, or its session is turned off, the app uses the shared jar. Turning the session on again gives the jar back. A page opened with `window.open` keeps its opener’s jar.

The record lives below the UI layer (`chrome/common/stedding/web_apps.h`) and is read through `stedding::AppJarInUse`. It is removed with the app. On the Mac, the launcher a Dock tile was added for is recorded too (`stedding.apps.dock_tiles`), so removing the app takes that tile alone.

## Consequences

- Two profile preferences, each a dictionary keyed by app id. Renaming either, or moving the jar into Chromium’s web-app database, needs a migration.
- The app and its Space share cookies and storage. “Also clear data” on removal clears the site in that jar. When the jar is a Space’s, the dialog says so (Wa18).
- “Open in Stedding” puts the page in the Space that keeps its jar, without a reload. “Open in &lt;App&gt;” does not move a tab that is in another jar: the app opens the address in its own window. Links are not captured until the user turns that on for the app; then only links from pages in the app’s jar are captured (Wa15).
- A jar of its own per app can still be added on this record. The record would then name the app’s own partition.
