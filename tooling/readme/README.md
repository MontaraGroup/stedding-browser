# tooling/readme/

The README's pictures and its animation, made on the Mac from a build, the same way
every time. What the animation shows and why is
[docs/images/readme/STORYBOARD.md](../../docs/images/readme/STORYBOARD.md); the README
that shows them is [README.md](../../README.md); a later rewrite is drafted as `docs/readme-draft.md` and promoted with `promote-readme.py`.

| File | What it does |
|---|---|
| `capture-stills.sh` | **(macOS)** Every still, each one `tooling/capture-state` run: no pointer, no keys, no focus change, so it runs while someone works at the Mac. One function per picture. |
| `record-demo.sh` | **(macOS)** The animation: the fixture and the scenes driven through `tooling/drive` with real input, the window recorded, then the GIF and the MP4. Also `check` (no launch), `layout`, `rehearse`, `convert`, `slideshow` and `probe`. |
| `steps/` | The steps files: `setup` builds the fixture, `preroll` loads the pages, then one file per scene. `tooling/drive`'s language plus `glide`, which `media.py render` turns into eased pointer moves. |
| `captions.tsv` | One caption per scene and per still: the keys, then the words. |
| `arc-demo-sidebar.py` | A made-up Arc sidebar for `welcome-import`, written under a scratch home folder. |
| `media.py` | The helpers: a seeded profile, the rendered steps, the caption strips, the window's rectangle, the timeline that cuts the recording. |
| `common.sh` | What both scripts share: the pages, the local servers, the checks before a launch. |
| `pages/` | Two local development pages, served on localhost:5173 and localhost:8797 while the scripts run. |
| `promote-readme.py` | Turns `docs/readme-draft.md` into `README.md` once nothing blocks it. |

## What it needs

- macOS, with the terminal allowed **Screen Recording** (for `screencapture`, which the
  captures already use) and **Accessibility** (for `tooling/drive`'s input), in System
  Settings → Privacy and Security.
- A build in `out/release` (`tooling/dev build`), or an installed copy with `--app`.
  The capture params (`pin_tabs`, `folder_tabs`, `space_pin_tabs`, `drift_tabs`,
  `open_command_bar`) work only in a build that is not an official one; an official
  build ignores them and the pictures come out without essentials or folders.
- A `python3` with PyObjC, as `tooling/drive` and `tooling/capture-state` need.
- `ffmpeg` and `ffprobe` for the animation (`brew install ffmpeg`; or set `FFMPEG` and
  `FFPROBE`). Neither gifski nor gifsicle is used.
- Your own Stedding quit: every launching mode refuses to start beside another copy.
- Ports 5173 and 8797 free.

## Order of work

```bash
# 1. The stills. No input; safe while you work. <out> is any folder outside the repository.
tooling/readme/capture-stills.sh ~/Desktop/readme-media/stills
tooling/readme/capture-stills.sh ~/Desktop/readme-media/stills --with-new   # also dark-pages, local-tabs, isolated-space, web-app

# 2. The animation. Real input: only with the operator's yes, then hands off.
tooling/readme/record-demo.sh check    ~/Desktop/readme-media/demo           # renders and checks the steps; no launch
tooling/readme/record-demo.sh probe    ~/Desktop/readme-media/demo           # which recorder works here
tooling/readme/record-demo.sh layout   ~/Desktop/readme-media/demo           # the fixture's pictures: confirm the GUESS coordinates
tooling/readme/record-demo.sh rehearse ~/Desktop/readme-media/demo
tooling/readme/record-demo.sh record   ~/Desktop/readme-media/demo
tooling/readme/record-demo.sh convert  ~/Desktop/readme-media/demo --offset -0.3   # if the captions run early or late

# 3. Look at every file, copy the chosen ones into docs/images/readme/, then:
tooling/readme/promote-readme.py           # what still blocks the new README
tooling/readme/promote-readme.py --write
```

Each script writes only under the folder it is given, and refuses one inside the
repository's `docs/` or `tooling/`: pictures go into `docs/images/readme/` by hand,
after a look. Running a step again replaces what it wrote.

## The stills

`capture-stills.sh <out> [still ...]`; `--list` names them. Each is
`<out>/<still>.png` at 1800 px wide, the size `docs/images/readme/` keeps, with the
capture as taken in `<out>/raw/` and `<out>/captures.tsv` naming the build, the date,
the fixture and the arguments of each.

| Still | The state, and where it comes from |
|---|---|
| `hero`, `hero-dark` | Work with four essentials and a folder holding a nested one (`pin_tabs/4/folder_tabs/6`), three Spaces, light and dark |
| `spaces` | Five Spaces with their colours and icons (the `spaces` fixture) |
| `command-bar` | The bar open over the page (`open_command_bar/true`) |
| `folders` | Two essentials and a nested folder (`pin_tabs/2/folder_tabs/5`) |
| `pins` | Three pinned tabs, the first wandered off to the next one's page (`space_pin_tabs/3/drift_tabs/1`) |
| `rail` | The sidebar closed to the rail (the seed's `collapsed`) |
| `private` | A private window (`--incognito`) |
| `welcome-<step>` | The welcome flow on `search`, `import`, `appearance`, `behaviour`, `default` or `keys` (`--stedding-welcome=<step>`) |
| `dark-pages` (new) | Dark pages on (the seed sets Chromium's `force_dark_mode_enabled`) |
| `local-tabs` (new) | Two pages on local servers, the first on screen |
| `isolated-space` (new) | A Space with its own session on screen (the `isolated` fixture) |
| `web-app` (new) | A page in a window of its own (`--app=`, a stand-in for an app made with the feature) |

How a seeded still works: `media.py seed` writes a fresh profile (the Spaces with
their names, colours and icons, a Space with its own session, the colour scheme, the
rail, dark pages, the welcome flow marked as shown, the version that last ran), and
its folder goes to the browser as a second `--user-data-dir` after the one
`capture-state` passes. Chromium keeps the last value of a repeated switch, so the
browser runs on the seeded profile, and `capture-state`'s own empty one is deleted
unused. A Space registry and these preferences are not protected preferences, so a
seed is read as written; pinned tabs are, which is why they come from the params.

`welcome-import` runs with a scratch home folder holding a made-up Arc sidebar
(`arc-demo-sidebar.py`: four Spaces, pinned tabs and folders, four essentials, on example
sites), handed to the browser alone through `STEDDING_LAUNCH_ENV` (`tooling/lib.sh`). The
step reads the Arc sidebar under the home folder, so it never shows the Mac's own profile.

## The animation

`record-demo.sh <mode> <out>`. The modes in order of use:

- `check` renders the steps of the chosen scenes into `<out>/steps/` and checks every
  line with `tooling/drive-window.py --check`, and that every scene has a caption.
- `probe` records three seconds of a corner of the screen with `screencapture` and
  with ffmpeg, and says which produced frames.
- `layout` seeds a profile, starts the local pages, waits until nobody has touched the
  Mac for `--idle` seconds (15 by default), and builds the fixture with
  `steps/setup.steps`. Its pictures in `<out>/shots/` are what the coordinates marked
  GUESS in `steps/` are read from; fix those there before a take.
- `rehearse` does the same and then runs the scenes without recording; the window at
  the start of each scene is in `<out>/marks/`.
- `record` does the same, recording the window from the moment it appears, then
  converts.
- `convert` makes the GIF and the MP4 again from the kept recording (`raw.mov`,
  `recording.env`, `marks/`), with `--offset` when the captions run early or late.
- `slideshow --stills <capture-stills out>` makes an input-free GIF from the stills,
  crossfaded, with the same captions: the fallback when the Mac cannot be left alone.

Between the fixture and the scenes it checks again that nobody used the Mac, as
`tooling/acceptance/mac/run-mac.sh` does, and stops if someone did. Ctrl-C at any point
lets go of every key and button, quits the launched browser and stops the recorder and
the local pages. `check`, `convert` and `slideshow` start no browser and record nothing,
so they also run beside your own Stedding.

The scenes: `hero colour bar spaces split dark end` by default; `--scenes` picks
others, `end` last. `rail` and `local` are left out of the default to keep the take
under 40 seconds: `rail` goes anywhere before `end`, `local` right after `colour`,
where Work is on screen. The first scene's
marker is a capture of the window by its id, and its transparent corners become the
mask that cuts the desktop out of every frame.

Outputs under `<out>`: `demo.gif` and `demo.mp4`, `timeline.txt` (each scene's start
and length, the offset and how it was found), `raw.mov` (kept for `convert`; delete it
when done, it is the largest file), `steps/`, `marks/`, `shots/`, `logs/` (every tool's
output, and the browser's log of each run) and `work/` (the profile, the captions, the
palette).

### What a take needs checked by a person

- The GUESS coordinates in `steps/`, from the `layout` pictures: the essentials card,
  the two pinned rows, the folder headers, the sample app's row and the rest point;
  Reading's rows from `marks/split.png` after a rehearsal. The chips and the sidebar
  toggles are the acceptance runs' coordinates.
- The pages: each scene's page shows the colour the storyboard says (a site may have
  changed its header since).
- The split scene: the dragged row's half lights once the pointer is over the page,
  and the address row over the split shows the two pages' colours (`marks/dark.png`
  after a rehearsal is the split as the drop left it).
- The recorder: `screencapture -v` with a rectangle is the default; if `probe` says it
  records nothing here, `--recorder ffmpeg` records the whole display and cuts the
  window out.

## Promoting the README

`promote-readme.py` reads `docs/readme-draft.md`, whose links are written from `docs/`
so `tooling/check-repo` checks them where the draft stands, and rewrites them for the
repository root. It refuses while a line carries a `confirm-when-built` marker (a
feature or a release fact not yet confirmed), while a linked file or picture is
missing, or while `demo.gif` is over 8 MB. `--write` writes `README.md`; then run
`tooling/check-repo links` and delete the draft.
