# 0028 — A Space with its own session has its own essentials

Status: Accepted (the owner, 2026-10-22; GitHub issue 8)
Date: 2026-10-22

## Context

Essentials are Chromium's pinned tabs of a window, shown above every Space's list (spaces B6).
ADR 0019 kept them on the profile's shared cookie jar, since they are in every Space. A Space
can keep a session of its own (an Independent session, sessions S32): pinning one of its pages
reloaded it in the shared jar, signed out, with a warning and an undo (sessions S33). A user
asked for essentials per Space (GitHub issue 8), naming Arc and Zen. Arc shows its Favorites
in every Space of a profile and gives each profile its own; Stedding's Independent session is
what an Arc profile is to a Space.

## Decision

Essentials stay shared, except in a Space with its own session:

- A tab pinned in a Space with its own session is that Space's own essential. It stays in
  the Space's jar and shows in that Space alone. That Space shows its own essentials and no
  shared one; every other Space shows the shared ones.
- With every Space on a session of its own, the shared essentials show in each, so they can
  always be reached; a shared essential chosen from a Space that does not show it brings the
  first Space that does.
- A Space's session turned off makes its own essentials its pinned tabs, with their pinned
  addresses, in the shared jar (the owner's choice). A deleted Space's own essentials go with
  its tabs to the Space that takes them, and become its pinned tabs unless it has a session of
  its own.
- The session marks an essential that is its Space's own (`stedding.own_essential`, beside
  the Space's key), so a restart puts it back in its Space's jar.

The warning of sessions S33, which told of a tab leaving its Space's session when pinned, has
nothing left to warn of and goes, with its setting.

## Consequences

ADR 0019's "Essentials stay on the default partition" now holds for shared essentials only.
Every place that chose a jar by the pin bit asks whether the tab is a shared essential
(`SpaceModel::IsSharedEssential`, the restored-tab jar helpers, the navigation throttle, the
rebinds). The essentials grid lays out only the cards the Space shows. The sidebar backup still
writes every essential as shared (a follow-up). The Arc importer still brings every Favorite
as a shared essential: Arc's profiles are not imported (import I8).
