# Privacy principles and defaults

Privacy in Stedding is a set of shipped defaults, not a mode you enable. This
document states the principles, then what the browser actually does: what ships by
default, what is available by choice, and what is not done yet. How the Google
services in the Chromium base are removed or replaced is in ARCHITECTURE.md
("De-Googling stance"); this document is the product contract that work must satisfy.

Anything the shipping browser does on the network that is not listed here is a
bug. Report it through SECURITY.md.

A beta named here by its number alone is one of the 0.2.0 betas; 0.3.0 beta 1 follows
0.2.0 beta 21.

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
| Browser update check | GitHub: the update feed on `raw.githubusercontent.com`, at launch when the last check is more than an hour old and every six hours while the browser runs, and a new version's image (the Mac's DMG, the Windows installer) from `github.com` when there is one, which answers with a redirect to `release-assets.githubusercontent.com`, the host that serves the file. Described under "The update check" below; off in Settings › Stedding › Updates. | On the Mac a plain GET with Sparkle's user agent (the browser's name and version); on Windows a plain GET through the browser's own network stack with Chromium's reduced user agent (Chrome's major version and the Windows platform, not Stedding or its version), no cookies and the cache disabled. Nothing about the machine. | Security updates are non-negotiable for a Chromium fork. |
| Thank-you pages | stedding.dev, twice in an installation's life and then once per update: `/thanks/` when the welcome flow ends, `/thanks/updated/` on the first launch of a later version. The second is off in Settings › Stedding › Updates. | A plain page request. The version is in the URL's fragment, which the browser never sends. The pages load nothing from another host and set no cookie. | The owner's thanks, and the project's sponsorship (ADR 0022). |
| Security component updates | Google's component update service, as in stock Chromium, less one component: Google's Subresource Filter Rules are not registered, since Stedding's own blocking makes its rules from lists it fetches only when the user asks (`features/blocker.md` Bk4). | Component name and version. | Chromium ships security-critical data as components (for example certificate revocation sets). Which ones to mirror, proxy or remove is decided before 1.0. |
| Safe Browsing list updates | Google (`safebrowsing.googleapis.com`); refused in these builds, see the Safe Browsing section | Hashed URL prefixes, not URLs. | Phishing and malware protection. |
| Network time | Google (`clients2.google.com`) | A request for the current time. | Chromium judges certificate dates with it. Turning it off is not done yet (below). |
| The user's own browsing | Sites the user visits | Whatever the user does. | This is a web browser. Includes the DNS, TLS (OCSP/CT) and favicon traffic that browsing implies. |
| Extension install and update | Chrome Web Store (Google) | Standard store traffic. | Only once the user installs an extension. See the extension note below. |

### Made only after the user turns it on

| Connection | To | Contains | Why |
|---|---|---|---|
| Ad and tracker lists | `easylist.to` (`/easylist/easylist.txt` and `/easylist/easyprivacy.txt`), only while Settings › Stedding › Privacy › **Block ads and trackers** is on, which it is not by default: each list when its own expiry says (one to fourteen days) and at once on **Update lists now**. Described under "Ad and tracker blocking" below. | A plain conditional GET (If-None-Match, If-Modified-Since): no cookies, no cache, no query string, Chromium's own user agent. Nothing about the machine or the pages visited. | The filter lists blocking works from; nothing from them is built into the browser (`decisions/0030-ad-and-tracker-blocking.md`). |

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
- No certificate reports. Chrome sends Google a sample of the certificates its users
  meet once it enforces Certificate Transparency (SCT auditing, with lookups at
  `sctauditing-pa.googleapis.com`). Stedding enforces Certificate Transparency and
  reports nothing, whatever the Safe Browsing setting (`S-237`,
  `CertificateReportsTest.NoCertificateIsReported`).

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
different claims, and only the first is true today, which is why `docs/ROADMAP.md#the-quality-bar`
makes an unexplained endpoint a release blocker.

## Concrete stances

### Crash reports — none leave the machine

Stedding uploads no crash reports. Chromium's upload to Google is absent from
unbranded builds, and Stedding runs no crash service of its own. A crash dump may
stay on your disk, in the `Crashpad` folder of Stedding's data folder, and goes
nowhere. An opt-in
reporter is not on the roadmap; adding one would need its own ADR and an entry here
first.

### Certificates — checked as in Chrome

A public authority's certificate must carry proof that it was written to the public
Certificate Transparency logs, and Google's own sites accept only the keys Google pinned
for them (`S-236`, `S-237`). Both lists come with the certificate component update that
already brings the root store; nothing extra is fetched, and nothing is reported. A list
more than ten weeks old turns its check off rather than refuse sites, as in Chromium. A
certificate from a root the user added needs neither. One difference from Chromium in how
the verifier's updates are applied: until it has verified a certificate, an update (the
profile's first one at launch, the network time) no longer drops the idle connections and
the ones being opened ahead of a page, so tabs given at launch load over the connections
opened for them (patch 0077, `S-251`). Nothing is sent or checked differently.

### Default search engine — chosen by the user

First run shows a search engine chooser. The list order is randomized, the chooser
preselects nothing, and no engine has paid for placement — no search deal exists, and
if that ever changes it will be disclosed in this document and in release notes
before shipping. Until the user chooses, the default is DuckDuckGo, in every region:
a query typed before a choice -- the welcome's search step skipped, say -- goes to
DuckDuckGo and nowhere else. Skipping the step, or finishing the welcome flow without a
pick, keeps DuckDuckGo and records it as the choice, so no second chooser follows;
Settings changes it any time. In beta 17 and earlier a skipped step also brought
Chromium's own "Choose your search engine" dialog over the first page (`BACKLOG.md`
S-134). Search suggestions
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
**Import sidebar…** in Settings → Stedding → Sync and import.

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

### Dark pages — local only, off by default

**Dark pages** (`features/dark-pages.md`, from beta 18) makes no network request and
sends nothing. What it stores stays in the profile's `Preferences` file on this disk: the
switch, the button's setting, and the mode and the two lists of sites, Chromium's content
setting `AUTO_DARK_WEB_CONTENT`, which Stedding registers on desktop. The lists name sites
the user chose, as bookmarks do. Delete browsing data with "Site settings" ticked, and
Reset settings, clear them (read in the code, not yet run). A site chosen from a private
window is kept in memory for that session only. A page can learn that the reader prefers
dark, the signal a dark window already gives, and, through a trick Chrome documents, that
automatic darkening is on; it cannot read the lists.

### History and Downloads in the sidebar — nothing fetched

The sidebar's History and Downloads panels (`features/sidebar-panels.md`, written
2026-10-25, not yet built) make no network request. Their page is built into the browser;
site icons come from the profile's own favicon cache, never from a favicon server, and a site
with no icon there shows the default globe; file icons come from the system. The History panel
reads the local history through Chromium's own handler, which could read Google's web history
only for a profile signed in with history sync, which Stedding does not offer (below, "Google
account sync — not available"). Copy File writes a downloaded file's path to the clipboard
only when the user picks it; Move to Trash moves a file to the system's Trash or Recycle Bin
and never deletes it outright.

### Pictures of pages in hover cards — in memory only

Hovering a tab that is not on screen shows a small picture of its page as it was last seen
(`features/pins.md` H19–H23): Chromium's tab preview images, on in Windows builds as in
Chrome there, and on the Mac since 0.2.0 beta 21. The picture is copied from the
tab itself, when the tab leaves the screen or while its hover card waits for one, and is
kept as a JPEG in the browser's memory. It is never written to disk, never put in the saved
session and never sent anywhere; it goes when the tab closes or the browser quits, so none
comes back after a restart. A sleeping tab keeps its picture until then. Private windows
work the same way. Settings → Appearance → **Show tab preview images** turns the pictures
off.

### Apps made from pages — the page's own server only

Making an app of a page (**Add to Dock…** on the Mac, **Install page as app…** on Windows;
`features/web-apps.md`, from beta 18) is part of the user's own browsing: it fetches
only what the page names, in the page's own session -- its manifest (which may sit on
another host), the icons the manifest lists, its favicons, and the manifest's screenshots
for the larger dialog -- and later re-reads the manifest when a page of the app shows it.
No Google service is in the path: no install model, no web-app sync, no preinstalled Google
apps. The launcher, its signature, its icon and the Windows shortcuts are made on this
machine. What Stedding keeps about the app stays in the profile's `Preferences` file: the
cookie jar of the Space the app was made in (`stedding.apps.jars`) and, on the Mac, the
launcher its Dock tile points at (`stedding.apps.dock_tiles`); both go when the app is
removed.

### Imports from Dia and from Safari's export file — read on this machine

Importing from Dia (welcome step 2) reads Dia's own files on this computer: its bookmarks,
and copies of its history and logins files, made in a temporary folder that is deleted when
the read ends. Its passwords are unsealed with Dia's key, which on the Mac macOS hands over
only after asking you, and only after you press the button with Passwords ticked; the
summary before it reads no key. Safari's export file is read where you chose it, and
Stedding neither copies nor deletes it. It holds your passwords as plain text, so Passwords
starts unticked there; ticked, they are held in memory only until they are saved in the
profile's password store, and a saved password is never replaced. Payment cards in the
export are never read: of their file, only the opening lines that name what it holds. The
export's bookmarks page and passwords file are parsed in sandboxed utility processes.
Nothing an import reads is sent anywhere (`features/import.md` I28-I42).

### Google account sync — not available

Google shut off access to its private Sync APIs for third-party Chromium builds in
2021; forks cannot offer Chrome sync legitimately, and we will not pretend
otherwise. Signing into Google *websites* works normally — this only concerns
browser-level account integration, which the de-Googling work removes
(ARCHITECTURE.md). Stedding never offers to sign the browser in to Google, also on a
computer with Google's OAuth environment variables set (`features/privacy.md` Q16). Sync
services are out of scope on the way to 1.0 (ROADMAP.md).
Today the sidebar travels between machines as a file: **Export Space…** writes one Space and
**Export all Spaces…** every Space, to Downloads, and **Import sidebar…** reads either on the
other machine; profile import covers the rest. The file holds each Space's name, icon,
colours and whether it has its own session, and the addresses and titles of its pins,
folders, essentials and open tabs. It never holds history, cookies, passwords, extensions or
anything in a Space's own session, and Stedding sends it nowhere
(`features/sidebar-file.md`).

Sync through a folder (off by default) is not a sync service: each computer writes that file
to a folder the user picks and reads the other computers' files from it; their own sync tool
or shared drive carries them, and Stedding itself sends nothing anywhere. Each computer also
keeps, in its own profile, a record of the merged sidebar, the last ten changes for Undo and
five backups (`features/sidebar-file.md` Sf7–Sf41, ADR 0029).

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

### Links you open — tracking parameters removed, on by default

A page you open, from a link, a new tab, the address field, a bookmark or another app,
loads without the tracking parameters a copied link loses (`utm_*`, `fbclid`, `gclid` and
the rest of one table, `features/copy-link.md` L2), so the site's server never receives
them, and history keeps only the clean address. A link through a redirect page that
carries its target in its own address (Google's `/url`, Facebook's and Messenger's
`l.php`, Instagram's `l.`, Reddit's `out.`, YouTube's `/redirect`) goes straight to the
target, and the redirect page is never asked for. Both tables are compiled in: nothing is
fetched, and a shortener such as `t.co` is not asked for its target, so it is followed as
any link is. Only the first address of a top-level page is touched: a page's own requests,
frames, forms, reloads, back and forward, and a server's redirects are left as they are, so
a page that needs a parameter can still ask for it back. The tab's own entry, which session
restore writes to disk, still records the address as it was opened. Settings → Stedding →
Privacy → **Remove tracking from links you open** turns it off, and **Sites that keep
their links** exempts a site (`features/clean-links.md`; `features/privacy.md` Q15).
### Ad and tracker blocking — off by default, nothing kept per site

**Block ads and trackers** (Settings › Stedding › Privacy; `features/blocker.md`, ADR 0030) is
off until the user turns it on. Then, and only then, Stedding downloads two filter lists,
EasyList and EasyPrivacy, from their homepage, `easylist.to`, each again when it says it
expires, and converts them on this computer into the rules Chromium's own subresource filter
blocks by. The request carries nothing about the user (the row above). The lists, the rules made
from them and a LICENSE file naming each list stay in the `Stedding Blocker` folder of the data
folder; their fetch times are in local state. Blocking keeps no record of the sites visited: the
"ads blocked" icon is not shown and Chromium's per-site ads data is not written. The only thing
stored for a site is an exception the user made (the ADS content setting, in the profile's
`Preferences` file); one made in a private window stays in that window's memory. Delete
browsing data with "Site settings" ticked clears the exceptions. Turning blocking off stops the
fetches; the downloaded lists stay on disk until the data folder is removed.

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
| Update checks | On, on the Mac from beta 16 and on Windows from beta 19: the signed feed on GitHub at launch when the last check is more than an hour old and every six hours, with no identifiers ("The update check", below) | Settings → Stedding → Updates |
| Search engine | User chooses at first run; DuckDuckGo until then | Change any time |
| Cookies per Space | Off: every Space shares the profile's jar | Independent session on a Space keeps its own cookies, cache and site data on this disk; Clear Independent Session empties it; deleting the Space deletes it; Delete browsing data reaches it from beta 9 on (Mac: beta 10) (`features/sessions.md`) |
| Search suggestions | Off | Opt in |
| Navigation error suggestions (asking a web service what to show when a page does not load) | Off | Turn on |
| Third-party cookies | Blocked | Allow per site |
| HTTPS-First | On | Turn off |
| Quiet permission prompts | On | Turn off |
| Topics, Protected Audience, Attribution Reporting | Off | — |
| Safe Browsing | The setting is on (hash-prefix only), but it does not protect in these builds: the list updates are refused without an API key (see above) | Turn off |
| Google sync | Not available | — |
| Sidebar sync through a folder | Off. Once a folder is chosen, this computer's file there holds its Spaces (name, icon, colours, order, whether it has its own session), pins (home address and the user's own name), pinned folders, essentials, a random install id and the computer's name ("Mac" or "Windows PC" and four characters, or what the user typed). Never open tabs, history, cookies, passwords, jars or the host name. Stedding makes no network request for it: the user's own sync tool or shared drive moves the file (`features/sidebar-file.md` Sf7–Sf41) | Settings → Stedding → Sync and import → Sync through a folder; Stop syncing, with or without removing this computer's file |
| WebRTC local IPs | Hidden (mDNS) | Stricter policies through an extension; no setting |
| Global Privacy Control | On | Turn off |
| Tracking parameters on links you open | Removed, and known redirect pages skipped; nothing fetched | Turn off; keep a site's in Settings |
| Ad and tracker blocking | Off; nothing fetched | Turn on (lists from easylist.to); then off or on for any site |
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

Planned (`ROADMAP.md` M10): the later slices of ad and tracker blocking (element hiding,
optional lists and a page for a blocked site, `features/blocker.md` Bk20 to Bk23)
(`BACKLOG.md` S-88).

---

## The update check

On the Mac, Stedding updates itself with Sparkle 2 from a signed feed in this
repository (`decisions/0022-sparkle-updates-the-mac.md`, which partly supersedes
`decisions/0014-github-releases-as-update-channel.md`; `docs/features/updates.md`). It is
the one endpoint this project deliberately adds to Chromium, so it is described exactly.
On Windows the browser itself reads a feed of its own the same way and runs the installer it
downloads (`decisions/0023-updates-on-windows-and-linux.md`, `decisions/0026-a-windows-update-key.md`):
the rows below say where the two differ.

| | |
|---|---|
| Feed | Mac: `https://raw.githubusercontent.com/ysalitrynskyi/stedding-browser/main/updates/appcast.xml`, the file `tooling/publish-appcast` writes after a release. Windows: `.../updates/appcast-windows.xml`, written by `tooling/win/publish-appcast.ps1`. |
| Download | the release's own image, `https://github.com/ysalitrynskyi/stedding-browser/releases/download/v<version>/Stedding-<version>-arm64.dmg` (Mac) or `Stedding-<version>-win-x64.exe` (Windows), only when the feed lists a later version. On both platforms `github.com` answers with a redirect to `release-assets.githubusercontent.com`, which serves the file. |
| Sends | a plain HTTPS GET. On the Mac it carries Sparkle's user agent, which names the browser and its version. On Windows it goes through the browser's own network stack with the cache disabled and Chromium's reduced user agent, which names Chrome's major version and the Windows platform but not Stedding or its version. No cookies, no account, no install id, no machine id, no system profile (`SUEnableSystemProfiling` is off and the browser adds no parameters), nothing in the query. |
| Receives | the feed: each release's version, minimum system, size, and EdDSA signature. |
| Frequency | ten seconds after a launch when the last check is more than an hour old (or there is none), then every six hours while the browser runs: no more often than once an hour, however often it is launched (the owner's decision of 2026-10-21; until 0.3.0 beta 1 it was once a day). On Windows a check that could not reach the feed does not count as one: the next comes within the hour. A check the user asks for (Stedding › Check for Updates… on the Mac, the command bar, the About page) runs when asked. |
| Default | **on** (the owner, 2026-10-16), with "Update Stedding automatically" in Settings › Stedding › Updates. |
| Verified | the image against the project's EdDSA public key in the app, before it is unpacked, and the feed's own signature; then Sparkle checks the new app's code signature. On Windows the feed and the installer are checked against the Windows update key the build carries (Ed25519) before either is used, and only a copy the installer put in place runs the updater. A build made locally never runs the updater. |

**What GitHub can see.** An IP address, a user agent naming the version (on Windows,
only Chrome's major version), and a timing pattern. Over time that is enough to infer
roughly where an installation is, which version it runs, and that it is still running.
That is a real cost and it is written here rather than hidden behind the phrase "no
telemetry", which would be technically true and misleading.

**What it is not.** It is not a check-in, a licence check, or an analytics event.
Nothing identifies the installation, and the response is the same for everybody.

**Why GitHub rather than our own server.** Running an update service means
running infrastructure that knows who is asking. The release artifacts already
live on GitHub, so the download is the release's own image, and there is no
additional party — including us — learning anything. If GitHub ever becomes
unacceptable, the feed is one URL to move.

**Turning it off.** With "Update Stedding automatically" (Settings › Stedding ›
Updates) off, the browser on the Mac does not start Sparkle at all: there is no
"reduced" mode that still calls home, and no request to GitHub until the user
chooses Check for Updates. A version already downloaded before the switch went off
still installs when the browser quits. On Windows the same setting stops the scheduled
checks; a check the user asks for still runs.

**The thank-you pages.** After the install, when the welcome flow ends, and on the
first launch of each later version, the browser opens one page on stedding.dev
(Cloudflare Pages): `/thanks/` and `/thanks/updated/#v<version>`. The fragment is
not sent, so the server learns only that someone opened the page. The pages run no
analytics, ask for no consent, set no cookie and load nothing from another host;
their `Cache-Control: no-transform` keeps Cloudflare's edge from adding its
page-view beacon. "Show a thank-you page after an update" turns the second off;
the first opens once per installation.
