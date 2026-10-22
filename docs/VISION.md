# Vision, name, brand and competitors

Stedding Browser is a fully open-source, Chromium-based desktop browser with an
Arc-style interface: a sidebar with vertical tabs, Spaces (workspaces), split view,
and a command bar. It is built for technical users who want privacy, control, and a
modern, productive UI — without betting their daily workflow on a company's
pivot, acquisition, or monetization plan.

This document explains why the project exists, what it values, who it is for,
and — just as important — what it will never be. It also records the project's name
and brand (how the name was chosen, the voice and look, and the trademark rules) and
the competitors Stedding is measured against.

## Why this exists

Arc proved something: a browser organized around a sidebar, workspaces, and a
command bar is a genuinely better way to work than a row of horizontal tabs.
People who adopted that model rarely wanted to go back.

Then its maker moved on. The Browser Company shifted its attention to Dia, its
AI-centric browser, and stopped building Arc forward. Arc was never open
source, so nobody outside the company could pick it up. Users who had
reorganized their working lives around that interface were left with a product
in maintenance and no exit that preserved their workflow.

Look at the alternatives and there is a gap:

- Arc is closed source and no longer the focus of its maker.
- Zen carries a similar spirit but is built on Firefox, which rules out the
  Chrome extension ecosystem many technical users depend on.
- Vivaldi is powerful but its UI layer is proprietary.
- Brave is open source but bundles crypto and rewards features, and its UI is
  conventional Chrome.
- Helium (de-Googled) and Thorium (performance-focused) are minimal Chromium
  forks that keep Chrome's UI; neither rethinks the interface.
- Nook and Aura, newer open-source Arc-style browsers, are built on WebKit for
  Apple's platforms under copyleft licences, so they have no Windows build and only
  WebKit's partial support for Chrome's extensions (see "Competitors", below); Aura is
  archived.

A fuller comparison is in "Competitors", below. The short version: **no
fully open, permissively licensed Chromium browser carries the Arc workflow
model forward.** That is the gap Stedding fills.

Because the core is BSD-3-Clause, this cannot happen to Stedding's users the
way it happened to Arc's. If the maintainers lose interest, pivot, or sell,
anyone can fork the browser and keep going. The license is the exit that Arc
never gave anyone.

## What we are building

A minimal patch-set fork of Chromium stable (the Brave/Helium model, not a hard
fork), with the UI work kept as high in the stack as possible so tracking
upstream stays as cheap as it can be. Full Chrome extension compatibility is a hard
requirement. macOS first, then Windows, then Linux.

The product bar is fixed: every milestone ends in something installable, and
features ship complete — shortcuts, settings, edge cases, polish — or they do
not ship. Details in `docs/PRODUCT.md`, `docs/ARCHITECTURE.md`, and
`docs/ROADMAP.md` ("The quality bar").

## Values

**User control.** The browser answers to the person using it. Defaults are
opinionated, and everything meaningful is configurable: nothing has to ask a server
for permission. Your profile, your data, your machine.

**Privacy by default.** No telemetry by default, and none in the builds to turn on. Privacy protections
are product features with the same quality bar as everything else, not
checkbox settings buried three menus deep. Concrete commitments are in
`docs/PRIVACY.md`.

**Openness.** The entire browser is developed in public under BSD-3-Clause.
Decisions that are hard to reverse get written down as ADRs in
`docs/decisions/` before or with the change. Closed or paid add-ons may exist
someday, but the core browser — everything needed to build, run, and fork it —
stays permissively licensed.

**Craft.** Shipping polished beats shipping first. A feature that is 90% done
is 0% done. Performance, keyboard support, and detail work are part of the
definition of every feature, not a later pass.

## Who it is for

Technical users: developers, researchers, power users — people who live in
their browser all day, keep dozens of tabs across several projects, rely on
extensions, and notice when software wastes their time. People who read a
privacy policy, or would rather use software that makes reading one
unnecessary.

It is emphatically for former Arc users who want that workflow back on a
foundation nobody can take away.

It is not, at least initially, aimed at users who want a browser that manages
itself. Stedding is opinionated and rewards investment. The defaults will be
good, but the payoff is in the Spaces, the command bar, and the keyboard.

## Non-goals

These are commitments, not omissions. Absence from this list is not a promise;
presence on it is.

- **No crypto or web3 features.** No wallet, no tokens, no rewards program, no
  blockchain integration of any kind. Users who want these can install
  extensions.
- **No ads or sponsored placements, ever.** No sponsored tiles, no paid default
  shortcuts, no affiliate-injected results, no "partner" content. The new tab
  page belongs to the user.
- **No AI gimmicks bolted on.** Stedding ships no bundled model: no command-bar
  chat, no agent that holds a Space's cookies (ADR 0020). Any later feature that
  sends page content or browsing data to a model needs an ADR of its own, and is
  opt-in, clearly labelled and off by default. Dia exists for people who want an
  AI browser; Stedding is not that.
- **No mobile, initially.** Desktop (macOS, Windows, Linux) is the whole scope
  until 1.0 is shipped and stable. A mobile browser is a different product with
  different constraints, and doing it badly would violate the quality bar.
- **Not a Chrome re-skin.** Stedding is an opinionated workflow browser. The
  point is the sidebar, Spaces, split view, and command bar — a different
  way of working. If a change merely recolors Chrome, it is not worth a patch.

## What success looks like

A technical user downloads an installer, opens it, imports their profile, and
prefers it to Chrome or Arc within a day. Every milestone on the way there ends
in something installable (`docs/ROADMAP.md`).

We do not measure success in user counts we would have to invent. The project
succeeds when it is someone's daily browser and they stop thinking about it —
and when, if this project ever ends, its users are not stranded.

## The name

The naming decision record.

Date: 2026-08-30
Status: Decided — the product is named **Stedding Browser**, canonical domain **stedding.dev**.
See also: `decisions/0001-product-name-stedding.md`, `decisions/0004-domain-stedding-dev.md`, and
"Brand and voice", below.

### Method

We generated candidate names from invented and real English words and coinages
across nautical, avian, wayfinding, and shelter themes.

Every candidate was vetted with live web searches on the same day against five criteria:

| Criterion | What we checked |
|---|---|
| Existing browsers | Any shipping or announced browser with the same or a confusable name |
| Software collisions | Apps, CLIs, SaaS products, packages, or dev tools using the name |
| Trademark exposure | Active companies or rights-holders in adjacent markets, especially ones selling to our audience |
| Pronunciation | One obvious reading for an English speaker; no competing readings |
| SEO headroom | Realistic odds of ranking #1 for the exact phrase "{Name} Browser" |

A name failed if it collided with any browser, with software our target users
(developers, DevOps, technical users) already know, or with a rights-holder likely to
contest it. A candidate also had to be usable as a name without implying affiliation
with anyone.

### Why the early working name was rejected

The project's early working name failed vetting on two counts. A well-funded software
company sells to the same technical audience under that name: two software products
with one name aimed at overlapping buyers is a textbook trademark-confusion posture,
and that company has the resources to contest it. And English speakers pronounced it
two ways; a name people cannot say the same way is a name they cannot recommend out
loud. Either problem alone would have been survivable; together they were
disqualifying.

### Finalists

#### Stedding — winner

- **Meaning matches the product thesis.** Stedding means a haven, a settled, kept
  place; the browser is a place to use the web where the surveillance economy cannot
  reach. The name *is* the pitch.
- **Clean field.** No products, no live trademarks, no exact-phrase competition for
  "Stedding Browser" — the SERP is effectively empty.
- **Plain English roots.** The name is shaped on the English word "steading", a
  farmstead or homestead, which comes from "stead", an old word for a place. We use
  only the word, as this browser's name, and claim no affiliation with anyone.

#### Vesper — runner-up

- Highly brandable, pleasant to say, empty exact-phrase SERP for "Vesper Browser".
- Some existing bare-name software use (assorted small apps and projects), which is
  survivable but not the clean field Stedding offers.

### Notable eliminations

| Candidate | Reason eliminated |
|---|---|
| Heron | **Herond Browser** — an active Chromium-based privacy browser one letter away; direct confusion in our exact category |
| Vela | Three existing browsers already use the name |
| Rove | rovebrowser.com exists |
| Lumar | Lumar (formerly DeepCrawl), an SEO SaaS sold to technical marketers; also a near-homophone of Lemur Browser |
| Skiff | Dead privacy brand (acquired by Notion, shut down); inheriting its ghost and its grave |
| Scry | An existing "Scry browser app"; also rhymes with "spy", the exact opposite of the pitch |
| Magpie | Name saturated across apps and tools |
| Lodestar | Saturated; multiple software products |
| Prow | Dev-tool collisions |
| Cairn | Saturated across apps and dev tools |
| Tern | Dev-tool collision (Tern, the JS analysis engine, among others) |
| Pharos | Saturated; multiple software products |

### Domain

**stedding.dev** is the canonical domain.

- **Short brand domain over exact-match.** steddingbrowser.com was available, but
  exact-match-domain SEO is mostly obsolete; ranking for "Stedding Browser" depends on
  content and links, not the domain string.
- **.dev fits the audience** — technical users — and the entire .dev zone is
  HSTS-preloaded, so the site is HTTPS-only by construction. Right signal for a
  privacy product.
- **stedding.top rejected**: cheap, but the TLD's spam association hurts trust in the
  one place we cannot afford it — the download page.
- **stedding.com, stedding.app, stedding.co** are already registered by unrelated
  parties. Acceptable: we are a browser people search for by name, not a domain-hack
  business. Revisit acquisition only if the project grows enough to justify it.

### Outcome

- Product name: **Stedding Browser**
- Domain: **stedding.dev** (DNS on Cloudflare)
- GitHub: `ysalitrynskyi/stedding-browser`
- Usage rules for the name (voice, trademark hygiene, what we never do): "Brand and voice", below

## Brand and voice

How Stedding presents itself: the name, the voice, the look, and the rules
that keep all three safe to use. The naming decision record — the candidates and
the criteria they were vetted against — is in "The name", above.

### Using the name

**Stedding Browser.** "Stedding Browser" on first mention; "Stedding" after
that. The binary, bundle, and package identifiers use `stedding`.

#### Meaning and story

Stedding means a haven: a settled, kept place. The name is shaped on the
English word "steading", a farmstead or homestead — a farmhouse and its
outbuildings. "Steading" comes from Middle English "steding" ("place, farm"),
and that from Old English "stede" ("locality, place, site"); "stead" is an old
English word for a place.

That meaning maps precisely onto what this browser is for: a place to use the
web where surveillance and vendor control cannot reach. What shapes the rest
of the web — tracking, telemetry, ad-driven defaults, roadmaps set by someone
else's business model — stops at the door.

The name says what it is: a quiet, held ground.

#### Pronunciation

**STED-ding.** Rhymes with "wedding." Two syllables, stress on the first.

### Voice

Calm, precise, no hype. Stedding writes the way a good engineer explains
something to a colleague: plainly, accurately, without selling.

- **Say what the software does.** Not what it "revolutionizes," "supercharges,"
  or "reimagines." If a sentence would survive on a competitor's site
  unchanged, it says nothing; cut it.
- **Be concrete.** "No telemetry by default" beats "privacy-first." Numbers
  only when they are real and measured; write TBD rather than invent one.
- **Be quiet.** No exclamation marks in product copy. No emoji in docs or
  release notes. No countdowns, no FOMO, no "last chance."
- **Respect the reader.** The audience is technical. Do not pad, do not
  over-explain, do not hide limitations. State trade-offs plainly.
- **Admit what is unfinished.** "Not implemented yet" is a complete sentence
  and better brand-building than a vague promise.

The same register applies everywhere: website, release notes, error messages,
settings copy, and social posts. If it would sound wrong in a commit message,
it is wrong on the website.

### Taglines

Chosen with the website (stedding.dev, 2026-09-16): **"Your haven on the web."** leads,
and **"A quiet place to get things done."** is kept for where the workflow features are
the subject. The first is the name's meaning in five words; the second is honest about
what daily use feels like.

### Visual direction

The mark and the palette exist. The mark is generated from one geometry file,
`tooling/brand/mark.py`, into `branding/` (an arch over a hearth); its colours are slate
`#2F4858`, cream `#F2E9DE`, amber `#E8B04B` and ink `#1C2B33`, deliberately not blue,
since every Chromium browser is blue. The browser's own chrome is sand by day and a
blue-to-plum gradient by night, each Space's colour tinting the sidebar (patch 0007). How
the assets are made and applied is `branding/README.md`. Neither the mark nor the palette
has an ADR.

The rules any new visual work keeps:

- **Mood: quiet and settled.** The name means a settled, kept place. Calm,
  grounded, unhurried. The opposite of neon gradients, glassy chrome, and
  startup confetti.
- **Motifs: shelter and ground.** A roof line, an arch, a threshold, a hearth,
  stone. Abstract geometry derived from these beats literal illustration —
  and material from anyone else's work is ruled out entirely (see trademark
  hygiene).
- **Both themes.** Everything holds up in light and dark, since the browser chrome
  is where the brand lives daily.
- **Typography.** A clear, unremarkable-in-the-best-way sans-serif for UI and
  docs. Nothing decorative in the product; any display face is for the website
  only, and its licence must permit open-source redistribution.
- **Iconography.** Simple, geometric, legible at 16 px. The app icon must read
  at dock size next to Chrome, Arc, and Firefox without shouting.

Test for any visual proposal: does it feel like a place you would go to
concentrate? If it feels like a place someone is trying to sell you something,
it fails.

### Trademark hygiene

The name is shaped on ordinary English words. These rules keep it clear of
anyone else's brand or work.

- **We use only the word.** Only the word "Stedding" is used, as this
  browser's name. No artwork, logos, names, quotations or other material from
  any book, film, game or other brand — not in the product, the website, the
  docs, marketing, or community spaces we control. Every piece of artwork is
  our own.
- **No claimed affiliation.** We do not state or imply endorsement by, or
  association with, anyone.
- **Plain English roots.** The name is shaped on plain English: "steading",
  a farmstead or homestead, from "stead", an old word for a place. This is a
  hygiene policy, not legal advice; if anyone ever objects to the name, we
  engage in good faith.
- **BSD clause 3 protects the name from forks.** BSD-3-Clause forbids using
  the names of the copyright holder or contributors to endorse or promote
  derived products without written permission. Anyone may fork the code — that
  is the point of the license — but a fork may not market itself as endorsed
  by, or pass itself off as, Stedding. Written guidance for naming a fork does not
  exist yet.
- **Registration status: TBD.** No trademark registration has been filed as of
  2026-08-30. Whether and where to file is an open question; the decision gets
  an ADR when it is made.

When in doubt: the word, its meaning, our own artwork — nothing else.

## Competitors

Where Stedding sits among the browsers that matter to our audience: technical users
who want an Arc-style workflow UI, privacy, and control. Facts below were checked
against public sources on 2026-08-30; statuses change, so verify before quoting.

### The reference point: Arc

**Arc** (The Browser Company of New York) defined the feature model we admire:
sidebar with vertical tabs, spaces (workspaces), split view, a command bar, and an
opinionated, polished macOS-first design. It proved there is real demand for a
browser that treats tab management as a first-class product problem.

Arc is closed source and its development has wound down. The Browser Company
announced in May 2025 that Arc would receive security and Chromium updates only,
with no new features, as the team pivoted to Dia. In September 2025 Atlassian
announced it was acquiring The Browser Company (reported at ~$610 million). Arc
still runs, but its users are effectively on a maintenance-mode product owned by an
enterprise software company — which is precisely the situation Stedding exists to
make impossible: our core is BSD-licensed and forkable, so no acquisition or pivot
can take the product away.

### Direct and adjacent competitors

#### Dia (The Browser Company / Atlassian)

AI-centric browser and the successor product to Arc. Closed source; as of this
writing available only on macOS 14+ with Apple Silicon. Dia's core interaction is
chatting with an AI about your tabs, not Arc's workflow model, though it does ship
tab groups, profiles and end-to-end encrypted sync. Under Atlassian, its roadmap points at
work/enterprise use. Different lane: Dia bets on AI as the interface; we bet on the
workflow UI Arc abandoned.

#### Zen Browser

Open-source (MPL-2.0), Firefox/Gecko-based browser with an Arc-like UI: vertical
sidebar, workspaces, compact mode, split view, "Glance" previews, community mods.
Actively developed with a large community (tens of thousands of GitHub stars) and
regular releases tracking Firefox. Zen is our closest spiritual peer — same thesis
(the Arc model deserves to live, in the open), different engine lane. The decisive
difference: Zen inherits Firefox's extension ecosystem and web compatibility
profile. Users who need Chrome extensions or Chromium-only site behavior cannot
switch to Zen. That is the lane we occupy, and why we did not simply join Zen
(see AGENTS.md: Firefox base considered and rejected).

#### Helium

Open-source (GPL-3.0) Chromium-based browser by imput, with Google service
dependencies removed, built-in ad/tracker blocking, and a deliberately minimal
interface. In beta on macOS, Windows, and Linux; no native sync. Helium validates
our technical approach — a small, maintained patch set on Chromium with the Google
services stripped — and we study it for that reason. Helium's product thesis is
minimalism, but the gap is narrower than it was: it now ships vertical tabs, split
view and tab groups. What it does not ship is the layer above those — workspaces and
a command bar — which is where Stedding's differentiation actually sits. Also copyleft
(GPL) where we are permissive (BSD).

#### Thorium

Chromium fork by a solo developer (Alex313031) focused on compiler-level
performance optimizations (AVX2/SSE4 builds and similar), with Chrome-like
features restored. Open source, BSD-3-Clause, active releases across platforms.
Thorium competes on raw speed claims, not workflow or privacy defaults, and ships
a stock Chrome-style UI. No overlap with our product surface; some overlap in
audience (users willing to run a niche Chromium fork).

#### Brave

The most prominent privacy-positioned Chromium browser. Open source (MPL-2.0), full
Chrome extension support, ad/tracker blocking on by default, solid engineering,
long track record of tracking Chromium stable. Brave's business model is the
friction point for our audience: opt-in Brave Rewards paying users in BAT
cryptocurrency, sponsored new-tab background images shown by default, crypto
wallet and widgets built in, and a history of trust incidents (notably the 2020
affiliate-link autocomplete episode). Ships a conventional horizontal-tab UI
(vertical tabs exist as an option, not as the organizing model). Users who want
Brave's privacy without the crypto/ads surface area are a core Stedding audience.

#### Vivaldi

Power-user Chromium browser: tab stacks, tiling/split view, workspaces, notes,
built-in mail and calendar, deep customization. Full extension support; revenue
comes from search deals and partner placements rather than from an ad product of its
own. The blocker for us and our users: Vivaldi's UI layer is proprietary
and closed source (Vivaldi has publicly explained why it won't open it), and the
browser sends a documented user-counting ping with an installation identifier. A
feature-rich browser you cannot audit or fork is not in our lane.

#### Floorp

Open-source (MPL-2.0) Firefox-based browser from the Japanese Ablaze community:
vertical tabs, workspaces, web panels, heavy customization. Same engine-lane
limitation as Zen (Firefox extensions only), with a smaller community and a less
Arc-shaped design. Adjacent, not competing.

#### SigmaOS

Closed-source, Mac-only, WebKit-based browser aimed at task-based work browsing
(pages as todo items, spaces, AI features), on a freemium model. macOS-only by
design. Notably it does support Chromium extensions despite the engine — the vendor
calls it "the first Webkit browser to support Chrome extensions" — so the engine
choice does not cost users their extensions the way it normally would. Interesting
interaction ideas; different engine, different openness, different audience breadth.

#### Horse Browser

Closed-source, paid (subscription) browser by a solo developer. Replaces tabs
entirely with "Trails" — a persistent tree of pages that preserves how you got
somewhere — and markets to users with ADHD. Chromium-based; added extension support
in August 2026. A genuinely novel navigation model, but a niche, closed, paid
product. Evidence that small teams can ship real browser UX innovation — and of how
much distribution a solo closed product can't get.

#### Nook

Open-source, Arc-style browser for macOS 26 on Apple silicon, in Swift and SwiftUI on
WebKit (`WKWebView`), GPL-3.0, with its name and icon reserved; an iPhone and iPad version
is started. Active: about 2,000 stars, 12 releases (v1.2.1 on 2026-10-08), 13 contributors,
most of the recent work by one person. Chrome extensions run through Apple's WebExtension
support, so what works is what WebKit supports. What it has that Stedding does not, read on
2026-10-11: a built-in ad blocker (Brave's adblock-rust) with a "blocked page, continue?"
screen; tracking parameters stripped from every link opened; child tabs under their opener,
Back returning to it; a second press of a chord a web app also binds reaching the browser;
rebindable shortcuts; a video you leave playing moving into the sidebar; Peek and little
windows as one page that becomes a tab without reloading; "this page is open in another
window: show here / go to window"; the sidebar on the right; closed tabs reopened from a
stack kept across launches; History and Downloads in the sidebar; import from Dia and
Safari's export file. A second read of its code the same day added smaller things:
folders inside the pinned list, a launch that loads only the last tab, tabs that sleep on
a timer and one panel of site controls; its inline completion, Tab-to-search chips and
folder and pin verbs have Stedding counterparts since beta 14. It also carries AI
features (a sidebar chat, a tab organizer, an agent-control server) that ADR 0020 keeps out
of Stedding. The ideas Stedding takes are rebuilt from these descriptions, never from its
files (ADR 0021; `docs/ROADMAP.md` M10).

#### Aura

Open-source Arc-style browser for iPad first (iPhone and visionOS too; the Mac through
Catalyst), in Swift and SwiftUI on WebKit, MPL-2.0 since 2025-06-06 and archived since then;
its rewrite has no license. One author, no releases (TestFlight), about 200 stars. Ideas
worth having: a free colour or gradient per Space and a searchable icon picker, per-site CSS
("Boosts") written in a side panel with a live preview, dark mode forced on web pages, the
sidebar on the right. Not to copy: it sends every keystroke to Google's suggestions whatever
the engine, logs API keys, and blocks every third-party script. Rebuilt from descriptions
only (ADR 0021).

### Summary table

| Browser | Engine | Arc-style workflow UI | Open source | License | Chrome extensions | Status (2026-08) |
|---|---|---|---|---|---|---|
| Arc | Chromium | Yes (defined it) | No | — | Yes | Maintenance mode |
| Dia | Chromium | No (AI-first) | No | — | Partial | Active (Atlassian) |
| Zen | Gecko | Yes | Yes | MPL-2.0 | No (Firefox add-ons) | Active |
| Helium | Chromium | Partial (tabs, split) | Yes | GPL-3.0 | Yes | Beta, active |
| Thorium | Chromium | No (stock UI) | Yes | BSD-3-Clause | Yes | Active |
| Brave | Chromium | No | Yes | MPL-2.0 | Yes | Active |
| Vivaldi | Chromium | Partial (power UI) | UI closed | Proprietary UI | Yes | Active |
| Floorp | Gecko | Partial | Yes | MPL-2.0 | No (Firefox add-ons) | Active |
| SigmaOS | WebKit | Partial (tasks) | No | — | Yes (vendor claim) | Active |
| Horse | Chromium | No (Trails) | No | — | Yes (recent) | Active, paid |
| Nook | WebKit | Yes | Yes | GPL-3.0 | Partial (WebKit's support) | Active (2026-10), macOS 26 only |
| Aura | WebKit | Yes (iPad first) | Yes | MPL-2.0 | No | Archived (2025) |
| **Stedding** | Chromium | Yes (goal) | Yes | BSD-3-Clause | Yes (hard req.) | Beta (2026-10): signed macOS image, unsigned Windows preview |

Competitor claims in this section were fact-checked against vendor sources on
2026-08-30; Nook and Aura were read from their repositories on 2026-10-11. Rival products move; treat anything here as needing a re-check before it
is quoted, and prefer the vendor's own site over this table.

#### The competitor this table omits: Chromium itself

Chromium ships vertical tabs, since 153. Not an experiment — a landed feature with collapse,
pinning, drag-to-reorder, persisted width and state, a settings toggle, in-product help
promoting it to users, and interactive tests. `kVerticalTabsLaunch` is enabled by
default; only a user pref keeps it off. There is a separate expand-on-hover feature.
Verified in the tree at the 153 pin; details and file paths are in
`decisions/0010-ride-upstream-vertical-tabs.md`.

This matters more than any row above. The gap analysis below was written on the premise
that a sidebar with vertical tabs on Chromium, open source, was an empty cell. Upstream
has now filled part of it, and Chrome inherits it. What is *not* upstream is the rest of
the workflow model — workspaces, a command bar, split view as a first-class concept —
together with privacy defaults and who controls the roadmap.

Whether that is still enough to justify this project was a genuine question, and the
owner answered it in ADR 0011: full functional parity with Arc, plus what Arc could not
offer.

### The gap we occupy

Every cell combination above is taken except one. Users today can have:

- Arc's workflow UI, open source — **only on Gecko** (Zen, Floorp): lose Chrome
  extensions and Chromium web compatibility.
- Open-source, de-Googled Chromium — **only with a partial workflow UI** (Helium has
  vertical tabs and split view but no workspaces or command bar; Thorium keeps stock
  Chrome UI), or **with a crypto/ads business model attached** (Brave).
- The workflow UI on Chromium — **only closed source** (Arc, now unmaintained;
  Vivaldi's closed UI layer).

Stedding targets the empty cell: an Arc-style workflow browser that is
simultaneously **Chromium-based** (full Chrome extension compatibility, mainstream
web compatibility), **fully open source including the UI layer**, and
**permissively licensed** (BSD-3-Clause — auditable, forkable, embeddable, no
copyleft conditions). No other project on this list offers all three.

### Why users would not pick us today

Honesty section. As of 2026-10-19:

- **A beta.** The macOS image (Apple silicon only) is signed and notarized and updates
  itself from beta 16 on; the Windows x64 preview updates itself from beta 19 on but is not
  code-signed, so SmartScreen asks once. Every browser above ships an updating build on
  more platforms than we do; Zen and Brave ship polished products today.
- **No track record.** Keeping a Chromium fork current with security updates is a
  treadmill that has broken larger teams. Until we demonstrate months of on-time
  stable rebases, trusting us with your daily browsing is a leap.
- **No sync.** Google Sync is unavailable to Chromium forks (see PRIVACY.md), and
  Stedding runs no sync service: a Space moves between machines as a file.
  Multi-device users lose real functionality.
- **Small team, bus factor.** Brave has a company behind it; Zen has a large
  community. We have neither yet. The BSD license is the mitigation — anyone can
  pick up the work — but a license is not a maintainer.
- **No Linux and no Intel Mac yet.** Windows is a preview: no signing, and links from
  other applications open as tabs (`BACKLOG.md` S-56).

The bet is that the empty cell above is worth occupying anyway, and that shipping
complete, polished milestones (see "The quality bar" in `ROADMAP.md`) closes the trust
gap over time.
