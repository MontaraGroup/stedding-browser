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
| Browser update check | None yet: no build checks for updates (`BACKLOG.md` S-74). When it lands it goes to the GitHub Releases API, described under "The update check" below. | — | Security updates are non-negotiable for a Chromium fork. |
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

### What a fresh profile contacted: a recorded run

2026-09-28, the release build of 155.0.8059.12 (patch 0057), a new profile in a
temporary folder, started headless with nothing opened, about four and a half
minutes, from Chromium's own network log (`BACKLOG.md` S-50; the ten-minute run with a
window is still to do):

| Host | What | Listed above? |
|---|---|---|
| `update.googleapis.com`, `edgedl.me.gvt1.com` | Component updates and their downloads: the first check at about one minute, then roughly every five hours, the certificate CRLSet among them | Yes |
| `safebrowsing.googleapis.com` | One Safe Browsing list update, refused (HTTP 400: no API key) | Yes |
| `clients2.google.com/time/1/current` | Chromium's network time | Yes |
| `android.clients.google.com/checkin`, `/c2dm/register3` | Google's push service: a device check-in and registrations | **No** (`BACKLOG.md` S-54) |
| `accounts.google.com/ListAccounts` | The Google account check, with no account signed in | **No** (`BACKLOG.md` S-67) |

The last two break principle 2 until they are removed. The new tab page is local
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
DuckDuckGo and nowhere else. Search suggestions (sending keystrokes to the chosen
engine) are off by default and can be turned on in Settings → Stedding → Privacy.

### Safe Browsing — does not work in these builds

The trade-off: Safe Browsing protects against phishing and malware, but the
standard implementation checks URLs against Google-operated lists. The standard
(v4, "Update API") protocol downloads hashed prefix lists locally and only contacts
the server for hash-prefix matches — Google does not receive your browsing
history, but does receive occasional partial-hash queries and your IP.

Where it stands (2026-09-28): the setting is on, but Stedding's builds carry no
Google API key, and Chromium's list updates need one. Confirmed on a running build
(PLAN.md WEB-5; the recorded run above): the first list update, about four minutes
after start, went to `safebrowsing.googleapis.com` with no key and Google answered
HTTP 400. So the local lists stay empty and no listed site gets a warning page --
while the requests themselves still reach Google, with your IP address. Only the
local warnings for dangerous file types remain. Do not count on Safe Browsing to
protect you in Stedding. The route the owner chose (2026-10-01, `BACKLOG.md` S-75) is
the lists through stedding.dev, with the key on the server and no Google API in the
browser; it is set aside for now, on the owner's word.

Our stance, once it is settled:

- **By default:** standard, hash-prefix Safe Browsing that is proven to work,
  because shipping a browser to non-hypothetical users with phishing protection off
  is not a defensible default.
- **Available by choice:** turning it off entirely, one switch, clearly explained.
- **Never by default:** "Enhanced" Safe Browsing modes that send full URLs or page
  content in real time. Stedding never turns it on, but Chromium's Security page
  still offers it as a choice; taking the option out is open (PLAN.md WEB-5).

### Data earlier betas left on disk

Betas up to 8 wrote a snapshot of the sidebar every hour into a `Sidebar Backups`
folder inside the profile: every tab's address and title, in plain JSON. Later
builds no longer write it, and Clear browsing data does not remove it. Delete the
folder by hand if you do not want to keep it, or import one of its files with
**Import sidebar…** in Settings → Stedding → Spaces.

### A Space's own cookies and Delete browsing data

A Space with an independent session keeps its cookies, cache and site data in a
jar of its own on this disk (`features/sessions.md`). In every beta up to 8,
**Delete browsing data** did not reach those jars: the dialog reported the data
gone while each such Space stayed signed in, and so did the jar a Space keeps
while its independent session is switched off. The same was true of
`chrome.browsingData` and of deleting one site's data. The fix makes every removal
that names no jar run again for each Space's jar, with the same time range and the
same sites (sessions S24, PLAN.md SPC-11). Beta 9 and later carry the fix (on the Mac,
beta 10 and later). On beta 8 or earlier, use **Clear Independent Session** on the
Space, or delete the Space.

Chromium also clears out unused storage after an extension or app is removed, and
that clean-up could delete the jar of a Space with no tab open, cookies and all
(sessions S25, PLAN.md SPC-10). The same builds keep the jars.

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
| Google's push service at startup | A fresh profile checks in with it (`BACKLOG.md` S-54) |
| The account check at startup | A fresh profile asks `accounts.google.com` (`BACKLOG.md` S-67) |
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

Stedding will check for updates against the GitHub Releases API
(`decisions/0014-github-releases-as-update-channel.md`); no build does yet
(`BACKLOG.md` S-74). It is the one endpoint this project deliberately adds to
Chromium, so it is described exactly.

| | |
|---|---|
| Endpoint | the releases of `ysalitrynskyi/stedding-browser` on `api.github.com`. The exact request is fixed when the check is built: `/releases/latest` returns only full releases, and every Stedding release so far is a pre-release. |
| Sends | a plain HTTPS GET. No account, no install id, no machine id, no usage data, nothing in the query that identifies anyone. |
| Receives | the newest release tag, compared against the running version. |
| Frequency | at most once a day, and only while enabled. |
| Default | **off** until it has a settings entry, which `QUALITY.md` requires before any feature ships. |

**What GitHub can see.** An IP address and a timing pattern. Over time that is
enough to infer roughly where an installation is and that it is still running.
That is a real cost and it is written here rather than hidden behind the phrase
"no telemetry", which would be technically true and misleading.

**What it is not.** It is not a check-in, a licence check, or an analytics event.
Nothing identifies the installation, and the response is the same for everybody.

**Why GitHub rather than our own server.** Running an update service means
running infrastructure that knows who is asking. The release artifacts already
live on GitHub, so the update metadata and the download are the same objects, and
there is no additional party — including us — learning anything. If GitHub ever
becomes unacceptable, the check is one URL to move.

**Turning it off.** The settings entry disables it completely; there is no
"reduced" mode that still calls home. A build with the check off makes no request
to GitHub at all.
