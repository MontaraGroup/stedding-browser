# Feature: Library

Status: **Lb1–Lb7 planned** (BACKLOG S-61). Not built. Downloads and History are panels in the sidebar’s column (`sidebar-panels.md`). Easels stay deferred (ADR 0012). No model.

One bottom-left door for archive, captures and downloads, when it is built. Owner docs: `docs/PRODUCT.md` §9.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Lb1 | The downloads button at the switcher’s left opens the Downloads panel in the sidebar’s column (`sidebar-panels.md` Pn2), not the bubble, and keeps the progress ring. The Library, when it comes, opens from a control of its own. The Archived row stays until then. | `SidebarPanelsTest.TheKeysAndButtonsOpenThePanelsInTheColumn` (Pn2). The Library’s own control is not written. | planned · BACKLOG S-61 (the Library). The button’s panel is Pn2. |
| Lb2 | The overlay is a layered child of the page card. Escape or a click on the scrim closes it. It does not cover the sidebar. | `LibraryViewTest.BoundsMatchTheCard` (not written) | planned · BACKLOG S-61 |
| Lb3 | Three shelves — Archived, Captures, Downloads. The last-used shelf is a profile pref. | `LibraryViewTest.ShelfChoice` (not written) | planned · BACKLOG S-61 |
| Lb4 | Each screenshot appends an index row (path, url, host, time, kind). The Captures shelf lists that index. Files stay in Downloads. | `CaptureIndexTest.CaptureAppendsARow` (not written) | planned · BACKLOG S-61 |
| Lb5 | The Library’s Downloads shelf is the Downloads panel (`sidebar-panels.md` Pn9): downloads grouped by the day they started, newest first, a download in progress at the top of its day with its progress. Grouping by kind within a day is not planned. | `SidebarPanelsTest.TheDownloadsPanelFollowsAndActsOnEachDownload` (Pn9) | planned · BACKLOG S-61 (the shelf). The list is Pn9. |
| Lb6 | The Archived shelf is `ListArchivedTabs` (archive A8–A11). Restore recreates a missing Space. | `LibraryViewTest.RestoreFromTheShelf` (not written) | planned · BACKLOG S-61 |
| Lb7 | Hovering a Library row shows a local preview (capture thumbnail, download type, archived title). No live site fetch. | `LibraryViewTest.HoverShowsPreview` (not written) | planned · BACKLOG S-61 |
