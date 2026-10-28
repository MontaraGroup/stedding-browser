# 0016 — One sidebar for every window: the SpaceRegistry

Status: Accepted. What `profile_id` means is [0019](0019-space-sessions-are-storage-partitions.md). Essentials in a Space with its own session are [0028](0028-a-spaces-own-essentials.md).
Date: 2026-09-05

## Context

[0015](0015-spaces-filter-one-tab-strip.md) made Spaces a filter over one window’s tab strip, with a `SpaceModel` per window. A second window then started with a default Space and none of the user’s. The sidebar is one list per profile.

Copying every tab into every window would leave two of each and no real one. A shared list, with each tab living in one window, is the other shape.

## Decision

- A profile-level **`SpaceRegistry`** (a `KeyedService`) owns the Space list and its order. Each entry has a name, an icon, a colour, whether that colour was chosen, an optional dark colour, a profile id, an isolation flag, and whether that Space’s pinned run is collapsed (windows G0). It is the preference `stedding.spaces.registry`, written on every change (patch 0036; pins H17).
- **`SpaceModel` stays per window.** It keeps the active Space and each open tab’s membership, observes the registry, and forwards add, remove, move, rename, icon, colour, pinned-run collapse and isolation to it.
- **A pinned tab is a tab of one window.** Essentials and pins stay with that window’s tabs ([windows.md](../features/windows.md) G1). There is no ghost row in the other windows. “Show here / Go to window” for a tab that lives in another window is not built (windows G2, `BACKLOG.md` S-94).
- **The session stays per window.** Extra data keeps the active Space and the memberships. The registry is the preference. A window that brings a Space the registry does not know adds it (patch 0036).
- **A registry Space carries `profile_id`.** What the field means is 0019.
- **New Blank Window** (the command bar; ⌥⇧⌘N on the Mac, Ctrl+Alt+Shift+N on Windows) does not follow the registry. It keeps a Space list of its own (`SpaceWindowTest.BlankWindowHasItsOwnSpaces`). A private window has no `SpaceModel` ([private.md](../features/private.md) V3).

## Consequences

Every normal window shows the same Spaces. A rename in one is a rename in all (`SpaceWindowTest.SecondWindowSeesTheSameSpaces`). The first window of a profile seeds the registry from the Spaces in its session; later windows read it. The settings page reads the registry (windows G3).
