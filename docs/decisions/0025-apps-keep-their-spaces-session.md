# 0025 — An app made from a page keeps the session of its Space

Status: Proposed (the owner's decision 2 in `docs/features/web-apps.md`)
Date: 2026-10-18

## Context

A page can become an app of its own (`docs/features/web-apps.md`): Safari's "Add to Dock…",
Chromium's "Install page as app…". Chromium opens every app window in the profile's shared
cookie jar. Stedding's Spaces can each keep a session of their own (ADR 0019): a Space's
pages live in a storage partition of the profile, named by the Space's token. An app made from
a Work Space's Gmail would, under Chromium's rule, open signed in as the personal account of
the shared jar, or signed out. Safari gives each app a jar of its own, seeded with the site's
cookies when the app is made; that needs cookie copying, a rule for collecting the jar, and a
control to clear it, none of which Chromium has for a web app.

## Decision

An app keeps the session of the Space it was made in. The install command records, with the
app, the jar of the tab the app was made from (`stedding.apps.jars`: app id to the Space's
partition name; a tab in the shared jar records nothing). Every page the app opens without an
opener is made in that jar while a Space keeps it with its own session on; once the Space is
deleted or its session turned off, the app uses the shared jar, and turning the session on
again gives the jar back. The record is written below the UI layer
(`chrome/common/stedding/web_apps.h`), read through one question (`stedding::AppJarInUse`),
and goes with the app when it is removed. On the Mac the launcher a Dock tile was added for is
recorded too (`stedding.apps.dock_tiles`), so removing the app takes that tile alone.

## Consequences

- Two preferences of the profile, each a dictionary keyed by app id. Renaming either, or
  moving the jar into Chromium's own web-app database, needs a migration.
- An app and the Space it came from share cookies and storage: signing out in one signs out
  the other, and "Also clear data" on removal signs the Space's tabs out of the site (the
  dialog says so).
- A page moving between the app and the browser keeps its jar: "Open in Stedding" files it in
  the Space that keeps the jar, "Open in <App>" opens a tab of another jar in the app's own
  window instead of moving it, and links are captured only from pages in the app's jar.
- A jar of its own per app (Safari's rule) stays possible later, as an option on top of this
  record: the record would name the app's own partition.
