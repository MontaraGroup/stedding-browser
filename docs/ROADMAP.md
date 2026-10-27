# Roadmap

Milestones from zero to 1.0. Each milestone ends in something installable and has
acceptance criteria a user can verify. A milestone is done when every criterion passes,
not when the code is merged.

**No dates.** This roadmap is a sequence, not a schedule. We do not promise dates, and
any date you find elsewhere is wrong. The order can change only via an ADR in
`docs/decisions/`.

The quality bar that applies to every milestone is set out in "The quality bar", at the end
of this page. "Installable" below always means: a fresh macOS user account can install
the artifact and run it without developer tools, without terminal commands, and without
reading build docs (Windows/Linux equivalents apply from M8/M9 on).

**Where this stands.** What is released is `docs/release-notes/` (and `gh release list`); what
is open is `BACKLOG.md`, whose rows name their milestone where it matters; what each feature
does today is its spec under `docs/features/`. The ladder was climbed out of order, chasing
feedback from real use (`docs/PROJECT-LOG.md`). The note under each milestone's heading says
what is left of it; this page keeps no table of open ids, because one went stale within days.
A beta named here by its number alone is one of the 0.2.0 betas; 0.3.0 beta 1 follows
0.2.0 beta 21.

---

## M0 — Reproduce a vanilla Chromium build (macOS arm64)

> **Done.** The pin moves by `tooling/update-pin --apply`, which syncs the checkout to it
> (ADR 0007); the Windows PC builds the same series since 2026-09-08 (M8).

**Goal:** prove we can build stock Chromium from source on macOS arm64, and document it
so any machine or agent can repeat it without tribal knowledge.

Scope:

- Check out and build Chromium stable channel source for macOS arm64.
- Pin the exact Chromium version, checkout method, `gn` args, and toolchain versions.
- Document every step — prerequisites, disk/RAM requirements, full command sequence,
  expected build time range on reference hardware, and known failure modes — in the
  build section of `docs/ARCHITECTURE.md`.
- Verify the result with `tooling/verify-build --app <path to the built Chromium.app>`,
  which is what checks the "launches, browses, plays video and WebGL" criterion below.
  That was a stock app at pin time. Today's `verify-build` expects a build from a
  Stedding args file (it requires H.264 and AAC, ADR 0008).
- Record the vanilla performance baselines defined in "The quality bar" below with
  `tooling/measure/harness.py`. These are the *vanilla* numbers; they become the
  baseline proper at M1, when Stedding is measured against them at the same pin.

Acceptance criteria:

- A second, clean machine (or wiped checkout) reproduces the build following only the
  written docs, with no undocumented steps.
- The resulting `Chromium.app` launches, browses, and plays video and WebGL content.
- The pinned Chromium version and full build configuration are committed to the repo.

## M1 — Branded minimal build, installable .dmg

> **Done, except the network criterion.** The build produces `Stedding.app` with our icon
> and bundle identifier `dev.stedding.Stedding`, `tooling/package-dmg` makes an installable
> image, the codec decision is ADR 0008 (accepted, `BACKLOG.md` S-18) and the performance
> baselines are in `docs/perf/README.md` (`S-13`, `S-31`, `S-37`). The first recorded
> idle-network run (2026-09-28, headless, about four and a half minutes, `docs/PRIVACY.md`)
> found three contacts the list lacked: network time, Google's push service (`S-54`) and
> the account check (`S-67`), both stopped since (patch 0030). The ten-minute run with a
> window followed on 2026-10-12; what it could not show is `S-50`.

**Goal:** the same browser, but ours: name, icons, defaults, and zero telemetry —
delivered as a .dmg a user can install.

Scope:

- Branding patch series: product name "Stedding", app icon, About page, bundle
  identifier, user agent policy (documented in an ADR — brand tokens in the UA are a
  compatibility trade-off).
- Default settings patch: no telemetry, no crash reporting to Google, no field trials,
  no promotional or sign-in prompts; privacy defaults per `docs/PRIVACY.md`.
- Network audit: enumerate every request a fresh profile makes on first run and idle,
  and document each one that remains (e.g. component/extension updates, safe browsing —
  each kept or removed per `docs/PRIVACY.md`).
- .dmg packaging (unsigned is acceptable at this milestone; signing lands at M7).
- Measure and commit the performance baselines against vanilla Chromium at the same
  pinned version (see "The quality bar" below — this replaces the TBD baselines).

Acceptance criteria:

- A user installs the .dmg by dragging to Applications and launches Stedding on a
  machine with no developer tools (Gatekeeper bypass is documented until M7 signing).
- App name, icon, and About page show Stedding, not Chromium.
- A network capture of first run and 10 minutes idle matches the documented request
  list — nothing unexplained, and no telemetry endpoints.
- Chrome Web Store works: a user installs an extension (e.g. uBlock Origin) and it runs.
- Performance baselines are committed and within the budgets in "The quality bar" below.

## M2 — Sidebar with vertical tabs (first public pre-alpha)

> **Done**, on Chromium's own vertical tabs (ADR 0010), and well past this scope since:
> folders (ADR 0013), Arc's pins, the rail, density and text size, and from beta 13 a sidebar
> that hides completely with the page edge to edge (`docs/features/sidebar.md` Y19). Released
> in beta 18 on Windows and beta 20 on the Mac: a tab on this computer's own server marked as
> Arc's Developer Mode marks it (`docs/features/local-tabs.md`, `S-117`). Patch 0077 adds
> folders in the pinned run (`docs/features/folders.md` F38, `S-107`) and Arc's way of
> closing a pin, which unloads it at its home (`docs/features/pins.md` H3).

**Goal:** the Arc-style sidebar replaces the horizontal tab strip. First build we
publish for strangers to try.

> **Since this was written, upstream shipped vertical tabs.** Chromium 153 has a
> landed `VerticalTabStripRegionView` with collapse, pinning, drag-reorder and
> persisted state, enabled by default behind a user pref. M2 therefore builds on it
> rather than replacing the tab strip — see
> `decisions/0010-ride-upstream-vertical-tabs.md`. That makes M2 much cheaper, and it
> means the sidebar by itself is no longer a differentiator. What still distinguishes
> Stedding is workspaces, the command bar, split view, privacy defaults and
> governance. ADR 0011 answers what that means for the product: full functional parity
> with Arc, plus what Arc could not offer.

Scope:

- Sidebar with vertical tabs: create, close, reorder (drag), pin, favicons, titles,
  audio indicator, and the `Space` preview specified in `docs/PRODUCT.md`. Hover
  previews are deliberately not listed: they are not in the product spec, and adding
  scope here rather than there is how a phantom requirement gets built.
- Collapse/expand the sidebar; toggle shortcut; state persists across restarts.
- Vertical tabs on by default: the `vertical_tabs.enabled` pref defaults on, so the
  sidebar replaces the horizontal strip; the switch back to horizontal tabs stays
  (`PLAN.md`, decision 1; `docs/PRODUCT.md`). Any
  look-and-feel divergence lives in a subclass in new files, never as edits to
  `browser_view.cc` or `vertical_tab_strip_region_view.cc` — 412 and 181 commits a
  year respectively.
- Keyboard: all existing Chromium tab shortcuts still work; sidebar-specific shortcuts
  documented in the shortcut reference.
- Pre-alpha release published on GitHub with known-issues list.

Acceptance criteria:

- Installable .dmg published as a GitHub pre-release.
- A user can do a full day of tab management (open, close, reorder, pin, switch by
  mouse and keyboard) using only the sidebar, with no crashes attributable to it.
- Sidebar state (width, collapsed, pinned tabs) survives quit and relaunch.
- The UX completeness definition in "The quality bar" below passes for the sidebar feature.

## M3 — Workspaces

> **Done** as Spaces (`docs/features/spaces.md`, ADR 0015, ADR 0016), each optionally with
> cookies of its own (ADR 0019). Released in 0.2.0 beta 18 on Windows and beta 20 on the Mac:
> the mark of a Space with cookies of its own wherever Stedding names it (`docs/features/sessions.md`
> S32–S34, `S-164`), and apps made from pages, which keep the session of the Space they were
> made in (`docs/features/web-apps.md`, ADR 0025, proposed; `docs/PRODUCT.md` §12 gives
> apps no tier yet, so they sit under no milestone).

**Goal:** separate contexts (work, personal, projects) with their own tab sets.

Scope:

- Create, rename, reorder, and delete workspaces; per-workspace icon/color.
- Each workspace has its own tab set in the sidebar; switching is instant and keyboard
  driven.
- Workspace-to-Chromium-profile mapping implemented as specified in
  `docs/PRODUCT.md` (one shared profile by default, optional per-space profile
  binding); the already-specified decision is recorded in an ADR.
- Tabs can be moved between workspaces.
- All workspace state persists across restarts and survives crashes.

Acceptance criteria:

- Installable .dmg published as a pre-release.
- A user maintains at least three workspaces for a day; every tab is in the workspace
  they left it in after quit, relaunch, and forced kill.
- Workspace switching works by mouse and by shortcut; shortcuts are documented.
- Deleting a workspace warns about its tabs and is undoable or explicitly confirmed.

## M4 — Command bar

> **Done** (`docs/features/commandbar.md`; K12, ⌘L's prefilled address, partial). The plan
> below had the bar replace the address bar; real use kept the address row instead -- the
> whole address always shown (toolbar T28 to T30) -- and ⌘L opens the bar with the address
> in it. With the address row hidden (a setting, off by default), the row's extension
> actions, media controls and page info are rows of the bar's actions mode, and ⌘E runs an
> extension (toolbar T13, T39, T40; commandbar K31–K33; `S-104`, 2026-10-20).

**Goal:** a keyboard-first launcher for navigation and browser actions.

Scope:

- Summonable command bar (default shortcut documented): open/switch tabs, search open
  tabs and history, navigate to URL, run browser commands (new tab, new workspace,
  toggle sidebar, etc.).
- Fuzzy matching; ranked results; full keyboard operation.
- Relationship to the omnibox implemented as specified in `docs/PRODUCT.md`. The bar
  was to replace the always-visible URL bar; the address row stayed (see the note above).
- Every sidebar and workspace action added so far is reachable from the command bar.

Acceptance criteria:

- Installable .dmg published as a pre-release.
- A user can switch tabs, open sites, and trigger every shipped Stedding feature
  without touching the mouse.
- Command bar opens in under the input-latency budget in "The quality bar" below.
- Escape always dismisses; no dead-end states.

## M5 — Split view

> **Partly done.** Chromium's own split view, with the sidebar's verbs acting on both panes
> (`docs/features/splits.md` J4). A split comes back whole after a restart through Chromium's
> own restore, and a pair the user unsplit stays apart (`RestoreTest.TheSidebarComesBack`,
> J1). A tab dragged onto the page makes a split with it (J10–J15, `S-113`, GitHub issue 7;
> released in 0.2.0 beta 21). Open (`BACKLOG.md` S-102): what ⌘W does on a split (J3,
> undecided), whether a Space pin that joins a split leaves the pinned run (J5), ⌘1–9
> counting a split once (J2), and the criteria below checked by hand. No ring is drawn around
> the panes (J6).

**Goal:** two pages side by side in one window.

Scope:

- Split a window into exactly two panes: create from sidebar, command bar, and drag.
  Three or more panes and grids are post-1.0 in `docs/PRODUCT.md` and are out of scope
  here; shipping them early would put an unspecified feature through the UX
  completeness gate.
- Resize divider; swap panes; close one pane back to single view; clear focused-pane
  indication (keyboard input, shortcuts, the address row and the command bar target
  the focused pane).
- Split state persists per workspace across restarts.

Acceptance criteria:

- Installable .dmg published as a pre-release.
- A user can create, resize, swap, and dismiss a split by mouse and keyboard, and both
  panes browse independently.
- Restoring a session restores splits exactly as left.
- No rendering artifacts or focus traps in split mode with DevTools, find-in-page, and
  fullscreen video.

## M6 — Settings, import, polish (public beta)

> **Done but for two things:** importing from Chrome, Brave and the new Edge (`PLAN.md`
> decision 8, `S-101`; Arc imports on the Mac and, since 0.3.0 beta 13, on Windows, `S-81`,
> and Dia, Safari's export file, Safari and Firefox import today) and the VoiceOver pass (`docs/history/plan-2026-09-26.md` WIN-3). Two planned rows of the Arc import
> are open too: Arc's splits and archived items, and a 400-tab import inside the budgets
> (`S-103`). Settings → Stedding reads in sections since beta 13 (settings T13).

**Goal:** everything shipped so far is configurable, discoverable, and complete; a
Chrome/Arc user can migrate in minutes. First build we call a beta.

Scope:

- Stedding settings surface: every Stedding feature has its settings entry (shortcuts,
  sidebar behavior, workspace options, command bar options), integrated with Chromium
  settings.
- Import from Chrome/Chromium-family browsers: bookmarks, history, passwords,
  extensions list, open tabs where feasible; explicit report of what did and did not
  import.
- Full pass of the UX completeness and accessibility gates in "The quality bar" below over
  M2–M5 features; fix or explicitly de-scope (ADR) everything that fails.
- Complete keyboard shortcut reference shipped in-product.
- A setting for URL elision. From beta 10 the address bar shows the whole address by
  default (Chromium's "Always show full URLs" on; toolbar T28, patch 0002), and its menu
  turns that off, which brings back Arc's bare host. Chrome tried the bare host and
  withdrew it, on the grounds that a user can misjudge a page from a host a long path
  would contradict. Stedding's is narrower -- the full URL returns on focus, and a bad
  certificate keeps it visible throughout -- and the choice belongs to the user. See
  patch 0002.
- Known-issues list triaged to zero release-blockers.

Acceptance criteria:

- Installable .dmg published as a public beta on GitHub.
- A Chrome user imports their profile and retains bookmarks, history, and passwords,
  with a visible summary of the result.
- Every shipped feature passes the UX completeness definition and the accessibility
  gates (VoiceOver, keyboard-only) in "The quality bar" below.
- A new user can discover and change every Stedding-specific behavior via settings and
  the command bar without reading the repo.

## M7 — Signed, notarized, auto-updating; site live

> **Mostly done on the Mac.** stedding.dev is live (2026-09-16), the macOS image is signed
> and notarized from beta 10 (`S-17`), and the Mac updates itself from beta 16 (`S-74`):
> beta 17 was the first release offered through the feed (2026-10-18), and a copy of the
> released beta 16 took it from the real feed, while the n-1 rehearsal showed the relaunch
> keeping the profile. Windows updates itself from beta 19 (ADR 0023, ADR 0026). Left: the rollback path
> tried for real, and updates on Linux (`S-216`).

**Goal:** distribution is production-grade: install with no warnings, update without
thinking, learn about it at stedding.dev.

Scope:

- Developer ID signing and Apple notarization in a reproducible release pipeline.
- Auto-update mechanism (updater choice recorded in an ADR), serving deltas or full
  updates over HTTPS; update checks contain no identifying data beyond what the
  updater strictly needs (documented in `docs/PRIVACY.md`).
- Update safety gates from "The quality bar" below: n-1 upgrade test and rollback path.
- stedding.dev live: download, release notes, source link, security policy. Done
  2026-09-16: the site lives in its own repository (`ysalitrynskyi/stedding.dev`,
  Astro, static, Cloudflare Pages) and is deliberately not on the path of an update
  check — see `decisions/0014-github-releases-as-update-channel.md`.
- Release checklist from "The quality bar" below adopted as the gate for every release from
  here on.

Acceptance criteria:

- A fresh macOS machine downloads from stedding.dev and installs with no Gatekeeper
  warnings or manual overrides.
- A machine running the previous release receives and applies the update automatically
  and relaunches into the new version with profile intact.
- The documented rollback path restores the previous version with profile intact.
- The release was produced by the documented pipeline and passes the full release
  checklist.

## M8 — Windows port

**Goal:** feature parity on Windows x64 with a native-quality installer and updates.

**Where this stands (2026-10-27):** an unsigned preview ships with each beta, and from 0.2.0
beta 19 it updates itself (`S-215`); betas 18 and 19 of 0.2.0 were Windows only, and from
beta 20 each release carries both platforms. Both suites passed with DCHECKs and the
dangling-pointer detector on and under AddressSanitizer on 2026-09-30; with DCHECKs and the
detector again on the series through patch 0061 on 2026-10-11, after one fix, and on the
current pin on 2026-10-17, after one more, but for `S-214`, fixed since. Under
AddressSanitizer, on the series through 0070 on 2026-10-18, the unit suite was clean and
the browser suite had one report, a test's own, fixed in 0071, and one failure still open
(`S-226`; `S-106`). From beta 19 each
Windows release carries a version of its own and updates itself (`S-72`, `S-215`). Built so
far: the series and the Stedding window on Windows (round 8, patch 0039); branding -- the
name, the icon, `%LOCALAPPDATA%\Stedding`, Stedding's own registry keys, COM classes and
sandbox prefix (N3–N4) -- and Chromium's `mini_installer` from the `win-release`
configuration (ADR 0018), a preview since beta 5 (N6); Arc's keyboard for Windows (N7,
patch 0043); little windows for links from other applications, since 0.3.0 beta 7
(`docs/features/little.md` E10); importing from Arc, since 0.3.0 beta 13 (`S-81`). Not done:
signing and SmartScreen, CI, Windows performance budgets, and a two-finger Space swipe that follows the fingers: a touchpad's
sideways scroll steps one Space instead (`docs/features/spaces.md` B39;
`docs/history/plan-2026-09-26.md` TAB-31). `BACKLOG.md` S-56.

Scope:

- Windows build of the full patch series; platform-appropriate shortcuts and window
  chrome; installer (format recorded in an ADR); code signing; auto-update on Windows.
- CI or documented reproducible build path for Windows releases.
- Windows-specific pass of the quality gates, including performance budgets re-measured
  against vanilla Chromium on Windows.

Acceptance criteria:

- A signed Windows installer is published; SmartScreen state is documented honestly.
- All shipped features (M2–M6) work on Windows and pass the same acceptance criteria
  as their macOS milestones.
- Auto-update from the previous Windows release works, with the same n-1 and rollback
  gates as M7.

## M9 — Linux port

**Goal:** feature parity on Linux x64 with maintainable packaging.

Scope:

- Linux build of the full patch series; package formats chosen and recorded in an ADR
  (e.g. .deb/.rpm/Flatpak/AppImage — decided then, not promised now); update story per
  format.
- Linux-specific pass of the quality gates, including performance budgets re-measured
  on Linux.

Acceptance criteria:

- At least one supported package format installs and runs on a clean install of a
  named mainstream distribution, following only the published instructions.
- All shipped features work and pass their acceptance criteria on Linux.
- The update story for each supported format is documented and tested.

## M10 — Beyond parity

> **Partly released.** 0.3.0 beta 16 brought ad and tracker blocking's first phase (`S-88`,
> off by default), clean links (`S-89`), shortcuts the user can change (`S-91`), the rebuilt
> Peek (`S-93`), the sidebar on the right (`S-96`), History and Downloads in the sidebar
> (`S-98`), import from Dia and Safari's export file (`S-101`) and the site controls panel in
> part (`S-118`). Left: a web app's chords (`S-90`), Back returning to a child tab's opener
> (`S-92`), "Show here / Go to window" (`S-94`), the mini player (`S-95`), the Chrome-family
> importer, and the later slices of blocking; `BACKLOG.md` has each one's state.

**Goal:** what Arc never had, and what two newer Arc-style browsers showed people want:
Nook and Aura, read on 2026-10-11 (`docs/VISION.md`, "Competitors"). Their code is not used -- Swift
on WebKit, under GPL-3.0 and MPL-2.0 -- and their behaviours are rebuilt from written
descriptions (ADR 0021). M10 runs alongside M8 and M9: each item stands alone, lands behind
its own spec rows and the quality bar, and its order is `BACKLOG.md`'s. Built-in AI stays
out (ADR 0020).

Scope, by area (`BACKLOG.md` ids):

- **Privacy:** ad and tracker blocking built in, with a switch per site (`S-88`; its own ADR
  first: the engine, and filter lists fetched at run time, never built in); tracking
  parameters stripped from every link opened, not only from a copied one (`S-89`); dark mode
  for web pages on Chromium's own (`S-100`, `features/dark-pages.md`; released in 0.2.0
  beta 18 on Windows and beta 20 on the Mac).
- **Keyboard:** a web app that binds the same chord gets the first press and Stedding the
  second (`S-90`); shortcuts the user can change, with a conflict check (`S-91`, the 1.0 item
  `docs/PRODUCT.md` §12 names).
- **Tabs:** child tabs under their opener, Back returning to it (`S-92`); Undo after closing
  tabs (`S-97`, built in beta 14); a page open in another window offers
  "Show here / Go to window" (`S-94`).
- **Sidebar:** on the right, as a setting (`S-96`); History and Downloads as panels in its
  column (`S-98`); the mini player for a video you leave (`S-95`); Space colours and icons
  freely chosen (`S-99`).
- **Pages:** Peek rebuilt, with little windows, on one primitive: a page that is a full tab
  but for its place and becomes one without reloading (`S-93`).
- **Import:** Dia's sidebar and Safari's export file, with Phase 2's Chrome-family importer
  (`S-101`).
- **Smaller things from Nook** (a second read of its code, 2026-10-11): the site's controls
  in one panel from the address row (`S-118`); clear a site's cookies and reload (`S-119`);
  folder verbs (`S-120`); a pin's home address edited by hand (`S-121`); mute and picture in
  picture by key (`S-122`); a resize bar on the sidebar's edge and a double click to reset
  it (`S-123`); the page flush against the window with the sidebar open (`S-124`); a handful
  of small conveniences (`S-125`). `S-119` to `S-124` and three of `S-125`'s conveniences
  are built in beta 14.

The same read found Arc behaviour that `docs/PRODUCT.md` puts at 1.0 with no item until
then; those sit under their own milestones above, not here: folders in the pinned run
(`S-107`, built in patch 0077 but for the Arc importer), inline completion and Site Search
in the command bar (`S-108`, `S-109`, both built in 0.2.0 beta 14), loading only the
selected tab at launch (`S-110`), tabs sleeping on a timer (`S-111`), the tab selected
after a close (`S-112`) and a split made by dragging a row onto the page (`S-113`), those
four released in 0.2.0 beta 21, and routing rules edited in Settings (`S-126`). What was read and left out, and why, is in ADR
0021.

Acceptance criteria:

- Each item meets its feature spec's rows on both supported platforms, with tests that
  failed before it was built, and the UX completeness definition in "The quality bar" below.
- With blocking on, a fresh profile's idle-network list in `docs/PRIVACY.md` gains only the
  filter-list fetches its ADR names; a site broken by it is fixed by its switch in one click.
- Nothing in the series derives from Nook's or Aura's files (ADR 0021).

## 1.0 — Quality gate

**Goal:** nothing new. 1.0 is a claim about quality, not a feature.

Acceptance criteria:

- Every gate in "The quality bar" below is green on every supported platform, verified
  against the current release, with evidence (measurements, test runs, checklist
  records) linked from the release notes.
- No open release-blocker issues.
- The Chromium base is current stable, and the security-update gate in
  "The quality bar" below has been met for the preceding releases.

---

## Out of scope for this ladder

Mobile, built-in AI features, sync services, and paid add-ons are not on the path to
1.0. Any of them entering the roadmap requires an ADR and a roadmap revision. ADR 0020 keeps
models out for good; the AI features Nook and Aura carry (a sidebar chat, a tab organizer,
an agent-control server, "Browse for Me") are not taken (ADR 0021).

## Build order, and why

The milestone order below predates any evidence about what Arc switchers actually want.
`docs/AGENT-LOOP.md` ("Evidence") gathers that evidence from the tracker of a comparable
project. Two things
in it change how these milestones should be built rather than what is in them:

- **Session restore belongs inside the sidebar milestone, not after it.** The largest
  bug cluster on the comparable project is tab identity across windows, spaces and
  favorites — restore duplicating favorites, moving a favorite between windows silently
  un-favoriting it. Build the persistence model with the tab model.
- **Folders are a gate, not a nicety** (412 upvotes, and named as the thing keeping
  people on Arc). They belong with the sidebar, not in a later polish pass.

## Deferred, with the intent to return

Real Arc features that are specified in `PRODUCT.md` and deliberately not in the first
releases. Listed here so they are visible as future work rather than quietly missing.

| Feature | Why deferred | What brings it back |
|---|---|---|
| **Boosts** (per-site CSS/JS, Zap) | Extensions already answer it — Stylus, Violentmonkey, uBlock's element picker — and full extension support is a hard requirement we keep regardless. It is also a script host, so it carries security work nothing else here does. | The workflow features ship and meet the quality bar, *and* a threat model exists. The threat model comes first, not alongside. Aura's editor is the model then: a live preview while typing, a switch per site in the page menu (ADR 0021). |
| **Easels** (whiteboards) | A drawing application inside a browser, and the single largest item in `PRODUCT.md`. Almost nothing to do with browsing. | Capacity after the features people actually stay in Arc for, or evidence users want it. |

Deferred is not cancelled. Both remain specified in `PRODUCT.md`; see
`decisions/0012-defer-boosts-and-easels.md` for the reasoning and the conditions.

Page capture is **not** deferred — captures are useful with or without a canvas.

## The quality bar

This section defines what "ready to use" means for Stedding, as verifiable gates.
A gate is either green (the check passed, with evidence) or red. There is no "mostly".
Aspirations that cannot be checked do not belong here.

These gates apply per release. The milestones above say when each gate
starts applying; from that point it applies to every subsequent release. 1.0 requires
all of them green on all supported platforms.

Several gates below have no tooling or record yet, and each says so. Until it has
both, such a gate is a target, not a check, and no release may be described as
passing it.

### Performance budgets (relative to vanilla Chromium)

Measured with `tooling/measure/harness.py all --sites local` against a vanilla build at
the same pin; the live list (`--sites live`) serves only the two absolute budgets.
Current numbers: `docs/perf/README.md`.

Stedding is Chromium plus patches, so performance is measured as **overhead relative to
vanilla Chromium at the same pinned version, same build configuration, same hardware**.
Absolute numbers depend on hardware and are not promised; the overhead budgets are.

The budgets are re-measured whenever the Chromium base version changes and on each new
platform (M8, M9). The one measurement so far is from 2026-09-02, on the Mac: the series
of 8 patches as it was then, on 153.0.8010.12, in the `official` configuration, against
vanilla Chromium at the same pin (`docs/perf/README.md`). The pin and the series have
moved since and nothing has been re-measured, so no current build has a number. The
harness takes a macOS app bundle; Windows has no measurement yet (M8, above).

| Metric | Method | Budget vs. vanilla |
|---|---|---|
| Cold startup to usable window | Median of 10 runs, fresh profile, timed launch to first accepted input | ≤ 10% overhead |
| Warm startup | Median of 10 runs, existing profile with 10 restored tabs | ≤ 10% overhead |
| Memory, 10-tab session | Physical footprint summed over the browser process tree after loading the fixed 10-site list and idling 60 s, median of 5 runs | ≤ 10% overhead |
| Input latency, tab switch via sidebar | Keypress/click to target tab painted, median of 20 switches | ≤ 16 ms added over vanilla tab-strip switch |
| Command bar open | Shortcut press to bar rendered and accepting input, median of 20 | ≤ 100 ms absolute |
| Page load / rendering | Identical to vanilla | No measurable regression: the series patches no renderer code, and its few hunks in the network stack are listed in `docs/ARCHITECTURE.md` ("Where patches are allowed to live") |

The measurement harness is `tooling/measure/harness.py` and the ten-site list is
`tooling/measure/sites.txt`, so anyone can reproduce the numbers:

```bash
tooling/measure/harness.py all --sites local --app ~/chromium/src/out/vanilla/Chromium.app --out vanilla.json
tooling/measure/harness.py all --sites local --app ~/chromium/src/out/official/Stedding.app --out stedding.json
```

Two practical notes before running it. Measure the **`official`** build, not `release`:
the release configuration skips PGO and LTO. Published images so far come from
`release` (`tooling/publish-release` packages it), so these numbers are not the shipped
build's; which configuration should ship is TBD (`BACKLOG.md` S-168). And a full run with `--sites live`
takes tens of minutes and needs working network — ten cold launches, ten warm, and five
memory runs that each load the ten live sites in `tooling/measure/sites.txt` and idle
for a minute; without network the memory and warm legs fail, and the harness will tell
you so rather than publish a median over whatever survived. `--sites local` runs
offline.

Two things about the harness are worth knowing before quoting anything it prints.
It measures launch to **first painted frame** of a trivial local page — the browser
cannot accept input into a page it has not painted, which is the operational reading
of "launch to first accepted input". And it discards one warmup launch: the very first
run of a binary also pays to fault the executable into the OS page cache, a cost paid
once per machine rather than once per browser start, and large enough to swamp the
overhead the budgets are trying to detect.

Memory is summed **physical footprint**, not RSS. macOS reports several memory numbers
that disagree by a factor of three: summing `ps` RSS counts every shared page once per
process, which on a three-tab session measured 9599 MB against a real cost of 3104 MB.
Physical footprint is what Activity Monitor reports, and the harness reads it via
`proc_pid_rusage`, which agrees with `vmmap --summary` exactly. It is summed over the
launched process and its descendants — not over every process running from the app
bundle, which on a machine where anything else is driving a copy of the same browser
silently counts that too.

Expect a three-figure process count: with site isolation, an ad-heavy news page alone
contributes a process per cross-origin iframe. The harness reports the count alongside
the total, because a count that moves between two builds is itself a finding.

Sidebar tab switching and the command bar ship, but the harness has no measurement for
them yet, so both budgets are TBD; they are added to the harness rather than stubbed.

A budget miss is a release blocker; either the regression is fixed or the
budget is changed by ADR with the reasoning on record.

### Stability

- **Crash-free sessions:** because there is no telemetry, we cannot measure a fleet
  crash rate — we do not fabricate one. The gate is local and reproducible: a scripted
  8-hour soak (tab churn across workspaces, splits, command bar use, restarts) completes
  with zero browser-process crashes, and any UI-process crash reported by a user with
  reproduction steps is a release blocker until fixed or shown to be upstream. No
  soak script exists yet.
- **No data loss on crash:** kill all browser processes (`SIGKILL`) during active use;
  on relaunch, session restore recovers all Spaces, tabs, splits, and sidebar
  state as of a few seconds before the kill. To be tested before every release; there
  is no script or record of it yet. Restarts and restores are covered by browser tests
  with `PRE_` steps and by real use (`docs/features/spaces.md` B9).
- **No data loss on upgrade:** covered under update safety below.
- **Unit tests keep out of the user's data folder:** `unit_tests` run on a user-data
  folder of their own in the system's temporary folder (`chrome::DIR_USER_DATA`), which
  the test process deletes when it ends, and the processes a test starts (a death test's
  child) use the same folder, only if it is one a test process made
  (`ChromeUnitTestSuite`; `ChromePaths.UnitTestsKeepOutOfThePersonsDataFolder`,
  `ChromePaths.UnitTestsTakeOnlyATestFolderFromTheEnvironment`). Before, a test's profile
  lived in the real data folder while it ran and stayed there when the test crashed
  (BACKLOG S-220). The other test binaries are not changed. `tooling/dev test` fails a
  run that leaves a test's folder at the top level of Stedding's or Chromium's data
  folder, and names, without deleting, what an earlier run left there; it does not look
  inside the profiles. A test process that is killed or crashes still leaves its own
  folder in the system's temporary folder: on Windows the test launcher deletes it with
  the process's temporary folder, and on the Mac nothing reports or deletes it.
- Chromium's own recovery surfaces ("Restore pages?") must work, not be patched into
  a broken state.

### UX completeness — the definition of "shipped"

A feature is shipped only when all of the following exist. A feature missing any of
them is not shipped, regardless of merge state.

1. **Keyboard shortcuts** for its primary actions, listed in the in-product shortcut
   reference, not conflicting with each other or with Chromium shortcuts that
   `docs/PRODUCT.md` does not deliberately remap; every deliberate remap is listed
   in the shortcut reference.
2. **Settings entry** for every behavior a reasonable user would want to change,
   discoverable in settings search and the command bar.
3. **Edge cases handled:** 0 items, 1 item, hundreds of items; extreme window sizes;
   fullscreen; multiple windows and displays; RTL text where user content is shown.
4. **Empty states** designed — a new Space, an empty sidebar, no command bar
   matches — with wording per `docs/VISION.md` ("Brand and voice"), never a blank panel.
5. **Interruptions survive:** the feature behaves sanely across restart, crash
   recovery, and update.
6. **Documented:** covered in the feature's spec (`docs/features/`), the user pages it
   changes (README, SHORTCUTS, FAQ) and the release notes.

The verification is a written checklist pass per feature per release, recorded with
the release. No release has stored one yet; each feature spec's rows and their tests
are the record so far.

### Accessibility

- **VoiceOver:** every Stedding surface (sidebar, Spaces, command bar, split
  controls, settings) is navigable and operable with VoiceOver: elements have correct
  roles and labels, focus is announced, no unreachable controls. Verified by a scripted
  VoiceOver walkthrough per release. Not yet done for any release (`S-129`, `docs/history/plan-2026-09-26.md` WIN-3).
- **Full keyboard navigation:** every action available by mouse is available by
  keyboard; focus is always visible; no focus traps. Verified by completing the UX
  walkthrough with the mouse disconnected.
- **Contrast and scaling:** Stedding UI meets WCAG 2.1 AA contrast; respects system
  "increase contrast" and "reduce motion"; remains usable at 200% display scaling.
- Chromium's existing accessibility must not regress: our patches may not break what
  upstream already does right.

### Update safety

Applies from M7 (first auto-updating release) onward.

- **n-1 upgrade tested:** before publishing version N, a machine running N-1 with a
  populated profile (Spaces, splits, pinned tabs, extensions, passwords) receives
  the update through the real update channel, applies it, and relaunches with all
  state intact. This test is part of the release checklist, not optional.
- **Skip-version upgrade:** the updater handles a user who missed releases (oldest
  supported direct-upgrade version is documented).
- **Rollback path:** a documented, tested procedure returns a user from N to N-1 with
  profile intact (or with an explicitly documented, bounded loss if a profile
  migration is one-way — such migrations require an ADR).
- **Update transparency:** what the updater sends and how often is documented in
  `docs/PRIVACY.md`; no identifiers beyond what the update mechanism strictly needs.
- A failed or interrupted update leaves the installed version working.

How it works on the Mac (ADR 0022, `docs/features/updates.md`):

- **The channel.** `tooling/publish-appcast` offers a release by putting its image, signed
  with the project's EdDSA key, first in `updates/appcast.xml`, then signing the feed. A
  release that is published but not offered reaches nobody automatically: offering is the
  last step, after the release has been tried as a user gets it.
- **The n-1 check.** Two builds signed the same way, the older installed with a used
  profile, the newer offered from a local feed: the older finds it, downloads it, shows the
  sidebar's button, restarts into the newer one with the session and the profile intact
  (`docs/HANDOFF.md`, "The updater"). For a release, the same with the previous release
  and the real feed.
- **Skipping versions.** The feed keeps the newest five releases and Sparkle takes the
  newest one the Mac's system can run, so any earlier version with the updater (0.2.0 beta 16
  and every release after it) goes straight to the latest.
- **Rolling back.** Sparkle never installs an older version over a newer one. To take a
  bad release back: take it out of the feed at once (`git revert` of its "offer" commit,
  pushed), so nobody else is offered it, then release the fix as a later version and offer
  that. The previous image can be installed over the bad one by hand (`docs/INSTALL.md`),
  but a profile a newer Chromium has opened is not promised to open in an older one: that is
  why the way back is a later version. A version that changes the profile's format one way
  needs an ADR before it ships, as above.

### Security

- **Upstream security bumps:** when Chromium stable ships a security update, Stedding
  ships a rebased release within **7 days** for actively exploited (in-the-wild)
  fixes and within **14 days** otherwise. The gate is checked per upstream release;
  misses are recorded publicly in the release notes with reasons. This is the standing
  cost of running a fork — the patch series and build pipeline are designed around it.
- **The clock is started by a machine, not by remembering.** `tooling/check-pin` asks
  daily whether the pin is still current and the `upstream` workflow opens one tracking
  issue while it is not (`.github/workflows/upstream.yml`). It reads stable on every
  desktop platform, because a point release on the milestone we ship reaches the others
  at the same time and a pulled macOS rollout would otherwise hide it. A deadline whose
  alarm can fail silently is not a deadline: the first version of that check spent four
  days red without ever filing the issue.
- **No bundled analytics or tracking SDKs.** Zero third-party analytics, crash
  reporting to third parties, advertising, or attribution SDKs in the product.
  Verifiable by dependency audit and by the network capture gate below.
- **Network conduct:** each release re-runs the M1-style network audit — every request
  from a fresh profile at first run and idle matches the documented list in
  `docs/PRIVACY.md`. An unexplained endpoint is a release blocker.
- **Signed releases only** (from M7; on Windows from M8): every published artifact is
  signed (and notarized on macOS); checksums published with the release. The macOS image
  is signed and notarized from 0.2.0 beta 10; the Windows installer is not signed yet
  (`BACKLOG.md` S-56).
- Vulnerability reports handled per `SECURITY.md`.

### Release checklist

Every public release, from M7 on, ships only after each item is checked off and the
completed checklist is stored with the release records. Pre-M7 releases use the
applicable subset. So far each beta's release notes record what was checked ("How it
was checked"); no complete checklist has been stored with a release yet. Before any
public 1.0 release, the codec licence terms are recorded per
`decisions/0008-proprietary-codecs.md` (in a superseding ADR).

1. Chromium base is current stable, or the divergence is stated in release notes.
2. Full patch series applies cleanly; build is reproducible from the documented steps.
3. Performance budgets re-verified if the base version or platform changed.
4. Stability gates pass: soak run, kill-and-restore test.
5. UX completeness checklist passes for every shipped feature.
6. Accessibility walkthroughs (VoiceOver, keyboard-only) pass.
7. Network audit matches the documented request list.
8. Artifact signed; notarized (macOS); checksums generated.
9. n-1 auto-update tested end-to-end on a real machine.
10. Rollback procedure verified against this release.
11. Changelog written: user-facing changes, known issues, Chromium base version.
12. Git tag created, matching the released artifact; release published with checksums
    and changelog.
13. Used for real on the platform being released, from the installer a user gets: a fresh
    profile, the first launch and its welcome flow, light and dark, a click on every kind of
    row, the gestures the specs name, with the real pointer and keyboard
    (`docs/AGENT-LOOP.md`, "Real use, safely"). Every suite passed the build that first had
    this done to it and five faults were on screen (`docs/HANDOFF.md`, trap 58).
    The core-loop script in `docs/features/acceptance.md` passes on that build, on each
    platform released, and the run is recorded in that file's table; a failed step gets a
    BACKLOG row and a failing test before the release goes out.
14. Both suites clean with DCHECKs and the dangling-pointer detector on
    (`STEDDING_TEST_OUT=win-checks tooling/dev test all --no-build` on Windows,
    `STEDDING_TEST_OUT=mac-checks` on the Mac), and the
    lifetime suites clean under ASan. A build that stops at its first window on a DCHECK has
    a defect whatever the release build does with it (trap 60).

If any item fails, the release does not go out. There are no exceptions that are not
written down as an ADR.
