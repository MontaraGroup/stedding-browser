# Privacy principles and defaults

Privacy in Stedding is a set of shipped defaults, not a mode you enable. This
document states the principles, then what the browser actually does: what ships by
default, what is available by choice, and what is not done yet. How the Google
services in the Chromium base are removed or replaced is in ARCHITECTURE.md
("De-Googling stance"); this document is the product contract that work must satisfy.

Anything the shipping browser does on the network that is not listed here is a
bug. Report it through SECURITY.md.

## Principles

1. **No telemetry, ever, by default.** The browser sends no usage metrics, no
   analytics, no A/B experiment data, no unique identifiers. There is no
   "anonymized" or "aggregated" exception.
2. **Every network connection is enumerated.** A user must be able to read this
   document and know every host their browser talks to and why. The aim is a short
   list: update checks (browser, components, Safe Browsing lists, installed
   extensions) and the user's own browsing. The connections table below is the
   enumeration; the recorded run after it shows where the builds still miss the aim.
3. **Defaults are the product.** A privacy feature that must be discovered and
   enabled protects almost nobody. Protections ship on; conveniences that cost
   privacy ship off.
4. **Honesty over purity.** Where a real trade-off exists (Safe Browsing, extension
   stores), we document the trade-off and pick a defensible default rather than
   pretending the trade-off away.
5. **Verifiable.** The entire browser, UI included, is open source (BSD-3-Clause).
   Claims in this document can be checked against the code and on the wire.

## Network connections the browser makes

### Shipped by default

| Connection | To | Contains | Why |
|---|---|---|---|
| Browser update check (Mac) | GitHub: the update feed on `raw.githubusercontent.com`, once a day, and a new version's image from `github.com` when there is one. Described under "The update check" below; off in Settings › Stedding › Updates. Windows has no updater yet (`BACKLOG.md` S-74). | A plain GET with Sparkle's user agent (the browser's name and version). Nothing about the machine. | Security updates are non-negotiable for a Chromium fork. |
| Thank-you pages | stedding.dev, twice in an installation's life and then once per update: `/thanks/` when the welcome flow ends, `/thanks/updated/` on the first launch of a later version. The second is off in Settings › Stedding › Updates. | A plain page request. The version is in the URL's fragment, which the browser never sends. The pages load nothing from another host and set no cookie. | The owner's thanks, and the project's sponsorship (ADR 0022). |
| Security component updates | Google's component update service, as in stock Chromium; no patch in the series changes it yet. | Component name and version. | Chromium ships security-critical data as components (for example certificate revocation sets). Which ones to mirror, proxy or remove is decided before 1.0. |
| Safe Browsing list updates | Google (`safebrowsing.googleapis.com`); refused in these builds, see the Safe Browsing section | Hashed URL prefixes, not URLs. | Phishing and malware protection. |
| Network time | Google (`clients2.google.com`) | A request for the current time. | Chromium judges certificate dates with it. Turning it off is not done yet (below). |
| The user's own browsing | Sites the user visits | Whatever the user does. | This is a web browser. Includes the DNS, TLS (OCSP/CT) and favicon traffic that browsing implies. |
| Extension install and update | Chrome Web Store (Google) | Standard store traffic. | Only once the user installs an extension. See the extension note below. |

### Never

- No telemetry or metrics endpoints.
- No first-run "ping" with an installation or user ID.
- No field-trial or experiment ("Finch") downloads.
- No new-tab-page network requests: the new tab page is fully local. No sponsored
  tiles, no news feed, no background promotions — not opt-out, but absent.
- No search or address-bar keystrokes sent anywhere until the user submits (search
  suggestions are off by default; see below).
- No Autofill server queries or votes: Chromium asks `content-autofill.googleapis.com`
  about every form a page shows and reports what was submitted; Stedding turns that off
  (since 2026-10-15, `features/privacy.md` Q14). Autofill fills from its own heuristics.

### What a fresh profile contacted: a recorded run

2026-09-28, the release build of 155.0.8059.12 (patch 0057), a new profile in a
temporary folder, started headless with nothing opened, about four and a half
minutes, from Chromium's own network log (`BACKLOG.md` S-50; the ten-minute run with a
window followed on 2026-10-12, below):

| Host | What | Listed above? |
|---|---|---|
| `update.googleapis.com`, `edgedl.me.gvt1.com` | Component updates and their downloads: the first check at about one minute, then roughly every five hours, the certificate CRLSet among them | Yes |
| `safebrowsing.googleapis.com` | One Safe Browsing list update, refused (HTTP 400: no API key) | Yes |
| `clients2.google.com/time/1/current` | Chromium's network time | Yes |
| `android.clients.google.com/checkin`, `/c2dm/register3` | Google's push service: a device check-in and registrations | **No**; stopped since beta 15 (`BACKLOG.md` S-54) |
| `accounts.google.com/ListAccounts` | The Google account check, with no account signed in | **No**; stopped since beta 15 (`BACKLOG.md` S-67) |

The last two broke principle 2; the series stopped both on 2026-10-12, and beta 15 was the
first release without them (`docs/features/privacy.md` Q11, Q12).

2026-10-12, the release build of the series with that fix, a new profile in a temporary
folder, nothing opened, from the same log: five minutes headless and ten with a window,
each run beside the same run of beta 10 as a control:

| Host | The fixed series | Beta 10 |
|---|---|---|
| `update.googleapis.com`, `edgedl.me.gvt1.com` | Component updates | The same |
| `safebrowsing.googleapis.com` | The list update, refused | The same |
| `clients2.google.com/time/1/current` | Network time | The same |
| `accounts.google.com/ListAccounts` | **Not asked** | Asked, in both runs |
| `android.clients.google.com` | Not contacted | Not contacted either |

The account check is gone. The push service was not reached in these runs by either
build, so they cannot show its part; that rests on the browser test that failed before the
fix (`QuietStartTest.AFreshProfileCallsNoGoogleService`: the policy invalidations no longer ask
it for a token at start). The runs used a stand-in keychain, so as not to touch the
login keychain; whether that keeps the push service from starting is not known. The new tab page is local
and makes no request of its own (`features/new-tab.md` N1). Nothing here is telemetry, but "no telemetry" and "contacts nothing" are
different claims, and only the first is true today, which is why `docs/QUALITY.md`
makes an unexplained endpoint a release blocker.

## Concrete stances

### Crash reports — none leave the machine

Stedding uploads no crash reports. Chromium's upload to Google is absent from
unbranded builds, and Stedding runs no crash service of its own. A crash dump may
stay on your disk, in the `Crashpad` folder of Stedding's data folder, and goes
nowhere. An opt-in
reporter is not on the roadmap; adding one would need its own ADR and an entry here
first.

### Default search engine — chosen by the user

First run shows a search engine chooser. The list order is randomized, the chooser
preselects nothing, and no engine has paid for placement — no search deal exists, and
if that ever changes it will be disclosed in this document and in release notes
before shipping. Until the user chooses, the default is DuckDuckGo, in every region:
a query typed before a choice -- the welcome's search step skipped, say -- goes to
DuckDuckGo and nowhere else. A skipped step also brings Chromium's own "Choose your
search engine" dialog over the first page (`BACKLOG.md` S-134). Search suggestions
(sending keystrokes to the chosen engine) are off by default and can be turned on in
Settings → Stedding → Privacy.

### Safe Browsing — does not work in these builds

The trade-off: Safe Browsing protects against phishing and malware, but the
standard implementation checks URLs against Google-operated lists. The standard
(v4, "Update API") protocol downloads hashed prefix lists locally and only contacts
the server for hash-prefix matches — Google does not receive your browsing
history, but does receive occasional partial-hash queries and your IP.

Where it stands (2026-09-28): the setting is on, but Stedding's builds carry no
Google API key, and Chromium's list updates need one. Confirmed on a running build
(docs/history/plan-2026-09-26.md WEB-5; the recorded run above): the first list update, about four minutes
after start, went to `safebrowsing.googleapis.com` with no key and Google answered
HTTP 400. So the local lists stay empty and no listed site gets a warning page --
while the requests themselves still reach Google, with your IP address. Only the
local warnings for dangerous file types remain. Do not count on Safe Browsing to
protect you in Stedding. Settings → Privacy and security → Security says so too, above
the modes it offers (since 2026-10-12; `docs/features/privacy.md` Q13). The route the owner chose (2026-10-01, `BACKLOG.md` S-75) is
the lists through stedding.dev, with the key on the server and no Google API in the
browser; it is set aside for now, on the owner's word.

Our stance, once it is settled:

- **By default:** standard, hash-prefix Safe Browsing that is proven to work,
  because shipping a browser to non-hypothetical users with phishing protection off
  is not a defensible default.
- **Available by choice:** turning it off entirely, one switch, clearly explained.
- **Never by default:** "Enhanced" Safe Browsing modes that send full URLs or page
  content in real time. Stedding never turns it on, but Chromium's Security page
  still offers it as a choice; taking the option out is open (docs/history/plan-2026-09-26.md WEB-5).

### Data earlier betas left on disk

Betas up to 8 wrote a snapshot of the sidebar every hour into a `Sidebar Backups`
folder inside the profile: every tab's address and title, in plain JSON. Later
builds no longer write it, and Clear browsing data does not remove it. Delete the
folder by hand if you do not want to keep it, or import one of its files with
**Import sidebar…** in Settings → Stedding → Spaces.

### A Space's own cookies and Delete browsing data

A Space with an independent session keeps its cookies, cache and site data in a
jar of its own on this disk (`features/sessions.md`). **Delete browsing data**,
`chrome.browsingData` and deleting one site's data reach every Space's jar, with the
same time range and the same sites (sessions S24), from beta 9 on (on the Mac, beta 10).
On beta 8 or earlier they did not: use **Clear Independent Session** on the Space, or
delete the Space.

**Clear Site Cookies and Reload** (⌥⇧⌘R, Ctrl+Alt+Shift+R, or the command bar; since beta
14) deletes the cookies of the page's site from the jar that tab uses and no other, then
reloads it; site storage, cache, history and passwords stay (`features/commandbar.md`
K24).

### Google account sync — not available

Google shut off access to its private Sync APIs for third-party Chromium builds in
2021; forks cannot offer Chrome sync legitimately, and we will not pretend
otherwise. Signing into Google *websites* works normally — this only concerns
browser-level account integration, which the de-Googling work removes
(ARCHITECTURE.md). Sync services are out of scope on the way to 1.0 (ROADMAP.md).
Today a Space travels between machines as a file (**Export Space…** and **Import
sidebar…**), and profile import covers the rest.

### WebRTC IP handling

Chromium's default mDNS obfuscation of local IP addresses is kept, so sites using
WebRTC see mDNS hostnames rather than your LAN IPs, and calls still work. There is no
setting for the stricter policies VPN users want ("public interface only", "disable
non-proxied UDP"), which keep WebRTC from bypassing a VPN at the cost of breaking some
calls; an extension that sets Chromium's WebRTC IP-handling policy can apply them.

### Global Privacy Control — on by default

Stedding sends the GPC signal (`Sec-GPC` header and
`navigator.globalPrivacyControl`) by default. It is a legally meaningful opt-out
in several jurisdictions and costs users nothing. Settings → Stedding → Privacy →
**Send Global Privacy Control** turns it off (`features/privacy.md` Q4).

### Extensions — compatibility with a caveat

Full Chrome extension compatibility is a core feature, and it has privacy
consequences we will not hide:

- Installing and updating extensions talks to the Chrome Web Store, a Google
  service. That traffic exists only when you use extensions.
- Extensions are third-party code running with the permissions you grant. An
  extension can read and transmit anything its permissions allow, and Stedding
  does not audit, vet, or sandbox extensions beyond what Chromium provides.
  Review permissions before installing; prefer open-source extensions.
- Whether extension update traffic can be proxied through Stedding infrastructure
  is an open question, TBD.

## Summary: default vs. choice

| Behavior | Shipped by default | Available by choice |
|---|---|---|
| Telemetry / metrics | None (does not exist) | — |
| Crash reports | None uploaded | — |
| Update checks | None yet: no build checks for updates (`BACKLOG.md` S-74); once built, on, with no identifiers, and listed here | — |
| Search engine | User chooses at first run; DuckDuckGo until then | Change any time |
| Cookies per Space | Off: every Space shares the profile's jar | Independent session on a Space keeps its own cookies, cache and site data on this disk; Clear Independent Session empties it; deleting the Space deletes it; Delete browsing data reaches it from beta 9 on (Mac: beta 10) (`features/sessions.md`) |
| Search suggestions | Off | Opt in |
| Third-party cookies | Blocked | Allow per site |
| HTTPS-First | On | Turn off |
| Quiet permission prompts | On | Turn off |
| Topics, Protected Audience, Attribution Reporting | Off | — |
| Safe Browsing | The setting is on (hash-prefix only), but it does not protect in these builds: the list updates are refused without an API key (see above) | Turn off |
| Google sync | Not available | — |
| WebRTC local IPs | Hidden (mDNS) | Stricter policies through an extension; no setting |
| Global Privacy Control | On | Turn off |
| New-tab sponsored content | Never (no network on the new tab page) | — |
| Extensions | None installed | User installs; store traffic follows |

The rows Stedding changes from Chromium are in one Privacy block of Settings →
Stedding (`features/privacy.md`). Changes to any default in this table require an ADR
in docs/decisions/ and a release-notes entry.

## Not done yet

Building unbranded Chromium (`is_chrome_branded=false`, no Google API keys) already
removes metrics and UMA/UKM reporting, crash upload to Google, RLZ, the variations
seed fetch, Google sign-in and Sync, and Google's updater (`enable_updater` is
`is_chrome_branded && …`, so no updater is compiled). What it does not remove, and no
patch has changed yet:

| Still to do | Today |
|---|---|
| Network time queries off | On by default on desktop, and not gated on branding |
| Translate off by default | `translate.enabled` defaults to true |
| No navigation prediction or preconnect | `net.network_prediction_options` defaults to standard preloading |
| Component updates from our infrastructure | The component updater talks to Google; it needs an endpoint swap and a component allowlist |
| No placeholder API keys in request URLs | The placeholder key is still appended to some Google requests |

Planned (`ROADMAP.md` M10): ad and tracker blocking built in, with a switch per site,
whose own ADR comes first and names the filter-list fetches it adds to this document
(`BACKLOG.md` S-88), and tracking parameters stripped from every link opened, not only
from a copied one (S-89).

---

## The update check

On the Mac, Stedding updates itself with Sparkle 2 from a signed feed in this
repository (`decisions/0022-sparkle-updates-the-mac.md`, which partly supersedes
`decisions/0014-github-releases-as-update-channel.md`; `docs/features/updates.md`). It is
the one endpoint this project deliberately adds to Chromium, so it is described exactly.
Windows has no updater yet (`BACKLOG.md` S-74).

| | |
|---|---|
| Feed | `https://raw.githubusercontent.com/ysalitrynskyi/stedding-browser/main/updates/appcast.xml`, the file `tooling/publish-appcast` writes after a release. |
| Download | the release's own image, `https://github.com/ysalitrynskyi/stedding-browser/releases/download/v<version>/Stedding-<version>-arm64.dmg`, only when the feed lists a later version. |
| Sends | a plain HTTPS GET with Sparkle's user agent, which names the browser and its version. No account, no install id, no machine id, no system profile (`SUEnableSystemProfiling` is off and the browser adds no parameters), nothing in the query. |
| Receives | the feed: each release's version, minimum macOS, size, and EdDSA signature. |
| Frequency | ten seconds after launch when a day has passed since the last check, then once a day. A check the user asks for (Stedding › Check for Updates…, the command bar, the About page) runs when asked. |
| Default | **on** (the owner, 2026-10-16), with "Update Stedding automatically" in Settings › Stedding › Updates. |
| Verified | the image against the project's EdDSA public key in the app, before it is unpacked, and the feed's own signature; then Sparkle checks the new app's code signature. A build made locally (signed ad hoc) never runs the updater. |

**What GitHub can see.** An IP address, a user agent naming the version, and a
timing pattern. Over time that is enough to infer roughly where an installation is,
which version it runs, and that it is still running. That is a real cost and it is
written here rather than hidden behind the phrase "no telemetry", which would be
technically true and misleading.

**What it is not.** It is not a check-in, a licence check, or an analytics event.
Nothing identifies the installation, and the response is the same for everybody.

**Why GitHub rather than our own server.** Running an update service means
running infrastructure that knows who is asking. The release artifacts already
live on GitHub, so the download is the release's own image, and there is no
additional party — including us — learning anything. If GitHub ever becomes
unacceptable, the feed is one URL to move.

**Turning it off.** With "Update Stedding automatically" off the browser does not
start Sparkle at all: there is no "reduced" mode that still calls home, and no
request to GitHub until the user chooses Check for Updates. A version already
downloaded before the switch went off still installs when the browser quits.

**The thank-you pages.** After the install, when the welcome flow ends, and on the
first launch of each later version, the browser opens one page on stedding.dev
(Cloudflare Pages): `/thanks/` and `/thanks/updated/#v<version>`. The fragment is
not sent, so the server learns only that someone opened the page. The pages run no
analytics, ask for no consent, set no cookie and load nothing from another host;
their `Cache-Control: no-transform` keeps Cloudflare's edge from adding its
page-view beacon. "Show a thank-you page after an update" turns the second off;
the first opens once per installation.
