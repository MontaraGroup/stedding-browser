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
(`COMPETITORS.md`). That is what makes parity finishable.

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
  sidebar text size (`features/sidebar.md` Y1–Y5).
- **Pinned Tabs** **[1.0]** — saved per Space, above the divider, never auto-archived.
  `⌘D` pins. Arc describes them as between an app and a bookmark: navigating *within* the
  site stays in the tab; **a link that would leave the site opens Peek (§5) instead of
  replacing the pinned page**. A pin remembers its home page; away from it the row shows
  Arc's slash, and Option-click on the favicon or **Reset to Pinned Page** goes home, while
  a plain click only selects. `⌘W` puts a pin to sleep instead of closing it. A new pin
  joins the end of the run (`features/pins.md`).
- **Favorites** **[1.0]** — Stedding's essentials: tabs visible in *every* Space, above the
  Space title, drawn as cards. Arc caps them at 12; Stedding's Arc importer takes twelve
  and nothing else caps them (`features/import.md` I11). Distinct from Pinned Tabs; a
  spec that conflates the two gets the model wrong (`features/spaces.md` B6).
- **Unpinned Tabs** **[1.0]** — below the divider, auto-archived when idle once the user
  picks a time (§11). `⇧⌘K` clears them as a set (`features/spaces.md` B20).
- **Folders** **[1.0]** — group tabs; **tabs in folders do not auto-archive**. Folders
  nest; rename, move and delete from the header's menu; drag a tab in. A collection type
  in the tab tree, not a tab group (ADR 0013; `features/folders.md`). Folders inside the
  pinned list, whose tabs behave as pins, are not built yet (`S-107`). **Not deferrable**:
  on the comparable project this was the highest Arc-named request (412 upvotes), and
  users said they would not leave Arc without collapsible *pinned* folders (`EVIDENCE.md`).
- **Bookmarks** **[1.0]**, diverging — Arc has none; Pinned Tabs replace them. Stedding
  keeps Chromium's bookmarks (their menu rows stay; `⌘D` pins instead). Imported bookmarks
  stay bookmarks, and the command bar's **Turn Bookmarks into Pinned Tabs** makes pins and
  folders of them when asked (`features/import.md` I13–I16). Converting them by itself
  after an import is **[cut]**.
- **Tab switching** **[1.0]** — `⌥⌘↑/↓` moves in sidebar order; `⌘1`…`⌘8` jump to the
  Nth visible row and `⌘9` to the last (`PLAN.md` decision 5; `features/tabs.md` R10–R13);
  `⌃⇥` walks the five most recently used tabs of the Space (`features/switcher.md`).
- **Favicons** **[1.0]** — per tab; a pinned tab away from home shows it, and the favicon
  takes Option-click as the reset (above).
- **Audio indicator and mute** **[1.0]** — click to mute; right-click mutes a tab that is
  not playing; an essentials card keeps its favicon and badges the sound
  (`features/tabs.md` R18). `⌃M` (Ctrl+M on Windows) mutes or unmutes the selected tabs,
  from inside a Split View too (R29).
- **Collapse Pinned Tabs** **[1.0]** — hide the pinned list without hiding the sidebar,
  from the Space's menu or the command bar, per Space (`features/pins.md` H17).
- **Previews on hover** **[post-1.0]** — hovering a pinned tab glances the site: recent
  mail, calendar events, open pull requests. Deferred because each site is a bespoke
  integration. The hover affordance itself is **[1.0]**, as a screenshot of the tab with
  no model (ADR 0020; `S-115`). Today a pinned tab's hover card names its Space and
  home (`features/pins.md` H8).
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
- **Sidebar export** **[1.0]** — a Space exports to a file and imports back
  (`features/import.md` I18, I20; `features/sidebar-file.md`). Scheduled backups, the
  sidebar folder and the version-2 catalog are **[cut]**.
- **Copy URL, and copy as Markdown** **[1.0]** — `⇧⌘C` and `⌥⇧⌘C`, with tracking
  parameters removed (`features/copy-link.md`).
- **Reopen closed tab** **[1.0]** — `⇧⌘T`, Chromium's.
- **Child tabs** **[M10]** — a link opened in a new tab sits under its opener, and Back
  returns to it (`S-92`).
- **Undo after closing tabs** **[M10]** — after a close, a toast with Undo that reopens those
  tabs in their Space and folder; a setting turns it off (`features/tabs.md` R25–R28, R30).
- **The sidebar on the right** **[M10]** — a setting (`S-96`).

## 2. Spaces

- **Spaces** **[1.0]** — distinct browsing areas, each with its own pinned section,
  unpinned section, colour and icon: one tab strip filtered by the active Space (ADR 0015)
  and one Space list for every window (ADR 0016; `features/spaces.md`). `⌃1`…`⌃9` focuses
  a Space and `⌥⌘←/→` moves to the next or previous one; a two-finger swipe in the sidebar
  switches, on the Mac only so far (`docs/history/plan-2026-09-26.md` TAB-31); the icons live at the sidebar's
  bottom.
- **Create, rename, reorder, delete** **[1.0]** — `+` creates; the Space's title row opens
  its menu (rename, colour, icon, delete); drag a Space icon, or Move Left / Move Right, to
  reorder. Deleting a Space asks first, naming the Space, its tabs and where they go, then
  moves its tabs into the Space the window shows; only the last Space cannot be deleted
  (`PLAN.md` decision 7; B5, B16, B27).
- **Theme and icon** **[1.0]** — a colour from five swatches and an icon from a fixed set,
  tinting the sidebar; light, dark or automatic for the whole browser
  (`features/welcome.md` W4, W7; `features/spaces.md` B31). Any colour, a gradient and any
  emoji: **[M10]** (`S-99`).
- **Per-Space sessions** **[1.0]** — a Space can keep its own cookies, HTTP cache and site
  storage, so the same site can be signed into with different accounts in different
  Spaces of one window. Opt-in per Space; off, Spaces share the profile's jar.
  Extensions, settings, history and saved passwords stay on the profile. A Chromium
  `StoragePartition`, not a profile (ADR 0019; `features/sessions.md`). Binding two Spaces
  to one jar, or giving a Space its own extensions, needs a later ADR. A Space with its own
  session is marked wherever Stedding names it as a place to go -- a cookie on its chip and
  after its name in the title row, the tab menu's Space rows, the command bar, the archive
  and Settings -- and pinning one of its tabs to the essentials, which use the shared
  session, says so with an Undo (`features/sessions.md` S32–S34, `features/spaces.md` B38;
  released in beta 18, on Windows so far).
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
  Stedding's settings (`features/commandbar.md` K8–K17, K22, K28, K29). `QUALITY.md`
  asks for every setting a user would change to be found here too; not every one is
  (the sidebar's width, `features/sidebar.md` Y22, and Undo after closing tabs,
  `features/tabs.md` R30, have no row; one table for both is `S-158`).
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
  bar has no row for it. Making one by dragging a row onto the page: `S-113`. More than two
  panes, or panes stacked vertically, are **[post-1.0]** (`ROADMAP.md` M5).
- **A split is a tab** **[1.0]** — one sidebar row and one unit for every verb: pin,
  sleep, move to a Space, rename. This is the part most clones miss
  (`features/splits.md` J1, J4).
- **Persistence** **[1.0]** — returning to the row, and a restart, bring the split back
  (J1). What `⌘W` does on a split is still to be decided (J3; `S-102`).

## 5. Transient windows

- **Peek** **[1.0]** — a link from a pinned tab or an essential opens in an overlay
  instead of navigating the pinned tab away; `⌘O` makes it a real tab, it can become a
  split, and a click outside dismisses it. **Peek is what makes pinned tabs behave like
  apps.** It was built and is switched off until it is rebuilt (`PLAN.md` decision 2;
  `features/peek.md`); the rebuild shares one primitive with the little window, a page
  that is a full tab in all but its place (**[M10]**, `S-93`).
- **Little Arc** **[1.0]** — the little window: a link from another application opens in
  a small window of its own, to read and dismiss; `⌘O` moves the page into the main
  window and `⇧⌘O` into a split (`features/little.md`). It has no Space commands
  (`PLAN.md` decision 9). The Mac only: on Windows such links open as tabs (`S-56`).
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
  sidebar's column: **[M10]** (`S-98`).
- **Library** **[1.0]** — archived tabs, captures and downloads behind the sidebar's
  bottom-left button, and easels when they return (`features/library.md`; `S-61`).

## 10. Profiles, windows, sync

- **Profiles** **[1.0]** — Chromium's profiles, as Chromium has them. Arc binds a profile
  to a Space; Stedding gives a Space cookies of its own instead (§2, ADR 0019), and the Arc
  importer drops a profile binding and says so (`features/import.md` I8).
- **Multi-window and multi-display** **[1.0]** — every window shows the same Spaces; Blank
  Windows are independent (ADR 0016; `features/windows.md`). Essentials and pins are per
  window until a pin can show as a ghost row in the other windows (windows G2).
- **Arc Sync** **[needs decision]** — cross-device sync of Spaces, pinned tabs and order.
  `ROADMAP.md` puts sync services out of scope and `PRIVACY.md` runs no accounts; today a
  Space travels as a file (§1). This is the largest unmet demand in the space: the
  equivalent request on Zen's tracker had 475 upvotes after about two years open
  (`EVIDENCE.md`). End-to-end encrypted, self-hostable or file-based answers are possible
  without becoming a service company; none is decided.
- **Recovery Card** **[not applicable]** — recovery for an Arc account we do not have.
- **Arc account / sign-in** **[not applicable]** — Stedding ships no account. A deliberate
  divergence, not a gap.

## 11. Archive, history, search

- **Auto Archive** **[1.0]** — idle unpinned tabs archive after a set time, reset by viewing
  the tab; nothing pinned, in a folder or in use is archived. Arc archives after 12 hours by
  default and does not let you turn it off. Stedding's is off (Never) by default since beta 14,
  and offers 6 hours, 12 hours, 1 day, 3 days and 7 days; the welcome flow asks
  (`features/archive.md` A6, `features/welcome.md` W12).
- **View and restore the archive** **[1.0]** — the Archived view, by day and Space and
  searchable, and archived tabs in the command bar (archive A7–A11).
- **History** **[1.0]** — `⌘Y`, Chromium's.
- **Find in page** **[1.0]** — `⌘F`, Chromium's.

## 12. The rest

- **Keyboard shortcut customisation** **[1.0]** — Arc has a full remapping page. Ours is
  `S-91` (in M10, and the one M10 item 1.0 needs); the reference is read-only today
  (`features/shortcuts.md` Z5).
- **Site Control Center** **[1.0]** — per-site permissions and controls from the address
  area. Chromium's page info serves it today; one panel of Stedding's own, with the
  blocker's switch, is `S-118` (M10). Its entry to Boosts waits on Boosts.
- **Developer Mode** **[1.0]** — a localhost page always shows the address row
  (`features/toolbar.md` T11), and its tab is marked in the sidebar as Arc marks it:
  a yellow and black tape round the row while it is on screen, and at the
  Comfortable density its host and port under the title, with a setting to turn
  it off (`features/local-tabs.md`; released in beta 18, on Windows so far). Arc's other
  developer affordances: `S-117`.
- **Extensions** **[1.0]** — full Chrome Web Store compatibility, a hard requirement
  (`AGENTS.md`). `⌘E` to cycle extension actions is planned (`features/toolbar.md` T13;
  `S-104`).
- **Import from another browser** **[1.0]** — Arc in one click on the Mac
  (`features/import.md`; Windows is `S-81`); Chromium's own importer for Safari and
  Firefox on macOS and for Firefox, Internet Explorer and the old Edge on Windows
  (`features/welcome.md` W3). Chrome, Brave and the new Edge come with Phase 2's importer
  (`PLAN.md` decision 8), and Dia and Safari's export file with it (**[M10]**, `S-101`).
- **Progressive Web Apps** — Arc does not install them and points users to Favorites.
  Supporting them anyway is this document's position, since parity is the floor; no tier
  is decided. Any page can become an app of its own, on Chromium's web apps: "Add to
  Dock…" on the Mac, as Safari has it (the File menu, the app menu, the command bar), with
  a Dock tile and a launcher in Stedding's own Applications folder, and Chromium's "Install
  page as app…" on Windows, with its Start menu entry. The app's window is drawn edge to
  edge, with no sidebar or card; the app keeps the session of the Space it was made in
  (ADR 0025, proposed), and takes no links from the browser until the user turns that on
  for it (`features/web-apps.md`; released in beta 18, on Windows so far).
- **Arc Search (iOS/Android)** **[not applicable]** — mobile is out of scope
  (`ROADMAP.md`).

## 13. Beyond parity (M10)

What Arc never had, rebuilt from written descriptions of Nook and Aura and never copied
(ADR 0021; `ROADMAP.md` M10). Besides the **[M10]** items above:

- **Ad and tracker blocking built in**, with a switch per site; its own ADR first: the
  engine, and filter lists fetched at run time, never built in (`S-88`).
- **Clean links on every page opened**, not only on a copied link (`S-89`).
- **Web apps keep their own keys**: the first press goes to the page, a second to
  Stedding (`S-90`).
- **Dark mode for web pages**, on Chromium's own (`S-100`): one switch, a moon at the
  address row's right end, ⌥⇧⌘D, a command bar row, a page-menu row and, on the Mac, a
  View menu row, with sites kept light or the only ones darkened, and an app's title bar
  darkened with its page (`features/dark-pages.md`; released in beta 18, on Windows so far).
- **Smaller things seen in Nook**: the site's controls in one panel (`S-118`) and the rest
  of the small conveniences (`S-125`). Built in beta 14: clear a site's cookies and
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
2. **Sync (§10)** — no Stedding account; a Space travels as a file.
3. **Hosted sharing (§2, §6)** — Share Space, Share Quote, the Boost gallery.

So "full parity" means *parity with the local, offline capabilities of Arc*, the large
majority of it, with the gaps listed. With Boosts and Easels deferred (ADR 0012), the
honest target until that is revisited is **parity minus Boosts and Easels**.

## Where we deliberately differ

- **No account, ever.** Arc requires one.
- **Auto Archive is off until you pick a time** (since beta 14), and little windows are
  never closed for idling.
- **An address row with the whole address**, where Arc has none.
- **Bookmarks stay**, beside pinned tabs.
- **Chromium's horizontal tabs stay one switch away.**
- **No telemetry**, per `PRIVACY.md`.
- **No bundled model, no Space intern, no command-bar chat** (ADR 0020). Dia exists for
  people who want an AI browser.
- **Open source under BSD**, so the browser cannot be discontinued out from under its
  users, which is what happened to Arc's.
