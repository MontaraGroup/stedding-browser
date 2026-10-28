# Feature: Clipboard fence

Status: **Cf1–Cf2 withdrawn** (patch 0055). **Cf3 planned** (BACKLOG S-61). **Cf4 partial**: the off-the-record mark is tested; Win+V's own list has not been seen (BACKLOG S-129).

Copy and paste are not tagged with a Space. The OS pasteboard is not fenced.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Cf1 | Copy inside an isolated Space would tag the clipboard with that Space's jar. | none | withdrawn · cut in patch 0055 |
| Cf2 | Paste into a different isolated Space would confirm first. | none | withdrawn · with Cf1 |
| Cf3 | `navigator.clipboard` and paste into another app are not fenced until a `content/` ADR. | documented | planned · BACKLOG S-61 |
| Cf4 | What Stedding itself puts on the clipboard from a private or Guest window stays out of the system's clipboard history and its cloud clipboard (Windows' Win+V), as the omnibox's own copies do. Copy link, the Markdown link and Copy title (`WriteLinksToClipboard`, `WriteTitleToClipboard`) are written with `ui::ScopedClipboardWriter::MarkAsOffTheRecord` when any page in the copy is off the record, so one such page marks the whole copy. A screenshot is marked from the capture's window, fixed when the capture starts (screenshot C1). | `CopyLinkTest.PrivatePagesAreCopiedOffTheRecord`, `CopyLinkTest.CopyTitleWritesThePagesTitle`; on Windows, `CopyLinkClipboardHistoryTest.PrivateCopiesStayOutOfWindowsHistory` (a private Markdown copy and a private screenshot carry a DWORD zero under `CanIncludeInClipboardHistory` and `CanUploadToCloudClipboard`; an ordinary copy and screenshot carry neither) | partial · Win+V's own list not seen: clipboard history is the owner's setting (BACKLOG S-129, `docs/history/plan-2026-09-26.md` WIN-5) |
