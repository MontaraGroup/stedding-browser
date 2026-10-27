# Roadmap

Milestones from zero to 1.0. Each ends in something installable and has acceptance criteria
a user can verify; a milestone is done when every criterion passes, not when the code is
merged.

**No dates.** This roadmap is a sequence, not a schedule, and the order changes only by an
ADR in `docs/decisions/`. What is released is `docs/release-notes/` (and `gh release list`),
what is open is `BACKLOG.md`, and what each feature does today is its spec under
`docs/features/`. "Installable" means that a fresh user account installs and runs the
artifact without developer tools, terminal commands or build docs. The quality bar at the
end of this page applies to every release. A beta named here by its number alone is one of
the 0.2.0 betas; 0.3.0 beta 1 follows 0.2.0 beta 21.

## Done so far

The ladder was climbed out of order, following feedback from real use
(`docs/PROJECT-LOG.md`). The scope and criteria the finished milestones were written with
are in this file's git history.

| Milestone | State | Left |
|---|---|---|
| M0 — A vanilla Chromium build, reproduced (macOS arm64) | Done; the pin moves by `tooling/update-pin --apply` (ADR 0007), and the Windows PC builds the same series since 2026-09-08 | — |
| M1 — Branded build, installable image | Done: `Stedding.app`, bundle id `dev.stedding.Stedding`, `tooling/package-dmg`, codecs by ADR 0008, baselines in `docs/perf/README.md` | The network criterion as a recorded idle run with a window that settles the push service (`S-50`) |
| M2 — Sidebar with vertical tabs | Done, on Chromium's own vertical tabs (ADR 0010), with folders (ADR 0013), Arc's pins, the rail, density and a sidebar that hides completely | — |
| M3 — Workspaces | Done as Spaces (ADR 0015, ADR 0016), each optionally with cookies of its own (ADR 0019) | — |
| M4 — Command bar | Done (`docs/features/commandbar.md`); real use kept the address row, and ⌘L opens the bar with the address in it | K12, ⌘L's prefilled address, partial |
| M5 — Split view | Partly done: Chromium's split view, the sidebar's verbs acting on both panes, a split made by dragging a tab onto the page (released in 0.2.0 beta 21) | ⌘W on a split (J3), a Space pin that joins a split (J5), ⌘1–9 counting a split once (J2): `S-102` |
| M6 — Settings, import, polish | Done but for what is left | Import from Chrome, Brave and the new Edge (`S-101`, `PLAN.md` decision 8); Arc's splits and archived items, and a 400-tab import inside the budgets (`S-103`); the VoiceOver pass (`S-129`) |
| M7 — Signed, notarized, auto-updating; site live | Done on the Mac: signed and notarized from beta 10 (`S-17`), updating itself from beta 16 (ADR 0022); Windows updates itself from beta 19 (ADR 0023, ADR 0026); stedding.dev live since 2026-09-16 | The rollback path tried for real; updates on Linux (`S-216`) |

---

## M8 — Windows port

**Goal:** feature parity on Windows x64 with a native-quality installer and updates.

**Where this stands (2026-10-27):** an unsigned preview ships with every beta and updates
itself from 0.2.0 beta 19 (`S-215`); from 0.2.0 beta 20 every release carries both platforms.
Built: the series and the Stedding window; the branding (the name, the icon,
`%LOCALAPPDATA%\Stedding`, Stedding's own registry keys, COM classes and sandbox prefix,
`docs/features/windows.md` N3–N4); Chromium's `mini_installer` (ADR 0018); Arc's keyboard
(N7); little windows, since 0.3.0 beta 7 (`docs/features/little.md` E10); and importing from
Arc, since 0.3.0 beta 13 (`S-81`). The checked and ASan runs of the suites are recorded in
`docs/PROJECT-LOG.md`; the ASan run of the newer patches is `S-106`. Not done: signing and SmartScreen
(`S-56`), CI, Windows performance budgets, and a two-finger Space swipe that follows the
fingers, where a touchpad's sideways scroll steps one Space instead
(`docs/features/spaces.md` B39).

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

What was read and left out, and why, is in ADR 0021.

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

Mobile, built-in AI features, a sync service of our own, and paid add-ons are not on the
path to 1.0 (sync through a folder the user's own tool keeps is not a service, ADR 0029). Any of them entering the roadmap requires an ADR and a roadmap revision. ADR 0020 keeps
models out for good; the AI features Nook and Aura carry (a sidebar chat, a tab organizer,
an agent-control server, "Browse for Me") are not taken (ADR 0021).

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

These gates apply to every release from the milestone a gate names (update safety and
signing from M7, Windows from M8). 1.0 requires all of them green on all supported
platforms.

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

The budgets are re-measured whenever the Chromium base changes and on each new platform
(M8, M9). No current build has a number: the one comparison so far is from 2026-09-02, on
Chromium 153 (`docs/perf/README.md`), and the harness takes only a macOS app bundle.

| Metric | Method | Budget vs. vanilla |
|---|---|---|
| Cold startup to usable window | Median of 10 runs, fresh profile, timed launch to first accepted input | ≤ 10% overhead |
| Warm startup | Median of 10 runs, existing profile with 10 restored tabs | ≤ 10% overhead |
| Memory, 10-tab session | Physical footprint summed over the browser process tree after loading the fixed 10-site list and idling 60 s, median of 5 runs | ≤ 10% overhead |
| Input latency, tab switch via sidebar | Keypress/click to target tab painted, median of 20 switches | ≤ 16 ms added over vanilla tab-strip switch |
| Command bar open | Shortcut press to bar rendered and accepting input, median of 20 | ≤ 100 ms absolute |
| Page load / rendering | Identical to vanilla | No measurable regression: the series patches no renderer code, and its few hunks in the network stack are listed in `docs/ARCHITECTURE.md` ("Where patches are allowed to live") |

How to run the harness, and what exactly it measures, is in `docs/perf/README.md`.
Published images come from the `release` configuration and the budgets are measured on
`official`; which one should ship is TBD (`BACKLOG.md` S-168).

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
- **Unit tests keep out of the user's data folder:** `unit_tests` run on a folder of their own
  in the system's temporary folder, and `tooling/dev test` fails a run that leaves a test's
  folder in Stedding's or Chromium's data folder (BACKLOG S-220).
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

How it works (ADR 0022, ADR 0023, `docs/features/updates.md`, `docs/HANDOFF.md` "The
updater"): a published release reaches installed copies only once it is offered in the signed
feed (`tooling/publish-appcast`, `tooling/win/publish-appcast.ps1`), after it has been tried
as a user gets it. On the Mac the feed keeps the newest five releases and Sparkle takes the
newest one the system can run, so any version with the updater goes straight to the latest.
Sparkle never installs an older version over a newer one, so a bad release is taken back by
removing it from the feed at once (a `git revert` of its "offer" commit) and fixed in a later
version: a profile a newer Chromium has opened is not promised to open in an older one.

### Security

- **Upstream security bumps:** when Chromium stable ships a security update, the target is
  a rebased release within **7 days** for actively exploited (in-the-wild) fixes and within
  **14 days** otherwise. The gate is checked per upstream release;
  misses are recorded publicly in the release notes with reasons. This is the standing
  cost of running a fork — the patch series and build pipeline are designed around it.
- **The clock is started by a machine, not by remembering.** `tooling/check-pin` asks
  daily whether the pin is still current and the `upstream` workflow opens one tracking
  issue while it is not (`.github/workflows/upstream.yml`). It reads stable on every
  desktop platform, because a point release on the milestone we ship reaches the others
  at the same time and a pulled macOS rollout would otherwise hide it.
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
    (`docs/AGENT-LOOP.md`, "Real use, safely").
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
