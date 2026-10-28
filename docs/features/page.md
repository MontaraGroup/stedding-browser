# Feature: Page card

Status: **U1–U9 built.**
Owner docs: `docs/PRODUCT.md` (UI spec). Patches: 0017 (U1–U8), 0060 (U9), 0062 (U6, U7).

The page is one card. The link-status bubble is a pill inside it, the find bar uses the dialog colours and the card's right edge, and a split pane has no ring. The page-coloured address row (toolbar T3) shows which pane is active.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| U1 | In Stedding mode the link-status bubble is a pill inside the card: 8 DIP from the page's left and bottom edges, every corner at half the height, background `ui::kColorDialogBackground`, text `ui::kColorSecondaryForeground`, hairline `ui::kColorSeparator`. Chromium's slide-away-from-the-mouse and expand-on-hover stay. | a hovered-link probe (`tooling/drive` hovers a link, shot): pill luma at the inset, card corner still rounded beneath | built |
| U2 | That 8 DIP inset is applied whenever the pill is repositioned, at every window size, including immersive full screen. | capture at 1400×880 and in ⌃⌘F, the full screen taken with `tooling/drive`'s `screen` step (2026-10-18, the Mac's release build of patch 0071) | built |
| U3 | `kColorFindBarBackground`, `Foreground`, `MatchCount` and `ButtonIcon*` map to the dialog colours the command bar uses (commandbar K6), so ⌘F follows light, dark and the Space tint. | a colour probe on a ⌘F capture, dark and light | built |
| U4 | The find bar's right edge is the content card's right edge: `GetFindBarBoundingBox` insets by `SteddingCardGutter` (toolbar T2; none when the page is flush or the sidebar is hidden). | probe | built |
| U5 | No position, width or colour settings. One switch turns the hovered link's address off (U9). | spec row | built |
| U6 | `kColorMultiContentsViewActiveContentOutline` and `InactiveContentOutline` map to the row-text tint at 0x18. A pane has no padding for a ring (splits J7). The outline view is hidden except while the pane is the drop target (U7), so the page's own edge on the mat is the pane's edge. | browser: `SidebarFormsTest.TheClosedFormsLeaveThePageEdgeToEdge` (no padding) | built |
| U7 | The 3 px highlight (`ContentsContainerOutline::UpdateState`) is drawn only for a drag-and-drop target, over the page's own edge. | existing split browsertests unchanged | built |
| U8 | The inactive pane's mini toolbar is Chromium's, unchanged. | capture | built |
| U9 | "Show a link's address on hover" (`stedding.page.show_link_address`, profile, on by default; Settings › Stedding › Pages and menus, after the animation switch, settings T16). Off, the window hands the pill no address (`BrowserWebContentsDelegate::UpdateTargetURL`), read at every hover, so the next hover follows the switch. A page's loading status still shows. The command bar's row is "Link address on hover" (commandbar K9). | browser: `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay`; unit: `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault` | built |
