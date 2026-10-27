# Product specification

**Stedding targets full functional parity with Arc** (`decisions/0011-full-arc-parity.md`),
and goes past it where newer Arc-style browsers showed what people want (`ROADMAP.md` M10,
`decisions/0021-ideas-from-nook-and-aura.md`). This document is the inventory of what that
means. It is written from Arc's own documentation and uses Arc's terms for Arc's concepts,
so it can be checked against the thing it copies; where Stedding's name differs, it is
given beside Arc's (Favorites are Stedding's **essentials**, Air Traffic Control is
**routing**, Little Arc is the **little window**).

It is a specification, not a status report. Each item names its home: the feature spec
under `features/` that says what is built, partial or planned, a `BACKLOG.md` id, a
milestone, or the decision that deferred or cut it. The order of work is `BACKLOG.md`.

Arc is a fixed target: its maker put it in maintenance mode in May 2025 and moved to Dia
(`VISION.md`, "Competitors"). That is what makes parity finishable.

## How to read this

| Tier | Meaning |
|---|---|
| **[1.0]** | Required for parity. Ships before 1.0. |
| **[post-1.0]** | Real Arc behaviour, deferred deliberately, with the reason stated. |
| **[needs decision]** | Parity here conflicts with a documented out-of-scope item in `ROADMAP.md`, or needs infrastructure we do not have. Listed, not silently dropped. |
| **[not applicable]** | Exists in Arc but is a property of Arc's business, not a browser capability. |
| **[deferred]** | Real Arc behaviour, kept here but not in the first releases (ADR 0012). |
| **[never]** | Decided against for good (ADR 0020). |
| **[cut]** | Taken out by the owner's decision of 2026-09-26 (`PLAN.md`, decision 4; the cuts are in `docs/history/plan-2026-09-26.md`, section 2). |
| **[M10]** | Beyond parity: `ROADMAP.md` M10, one `BACKLOG.md` id each, built from written descriptions (ADR 0021). Not a condition of 1.0 unless it says so. |

"No spec row yet" marks a feature with no home but this document: it is in the plan only
here.

Stedding ships on macOS and Windows (`decisions/0006-platform-order-macos-first.md` sets
the order). A behaviour that works on one platform only says so here and in its spec.
Shortcuts are Arc's macOS chords; on Windows ⌘ reads as Ctrl and ⌥⌘ as Ctrl+Alt
(`features/windows.md` N7). Every deliberate divergence from Chromium's chords is in the
in-product reference (`features/shortcuts.md`) and in `SHORTCUTS.md`.

---

## 1. Sidebar and tabs

Top to bottom: the essentials, the Space title, **Pinned Tabs**, a divider (Stedding's
Clear line), **Unpinned Tabs**, and at the bottom the Space icons, the Library (not built
yet, `docs/features/library.md`) and a `+`.

- **Sidebar** **[1.0]** — a vertical tab strip in place of the horizontal one, on
  Chromium's own vertical tabs (ADR 0010). `⌘S` closes and opens it. Closed, it shrinks to
  a rail of icons or, as a setting, hides completely: the page goes edge to edge and the
  pointer at the window's leading edge slides the sidebar back over it
  (`features/sidebar.md` Y19). State persists. Chromium's switch to horizontal tabs stays,
  and Spaces, pins and folders work there too (`PLAN.md` decision 1; `features/menus.md`
  M8, M9; `features/spaces.md` B34).
- **Row height and text size** **[1.0]**, Stedding's own — three tab row heights and a
  sidebar text size (`features/sidebar.md` Y1–Y5); the rail of icons follows the row height
  too (Y8, Y12).
- **Pinned Tabs** **[1.0]** — saved per Space, above the divider, never auto-archived.
  `⌘D` pins. Arc describes them as between an app and a bookmark: navigating *within* the
  site stays in the tab; **a link that would leave the site opens Peek (§5) instead of
  replacing the pinned page**. A pin remembers its home page; away from it the row shows
  Arc's slash, and Option-click on the favicon or **Reset to Pinned Page** goes home, while
  a plain click only selects. Closing a pin works as in Arc: `⌘W`, its close button, a
  middle click or the menu's Close unloads it and sends it back to its home, in its place,
  whatever it was doing, after a page's own "Leave site?" (the owner, 2026-10-20;
  `features/pins.md` H3, H9, H16). A new pin joins the end of the run (`features/pins.md`).
- **Favorites** **[1.0]** — Stedding's essentials: tabs visible in *every* Space, above the
  Space title, drawn as cards. Arc caps them at 12; Stedding's Arc importer takes twelve
  and nothing else caps them (`features/import.md` I11). Distinct from Pinned Tabs; a
  spec that conflates the two gets the model wrong (`features/spaces.md` B6). They are
  shared by every Space, as in Arc, except in a Space with an Independent session, whose
  essentials are its own, in its session, and which shows only those (the owner, 2026-10-22;
  `S-254`, GitHub issue 8, ADR 0028).
- **Unpinned Tabs** **[1.0]** — below the divider, auto-archived when idle once the user
  picks a time (§11). `⇧⌘K` clears them as a set (`features/spaces.md` B20).
- **Folders** **[1.0]** — group tabs; **tabs in folders do not auto-archive**. Folders
  nest; rename, move and delete from the header's menu; drag a tab in. A collection type
  in the tab tree, not a tab group (ADR 0013; `features/folders.md`). A folder can join
  the pinned list, dragged over the divider or by Pin Folder, and its tabs then behave as
  pins (`features/folders.md` F38; the Arc importer still makes a pinned folder an ordinary
  one, `features/import.md` I3, `S-107`). Essentials take no folder. **Not deferrable**:
  on the comparable project this was the highest Arc-named request (412 upvotes), and
  users said they would not leave Arc without collapsible *pinned* folders
  (`AGENT-LOOP.md`, "Evidence").
- **Bookmarks** **[1.0]**, diverging — Arc has none; Pinned Tabs replace them. Stedding
  keeps Chromium's bookmarks (their menu rows stay; `⌘D` pins instead). Imported bookmarks
  stay bookmarks, and the command bar's **Turn Bookmarks into Pinned Tabs** makes pins and
  folders of them when asked, asking first above 50, and Settings shows the bar and the star
  again afterwards (`features/import.md` I13–I16, `features/settings.md` T27). Converting them
  by itself after an import is **[cut]**.
- **Tab switching** **[1.0]** — `⌥⌘↑/↓` moves in sidebar order; `⌘1`…`⌘8` jump to the
  Nth visible row and `⌘9` to the last (`PLAN.md` decision 5; `features/tabs.md` R10–R13);
  `⌃⇥` walks the five most recently used tabs of the Space (`features/switcher.md`).
- **Favicons** **[1.0]** — per tab; a pinned tab away from home shows it, and the favicon
  takes Option-click as the reset (above). A page that names no icon keeps the favicon its
  site gave the tab, never another site's (`features/tabs.md` R54).
- **Audio indicator and mute** **[1.0]** — click to mute; right-click mutes a tab that is
  not playing; an essentials card keeps its favicon and badges the sound
  (`features/tabs.md` R18). `⌃M` (Ctrl+M on Windows) mutes or unmutes the selected tabs,
  from inside a Split View too (R29).
- **Collapse Pinned Tabs** **[1.0]** — hide the pinned list without hiding the sidebar,
  from the Space's menu or the command bar, per Space (`features/pins.md` H17).
- **Previews on hover** **[post-1.0]** — hovering a pinned tab glances the site: recent
  mail, calendar events, open pull requests. Deferred because each site is a bespoke
  integration. The hover affordance itself is **[1.0]**, as a screenshot of the tab with
  no model (ADR 0020; `S-115`): every row not on screen shows a picture of its page as last
  seen, held in memory only, on the Mac and on Windows, and a pinned tab's card also names
  its Space and home (`features/pins.md` H8, H19–H23).
- **Rename tab** **[1.0]** — double-click (`features/tabs.md` R14–R17).
- **Multi-select tabs** **[1.0]** — ⌘-click and ⇧-click, then every verb acts on the
  selection (`features/tabs.md` R20–R22).
- **Sleeping tabs** **[1.0]** — Sleep Tab and Sleep Other Tabs in This Space; a Space can
  put its tabs to sleep after you leave it, a setting whose default is Never until sleep
  skips everything in use (`PLAN.md` decision 3; `features/tabs.md` R4–R8). Past Arc:
  tabs that sleep on a timer and under memory pressure (`S-111`), and a launch that loads
  only the selected tab (`S-110`).
- **Drag a tab out** **[1.0]** — the tab opens in a window that shows the same Spaces
  (`features/windows.md` G1). A window that shares nothing is a Blank Window (§5).
- **Sidebar export** **[1.0]** — a Space, or every Space with its pins, pinned folders and
  essentials (Export all Spaces…), exports to a file and imports back on any computer,
  merged by ids that survive a restart (`features/import.md` I18, I20;
  `features/sidebar-file.md` Sf2, Sf6). Scheduled backups and the version-2 catalog are
  **[cut]**; sync through a folder is below.
- **Sync through a folder** **[1.0, released in 0.3.0 beta 16]** — off by default; each computer
  writes its sidebar to its own file in a folder the user picks and merges the others',
  field by field, with removals only from the user's own action, large batches and Space
  deletions held for a yes, Undo and backups. Not a sync service: no account, no server, no
  network request; the user's own sync tool or shared drive moves the files
  (`features/sidebar-file.md` Sf7–Sf41, ADR 0029, `S-282`).
- **Copy URL, and copy as Markdown** **[1.0]** — `⇧⌘C` and `⌥⇧⌘C`, with tracking
  parameters removed, and a Copy Link button at the address field's right end, Option-click
  for Markdown, which a setting hides (`features/copy-link.md` L7; GitHub issue 11).
- **Reopen closed tab** **[1.0]** — `⇧⌘T`, Chromium's.
- **Child tabs** **[M10]** — a link opened in a new tab opens just below the page it came
  from; a setting, off by default since 2026-10-22 (the owner), draws it indented under that
  page, a closed parent's children move up, and the tree survives a restart
  (`features/tabs.md` R56–R59). Back returning to the parent is not built yet (R60, `S-92`).
- **Undo after closing tabs** **[M10]** — after a close, a toast with Undo that reopens those
  tabs in their Space and folder; off by default since 2026-10-21 (the owner), a setting turns
  it on (`features/tabs.md` R25–R28, R30).
- **The sidebar on the right** **[M10]** — "Sidebar on the right" in Settings, on the
  sidebar's own menu, the Mac's View menu and the command bar puts the sidebar at the
  window's right in every window at once; its edge, rail, handle and reveal edge mirror, and
  the Mac's traffic lights stay left over the address row (`features/sidebar.md` Y34–Y43,
  `S-96`). Released in 0.3.0 beta 16.

## 2. Spaces

- **Spaces** **[1.0]** — distinct browsing areas, each with its own pinned section,
  unpinned section, colour and icon: one tab strip filtered by the active Space (ADR 0015)
  and one Space list for every window (ADR 0016; `features/spaces.md`). `⌃1`…`⌃9` focuses
  a Space and `⌥⌘←/→` moves to the next or previous one. Over the sidebar a sideways
  scroll steps to the next or previous Space, as in Arc: a tilt wheel or Shift with the
  wheel, and on Windows a touchpad's sideways scroll and Ctrl with the wheel too
  (`features/spaces.md` B39, GitHub issue 10); on the Mac a two-finger swipe follows the
  fingers (B35), which Windows does not do yet (`docs/history/plan-2026-09-26.md` TAB-31).
  The icons live at the sidebar's bottom.
- **Create, rename, reorder, delete** **[1.0]** — `+` creates; the Space's title row opens
  its menu (Edit Space…, colour, rename, delete); drag a Space icon, or Move Left / Move Right, to
  reorder. Deleting a Space asks first, naming the Space, its tabs and where they go, then
  moves its tabs into the Space the window shows; only the last Space cannot be deleted
  (`PLAN.md` decision 7; B5, B16, B27).
- **Theme and icon** **[1.0]** — Edit Space, from the Space menu or Settings: any emoji,
  and any colour from a palette or a picker, one colour for both looks or one for each of
  the light and dark looks, tinting the sidebar; light, dark or automatic for the whole
  browser (`features/welcome.md` W4, W7; `features/spaces.md` B31, B41–B44). A gradient:
  **[M10]** (`S-99`).
- **Per-Space sessions** **[1.0]** — a Space can keep its own cookies, HTTP cache and site
  storage, so the same site can be signed into with different accounts in different
  Spaces of one window. Opt-in per Space; off, Spaces share the profile's jar.
  Extensions, settings, history and saved passwords stay on the profile. A Chromium
  `StoragePartition`, not a profile (ADR 0019; `features/sessions.md`). Binding two Spaces
  to one jar, or giving a Space its own extensions, needs a later ADR. A Space with its own
  session is marked wherever Stedding names it as a place to go -- a cookie on its chip and
  after its name in the title row, the tab menu's Space rows, the command bar, the archive
  and Settings (`features/sessions.md` S32, S34, `features/spaces.md` B38; released in 0.2.0
  beta 18 on Windows and beta 20 on the Mac). Its essentials are its own and stay in its
  session (`features/sessions.md` S8, ADR 0028).
- **Move tabs between Spaces** **[1.0]** — the command bar's "Move Tab to [Space]", the tab
  menu, `⌥⇧⌘←/→`, or a drag onto a Space icon (`features/spaces.md` B12, B22).
- **Air Traffic Control** **[1.0]** — Stedding's routing: rules sending a site, a part of
  an address or an exact address to a Space, plus a default Space for links from other
  applications (`features/routing.md`). One of Arc's most distinctive features and easy
  to overlook. Rules made from the Space menu, and edited in Settings: `S-126`.
- **Focus and Hide Other Spaces** **[1.0]**, Stedding's own — one Space on screen at a
  time, from the command bar (`features/focus.md`, `features/share-coat.md`).
- **Live Folders (GitHub)** **[post-1.0]** — a folder filled with your open pull requests.
  A bespoke integration; deferred, not dropped. No spec row yet.
- **Live Calendars** **[post-1.0]** — a pinned calendar counts down to the next event with
  a Join button. Same reasoning. No spec row yet.
- **Share Space** **[needs decision]** — publishes a snapshot of a Space to a public URL.
  Needs hosting we do not have, and shared links cannot be deleted by the sharer. The
  local half, exporting a Space, is §1's sidebar export.
- **Share Quote** **[needs decision]** — the same: a hosted link whose preview image holds
  the quoted text.
- **A throwaway Space, Copy Tab to Space, a clipboard fenced per Space** — **[cut]**
  (`features/throwaway.md`, `features/clipboard.md`, `features/sessions.md` S14–S15).

## 3. Command bar

- **Command bar** **[1.0]** — Arc's combined new tab, URL entry, search, tab switcher and
  action palette. `⌘T` opens it and lists open tabs from every Space first; `⌘L` opens it
  with the page's address in it (`features/commandbar.md`). Arc has no always-visible URL
  bar. Stedding keeps an address row on top of the page that shows the whole address,
  because real use asked for it (`ROADMAP.md` M4; `features/toolbar.md` T28–T30).
- **Actions mode** **[1.0]** — `⇥` in an empty bar, a leading `>`, or `⇧⌘P`. It lists
  Stedding's verbs, an allow-list of the window's commands and rows for most of
  Stedding's settings (`features/commandbar.md` K8–K17, K22, K28, K29). `ROADMAP.md`
  ("The quality bar") asks for every setting a user would change to be found here too;
  not every one is (the sidebar's width, `features/sidebar.md` Y22, and Undo after closing
  tabs, `features/tabs.md` R30, have no row; one table for both is `S-158`).
- **Site Search** **[1.0]** — a search engine's keyword, then the query, searches that site
  directly, from Chromium's own keywords and their `%s` templates (K18). `@Space` narrows
  the list to a Space (K19). Tab after a site's name turns it into a search chip, the
  list being Chromium's own search engine settings (K27). Typing completes to a site from
  history, the rest selected (K23).
- **Full URL in Toolbar** **[1.0]** — the address row above, on by default; `⇧⌘D` shows or
  hides it on its own, and a setting hides it with the sidebar (`features/toolbar.md`
  T8–T12).
- **Instant Links** **[needs decision]** — `⇧↵` opens the top result instead of the
  results page. No spec row yet. The "Folder of …" variant is AI and **[never]** (§8).
- **Ranking** **[1.0]** — Arc never documented its ranking, so ours is specified rather
  than inherited: the typed text's own row first, and a site search it names, then
  up to four open tabs, the active Space's first and then the other Spaces', each in the
  strip's order, up to three archived tabs, blank documents
  for text that starts with "new", then the omnibox's suggestions as they arrive.
  Nothing is scored (`features/commandbar.md` K2, K4, K5, K7, K27, K28).

## 4. Split View

- **Split View** **[1.0]** — two pages side by side in one window, on Chromium's own split
  view. Made with `⌃⌘N` on the Mac (the current tab and a new one; Chromium's `⌥⌘N`
  too, except while Arc runs and takes it, `S-79`) or from a tab's menu; the command
  bar has no row for it. Dragging a tab onto the page makes one too, from the sidebar or the
  horizontal strip: the half under the pointer lights in the Space's colour, and the dropped
  page takes that half (`features/splits.md` J10–J15; asked for in GitHub issue 7). More than two
  panes, or panes stacked vertically, are **[post-1.0]** (`ROADMAP.md` M5).
- **A split is a tab** **[1.0]** — one sidebar row and one unit for every verb: pin,
  sleep, move to a Space, rename. This is the part most clones miss
  (`features/splits.md` J1, J4).
- **Persistence** **[1.0]** — returning to the row, and a restart, bring the split back
  (J1). What `⌘W` does on a split is still to be decided (J3; `S-102`).

## 5. Transient windows

- **Peek** **[1.0]** — a link from a pinned tab or an essential that leaves its site
  opens in a peek, a little window over the window, nearly its size, instead of
  navigating the pinned tab away. "Open as Tab" (`⌘O`) and "Open in Split View" (`⇧⌘O`,
  beside the pinned tab) move the very page into the window; Escape or a click on the
  window closes it. **Peek is what makes pinned tabs behave like apps.** Rebuilt on the
  little window (2026-10-25, `S-93`), so the page is a whole tab; on by default (the owner,
  2026-10-25, `PLAN.md` decision 2), with its switch in Settings › Stedding
  and on the welcome flow. "Open a peek with" can ask for a press held 0.3 s or 0.5 s
  instead of a click, so a plain click follows the link in the pinned tab as before
  (`features/peek.md` P18).
- **Little Arc** **[1.0]** — the little window: a link from another application opens in
  a small window of its own, to read and dismiss. Its top is one row, the main window's
  address row on the page's colour with the traffic lights inline, light or dark as the
  main window (`features/little.md` E8, E9); `⌘O` or the row's "Open in Stedding" button
  moves the page into the main window (a new one when none is open) and `⇧⌘O` into a
  split, as the page's menu and the File menu also offer (E7). It has no Space commands
  (`PLAN.md` decision 9). On Windows since 0.3.0 beta 7, with Windows' own title bar
  (`features/little.md` E10).
  Diverging from Arc: no global `⌥⌘N` to open one (`⌥⌘N` splits, as `⌃⌘N` does,
  little E5), and a little window is never closed for being idle, where Arc archives it
  after 6 hours (the idle close is **[cut]**; little E3).
- **Folder peek** **[post-1.0]** — hover a closed folder, search or scroll it, and open one
  tab without expanding it. No spec row yet.
- **Blank Window** **[1.0]** — a window that does not share the Spaces, `⌥⇧⌘N`
  (`features/windows.md` G4).
- **Incognito Window** **[1.0]** — Chromium's private window, in colours of its own, with
  nothing reaching the sidebar's model, the session or the archive
  (`features/private.md`).
- **A page already open in another window** **[M10]** — "Show here / Go to window"
  instead of a second copy or a silent jump (`S-94`).

## 6. Boosts — [deferred]

Deferred by `decisions/0012-defer-boosts-and-easels.md`; the reasons and what brings them
back are there and in `ROADMAP.md` ("Deferred, with the intent to return"). Specified here
so the eventual work has something to build against:

- **Boosts** — per-site restyling: colour, inverted lightness for a dark mode,
  contrast, brightness and saturation, font presets, size 90–150%, capitalization, and
  **full CSS and JavaScript editors**.
- **Zap** — click a page element to hide it on that site's pages; `\` restores.
- **Sharing Boosts** — Arc hosted a gallery. The local half, a Boost exported and
  imported as a file, is the part worth having.

Extensions answer all three today (Stylus, Violentmonkey, uBlock Origin's element picker).
A Boost is a script host, so a threat model comes before any code. When they return,
Aura's editor is the model: a live preview while typing and a switch per site in the page
menu (ADR 0021).

## 7. Easels and captures

- **Captures** **[1.0]** — the page as shown, a region, or the whole document, as a PNG in
  Downloads and on the clipboard (`⇧⌘2`, `⌥⇧⌘2`, `⇧⌘1`; `features/screenshot.md`). Arc
  sends a region to an Easel; without Easels it goes to the file and the clipboard.
- **Easels** **[deferred]** — whiteboards holding captures, drawings and text (ADR 0012):
  a drawing application inside a browser and the largest item in this document. Captures
  stay **[1.0]**; they are useful without a canvas.
- **Arc Notes** **[not applicable]** — Arc removed them in three phases during 2024.
  Parity with a feature its author deleted is not parity.
- **New Documents** **[1.0]** — command bar rows that open a blank document in Google
  Docs, Sheets, Slides or Forms, Notion, Figma, GitHub, Word, Excel or PowerPoint through
  their own .new addresses (`features/commandbar.md` K28).

## 8. Arc Max (AI) — [never]

Arc Max bundles 5-second previews on hover, tidy tab titles, tidy downloads, tidy tabs,
Ask on Page, Instant Links and ChatGPT in the command bar.

**Stedding ships no bundled model** (`decisions/0020-no-bundled-model.md`). Command-bar
chat, Ask on Page, Instant Links' "Folder of …", and a persistent agent holding a Space's
cookies are never; nor are the AI features of Nook and Aura (a sidebar chat, a tab
organiser, an agent-control server, "Browse for Me"; ADR 0021). The halves without a model
stay: *tidy downloads* (grouping by day and kind, **[1.0]**, `features/library.md` Lb5),
the *hover preview* as a screenshot of the tab (**[1.0]**, §1), and *tidy titles*, which
may ship later as an optional local heuristic (ADR 0020; no spec row yet).

## 9. Media and downloads

- **Mini Player / Picture-in-Picture** **[1.0]** — a video player inside the page card
  (`features/player.md`); following you into the sidebar when you leave the tab is
  **[M10]** (`S-95`). `⌥⇧⌘P` puts the page's video in picture in picture and brings it back
  (Mp5).
- **Audio Player** **[1.0]** — playback controls for a tab playing sound, none for a muted
  one (`features/player.md` Mp3).
- **Downloads** **[1.0]** — Chromium's downloads, with the progress ring on the sidebar's
  bottom-left button (`features/toolbar.md` T14). History and Downloads as panels in the
  sidebar's column, in the tabs' place, by ⌘Y and ⇧⌘J, the foot's History button and the
  downloads button: **[M10]**, released in 0.3.0 beta 16 (`features/sidebar-panels.md`, `S-98`).
- **Library** **[1.0]** — archived tabs, captures and downloads behind the sidebar's
  bottom-left button, and easels when they return (`features/library.md`; `S-61`).

## 10. Profiles, windows, sync

- **Profiles** **[1.0]** — Chromium's profiles, as Chromium has them. Arc binds a profile
  to a Space; Stedding gives a Space cookies of its own instead (§2, ADR 0019), and the Arc
  importer drops a profile binding and says so (`features/import.md` I8).
- **Multi-window and multi-display** **[1.0]** — every window shows the same Spaces; Blank
  Windows are independent (ADR 0016; `features/windows.md`). Essentials and pins are per
  window until a pin can show as a ghost row in the other windows (windows G2).
- **Arc Sync** **[1.0, as sync through a folder]** — cross-device sync of Spaces, pinned tabs
  and order. `ROADMAP.md` puts sync services out of scope and `PRIVACY.md` runs no accounts,
  so the answer is file-based: sync through a folder the user's own sync tool keeps (§1,
  ADR 0029, released in 0.3.0 beta 16), and a Space still travels as a file. Open tabs,
  history and passwords do not travel. This was the largest unmet demand in the space: the
  equivalent request on Zen's tracker had 475 upvotes after about two years open
  (`AGENT-LOOP.md`, "Evidence").
- **Recovery Card** **[not applicable]** — recovery for an Arc account we do not have.
- **Arc account / sign-in** **[not applicable]** — Stedding ships no account. A deliberate
  divergence, not a gap.

## 11. Archive, history, search

- **Auto Archive** **[1.0]** — idle unpinned tabs archive after a set time, reset by viewing
  the tab; nothing pinned, in a folder or in use is archived. Arc archives after 12 hours by
  default and does not let you turn it off. Stedding's is off (Never) by default since 0.2.0
  beta 14, and offers 6 hours, 12 hours, 1 day, 3 days and 7 days; the welcome flow asks
  (`features/archive.md` A6, `features/welcome.md` W12).
- **View and restore the archive** **[1.0]** — the Archived view, by day and Space and
  searchable, and archived tabs in the command bar (archive A7–A11).
- **History** **[1.0]** — `⌘Y`, Chromium's; as a panel in the sidebar's column with
  Chromium's page one click away **[M10]** (`features/sidebar-panels.md`, `S-98`).
- **Find in page** **[1.0]** — `⌘F`, Chromium's.

## 12. The rest

- **Keyboard shortcut customisation** **[1.0]** — the Shortcuts block in Settings is
  editable (`S-91`, `features/shortcuts.md` Z5, Z10–Z22): record a chord, a conflict named
  before it is taken, a switch per command, Reset per row and for all, search and a group
  filter. The chords are the computer's, kept in Local State. Released in 0.3.0 beta 16.
- **Site Control Center** **[1.0]** — per-site permissions and controls from the address
  area: Chromium's page info with Stedding's controls in it, from the site chip and the
  command bar (`features/site-controls.md`, `S-118`; released in part in 0.3.0 beta 16). The
  blocker's switch joins it with `S-88`. Its entry to Boosts waits on Boosts.
- **Developer Mode** **[1.0]** — a localhost page always shows the address row
  (`features/toolbar.md` T11), and its tab is marked in the sidebar as Arc marks it:
  a yellow and black tape round the row while it is on screen, and at the
  Comfortable density its host and port under the title, with a setting to turn
  it off (`features/local-tabs.md`; released in 0.2.0 beta 18 on Windows and beta 20 on the
  Mac). Arc's other developer affordances: `S-117`.
- **Extensions** **[1.0]** — full Chrome Web Store compatibility, a hard requirement
  (`AGENTS.md`). `⌘E` (Ctrl+Alt+E) runs one, as in Arc: hold to choose, let go to run; the
  command bar's actions mode lists each extension, so they stay reachable with the address
  row hidden (`features/toolbar.md` T13, T39, T40; `S-104`).
- **Import from another browser** **[1.0]** — Arc in one click, on the Mac and, since 0.3.0
  beta 13, on Windows (`features/import.md`, `S-81`); Dia and Safari's export file, with
  bookmarks, history and passwords (**[M10]**, `S-101`, released in 0.3.0 beta 16);
  Chromium's own importer for Safari and Firefox on macOS and for Firefox, Internet Explorer
  and the old Edge on Windows (`features/welcome.md` W3). Chrome, Brave and the new Edge come
  with Phase 2's importer (`PLAN.md` decision 8).
- **Progressive Web Apps** — Arc does not install them and points users to Favorites.
  Supporting them anyway is this document's position, since parity is the floor; no tier
  is decided. Any page can become an app of its own, on Chromium's web apps: "Add to
  Dock…" on the Mac, as Safari has it (the File menu, the app menu, the command bar), with
  a Dock tile and a launcher in Stedding's own Applications folder, and Chromium's "Install
  page as app…" on Windows, with its Start menu entry. The app's window is drawn edge to
  edge, with no sidebar or card; the app keeps the session of the Space it was made in
  (ADR 0025, proposed), and takes no links from the browser until the user turns that on
  for it (`features/web-apps.md`; released in 0.2.0 beta 18 on Windows and beta 20 on the
  Mac).
- **Arc Search (iOS/Android)** **[not applicable]** — mobile is out of scope
  (`ROADMAP.md`).

## 13. Beyond parity (M10)

What Arc never had, rebuilt from written descriptions of Nook and Aura and never copied
(ADR 0021; `ROADMAP.md` M10). Besides the **[M10]** items above:

- **Ad and tracker blocking built in**, with a switch per site, on Chromium's subresource
  filter and lists fetched at run time, never built in (`S-88`, ADR 0030,
  `features/blocker.md`): its first phase released in 0.3.0 beta 16, off by default.
- **Clean links on every page opened**, not only on a copied link (`S-89`;
  `features/clean-links.md`, released in 0.3.0 beta 16): a page you open loses the tracking parameters a copy loses,
  and a known redirect page that carries its target is skipped; Settings → Stedding →
  Privacy turns it off and keeps a site's parameters.
- **Web apps keep their own keys**: the first press goes to the page, a second to
  Stedding (`S-90`).
- **Dark mode for web pages**, on Chromium's own (`S-100`): one switch, a moon at the
  address row's right end, ⌥⇧⌘D, a command bar row, a page-menu row and, on the Mac, a
  View menu row, with sites kept light or the only ones darkened, and an app's title bar
  darkened with its page (`features/dark-pages.md`; released in 0.2.0 beta 18 on Windows and
  beta 20 on the Mac).
- **Smaller things seen in Nook**: the site's controls in one panel (`S-118`) and the rest
  of the small conveniences (`S-125`). Built in 0.2.0 beta 14: clear a site's cookies and
  reload (`features/commandbar.md` K24, `features/sessions.md` S27), folder verbs
  (`features/folders.md` F30–F33), a pin's home address edited by hand and a middle click
  that sends a pin home (`features/pins.md` H15, H16), mute and picture in picture by key
  (`features/tabs.md` R29, `features/player.md` Mp5), the sidebar's edge showing where to
  drag and a double click that resets its width (`features/sidebar.md` Y22), the page
  flush against the window (Y23), and three of the conveniences: Close Duplicate Tabs
  (commandbar K26), a middle click on the sidebar's ground that opens the command bar
  (sidebar Y24) and a switch for the link address shown on hover (`features/page.md` U9).

---

## What parity does not cover

Three areas collide with a documented out-of-scope item:

1. **AI (§8)** — closed by ADR 0020: no bundled model, no Space intern.
2. **Sync (§10)** — no Stedding account or server; the sidebar travels through a folder the
   user's own sync tool keeps (ADR 0029), or as a file, and open tabs, history and passwords
   stay on each computer.
3. **Hosted sharing (§2, §6)** — Share Space, Share Quote, the Boost gallery.

So "full parity" means *parity with the local, offline capabilities of Arc*, the large
majority of it, with the gaps listed. With Boosts and Easels deferred (ADR 0012), the
honest target until that is revisited is **parity minus Boosts and Easels**.

## Where we deliberately differ

- **No account, ever.** Arc requires one.
- **Auto Archive is off until you pick a time** (since 0.2.0 beta 14), and little windows are
  never closed for idling.
- **An address row with the whole address**, where Arc has none.
- **Bookmarks stay**, beside pinned tabs.
- **Chromium's horizontal tabs stay one switch away.**
- **No telemetry**, per `PRIVACY.md`.
- **No bundled model, no Space intern, no command-bar chat** (ADR 0020). Dia exists for
  people who want an AI browser.
- **Open source under BSD**, so the browser cannot be discontinued out from under its
  users, which is what happened to Arc's.

## UI spec

The target is a **close, measured match of Arc's window chrome**, taken from reference
screenshots of Arc on macOS. This section holds the targets and the values Stedding ships;
the behaviour of each surface, with its tests, is in its feature spec (`features/sidebar.md`,
`features/toolbar.md`, `features/tabs.md`, `features/page.md`, `features/commandbar.md`).
Where this section disagrees with a screenshot of Arc, the screenshot wins and this
section is corrected.

Chromium's built-in vertical tab strip is *not* the target. It supplies the tab model
(`decisions/0010-ride-upstream-vertical-tabs.md`) and almost none of the appearance.
Treating "vertical tabs are on" as "the sidebar is done" was an early mistake, recorded
here so it is not repeated.

### The layout

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

### Targets and shipped values

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

### Sidebar, top to bottom

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

### Address row

Back, forward and reload at the left; extension icons and the app menu at the right, with
no profile avatar. No omnibox chrome: no background, no border. The field takes the row
between the button clusters, and at rest the address gathers on the page's centre and
shows the whole address, the host in the text colour and the rest a step dimmer
(`features/toolbar.md` T18, T28–T30). Arc shows the bare host; Chromium's "Always show
full URLs", switched off from the field's menu, gives that.

### Command bar

![The command bar](images/ui-command-bar.png)

⌘T opens a centred overlay, not a focused omnibox: a rounded panel in the theme's dialog
colours with a result list beneath the field. The results mix open tabs in the current
Space, tabs in **other** Spaces labelled with their Space, and ordinary suggestions and
search (`features/commandbar.md`). The bar searches every Space, which is why one tab strip
holding every Space's tabs (ADR 0015) is the right shape rather than a limitation.

### How it is checked

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
