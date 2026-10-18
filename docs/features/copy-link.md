# Feature: Copy link

Status: **L1–L6 built**.
Owner docs: `docs/PRIVACY.md` (the tracking strip), `docs/PRODUCT.md`. Patch: 0016.

⇧⌘C copies the page's URL, ⌥⇧⌘C a Markdown link with a rich-text twin, both with
tracking parameters removed when the setting is on. The Markdown title is the page
title, or the host when the title is empty. With rows selected, both copy every selected
page (tabs R21); a split is one row, so on a split alone they copy the page in focus.

On Windows every chord below is the Mac's with ⌘ read as Ctrl and ⌥⌘ as Ctrl+Alt
(Alt+1–9 for the Spaces themselves); the full map is `docs/features/windows.md` N7.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| L1 | ⇧⌘C copies the page URL; ⌥⌘C keeps Inspect Element (both chords mapped to `IDC_DEV_TOOLS_INSPECT` before), recorded in the shortcut reference (Z2). | `ShortcutReferenceTest.EverySteddingCommandWithAnAcceleratorIsListed` (⇧⌘C resolves to `IDC_COPY_URL` through the accelerator tables); browser: `SidebarSelectionTest.CopyLinkOnASplitTakesThePaneInFocus` (⇧⌘C on a split with nothing else selected copies the page in focus; with another row selected, every selected page; both panes had been copied: Chromium selects both panes of the split on screen, and the copy counted tabs, not rows) | built |
| L2 | Tracking parameters are removed before the copy when the setting is on: `utm_*`, `fbclid`, `gclid`, `dclid`, `msclkid`, `mc_eid`, `mc_cid`, `igshid`, `_hsenc`, `_hsmi`, `mkt_tok`, `yclid`, `twclid`, `ref_src`, and `si` on youtube.com; the table lives in one file. Never applied to navigation. | `CleanLinkTest.TrackingParameters` | built |
| L3 | ⌥⇧⌘C (`IDC_STEDDING_COPY_MARKDOWN_LINK`) writes `[title](clean url)` as text and an anchor as HTML on the same pasteboard, so Slack, Notion and Docs paste a live link. The title is the page's own, from its committed entry, else the cleaned host -- never the formatted URL, which could carry tracking parameters (docs/history/plan-2026-09-26.md WIN-5). Brackets and backslashes in the title are escaped, so the label reads as the title: only "]" was, so a title with "[" read as text and a link on its tail (2026-10-18). A private window's copy is marked off the record, so clipboard history does not keep it. | `CopyLinkTest.PlainMarkdownAndHtmlFlavours` reads the clipboard; `CopyLinkTest.AMarkdownLabelEscapesWhatMarkdownReads` (a backslash and brackets anywhere in the title); `CopyLinkTest.UntitledPageUsesTheHost`, `CopyLinkTest.PrivatePagesAreCopiedOffTheRecord`; browser: `CopyLinkTest.AMarkdownLinkDropsTheTrackers` (an untitled page at an address with `utm_source` and `fbclid`, read back from a test clipboard); on Windows, on the machine's own clipboard, `CopyLinkClipboardHistoryTest.PrivateCopiesStayOutOfWindowsHistory` (its steps: a private window's copy carries a DWORD zero under `CanIncludeInClipboardHistory` and `CanUploadToCloudClipboard`, the two formats Windows reads to keep an item out of Win+V and the cloud clipboard; an ordinary copy carries neither) | built · Win+V's own list not yet seen (BACKLOG S-129) |
| L4 | Both appear in the tab context menu (`CommandCopyURL` exists; a Markdown sibling joins it) and the app menu; the command bar's actions mode lists them (commandbar K9). | live: capture of the tab context menu and the File menu | built |
| L5 | Chromium's `ToastId::kLinkCopied` confirms; it reads "Link copied, tracking removed" when something was stripped. | live capture through `tooling/drive` | built |
| L6 | Setting off copies the URL verbatim. | `CopyLinkTest.SettingOffCopiesVerbatim` | built |

## Running the tests

```bash
tooling/dev test copy-link
```
