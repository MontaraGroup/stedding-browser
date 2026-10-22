# Handoff — how to pick this project up cold

Written for the next agent (or human) continuing this work. AGENTS.md is the
project context; this file is the operational knowledge that is otherwise only
in one contributor's head. Read both.

## Fast path (the first hour)

The long form of each step is `docs/AGENT-LOOP.md`; the numbers behind it are from the run
of 2026-09-29 to 30.

1. **Orient, five minutes.** `tooling/dev status`; `PLAN.md` (short); `BACKLOG.md`.
2. **Ask the operator once** for the things you would find out hours in; the list is
   `docs/AGENT-LOOP.md`, "Ask once, up front" (the screen and keyboard, push and release,
   what to delete, the machine overnight, a setting only they may flip, their own Stedding
   closed for the installer test).
3. **Use the product** before any long job: launch it on a fresh profile, click through the
   first launch, light and dark, the gestures the specs name (`tooling\win\drive.ps1` on
   Windows; `tooling/drive` on the Mac). Half an hour, and it finds what the suites do not.
   With other agents on the machine, take turns for builds and for the screen, and drive a
   copy of the app beside the owner's own (`docs/AGENT-LOOP.md`, "Roles").
4. **Run the suites on the shipping configuration:** `tooling/dev test all --no-build`.
5. **Sanitizer runs, cheapest first:** a DCHECK + dangling-pointer build (`win-checks`, or
   `mac-checks` on the Mac), then ASan (`win-asan`). The same command on each, naming its
   directory: `STEDDING_TEST_OUT=win-checks tooling/dev test all --no-build` (`mac-checks`
   on the Mac). Read findings with `tooling/digest-sanitizer <log>`, not raw.
6. **Fix loop:** edit the checkout (no build running), `tooling/fold-fix <commit> <files>`,
   `tooling/update-patches`, `tooling/check-repo`, commit this repo.
7. **Report** what was and was not verified, result first.

| To do this | Run |
|---|---|
| Build on Windows, to the end | `tooling\win\build-until-done.ps1 -Config win-checks -Targets unit_tests,stedding_browser_tests` (detached; wait for `SUPERVISOR_EXIT=`) |
| Build on the Mac | `tooling/dev build release chrome` |
| Run a sanitizer suite | `STEDDING_TEST_OUT=win-asan tooling/dev test browser --no-build` (`STEDDING_TEST_BUDGET_S=2400`) |
| Read a failing run | `tooling/digest-sanitizer <log>` |
| Use the window | `. tooling\win\drive.ps1` |
| Find a string in the tree | `git grep -n <pattern> -- <dir>` in the checkout |

### Trap index

A hundred and twenty-eight traps follow (28 is retired). Read the one for the topic in front of
you, not the list.

| Topic | Traps |
|---|---|
| Building, disk, rebuild cost | 1, 16, 19, 23, 44, 45, 53, 54, 57, 70, 73, 74, 83, 89, 90, 100, 123 |
| The working loop and the series | 5, 9, 13, 14, 17, 22, 50, 51, 89, 92 |
| Driving and capturing the window | 3, 7, 10, 11, 12, 15, 18, 24, 27, 29, 30, 36, 37, 52, 56, 59, 61, 63, 64, 65, 76, 82, 93, 94, 95, 96, 103, 105, 107, 116, 121 |
| What a test can and cannot prove | 2, 4, 31, 46, 48, 51, 52, 55, 56, 58, 59, 60, 66, 68, 69, 72, 75, 77, 78, 79, 80, 81, 84, 86, 87, 88, 91, 98, 99, 101, 102, 104, 106, 107, 110, 111, 112, 113, 114, 115, 119, 120, 126, 127 |
| Windows | 32, 34, 36, 38, 40, 42, 53, 54, 55, 56, 57, 59, 62, 67, 68, 69, 70, 71, 74, 91, 93, 98, 99, 100, 101, 103, 106, 111, 113, 114, 115, 116, 118, 121, 122, 125, 128 |
| Release and signing | 44, 47, 49, 62, 85, 117, 118, 124 |
| Chromium's and the platforms' own behaviour to know | 6, 8, 20, 21, 25, 26, 33, 35, 39, 41, 43, 60, 72, 73, 92, 95, 97, 98, 104, 105, 107, 108, 109, 110, 111, 113, 122 |

## Where things live

- This repo: docs, tooling,
  the patch series in `patches/`, branding. Public; never commit secrets or
  machine paths.
- The Chromium checkout: on the Mac `/Users/Shared/chromium/src` (recorded in
  `.stedding-local`); on the PC wherever `STEDDING_CHROMIUM_SRC` points ("The Windows
  build"). Each is pinned to `tooling/chromium-version`, on branch `stedding-work`. The
  patch series in `patches/` is generated FROM that branch by `tooling/update-patches` —
  the branch is the source of truth while working; the patches are the durable
  artifact. A series exported on one machine is applied on the other with
  `tooling/apply-patches` (on a checkout that already holds an older series, trap 89's
  route, which rewrites only the files that differ), and built there before the release
  that carries it (trap 44).
- Build output on the Mac: `out/release` (proprietary codecs on). `out/official` is
  built only for a performance baseline (`tooling/dev build official chrome`) and is
  not there now (never quote numbers from `release`; `docs/ROADMAP.md#the-quality-bar`). On the PC:
  `STEDDING_CHROMIUM_SRC` and `out\win-release` ("The Windows build").
- The website: `ysalitrynskyi/stedding.dev` (private), live
  at https://stedding.dev since 2026-09-16. Astro, static, Cloudflare Pages from
  `main`; it reads the latest release from the GitHub Releases API at build time and
  rebuilds itself every 6 hours through a deploy hook, so a published release reaches
  the site without a change there. Its rules and its dashboard steps are its own
  `AGENTS.md` and `docs/DEPLOYMENT.md`; its facts come from this repository's README,
  `docs/INSTALL.md`, `docs/SHORTCUTS.md` and `docs/FAQ.md`, so keep those true.

## The loop that works

The procedure is `docs/AGENT-LOOP.md`; the command is `tooling/dev`. Short form:

```bash
# 1. spec the behaviour in docs/features/<feature>.md, write the failing test
# 2. edit code in the checkout (on stedding-work) -- never while a build runs
tooling/dev test spaces               # the Mac: builds unit_tests, runs the feature's filter
#   Windows: tooling\win\build-until-done.ps1 -Targets unit_tests,stedding_browser_tests,
#   then tooling/dev test spaces --no-build
tooling/dev capture --features 'SteddingArcStyleWindow:extra_spaces/2/pin_tabs/1'
#   (the Mac; on Windows tooling\win\capture.ps1, or drive.ps1 for real use)
# look at the capture. measure pixels, don't eyeball.
# 3. commit in the checkout with Why:/Removable when: footers -- a fix to an existing
#    feature is a fixup into that feature's commit (git commit --fixup=<sha>, then
#    GIT_SEQUENCE_EDITOR=true git rebase --autosquash <pin>), not a new patch --
#    or, to leave every other file's modification time alone and so rebuild
#    nothing else (trap 44): tooling/fold-fix <sha> <files>, with the fix in the tree
tooling/dev patch                     # update-patches + check-repo
tooling/dev status                    # the numbers for any doc you touch
# commit + push this repo
```

`tooling/verify-build --app .../Stedding.app` checks rendering, WebGL 1 and 2, codecs
(H.264 decodes real frames), navigation and full screen (`--no-fullscreen` skips it).

On the Mac the capture step has two tools (Windows has its own, "The Windows build",
step 5). `tooling/capture-state --out <prefix> --features
'SteddingArcStyleWindow:...' [switches] [URLs]` launches a fresh profile in the state
the params describe, photographs every window the process owns by window id (a
dialog is `<prefix>-2.png`), quits through the AppleEvent and reports an abort: no
synthetic input, no focus change, safe while someone is at the machine, and the way
round 7 was verified. `tooling/drive <profile> <steps>` clicks, drags and types; it
is the only way to reach a context menu or a typed URL, and it runs only when nobody is
at the machine (trap 27): unlike `drive.ps1`, it does not watch for the operator's
input. Measure the PNG (PIL, a luma scan) rather than eyeballing it.

## What needs which machine

The Windows PC is the development machine: it builds the series, runs both suites and
drives the window ("The Windows build"). The Mac is needed for the macOS image: its
build (the Objective-C++ files the series changes, against AppKit, and full Xcode), its
suites and the Mac-only checks, and signing and notarizing. Three checks need no build at all, and
they are worth knowing about before assuming a check has to wait for one:

- **The series applies.** `tooling/apply-patches --check` reads the pinned tree into a
  temporary index and applies the series into it. Plain git: no depot_tools, no build,
  no macOS. Getting the tree is a `git init` plus one blobless-free depth-1 fetch of
  the tag (about 1.4 GB, two minutes); no working tree is needed, because
  `git apply --cached` reads objects rather than files. The `series` workflow does
  exactly this on every change to `patches/` or the pin, cached under the pin.
- **The window's geometry.** `tooling/check-geometry` re-measures the card's gutters
  and corner radius in `docs/images/*.png` against `tooling/probes/geometry.json`. It
  needs Pillow and the committed captures; it is no longer a CI check (cut on
  2026-09-26), so run it by hand after a recapture. Two traps in
  measuring this way: read a gutter as a band of window ground across the whole card
  rather than as one probed pixel, or the page's own content answers instead; and fit
  a corner radius across the whole arc, because the inset of the edge one scanline
  below the top is `r - sqrt(2r)`, which reads 8.7 for a 12 px corner and looks like a
  real discrepancy.
- **shellcheck at the pinned version.** The Windows build of the pinned release runs
  under Git Bash through a one-line shim on PATH, so `tooling/check-shell` gives the
  same answer CI gives.

No CI runner can build, run the suites, drive a window or sign: that is `S-49`.

## Dev parameters (all on `SteddingArcStyleWindow`, tunable without rebuilds)

`contents_corner_radius`, `vertical_tab_height`, `vertical_tab_corner_radius`,
`vertical_tab_pinned_height`, `location_bar_height`, `location_bar_width` (0 = no cap, as shipped),
`toolbar_vertical_margin`, `toolbar_button_height`, `toolbar_button_inset`,
`toolbar_button_icon_size`, `tab_favicon_size`, `card_gutter` — metrics.
`extra_spaces/N` — start with N extra Spaces. `pin_tabs/N` — pin first N tabs
(the essentials row). `space_pin_tabs/N` — pin the first N tabs in their Space,
their URL as home; `drift_tabs/N` — then send the first N of those to the next
tab's page (a drifted pin, for pins H4 and H12). `folder_tabs/N` — wrap first N tabs in a folder and nest
one (exercises the whole folder pipeline). `split_tabs/1` — put the first two tabs side
by side in a split (toolbar T41's row). `open_command_bar/true` — open ⌘T
overlay at startup. `drag_tabs_to_spaces` — on by default. `reduce_motion/true` — no
Stedding animation, as with the system's reduced motion (`docs/features/motion.md`).

All exist because pinning/folders/⌘T are UI gestures a headless harness cannot
perform; a param that recreates the state IS the test surface. Two switches do the
same for windows: `--stedding-welcome[=<step>]` forces the welcome flow (on a named
step: `search`, `import`, `appearance`, `behaviour`, `default`, `keys`; `behaviour` since
patch 0060), and `tooling/capture-state
--seed collapsed` writes the collapsed-rail preference (`vertical_tabs.collapsed_state`)
into the fresh profile; `--seed grey-dark` writes dark mode with Customize Chrome's Grey
(`browser.theme.color_scheme2` 2, `browser.theme.is_grayscale2`), the colour key a
private window has; `--seed light` and `--seed dark` set the window's scheme whatever
macOS is set to; `--seed horizontal` (or `horizontal-light`, `horizontal-dark`) turns vertical
tabs off, for Chromium's horizontal strip. A split, a tab group or pinned tabs in that strip
come from an unpacked extension passed as `--load-extension=<dir>` with `--features
ApiTabsSplitView` (`chrome.tabs.createSplit`, `chrome.tabs.group`).

## Traps this project already paid for (do not rediscover)

1. **siso stats sources once, near build start.** Edit during a build and your
   change silently misses the binary; `build-chromium` now warns when the tree
   moved mid-build. Never edit the checkout while a build runs.

2. **Screenshots cannot see teardown or input.** The folder close-crash (UAF)
   was invisible to every capture and found by a unit-test fixture. Anything
   that owns a tab needs a test, not a screenshot.

3. **Synthetic input**: `CGEventPostToPid` reaches the app for HOVER without
   focus; CLICKS and DRAGS need the window key (activate the process via
   System Events first, then post HID-tap mouse events; a tab drag needs a few
   slow moves past the threshold before the long move). Never drive the
   user's real pointer while they are at the machine. `tooling/capture-windows
   --largest` captures one window by id — never the screen. `tooling/drive` is the tool:
   its header lists the traps (a created key event inherits the last chord's
   modifiers, so clear them; a Cmd+Q keystroke does not quit, the AppleEvent
   does).

4. **SIGTERM does not reliably flush Chromium session files** from a raw binary
   launch — live restore tests via kill are meaningless; `tooling/drive` quits
   through an AppleEvent, which does flush. And the session log is **rebuilt
   from the live browser** at startup and every 250 writes: anything a feature
   keeps in session extra data must be re-emitted through
   `stedding_session_rebuild.h` *and* written once the window is tracked, or
   it survives exactly one restart.

5. **macOS bash is 3.2** (no mapfile); `tooling/check-shell` runs a pinned
   shellcheck because versions disagree about real findings.

6. **Chromium API drift in this tree**: `base::Value::Dict/List` are
   `base::DictValue/ListValue`; `TokenId` parses via `base::Token::FromString`
   + `FromRawToken`; `BubbleDialogDelegateView`/`WidgetDelegateView` cannot be
   subclassed outside Views (private ctor + friend list); `views::Separator`
   paints its whole bounds; FlexLayout stretches children that don't declare
   sizes (BoxLayout honours alignment).

7. **Tracked prefs** (`pinned_tabs`) cannot be seeded externally — that is
   anti-tampering working; add a dev param on our own code instead.

8. **Colour mixers hand out single colours** — the dark gradient is painted
   once on BrowserView with sidebar/top-container/mat made *invisible, not
   removed* (a nulled background crashes: the layout dereferences it).

9. **A sleep loop is not supervision.** A vanilla `official` build ran 3.5 h
   with an agent polling for an exit line and nothing else; the operator had to
   ask whether it was stuck (it was at 95%, but nobody could tell). The rule, in
   code: every build prints objects and active compilers each minute and has a
   budget that kills it when it runs past (`build-chromium --budget`, `build.ps1
   -BudgetMinutes`). The budget is a dead-man's switch and not a schedule: it kills
   the steps in flight, so a hand-restarted 15-minute chunk wastes their minutes and
   the idle gap before the next poll, which added up to hours across 40 chunks on
   2026-09-30. `tooling\win\build-until-done.ps1` restarts what the budget stops with
   no gap, writes a status file whose last line is `SUPERVISOR_EXIT=<n>`, and stops
   with exit 4 naming any step killed at the end of three chunks in a row (trap 57).
   The agent waits for that line in a background call and says where it stands, with a
   number, before any wait over ten minutes (`docs/AGENT-LOOP.md`).

10. **Synthetic mouse events inherit modifiers too.** After a `key f+ctrl+cmd`
    the harness's next plain click carried Ctrl, which macOS reads as a right-click:
    context menus opened where a click was meant. `tooling/drive-window.py` clears the
    flags on every mouse event now; if a "click" ever opens a menu, check this first.

11. **A floating window from another app can sit over the capture harness's
    click targets** (2026-09-03: Arc's mini player parked at the screen's
    top-left corner swallowed every click on the sidebar's first rows, so a
    pinned tab looked as if it had no context menu). Window captures never
    show it. Before blaming a view, list what is on screen there:
    `python3 -c 'import Quartz; ...CGWindowListCopyWindowInfo(...)'` or a
    full-screen `screencapture -x`, and move our window with
    `--window-position` on a fresh profile (a restored session keeps its old
    bounds).

12. **`tooling/drive`'s `shot` photographs the browser's largest window, not
    every window Stedding owns.** Since 2026-09-28 it captures that one window by
    its id; the welcome dialog (a separate child window) is not in it, so a check of
    it needs the `screen` step (the whole display, since 2026-10-18), or a
    `CGWindowListCopyWindowInfo` listing to prove the window exists and where.

13. **A fold that stashes the branding and then fails leaves the stash
    unpopped** (2026-09-04: an autosquash rebase conflicted, `git rebase
    --abort` restored the tree, but `git stash list` still held the branding).
    The next `tooling/dev build` then produces `Chromium.app`, and
    `tooling/drive` keeps launching the stale `Stedding.app`, so every "fix"
    looks ineffective. After any failed fold run `git stash list`; scripts that
    stash must pop in an EXIT trap; `ls out/release/*.app` says which product
    the last build made.

14. **A new `.grdp` part must also be listed in `chrome/app/generated_resources.grd.gritdeps`**
    (2026-09-04: `stedding_strings.grdp`, the one file for every string this fork
    adds, failed the first build at `generated_resources_check_gritdeps` with a
    "gritdeps mismatch" diff; the manifest is sorted, add the line where the
    diff says). Stedding strings that reach a macOS menu or a toast need real
    `IDS_` ids; the settings page and the command bar still use literals.

15. **A drive's keys go nowhere when the window is not key.** Two runs that
    opened two URLs (`https://example.com/ https://example.org/`) came up with grey
    traffic lights; `activate` twice did not help, and ⌥⌘N never reached the window.
    Read the traffic lights in the shot before blaming a chord. The fallback that
    works for anything with a menu row is System Events from the foreground shell
    while the drive parks: `click menu item "Add Tab to New Split View" of menu 1 of
    menu bar item "Tab" of menu bar 1` (2026-09-05).

16. **`tooling/dev build` refuses under 60 GB free, and drives eat the margin.**
    Every `tooling/drive` profile keeps 100–500 MB of cache; a batch of ten leaves
    the volume 3 GB lighter and the next build exits at once with "need 60 GB free".
    Delete the scratch profiles after each batch (`rm -rf <scratchpad>/p-*`), then
    the reclaims in the disk runbook (old Playwright browsers, `npm cache clean`).
    The browser itself leaks `$TMPDIR/dev.stedding.Stedding.chromium_chrome_url_fetcher_.*`
    (25 MB each; 323 of them, 8.3 GB, after two days of drives) — delete those too.
    `df -k` is the number the check reads; Finder's figure includes purgeable space.
    For an incremental chunk `STEDDING_MIN_FREE_GB=40 tooling/dev build …` lowers the
    floor (20 is the least it accepts); the 60 stays the default for full builds.

17. **Patch files are tracked, so ADR 0007's version scan reads them.** A unit test
    that spelled the pinned Chromium version (`stedding_version_unittest.cc`) passed
    `tooling/check-repo` while its patch was still untracked and failed the moment
    the patch was committed. Tests of version formatting use a made-up version
    (`150.0.1234.5`); only `tooling/chromium-version` carries the pin (2026-09-05).

18. **The machine's input source leaks into the harness.** A `type` step that used
    virtual key codes alone typed Cyrillic into the address bar once a non-Latin
    input source was active (2026-09-05, 05:21: `chrome://settings/stedding` became a
    DuckDuckGo search). `tooling/drive-window.py` now puts the character on every
    typed event as well as the code; if a capture shows the wrong script, that is
    the first thing to check.

19. **A new `IDC_` id rebuilds most of the browser.** Adding one line to
    `chrome/app/chrome_command_ids.h` (2026-09-05, `IDC_STEDDING_COMMAND_PALETTE`) put
    about 2,800 steps on the unit_tests build at roughly 0.5–0.8 steps a second: four
    15-minute chunks. Batch new ids with other header-wide changes, and start such a
    build first thing in a session rather than last.

20. **On the Mac the focus manager sees a key before the focused view does.** A
    Textfield that wants ⇥ (the command bar's mode switch, 2026-09-05) never gets it:
    `FocusManager::OnKeyEvent` runs tab traversal first, focus lands on the toolbar
    and the bar closes on the focus change -- while the unit test, which calls the
    controller's `HandleKeyEvent` directly, stays green. Claim the key in
    `SkipDefaultKeyEventProcessing` (as `OmniboxViewViews` does) and assert the claim
    in the test. The same shape hides a sizing bug: a panel that sizes itself from
    its rows must recompute its bounds on every rebuild path; a `GetPreferredSize`
    probe cannot see an early `return`, only the live shot can.

21. **Stedding's own WebUI CSS and TypeScript go through Chromium's linters at build
    time.** stylelint wants a blank line before every rule and short hex colours
    (`#fff`, not `#ffffff`); the Lit template linter wants event handlers named
    `on<Context><Event>_` (`onRouteAddChange_`, not `onRouteAdd_`). A lint failure
    stops the build before any compile step, so read the first `✖` line of the log.

22. **A fixup into an earlier patch can conflict with a later patch's hunk in the
    same include block.** `git rebase --autosquash` then stops twice: once applying
    the fixup, once re-applying the later patch. Both conflicts were include lists;
    the resolution is the union of both sides, deduplicated, then `git add` and
    `GIT_EDITOR=true git rebase --continue`, and only then `git stash pop` the
    branding files. Check `git status` shows no non-branding changes at the end.

23. **Small things that cost a build each:** the Mac's shell is zsh, which does not
    word-split an unquoted `$var` (pipe file lists through `xargs`); `tooling/dev`
    and `tooling/check-repo` are relative to the repo root, so a subshell that `cd`s
    into the checkout must call them by absolute path; a bar action gated on an
    asynchronous check (a file's existence) has to be primed at window creation,
    not at the first actions-mode bar, or every first look at it comes up empty.

24. **The vertical tab strip's anonymous Spaces take their glyph and name from
    their index.** A reorder of two unnamed Spaces is invisible in a capture except
    through the active highlight and the title row; give one an icon through its
    chip menu before capturing a drag.

25. **Small things that cost a build each, round 6 wave 3:** a `views::View`
    subclass, even one in an anonymous namespace, needs `METADATA_HEADER` and
    `BEGIN_METADATA`/`END_METADATA` or `AddChildView` fails a static assert;
    `views::LabelButton::label()` is protected, so a row whose font must change
    is a subclass that re-exports it; `switches::kEnableFeatures` is in
    `base/base_switches.h`, not content's switches; gn targets are named after
    their directory unless the BUILD file says otherwise
    (`//components/embedder_support`, `//components/bookmarks/test`); a
    `Browser` has `GetProfile()`, not `profile()`, and no `window()` (use
    `BrowserWindow::FromBrowser`); `SkColorGetR` and friends are macros, not
    functions. In the live checks, chrome://settings' search box finds a row
    but does not scroll to it: click the page body and press space instead;
    `tooling/drive-window.py` writes its `shot` files into the current
    directory, so `cd` to the scratch directory first. The feature params
    `folder_tabs/N` and `pin_tabs/N` seed a folder or an essential for a capture;
    a Space pin comes from `space_pin_tabs/N`, or the ⌘T action "Pin to This Space".

26. **Wave 4's lessons.** `content::WebContents::Create` makes a plain
    WebContents; `WebContentsTester::For` on it is a wrong cast that only
    sometimes faults (patch 0027's restored-tab test did, once the layout
    shifted): a test that drives navigation makes its contents with
    `WebContentsTester::CreateTestWebContents`. A view's `UnownedUserData` must
    die before its window: a per-window mark lives on `BrowserWindowFeatures`
    as a plain flag. `tooling/drive` passes `--window-size` and
    `--window-position`, which the window sizer applies to every window the
    process opens, so a little window's own bounds only show on a plain
    launch; and its `shot` picks the window behind when two share a position:
    `screencapture -x -R x,y,w,h` of the front one instead. The
    `extra_spaces` feature param adds a Space to every new window, and with
    the registry that Space is shared: make the second Space through the
    sidebar's "+" when capturing a second window.

27. **Never drive the machine while the operator is at it — and an app launched
    under lldb is never key for the harness.** A `drive-window.py` run against a
    browser started by `lldb --batch` could not activate it; every synthetic key
    went to the frontmost app, which was the operator's chat (2026-09-05). The
    input-free path covers almost everything: `tooling/capture-state` (a window
    capture by id, no focus change; `tooling/capture-ui` forwards to it) with feature params for the state
    (`folder_tabs/N`, `pin_tabs/N`,
    `extra_spaces/N`, `space_pin_tabs/N`, `drift_tabs/N`; the collapsed rail is
    a profile preference, `vertical_tabs.collapsed_state`, seeded into a fresh
    profile's `Default/Preferences`), and `tooling/window_by_pid.py --quit <pid>`
    for a clean quit of the one browser a tool launched. An `osascript` quit
    addressed to the app bundle reaches the owner's own Stedding too; the folder
    quit crash was once reproduced that way under `lldb --batch -o run -k "bt 40"`
    with a symbolised stack (the release build keeps its symbol table;
    `symbol_level=0` drops only the line tables). Drives wait for an empty chair,
    and `drive-window.py` refuses any input unless the launched pid is frontmost
    and, for the mouse, its window is the topmost one at the point.

    The policy since 2026-09-30: real input is used with the operator's yes, asked once at
    the start of a session ("you can use the screen any time", that night), and only through
    a driver that keeps these two conditions. On Windows that is `tooling\win\drive.ps1`:
    input goes only while the launched process's window is in front, and only while the
    operator's own last input is more than six seconds old (`GetLastInputInfo`; its own
    events are told apart by their time), and a screenshot is of the window's rectangle,
    only while it is in front. Without the yes, the input-free tools.

28. **Retired:** it was about an early apply-script pipeline that clang-format broke; the
    series is git commits exported by `tooling/update-patches`, and no such script runs.

29. **`tooling/capture-state` is the harness that needs no hands.** It launches
    the app on a fresh profile, captures every window the process owns by id and
    quits through the AppleEvent, so a state can be photographed while someone is
    at the machine -- what `tooling/drive` must never do (trap 3). The state comes
    from feature params, not from input: `space_pin_tabs/N`, `drift_tabs/N`,
    `folder_tabs/N`, `pin_tabs/N`, `extra_spaces/N`, `open_command_bar/true`,
    `--stedding-welcome=<step>`, `--seed collapsed`, `--seed grey-dark`. Since
    2026-09-28 it, like `tooling/drive`, launches in the background (`open -g
    -n`), refuses to start while another Stedding with the same bundle id runs
    (quit the installed one first), and quits by pid and deletes its profile on
    any exit. A background launch is not enough on its own: Chromium's Mac window
    bridge activates the app when it shows a window, so every run stopped with
    "made itself the frontmost app" and captured nothing. Since 2026-09-29
    capture-state passes `--stedding-stay-in-background`, which skips that one
    `activateIgnoringOtherApps:` call (patch 0057); the windows are ordered in
    front but never take the focus or the keys. `tooling/drive` does not pass
    it: it needs the focus, and waits for an empty chair.

30. **A window capture carries the window's shadow.** An absolute y read off one
    is not a window coordinate; compare two things inside the same capture --
    the toggle's centre against the traffic lights' centre (sidebar Y7), never
    either against zero. The exclusion macOS reports for the lights is a box with
    a margin around them, not the glyphs themselves: the glyphs are 12 DIP circles
    at the box's top inset, so half the box's height sits a button 3 DIP low.

31. **Chromium's own suites over the code the series changes must run too: two of its
    tab tests had been red since patch 0002.** Until 2026-09-10 nothing ran `TabTest.*`,
    which reads the favicon column's width and the discard ring -- both of which this
    fork changes on purpose. Now `tooling/dev test upstream` runs the Chromium suites
    over code the series changes (`TabStripModelTest`, `VerticalTabStripStateControllerTest`,
    the accelerator, tab menu and tab layout suites, and the two `TabTest` cases on the
    favicon column), `tooling/dev test all` includes them, and `tooling/dev test rebase`
    runs the wider ring (`TabTest`, `TabContainerTest`, `TabStripTest`) after a pin bump.
    Every filter part must match a test or the sweep stops. Chromium's `browser_tests`
    and `interactive_ui_tests` are not built: their cases over the series' files assert
    the product from before it. The Mac pass on beta 6 found eight red cases there,
    none a product bug: five read Chromium's horizontal tab, its icons and its
    group colours under the 2026 refresh that patch 0042 turns on in code
    (unit tests never see the field-trial config, so upstream's tests had never
    run that way), two read the find bar under the location bar where Stedding
    hangs it from the card since round 6, and one dereferenced the horizontal
    strip an Arc window does not have -- a crash, which prints no FAILED line and
    which `tooling/dev test` used to swallow: it reports crashes and timeouts now
    (`docs/history/archive.md#the-operators-rounds`, *The Mac pass*).

32. **Windows' caption buttons are on the right, and the frame reports them as
    the trailing exclusion.** The layout skipped every exclusion with a vertical
    strip because macOS's lights sit over the sidebar's column; Windows' buttons
    sit over the row's. Read both exclusions, never assume one side (round 8).
33. **Collapse state and drawn width are two different things.** Expanded on
    hover the state stays collapsed while the strip is at its open width. Anything
    styled for the rail -- centring, icon-only rows, the stacked switcher, the
    opaque ground -- keys on the width being laid out, or it dresses the hover
    overlay as a rail (round 8, three fixes in a row got this wrong first).
34. **A Windows build from an agent's MSIX-packaged desktop app inherits a redirected
    %LOCALAPPDATA%** some 60 characters longer than the real one, and vpython's
    venv then blows past MAX_PATH; point `VPYTHON_ROOT` at a short directory. And
    a driver that clicks must verify the browser is the foreground window first
    (`GetForegroundWindow`, after the Alt-key tap Windows requires):
    `SetForegroundWindow` is allowed to fail, and one launch put the clicks into
    the operator's own app. Trap 36 is the way that needs neither.
35. **A bubble before the window is shown cannot anchor to a tracked element.**
    The element tracker knows a view only once its widget is visible, so a
    startup bubble -- the crashed-session "Restore pages?" one -- that falls
    back to `kFallbackPopupAnchorElementId` because its button is not drawn
    (the address row hidden, toolbar T8) finds nothing, and Chromium's CHECK
    kills the launch: a profile killed while the sidebar was collapsed never
    opened again (round 8, second pass). Anything that hides a toolbar button
    must give such bubbles a drawn view to anchor to (toolbar T23).
36. **On Windows a capture needs neither focus nor input.** `PrintWindow` with
    `PW_RENDERFULLCONTENT` renders a window behind others, provided the launch
    disables occlusion tracking (`--disable-features=CalculateNativeWinOcclusion`)
    so Chromium keeps drawing a covered window; a click goes to the window's own
    queue as `WM_LBUTTONDOWN`/`WM_LBUTTONUP` in client coordinates, never through
    `SendInput`, so nothing reaches whatever the operator is doing. The
    `Chrome_WidgetWin_1` window to render is the largest one of the process:
    bubbles and toasts have the same class, and a console launched with
    redirected output is what `MainWindowHandle` returns. `tooling/win/capture.ps1`
    is that driver. One more thing it taught: a `--force-device-scale-factor=2`
    window on a 1728 px display is 864 DIP wide, so the toolbar's forward button
    folds into the "»" overflow there -- Chromium's narrow-window rule, not a bug.
37. **A views layout that a capture cannot explain is answered by a dump, not
    a theory.** Three readings of the toolbar's flex rules did not predict the
    field landing on the back button; one `VLOG` of every child's bounds after
    `Layout` did in a minute (the layout had dropped the centring spacers and
    the clamp read their empty bounds). Chromium's own `--enable-ui-devtools`
    listens but its `DOM.getDocument` never answered this build. Add the dump,
    rebuild the one file, read the log, remove it before the patch is cut.
    On Windows `tooling\win\uia-dump.ps1` answers the same question with no
    build at all (round 9).
38. **On Windows, Chromium reads Google Chrome's registry key for extensions
    whatever the branding** (`Software\Google\Chrome\Extensions`, machine
    and user, `ExternalRegistryLoader`), and installs what it finds from
    Google's update server. On a PC with Chrome and Adobe Acrobat that is an
    "Action required" chip on a fresh profile's first launch. Stedding does
    not create that provider (privacy Q9); any other Chrome-keyed lookup a
    port meets deserves the same question.
39. **A WebUI message with no handler kills the browser.** `chrome.send` to a
    name nobody registered is a `NOTREACHED` in the browser process, not a
    console error in the page. A handler behind `is_mac` in BUILD.gn and
    `#if BUILDFLAG(IS_MAC)` in `settings_ui.cc`, asked for by a page that ships
    everywhere, made chrome://settings/stedding a crash on Windows (windows
    N5). Every platform-gated handler needs a `loadTimeData` boolean the page
    checks before it sends.
40. **Processes started from an agent's MSIX-packaged desktop app see a virtualised AppData
    and HKCU.** The app is an MSIX package: an installer run from its tools
    installs into `%LOCALAPPDATA%\Packages\<the app's package>\LocalCache\Local`, the
    registry entries land in the package hive, and the installed exe then fails
    with a side-by-side error because the Windows loader probes the real path.
    Tests of an installer, or of anything under AppData, run through a
    scheduled task as the user (`schtasks /Create ... /Run`) with a log in a
    real path; the captures come from outside the sandbox as usual (trap 36).
    The cycle ended in `setup.exe --uninstall --delete-profile`, so it had to refuse
    to start over an existing install: on 2026-09-10 it ran over the beta 5
    installed for the operator and took that install and its profile with it. It
    never deletes a profile now: `-Mode uninstall-keep` keeps it, and the upgrade and the
    uninstall need `-Mode backup` first.
    The tasks themselves do not survive: `/SC ONCE` tasks were gone the next
    day and had to be created again.
41. **A non-official build runs Chromium's field-trial testing config** unless
    `disable_fieldtrial_testing_config = true`, and so does an official one:
    `testing/variations/fieldtrial_testing_config.json` switches on hundreds of
    experiments, differently per platform. It is off in every configuration
    under `tooling/args/` (privacy Q10); a build made with hand-written args
    elsewhere is running Google's experiment set until it says so too. And the
    look moves with it: the 2026 desktop refresh was one of those experiments,
    so patch 0042 keeps its seven features on by default.
42. **Chromium's Windows accelerator list refuses Ctrl+Alt.** A DCHECK in
    `GetAcceleratorList` fires on any mapping with both, because AltGr sends
    Ctrl+Alt on many keyboards. Arc for Windows puts its Space and tab traversal
    on Ctrl+Alt with the arrows all the same, so Stedding's Ctrl+Alt rows (patch
    0043, windows N7) are inserted after the check, the way Chromium's own debug
    map is. A Ctrl+Alt row in the main table kills a DCHECK build at startup.
    Where a layout's AltGr does type a character on the key (Polish (Programmers):
    C and N with Shift), Windows hands the key over as that AltGr character and no
    row matches; `stedding::AltGrChords` runs the row when it was made with the
    left Alt (windows N14). Its unit test plays the keyboard's state: the real one
    needs a Polish layout on the PC, which is the operator's setting to add.
43. **A container whose size is its children's gets it from its layout, not from
    a number set by hand -- and a BoxLayout with a flexible child reports the
    space it is offered as its preferred size.** The sidebar's bottom row had a
    preferred height set at construction and at each collapse; a Space added in
    the rail rebuilt the switcher inside it and the row kept its old height, so
    the "+" was laid out past the window's bottom until the sidebar was opened
    and collapsed again (round 9). Dropping the number was not enough: the row's
    BoxLayout flexes the switcher to take the open row's width, and in the rail,
    stacked, that flex made the row ask for everything under the Archived row and
    sit the stack at its top, 200 DIP above the window's bottom
    (`tooling\win\uia-dump.ps1` showed the row 425 DIP tall).
    The flex is the open form's alone now, the row's height is its children's,
    and the switcher reports a height that counts its dots as dots (sidebar Y13).

44. **The checkout can vanish, and a re-sync is an hour of the Mac's time.** On
    2026-09-09 `/Users/Shared/chromium` was gone -- the volume was 88% full and the
    tree is the biggest thing on it -- and the Mac's part of beta 6 began with no
    checkout, no `out/`, no `unit_tests`. `tooling/sync-chromium` rebuilt it in 43
    minutes from 109 GB free (the git-cache bundle 7 min, the tag fetch 19 min,
    `gclient sync` and the hooks 17 min): src 43 GB, the cache 26 GB, 53 GB together
    on disk since the two share objects, 48 GB free after. `tooling/apply-patches`
    replayed the series; the caches the machine's disk runbook allows
    were worth about 20 GB and nothing else on the machine is an agent's to delete.
    Three rules from it. `STEDDING_SYNC_MIN_FREE_GB` lowers the sync's 150 GB floor
    for a run that has done the arithmetic (65 for the checkout, 9.3 for a release
    build, about 10 for `unit_tests`, 20 of headroom), never under 100. The deps
    are cloned with alternates into `.git-cache`, so the cache is part of the
    checkout, not a download to delete (`tooling/repair-checkout`). And a patch
    exported from one platform is built on the other before the release that
    carries it: of the seven written on Windows (0039-0045) one did not compile on
    the Mac -- `kColorCaptionButtonOnToolbar` is declared for Windows alone in
    `chrome_color_id.h` -- and `AppendASCII` on a Space's name would DCHECK on a
    debug Mac; both fixed as fixups into 0039 that day. The seven patch files had
    also been written by hand on Windows (CRLF headers, no diffstat, untruncated
    names); `tooling/update-patches` is the one exporter, and `tooling/check-repo
    eol` refuses a CR byte in any tracked text file since. And a build that turns
    Chromium's field-trial testing config off (privacy Q10) changes what nobody
    measured: every inactive sidebar row and essentials card took the Material
    fill the config had been hiding, and the first multi-tab capture on the Mac
    was the first to show it (tabs R23). Before trusting a look that only ever
    existed under the config, run the previous release with
    `--disable-field-trial-config` beside the new build and diff the captures.
    One more cost: a fixup into an early patch makes the rebase re-check-out
    every later patch's files, and siso rebuilds their objects even though the
    content is the same (a fixup into 0017 cost a 20-minute `unit_tests`
    rebuild for two test files). Fold into the latest patch that can own the
    change, and fold before the sweep, not between sweeps.

45. **A point release is a delta, not a re-sync -- and nothing else may touch the
    checkout's git while the series goes on.** On 2026-09-18, with 29 GB free,
    153.0.8010.48 became .53 through `tooling/update-pin --apply`, which now hands
    `tooling/sync-chromium --point-release` to a same-milestone bump: a 25 GB
    floor (`STEDDING_SYNC_POINT_RELEASE_MIN_FREE_GB`, never under 20) instead of the
    150 GB a checkout from nothing needs, because what moves is the tag's delta,
    the dependencies that changed and the release's PGO profile. The sync's
    `git checkout -f` drops the branding; `tooling/apply-branding` puts it back
    once the series is on. Of 48 patches one conflicted: upstream added
    `old_elevator_iids` and `old_tracing_service_iids` beside the COM ids that
    0041 replaces with Stedding's own, resolved by keeping Stedding's GUIDs and
    empty old-id lists (Stedding's never changed). And a `git status` from a
    second shell while `tooling/apply-patches` was mid-`git am` took `index.lock`,
    the apply died at patch 0016 with "unable to write index file", and the rest
    of the series went on by hand. Read the log, not the tree, while it runs.

46. **A green unit test is not a shipped behaviour.** Patches 0047-0048
    (2026-09-16 and 17) added a dozen behaviours with tests and marked every one
    built. On 2026-09-18 a grep of the checkout for their call sites found seven
    that no menu, key or setting reaches -- the clipboard fence, the sidebar file,
    copy-to-jar, the isolation mark, folder insert at an index, `HostRouteFor`,
    the throwaway Space -- and two command-bar rows that flipped a flag nothing
    read (Focus, Hide Other Spaces), so a user who chose them saw nothing happen.
    The specs' state column now says `model only` for the first kind; the rows
    were wired or withdrawn for the second (`S-61`). `tooling/check-repo` cannot
    tell a called function from an uncalled one, so the audit is by hand: for
    every public function a patch adds, grep the checkout for a caller outside
    the tests before the spec says built. A behaviour is shipped when a user can
    reach it and its test is green -- both, not either.

47. **A release is tried the way a user gets it: downloaded.** Every macOS
    pre-release up to beta 8 told users to right-click → Open the unsigned app on
    its first launch, and nobody had tried that on a download: `verify-build`
    launches the app from `out/release`, which carries no quarantine mark, so no
    check ever met Gatekeeper. On 2026-09-19 the operator downloaded beta 8 through
    a browser and macOS said Stedding "is damaged and can't be opened", which no
    right-click gets past. The download was intact (its checksum matched); the
    signature is the cause: the linker gives each Mach-O an ad-hoc signature, the
    bundle has no sealed resources, and Gatekeeper reports that on a quarantined
    app as damage (`codesign --verify --deep --strict`: "code has no resources but
    signature indicates they must be present"). Until `S-17` the install step was
    `xattr -dr com.apple.quarantine` on the one app, after the checksum
    (`docs/INSTALL.md`); every macOS image from beta 10 on is signed and notarized, and
    needs none. Before a release is announced, run `syspolicy_check
    distribution` on the app that goes into the image: anything short of a pass
    means the notes carry the unsigned paragraph, and the paragraph is one that was
    tried on a downloaded copy.

48. **Nobody had run the browser in full screen.** Every capture, probe and
    test since patch 0013 ran in a window. macOS in full screen moves the top
    container into an overlay widget of its own, so the toolbar is no longer in
    the browser view's widget, and the window background's page bar converted
    its bounds anyway: a CHECK, and the browser aborted a second after launch
    (toolbar T24, 2026-09-19). The operator met it as "it crashes on launch":
    their session had a full-screen window, so the restore hit it every time.
    Two lessons. A view another window may own -- the toolbar, the top
    container, anything in it -- is converted only after `GetWidget()` says it
    is still this window's. And a state the product supports is a state
    something must enter: `--start-fullscreen` with a page that carries a theme
    colour is one line in a capture or a run, and it is now what the release
    sweep does (`tooling/verify-build`).

49. **Chromium's signer had never been run here with a real identity.** Until
    2026-09-23 the only signing run was `--development` (2026-09-03), which skips
    Gatekeeper and notarization. The first Developer ID run failed three times in a
    row, each a fault nothing had exercised: `tooling/sign-release` passed
    `--notary-arg --keychain-profile=...`, which the signer's parser reads as an
    option with no value; upstream's `validate_app` asked Gatekeeper about the app
    before notarizing it, and current macOS rejects every Developer ID app until it
    is notarized ("source=Unnotarized Developer ID"), with a `NameError` in the
    error path hiding the message; and `Distribution.to_config` dropped the
    notarization level, so every distribution read the default whatever
    `--notarize` said. Patch 0051 fixes the two upstream faults and assesses only
    after stapling. The fourth run signed and submitted, then waited out the
    signer's two-hour limit on the team's first notarization, which Apple can
    hold longer. Chromium's signer tests need Python 3.11 exactly (3.10 lacks
    `asyncio.TaskGroup`, 3.12 dropped `assertEquals`); on another version compare
    the failure list with and without a change, as the 0051 change was.

50. **M155 took `Browser` away, and a milestone rebase is two jobs.** Upstream's
    Bedrock work removed `BrowserWindowInterface::GetBrowserForMigrationOnly()`,
    `BrowserList`, `TestWithBrowserView` and `browser_view_unittest.cc`, and made
    `BrowserView::browser()` return the interface. The rebase itself (conflicts,
    `zdiff3` on, the tab menu enum and toast ids handled by rule) is the first
    job; the port is the second, and only the compiler finds it -- build with
    `KEEP_GOING=1` so one pass lists every error. The port: take the interface
    wherever a `Browser` was held (`GetTabStripModel()`, `GetProfile()`,
    `GetSessionID()`; the interface still has an inline `tab_strip_model()` for
    migrating callers, so upstream lines that use it need no change); a URL with
    parameters goes through `BrowserWebContentsDelegate::From(window)->OpenURLFromTab`,
    which is what `Browser::OpenURL` did; tests hold `std::unique_ptr<BrowserWindowInterface>`
    from `CreateBrowser`. The fixes go back into the patches they belong to by
    blame: one `--fixup` per owning patch, hunk by hunk, then one autosquash.
    Fixups placed early collide with later patches' lines; resolve a fixup's
    conflict with the stage's own side, ported, and a feature patch's with its
    own side, ported -- the first run took the stage's side for both and lost 97
    lines, which the tree-identity check against the pre-squash snapshot caught.
    A correction a later patch's context blocks goes into the last patch that
    touches the file. The snapshot is what makes this safe: the squash is done
    when the tree is identical, not when the rebase says so.
51. **Chromium's search suites assert a Google default and an EEA-only choice.**
    Stedding changed both on purpose: DuckDuckGo is the fallback engine in
    every region, and the search engine choice program runs in every country
    (`docs/PRIVACY.md`; docs/history/plan-2026-09-26.md WEB-4). The cases that are about those two
    hunks assert Stedding's behaviour now and run in `tooling/dev test
    search`: `TemplateURLPrepopulateDataTest.DuckDuckGoIsTheFallbackInEveryRegion`
    (every `regional_settings` entry and an unknown country), and the
    regional-capabilities cases `IsInEeaCountry`,
    `IsInSearchEngineChoiceScreenRegion` and `ClientIsInSearchEngineChoiceScreenRegionTest.*`.
    31 other upstream cases in `components_unittests` still assert the
    upstream defaults and are not in any leg (2026-09-28, run from a
    components-only binary): `DefaultSearchManagerTest` (3, the default is
    DuckDuckGo), `SearchEngineChoiceServiceTest` (5) and
    `SearchEngineChoiceServiceDisplayStateRecordTest` (1, a Google default and
    the region), `SearchEngineChoiceEligibilityTest` (6) and
    `SearchEngineChoiceEligibilityOnRestoreTest` (2, eligibility outside the
    EEA), `RegionalCapabilitiesServiceProgramDeterminationTest` (4) and
    `RegionalCapabilitiesServiceTest.GetCountryAndProgramCommandLineOverride`
    (the program outside the EEA), `TemplateURLPrepopulateDataTest` (3, a
    Google fallback and the EEA list sizes applied to every country), and
    the `LoadedTemplateURLServiceUnitTestBase` fixture's six users (its
    setup counts the regional list, which DuckDuckGo joins where it was not
    in it). Rewriting them to Stedding's defaults is open; a change to either
    hunk is checked against this list by running those suites.
52. **On the Mac, the event generator's drag runs past its target.**
    `ui::test::EventGenerator::MoveMouseTo(point, count)` re-bases every step
    on the point it has just sent, so the pointer mid-drag runs far beyond
    `point` and only the release lands where asked; a test that looks at
    anything during a drag, or at a small drag threshold, measures the
    wrong thing and can still pass. The Stedding browser tests drag and
    click the sidebar through `stedding::test::SendLeftMouse` and
    `ClickLeftMouse` (`chrome/test/stedding/sidebar_test_util.h`), which hand
    each event to the window's root view in even steps; a single
    `MoveMouseTo(point)` followed by a click is fine. Two more traps in the
    same tests: `WaitForRowsToSettle` before a click (a row still growing
    covers its neighbours), and never open `chrome://settings/clearBrowserData`
    to drive a deletion by message (the dialog's own start-up drops any
    reply still pending; open `chrome://settings` and send
    `initializeClearBrowsingData` first). Six browser tests running at once
    on this Mac also make Chromium's own clearing of the network history,
    part of a cache deletion, take longer than a test may wait; a test that
    deletes data asks for cookies alone. Two more: a background tab's
    renderer runs at a low priority on the Mac, so waiting for a background
    tab to load can take half a minute (open it in the foreground, or do not
    wait); and the rail expands on hover only in the active window, so the
    rail and hover fixtures run one at a time (`SERIAL_BROWSER_TESTS`, trap
    88), since with several a test's window can lose focus to another's. And three found on
    2026-09-29: the generator's click reaches the window's views but not a
    page's content on the Mac, so a test cannot press a button inside a
    page that way (use `content::SimulateMouseClickAt`, which skips the
    window, or an interactive_ui_test); a row drag through `SendLeftMouse`
    does work, and its press makes the dragged tab the active one, as a
    person's does, so a test of what a drag keeps compares with that tab
    first; and a negative check -- a fix taken out, built, the test seen
    red -- leaves its objects behind: rebuild after putting the fix back,
    before any run that is to count.

53. **`gclient sync --no-history` shallows a new clone, not an update.** An existing
    shallow dependency is brought up with a plain `git fetch --prune --no-tags origin`
    over every branch, which pulls each branch's whole history down to the shallow
    boundary. The Windows checkout's move from 153.0.8010.12 to 155.0.8059.12
    (2026-09-29, 18 minutes, `tooling/sync-chromium` in its Windows mode) took the
    source tree from 26 GB to 46 GB -- `v8` alone was a 1.3 million object pack, and
    `gclient` said "STALL DETECTED" while it was indexed -- and, while it ran, the
    volume's free space fell 60 GB below the figure it settled at, in the packs being
    received and the garbage collection after them. So budget a milestone on Windows
    for the tree's full history, keep the Mac's 150 GB floor, and do not read the
    free-space figure a minute in as the last one. The other way is to clone the
    dependencies again from nothing, which costs a download and the dependencies'
    working trees but keeps them shallow.

54. **A full Windows build at siso's default parallelism runs out of memory.** On a
    32-thread machine with 32 GB (page file 16 GB growing to 48), the first build of
    the M155 tree ran 32 steps at once and, five minutes in, failed in ways that read
    like six different bugs: 46 "LLVM ERROR: out of memory" from clang-cl, `MemoryError`
    and `OSError: [Errno 22]` from `pickle.load` in Blink's Python binding generators
    (each process loads the whole Web IDL database), "the paging file is too small"
    (WinError 1455), "Insufficient system resources" (1450), even the Go runtime under
    siso unable to allocate -- and the shell the build was started from died with the
    same error, which orphaned siso and its compilers past the budget. None of it is
    the code. Cap the steps (`tooling\win\build.ps1 -Jobs 20`, whose progress line
    shows the commit charge against its limit), run each budgeted chunk as its own
    detached process rather than as a child of the tool that watches it, and stop an
    orphaned tree with `taskkill /F /T /PID <siso>`. The page file also grew by 32 GB
    on the way and keeps that space until the machine restarts, so free space after a
    failed run is not free space after a clean one.

55. **Tests written on the Mac carry the Mac.** The first Windows run of the series
    (2026-09-29) compiled everything but three test files and ran the unit sweep and
    the browser tests; every one of the eight things it found was in a test, none in
    the product. What to look for before the next port: `<windows.h>` defines `far`
    and `near` as nothing, so a local of that name stops parsing; `FilePath::Append`
    takes no narrow literal where a path is wide (`AppendASCII`, or
    `FILE_PATH_LITERAL`); `FilePath::value()` joins with a backslash, so compare
    through `NormalizePathSeparatorsTo('/')`, never to a slash literal;
    `ui::EF_COMMAND_DOWN` is the Windows key, and the selection and chord modifier is
    `ui::EF_PLATFORM_ACCELERATOR`; a chord's text is `⇧⌘K` on the Mac and
    `Ctrl+Shift+K` elsewhere; `chrome::DIR_USER_EXTERNAL_EXTENSIONS` exists on the
    Mac and Chromium Linux alone; the Space swipe is the Mac's until WIN-12; and a
    tab found by its title is lost as soon as it loads its page, which on Windows is
    at once (a tab a close makes active starts its page), so keep its handle. A test
    that asserts one platform's behaviour says which (`#if BUILDFLAG(IS_MAC)` with the
    reason beside it), and the platform without it gets a case of its own or a
    WIN- id in the 2026-09-26 audit, not a skipped line.

56. **A Windows test binary started straight from a bash script under an agent's tool
    fails the tests that need a really active window.** On 2026-09-29
    `tooling/dev test browser --no-build` failed the same four of 150 on every run --
    `SidebarClickTest.EveryPartOfEveryRowSelects`, the three `TabDropTest` drags, and
    sometimes `SleepInUseTest.LeavingASpaceAndSleepingOthersKeepWhatIsInUse`, whose typed keys never
    reached the page -- while the same binary with the same arguments passed all 150
    whenever `timeout` was its parent (`timeout N exe`, `timeout --foreground N exe`),
    when it was detached from the tool, and from a hidden `cmd`. Ruled out: the
    flags, the working directory, `lib.sh`'s environment, the temp file, stdin, the
    `--gtest_list_tests` pass, job membership (both are in the tool's job), the real
    pointer (it does not move in either mode) and the process group. Why is not
    understood; trap 67 has the likely reason for the drags. `tooling/dev` runs its binaries through `timeout` on Windows
    (`STEDDING_TEST_BUDGET_S`, 900 by default, which is also the 15-minute cap), and
    anything else that starts one from the tool's shell should do the same or start it
    detached. A Windows run that fails exactly these tests is this, not a regression.

57. **An ASan build's assembler never finishes three files, and every chunk ends with
    "FAILED" steps that are not errors.** `nasm` is built with the same args as the
    rest, so in `win-asan` it is ASan-built, and on Windows ASan records a stack for
    every allocation with its slow unwinder. `tx_float.asm` (ffmpeg), `itx16_avx2`
    (dav1d) and `highbd_sad4d_sse2` (libvpx) allocate millions of times: each passed 20
    minutes of CPU without finishing, where the release assembler needs 37 seconds under
    load. A 15-minute budget kills them, so the last chunks each ended with those steps
    as the only `FAILED:` lines, and the build could not reach a link while they were
    outstanding. Copying the release `nasm.exe` over the ASan one does not hold: siso
    sees the output changed and relinks it.
    `ASAN_OPTIONS=malloc_context_size=0` in the build's environment brings each to
    about 3.5 minutes; `tooling\win\build.ps1` sets it for any args file with
    `is_asan = true`. The test runs want the options the other way round, with a
    symbolizer -- and ASan splits `ASAN_OPTIONS` at a `:` as well as at a space, so a
    drive letter ends an option and the run dies with "expected '=' in ASAN_OPTIONS":
    `handle_abort=1:detect_odr_violation=0:symbolize=1:external_symbolizer_path='C:/.../llvm-symbolizer.exe'`,
    the path in single quotes. `STEDDING_TEST_OUT=win-asan` points `tooling/dev`'s
    sweeps at that output directory.

58. **Thousands of passing test runs had not used the product.** The first real use of the
    Windows build -- a fresh profile, the pointer and the keyboard, light mode and dark --
    found five faults in half an hour. The welcome flow, a tooltip and three command-bar
    rows wrote the Mac's keys and prompts ("on this Mac", "macOS asks once to confirm",
    "New Tab (⌘T)", "⌘W on a pinned tab puts it to sleep"); in light mode the inactive rows'
    text was a pale grey on the sand ground, about 1.2:1 (a contrast recipe read a transparent
    fill as black; the fix measures it against the ground, 6.5:1 on the rebuilt window);
    the command bar runs past the window's right edge in a narrow window; the "Continue where
    you left off" infobar and the card's 6 DIP gutter stay in full screen; a Space chip shows
    two hover names. None of them could have failed a test that did not ask the question.
    The same pass proved by hand what the suites proved by proxy: 8 of 8 clicks on rows in the
    open sidebar and 7 of 7 in the rail selected their tab, a drag onto a folder header and
    onto a Space chip landed, Alt+digit and Ctrl+Alt+arrows switch Spaces, the clean-link and
    Markdown keys write the clipboard, the page screenshot key writes a PNG and an image on
    the clipboard, a video's full-screen button works and Esc leaves it. The wording and the
    light-mode text are fixed (patches 0057 and 0042); the other three went to
    `BACKLOG.md`: S-68 (fixed in patch 0057), S-69 (its gutter half fixed in 0059) and
    S-70. Rule: use the build before the long
    runs, with `tooling\win\drive.ps1` (`docs/AGENT-LOOP.md`, "Order of evidence").

59. **A disconnected remote-desktop session fails the tests that need an active window.** At
    03:04 on 2026-09-30 the three `TabDropTest` drags failed in the release build and under
    ASan alike, and `qwinsta` said the session was `Disc` and `GetForegroundWindow` returned
    nothing. Reconnected, the same tests passed in every build. It looks like trap 56 (the
    same tests, the same symptom) and is not: there the session was live and the launch
    context decided it. Before calling one of these tests a regression, run `qwinsta` and
    see `Active`. A run meant to go on overnight needs the session kept connected; a
    window a test opens is, for the operator at the screen, a black rectangle for the few
    seconds it lives, and a slow build (ASan) keeps it up longer. Seen again on 2026-10-14:
    disconnected, 104 of 107 browser tests passed, four at a time and one at a time alike,
    and the three that failed were the drags (`TabDropTest` and `SidebarClickTest`'s row drag:
    no window is under the pointer). `tooling/dev` warns, and runs every test: the drags
    then fail. On the checked
    build (`win-checks`) two more things went wrong while disconnected: three `SpaceJarTest`
    cases passed and then failed at exit with a dangling `Profile` (freed by
    `ProfileDestroyer::Timeout`, the renderers not gone in time; the same with the day's
    change taken out), and `SidebarFormsTest.FullScreenIsEdgeToEdge` missed its full-screen
    step. Connected, both
    were clean on the same build. Do not chase either before `qwinsta` says `Active`.

60. **A check that aborts at its first failure hides the rest, and a build with DCHECKs on
    found twelve defects in a tree whose suites were green.** With `dcheck_always_on` and the
    dangling-pointer detector, 145 of 150 browser tests crashed at the same line -- and after
    that line was fixed, at the next, over a dozen rebuilds, before the method changed: print every
    distinct failure per run (`--test-launcher-print-test-stdio=always`, or a local edit that
    logs where the check would abort, reverted afterwards), read them through
    `tooling/digest-sanitizer`, fix in batches. What it found, for the next person to look for:
    (a) `BlendForMinContrast` needs an opaque background; Stedding's transparent row fill
    and translucent active tint violated it in two places (the colour recipes, and
    `TabStyle::GetContrastRatioValues` in the horizontal strip); (b) a recipe that is not
    invariant is first handed the same id from the mixers below, so Chromium's own recipe for
    it runs, DCHECK and all, only to be thrown away: lead an override with a plain colour
    (`ColorRecipe::Invariant()`); (c) a `Label` on a layer that is not opaque must draw
    grayscale text (`SetSubpixelRenderingEnabled(false)` with `SetSkipSubpixelRenderingOpacityCheck`),
    or Label DCHECKs on paint; (d) every focusable view needs a role and an accessible name,
    the Space title row and the Space rename field had none; (e) `raw_ptr` members of a test
    fixture that point into the window must be cleared in `TearDownOnMainThread`, which runs
    before the window closes, or the detector reports them when the fixture is destroyed;
    (f) a container of `raw_ptr`s to child views is cleared before the views go, not after;
    (g) when the unpinned container is destroyed on the switch to horizontal tabs, the Clear
    line and the New Tab row it owned must be nulled in `TabStripView` (this was the real
    dangling pointer, WIN-1 and SPC-3); (h) quiet permission prompts and adaptive (CPSS) ones
    are one setting's two choices, and Stedding's "quiet by default" left both on, which the
    settings page DCHECKs; (i) a renderer-initiated `NavigateParams` needs an
    `initiator_origin`; (j) a destructor that deletes files (`ScopedTempDir`) blocks, so a
    `ScopedAllowBlockingForTesting` has to outlive it. ASan, run first and for five hours,
    found one use-after-free, in a unit test that read a deleted Space's id, and made
    `RemoveSpace` take its id by value. Order the runs by yield per hour: the DCHECK build
    first.

61. **Two browsers from one executable with the same `--remote-debugging-port` leave the
    second with a window and no UI.** A fresh profile launched while a scratch browser from
    the same build still held port 9222 showed a black rectangle where the welcome flow
    belongs, with a browser process, a GPU process and renderers all idle and nothing for UI
    Automation to find; DevTools calls answered for the first browser. It read as a
    regression for ten minutes. Stop the first browser (by profile path, trap 40), or give
    each its own port (`. tooling\win\drive.ps1 -DebugPort <n>`; `Drive-Launch` uses it).

62. **A second Windows release on the same Chromium pin has the same file version as the
    first, and the installer reads it as a repair.** The installer's version is
    `chrome/VERSION`, which the pin sets, so beta 10 and beta 9 are both 155.0.8059.12. Chromium's
    `setup.exe` compares versions and, for equal ones, repairs in place: with nothing running it
    copies the new files over the old (`INSTALL_REPAIRED`); with Stedding running it cannot replace
    the version folder, rolls back and reports `SAME_VERSION_REPAIR_FAILED` ("Chrome repair failed as
    Chrome was running", `chrome/installer/util/util_constants.h`), changing nothing. It is versions
    that differ which install beside a running browser (the new folder is added, the old one stays
    and `new_chrome.exe` takes over at the next start), which is how beta 6 to beta 9 went. So:
    quit Stedding first, and say so in the notes; `tooling/win/test-installer.ps1` refuses to
    upgrade, install or uninstall while one runs, and logs the sha256 of `chrome.dll` before and
    after, because the version resource cannot tell the two releases apart. The real fix is
    `S-72`: a file version of Stedding's own for every Windows release, never lower than the last
    one a profile ran (Chromium's downgrade manager reads a lower number as a downgrade), with the
    About line's Chromium number read from the pin and not from `chrome/VERSION`. It landed in
    patch 0073 (beta 19): a later release now installs beside a running Stedding, and only an
    installer of the version already installed still repairs.

63. **A synthetic two-finger swipe that sets the line delta travels eight times as far.**
    `CGEventCreateScrollWheelEvent` in pixel units sets the event's point delta; setting
    `kCGScrollWheelEventDeltaAxis2`, the line delta, as well makes macOS recompute the point
    delta as eight times the lines: `NSEvent.scrollingDeltaX` read 40 for a 5-point step. The
    helper that posted the round 11 swipes did that, so a "short" swipe of 60 points went 480,
    switched Spaces, and the shot taken mid-swipe showed the list gone (2026-10-02). A trackpad's
    line delta is about a tenth of its point delta: post the point delta and the phases only,
    and read a synthetic event back through `[NSEvent eventWithCGEvent:]` before trusting what
    it measures.

64. **Arc takes ⌥⌘N from any app while it runs.** A drive's ⌥⌘N opened a Little Arc window
    and brought Arc to the front, and the rest of that run's keys went nowhere, Stedding no
    longer being frontmost (2026-10-02). Quit Arc before a drive that uses the chord, or reach a
    split from the tab menu ("New Split View with Current Tab"); `S-79` is the product side.
    Since 2026-10-18 the menu's split chord is ⌃⌘N, which Arc leaves alone: drive the split
    with it on a build that has it.
    In the same run `drive-window.py` refused a second click at the point of the first, "covered
    by Window Server's window": the pointer's own window is the topmost one there. Since
    2026-10-18 the guard passes over that window (trap 95).

65. **A stall is measured, not guessed.** A Space switch on the owner's profile (hundreds of
    tabs, dozens of folders) showed nothing for 450 to 700 ms. One `sample <pid> 3 1 -file <out>` started in the
    background just before the key, its main thread read as a tree under the slow call
    (`SpaceModel::SetActiveSpace`, then `Widget::ThemeChanged`), named both causes in one run:
    every row set its title's font again, and a label asks for a layout whenever that happens,
    so the whole list was laid out once per row; and every row in a folder drew the folder's
    glyph from macOS's symbol again (spaces B36). Time an action from window captures taken in
    process (`CGWindowListCreateImage` by window id, every few milliseconds), not with
    `screencapture`, which takes half a second a shot.

66. **A browser test that crashes at "CompleteShutdown took more than 30 seconds" is the machine,
    not the code.** The harness gives the browser's thread pool thirty seconds to stop; with
    other jobs holding this Mac at a load of about 400 and swap full, sixteen of the first
    twenty-nine browser tests of a sweep crashed there ("ThreadPool currently running tasks:
    none"), tests the change did not touch among them, and the whole suite passed, 160 of 160,
    once the load fell (2026-10-02). Read `uptime` and `sysctl vm.swapusage` before reading a
    sweep; wait for a quiet machine rather than retrying, and never stop other sessions' jobs.

67. **Browser tests started over SSH need the signed-in session at normal priority, and their
    drags need the foreground.** From the Mac, `ssh` to the PC lands in PowerShell, and what it
    starts, even detached through WMI's `Win32_Process Create`, runs in session 0, where every
    browser test failed waiting for its window to show (`widget_test.cc(277)`). A scheduled task
    with an interactive token (`schtasks /Create ... /IT`, then `/Run`) runs in the operator's
    session, but Task Scheduler starts it below normal priority, and Chromium's test suite stops
    before it lists a test (`Check failed: !IsProcessBackgrounded()`, `base\test\test_suite.cc`).
    The task's script raises itself first, `(Get-Process -Id $PID).PriorityClass = 'Normal'`,
    and what it starts inherits that. That raises the processor priority only: the task's
    disk and memory priorities stay low unless the task itself is made at priority 4 (trap
    99). Even then the four tests that drag a row
    (`SidebarClickTest.EveryPartOfEveryRowSelects` and the three `TabDropTest` drags, trap 56's
    set) failed there on every run, most likely because Windows gives the mouse capture a drag
    needs only to the foreground window, and a task's window may not take the foreground from
    the window the operator left in front (2026-10-02). Run those at the desk, or say they were
    not run. Such a task is created only with the operator's yes, and deleted when its run ends.

68. **On Windows at a display scale other than 1, a click from `ui::test::EventGenerator`
    lands in the wrong place.** The generator hands the window a point already in DIPs, and
    aura scales a located event by the display's scale once more on its way in
    (`WindowEventDispatcher::TransformEventForDeviceScaleFactor`). On the PC's 4K display at
    150 % every generated click landed at two thirds of where it was aimed: sixteen click tests
    failed with "the click landed on the row of tab 0" (the hit test before the click) while
    the tab stayed unselected, and the same sixteen passed with `--force-device-scale-factor=1`
    (2026-10-02). A real click arrives in pixels and is scaled once, so this says nothing about
    the product. The click fixtures run at scale 1 off the Mac
    (`stedding::test::ForceScaleOneForEventGenerator`); a new fixture that clicks through the
    generator calls it too. `TabDropTest` hands its events to the root view and is not affected.

69. **A pointer at "the window's edge" from `GetWindowRect` is outside the window.** On
    Windows 10 and 11 the rectangle includes the invisible resize border, about 7 px on each
    side: a pointer moved to its left + 1 sits on that border, where the frame answers HTLEFT
    and no view hears the move. The first test of the hidden sidebar's edge said "it does not
    open" for exactly that reason (2026-10-10). Aim at the visible bounds,
    `DwmGetWindowAttribute(DWMWA_EXTENDED_FRAME_BOUNDS)`, which `Drive-VisibleRect` in
    `tooling\win\drive.ps1` returns; in a maximized window the screen's edge is the client's.

70. **The build supervisor stops with SUPERVISOR_EXIT=6 when `build.ps1` refuses to start.**
    `build.ps1` throws before building when a browser from the output directory is still
    running (it would hold `chrome.dll` and the link would fail). The supervisor used to die
    with it and write no finish line, so a waiter waited for one that never came
    (2026-10-10). Stop your own test browsers by profile path before a build; never the
    operator's.

71. **A Windows Security prompt holds the foreground, and `drive.ps1` refuses every input
    while it does.** A firewall prompt (`PickerHost.exe FirewallNotificationDialogServer`)
    appeared during a run and every step was refused ("the foreground window is not the
    browser under test"), which is the guard doing its job (2026-10-10). Answering it changes
    a security setting: that is the operator's. Say so in one line and work on what needs no
    screen until it is gone.

72. **A `raw_ptr` to a view inside a widget you own dangles when your object goes.** A dialog
    delegate that owns its widget (`CLIENT_OWNS_WIDGET`, a `std::unique_ptr<views::Widget>`
    member) and keeps a `raw_ptr` to a view in that widget's tree frees the view while its
    members are destroyed, and the `raw_ptr`, released after, still points at it. Nothing used
    it, so the release build never crashed; the dangling-pointer detector stopped three welcome
    flow tests on it (2026-10-11, `WelcomeDialog`, fixed in patch 0015). Null such a pointer in
    the destructor's body, or declare it after the widget so it goes first. Only a
    `win-checks` build sees this.

73. **`-Wunsafe-buffer-usage` is an error in this Chromium: a test that indexes a plain C
    array in a loop does not compile.** All of `chrome/` but a few exempt directories is
    checked for unsafe buffer use (`build/config/unsafe_buffers_paths.txt` in the
    checkout) and warnings are errors, so `kRows[i]` over a `constexpr int kRows[]` stopped the first build of patch
    0060 (2026-10-11, `FolderViewTest.HeaderMenuOffersNewTabAndAlphabetize`). Declare the
    table as a `std::array`, or `constexpr auto kRows = std::to_array<int>({...})`, whose
    `operator[]` is checked, or loop with a range `for` when the index is not needed.

74. **The DCHECK build at the supervisor's default of 22 jobs ran out of commit on the PC.**
    Trap 54's cap is not one number: it depends on what else holds memory. On 2026-10-11 the
    `win-checks` build of patch 0060 at 22 jobs (`build-until-done.ps1`'s default) failed 22
    steps after 28 minutes, the compiler dying on a signal on 20 objects, most in files the
    round had not touched: the commit charge had run out, with about 10 GB of the 53 GB
    limit free at idle. A rerun at `-Jobs 16` finished it in five minutes. A compiler killed
    on a signal in several unrelated files is memory, not the code: read the commit charge
    at idle and in the progress line before choosing `-Jobs`, and give `win-checks` 16 or
    fewer when most of the limit is taken before the build starts. The supervisor's default
    is 12 since.

75. **A row container that lays out in view order draws a reorder only if it reorders its
    views.** `TabCollectionNode` adds each child's view at the end and, on a move, reorders
    only its list of children; Chromium's own containers lay out from that list
    (`GetDirectChildren()`), but `FolderView` used a `BoxLayout`, which follows view order. So
    a folder sorted by Alphabetize kept drawing its old order while every model check passed
    (2026-10-11, found by a browser test that read the drawn rows' bounds). `FolderView` now
    puts its rows in the node's order before it lays out. Any new container that lays out by
    view order needs the same, and its test must read drawn bounds, not the model.

76. **`Drive-Find` takes the first big window of the process, which can be a dialog.** On a
    fresh profile the welcome flow's dialog is a `Chrome_WidgetWin_1` wider than 300 px, so the
    driver attached to it; when the flow finished, every shot said "the window is not on
    screen" and UI Automation failed on a dead handle (2026-10-11). Launch with
    `--no-first-run` unless the flow is the subject, and call `Drive-Find` again after a
    dialog closes. Chromium's own search engine chooser (S-134) takes the window the same way
    after a skipped engine step in beta 17 and earlier, and on a profile that finished the
    flow before 2026-10-18 with no engine recorded.

77. **A test that starts failing between two runs may be the machine: rebuild the last good
    code before bisecting the new.** On 2026-10-11 three drag tests (`TabDropTest.*`) passed
    at noon and failed every run an hour later on the release build, with the machine idle, no
    key held and the cursor parked away. Reverting the new code's one suspect line changed
    nothing; setting the whole round aside and rebuilding patch 0060's own code (copy the
    files out, `git checkout HEAD --` them, build, test, copy back and `touch` them so the
    next build sees them) failed the same three, so the cause was this PC's state, not the
    round. Do that check first: it costs one incremental build. The remote-desktop display
    had reconnected many times that day (its display was the seventeenth of the session).

78. **The real cursor over a test window's sidebar fails the hover and edge tests.** The
    sidebar expands on hover and the hidden form's edge re-checks the real pointer, so four
    tests (`SidebarFormsTest.TheRailAndTheLeadingEdge`, `.TheEdgeDoesNothingInFullScreen`,
    `SidebarRailTest.TheFormFollowsTheWidthAndOneHoverHandler`, `.ADriftedPinShowsTheDotOrTheSlash`)
    failed when the cursor rested near the screen's top left, where test windows open, and
    passed with it parked in the bottom-right corner (2026-10-12). Park the cursor before a
    browser-suite run, and only while the operator is idle: `tooling/dev` does it on Windows
    through `tooling/win/park-cursor.ps1`, which leaves a cursor in use alone (the earlier
    parking lived in uncommitted scripts, and the suite failed the three again on
    2026-10-14 after a live check left the cursor mid-screen).

79. **A `base::test::RunUntil` check must only look, never wait.**
    `FolderTabsTest.TheHeadersMenuSortsAndOpensATab` called a helper that runs a loop of
    its own (`WaitForRowsToSettle`, inside `DrawnRow`) from `RunUntil`'s condition. Windows
    got away with it; on the Mac the nested loop, entered from the message pump's pre-wait
    observer, never returned, and the test timed out every run (2026-10-12). Settle before
    the check; inside it, only lay out and find (`RunScheduledLayout`, `FindDrawnRow`).

80. **A filter part that names a test of one platform stops `tooling/dev test` on the
    other.** The screenshot filter named `SteddingStringsTest.*`, whose one case was built
    off the Mac only; the Mac's `unit_tests` had no such test, and the guard that refuses a
    filter part matching nothing stopped the whole sweep before it ran (2026-10-12). Give
    such a class a case on every platform (here the Mac's "Show in Finder"), or put a suite
    only one platform builds in that platform's own table (`MAC_FEATURE_FILTERS`,
    `WIN_FEATURE_FILTERS` in `tooling/dev`), and build a new filter on both machines before
    the release that needs it.

81. **A bubble placed while a Mac test window is still moving keeps the old place.**
    `AddressBandTest` moves its window in `SetUpOnMainThread`; the undo toast that showed
    moments later was placed against the window's old origin, its top above the window's own
    (y 25 against 33), and the test read it 12 to 40 DIP high, a different number each run
    (2026-10-12). A bubble follows its window only when the window moves after it shows. Put
    test windows in the screen's work area, not at (0, 0) under the menu bar, and call the
    bubble's `SizeToContents()` before measuring where it sits.

82. **`tooling/drive`'s `hover` jumps the pointer; leaving a view needs a path.** A hidden
    sidebar slid in at the window's edge did not slide away when the next `hover` put the
    pointer in the middle of the page, and did when the pointer went there in eight steps:
    `hover` posts one move, and a hand never jumps (2026-10-12). Move along a path to check
    anything that reacts to the pointer leaving; and in the command bar, select its text
    (`key a+cmd`) before typing, or the last text stays in front of the new.

83. **A file put back from an archive keeps its old time, and the build skips it.** To
    prove a test red, the fixes were saved with `tar`, taken out, built, and extracted
    again; `tar` restores each file's modification time, which was older than the objects
    the red build had just made, so the green build compiled nothing and the old code ran
    again (2026-10-12). `touch` every file put back, or copy it with a fresh time.

84. **Browser tests pretend an OAuth client exists; a Stedding build has none.**
    `ChromeTestSuite` calls `SetIgnoreMissingOAuthClientForTesting`, so in every browser
    test browser sign-in is allowed (`signin.allowed` true), where in a build it is not.
    A test of what the build does without sign-in passed for the wrong reason, or failed
    against a fix that works (2026-10-12): append `--allow-browser-signin=false` in
    `SetUpCommandLine` to put the test where the build is (`QuietStartTest`).

85. **A firewall that asks per program holds a newly signed build's connections.** On the
    Mac an outgoing firewall asks before a program it has not seen connects, and every
    signed build is a new program to it: `verify-build`'s network check waited behind the
    unanswered question and timed out, and the probe took 75 s instead of 7 (2026-10-12).
    The question is the operator's to answer; run `verify-build --offline` and say so in
    the notes, and count the questions left on screen for the operator. From M156 a held
    connection also costs the quit. At shutdown Chromium waits up to 10 s for the network
    service to exit, and M156's new shutdown watchdog (`chrome/browser/shutdown_watchdog_mac.cc`)
    ends any quit that takes 10 s with a dump and `RESULT_CODE_HUNG`; `tooling/drive` then
    reports that the pid "did not quit". On 2026-10-16 the ad hoc build did that three times
    in three after a few Settings pages. The same steps on a Developer-ID-signed copy of the
    same build, which the firewall lets through, quit in 2 s. The dump goes to the real
    data folder's `Crashpad/pending`, whatever `--user-data-dir` says, so move a test's
    dumps out of it: `S-66` reads that folder for the owner's crashes.

86. **A layout that is right at rest can be wrong for the length of an animation.** The
    tests settled the sidebar before they measured, and every steady form cleared the Mac's
    traffic lights; the operator saw the lights on Back and Forward in a test window, while
    a hidden sidebar opened and its strip was still narrower than the lights, a state that
    lasted seconds on a loaded Mac (2026-10-13). Seven live repros of steady states found
    nothing. Two things found it: capturing the test processes' own windows a few times a
    second while the suite ran (by window id and owner name, nothing else on the screen),
    and a test that steps the animation by hand
    (`BrowserAnimationController::SetAnimationContainerForTesting` with an
    `AnimationContainerTestApi`) and checks every step
    (`WindowButtonsTest.OpeningAHiddenSidebarKeepsTheRowOffTheLights`).

87. **A test that fails one run in three can be the product's race, not the machine: log it
    before trap 77's rebuild.** `TabDropTest.ChipDropsMoveLightAndSurviveARebuild` lost its drop one
    run in three or four on 2026-10-14, on the round's code and on the code before it. A
    `LOG(ERROR)` in each of the drag target's calls and in the chip hit test, run until it
    failed (a loop over the one test with `STEDDING_TEST_LOG` keeping each run's output),
    showed the chips at 0x0 in the failing run: a theme change had rebuilt them between two
    drag passes, a new view has no bounds until the next layout, and the one drag event that
    reached the chip found none. The product had the same gap, one frame wide (a release in it
    dropped nothing); the fix and its own test followed. Six runs found it, where a rebuild of
    the old code alone would have blamed the machine.
88. **Most browser tests share the desktop; a few cannot, and a covered window fails a
    drag.** The browser suite ran one test at a time until 2026-10-14 (208 s for the whole
    suite). Run four or eight at a time, every test passed except those that need the
    desktop to themselves: a row drag, the pointer over the window, keys through the window's
    accelerators or typed into a page, the clipboard, picture-in-picture, and a command bar
    held open across a wait (the bar closes when its window loses focus, so another test's
    window taking the focus left a pointer to a closed bar). A failure there looks like a
    30 s timeout. They are `SERIAL_BROWSER_TESTS` in `tooling/dev`, run one at a time after
    the rest run four at a time on Windows (one at a time on the Mac, until it is measured
    there); eight jobs also slowed every test by contention. One more
    cause took an hour to see: a tab drag asks Windows which window is under each point
    (`WindowFinder`), and a new test window does not always get the foreground, so it can
    open behind the agent's own window, which covers the screen; the drag then finds that
    window and drops nothing. A screen capture every three seconds during the run showed it.
    Drag fixtures call `stedding::test::KeepAboveOtherWindows` on their widget (z-order needs
    no foreground right). A new fixture that drags, hovers, types or needs its window in
    front goes on the serial list. The leg prints two counts that overlap: "N tests for
    all" (or "for browser") is every test, and "M tests for serial" the ones among them it
    runs one at a time at the end, so the leg runs N tests, not N + M. Betas 15 to 17 were
    first reported with the two added up (2026-10-18, corrected in the notes).

89. **`tooling/apply-patches` rewrites every file the series touches, and the build then
    recompiles for hours.** On 2026-10-15 the Mac's checkout held an older 0062 and neither
    0063 nor 0064; applying the series again would have rewritten about 400 files, and
    `apply-patches` refuses while the branding is applied anyway. What moved it, rewriting
    the 84 files that differed: build the series' commits in a temporary index on the pin
    (for each patch `git mailinfo -b`, `git apply --cached`, with `--3way` when that fails,
    `git write-tree`, and `git commit-tree` with the patch's author and date), then
    `git read-tree -m -u <old tip> <new tip>`, which rewrites only the files whose content
    differs and leaves the branded files as they are, then move `stedding-work` and
    `refs/stedding/applied` to the new tip. `tooling/update-patches` writing no change
    afterwards proves the tree is the series.
90. **A hook in a header much of the tree includes costs a rebuild of most of it.** Patch
    0067's first draft added a method to `NavigationController` and to
    `SessionStorageNamespaceHandle`, a field to `NavigateParams` and a member to
    `BrowserView`: about 11,800 build steps on the PC and as many on the Mac, hours each,
    because `browser.h` includes `browser_navigator_params.h`, and
    `render_frame_host_impl.h` includes `storage_partition_impl.h`, which includes
    `platform_notification_context_impl.h`. The same fixes then went into a header of
    Stedding's own (`content/public/browser/stedding_session_storage.h`), `.cc` files, a
    scoped marker in `new_tab_space.h`, and a key handler its window owns; the Mac's next
    build ran about 1,100 steps, most of them redoing objects the first draft had built.
    Count a header's includers (`git grep -l` on its path) before adding to it. Taking such
    an edit back is not free either: the restored header has a new time, so give it an old
    one (`touch -r` from an untouched neighbour), and delete the objects built while it was
    changed (`find out/<dir> -name '*.o' -newer <marker> -delete`, `*.obj` on Windows), or
    the next build mixes two layouts of one class.

91. **The Windows checks build is the only one that sees a pointer left dangling at a
    window's close.** Patch 0067's `AltGrChords` kept a raw pointer to its window's widget,
    which a browser window frees before its native window. Every browser test passed on
    `win-release`, where the stale pointer was only ever cleared; on `win-checks` the
    dangling-pointer detector stopped every test at its window's close, and the release
    build crashed at shutdown in one test two runs in four, with a stack that named
    nothing of Stedding's (identical code folding gives a release stack the wrong
    function names). The suite on `win-checks` (`STEDDING_TEST_OUT=win-checks tooling/dev
    test browser --no-build`) belongs to every round that adds a raw pointer on Windows,
    and a shutdown crash in a release run is read on the checks build, where the stack is
    true. Two failures it showed on 2026-10-16 are older than that round (`S-213`, `S-214`).
    And a `tar` made on the Mac for the PC carries `._*` files unless
    `COPYFILE_DISABLE=1` is set; they turn up as untracked files in the checkout there.

92. **M156 rebuilt the sidebar's region view; the rebase compiles long before it lays out
    right.** The move from 155.0.8059.12 to 156.0.8078.36 (2026-10-16) needed hand merges
    in 27 of 68 patches. `VerticalTabStripRegionView` now lays itself out through a
    `DelegatingLayoutManager` (`CalculateProposedLayout`) and holds its rows in
    `content_area_view_`, a `FlexLayoutView`. Stedding's switcher row, Archived row,
    bottom row and update pill go in that content area. The hover pill stays a direct
    child on a layer of its own. The rail's side margins are the content area's interior
    margin. The top row's height comes from the top container's `kMarginsKey` and from
    whether the layout lets that container be visible. Elsewhere:
    - `OnTabStripViewSet` / `OnTabStripViewWillClear` became `AddTabStripView` /
      `RemoveTabStripView`, and the state controller's logic moved to
      `vertical_tab_strip_state_controller_impl.cc`.
    - Upstream removed `kSigninPromoOnAvatarPill`; a feature of Stedding's own,
      `kSteddingSigninPromoOnAvatarPill`, now keeps the promo off.
    - `TabGroupHeaderView` colours its parts in `UpdateColors()`.
    - `TabRestoreService::RestoreEntryById` returns an optional.
    - `AutocompleteMatchType` is an enum class with kCamelCase names.
    - Upstream took toast ids 59 and 60, so Stedding's are 61 to 65. They are histogram
      values: append after upstream's and move `kMaxValue`.
    - A new WebUI lint rule (`lit-element-template-structure`) wants a ternary in a
      template to return an `html` literal in its true branch: invert the condition.
    - The engine list gained Perplexity, which needed a mark in the welcome flow.
    - New upstream tests assumed defaults Stedding changes (HTTPS-First starting
      disabled, the long tab menu). They now assert Stedding's defaults, in the patch that
      changes each default.
    - `gn check` refused the window layout's include of the region view's header, so the
      layout has a target of its own,
      `//chrome/browser/ui/views/frame:stedding_browser_view_layout`.
    - The content area is a layer that is not opaque. A label in it that draws subpixel
      text trips `Label::PaintText`'s DCHECK at a window's first paint (on 2026-10-17, 110
      of the 124 browser tests on `win-checks`), and on Windows it draws colour fringes in a
      release build (beta 16's Archived row had them). Stedding's rows there turn subpixel
      text off, as `tab_strip_view.cc`'s rows already did:
      `SetSubpixelRenderingEnabled(false)` and `SetSkipSubpixelRenderingOpacityCheck(true)`.
      So does a Chromium tab group's header, which Stedding draws as a row with no fill
      (patch 0066), and the Clear line's word, canvas text drawn with
      `gfx::Canvas::NO_SUBPIXEL_RENDERING` (2026-10-18, BACKLOG S-214).
      `FolderTabsTest.EveryLabelInTheSidebarSuitsItsGround` runs the DCHECK's own test over
      every label of the window without painting, so it finds a label left out in a release
      build too; canvas text it cannot see.

    What worked: `git rebase --onto <new pin> <old pin> stedding-work` with `rerere` and
    `zdiff3`; the compiler's whole error list in one pass (trap 50); the port's fixes
    folded into their patches by blame with `tooling/fold-fix`, which rewrites no file and
    so costs no rebuild; and the two machines' trees compared by hash after every fold.
    Then the window's states were captured beside the previous release
    (`tooling/capture-state --build b16ref` against a copy of the released app in
    `out/b16ref`). The captures show a row laid out in the wrong container; the suites do
    not. A chrome:// page cannot be named on the command line, because Chromium opens none
    named there and shows the new tab page instead; the first comparison's Settings,
    About and Archived captures were five pictures of the new tab page, identical in both
    builds. `capture-state` now refuses such an address as a URL, and since 2026-10-18
    opens it with `--page chrome://settings/stedding`, through the browser's local DevTools
    endpoint (`tooling/devtools-page`), with no input (`S-47`).

93. **A synthetic arrow key without `KEYEVENTF_EXTENDEDKEY` is the numeric keypad's.** The
    arrows, Home, End, PgUp, PgDn, Insert and Delete of the cluster are extended keys;
    `keybd_event` without that flag sends the keypad's key with NumLock off. With Alt held, a
    text field takes the keypad's arrow for the start of an Alt code
    (`ui::KeyEvent::IsUnicodeKeyCode`), the focus manager skips the window's accelerators for
    it, and nothing happens: `tooling\win\drive.ps1` sent every key that way, and Ctrl+Alt+→
    from the address bar "did not change Space" (`S-218`), where the arrow key itself does.
    The driver sends the flag since 2026-10-18 (`Drive-Key`). Any earlier driven result for a
    chord of Alt with one of those keys from a text field (Ctrl+Alt+←/→, Ctrl+Alt+↑/↓,
    Ctrl+Alt+Shift+←/→, Alt+←/→ in the address bar or the command bar) is suspect: drive it
    again before trusting it.

94. **A clipboard manager takes ⇧⌘C from every app while it runs, as Arc takes ⌥⌘N
    (trap 64).** Maccy, the clipboard manager on the Mac, owns ⇧⌘C system-wide by default, so the chord
    never reaches the browser: the live checks of 2026-09-05 went through the File menu's Copy
    Link row for that reason, and on 2026-10-18 the first driven run of TST-9's keys pressed
    ⇧⌘C and its capture showed no "Link copied" toast, where a later run showed it. A live
    keyboard check of Copy Link fails until the clipboard manager is closed. Ask the operator
    to quit it, and Arc, before the run (`docs/AGENT-LOOP.md`, "Ask once"), and when a chord
    does nothing, look at what else is running before blaming the build.

95. **On macOS 27 the pointer is a window, and a guard that asks what is on top finds it.**
    `drive-window.py` refuses a click unless the launched browser's window is the topmost one
    at the point. macOS 27 draws the pointer as a window of its own, owned by the Window
    Server and named "Cursor"; where the pointer already rests, as for a second click on the
    same spot or a click after a `hover` there, that window was the topmost one, and the click
    was refused as covered (seen on 2026-10-02 as "covered by Window Server's window", trap
    64, when hovering away was the way round it; seen again on 2026-10-18). The guard now
    passes over that one window, which never takes a click. Any check of what lies under a
    point needs the same exception.

96. **In macOS full screen a window point is not a screen point.** In the full-screen run of
    `S-154` on 2026-10-18, on the Mac's built-in display (1728×1117 points, with a notch), a
    `click 140 143` in `tooling/drive`'s window points selected the sidebar's second row, whose
    centre the run's `screen` capture shows about 215 points below the screen's top: there the
    window points started about 71 points below the top of the screen. That is measured once,
    from that run; what the offset is made of (the title bar macOS hides in full screen, the
    notch's band, or both) was not established. Move a point measured on a `screen` capture
    up by that much, and confirm the click with a capture after it.

97. **macOS 26's full-screen title bar draws a line of its own, and only a private switch
    turns it off.** The owner saw a one-pixel line across the whole window under the address
    row in full screen (`S-223`, 2026-10-18, on macOS 27.0.1). It is the hard edge of the
    scroll pocket (`NSScrollPocket`) that backs the full-screen title bar from macOS 26 on: a
    test's dump of the title bar's views showed a 0.5-point `Separator` layer in the pocket,
    and the pocket's `allowsSeparator` on. Setting the accessory's private
    `allowsAutomaticSeparator` off and the full-screen window's `titlebarSeparatorStyle` to
    none left the line in eight test runs; only the pocket's own private `allowsSeparator`,
    set off, removed it (`HideTitlebarPocketSeparators` in `immersive_mode_controller_cocoa.mm`,
    asked again whenever the title bar may lay its pocket out anew, and guarded, so a macOS
    without the pocket is untouched). For a line under a title bar on macOS 26 or later, look
    for a pocket before a separator view.

98. **On Windows `ui::test::EventGenerator` types the letter of every key it presses, Ctrl
    held or not.** It follows each key down with the plain letter's `WM_CHAR`
    (`DomCodeToUsLayoutCharacter`, which reads only Shift and Caps Lock), where Windows
    itself sends a control character for a Ctrl chord, which a text field ignores;
    `views::Textfield` takes the plain letter as text.
    `SpaceSwitchTest.TheCoreChordsAsKeysThroughTheWindow` pressed Ctrl+L, which opens the command bar with its field focused, and then Enter, and the
    tab went to a search for "l" (2026-10-18, the PC's first run of the round, in all three
    builds). A test that presses a Ctrl chord into a focused field on Windows dispatches the
    key events itself (a `ui::KeyEvent` down and up through the generator's `Dispatch`), as
    that test now does.

99. **On the PC, unit tests on mock time time out when their leg runs from the hidden
    scheduled task, and pass over SSH.** Trap 67's scheduled task, which the browser tests
    need, ran the unit leg 32 jobs at a time, and the same three tests timed out in each of
    four runs on `win-release` and `win-checks` (2026-10-18):
    `SidebarNoBackupTest.AnHourOfAWindowWritesNoBackup`, which fast-forwards an hour,
    `SleepTabsTest.SpaceTimerLeavesTabsInUseAwake` and `TabArchiverTest.TimerSweeps`. The
    same leg run over SSH passed every test, in seconds. The cause (found 2026-10-20): Task
    Scheduler starts a task at its default priority 7, which gives the task's processes a low
    disk priority (1) and memory priority (2), and the children inherit both; raising
    `PriorityClass` in the script (trap 67) changes neither. Every `FastForwardBy` waits for the
    thread pool to go idle, and there Chromium's own profile services were opening their
    databases on the starved disk, one load taking 30 s. Make the task at priority 4 right
    after `schtasks /Create`:
    `$t = Get-ScheduledTask -TaskName <name>; $t.Settings.Priority = 4; Set-ScheduledTask -InputObject $t`.
    So made, the unit leg passed 985 of 985 in 15 s on `win-release`, and 972 of 972 in 41 s
    with four disk writers running beside it.

100. **A test binary still running from an output directory makes the next link into it
    fail.** On 2026-10-18 the PC's `win-asan` build of the round's code stopped with
    `lld-link: error: failed to write output './stedding_browser_tests.exe': permission
    denied`: the previous ASan build's browser suite was still running from `out\win-asan`,
    its serial leg alone a quarter of an hour, and Windows does not let a running executable
    be overwritten. `tooling\win\build.ps1` refuses to start only while a `chrome.exe` of that
    directory runs; it does not look for a test binary. Wait for the suite's last line before
    building into the same directory; the rerun after the suite ended linked in under a
    minute.

101. **A theme change rebuilds the Space chips, so a test cannot hold them across one.**
    `SpaceSwitchTest.TheChipsStayTheSameViewsWhileTheSidebarAnimates` kept raw pointers to
    the chips through a collapse, to check that the change of form reuses them. On the PC's
    ASan build (2026-10-18, `S-106`) it read a freed chip, and its first expectation said the
    chip "was made again". The free came from a theme change in the middle of the collapse:
    the page-colour controller's notification, posted a turn after a colour change, reached
    `BrowserView::UserChangedTheme`, which rebuilds the switcher, as it should. The product was
    right, and only ASan saw the fault; unlike trap 87's lost drop it was the test's own. A
    test that holds views across a wait tracks them (`views::ViewTracker`) and takes them
    again after a theme change (a `views::ViewObserver`'s `OnViewThemeChanged`), as that test
    now does.

102. **A drag test that sends every move before any layout passes where a person's drag
    fails.** The sidebar's reorder moves rows while a drag goes on. `TabDropTest`'s `Drag` and
    `PressAndMove` send their twelve moves and only then let the window lay out, so every row
    is still drawn where the press found it. A row dragged from above onto a folder's header
    (in the rail, its glyph) made the reorder slide the folder up into the row's place at the
    first move: a person's
    pointer then arrived where the header had been, and the drop landed after the folder,
    while the test's pointer met the header still drawn under it and passed. Found by the
    installed builds' runs of 2026-10-18 (`tooling/acceptance/win/s173-live.ps1` tst7-3 on
    the PC, the same drop in the Mac's capture; `S-232`), with every header-drop test green.
    `TabDropTest::PointerPressAndMove` drags the pointer's way: thirty moves, the rows left to
    settle between two (`stedding::test::WaitForRowsToSettle`), as the live check's driver
    moves. Use it for any drop onto something the drag itself can move, and first assert that
    the rows are on screen whole (`ShownWhole`): in a short window or a scrolled list the drag
    aims at stale coordinates. The tests rewritten that way have not yet run.

103. **A page put to sleep may never answer DevTools, so every wait a driver makes needs a
    clock of its own.** Three runs of `tooling/acceptance/win/s173-live.ps1` on the installed
    build (2026-10-18, `S-233`) stopped for good at tst9-11, the first step with a tab asleep
    (Ctrl+W on a pin), where the runner reads the rows through UI Automation and the visible
    page through DevTools. That DevTools call had no time limit, and `Invoke-RestMethod`'s
    `-TimeoutSec` does not bound reading the answer (the driver's own notes). Since then
    `tooling\win\drive.ps1` gives each call a clock: `Drive-Eval` waits three seconds for a
    page and counts one that has not answered as not visible, `Drive-Pages` five for the page
    list, UI Automation and the clipboard run through `Drive-Bounded` (30 and 10 seconds,
    and a call left behind is logged as a TIMEOUT), and WMI queries take
    `-OperationTimeoutSec`. That the sleeping tab was the cause is not proven until a run
    passes tst9-11. A new wait on the browser, in a driver on either machine, gets a bound
    of its own and a log line before it.

104. **A page's title reaches the session file only when something else rewrites its
    entry.** Chromium writes a tab's navigation entry into the session at its commit, before
    the page has a title, and again only through `NavigationEntryChanged`: when the renderer
    sends the page's state (after a scroll, a form change, a history call, or as the page is
    left) or when the whole session is rebuilt. A title change alone fires only `TitleWasSet`
    (`WebContentsImpl::NotifyTitleUpdateForEntry`), which no session code heard. So a static
    page never scrolled was saved with an empty title, and after a relaunch its row, not yet
    loaded, read its file name ("d.html"). Found on 2026-10-18 re-reading the acceptance
    captures of step 1 and decoding the profile's `Sessions/Tabs_*` and `Session_*` files
    (`S-229`, tabs R31); `SessionTabHelper` now writes a first title at once and later ones
    at most every 5 seconds. A row the restore went on to load shows the page's own title and
    hides the fault: to see what a session holds, decode its files.

105. **A quit leaves every window it closed in Chromium's recently-closed list, though the
    next launch opens them again.** `UnloadController::OnWindowClosing` records each closing
    window as one WINDOW entry (`TabRestoreService::BrowserClosing`), a quit's windows too;
    "Continue where you left off" then restores the same windows, and the entry stays: ⇧⌘T
    straight after a relaunch opens the window a second time, in Chrome as well. Since a
    closed window's tabs became archive rows (`S-187`), every tab of the last session was
    listed as closed beside itself: the command bar showed "Page F — Archived · Play" under
    "Page F — Play" in the acceptance captures of 2026-10-18, and the profile's `Tabs_*` file
    held one WINDOW of six tabs from the quit before (`S-230`, archive A13). Anything that
    reads the recently-closed list passes over what the next launch reopened. A profile used
    before that fix keeps unmarked records of its earlier quits for the retention (30 days by
    default), so captures and checks start from a freshly seeded profile
    (`tooling/acceptance/mac/seed-profile.py` refuses a folder that already holds one).

106. **Expand-on-hover asks the machine's real pointer, so a test's played events alone do
    not decide it.** `VerticalTabStripRegionView::UpdateExpandOnHoverState` reads
    `IsMouseHovered()`, where the real pointer is, besides the event it was given, and asks
    whether the frame paints active, which is the real window's activation; on the PC's
    release build `SidebarFormsTest`'s reveal and the right-to-left edge's stray exit were
    flaky (`S-221`, 2026-10-18; the cause not proven). A test that plays a hover sets the
    stand-in, `SetHoveredForTesting(true)` before its enter and move events, `false` before
    the exit and `std::nullopt` after the last wait, as `SidebarFormsTest` and
    `LocalTabsTest.TheRailShowsTheTapeAndNoText` do. The stand-in replaces the event's word,
    `IsMouseHovered()` and the activation check, and the Windows exit debounce's read; the
    velocity heuristic and the collapse button's hover still read the real pointer, and focus
    inside the strip still holds the reveal open. A slow drag that rests on the rail (folders
    F7 with expand-on-hover on) is beyond it and is checked live. A PC run with the stand-in:
    TBD.

107. **`--enable-automation` changes the browser under test.** With it,
    `ContentInfoBarManager` turns every infobar's slide off, so bars come and go at once;
    Chromium shows its own "controlled by automated test software" bar and skips the other
    startup bars (`chrome/browser/ui/startup/infobar_utils.cc`), and pages are told they are
    automated (`navigator.webdriver`). The band an unanimated removal left over the page
    (`S-227`, toolbar T33) is one a person never met and a script driving Stedding through
    the switch always would. In-process browser tests do not pass it
    (`test_launcher_utils::PrepareBrowserCommandLineForTests`), so a test that wants the
    unanimated path asks for it (`RemoveAllInfoBars(/*animate=*/false)` in
    `SidebarFormsTest.FullScreenIsEdgeToEdge`, which timed out in most Windows runs of
    2026-10-18 while the Mac passed). The Windows acceptance runner launches without the
    switch for the same reason, though under it every tab would have a bar for tst9-9 to
    measure against.

108. **The Mac's context menus show neither a row's minor text nor its accessible name, and
    a vector icon only on macOS 26 with the new icon scheme.** `ui/menus/cocoa/menu_controller.mm`
    reads a row's label and its icon alone, and `SetMenuItemIcon` draws a context menu's
    vector icon only under `features::IsMenuSimplificationEnabled()`
    (`initializeWithNewMenuIconScheme`, `app_controller_mac.mm`) on macOS 26 or later. Found
    writing the session mark (2026-10-18, sessions S32): the views menus carry it in a Space
    row's minor text and icon, and on the Mac the words go into the title instead ("Work ·
    Independent session"). What a Mac menu row must say goes in its label, and a test that
    compares a Space row's label to the bare name fails there.

109. **Replacing the active tab's contents closes a tab-scoped toast.**
    `Browser::OnTabReplacedAt` runs the active-tab-changed callbacks, and
    `ToastController::OnActiveTabChanged` then clears every tab-scoped toast, as a navigation
    of the primary page does. A jar rebind and a sleep both replace a tab's contents (sessions
    S23), so a tab-scoped toast shown just before one is gone at once. Found by reading the
    code while writing S33's notice (2026-10-18): the pin's rebind reloads the page under it,
    so that toast is window-wide (`ToastId::kSteddingPinLeftSession`). A toast that must
    outlive a rebind is registered window-wide.

110. **The desktop brings app windows back at start only after a restart, so an app-restore
    test ends its `PRE_` step with one.** Off ChromeOS, `ShouldRestoreApps` in
    `startup_browser_creator_impl.cc` is `is_post_restart`: a plain start with "Continue where
    you left off" restores the browser's windows and no app's. A `PRE_` step that just ends
    also records the app window's close (`AppSessionService::WindowClosed`), so setting the
    restart preference alone is not enough. `AppJarTest.PRE_ARestoredAppWindowKeepsTheJar`
    ends with `chrome::AttemptRestart()` under an `upgrade_util::ScopedRelaunchChromeBrowserOverride`
    that starts nothing, as upstream's `SessionRestoreRestartMetricTest.PRE_RecordTabWindowDiff`
    does: the restart sets `prefs::kWasRestarted` and stops the session services before the
    windows close. Found in the review of apps made from pages (2026-10-18), whose first
    version of the test could not pass; upstream's in-process app-restore tests are off on
    the Mac (crbug.com/40758309), and this one has not yet run.

111. **On Windows a new page's view reports the old page's background colour.** Aura's
    (Windows' and Linux's) `RenderWidgetHostViewAura::TakeFallbackContentFrom` copies the
    previous view's colour
    (`CopyBackgroundColorIfPresentFrom`), so `RenderWidgetHostView::GetBackgroundColor()` on
    the view a navigation has just made answers the new tab page's colour, not the coming
    page's. Found in the review of dark pages (2026-10-18, Dk7):
    `DarkPagesTest.TheContentAreaIsDarkBeforeTheFirstFrame` read it and could not have passed
    on Windows; it reads the content area's own solid-colour layer instead, which has not yet
    run.

112. **Test pages on `127.0.0.1` are local tabs.** A bare
    `embedded_test_server()->GetURL("/x")` is `127.0.0.1`, which `stedding::IsLocalPage`
    counts as this computer's own server (`net::IsLocalhost`). Since local tabs (2026-10-18)
    the active row of most sidebar browser tests wears the tape, and their Comfortable rows
    show a host line under the title, the title moved up within the row. Heights, the title's
    x and width, the favicon, the close slot and the number badge stay; a test that reads a
    title's vertical centre, a pixel at a row's edge, an essentials card's edge colour or a
    row's accessible description sees the change. Serve a page that must be plain from
    `GetURL("a.test", ...)` with `host_resolver()->AddRule("*", "127.0.0.1")`. Found writing
    local tabs; the tabs, density, sidebar, pins and addressrow suites have not yet run with
    it.

113. **Off the Mac a browser test draws nothing unless it asks.** On Aura (Windows,
    Linux) `BrowserTestBase` adds `--disable-gl-drawing-for-tests` unless the fixture calls
    `EnablePixelOutput()`, so every pixel read back through `CopyFromSurface` (a test's own
    read, a screenshot, the row's edge sampler) comes back `rgba(0,0,0,0)`. The Mac draws
    regardless, so a pixel test passes there and waits out its 30 s on the PC; worse, a
    check that transparent black satisfies passes without testing anything
    (`DarkPagesTest.AnErrorPageIsDark` asked `IsDark` of it). A fixture that reads a page's
    pixels calls `EnablePixelOutput()` in its constructor (it also forces a scale factor of
    1). Found in BACKLOG S-242 (2026-10-19): six dark-page, page-colour and capture tests.

114. **Unit tests run over SSH on the PC read the system font half as large again.**
    `LocalRowLinesTest.TheComfortableRowAloneShowsTheHostLine` read a 24 DIP title and a 22
    DIP host line in two runs over SSH (2026-10-19) and passes in the desktop session, the
    same build and code. `unit_tests.exe` does not make itself DPI-aware (the browser tests'
    `main` calls `base::win::EnableHighDPISupport()`, the unit tests' does not), and outside
    the desktop session the system font and the screen's DPI, which `gfx::SystemFonts`
    divides by, did not agree; the operator's setting is 150% (`LogPixels` 144). The
    browser, DPI-aware, is not affected. Run font-measuring unit tests in the desktop
    session; read a failure over SSH as this first. Not reproduced on purpose: SSH to the
    PC from itself is not set up.

115. **Keys dispatched to a test window go nowhere once another test takes the
    foreground.** A browser test that sends `ui::KeyEvent`s through the window's dispatcher
    reaches its handlers only while the window holds the keyboard focus. In the parallel
    leg another test process's window took the foreground; the window under test was no
    longer active and nothing in it had the focus (`widget()->IsActive()` false, the focus
    client's focused window null, both logged), so a Ctrl press or release was lost.
    `NumberBadgeTest.TheNumbersAreTheKeysAndLeaveWithTheWindow` failed in 12 of 13 runs
    among its neighbours four at a time and in none of ten alone (S-242, 2026-10-19). A
    fake activation (`OnNativeWidgetActivationChanged(true)`) does not give the focus back,
    and a real `Activate()` from a process in the background is refused by Windows. An
    accelerator handed to the focus manager is refused the same way: on desktop Aura a view
    takes accelerators only while its widget is active (`View::CanHandleAccelerators`;
    `SpaceSwitchTest.MoveUpAndDownPassAnotherSpacesRows`, found on `win-checks` before beta
    18). Such tests run in `SERIAL_BROWSER_TESTS` (`tooling/dev`).

116. **On a busy machine a launched browser takes no key for its first minute.** The
    acceptance runner filed its fixture four seconds after the launch; while an ASan build and
    its multi-gigabyte link ran, the window stood with no page drawn, no DevTools answer and
    no key taken for about a minute, the fixture's keys were lost, and every later step read
    the wrong rows (2026-10-19, beta 18). `s173-live.ps1` now waits until DevTools calls the
    first page visible. Run real-input checks on a quiet machine, and read a fixture that
    failed as a too-early start first. Beta 19's run (2026-10-19) showed the same minute on
    a quiet machine for every part that was not the first of its task, with DevTools
    answering and no page visible. That one was Windows' foreground lock (`S-248`): a
    window launched seconds after the script's own keys opens behind the operator's
    window and stays there, its pages hidden, until something brings it forward. The
    fixture now brings it to the front before it waits, and the parts run in one task
    again. A first page that will not show is a busy machine only once the window is in
    front.

117. **A copy updated through the real feed opens the real profile.** The Mac's real-update
    check runs a copy of the released previous version with its own `CrProductDirName` and
    Sparkle defaults domain, so it starts on a scratch data folder and leaves the person's
    update settings alone. The update replaces the whole bundle with the published one, whose
    `Info.plist` names the default folder, and Sparkle relaunches it there: on 2026-10-20
    beta 21 came back on the person's own `~/Library/Application Support/Stedding`, their
    session and all, while their own copy was quit. Nothing was lost (the copy was quit with
    SIGTERM, which saved the session; same Chromium version, so no downgrade question for
    their copy), but only run that check while the person's own Stedding is quit, read the
    relaunched copy's windows before anything else, and quit it at once. The local n-1 check
    does not do this: it retargets the new bundle too.

118. **A one-off task's window cannot take the foreground, so press the pill through UI
    Automation.** `tooling\win\update-n1.ps1` clicked the pill with real input, and
    `drive.ps1` refuses when the browser is not the foreground window; started from a
    scheduled task while the operator's desktop is idle or behind another window, it was
    refused (2026-10-20), and the restart was not seen. It now presses the button through UI
    Automation's Invoke pattern, as the Mac's check presses it through accessibility, which
    needs neither the pointer nor the foreground: beta 21's local and real checks restarted
    into the new version two seconds after the press.

119. **A browser test's `host_resolver()` rules do not reach the tabs a launch opens.** Rules
    added in `SetUpOnMainThread` reach the network service only after the startup browser
    creator has opened the command line's addresses, so those tabs commit "name not resolved"
    error pages; `CommandLineTabsTest.EveryAddressLoadsAtLaunch` passed that way for a day,
    checking only the committed URL (2026-10-20, S-251). Map names for launch tabs with
    `--host-resolver-rules` in `SetUpCommandLine`, and check a page's title, not its URL.

120. **Python's `http.server` resets bursts on the Mac.** Its accept queue is five; macOS resets
    the connections that overflow it, and Chromium does not retry a fresh connection that is
    reset. A launch whose tabs all reconnect at once (S-251) lost tabs against it and none
    against a server with a queue of 64. For a live check that opens several tabs at once,
    serve with a larger queue (`ThreadingHTTPServer` with `request_queue_size = 64`).

121. **On the PC, keys sent while an elevated window is in front are lost, and the modifiers stay
    down.** Task Manager runs there at high integrity; a script's injected keys are medium, and
    Windows drops them while a higher window has the foreground (UIPI). A quit by Ctrl+Shift+W
    closes the browser mid-chord, the foreground falls to Task Manager, and the chord's key-ups
    are dropped: the system holds Ctrl and Shift down, the next launch reads them as held with
    no input event, and its first Ctrl+W quit it as Ctrl+Shift+W (2026-10-20, beta 21's live
    run). While the elevated window is in front, `GetAsyncKeyState` from the script reads no key
    at all, so the stuck keys show only once a medium window is in front again. Not the
    product: with the script's own window right behind the browser, the same quit leaves no
    key down. Close Task Manager before a run, quit through `Quit` (WM_CLOSE) where the keys
    are not the subject, and let go of stuck modifiers (`Unstick`) with a medium window in
    front.

122. **Windows takes some chords before the window hears them.** Escape with Alt down is
    Alt+Esc, Ctrl down or not: the window that has the foreground goes to the back of the
    others, and it is sent no key message for the Escape, so no handling of WM_KEYDOWN,
    WM_SYSKEYDOWN or WM_SYSCOMMAND can stop it. A hot key comes first: `RegisterHotKey` for
    the chord (or a low-level keyboard hook) gets the key instead, and Windows does nothing
    else with it (toolbar T39's hold registers Ctrl+Alt+Escape). Another program's hot key
    wins the same way: on the PC another program holds Ctrl+Alt+Space, and that chord brings
    it forward. Ctrl+Alt+F4 and Ctrl+Alt+Space are not Alt+F4 and Alt+Space to Windows
    (2026-10-20, a probe window's message log).

123. **Files copied to the PC with `tar xf` keep their Mac times, and the build may skip them.**
    tar restores each file's modification time. A file edited on the Mac before the PC last
    built that object, from another copy of it, arrives older than the object, and the build
    does not compile it again: on 2026-10-20 the PC's link failed with seven undefined
    symbols, every one defined in a file the copy had brought (`PageBarColorSupplier`'s new
    constructor among them). Extract with `tar xmf`, which stamps the files with the time of
    the copy.
124. **A Stedding of the operator's waiting to install an update stops the Mac's n-1 copies
    from checking.** Sparkle names an install in progress by the host app's bundle id, and asks
    for one (the `<bundle id>-spks` service) before it checks. On 2026-10-22 the operator's own
    Stedding had downloaded an update and waited to quit to install it; the test copies, which
    kept the real bundle id, found that install, made no request to the local feed, and showed
    no pill in five minutes, three runs in a row. Give each test copy a `CFBundleIdentifier` of
    its own (the test domain plus `.app`) when its `Info.plist` is retargeted: the copy then
    fetched the feed and the image nine seconds after launch, and Chromium's own defaults stay
    off the real app's too.
125. **`near` and `far` are macros on Windows.** `windef.h` defines both as nothing, so
    `gfx::Rect near = bounds;` fails to compile there with "expected unqualified-id" while the
    Mac builds it (2026-10-22, a test). Name a variable anything else.
126. **A test window under the machine's resting pointer gets that pointer's events on the
    Mac.** With the pointer resting on a rail row a drag the test sent failed every time, and
    passed every time with the window moved clear of it (BACKLOG S-252). A test that drags
    keeps its window clear of the real pointer, and says so if it cannot.
127. **A wait inside a `RunUntil` check never ends, and a settle loop can keep a layout from
    settling.** `base::test::RunUntil` runs its check while the loop is idle; a check that
    waits itself (`DrawnRow`, `RowCentre`, `ShownWhole`, anything calling
    `WaitForRowsToSettle`) runs a loop inside that check, and the test hangs to its 45-second
    timeout (2026-10-22, `FolderTabsTest.AHoverDrawsNothingOfTheFolder`). Look rows up with
    `FindDrawnRow` inside a check. And `WaitForRowsToSettle` lays out at every idle turn: right
    after a row moved into a folder nested in another, two layouts with no frame between found
    the nested folder at two heights in turn, so the rows started over at every check and never
    settled, where at a frame's pace they settle in 200 ms. Wait with
    `WaitForRowsToSettleAtFramePace` there. A Space switch slides the list on its layer
    (spaces B32), which neither wait covers: a row is cut off by the list's edge until the slide
    ends.
128. **With no monitor on, the PC runs at 1024×768 and the sidebar tests fail.** On 2026-10-22
    the PC's monitor was off and its console session was signed in again; Windows fell back to
    1024×768 (`Win32_VideoController` reports it), the test windows came up too small, and the
    release build's browser run failed 20 layout and drag tests across unrelated suites, some
    after 31-second waits, on a build whose installer and update checks had just passed. Check the
    resolution before the Windows legs. A Windows App (RDP) session gives the session its own
    display (1728×1084 from the Mac); keep its window open, not minimized, while the legs run,
    and do not leave it disconnected, which locks the session.

## The Windows build

Git for Windows for the bash tooling, PowerShell for the rest, Visual Studio's own
toolchain (`DEPOT_TOOLS_WIN_TOOLCHAIN=0`) and depot_tools on PATH. Three environment
variables name the machine's paths, so none is in the repo: `STEDDING_CHROMIUM_SRC`
(the checkout's `src`), `STEDDING_DEPOT_TOOLS` if it is not on PATH, and
`STEDDING_VPYTHON_ROOT`, a short directory for vpython's venv (trap 34). The bash
tooling takes the checkout as `CHROMIUM_ROOT`, the folder that holds `src`, as a POSIX
path (`/c/...`). Then:

1. `tooling/sync-chromium` moves the checkout to the pin and `tooling/apply-patches`
   puts the series on it, in that order and both before the branding: the apply
   refuses a tree with uncommitted changes, and the branding leaves a few hundred tracked
   files modified on purpose (`tooling/status` counts what is left besides them). There
   is no git cache on Windows: `src` is one commit of the pinned tag fetched by name (the
   sequence the `series` workflow runs), the dependencies come from `gclient sync
   --no-history`, and `--all-tags` is refused. The floor is 150 GB free, on every host.
   Trap 53 says what a milestone move really costs there (an update of an existing
   dependency is not shallowed).
2. `tooling/apply-branding` from Git for Windows: the BRANDING file, the logos, the
   Windows icons and the product-name rewrite over every locale's tables. Before
   `gn gen`, as on the Mac.
3. `tooling\win\build-until-done.ps1` -- the build to the end, detached, one status
   file (`out\<config>\supervisor.log`, last line `SUPERVISOR_EXIT=<n>`); it runs
   `tooling\win\build.ps1` chunk after chunk and stops only when done, failed, stuck
   or looping on the same killed steps (traps 9 and 57). `build.ps1` is the one chunk:
   the args file of `tooling/args/<config>.gn` copied into the output directory with
   `stedding_version` appended, `gn gen`, `autoninja`, a progress line every minute
   (steps done, compilers, commit charge), a budget (`-BudgetMinutes`, exit 2 means it
   stopped on it and a rerun resumes), `-KeepGoing` for one pass that lists every error
   (trap 50), `-Jobs` to keep the commit charge inside memory (traps 54, 74; the
   supervisor's default is 12). `build.ps1` alone builds `win-release`'s `chrome` and
   `mini_installer` by default; the supervisor builds those and both test binaries. The other three are test-target builds only:
   `win-checks` (DCHECKs and the dangling-pointer detector), `win-asan` and `win-debug`
   (docs/ARCHITECTURE.md, "Build configurations"). `stedding_browser_tests` depends on
   `//chrome:packed_resources` off the Mac since 2026-10-18, so a build of the test targets
   repacks `resources.pak` and the locale paks; before, a checks build of the tests alone
   ran them against the WebUI pages of the last `chrome` built in that directory, a welcome
   page without its test hook among them (BACKLOG S-213). A build is refused while a browser from
   that output directory runs (the link fails with "permission denied" otherwise); a test
   binary still running from it is not looked for, and its link fails the same way (trap 100).
4. `tooling/dev test all --no-build` (or one feature) runs the same filters against
   `out/win-release/*.exe`; `tooling/dev test browser --no-build` runs
   `stedding_browser_tests` in two legs, most of it four at a time and the tests that need
   the desktop to themselves one at a time (both through `timeout`, traps 56, 88). On a
   sanitizer build the same commands with `STEDDING_TEST_OUT=win-checks` or `win-asan`:
   the run-time flags and options are set for you and a finding is printed as a digest
   (`STEDDING_TEST_LOG=<path>` keeps the raw output, one file per binary,
   `<path>.unit_tests` and so on, emptied when a run starts). A browser-suite run under
   ASan takes 20 minutes: `STEDDING_TEST_BUDGET_S=2400`. The session must be connected (trap 59).
5. `tooling\win\capture.ps1` for captures that need neither focus nor input (trap
   36); `tooling\win\cdp.ps1` for what a capture cannot reach -- JavaScript in a
   page over the DevTools websocket (the welcome flow's buttons pressed by name,
   a settings page scrolled to its Shortcuts block) and a screenshot of the page;
   `tooling\win\uia-dump.ps1` for a layout question -- every view of the window
   with its name and bounds through UI Automation, no build needed (trap 37);
   `tooling\win\hit-test.ps1` for what the frame answers at each row, with no input;
   `tooling\win\drive.ps1` to use the window for real -- the pointer, the keyboard,
   a window-only screenshot, rows and buttons by UI Automation, the visible page by
   DevTools, with the guards of trap 27 (ask the operator once first);
   `tooling\win\package-installer.ps1` for the release image in `dist/`;
   `tooling/publish-release` from Git for Windows to publish it beside the Mac's DMG
   (ADR 0018).

## Open items

Everything open is `BACKLOG.md`, in priority order; `PLAN.md` holds the owner's standing
decisions and the definition of done. This file keeps no list of its own. What each patch
was seen to do, and which release carries it, is `docs/PROJECT-LOG.md` and
`docs/release-notes/`.

## The updater (Mac)

Sparkle 2 (ADR 0022, `docs/features/updates.md`). What lives where:

- `tooling/fetch-sparkle` puts the framework in the checkout at
  `third_party/stedding_sparkle/` (ignored by its `.gitignore`), with a `README.chromium` so
  the credits page names it; `tooling/build-chromium` runs it on every Mac build and sets
  `stedding_sparkle = true`. A build without it simply has no updater.
- The feed URL and the EdDSA public key are in `chrome/app/app-Info.plist`;
  `build/apple/tweak_info_plist.py` writes `CFBundleVersion` from VERSION (Up11).
- Only a bundle signed by a team starts the updater, so `out/release/Stedding.app`
  (ad hoc) never replaces itself. Tests never start it (`--test-type`); they use
  `stedding::FakeAppUpdater`.
- **The private key** is in the release Mac's login keychain under the account
  `stedding` (Sparkle's `generate_keys --account stedding`, made 2026-10-16), and in the
  owner's backup (ADR 0022; exported with `generate_keys --account stedding -x <file>`,
  the file deleted after), never in this repository. Without it no installed copy can be
  offered an update: a new key ships only in a release people install by hand.
- Offering a release: `tooling/publish-appcast` after `tooling/publish-release` (below).

The local n-1 check, before a release that changes the updater or its feed: two copies of
one `out/release` build, both signed with the Developer ID in development mode (no
notarization; `sign_chrome.py --development --notarize none`), the older with
`CFBundleVersion` lowered. Before signing, each copy's `Info.plist` gets `SUFeedURL` pointing
at a local server (`http://127.0.0.1:<port>/appcast.xml`, which `NSAllowsArbitraryLoads`
lets through), `CrProductDirName` set to a test folder (so the copy Sparkle relaunches
without arguments still opens the test profile, never the operator's), and
`SUDefaultsDomain` set to a test domain (Sparkle's own keys away from the real app's). The
test folder is made empty before the first launch, with a `First Run` file in it: without
the folder, patch 0050's legacy migration seeds it from `~/Library/Application
Support/Chromium`, and without the file the relaunch is a first run, which restores no tabs.
The newer copy goes into a DMG signed with `sign_update`, the feed is written with
`tooling/appcast.py write --url ...` and signed, a `python3 -m http.server` serves both, and
the older copy runs from a folder of its own. Ten seconds after launch it fetches the feed
and the image, the sidebar shows the pill (about twenty seconds in, on 2026-10-16), and a
press of it through the accessibility API (`AXPress`, which moves no pointer) or a quit
installs the newer copy in place; the relaunched copy reads the newer `CFBundleVersion` and
has the test profile's tabs. Signing with the Developer ID rather than an Apple Development
identity keeps macOS from asking for the "Stedding Safe Storage" key, which the relaunched
copy, started without `--use-mock-keychain`, would otherwise wait on
(`docs/ARCHITECTURE.md`). The copies share the real app's defaults domain
(`dev.stedding.Stedding`), where Chromium writes `LastRunAppBundlePath` and the migration
its decision: export it before, and afterwards delete the domain and import the export
(`defaults import` alone keeps keys the test added). Afterwards: stop both, delete the test
profile and its cache folder, and `defaults delete` the test domain.

Before a release that moves the pin or changes the updater, run the same check from the
release people have installed. The older copy is that release's app, out of its DMG, with
the same three keys changed in its `Info.plist` and only the outer bundle signed again
with the same Developer ID: `codesign --force --sign <identity> --options
runtime,library,restrict,kill --timestamp=none
--preserve-metadata=identifier,entitlements,requirements`. Its nested code keeps the
release's signatures. `--options` has to name the release's flags, because once
`--options` is given, `--preserve-metadata=flags` does not keep them. The newer copy is the
new build, signed as above, with the next release's `CFBundleVersion`. On 2026-10-16 beta 16
updated itself this way to the 156 build. The pill showed in about twenty seconds, the new
version was running a second after the press, the tab came back, and the profile's `Last
Version` read 156. The relaunched build can then show the welcome flow or Chromium's
engine chooser. That is the test profile, not the update: the older copy ran with
`--no-first-run`, so the profile never finished the welcome or chose an engine. Seeding
`Default/Preferences` with `{"stedding":{"welcome":{"shown":true}}}` skips the welcome.
The chooser then opens as it does for a beta 16 user who never chose an engine (trap 76,
`S-134`).

## The updater (Windows)

The browser's own updater (ADR 0023; its key, ADR 0026; `docs/features/updates.md`
Up14-Up22). What lives where:

- `chrome/browser/ui/stedding/app_updater_win.cc` is `stedding::AppUpdater` on Windows,
  started from `ChromeBrowserMainPartsWin::PostProfileInit`; `update_feed.cc` checks the
  feed's and the installer's Ed25519 signatures and picks the item, through the sandboxed XML
  parser. The feed URL and the public key are constants in `update_feed.h`.
- **The version.** `tooling/win/build.ps1` writes the product's version into the checkout's
  `chrome/VERSION` before `gn gen` (`S-72`): `<milestone>.<100 x major + minor>.<patch>.<beta
  n, 999 for a release>`, with Chromium's on a fifth line, `CHROMIUM_VERSION`, which
  `version_info::GetChromiumVersionNumber()` returns for the user agent, the client hints,
  the Web Store and component updaters and About. The file shows as changed in the checkout
  like the branding; `git checkout chrome/VERSION` restores Chromium's, and
  `tooling/sync-chromium` does it before a sync. A VERSION bump rewrites it and rebuilds what
  includes the version headers (most of the tree once, about an hour on this PC).
- Only a copy the installer put in place (`%LOCALAPPDATA%\Stedding\Application`) starts the
  updater: `out\win-release\chrome.exe` never does, nor a test.
- The installer runs hidden with `--do-not-launch-chrome --verbose-logging --log-file=...`;
  Chromium's in-use update leaves `new_chrome.exe` and the rename command in
  `HKCU\Software\Stedding`, and `chrome::AttemptRestart` (or any quit) swaps it in
  (`chrome/browser/first_run/upgrade_util_win.cc`). Its exact status is the `InstallerError`
  value in that key: 30 is an in-use update, 31 a same-version repair that failed.
- **The private key** is on the Windows release PC under `%USERPROFILE%\.stedding\update-key`
  (`tooling/win/update-key.ps1 -Create`, made 2026-10-19), encrypted, its passphrase under
  DPAPI; the operator keeps a backup (`-Backup <folder>`). Without it no installed Windows copy
  can be offered an update.
- Offering a release: `tooling/win/publish-appcast.ps1` after `tooling/publish-release`.

The local n-1 check, before a release that changes the updater or its feed: two builds of the
same tree, A at one VERSION and B at the next (each a `build.ps1` run, so each carries its
Windows version), each packaged with `tooling/win/package-installer.ps1`. Install A over the
installed copy through a one-off task (trap 40). Write a local feed for B with
`tooling\win\publish-appcast.ps1 -Installer <B> -Feed <dir>\appcast-windows.xml -Url
http://127.0.0.1:<port>/<B's name>` and serve the folder with `python -m http.server`. Start
the installed A on a scratch profile with `--stedding-update-feed=http://127.0.0.1:<port>/appcast-windows.xml`:
ten seconds in it fetches the feed and B, runs B's installer hidden, and the sidebar shows the
pill; a click restarts into B, which About and `HKCU\Software\Stedding`'s `pv` confirm, and
`new_chrome.exe` is gone. Read the registry and the install from the task, not from a shell
of the agent's app, which sees a virtualised copy without `pv` or the uninstall entry (trap 40).
`--no-first-run` keeps the welcome away and the thank-you page with it.

First run, 2026-10-19: a build of 156.2.0.18 installed over beta 18 as an upgrade, not a repair
(the version folder replaced, the profile kept); on a scratch profile it fetched the feed and
beta 19's installer nine seconds after launch, the installer ran (`InstallerError` 30, an
in-use update, `new_chrome.exe` beside both version folders), and the pill showed at 25
seconds. A real click restarted into 156.2.0.19 in about two seconds, with `pv` 156.2.0.19,
`new_chrome.exe` gone and the two tabs back; About read "Stedding 0.2.0-beta.19 · Chromium
156.0.8078.36". Scripts: `tooling\win\update-n1.ps1` (through `tooling\win\drive.ps1`) and an
`Up21` check that `out\win-release\chrome.exe` asks nothing.

## Release channel

Releases on GitHub Releases, each the repository's latest release from 0.3.0 beta 1 (the
owner, 2026-10-21, so the repository's page shows it; every release up to 0.2.0 beta 21 was
a pre-release; `tooling/publish-release --prerelease` still makes one): the Mac's DMG, with
the app in it signed with the Developer ID and notarized (since beta 10; the image itself is
not signed), the Windows installer an unsigned preview, each with its sha256 beside it. The Mac's order, all from the repo root with a clean tree: bump
`VERSION`, `tooling/dev build release chrome` (the About line is a build flag), empty
`dist/`, `tooling/sign-release release` (`--check` first; it signs, notarizes and staples
into `dist/signed/stable/Stedding.app`), `tooling/verify-build --app
dist/signed/stable/Stedding.app`, `tooling/package-dmg release --app
dist/signed/stable/Stedding.app` (`dist/Stedding-<VERSION>-arm64.dmg` and its `.sha256`),
`syspolicy_check distribution` on that app (trap 47), paste the checksum into
`docs/release-notes/v<ver>.md`, commit, **push**, `tooling/publish-release --check`,
then `tooling/publish-release`. Then, once the release has been tried the way a user gets
it, offer it to installed copies: `tooling/publish-appcast --check`, then
`tooling/publish-appcast --push` (ADR 0022; it signs the image, writes and signs
`updates/appcast.xml`, commits and pushes it; the push is the release's own step and needs
the operator's yes like the publish). Then fetch the feed from its raw.githubusercontent.com
URL: it should be byte for byte the commit's, `sign_update --account stedding --verify` should
pass on it, and the image downloaded from the release should verify against the feed's
`edSignature` (`sign_update --verify <image> <signature>`). Betas 1 to 8 went out unsigned, with `docs/INSTALL.md`'s
`xattr` command in their notes. The Windows
image joins the same release from the Windows PC: `tooling\win\build-until-done.ps1`
(then both suites on that exact build), `tooling\win\package-installer.ps1`,
`tooling\win\test-installer.ps1` (`-Mode backup`, then `upgrade`, `uninstall-keep`,
`install`) and a real launch of
the installed build (docs/ROADMAP.md#the-quality-bar, release checklist 13), the checksum pasted under
*Windows* in the notes, commit, push, `tooling/publish-release` from Git for Windows -- whichever
platform publishes first creates the release, the other uploads into it and the
notes are refreshed (ADR 0018). Then the Windows feed, on the PC after `git pull`:
`tooling\win\publish-appcast.ps1 -Check`, then `-Push` on the operator's yes for that release
(ADR 0023), one feed push at a time (both feeds are commits to `main`). Which platform went first for each beta is in
`docs/PROJECT-LOG.md` and the notes. Since beta 19 (patch 0073, `S-72`) each Windows build
carries its own version, `<milestone>.<100 x major + minor>.<patch>.<beta>` (156.2.0.19 for
beta 19), so a newer Stedding over an older one is an ordinary upgrade on the same Chromium
number; only an installer of the very version installed still repairs and needs Stedding
closed (trap 62). The PC builds and tests its own image; driving it from the Mac
over SSH (beta 12) put the browser suite in session 0, where it fails (traps 67, 68).
After `publish-release`, nothing is needed on the site: its scheduled rebuild
(every six hours) reads the release list, pre-releases included. To see the new
version at once, `gh workflow run rebuild.yml -R ysalitrynskyi/stedding.dev`
(the deploy hook; working since 2026-09-18) or push to the site's `main`, which
Cloudflare builds on its own.

**Release at least every five weeks, each time on a newer pin.** Chromium uses its built-in
list of sites that must load only over HTTPS (the HSTS preload list) only while the build is
less than 70 days old: `TransportSecurityState::IsBuildTimely()` in
`net/http/transport_security_state.cc` is `return (base::Time::Now() - build_time).InDays()
< 70 /* 10 weeks */;`, and `GetStaticSTSState()` answers nothing once it is false. A build's
date is its pin's, not the day it was built: `build/compute_build_timestamp.py` reads the commit
time `gclient sync` recorded in `build/util/LASTCHANGE.committime` (the pin's upstream
commit; the series' commits come later and do not move it), and a build that is not official,
as the recipe above builds (`S-168`), rounds that down to the first Sunday of the month or of
the month before. So a release can be five weeks old the day it ships, and a release on the
same pin keeps the old date: betas 17 to 20 share a pin committed on 2026-10-13, so all are
dated 2026-10-04 (the Mac's `out/release/gen/base/generated_build_date.h` says so) and all
lose the list on 2026-12-13. The updaters only deliver what is released; an official build
would take the commit's own date.

The push moved ahead of the publish on purpose. `gh release create` cuts the tag on
the remote, so publishing from an unpushed commit tagged whatever the remote's default
branch happened to be; `publish-release` now pins the tag to this commit with
`--target` and refuses to run until the commit is on the remote, which is why the push
comes first and `git push --tags` afterwards is no longer part of the dance.

"Empty `dist/`" is still worth doing, but it is no longer the thing standing between a
release and the wrong image. `package-dmg` names the image for the product version
rather than Chromium's — two Stedding releases on one pin used to produce one filename
— and warns about anything else left in `dist/`; `publish-release` takes the image
named for this VERSION, accepts a lone unnamed one, refuses to choose between two, and
recomputes the sha256 against both the file beside it and the number in the release
notes.
