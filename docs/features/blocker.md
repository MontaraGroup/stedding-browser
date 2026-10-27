# Feature: Ad and tracker blocking

Status: phase 1 written 2026-10-25 and released in 0.3.0 beta 16: **Bk1–Bk5, Bk7–Bk13 built**,
their tests passing on the Mac (2026-10-26); **Bk6 partial** (its live check not yet run;
nothing has been seen live). **Bk0 partial**: the decision behind it,
`docs/decisions/0030-ad-and-tracker-blocking.md`, is **Proposed** and waits for the owner; the
feature stays off by default until then and after. **Bk20–Bk23 planned**. BACKLOG S-88.
Owner docs: `docs/PRIVACY.md` (the connection it adds), `docs/ROADMAP.md` M10. Patch: 0098.

One switch blocks the ads and trackers that the EasyList and EasyPrivacy filter lists name: their
scripts, images, frames, requests and pings do not load. It is off until the user turns it on in
Settings > Stedding > Privacy. Only then does Stedding download the two lists from their own
homepage, `easylist.to`, each again when the list says it expires, and convert them on this
computer into the rules of Chromium's own subresource filter, which blocks in every renderer from
one shared index. Nothing from the lists is built into the browser. A shield at the address row's
right end, a command bar row and a list in Settings turn blocking off for one site (subdomains
included) and back on. Blocking keeps no record of the sites visited: the only thing stored for a
site is an exception the user made.

This first slice blocks requests. Hiding the empty boxes ads leave (element hiding), a page shown
for a blocked top-level load, optional lists and a count of what was blocked are later slices
(Bk20 to Bk23).

Code: `chrome/browser/ui/stedding/blocker/` (the rules, the lists, the converter, the throttle),
`chrome/browser/ui/views/toolbar/stedding_blocker_button.{h,cc}`,
`chrome/browser/ui/webui/settings/stedding_blocker_handler.{h,cc}`; tests in
`chrome/browser/ui/stedding/blocker/*_unittest.cc` and `chrome/test/stedding/blocker_browsertest.cc`,
with test lists in `chrome/test/data/stedding/blocker/` written for them.

On Windows every label below is the same; the command bar rows are in title case on both, as the
bar's other rows.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Bk0 | `docs/decisions/0030-ad-and-tracker-blocking.md` records the three options (a separate Rust engine, Chromium's subresource filter fed with lists fetched at run time, extensions), the choice of the subresource filter, the lists' licences, the connection added to `docs/PRIVACY.md` and the one removed (Google's ruleset component), and the changes outside Stedding's files under `docs/ARCHITECTURE.md`'s rule for engine changes. | `docs/decisions/0030-ad-and-tracker-blocking.md` | partial · written · Proposed, awaiting the owner |
| Bk1 | One switch, "Block ads and trackers" (`stedding.blocker.enabled`, local state, **off**). While it is on, every http or https top-level page is filtered at the subresource filter's "enabled" level, in normal, private, little, Peek and app windows alike: listed scripts, images, stylesheets, fetches and XHRs, WebSockets, pings and child frames do not load. Browser pages, files and `about:` pages never are. While it is off, Chromium's own behaviour is kept: an ad-tagging dry run that blocks nothing. The switch on with both lists off is the same as off. `stedding::BlockerAppliesTo` decides; `stedding::BlockerActivationThrottle::WillProcessResponse` hands the decision to the filter through `SubresourceFilterObserverManager`. The blocker does not depend on the window style flag (`kArcStyleWindow`). | unit: `BlockerRulesTest.TheSwitchTheSchemeAndTheSiteDecideEachPage`; browser: `BlockerTest.AFreshProfileFetchesNothing`, `BlockerTest.AListedScriptImageAndFrameAreBlocked` (a page with a listed and an unlisted script, image, frame and fetch, and a listed tracker: only the unlisted ones load), `BlockerTest.TheSwitchOffLoadsEverything` | built |
| Bk2 | Two lists, each with its own switch: EasyList for ads (`stedding.blocker.list.easylist`, on) and EasyPrivacy for trackers (`stedding.blocker.list.easyprivacy`, on), fetched from `https://easylist.to/easylist/` and never built into the browser. They are kept in `<user data>/Stedding Blocker/`. A list is fetched again when its own `! Expires:` line says, clamped to between one and fourteen days (four when the line is missing), at launch (ten seconds after it) and then on a timer that survives sleep. The request is conditional (If-None-Match, If-Modified-Since); a 304 keeps the stored list. A failed fetch is tried again after an hour, then twice as long each time, up to the list's expiry. Nothing is fetched while the switch is off, or for a list that is off; turning the switch off drops a fetch under way. | unit: `BlockerConvertTest.TheExpiresLineSetsTheExpiry`, `BlockerListsTest.TheExpiresLineSetsTheNextFetch`, `BlockerListsTest.ANotModifiedAnswerKeepsTheList`, `BlockerListsTest.AFailedFetchRetriesWithBackoff`, `BlockerListsTest.NothingIsFetchedWhileTheSwitchIsOff` | built |
| Bk3 | The lists are converted on a background sequence (best-effort priority, user-visible after "Update lists now") by Chromium's EasyList parser into one unindexed ruleset of URL rules; element-hiding rules are read and dropped in this slice; lines the parser cannot read (rules with options it does not know, such as `$redirect`, `$removeparam`, `$csp`) are counted, not logged. The ruleset goes to Chromium's `RulesetService` with a content version made from the lists' SHA-256 and a salt, and a LICENSE file naming each list, its homepage and its licence. A download that is not a filter list (no `[Adblock` header) or that gives fewer than 1000 URL rules is refused, and the previous ruleset stays. A ruleset made at an earlier run that the service never indexed (a quit or a crash while indexing, which bars that version) is made again at launch under a new salt. | unit: `BlockerConvertTest.UrlRulesAreKeptAndCosmeticRulesDropped`, `BlockerConvertTest.UnreadableLinesAreCounted`, `BlockerConvertTest.ABrokenDownloadKeepsThePreviousRuleset`, `BlockerConvertTest.TheLicenceFileNamesEveryList`, `BlockerListsTest.ARulesetNeverIndexedIsMadeAgainAtLaunch` | built |
| Bk4 | Google's "Subresource Filter Rules" component is not registered with the component updater, so the ruleset is Stedding's alone and one fewer component is checked at `update.googleapis.com`. | browser: `BlockerComponentsTest.GooglesRulesetComponentIsNotRegistered` (the components registered, with the update service pointed at the test's server; Google's id is not among them) | built |
| Bk5 | The switch for a site: turning blocking off on a site writes Chromium's `ADS` content setting ALLOW for the site's registrable domain on any scheme and port (`[*.]example.com`, the pattern dark pages uses; an IP address as it is), which covers its subdomains; that site's pages load unfiltered and every other site stays filtered. Only an entry for a site counts: the content setting's default, which Chromium's "Intrusive ads" page and policy can change, is not read. The change goes to the profile of the window it was made in; from a private window it stays in that session's memory, and turning blocking back on there over an exception the normal profile has writes the private session's own entry. The tab reloads so the change shows. Turning blocking back on removes the exception. | unit: `BlockerRulesTest.TheSwitchTheSchemeAndTheSiteDecideEachPage`, `BlockerRulesTest.APrivateSessionsChoiceStaysInIt`; browser: `BlockerTest.TheSiteSwitchTurnsBlockingOffForThatSiteOnly`, `BlockerTest.APrivateWindowsSiteSwitchIsForgotten` | built |
| Bk6 | The address row has a shield at its right end, before the dark pages moon, in normal and private windows. Filled, with the toolbar's active highlight, while blocking applies to the active tab's site; an outline while it is off there. A click flips the site's switch (Bk5). Its tooltip and its accessible name name the site: "Blocking ads and trackers on example.com" or "Blocking is off on example.com"; before the first lists have arrived, "Blocking starts once the lists have downloaded". To assistive technology it is a toggle button, checked while blocking applies. It is hidden on a page that is not http or https, while the switch is off, and when "Show the blocker button" (`stedding.page.blocker_button`, profile, on) is off. Little windows, Peek and app windows have no such row; their sites are turned off from Settings (Bk9) or from a normal window's shield, which the same profile shares. Page info carries no blocker row. | browser: `BlockerButtonTest.TheButtonFollowsTheSiteAndFlipsIt`; live: `bk_button` (light and dark, Mac and Windows, window-only capture) | partial · written · test passes on the Mac (2026-10-26); live check not yet run |
| Bk7 | Blocking keeps no record of the sites visited. Where Stedding decides a page's activation, Chromium's "ads blocked" address-bar icon is not shown (from either of its call sites, so not for a page restored from the back-forward cache or an activated prerender either), no ads intervention is triggered, and no `ADS_DATA` site metadata is written. The only thing stored for a site is an exception the user made. Chromium's heavy-ad intervention keeps its own host list as before; Delete browsing data clears it. | browser: `BlockerTest.BlockingWritesNothingPerSite` (three sites, each with blocked requests, and one of them again from the back-forward cache: no `ADS_DATA` entry and no blocked-ads state on the page) | built |
| Bk8 | Sign-in steps are let through: a top-level page whose address has a path segment `oauth`, `oauth2`, `authorize` or `openid-connect`, or a query with both `client_id` and `redirect_uri`, is not filtered. | unit: `BlockerRulesTest.SignInFlowsAreLetThrough` | built |
| Bk9 | Settings > Stedding > Privacy has the blocking rows: the switch, whose line says that it blocks requests and that ads a site serves itself, such as promoted posts, still show until element hiding (Bk21) is built (GitHub issue 46: Reddit's promoted posts, on EasyList as element-hiding rules); a row for each list, with its own switch, what it blocks, its homepage and its licence; "Last updated <time>: N rules, M lines skipped" (or "No lists downloaded yet") with **Update lists now**; the sites where blocking is off, each with Remove, and a field to add one (a host, a web address or `*.host`; anything else is refused with a line under the field); and "Show the blocker button". `SteddingBlockerHandler` (`steddingGetBlocker`, `steddingUpdateBlockerLists`, `steddingAddBlockerException`, `steddingRemoveBlockerException`) backs the rows no preference binds, and the page follows a change made from the shield or the command bar at once. | unit: `BlockerRulesTest.ExceptionsAreListedAddedAndRemoved`; browser: `SettingsBlockerTest.TheRowsShowTheListsAndUpdateNow` (the switch's line too); live: `w3_privacy_blocker` | built |
| Bk10 | While blocking is on, the command bar has "Turn Off Blocking on This Site" or "Turn On Blocking on This Site" (the title follows the site's state; in private windows too; none while a peek is open or on a page that is not a web page) and "Update Ad and Tracker Lists". | browser: `BlockerCommandBarTest.TheBlockerRowsActOnTheSite` | built |
| Bk11 | After a launch with a ruleset indexed at the run before, the first page is filtered: Stedding's page activation is in place before the first window loads a page, beside Chromium's ruleset service, which opens the last indexed ruleset at once. On a fresh install, before any list has arrived, pages load unfiltered and the shield says the lists are downloading. Whether a first page can ever beat the ruleset's publication is TBD until the test has run on both platforms. | browser: `BlockerLaunchTest.PRE_TheFirstPageAfterALaunchIsFiltered`, `BlockerLaunchTest.TheFirstPageAfterALaunchIsFiltered` | built |
| Bk12 | A list fetch carries nothing about the user: no cookies (credentials omitted), no cache, no query string, Chromium's own user agent. Its traffic annotation is `stedding_blocker_lists`. A fresh profile fetches nothing, since blocking starts off. | unit: `BlockerListsTest.NothingIsFetchedWhileTheSwitchIsOff`; browser: `BlockerTest.TheListFetchCarriesNothingAboutTheUser` (the test's list server first sets a cookie, then records the list requests: neither carries it), `BlockerTest.AFreshProfileFetchesNothing` | built |
| Bk13 | Delete browsing data with "Site settings" ticked clears the sites where blocking is off. | browser: `BlockerTest.DeletingSiteSettingsClearsTheExceptions` | built |
| Bk20 | (planned, later slice) A top-level load of a page on a list shows a local page: "This page is on a blocking list", with "Go back" and "Continue to <host>". The page cannot press its buttons, and "Continue" holds until the tab leaves that host. | TBD when the slice starts | planned |
| Bk21 | (planned) Element hiding, for each domain and generic, once Blink applies the subresource filter's style rules upstream; otherwise through a Stedding renderer observer that inserts a user-level stylesheet. Reddit's promoted posts (`reddit.com##shreddit-ad-post`) are one of its acceptance cases (GitHub issue 46). | TBD | planned |
| Bk22 | (planned) Optional lists by category (cookie notices, annoyances), each with its own switch and fetched on its own expiry. Most of their rules hide elements, so they wait for Bk21. | TBD | planned |
| Bk23 | (planned) A count of blocked requests on the shield, from the renderer's document load statistics. | TBD | planned |

## Not covered, and known limits

- Rules with options Chromium's parser does not know are skipped. A skipped `$badfilter` could
  leave active a rule the list meant to cancel. The share of EasyList and EasyPrivacy that is
  kept, the indexed size, the time to index on each platform and the cost per page are TBD until
  measured on the real lists.
- A new ruleset reaches the pages loaded after it is published; open pages, pinned tabs and apps
  keep the one they started with until they reload. Nothing prompts a reload.
- Whether requests from dedicated and service workers are filtered is not known yet (TBD; the
  renderer-side filter is attached to documents).
- Chromium's own "Intrusive ads" page in site settings lists the same exceptions under its own
  name; whether to relabel it is the owner's call (ADR 0030).

## Acceptance (live)

- `bk_button`: in a normal and a private window, light and dark, on the Mac and on Windows, with
  blocking on: open a news site, see the filled shield and its tooltip, click it, see the page
  reload with its ads and the outline shield; open another site and see it filtered. Window-only
  captures (`tooling/capture-windows`).
- `w3_privacy_blocker`: Settings > Stedding > Privacy: turn blocking on, see "No lists downloaded
  yet" turn into "Last updated ..." with a rule count, press Update lists now, add and remove a
  site, turn a list off and see the count fall.
