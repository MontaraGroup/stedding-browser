# tooling/

Scripts that build Stedding. The rule these exist to serve is in `../AGENTS.md`: the
documented procedure and the executed procedure must be the same thing, so anything a
contributor is told to do lives here as a script rather than as prose to be retyped.

Every script is idempotent, fails with the remedy rather than a stack trace, and reads
its configuration from `chromium-version` — never from a value typed twice.

The shell scripts run on macOS and in Git for Windows' bash. Those marked **(macOS)**
drive or package a Mac app and need a Mac; `win/` holds the Windows side, in
PowerShell.

## The files

| File | What it does |
|---|---|
| `dev` | **Start here.** `build`, `test <feature>`, `capture`, `patch`, `check`, `status`, `features` — the loop in [docs/AGENT-LOOP.md](../docs/AGENT-LOOP.md) as one command. Owns the feature→gtest-filter tables (unit_tests, components_unittests; Stedding's browser tests run whole). `test` lists what every part of the filter matches before it runs anything and stops when a part matches nothing; `--list` does only that. No retries: a test that passes only on its second run fails. `test browser` runs the suite in two legs: most of it `STEDDING_BROWSER_JOBS` at a time (4 on Windows, 1 on the Mac), then `SERIAL_BROWSER_TESTS`, the tests that need the desktop to themselves, one at a time (HANDOFF trap 88); on the Mac the list also holds `WindowButtonsTest`'s two full-screen tests. `STEDDING_TEST_OUT=win-checks`, `mac-checks` or `win-asan` points `test` at that output directory and sets the run-time flags (the detector flag, ASan's option string with the quoted symbolizer path). |
| `assert-capture` | Checks a capture against a probe spec (points in DIPs with expected colour or luminance), optionally against a golden PNG. `--record` fills a spec from a capture you have inspected. `tooling/dev capture --assert <spec>` runs the spec's own capture command and checks it. |
| `probes/` | Probe specs. `window.json` is the reference window: sidebar edge, content corner radius, toolbar height, essentials grid, no Chromium buttons, switcher at the bottom. `ntp.json` is a fresh profile's new tab page: theme ground, the hint line, no shortcut tile (`docs/features/new-tab.md`). `settings.json` is Settings → Stedding; `geometry.json` is what `check-geometry` measures. Probes with `w`/`h` check a box, for text and icons. |
| `drive` | **(macOS)** Drives the built browser with synthetic clicks, drags and keys from a steps file (`drive-window.py`), captures after steps, and quits the launched pid so session files flush. Checks every step before it launches anything, refuses to start while another app with the same bundle id runs, and starts the browser in the background; any exit, Ctrl-C or kill quits that pid, then kills it. Input goes only to that pid while it is frontmost, and a click only where its window is on top; the pointer's own image, which macOS 27 draws as a Window Server window named "Cursor", does not count as a window on top. `shot` captures the window; `screen` captures the display it is on, which in macOS full screen also holds the address row, drawn in windows of its own. The real OS pointer moves: never on a machine someone is using. |
| `capture-state` | **(macOS)** Photographs a browser state without input: a fresh profile in the state the feature params and switches describe (`--features`, `--stedding-welcome=<step>`, `--seed collapsed`), or a page Chromium will not open from its command line (`--page chrome://settings/stedding`, through `devtools-page`), every window of the launched pid by id, a quit of that pid, the abort check. Refuses to start while another app with the same bundle id runs, starts the browser in the background, and fails if it ever becomes the frontmost app. Safe while someone is at the machine; how round 7 was verified. |
| `capture-ui` | **(macOS)** Runs `capture-state` with the same arguments, so older commands still work; with no `--out` the image is `ui-capture.png` in the repo root, with no `--url` the page is example.com. `tooling/dev capture` calls it. |
| `capture-windows` | **(macOS)** Captures every on-screen window a pid owns, by window id, largest first — a dialog such as the welcome flow is the second file. Used by `capture-state`. `--largest PID OUT.png` captures the largest one only, on screen or not: `drive`'s `shot` step. |
| `devtools-page` | Opens a page in a browser tooling launched with `--remote-debugging-port=0`, through its local DevTools endpoint (`/json/new`): no input, no focus change. `--close-new-tab` closes the launch's new tab page. Fails unless the tab reports the address asked for and a title, so a capture cannot pass for a page it does not show. Used by `capture-state --page`. |
| `acceptance/` | The acceptance scripts of `docs/features/acceptance.md`, run with real input on a real build. `mac/run-mac.sh` **(macOS)** (`layout`, `tst6`, `tst7`, `tst9` or `all`) seeds a fresh profile with three Spaces (`seed-profile.py`), files the local pages of `pages/` into the fixture, renders the steps files of `templates/` for `drive`, and keeps each run's captures and logs in a directory of its own; an app path drives an installed copy instead of `out/release`. `win/s173-live.ps1` (`-Part layout` or a part, `-Exe` for an installed copy) is the same on Windows through `win/drive.ps1`, finding rows, chips and buttons by UI Automation and reading each step's result back through DevTools. Both move the real pointer and press real keys: only with the operator's yes. |
| `drive-window.py` | **(macOS)** The step runner behind `drive`. `--check <steps>` reads and checks a steps file and posts nothing. A button or modifier it pressed is always released, on an error or an interrupt too. |
| `window_by_pid.py` | **(macOS)** The windows a launched pid (or its children) owns, and `--quit <pid>` for a clean quit of that one browser. Used by the capture and drive tools so they never touch another Stedding. |
| `status` | Prints what the repo and checkout actually contain (pin, patch count, tests per feature, backlog). Docs quote this instead of typing numbers. |
| `chromium-version` | The pinned upstream Chromium version. Single source of truth. Policy: [ADR 0007](../docs/decisions/0007-chromium-version-pin.md). |
| `lib.sh` | Shared paths, logging, and preflight checks. Sourced, never executed. |
| `bootstrap-depot-tools` | Verifies the host toolchain, then installs or updates `depot_tools`. |
| `sync-chromium` | Materialises the Chromium tree at the pin, outside this repository. Refuses under 150 GB free; `STEDDING_SYNC_MIN_FREE_GB` lowers the floor for a run that has done the arithmetic, never under 100 (HANDOFF trap 44). |
| `build-chromium` | `gn gen` + `autoninja` for a named configuration. |
| `fetch-sparkle` | **(macOS)** Puts Sparkle 2.10.0's framework at `third_party/stedding_sparkle/` in the checkout, from its release archive checked against GitHub's digest, without the XPC services; keeps the archive and Sparkle's tools (`sign_update`, `generate_keys`) in `~/Library/Caches/Stedding`. `build-chromium` runs it. `--tools` prints the tools' directory. |
| `apply-branding` | Copies `../branding/` assets over the checkout. Not a patch. |
| `apply-patches` | Replays the patch series onto the pin as commits on `stedding-work`. `--check` answers whether it would apply without touching anything, needs only git (no depot_tools, no Mac, no build), and reports which patches would need a three-way merge. The `series` workflow runs it. |
| `update-patches` | Turns those commits back into `../patches/`. |
| `fold-fix` | Folds fixes made in the working tree into an earlier commit of the series with git plumbing, no checkout: the fixed files are the only ones whose modification time changes, so siso rebuilds nothing else (HANDOFF trap 44). A conflict stops it before anything moves, and the branch moves only when the new tip's tree is the old tip's plus the fix. Run `update-patches` and `check-repo` after it. |
| `repair-checkout` | Rewrites git cache paths after a checkout is moved. |
| `update-pin` | Moves the Chromium pin to the newest stable and checks the series still applies. |
| `check-pin` | Is the pin current? Reports `current`, `behind` or `ahead` against stable on every desktop platform; `--self-test` runs the verdict on offline fixtures. The `upstream` workflow calls it. |
| `sign-release` | **(macOS)** Sign and notarise a built app with Chromium's signing pipeline; `--check` lists what is missing (identity, notary profile, packaging dir) |
| `publish-release` | GitHub pre-release from `dist/`: tag `v<VERSION>`, notes from `docs/release-notes/<tag>.md`; the platform that publishes second adds its image to the same release; `--check` first. Only with the operator's word in chat (`AGENTS.md`, red lines) |
| `publish-appcast` | **(macOS)** Offers the release to installed copies (ADR 0022): checks that `dist/`'s image is the release's and its app carries the updater, signs it with Sparkle's `sign_update`, writes `updates/appcast.xml` through `appcast.py`, signs and verifies the feed, commits it; `--push` publishes it. `--check` changes nothing. |
| `appcast.py` | Writes and reads the update feed: newest release first, five kept. `selftest` checks it. |
| `package-dmg` | **(macOS)** Packages a built app into an installable `.dmg`. |
| `brand/` | `generate.py` regenerates the brand system from `mark.py`, the mark's one geometry file; `win_icons.py` makes the Windows icons from the same mark; `product_name.py` rewrites the product name in Chromium's string tables (`apply-branding` runs it). |
| `verify/` | The probe page and the media clips `verify-build` serves to the built app. |
| `shellcheck-version` | The shellcheck version `check-shell` and CI pin. |
| `check-repo` | Repository hygiene: shell portability, links, ADRs, patch series, the pin, traps, LF line endings, nothing tracked that is ignored, no machine paths; every test a spec row or BACKLOG cites exists and is in a `dev` filter. |
| `check-shell` | shellcheck at the pinned version over every script here, plus `bash -n`. CI calls this exact script. |
| `digest-sanitizer` | A test run's output as a few lines: the tests that crashed, each distinct DCHECK/FATAL once with the first frames that are this project's, each dangling raw_ptr as a pair (freed in / still held in), each AddressSanitizer report's head. `tooling/dev` calls it on any run with a finding; `STEDDING_TEST_LOG` keeps the raw output. Read findings through it, not raw (trap 60). |
| `win/build.ps1` | One Windows build chunk: `gn gen` with the args file of `args/<config>.gn`, `autoninja`, a progress line a minute (steps, compilers, commit charge), a budget. `-Jobs` caps the steps; exit 0 built, 1 failed, 2 budget stop, 3 stuck |
| `win/build-until-done.ps1` | The build to the end, detached: `build.ps1` chunk after chunk, status in `out\<config>\supervisor.log` ending in `SUPERVISOR_EXIT=<n>`, exit 4 on steps killed at three stops in a row. Wait for that line; do not poll a clock (traps 9, 54, 57) |
| `win/drive.ps1` | The window used for real: pointer, keyboard, a window-only screenshot, rows and buttons by UI Automation, the visible page by DevTools, guarded (only into the window under test, only while the operator's hands are off). Ask the operator first (trap 27, trap 58) |
| `win/capture.ps1`, `win/cdp.ps1`, `win/uia-dump.ps1`, `win/hit-test.ps1` | Looking without touching, for when real input is not allowed: a window rendered by `PrintWindow`, JavaScript in a page over DevTools, every view with its bounds, what the frame answers at each row (traps 36, 37) |
| `win/park-cursor.ps1` | Moves the real cursor to the primary screen's bottom-right corner before the browser tests, so a cursor resting where test windows open does not expand a sidebar on hover (trap 78); only when nobody has touched the mouse or keyboard for ten seconds. `tooling/dev` runs it before each browser leg on Windows |
| `win/test-installer.ps1` | The installer against a real install, one step per call (`status`, `backup`, `upgrade`, `uninstall-keep`, `install`), log in `dist\installer-test\`; it never deletes a profile and refuses to remove anything without a backup. Run it as a scheduled task of the user's, not from an agent's shell (trap 40) |
| `win/package-installer.ps1` | The release image in `dist/` from a built `mini_installer` (ADR 0018) |
| `check-geometry` | Re-measures the card's gutters and corner radius in `docs/images/*.png` against `probes/geometry.json`. Needs Pillow; runs anywhere. `--report` prints the measurements. Not a CI check. |
| `verify-build` | **(macOS)** Runs a built browser and checks it renders, does WebGL, and decodes video. |
| `measure/` | **(macOS)** Performance harness, the ten live sites and the ten local pages for the QUALITY.md budgets (`docs/perf/README.md`). |
| `args/` | `gn` argument files, one per build configuration, with the reasoning per flag. |

## Normal use

On the Mac:

```bash
tooling/bootstrap-depot-tools     # once per machine
tooling/sync-chromium             # once per pin change
tooling/apply-patches             # our patch series
tooling/apply-branding            # our name and icon
tooling/build-chromium release --budget 0   # 0 = no time limit; the default stops at 15 min
tooling/verify-build --app ~/chromium/src/out/release/Stedding.app
tooling/package-dmg release
```

On Windows, after the same sync, patches and branding from Git for Windows' bash, the
build runs detached with `win/build-until-done.ps1` (wait for its `SUPERVISOR_EXIT=` line)
and `win/package-installer.ps1` makes the installer; both read `STEDDING_CHROMIUM_SRC`.

## Following upstream

```bash
tooling/update-pin                # is there a newer stable? changes nothing
tooling/update-pin --apply        # take it, sync, check the series still applies
```

A scheduled workflow (`.github/workflows/upstream.yml`) runs the same comparison daily
through `tooling/check-pin`, and opens a single tracking issue when we fall behind. A patch that conflicts on a routine
point release is in the wrong layer — see
[docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md).

Full prerequisites, measured build times and sizes, and known failure modes are in
[docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md#build-system).

## Branding

Branding is asset replacement, not patching: upstream's switch is boolean and grit
hardcodes the `chromium/` theme path, so our files overwrite that tree in place. It
must run before `gn gen`, and it leaves the Chromium checkout dirty on purpose so
`git status` shows exactly what changed.

```bash
tooling/apply-branding --check     # what would change; touches nothing
tooling/apply-branding             # copy branding/ into the checkout
tooling/apply-branding --revert    # restore Chromium's originals
```

Order matters when both are in play: `apply-patches` first (it requires a clean tree),
then `apply-branding`, then build.

## Patch workflow

Commits are the working representation; `../patches/` is the serialised form.

```bash
tooling/apply-patches             # series -> commits on stedding-work
# ... edit, commit, reorder, rebase ...
tooling/update-patches            # commits -> series
tooling/check-repo patches        # verify the result
```

Every patch commit message must carry `Why:` and `Removable when:` fields.
`update-patches` refuses to export a series without them, because a patch nobody can
justify or delete is how a minimal patch set stops being minimal.

## Paths

All overridable by environment variable; defaults suit a fresh machine.

| Variable | Default | What |
|---|---|---|
| `STEDDING_ROOT` | the repository root | This repository |
| `DEPOT_TOOLS_DIR` | `~/depot_tools` | Chromium's `depot_tools` |
| `CHROMIUM_ROOT` | `~/chromium`, or the location the first sync recorded in `.stedding-local` (local state, never committed) | `gclient` checkout root |
| `CHROMIUM_SRC` | `$CHROMIUM_ROOT/src` | Chromium source tree |

The Chromium tree is never committed to this repository.
