# Roadmap

Milestones from zero to 1.0. Each milestone ends in something installable and has
acceptance criteria a user can verify. A milestone is done when every criterion passes,
not when the code is merged.

**No dates.** This roadmap is a sequence, not a schedule. We do not promise dates, and
any date you find elsewhere is wrong. The order can change only via an ADR in
`docs/decisions/`.

The quality bar that applies to every milestone lives in `docs/QUALITY.md`. "Installable"
below always means: a fresh macOS user account can install the artifact and run it
without developer tools, without terminal commands, and without reading build docs
(Windows/Linux equivalents apply from M8/M9 on).

**Where this stands (2026-10-12):** the current release is `v0.2.0-beta.14` on Chromium
155.0.8059.12, a Windows x64 preview (unsigned) out first, its macOS image to follow from
the Mac; until it does, beta 12's macOS image (Apple silicon, signed and notarized, as every
macOS image is from beta 10 on) is the newest one. The ladder was climbed out of order,
chasing feedback from real use (`docs/ARC-ROUND2.md`), and each feature's own spec under
`docs/features/` is the record of what passes. `PLAN.md` is the finish-or-cut pass over the
features of M2 to M6 that the 2026-09-26 audit asked for; its items keep their own ids there
and are not repeated here. Beta 14's patches 0060 and 0061 closed sixteen `BACKLOG.md` ids
and three parts of `S-125` (BACKLOG's Done table). In short, with every open `BACKLOG.md` id
under the milestone it belongs to:

| Milestone | State | Open in `BACKLOG.md` |
|---|---|---|
| M0 vanilla build | Done | -- |
| M1 branded build | Done, except the recorded ten-minute idle-network run and two calls to Google a fresh profile makes unasked; Safe Browsing does not work without a key | `S-50`, `S-54`, `S-67`, `S-75` |
| M2 sidebar | Done, and past it: three forms (open, a rail of icons, hidden), density and text size, folders, pins | `S-65` (fixed; the owner's confirmation), `S-107` (folders in the pinned run), `S-111`, `S-112`, `S-115` |
| M3 workspaces (Spaces) | Done, with independent cookie jars per Space (ADR 0019) | `S-70`, `S-126` |
| M4 command bar | Done but K12 (⌘L's prefilled address, partial); the address row stayed beside it | `S-104`, `S-127` |
| M5 split view | Partly: Chromium's own split view, with Stedding's verbs on both panes; a split comes back whole after a restart (J1); ⌘W on a split (J3), a pin joining a split (J5) and ⌘1–9 counting a split once (J2) are open | `S-102`, `S-113` |
| M6 settings, import, polish | Done but for importing from Chrome, Brave and the new Edge (`PLAN.md` decision 8, Phase 2) and the VoiceOver pass (`PLAN.md` WIN-3) | `S-48`, `S-51`, `S-57`, `S-69`, `S-79`, `S-103`, `S-110`, `S-117`, `S-134` |
| M7 signed, updating, site | The site (https://stedding.dev) and the Mac's signing are done; automatic updates are next, the Mac first | `S-74`, `S-49`, `S-59` |
| M8 Windows | A preview with every feature, Arc's keys for Windows and a per-user installer; little windows, signing, updates and CI open | `S-56`, `S-55`, `S-71`, `S-72`, `S-81` |
| M9 Linux | Not started; there is no Intel Mac build either | -- |
| M10 beyond parity | Added 2026-10-11 (ADR 0021): the ideas taken from Nook and Aura; seven of them, and three parts of `S-125`, built in beta 14 | `S-88` to `S-96`, `S-98` to `S-101`, `S-118`, `S-125` |
| 1.0 quality gate | Not reached | `S-61` (the rows `docs/PRODUCT.md` marks [1.0] that no milestone names: the Library, the mini player), `S-66`, `S-106`, `S-128`, `S-129` (spec rows short of a test or a look) |

Outside the ladder: `S-47` (a capture probe), `S-58` (the Mac's disk) and `S-105` (the macOS
image of betas 13 and 14, a release step).

---

## M0 — Reproduce a vanilla Chromium build (macOS arm64)

> **Done.** The pin moves by `tooling/sync-chromium` (ADR 0007); the Windows PC
> builds the same series since 2026-09-08 (M8).

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
- Record the vanilla performance baselines defined in `docs/QUALITY.md` with
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
> the account check (`S-67`). The ten-minute run with a window is `S-50`.

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
  pinned version (see `docs/QUALITY.md` — this replaces the TBD baselines).

Acceptance criteria:

- A user installs the .dmg by dragging to Applications and launches Stedding on a
  machine with no developer tools (Gatekeeper bypass is documented until M7 signing).
- App name, icon, and About page show Stedding, not Chromium.
- A network capture of first run and 10 minutes idle matches the documented request
  list — nothing unexplained, and no telemetry endpoints.
- Chrome Web Store works: a user installs an extension (e.g. uBlock Origin) and it runs.
- Performance baselines are committed and within the budgets in `docs/QUALITY.md`.

## M2 — Sidebar with vertical tabs (first public pre-alpha)

> **Done**, on Chromium's own vertical tabs (ADR 0010), and well past this scope since:
> folders (ADR 0013), Arc's pins, the rail, density and text size, and from beta 13 a sidebar
> that hides completely with the page edge to edge (`docs/features/sidebar.md` Y19).

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
  sidebar fully replaces the horizontal strip as specified in `docs/PRODUCT.md`. Any
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
- The UX completeness definition in `docs/QUALITY.md` passes for the sidebar feature.

## M3 — Workspaces

> **Done** as Spaces (`docs/features/spaces.md`, ADR 0015, ADR 0016), each optionally with
> cookies of its own (ADR 0019).

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
> actions, media button and page info are not in the bar yet (toolbar T13, `S-104`).

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
- Command bar opens in under the input-latency budget in `docs/QUALITY.md`.
- Escape always dismisses; no dead-end states.

## M5 — Split view

> **Partly done.** Chromium's own split view, with the sidebar's verbs acting on both panes
> (`docs/features/splits.md` J4). A split comes back whole after a restart through Chromium's
> own restore, and a pair the user unsplit stays apart (`RestoreTest.TheSidebarComesBack`,
> J1). Open (`BACKLOG.md` S-102): what ⌘W does on a split (J3, undecided), whether a Space pin
> that joins a split leaves the pinned run (J5), ⌘1–9 counting a split once (J2), and the
> criteria below checked by hand. No ring is drawn around the panes (J6).

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
> decision 8, Phase 2; Arc, Safari and Firefox import today on the Mac, and Arc is the Mac's
> alone, `S-81`) and the VoiceOver pass (`PLAN.md` WIN-3). Two planned rows of the Arc import
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
- Full pass of `docs/QUALITY.md` UX completeness and accessibility gates over M2–M5
  features; fix or explicitly de-scope (ADR) everything that fails.
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
  gates (VoiceOver, keyboard-only) in `docs/QUALITY.md`.
- A new user can discover and change every Stedding-specific behavior via settings and
  the command bar without reading the repo.

## M7 — Signed, notarized, auto-updating; site live

> **Half done.** stedding.dev is live (2026-09-16) and the macOS image is signed and
> notarized from beta 10 (`S-17`). Automatic updates are next, the Mac first (`S-74`), with
> the n-1 and rollback gates below.

**Goal:** distribution is production-grade: install with no warnings, update without
thinking, learn about it at stedding.dev.

Scope:

- Developer ID signing and Apple notarization in a reproducible release pipeline.
- Auto-update mechanism (updater choice recorded in an ADR), serving deltas or full
  updates over HTTPS; update checks contain no identifying data beyond what the
  updater strictly needs (documented in `docs/PRIVACY.md`).
- Update safety gates from `docs/QUALITY.md`: n-1 upgrade test and rollback path.
- stedding.dev live: download, release notes, source link, security policy. Done
  2026-09-16: the site lives in its own repository (`ysalitrynskyi/stedding.dev`,
  Astro, static, Cloudflare Pages) and is deliberately not on the path of an update
  check — see `decisions/0014-github-releases-as-update-channel.md`.
- Release checklist from `docs/QUALITY.md` adopted as the gate for every release from
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

**Where this stands (2026-10-12):** the preview ships with beta 14 on 155.0.8059.12. Both
suites passed with DCHECKs and the dangling-pointer detector on and under AddressSanitizer
on 2026-09-30, and with DCHECKs and the detector again on the series through patch 0061 on
2026-10-11, after one fix; ASan has not run on 0058 to 0061 yet (`S-106`). A second release
on one Chromium number installs as a repair that needs Stedding closed (`S-72`). Built so
far: the series and the Stedding window on Windows (round 8, patch 0039); branding -- the
name, the icon, `%LOCALAPPDATA%\Stedding`, Stedding's own registry keys, COM classes and
sandbox prefix (N3–N4) -- and Chromium's `mini_installer` from the `win-release`
configuration (ADR 0018), a preview since beta 5 (N6); Arc's keyboard for Windows (N7,
patch 0043). Not done: little windows and links from other applications, signing and
SmartScreen, updates, CI, Windows performance budgets, and importing from Arc for Windows
(`BACKLOG.md` S-81). `BACKLOG.md` S-56.

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

**Goal:** what Arc never had, and what two newer Arc-style browsers showed people want:
Nook and Aura, read on 2026-10-11 (`docs/COMPETITORS.md`). Their code is not used -- Swift
on WebKit, under GPL-3.0 and MPL-2.0 -- and their behaviours are rebuilt from written
descriptions (ADR 0021). M10 runs alongside M8 and M9: each item stands alone, lands behind
its own spec rows and the quality bar, and its order is `BACKLOG.md`'s. Built-in AI stays
out (ADR 0020).

Scope, by area (`BACKLOG.md` ids):

- **Privacy:** ad and tracker blocking built in, with a switch per site (`S-88`; its own ADR
  first: the engine, and filter lists fetched at run time, never built in); tracking
  parameters stripped from every link opened, not only from a copied one (`S-89`); dark mode
  for web pages on Chromium's own (`S-100`).
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
(`S-107`), inline completion and Site Search in the command bar (`S-108`, `S-109`, both
built in beta 14), loading only the selected tab at launch (`S-110`), tabs sleeping on a
timer (`S-111`), the tab
selected after a close (`S-112`), a split made by dragging a row onto the page (`S-113`), and
routing rules edited in Settings (`S-126`). What was read and left out, and why, is in ADR
0021.

Acceptance criteria:

- Each item meets its feature spec's rows on both supported platforms, with tests that
  failed before it was built, and the UX completeness definition in `docs/QUALITY.md`.
- With blocking on, a fresh profile's idle-network list in `docs/PRIVACY.md` gains only the
  filter-list fetches its ADR names; a site broken by it is fixed by its switch in one click.
- Nothing in the series derives from Nook's or Aura's files (ADR 0021).

## 1.0 — Quality gate

**Goal:** nothing new. 1.0 is a claim about quality, not a feature.

Acceptance criteria:

- Every gate in `docs/QUALITY.md` is green on every supported platform, verified
  against the current release, with evidence (measurements, test runs, checklist
  records) linked from the release notes.
- No open release-blocker issues.
- The Chromium base is current stable, and the security-update gate in
  `docs/QUALITY.md` has been met for the preceding releases.

---

## Out of scope for this ladder

Mobile, built-in AI features, sync services, and paid add-ons are not on the path to
1.0. Any of them entering the roadmap requires an ADR and a roadmap revision. ADR 0020 keeps
models out for good; the AI features Nook and Aura carry (a sidebar chat, a tab organizer,
an agent-control server, "Browse for Me") are not taken (ADR 0021).

## Build order, and why

The milestone order below predates any evidence about what Arc switchers actually want.
`EVIDENCE.md` gathers that evidence from the tracker of a comparable project. Two things
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
