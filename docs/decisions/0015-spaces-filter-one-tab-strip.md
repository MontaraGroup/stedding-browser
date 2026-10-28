# 0015 — Spaces filter one tab strip; they do not park tabs

Status: Accepted
Date: 2026-08-31

## Context

A Space is a set of tabs in one window. Three shapes were possible.

**Parking.** On a switch, take the outgoing Space’s tabs off the strip and insert the incoming Space’s.

**Filtering.** Every tab stays in the one strip and carries a Space id. The sidebar shows the active Space.

**A collection.** Add `SPACE` so the strip holds Space collections, and those hold `PINNED` and `UNPINNED`.

## Decision

**Filtering. One tab strip, every tab tagged with a Space id, shown or hidden for the active Space.** Patch 0004.

Parking loses tabs on a restart, and it does so quietly. Chromium rebuilds the session log from the live tab strip. A tab that is not in that strip lasts only until the next rebuild. A second place for tabs would be a patch into the session service.

A `SPACE` collection would sit between the strip and `PINNED` / `UNPINNED`. That moves every index in the tab strip model, for a structure the user cannot see. A folder is a collection type ([0013](0013-folders-are-a-collection-type.md)) because it nests inside the strip. A Space contains the strip’s tabs, which is the other shape.

## Consequences

Every tab is in the live strip, so a rebuild keeps the other Spaces’ tabs. The Space id is per-tab extra data, written again by `stedding_session_rebuild.h` when the log is rebuilt (patch 0004). Closing a window closes its tabs, including Spaces that are not on screen.

`TabStripModel` holds every Space’s tabs, so its count is the window. A tab the user cannot see — another Space, a collapsed group, a collapsed folder — is `TabStripModel::IsTabHidden`, and traversal uses that (patch 0004; spaces B33). The command bar lists this window’s open tabs from every Space, or only the active Space while Hide Other Spaces is on ([commandbar.md](../features/commandbar.md) K2).

If the tab collection tree grows a first-class notion of tab sets, this becomes a collection and the filter becomes a tree walk (patch 0004, `Removable when`).
