# Feature: Page card

Status: **U1–U9 built** (U9 since beta 14; U2 seen in immersive full screen on 2026-10-18).
Owner docs: `docs/PRODUCT.md#ui-spec`. Patches: 0017, 0060 (U9).

The content card is one surface: the link status bubble is a pill inside it, the find
bar takes the dialog colours and the card's right edge, and split panes carry no ring
(Arc draws none; the page-coloured bar, toolbar T3, says which pane is active).

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| U1 | In Stedding mode the link status bubble is a pill inside the card: inset 8 DIP from the card's left and bottom edges, radius = height/2 on all four corners, background and text from `kColorStatusBubble*` mapped to the card surface and secondary text, a hairline in the toolbar-separator tint. Chromium's slide-away-from-the-mouse and expand-on-hover stay. | a hovered-link probe (`tooling/drive` hovers a link, shot): pill luma at the inset, card corner still rounded beneath | built |
| U2 | The pill never touches the card edge at any window size, including immersive fullscreen. | capture at 1400×880 and in ⌃⌘F, the full screen taken with `tooling/drive`'s `screen` step (2026-10-18, the Mac's release build of patch 0071) | built |
| U3 | `kColorFindBarBackground` / `Foreground` / `MatchCount` / `ButtonIcon*` map to the dialog colours the command bar uses (commandbar K6), so the ⌘F bubble follows light, dark and the Space tint. | a colour probe on a ⌘F capture, dark and light | built |
| U4 | The find bubble's right edge aligns with the content card's right edge (the `card_gutter`, toolbar T2). | probe | built |
| U5 | No position, width or checkbox settings: Arc has one placement for each and shows the hovered link. One switch turns the hovered link's address off (U9). | spec row | built |
| U6 | `kColorMultiContentsViewActiveContentOutline` and `InactiveContentOutline` map to the row-text tint at 0x18 (the selected-row value) so light, dark and Space tint follow; no Material ring. Since 2026-10-13 a pane has no padding for the ring (splits J7), and the 1 DIP ring around a pane is not drawn at all: the page's own edge on the mat is the pane's edge. | a probe on a split capture at the pane edge: no Material outline luma; `SidebarFormsTest.TheClosedFormsLeaveThePageEdgeToEdge` (no padding) | built |
| U7 | The 3 px highlight (`ContentsContainerOutline::UpdateState(is_active, is_highlighted)`) stays for the drag-and-drop target only, drawn over the page's own edge now that a pane has no padding (splits J7). | existing split browsertests unchanged | built |
| U8 | The inactive pane's mini toolbar is captured against Arc in the same pass and left alone unless it clashes (a separate row if it changes). | capture | built |
| U9 | "Show a link's address on hover" (`stedding.page.show_link_address`, profile, on by default; Settings > Stedding > Pages and menus, after the animation switch, settings T16): off, a hovered link's address stays out of the pill (U1), while a page's loading status still shows there. The window's web-contents delegate hands the pill no address while it is off (`BrowserWebContentsDelegate::UpdateTargetURL`) and reads the setting at every hover, so a change takes effect at the next one. The command bar has the preference's on/off row, "Link address on hover: On / Off" (commandbar K9). | browser: `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay` (on in a fresh profile; off, a hovered link shows no pill; on again, it does); unit: `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault` (on) | built |
