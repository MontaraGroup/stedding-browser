# 0030 — Ad and tracker blocking on Chromium's subresource filter, with lists fetched at run time

Status: Proposed (awaiting the owner)
Date: 2026-10-25

## Context

`BACKLOG.md` S-88 asks for ad and tracker blocking built in, with a switch for each site.
ADR 0021 says this one gets an ADR before any code ships, with the filter lists fetched at run
time and never built in. ADR 0017 makes privacy defaults preference defaults, and
`docs/PRIVACY.md` principle 2 says every connection the browser makes is listed there.

The lists people use are EasyList (ads) and EasyPrivacy (trackers), from `easylist.to`, under
GPL-3.0-or-later or CC BY-SA 3.0. Other community lists mostly use syntax beyond EasyList's.

What Chromium 156 already has, read in the checkout:

- `components/subresource_filter` (BSD-3-Clause), in every Stedding binary. Its ruleset is a
  memory-mapped index shared by every renderer. A top-level page's subresources are filtered in
  the renderer; a child frame's navigation is filtered in the browser
  (`SafeBrowsingChildNavigationThrottle`). `RulesetService::IndexAndStoreAndPublishRulesetIfNeeded`
  indexes an unindexed ruleset and publishes it; Google's "Subresource Filter Rules" component is
  the only caller today, and Stedding downloads it from Google like any other component.
- The page's activation is decided by `SafeBrowsingPageActivationThrottle`. It is not dead in
  Stedding: the database manager exists in desktop builds, and with ad tagging on it delivers
  Chromium's "dry run on every site" preset, which tags ad frames and blocks nothing. It also
  carries DevTools' forced activation and the ads intervention.
- A switch for each site exists: the content setting `ADS` (default Block, top-origin scope,
  inherited by private windows). ALLOW for a site turns the filter off there.
- Chromium's own path records the sites it filters. `ProfileInteractionManager` writes `ADS_DATA`
  metadata for an activated site, and again when it shows the "ads blocked" icon, kept for seven
  days; the ads intervention writes it too. That is a list of sites visited if every site is
  filtered.
- An EasyList parser production code may use: `components/subresource_filter/tools/rule_parser`.
  It skips rules with options it does not know (`$redirect`, `$removeparam`, `$csp`,
  `$badfilter`, extended syntax other lists use). Element-hiding rules are parsed and indexed upstream but
  Blink does not apply them yet in 156.

## Options

**A. A Rust filter engine under MPL-2.0 as a separate component.** The fullest matching: element
hiding, scriptlets, `$redirect`, `$removeparam`. It means vendoring a crate and its dependencies,
a C++ bridge, and checking every subresource request in the browser or network process, which is
a URL loader proxy or a hook in the network stack: the engine work `docs/ARCHITECTURE.md` says
to avoid, a cost on every request, and an MPL file-level obligation inside a BSD core.

**B. Chromium's subresource filter, fed with EasyList and EasyPrivacy converted in the browser.**
All of it is BSD code already in the binary. Matching runs in the renderer against the shared
index; child frames are blocked in the browser; the switch for each site already exists. The
changes outside Stedding's own files are small (below). Limits: one ruleset for the whole browser;
no scriptlets, `$redirect` or `$removeparam`; rules with unknown options are skipped; no element
hiding until Blink applies the filter's style rules, or until Stedding adds a renderer observer.

**C. Leave it to extensions.** No code, but it is not built in, an extension brings Web Store
traffic, and Manifest V3 content blockers are weaker than the old ones.

## Decision

B, as follows.

1. **Off by default.** One switch, `stedding.blocker.enabled`, in local state, off. Nothing is
   fetched, converted or filtered until the user turns it on in Settings > Stedding > Privacy.
   No filter list, and nothing derived from one, is in the binary or in this repository; the
   test lists are written for the tests.
2. **Lists fetched at run time, from their own homepage.** While blocking is on, EasyList and
   EasyPrivacy (each with its own switch, both on) are fetched from `https://easylist.to/easylist/`,
   each when its own `! Expires:` line says (clamped to one to fourteen days, four when missing),
   with a conditional request (If-None-Match, If-Modified-Since): no cookies, no cache, no query
   string, Chromium's own user agent. A failed fetch is retried after an hour, then twice as
   long each time, up to the list's expiry. The lists are kept in `<user data>/Stedding Blocker`,
   with a LICENSE file naming each list, its homepage and its licence beside the converted rules.
3. **Converted in the browser.** On a background sequence, Chromium's EasyList parser turns the
   lists into one unindexed ruleset of URL rules; element-hiding rules are dropped in this slice;
   lines the parser cannot read are counted, not logged. A download that is not a filter list (no
   `[Adblock` header, or fewer than 1000 URL rules) is refused and the previous ruleset kept. The
   ruleset goes to Chromium's own `RulesetService`, with a content version made from the lists'
   SHA-256 and a salt; a version the service never indexed (a quit or a crash during indexing,
   which leaves that version barred by the service's sentinel) is made again under a new salt.
4. **Google's ruleset component is not registered.** The ruleset is Stedding's alone, and one
   fewer component is checked at `update.googleapis.com`. A ruleset Google's component installed
   in an earlier version stays published until Stedding's first one is indexed: while blocking is
   off only Chromium's ad-tagging dry run reads it, which blocks nothing; in the minutes between
   turning blocking on and the first lists arriving, pages are filtered by it.
5. **Stedding decides each page, while blocking is on.** The subresource filter's throttle manager
   gains an embedder hook: while Stedding has set a page-activation factory, Stedding's throttle
   is added in place of the Safe Browsing one, before the activation state computing throttle, and
   hands its decision over through `SubresourceFilterObserverManager`, as the Safe Browsing
   throttle does: enabled where blocking applies (the switch, an http or https page, not a sign-in
   step, no exception for the site) or where DevTools forced it; otherwise the ad-tagging dry run
   that Chromium runs today. While blocking is off the factory is cleared and Chromium's own path
   runs unchanged.
6. **Nothing is written for each site visited.** While the factory is set the throttle manager
   shows no "ads blocked" icon (from both its call sites, so a page restored from the back-forward
   cache or an activated prerender shows none either) and triggers no ads intervention; Stedding's
   throttle never calls `ProfileInteractionManager`, so no `ADS_DATA` is written. The only thing
   stored for a site is an exception the user made. Chromium's heavy-ad intervention keeps its own
   list of hosts, as it does today; it is cleared with browsing data.
7. **The switch for each site is the `ADS` content setting, user entries only.** ALLOW for the
   site's registrable domain (the pattern dark pages uses) turns blocking off there, subdomains
   included. The content setting's default, which Chromium's "Intrusive ads" page and policy can
   change, is not read, so it cannot turn blocking off everywhere while the switch says it is on.
   A private window writes to its own session and nowhere else. The switch for a site is a shield
   in the address row, a command bar row and a list in Settings; it is kept out of page info.

The changes outside Stedding's own files, under `docs/ARCHITECTURE.md`'s rule for engine changes
(`components/` is not `net/` or `services/`, so ADR 0027's list does not apply):

- `components/subresource_filter/content/browser/content_subresource_filter_throttle_manager.{h,cc}`:
  the factory and its three guards (about 40 lines).
- `chrome/browser/component_updater/registration.cc`: one call removed.
- `chrome/browser/chrome_browser_main.cc`: Stedding's start, beside the ruleset service's.
- The usual Stedding wiring: the toolbar row, the command bar, Settings, preferences, build files.

## Consequences

- `docs/PRIVACY.md` gains one connection, `easylist.to`, made only after the user turns blocking
  on, and loses Google's ruleset component download.
- Replacing the Safe Browsing activation while blocking is on drops Chromium's phishing and
  "abusive site" activation lists and the ads intervention for those pages. Both are inert in
  Stedding today (Safe Browsing has no key, `docs/PRIVACY.md`); when S-75 makes Safe Browsing
  work, Stedding's decision is chained after the Safe Browsing throttle instead of replacing it.
- Coverage is less than a full engine's: rules with unknown options are skipped, and a skipped
  `$badfilter` could leave active a rule the list meant to cancel. The parse rate, the indexed
  size, the indexing time and the cost per page are TBD until measured on the real lists.
- A new ruleset reaches pages loaded after it is published; open pages keep the old one until
  they reload.
- Element hiding, a page shown for a blocked top-level load, optional lists and a count of
  blocked requests are later slices (`docs/features/blocker.md` Bk20 to Bk23).
- A pin move re-applies the throttle manager's hunk; a conflict there is resolved by reading the
  upstream change first.
- The owner decides: whether fetching from `easylist.to` with the attribution in the LICENSE
  file and in Settings meets the lists' licences; whether Chromium's "Intrusive ads" page is
  relabelled, now that it lists Stedding's exceptions; and this ADR as a whole, before the
  feature is turned on in a release.
