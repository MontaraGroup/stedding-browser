# Feature: Clean links

Status: **Cl1–Cl14 written and coded** 2026-10-25 (BACKLOG S-89); the review's findings
of the same day are fixed (Cl3's empty `q=`, Cl12–Cl14, Cl4's browser test); not yet
built, run or seen live.
Owner docs: `docs/PRIVACY.md` (what Stedding does), `docs/features/copy-link.md` (L2, the
shared table), `docs/features/privacy.md` (Q15), `docs/features/settings.md` (T31, T32).
Patch: `patches/0089-feat-clean-links-on-every-page-opened-s-89.patch`; the review's fixes
are not yet folded in.

A page the user opens loads without the tracking parameters a copied link already loses
(`utm_*`, `fbclid`, `gclid` and the rest of copy-link L2), so the site's server never
receives them, and the address field, the page's own `location`, history and a later copy
all show the clean address. A link through a known redirect page that carries its target in
its own address (Google's `/url`, Facebook's and Messenger's `l.php`, Instagram's `l.`,
Reddit's `out.`, YouTube's `/redirect`) goes straight to the target; the redirect page is
never asked for. Nothing is fetched for this: both tables are compiled in.

How: `stedding::CleanLinksThrottle` (`chrome/browser/ui/stedding/clean_links_throttle.cc`),
a URL loader throttle made in `ChromeContentBrowserClient::CreateURLLoaderThrottles` for a
navigation's own loader. It decides on the UI thread, from the request and the profile's
preferences, and rewrites the request's address in `WillStartRequest`; the loader turns that
into an internal 307 before anything reaches the network. When the loader later restarts at
the address the request was made for (Cl12), a Stedding hook in Blink's
`ThrottlingURLLoader::RestartWithURLResetNow`, `URLLoaderThrottle::WillRestartWithURLReset`,
lets the throttle turn that restart to the clean address. The address rules are pure URL
logic in `clean_link.cc`, shared with copy-link.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Cl1 | A top-level GET to an http or https address that the user opens arrives without tracking parameters: a link clicked in the page, a link opened in a new tab or window (a middle click, ⌘-click, Ctrl-click, `window.open`), a typed address, a bookmark or pin, the command bar, an address handed over by another app, a tab an extension opens. The server is asked only for the clean address; the committed address, `location.search`, the address field and the tab's entry are clean. Every other parameter keeps its order and its encoding, and the fragment stays. | unit: `CleanLinksThrottleTest.StripsATopLevelGet` (a link, a typed address, a bookmark; a clean address makes no throttle), `CleanLinkTest.CleansTheAddressAPageOpensAt`; browser: `CleanLinksTest.ALinkClickArrivesClean` (the server's log, the committed address, `location.search`, the address field), `CleanLinksTest.ALinkOpenedInANewTabArrivesClean`, `CleanLinksTest.ATypedAddressArrivesClean` | planned · coded 2026-10-25, not yet built or run |
| Cl2 | One table with copy-link L2 (`kTrackingParameters` in `clean_link.cc`): what a copy drops is what an opened page never sends. No parameter was added for this feature, so copying is unchanged. | unit: `CleanLinkTest.TrackingParameters` | planned · coded 2026-10-25, not yet built or run |
| Cl3 | A known redirect page is skipped: `www.google.<tld>/url?q=` or `?url=` (`[www.]google.<tld>` only, on the standard port; `q=` is used when it holds an http or https address and `url=` otherwise, so Google's usual shared form, an empty `q=` with the target in `url=`, is skipped too), `l.facebook.com`, `lm.facebook.com` and `l.messenger.com` `/l.php?u=`, `l.instagram.com/?u=`, `out.reddit.com/...?url=`, `[www.\|m.]youtube.com/redirect?q=`. The target is decoded and must be an http or https address; a redirect page inside another is unwrapped too, up to three deep; the target is cleaned in the same step (the loader allows one change of address per throttle stage). A shortener whose target is not in its address (`t.co`, `bit.ly`) is not skipped: finding its target means asking it, which is the request the user made. | unit: `CleanLinkTest.UnwrapsKnownRedirectHops` (each page, encoded and nested targets, an empty `q=` with the target in `url=`, a `q=` that is no address beside `url=`, a `q=` that wins over `url=`), `CleanLinkTest.LeavesOtherAddressesAlone` (`t.co`, `bit.ly`, a missing, `javascript:`, `file:`, `data:` or broken target, empty `q=` and `url=`, `mail.google.com`, a non-standard port, `google.com/search`, look-alike paths and hosts), `CleanLinksThrottleTest.SkipsARedirectPage`; browser: `CleanLinksTest.ARedirectHopIsSkipped` (the target commits clean, for `q=` and for an empty `q=` with `url=`; nothing asked for `www.google.com`, which resolves to a port where nothing answers) | planned · coded 2026-10-25, not yet built or run |
| Cl4 | Never cleaned: a subresource, a worker, a frame inside a page, a fenced frame (only a navigation's own loader of the outermost page, `destination == kDocument`); a request with no navigation (a preload, a fetch of the browser's own); a POST; a form, GET forms too (`FORM_SUBMIT`); a reload, and a restored tab, which loads as a reload; back and forward; anything not http or https. A same-document navigation makes no request. | unit: `CleanLinksThrottleTest.OnlyTopLevelDocumentsAreCleaned`, `CleanLinksThrottleTest.LeavesPostsFormsReloadsAndHistoryAlone`; browser: `CleanLinksTest.SubresourcesAndFramesKeepTheirParameters` (an image, a fetch and a frame ask for their `utm_source`), `CleanLinksTest.AFormKeepsItsParameters` (GET and POST), `CleanLinksTest.BackForwardAndReloadAreNotCleaned` (two entries opened with the setting off, then back, reload and forward with it on, the back/forward cache off: each commits its tracked address and the clean ones are never asked for) | planned · coded 2026-10-25, not yet built or run |
| Cl5 | Only the first address of a navigation is cleaned; a server's redirect is followed as given (a page's own script or meta refresh is Cl13). So a page that needs a parameter and redirects to put it back gets it, with no loop, and a shortener's redirect that adds `utm_` delivers it (the server chose it, not the link). The throttle reads the navigation's redirect chain from the request, so a loader made again after a redirect (a service worker, HTTPS upgrades) leaves the later address alone too. | unit: `CleanLinksThrottleTest.AServerThatAsksForTheParameterBackGetsIt`; browser: `CleanLinksTest.TheServerThatAsksForItBackGetsIt` (a page that redirects to put `utm_source` back commits with it; `/server-redirect` to a `utm_` address commits that address) | planned · coded 2026-10-25, not yet built or run |
| Cl6 | History holds only the address the page opened at: the hop Stedding made (the tracked address to its clean one, a redirect page to its target, with SafeSearch's parameters when Cl14 added them) is left out of the redirect chain `HistoryTabHelper` hands to history, so no row or visit holds the tracked or redirect-page address and the address field's suggestions cannot offer it. | unit: `CleanLinkTest.RecognisesItsOwnHop`, `HistoryTabHelperTest.SteddingLeavesTheCleanLinkHopOut` (and the rest of `HistoryTabHelperTest`, Chromium's own, on the hunk's line); browser: `CleanLinksTest.HistoryHoldsOnlyTheCleanAddress`, `CleanLinksTest.ARestartForClientHintsStaysClean` (a restarted navigation) | planned · coded 2026-10-25, not yet built or run |
| Cl7 | "Remove tracking from links you open" writes `stedding.privacy.clean_links` (profile, **on by default**, as Stedding's privacy rows ship, ADR 0017), in the Privacy block right after Global Privacy Control (settings T31, privacy Q15); the command bar lists "Clean links you open: On/Off" with the other on/off rows (commandbar K17; a private window lists none, K15). Off, every page opens with the address as written, redirect pages included; copy-link's own setting is separate. The throttle reads it as each navigation starts, so a change applies to the next page in every window. | unit: `CleanLinksThrottleTest.TheSettingOffLeavesEveryLinkAlone`, `SteddingPrefsTest.EveryPreferenceRegistersWithItsDefault` (on); browser: `CleanLinksTest.TheSettingOffOpensLinksAsWritten`, `CleanLinksTest.TheCommandBarRowTurnsItOff`, `CleanLinksSettingsTest.TheSwitchIsBoundAndOn` | planned · coded 2026-10-25, not yet built or run |
| Cl8 | Kept sites: `stedding.privacy.clean_links_kept_sites`, a list of lower-cased hosts; an entry covers its subdomains. A page on a kept site opens with its parameters; a redirect page on a kept site is not skipped; a redirect page into a kept site is skipped, and the target keeps its parameters. | unit: `CleanLinkTest.CleansTheAddressAPageOpensAt`, `CleanLinksThrottleTest.AKeptSiteIsLeftAlone`, `CleanLinksThrottleTest.AKeptTargetIsUnwrappedButNotCleaned`, `CleanLinksThrottleTest.AKeptWrapperIsNotUnwrapped`; browser: `CleanLinksTest.AKeptSiteOpensAsWritten` | planned · coded 2026-10-25, not yet built or run |
| Cl9 | Settings lists the kept sites under the switch (settings T32), "Sites that keep their links:", with an add field that takes a host or a whole address and stores its lower-cased host (`stedding::KeptSiteFromTyped`, in `SteddingCleanLinksHandler`, so Settings stores what the throttle matches). An empty entry says nothing; a path alone or an address that is not http or https (a browser page) is refused with a line under the field and nothing is written. Each site has a remove button named "Remove <site>"; an empty list says "No sites". A site is listed once. | unit: `CleanLinkTest.AKeptSiteIsAHost`, `CleanLinksThrottleTest.TheKeptListHoldsEachSiteOnce`; browser: `CleanLinksSettingsTest.AddsAndRemovesAKeptSite` (typed `https://Shop.Example/x?y` is stored as `shop.example`; refused entries; Remove empties the list) | planned · coded 2026-10-25, not yet built or run |
| Cl10 | Private and Guest windows clean links too, with their profile's setting and list (an off-the-record profile reads its original profile's values). | browser: `CleanLinksTest.APrivateWindowCleansToo` | planned · coded 2026-10-25, not yet built or run |
| Cl11 | Nothing is fetched for this feature: no list is downloaded and no shortener is asked for its target. A skipped redirect page receives no request; Chromium's preconnect may still open a connection to its host ahead of a click while preloading is on (`docs/PRIVACY.md`, "Still to do"). | browser: `CleanLinksTest.ARedirectHopIsSkipped`; docs: `docs/PRIVACY.md` | planned · coded 2026-10-25, not yet built or run |
| Cl12 | A restart keeps the clean address. When a site's first answer asks for a client hint it was not sent (`Accept-CH` with `Critical-CH`), or a language or origin-trial restart is needed, the loader asks for the page again at the address the request was made for, without running the throttles' start again. The throttle turns that restart to the clean address (`WillRestartWithURLReset`), so the server never receives the tracked address, the page commits clean and history holds the clean address only. A restart at any other address is left alone. | unit: `CleanLinksThrottleTest.ARestartAsksForTheCleanAddressAgain` (the tracked address, another address, a skipped redirect page); browser: `CleanLinksTest.ARestartForClientHintsStaysClean` (a page that sends `Accept-CH` and `Critical-CH: Sec-CH-UA-Platform-Version` is asked for twice, the second time with the hint, both times clean; it commits clean; history holds no tracked address) | planned · coded 2026-10-25, not yet built or run |
| Cl13 | A page that sends itself to its own address with a tracking parameter, with no click behind it (a meta refresh, `location.replace`, a later script), gets it: a navigation the page started (it has an initiator), without a user gesture, to the same origin and path as the address the tab shows is followed as given, like a server's redirect (Cl5). Cleaning it would load the page again, which would ask again, with no end. A click, another path, another site, a new tab and an address the browser opened (typed, a bookmark) are cleaned as ever. | unit: `CleanLinksThrottleTest.APageThatAsksForItsOwnParameterGetsIt` (with and without the client-redirect mark; a click, another path, another site, a typed address, a new tab); browser: `CleanLinksTest.APageThatPutsItsParameterOnGetsIt` (a page whose script `location.replace`s to itself with `utm_source` commits with it after two loads and stops; a link clicked afterwards is cleaned) | planned · coded 2026-10-25, not yet built or run |
| Cl14 | With the ForceGoogleSafeSearch policy on (an enterprise policy, or a supervised profile), Google's own throttle adds SafeSearch's parameters to a Google search, home or SafeSearch settings page at the start, and a loader takes only one change of address there. So clean links leaves such a page to it: the page opens with SafeSearch on and keeps any tracking parameter it carried. A redirect page skipped into a Google search would never pass Google's throttle, so clean links adds SafeSearch's parameters to that target itself. Other pages are cleaned as ever. | unit: `CleanLinksThrottleTest.TheSafeSearchPolicyKeepsOneChangeOfAddress` (a search page and the home page under the policy make no throttle; without it a search page is cleaned; a redirect page into a search opens it with `safe=active&ssui=on`; a page that already has them is cleaned), `CleanLinkTest.AddsGoogleSafeSearchToGoogleSearchOnly`, `CleanLinkTest.RecognisesItsOwnHop`; browser: `CleanLinksTest.TheSafeSearchPolicyKeepsOneChangeOfAddress` (the policy's preference on, Google's pages served by an interceptor: the search page commits with SafeSearch's parameters, a redirect page into a search commits it clean with them, and the redirect page is never asked for) | planned · coded 2026-10-25, not yet built or run |

## Notes

- **Where the tracked address is still kept.** The tab's navigation entry keeps the
  address the navigation started with as its original request address, and session
  restore and tab restore write that to disk with the entry (Chromium's
  `SerializedNavigationEntry`). History (Cl6) does not hold it.
- **History judges a hop by its shape.** `IsCleanLinkHop` cannot tell Stedding's internal
  redirect from a server's own redirect of the same shape (a site that redirects its
  tracked address to the clean one, or a kept redirect page whose server sends the
  browser on to its target), so history leaves those out too, whether or not the setting
  is on. Nothing else in the chain is dropped.
- **The referrer on a skipped redirect page** follows the linking page's referrer policy,
  as the redirect page's own redirect would not. Under the default
  `strict-origin-when-cross-origin` the target sees the linking page's origin, usually the
  same site as the redirect page.
- **Prefetch and prerender.** A browser-side prefetch carries no navigation and is not
  cleaned, so a prefetched tracked address reaches its server before any click, and the
  cleaned navigation does not reuse it. A prerender of a redirect page is cancelled by its
  cross-site internal redirect; nothing breaks.
- **Decisions on the address as written.** The Space routing rules, little windows and
  Peek's new-tab path see the address before the throttle runs. Peek already judges a
  redirect link by its target (`PeekTargetOf`, peek P15).
- **Upstream tests.** The throttle is made only while `SteddingArcStyleWindow` is on, as
  every other Stedding hunk in the content browser client is. Chromium's own browser tests
  that commit an address with `utm_source` (the extension uninstall dialog's, the app info
  dialog's) are not in any sweep of this repository.
- **The restart hook.** Chromium's loader restarts a navigation at the address the
  request was made for and does not run the throttles' start again, so a throttle that
  changed the address at the start had no way to keep it. Stedding adds one virtual,
  `URLLoaderThrottle::WillRestartWithURLReset`, empty by default, which the loader calls
  for each throttle before the restart's internal redirect. Only the clean-links throttle
  overrides it. A restart that keeps the clean address is a redirect from the clean
  address to itself, as an ordinary Critical-CH restart is.
- **Which page "the page" is (Cl13).** The address the tab showed when the navigation's
  loader was made, read through the content browser client. A frame inside the page that
  sends the whole tab to the page's own address counts as the page.
- **Extensions.** A tab an extension opens is cleaned like any other; an extension's own
  redirect (`declarativeNetRequest`, `webRequest`) is a server-side redirect to the throttle
  and is followed as given (Cl5).

## Not in this cut

- **Cleaning a server's redirect.** A URL loader throttle's change to a redirect's address
  is sent to the network but not handed back to the navigation (the loader forwards the
  redirect it received), so the committed address, the address field and history would
  carry the tracked address while the server got the clean one. Followed as given instead
  (Cl5).
- **A guard that remembers what it cleaned.** A throttle is made again whenever the
  navigation's loader is (a service worker, HTTPS upgrades), so state in one throttle is
  lost. Cleaning only the first address of the chain (Cl5), and leaving a page's own
  navigation to its own address alone (Cl13), make the guard unnecessary.
- **A page that loops through another path.** A page that sends itself, with no click,
  to a different path with a tracking parameter, which sends it back again, is not caught
  by Cl13; it keeps loading until its site is added to the kept sites (Cl8).
- **Cleaning a Google search page under the SafeSearch policy.** It would need Google's
  throttle to add its parameters to the clean address, a change to Chromium's own
  throttle; the page keeps what it carried (Cl14).
- **A per-site command-bar row that reloads the page as it was opened.** Chromium has no
  reload that asks for the original request address any more; a new load replacing the
  entry is needed, and private windows list no preference rows (commandbar K15). Kept sites
  are added in Settings.
- **Peek's own unwrapping.** Peek already judges a redirect link by its target
  (`PeekTargetOf`, P15), with a wider rule than Cl3's; it is left as it is.
- **New parameters.** `gbraid`, `wbraid`, `ttclid` and `li_fat_id` would change copying too
  (copy-link L2); not added.

## Running the tests

```bash
tooling/dev test clean-links
```
