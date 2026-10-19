# The README's animation: storyboard

One animated GIF under the README's header, `docs/images/readme/demo.gif`, with an MP4
of the same take beside it (`demo.mp4`) for the website and the release notes. It
shows what Stedding is in about half a minute, at a pace a person can follow, and
loops without a seam. `tooling/readme/record-demo.sh` makes it from the steps files
in [tooling/readme/steps/](../../../tooling/readme/steps/); how to run it is in
[tooling/readme/README.md](../../../tooling/readme/README.md).

## The picture

| | |
|---|---|
| Window | 1400 × 880 points, the size `tooling/drive` opens, at the top left of the main display |
| Colours | Light (sand) by default. Page colours read best against light pages, and the night gradient bands in a 256-colour GIF; `--scheme dark` makes the other one |
| Frame | The window with its own rounded corners on the brand's slate (#2F4858), a 28 px margin at 1400 px wide |
| Captions | A 64 px lane under the window: the keys in amber (#E8B04B), the words in cream (#F2E9DE), one caption per scene, a short blank between two |
| Pointer | Visible. It glides between targets on an eased path (0.3 to 0.6 s) and never jumps; clicks draw no ring unless `--show-clicks` |
| Length | 25 to 40 seconds: about 31 with the built scenes, about 38 with this round's two |
| Loop | The last frame is the first: Work, the GitHub page, the pointer at rest |
| GIF | 1200 px wide at 15 fps, down to 12 fps and 1040 px if it would pass 8 MB |
| MP4 | 1400 px wide, 30 fps, H.264 |

The pace, everywhere:

- One idea per scene, and each scene opens on a still frame (the scene's marker).
- Every state stays on screen 1.3 s or more before the next change.
- One thing moves at a time: the pointer, or the window, never both.
- Typing comes in two short bursts, the way a person types.
- Nothing flashes: dark pages stay on for two seconds and go off once.

## What is in the window

The fixture is built before the recording, and none of it is recorded.

| Space | Colour, icon | Its tabs |
|---|---|---|
| (essentials) | in every Space | GitHub (the project's repository), MDN, DuckDuckGo, Hacker News |
| Work | Moss, 💼 | pinned: Django, TypeScript; a folder Docs holding MDN's CSS reference and a nested folder TypeScript with the handbook; the sample app on localhost:5173; GitHub Trending |
| Personal | Plum, 🏠, its own session | OpenStreetMap, Lobsters |
| Reading | Clay, 📚 | LWN.net, arXiv |

Made with as little real input as possible: the Spaces, their colours, icons and the
own session come from a seeded profile (`media.py seed`), the essentials and the
folder from the capture params `pin_tabs/4/folder_tabs/6`. Real input does the rest
(`steps/setup.steps`): the keys that move four tabs to the other Spaces and pin two,
and the double clicks that name the folders.

## Pages

Real sites that are stable, need no sign-in and show no consent banner, plus a local
page of this repository. GitHub stands for an example page everywhere; never
rust-lang.org; no Wikipedia page on screen (its fundraising banners) and no
chromium.org (its title reads "Home").

| Page | Address | Why | Check at rehearsal |
|---|---|---|---|
| The project on GitHub | github.com/ysalitrynskyi/stedding-browser | The first and last frame: Stedding showing its own README | The page is white and still; no banner |
| Django | www.djangoproject.com | A dark green header: the row turns green | The row is green |
| TypeScript | www.typescriptlang.org | A blue header: the row turns blue; white below, for dark pages | The row is blue, the page light |
| OpenStreetMap | www.openstreetmap.org | A map, the colour of the Personal Space's scene | The tiles have loaded |
| LWN.net, arXiv | lwn.net, arxiv.org | Quiet pages for Reading | |
| Sample app | localhost:5173 (`tooling/readme/pages/sample-app/`) | A local development page, amber across its top | The outline and host:port, once built |
| Sample API | localhost:8797 (`tooling/readme/pages/sample-api/`) | A second local page, for the still | |

If a site's header has changed colour, pick another page whose top edge is one strong
colour, put it in `common.sh` and in the steps, and check it in a rehearsal.

## Scenes

The times are the steps' own, estimated from their waits; `timeline.txt` gives the
real ones after a take. Coordinates are window points; those marked GUESS in the steps
files are confirmed from the layout run's pictures before the first take.

| # | Scene (`steps/`) | Seconds | What happens (keys, clicks) | On screen | Caption |
|---|---|---|---|---|---|
| | `setup`, `preroll` | cut | The fixture is built, quit and reopened; every page a scene shows is loaded once; back to Work and its GitHub essential, the pointer at rest (150, 720) | | |
| 1 | `hero` | 2.5 | Nothing: the window at rest | Work: essentials, pins, the folder, the tabs; the GitHub page on its card, the address row in the page's colour | Stedding: an open-source, Arc-style browser built on Chromium |
| 2 | `colour` | 5.5 | Glide to Django's row, click; glide to TypeScript's row, click | The page changes and the address row with it: green, then blue | The address row takes each page's own colour |
| 3 | `bar` | 5.5 | ⌘T; type "open", a beat, "street"; ↓; Return | The bar over the page lists the OpenStreetMap tab with its Space; Return slides the sidebar to Personal, its plum tint, the map | **⌘T** Search, open a site, or jump to any tab in any Space |
| 4 | `spaces` | 6 | Glide to the third chip, click; glide to the first, click | Reading slides in, clay; then Work, moss | **⌃1–⌃9** Spaces, each in its own colour, with its own cookies if you like |
| 5 | `rail` | 5.5 | Glide to the sidebar's toggle, click; glide to the rail's toggle, click | The sidebar folds to a column of icons, the page widens; it opens again | **⌘S** Fold the sidebar to icons, or hide it completely |
| 6 | `dark` (this round) | 4 | ⌥⇧⌘D, two seconds, ⌥⇧⌘D | The TypeScript page goes dark at once, the row with it, and comes back | **⌥⇧⌘D** Every website dark at once, with no white flash |
| 7 | `local` (this round) | 4 | Glide to the sample app's row, click | The amber page; its row outlined in dashed yellow, localhost:5173 under the title | Tabs on a local server are marked, with their host and port |
| 8 | `end` | 5.5 | Glide to the GitHub essential, click; glide to the rest point; hold | The first frame again | stedding.dev · free and open source · macOS and Windows |

Scenes 6 and 7 go in with `--with-new` once their features are built. The mark of a
Space with its own session needs no scene of its own: it is on screen in scenes 3 and 4.

Keys are chosen so nothing outside the browser takes them: the chips switch Spaces in
scene 4 and ⌥⌘← in the fixture, because macOS takes ⌃1–⌃9 once a second desktop
exists (the caption still names them).

## Left out of the animation

Each of these is a still or a line of the README instead: folders and pinned tabs up
close (a slash on a wandered pin is too small at GIF size), split view and the archive
(each would need a scene of its own past 40 seconds), little windows and apps from
pages (both open a second window outside the recorded region), the Arc import, the
welcome flow, and private windows.

## Real input only where nothing else shows it

Every still is taken with no input at all (`tooling/readme/capture-stills.sh`, through
`tooling/capture-state`), and so is everything in the fixture that a seed or a param
can make. Motion cannot be seeded: typing in the bar, a Space sliding in, the rail
folding. Those take one driven run with real pointer and keys, which starts only after
nobody has touched the Mac for a while and stops if anyone does.

When the Mac cannot be left alone, `record-demo.sh slideshow` makes an input-free GIF
from the stills, crossfaded, with the same captions. It has no pointer and no motion,
so it is the fallback, not the plan.

## Recording and conversion

- **Recorder.** macOS's own `screencapture -v` on the window's rectangle; if it
  records nothing on this Mac, ffmpeg's avfoundation input on the whole display, cut
  to the window. `record-demo.sh probe` tells which works; both need the terminal's
  Screen Recording permission.
- **Clock.** Each scene opens with a capture of the window (`shot`); the files' times
  are the scene boundaries. The command bar opening in scene 3 is the largest change on
  screen in the second around its marker, which gives the recorder's delay; `--offset`
  overrides it.
- **Composition.** The first marker is the window captured by its id, with transparent
  corners: its alpha cuts the corners out of every frame, so no desktop shows behind
  them. The window goes on the slate ground, the caption lane under it.
- **GIF.** Two passes: `palettegen` (256 colours, from every frame) then `paletteuse`
  with ordered (Bayer) dithering at scale 4, and only the changed rectangle of each
  frame redrawn. Ordered dithering puts the same pattern on the same pixels in every
  frame, so flat interface colour does not shimmer and unchanged areas cost nothing;
  error diffusion would make gradients crawl. `mpdecimate` drops frames that repeat the
  one before, so a held state costs one frame.
- **MP4.** From the same composed take: H.264, CRF 18, faststart.

## Before a take

- The operator's yes for real input, then nobody at the Mac.
- Their own Stedding quit (the scripts refuse to start beside it), and Arc and any
  clipboard manager too (each takes a chord from every app while it runs).
- Do Not Disturb on, so no notification lands on the window.
- One desktop in Mission Control is safest; the steps avoid ⌃1–⌃9 anyway.
- The display shows at least 1400 × 880 points under the menu bar.

## Checks on the result

- `layout`: the GUESS coordinates match the fixture's pictures.
- `rehearse`: each frame in `marks/` is the state its scene starts from.
- `demo.mp4`, watched once through: captions on their scenes, the pointer never jumps,
  no white flash, no banner, no link address in the corner from a resting pointer, the
  first and last frames the same.
- `timeline.txt`: 25 to 40 seconds. `demo.gif`: 8 MB or less.
