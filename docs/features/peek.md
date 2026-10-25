# Feature: Peek

Status: **P1–P16 built** (and private V6) (2026-10-25, BACKLOG S-93), not yet released; **off by default**
until the owner turns it on (`PLAN.md` decision 2). Settings › Stedding › "Open links from
pinned tabs in a peek" turns it on.
Owner docs: `docs/PRODUCT.md` ("Peek": what makes pinned tabs behave like apps). Patch: `0009`
(the decision), with the little window's patch (`0035`) for the window it opens.

A link from a pinned tab that would leave the pinned site opens in a peek: a little window
(`little.md`) over the window, nearly its size, while the pinned tab stays where it was.
"Pinned" means either tier: Chromium-pinned (the essentials row) or pinned within a Space.
The peek is a whole tab in a window of its own, so dialogs, file choosers, permissions, the
popup blocker and the address row with the site's security state all work in it as in any
tab. Its row has "Open as Tab" (⌘O) and "Open in Split View" (⇧⌘O): either moves the very
page into the window, without loading it again. Escape, ⌘W or a click on the window it came
from closes it.

The decision is a navigation throttle (`PeekNavigationThrottle`, registered for
renderer-initiated main-frame navigations in pinned tabs) for links that navigate the tab, and
one check at the top of `chrome::Navigate()` for links that ask for a new tab. The window is
`stedding::OpenPeek` (`chrome/browser/ui/stedding/peek.h`), a little window marked as a peek's
by its page; the moves into the window are the little window's (`PromoteLittleWindow`).

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| P1 | A link click from a pinned tab to a different site (eTLD+1) opens a peek instead of navigating the tab. | `ShouldPeekTest.Decisions`; browser: `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` | built |
| P2 | Links that stay on the pinned site (other paths, subdomains, http→https) navigate the tab as always. | `ShouldPeekTest.Decisions`; browser: `PeekTest.ASameSiteLinkOrAScriptsClickStaysInThePin` | built |
| P3 | Unpinned tabs are never throttled; the throttle is not even registered for them. | `ShouldPeekTest.Decisions`, `PeekNewTabTest.OtherNewTabLinksOpenTabs` | built |
| P4 | Typed URLs, script redirects (sign-in bounces) and form posts navigate the pinned tab; only a user's link click peeks. | `ShouldPeekTest.Decisions`, `PeekThrottleTest.ScriptRedirectFromPinnedTabProceeds` | built |
| P5 | Only http(s) pages peek; chrome://, file: and blank pages never do. | `ShouldPeekTest.Decisions` | built |
| P6 | A peek is a little window over the window the link came from, its one tab the link's page: a whole tab, with dialogs, file choosers, permissions and the address row. The window's tabs are untouched while it is open. | browser: `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` (a peek window, the page laid out taller than 0 px, the tab count and the pinned page unchanged); live on the Mac, 2026-10-25: a page's `alert()` showed its dialog in the peek, and a pin in a full-screen window peeked over it in the same full-screen Space | built |
| P7 | Open as Tab (⌘O, the row's button, the page menu's first row) moves the very page into a new active tab of the window it came from, in the pinned tab's Space, and closes the peek. Nothing loads again. | browser: `PeekTest.OpenAsTabMovesThePageAsItIs` (the same WebContents, the same committed entry); live: ⌘O in a peek | built |
| P8 | Links from a pinned tab that open a new tab (`target=_blank`, `window.open`, ⌘-click) also peek when they leave the site; a page the source made itself (one with an opener) is adopted by the peek. | `PeekNewTabTest.NewTabLinkFromPinnedTabPeeks`, `PeekNewTabTest.OtherNewTabLinksOpenTabs`; browser: `PeekTest.ALinkForANewTabPeeks` | built |
| P9 | Open in Split View (⇧⌘O; Ctrl+Shift+O on Windows, the bookmark manager's chord, which a little window takes for the split; the row's button; the page menu's second row) puts the page in a split beside the pinned tab it came from. The pair's row then sits under the Clear line, as any Space pin that joins a split leaves the pinned run (splits J5, an open question for the owner, BACKLOG S-102). An essential cannot take a pair (it would pin the page), nor a tab already in a split: their peeks show Open as Tab alone, and ⇧⌘O gives a tab of its own (PLAN.md CMD-30, decided so). | browser: `PeekTest.OpenInSplitViewPairsThePageWithItsPin`, `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` (no split button over an essential) | built |
| P10 | Peek is off on a fresh profile; Settings › Stedding › "Open links from pinned tabs in a peek" turns it on. With it off, pinned tabs follow links like any other. | `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault` (default off), `ShouldPeekTest.Decisions`; browser: `DefaultsTest.AFreshProfileHoldsAndWorksAfterStay` (a fresh profile: the pinned tab goes, no peek, no new tab) | built |
| P11 | Only the user's own click peeks, from the pinned tab on screen (PLAN.md CMD-10): a script's click with no gesture, or a tab in a Space out of view, navigates as before. The peek loads the link as the page asked for it, with its initiator, referrer and gesture, so the site sees a cross-site link and not a typed address; and in the pinned tab's jar, so a pin in a Space with a session of its own peeks with that session (CMD-9). | `ShouldPeekTest.Decisions`; browser: `PeekTest.ASameSiteLinkOrAScriptsClickStaysInThePin`, `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` (`Sec-Fetch-Site: cross-site` and the Referer), `PeekTest.APinInASpaceWithItsOwnJarPeeksInIt` | built |
| P12 | The peek covers the window it came from but for a margin, 72 DIP at the sides and 48 at the top and bottom, so the page behind frames it. Its bounds are set once the window is made: the bounds a popup is made with were set aside on the Mac, and the window took the last window's size, 22 DIP down and right. | browser: `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` (the peek inside the window's bounds); live on the Mac: a 1256×784 peek at 72,81 over a 1400×880 window at 0,33 | built |
| P13 | One peek over a window: the next link from a pin replaces it. | browser: `PeekTest.ALinkLeavingThePinOpensAPeekOverTheWindow` (a second link, one peek) | built |
| P14 | Escape, ⌘W or a click on the window it came from closes the peek. When that click is on the very link the peek shows, the link does not open it again. The window taking the activation back in the peek's first 750 ms is not a click: Windows does that when the browser is not the foreground process. | browser: `PeekTest.AClickOnTheWindowClosesThePeek`; Escape and ⌘W are the little window's (little E2, `LittleWindowTest.EscapeClosesIt`); live on the Mac, 2026-10-25: a click on the window's margin, Escape and ⌘W each closed a peek, and the same link opened it again three seconds later | built |
| P15 | A redirect link (its `u=`, `q=` or `url=` naming an http(s) address, as mail and chat apps wrap their links) is judged by where it leads: a pinned mail app's wrapped link to another site peeks, and one back to its own site stays. The peek loads the link as written. | `ShouldPeekTest.Decisions` | built |
| P16 | A sign-in page stays in the pin: a host that starts with login., signin., auth., accounts., sso. and the like, or a path with a sign-in step (/login, /signin, /oauth, /sso, /authorize, /saml), so signing in finishes where it started. | `ShouldPeekTest.Decisions` | built |

## Not in this cut

- A link from a pinned tab that redirects to another site on the server (PLAN.md CMD-29) goes
  on in the pin: the throttle judges the link, not where the server sends it.
- Option-click (Alt-click) is still Chromium's download; it does not peek any link.
- The screenshot chords inside a peek (WIN-18): the peek is a window of its own, and its page
  is the one a capture of that window takes.
