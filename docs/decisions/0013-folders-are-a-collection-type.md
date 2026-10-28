# 0013 — Folders are a new collection type, not nested tab groups

Status: Accepted
Date: 2026-08-31

## Context

A folder is a named, collapsible container of tabs in the sidebar. Folders nest. Tabs inside a folder are not auto-archived ([archive.md](../features/archive.md) A4).

Making a Chrome tab group contain another group does not do this. `TabModel::UpdateProperties` walks a tab’s ancestors and writes each group’s id onto the tab, so the outermost group wins and the inner membership is gone. A tab has one group id, which that walk overwrites. Patch 0008 records that, in `components/tabs/public/folder_tab_collection.h`.

## Decision

**A folder is `TabCollection::Type::FOLDER`, its own collection type.** Chrome’s tab groups stay as they are, under `UNPINNED`.

- `FolderTabCollection` holds tabs and accepts `FOLDER` and `SPLIT` children. It does not accept `GROUP` (patch 0008, `components/tabs/impl/folder_tab_collection.cc`; folders F35).
- Identity is a `FolderId` (`tab_groups::TokenId<FolderId>`), not a `TabGroupId`. The path is per-tab session extra data (`stedding.folderpath`), not a group command (patch 0008; folders F5).
- `UNPINNED` accepts `FOLDER` beside `GROUP` and `SPLIT`.

## Consequences

Saved tab groups do not carry folders. A group made for a tab that sits in a folder takes that tab out of the folder (folders F35). Code that should see a folder has to be taught.

If upstream ships a nestable container that does not archive, and that the session can persist, this is the place to drop ours (patch 0008, `Removable when`).
