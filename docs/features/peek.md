# Feature: Peek

Status: **P10 built**; **P1–P9 partial: switched off and hidden.** The peek's card lays its
page out 0 px tall, so no one sees a page in it, and the review in docs/history/plan-2026-09-26.md (CMD-9, CMD-10)
found security holes in how a peek is opened. Peek is off by default and its setting is
hidden until it is rebuilt (`PLAN.md` decision 2; the rebuild is `BACKLOG.md` S-93).
P1–P9 describe the intended behaviour and their tests check the decision and the view's
parts; none of them reaches a user today.
Owner docs: `docs/PRODUCT.md` ("Peek": what makes pinned tabs behave like apps). Patch: `0009`.

A link from a pinned tab that would leave the pinned site opens in a peek: a page over the
window, not a tab. Escape or a click outside dismisses it; ⌘O (or the button) promotes it to a
real tab, moving the same page into the strip so nothing reloads. "Pinned" means either tier:
Chromium-pinned (the essentials row) or pinned within a Space.

The decision is a navigation throttle (`PeekNavigationThrottle`, registered from Chromium's
throttle list for renderer-initiated main-frame navigations in pinned tabs) for links that
navigate the tab, and one check at the top of `chrome::Navigate()` for links that ask for a
new tab. The overlay is
`PeekView`, a layered child of the browser view like the command bar; it owns its WebContents
and hands it to the tab strip on promotion.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| P1 | A link click from a pinned tab to a different site (eTLD+1) opens a peek instead of navigating the tab. | `ShouldPeekTest.Decisions` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P2 | Links that stay on the pinned site (other paths, subdomains, http→https) navigate the tab as always. | `ShouldPeekTest.Decisions` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P3 | Unpinned tabs are never throttled; the throttle is not even registered for them. | `ShouldPeekTest.Decisions` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P4 | Typed URLs, script redirects (sign-in bounces) and form posts navigate the pinned tab; only a user's link click peeks. | `ShouldPeekTest.Decisions`, `PeekThrottleTest.ScriptRedirectFromPinnedTabProceeds` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P5 | Only http(s) pages peek; chrome://, file: and blank pages never do. | `ShouldPeekTest.Decisions` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P6 | A peek owns a page of its own at the link's URL; the window's tabs are untouched while it is open. | `PeekViewTest.PeekLoadsItsOwnPage` | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P7 | Promoting (⌘O, the button) moves the very same page into a new active tab and closes the peek. | `PeekViewTest.PromotingMovesThePageIntoANewActiveTab`; live: ⌘O in the peek | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P8 | Links from a pinned tab that open a new tab (`target=_blank`, `window.open`, ⌘-click) also peek when they leave the site, as in Arc; a renderer-created page is adopted by the peek. | `PeekNewTabTest.NewTabLinkFromPinnedTabPeeks`, `PeekNewTabTest.OtherNewTabLinksOpenTabs`; live: `target=_blank` link from the pinned page | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P9 | ⇧⌘O (or the button) promotes the peek into a split with the tab it came from, using Chromium's split view; a source already in a split gets a plain tab. | `PeekViewTest.PromotingIntoASplitPairsWithTheSourceTab`; live: ⇧⌘O in a peek from the pinned page, both pages side by side | partial · off until rebuilt (S-93); the peek shows no page (docs/history/plan-2026-09-26.md CMD-9) |
| P10 | Peek is off on a fresh profile, and nothing in the product turns it on; with it off, pinned tabs follow links like any other. | `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault` (default off), `ShouldPeekTest.Decisions`; browser: `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay` (a fresh profile: the pinned tab goes, no peek, no new tab) | built |
