# Feature: Private windows wear a different coat

Status: **V1–V3, V7–V9 built**; **V6 partial** (it does not arise while Peek is off, BACKLOG S-93); **V4, V5 withdrawn**.
Owner docs: `docs/PRIVACY.md`, `docs/PRODUCT.md` §7. Patch: 0034.

A private window (⇧⌘N) must be told apart at a glance and must leave nothing in the
sidebar's model, the session or the archive. It paints a flat graphite ground with no
Space tint, its title row reads "Private", it has no Space switcher, and Chromium's
avatar badge stays hidden (V4 withdrawn).

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| V1 | A private window paints a flat graphite ground in both schemes: no gradient, no Space tint; the mat, the page bar and the command bar follow through the colour mixer. Private is decided once, by `stedding::IsPrivateWindow` (an incognito profile), and the window says so on its colour key: `BrowserWidget::GetColorProviderKey` puts Stedding's private mark in the key's app-controller slot, and the mixer paints graphite for that key alone, never for a normal window in dark mode with Chrome's Grey colour (`PLAN.md` WIN-F8). | `SteddingColorMixerTest.PrivateWindowsAreGraphite`, `SteddingColorMixerTest.GreyInDarkModeIsNotPrivate`, `PrivateWindowTest.IncognitoIsPrivate`; browser: `PrivateCoatTest.OnlyAnIncognitoWindowIsGraphite` (real windows, the whole colour pipeline: graphite for the incognito window alone, not for a normal window in dark mode with Customize Chrome's Grey, nor for a Guest window); captures `w4_private_dark`, `w4_private_light` | built |
| V2 | The Space title row reads "Private" with the incognito glyph and opens no menu; the switcher row shows no chips and no "+"; the window title carries " – Private". The label and the title follow `stedding::IsPrivateWindow`, the same test as the coat (V1), so a Guest window has neither (V7). | `SpaceWindowTest.PrivateWindowHasNoSpaceModel` (no model, so no switcher and no chords), `PrivateWindowTest.*`; capture `w4_private_dark` (the row and the title) | built |
| V3 | No `SpaceModel` and no `TabArchiver` for a private window: the archiver never closes a private tab, and nothing private reaches the sidebar model or the session's extra data. | `TabArchiverTest.SkipsOffTheRecordWindows`, `SpaceWindowTest.PrivateWindowHasNoSpaceModel` | built |
| V4 | Chromium's avatar badge ("Incognito") shows again for private windows only; every other window keeps the toolbar without it. | none | withdrawn · dropped: the address row keeps Chromium's avatar button hidden; the coat, the title row's glyph and the window title say what the window is |
| V5 | The local new tab page adds one line under the hint: "Private window: history, cookies and site data are forgotten when the last private window closes". | none | withdrawn · dropped: a private window shows Chromium's own incognito new tab page, which already says what is forgotten; Stedding's local page never appears there |
| V6 | Peek and its promotion into a split stay inside the private window. | by construction: `PeekView::PromoteToTab` and `PromoteToSplit` insert into the peek's own window; live: ⌘O on a private peek stays private | partial · does not arise while Peek is off (BACKLOG S-93) |
| V7 | A Guest window is not private. Its profile is off the record, so it has no Spaces and no archive, and it gets the private window's rows -- the New Tab row, no Clear line, no Space switcher, no "+" pill -- but it wears the ordinary coat (the sand or navy ground, not graphite), its title row stays empty, and its window title has no " – Private" (`PLAN.md` WIN-F8). | `PrivateWindowTest.OffTheRecordAloneIsNotPrivate`; browser: `PrivateCoatTest.OnlyAnIncognitoWindowIsGraphite` (a Guest window: not graphite, no " – Private" in its title, no "Private" row); live: a Guest window (`tooling/capture-state --guest`): the navy ground, the New Tab row, no title row | built |
| V8 | ⇧⌘K (and the Clear rows of the menus) closes a private window's tabs and keeps the window and its private session, with one New Tab; the window has no Spaces, so no pinned run and no Clear line (spaces B17; PLAN.md CMD-3). | browser: `ClearSpaceTest.ClearingAPrivateWindowKeepsIt` | built |
| V9 | A private window's address row takes the page's colour, as a normal window's does (toolbar T3, T7, T31), and a Guest window's too; the private window stays graphite. The page's colour belongs to the Space model, which neither window has, so `BrowserWindowFeatures` owns a `PageThemeColorController` for them; without it the row sat on the bare ground, Back, Forward and Reload with it, under a page of another colour (operator, 2026-10-13). The colour key has one app-controller slot: the private mark holds it until the page has a colour, then the row's own supplier, marked to stand for the mark (`stedding::SetMarksPrivateWindow`, read by `IsPrivateColorKey`); private windows share those suppliers, and they are never freed, as the mark is not. The rest of PLAN.md WIN-6 (the address row's own rules, the density at startup) is open. | browser: `PrivateCoatTest.APrivateWindowsRowTakesThePagesColour` (an orange page: the private row's colour, its icons' contrast, the key still private and graphite; a Guest window's row in the ordinary coat); unit: `SteddingColorMixerTest.AMarkedSupplierStandsForThePrivateMark`, `PageThemeColorControllerTest.AColoursSupplierIsSharedAndKept` (no supplier is freed, so a private window never takes a freed normal one's cached provider); live, Mac release build, 2026-10-13: a private window over the incognito page, an orange page and a white one, the row in each page's colour with Back, Forward and Reload on it, the ground graphite | built |

## Notes

- Chromium forces a dark, grayscale colour key for incognito, and a normal window with
  Chrome's Grey colour in dark mode gets the same key, so the key's colour fields cannot
  say "private". The window says it instead: `BrowserWidget` puts Stedding's private
  mark (`SteddingPrivateWindowMark()`) in the key's app-controller slot for a window
  `stedding::IsPrivateWindow` calls private, and `AddSteddingColorMixer` paints graphite
  for that key. Once the page has a colour, the row's supplier holds the slot instead,
  marked to stand for the mark (V9).
- The Space chords (⌃1–9, ⌥⌘←/→) do nothing in a private window: there is no model to
  act on (spaces B29).
- "Private" as the title row's text is a VoiceOver label too (critic #31).
