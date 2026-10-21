# UI specification — matching Arc

The target is a **close, measured match of Arc's window chrome**, taken from reference
screenshots of Arc on macOS. This file holds the targets and the values Stedding ships;
the behaviour of each surface, with its tests, is in its feature spec (`features/sidebar.md`,
`features/toolbar.md`, `features/tabs.md`, `features/page.md`, `features/commandbar.md`).
Where this file disagrees with a screenshot of Arc, the screenshot wins and this file is
corrected.

Chromium's built-in vertical tab strip is *not* the target. It supplies the tab model
(`decisions/0010-ride-upstream-vertical-tabs.md`) and almost none of the appearance.
Treating "vertical tabs are on" as "the sidebar is done" was an early mistake, recorded
here so it is not repeated.

## The layout

The single most important difference from stock Chromium: **the web contents do not
meet the window's edges.** The page sits on a rounded card, with the window's ground as
a mat at the top, the right and the bottom (the `card_gutter`, 6 DIP; the sidebar side
has none). The address row is the top of that card, with no gap and no hairline under
it, in the page's own colour: the colour the page draws along its top edge, else its
`theme-color`, else its background, with the row's icons and text flipped for contrast
(`features/toolbar.md` T3, T7, T15, T31). That one change accounts for most of "looks like
Arc". With the sidebar hidden completely, or in a full screen with no address row, the
page is edge to edge with no gutter and no rounded corner (`features/sidebar.md` Y19,
`features/toolbar.md` T33); the setting "Page flush against the window", off by default,
does the same beside an open sidebar (`features/sidebar.md` Y23).

## Targets and shipped values

The reference values are pixels measured on a 2000×1293 screenshot of Arc; Stedding's are
DIP, the defaults of the `SteddingArcStyleWindow` feature parameters
(`chrome/browser/ui/stedding_ui_metrics.cc`, patch 0002) or measured on a capture at
1400×880.

| Element | Arc reference | Stedding |
|---|---|---|
| Sidebar width | ~352 px, user-resizable, persisted | 352 measured; resizable from 126 to 480 by its edge or Settings (`features/settings.md` T7, `features/sidebar.md` Y18) |
| Card corner radius | ~12 | 12 (`contents_corner_radius`); the top corners belong to the address row while it shows (toolbar T16) |
| Card gutter | the mat around the page | 6 (`card_gutter`) at the top, the right and the bottom |
| Address row | thin, on the window ground | 33 measured: 28 DIP buttons (`toolbar_button_height`) and a 25 DIP field (`location_bar_height`), against Chromium's 46 |
| Tab row height | ~48 | 44 (`vertical_tab_height`); 36 and 30 in the Compact and Dense row heights (sidebar Y1) |
| Favicon | ~18, left inset ~28 | 18 (`tab_favicon_size`); in the rail 22, and 20 at Compact and Dense (sidebar Y8) |
| Active tab | a filled rounded rect, radius ~10, inset ~10 | radius 10 (`vertical_tab_corner_radius`) |
| Essentials | a grid of cards at the very top, ~150×50, radius ~12, icon only | cards 50 tall (`vertical_tab_pinned_height`), two to a row at the default width, a lone card stays card-sized |
| Space switcher | at the bottom: ~24 icons, one per Space, and a trailing `+` | the same: 24 DIP chips 12 apart, closing up to 4 before they overflow (`features/spaces.md` B11, B24) |

## Sidebar, top to bottom

| Element | What it is |
|---|---|
| **Essentials** | The cards above all Spaces: visible whichever Space is active |
| Space title | The active Space's icon and name, with two or more Spaces; it opens the Space menu (spaces B16) |
| Space-pinned tabs | Ordinary rows, favicon and title, pinned **within the current Space**, and folders of them (folders F38) |
| Clear line | A hairline with `Clear` at its right end, which closes the Space's unpinned tabs and leaves the pins (spaces B17, B20) |
| `New Tab` row | A plus glyph and label, muted, above the unpinned tabs; it opens the command bar |
| Unpinned tabs | The rest, folders among them |
| **Space switcher** | At the **bottom**, not the top: the downloads button at the left, the Space chips in the middle, `+` at the right |

Two things this project got wrong first, recorded so they are not repeated: the
essentials are not the same as pinned tabs (essentials are global, pinned tabs are per
Space), and the Space switcher is at the bottom of the sidebar, as icons rather than named
pills at the top.

## Address row

Back, forward and reload at the left; extension icons and the app menu at the right, with
no profile avatar. No omnibox chrome: no background, no border. The field takes the row
between the button clusters, and at rest the address gathers on the page's centre and
shows the whole address, the host in the text colour and the rest a step dimmer
(`features/toolbar.md` T18, T28–T30). Arc shows the bare host; Chromium's "Always show
full URLs", switched off from the field's menu, gives that.

## Command bar

![The command bar](images/ui-command-bar.png)

⌘T opens a centred overlay, not a focused omnibox: a rounded panel in the theme's dialog
colours with a result list beneath the field. The results mix open tabs in the current
Space, tabs in **other** Spaces labelled with their Space, and ordinary suggestions and
search (`features/commandbar.md`). The bar searches every Space, which is why one tab strip
holding every Space's tabs (ADR 0015) is the right shape rather than a limitation.

## How it is checked

![The Stedding window, beta 7](images/ui-current.png)

With four Spaces, two essentials and a Space-pinned tab (`--features
'SteddingArcStyleWindow:extra_spaces/3/pin_tabs/2/space_pin_tabs/1'`):

![Four Spaces, beta 7](images/ui-spaces.png)

The captures above are beta 7's, taken with `tooling/capture-state` at 1400×880, which
needs neither the keyboard nor the pointer. The measurements that matter are probes in
`tooling/probes/window.json`; `tooling/dev capture --assert tooling/probes/window.json`
checks them against a fresh capture, and `tooling/check-geometry` re-measures the gutters
and the corner radius in the committed images. Both capture tools run on macOS; on Windows the
capture is `tooling\win\capture.ps1`.

The corner radius, the row height and the pill radius are feature parameters, not
constants, so a value can be tried on a build that already exists, with no compile:

```
tooling/capture-state --size 1400x880 --features \
  'SteddingArcStyleWindow:contents_corner_radius/16/vertical_tab_height/48'
```

Pinned tabs cannot be seeded for a capture by writing `pinned_tabs` into a profile's
`Preferences`: Chromium's tracked-preference protection rejects a value it did not write.
The `pin_tabs` and `space_pin_tabs` parameters pin the first tabs once the window has
them instead, the same trade as `extra_spaces`.
