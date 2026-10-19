# Keyboard shortcuts

Every shortcut Stedding adds or changes, on both platforms. The same list is inside
the browser at **Settings → Stedding → Shortcuts**, generated from the keyboard tables
the browser itself uses, so its keys are those of the version you run.

Four keys are new since beta 14: muting a tab (⌃M / Ctrl+M), all folders at once
(⇧⌘E / Ctrl+Shift+E), clearing a site's cookies (⌥⇧⌘R / Ctrl+Alt+Shift+R) and picture in
picture (⌥⇧⌘P / Ctrl+Alt+Shift+P). An earlier build does nothing with them. On the Mac,
splitting the current tab with a new one is ⌃⌘N from the first release after beta 17;
beta 17 and earlier have only ⌥⌘N for it, which still splits after that, except while Arc
runs.

Keys: ⌘ Command, ⌥ Option, ⇧ Shift, ⌃ Control, ⇥ Tab.

## Sidebar and Spaces

| Action | macOS | Windows |
|---|---|---|
| Close the sidebar, to icons or hidden completely (Settings → Stedding → Sidebar), or bring it back | ⌘S | Ctrl+S |
| Show or hide the address row on its own | ⇧⌘D | Ctrl+Shift+D |
| Jump to Space 1 to 9 | ⌃1 – ⌃9 | Alt+1 – Alt+9 |
| Next Space / previous Space | ⌥⌘→ / ⌥⌘← | Ctrl+Alt+→ / Ctrl+Alt+← |
| Move the tab to the next / previous Space | ⌥⇧⌘→ / ⌥⇧⌘← | Ctrl+Alt+Shift+→ / ← |
| Pin the tab in its Space, or unpin it | ⌘D | Ctrl+D |
| Clear: close the Space's unpinned tabs | ⇧⌘K | Ctrl+Shift+K |
| New Blank Window: a window with Spaces of its own | ⌥⇧⌘N | Ctrl+Alt+Shift+N |
| In a little window (macOS): move the page into your window as a tab | ⌘O | — |
| In a little window (macOS): send the page into a split of your window | ⇧⌘O | — |
| In a little window (macOS): close it (the bare key may not reach the window yet, `docs/history/plan-2026-09-26.md` CMD-15) | Esc | — |

## Tabs and the bar

| Action | macOS | Windows |
|---|---|---|
| Open the bar: search, a URL, or any open tab | ⌘T | Ctrl+T |
| Open the bar in actions mode (⇥ in an empty bar does the same; ⇥ after the start of a search engine's name makes a search chip for that site instead) | ⇧⌘P | Ctrl+Shift+P |
| Open the bar with the page's address in it, selected | ⌘L | Ctrl+L |
| Jump to one of the first eight rows you can see, or to the last one with 9 (hold ⌘ / Ctrl a moment to see the numbers) | ⌘1 – ⌘9 | Ctrl+1 – Ctrl+9 |
| Next tab / previous tab | ⇧⌘] / ⇧⌘[ | Ctrl+PgDn / Ctrl+PgUp |
| Next tab down the sidebar / previous tab up the sidebar | ⌥⌘↓ / ⌥⌘↑ | Ctrl+Alt+↓ / Ctrl+Alt+↑ |
| Most recent tab of the Space (hold ⌃ / Ctrl to see the five most recent) | ⌃⇥ | Ctrl+Tab |
| Most recent tabs, the other way round | ⌃⇧⇥ | Ctrl+Shift+Tab |
| Move the row down / up (a folder beside it is one row) | ⌥⇧⌘↓ / ⌥⇧⌘↑ | Ctrl+Alt+Shift+↓ / ↑ |
| Collapse the Space's folders, or expand them all when none is open | ⇧⌘E | Ctrl+Shift+E |
| Split the current tab with a new one | ⌥⌘N (⌃⌘N too from the first release after beta 17) | Alt+Shift+N |
| Mute the tab or unmute it (a split's two panes go together) | ⌃M | Ctrl+M |
| Reopen closed tabs, one at a time, each in its Space and folder (the toast's Undo brings back a whole close) | ⇧⌘T | Ctrl+Shift+T |
| Put a pinned tab to sleep (instead of closing it) | ⌘W | Ctrl+W |

## Page

| Action | macOS | Windows |
|---|---|---|
| Copy the link, without its tracking parameters | ⇧⌘C | Ctrl+Shift+C |
| Copy the link as Markdown | ⌥⇧⌘C | Ctrl+Alt+Shift+C |
| Clear the site's cookies and reload the page (only cookies; in a Space with its own session, only that Space's) | ⌥⇧⌘R | Ctrl+Alt+Shift+R |
| Screenshot the page as shown | ⇧⌘2 | Ctrl+Shift+2 |
| Screenshot a region you drag out | ⌥⇧⌘2 | Ctrl+Alt+Shift+2 |
| Screenshot the whole document | ⇧⌘1 | Ctrl+Shift+1 |
| Play the page's video in picture in picture, or bring it back (once the video has played with sound) | ⌥⇧⌘P | Ctrl+Alt+Shift+P |
| Turn dark pages on or off: every website drawn dark, in every window | ⌥⇧⌘D | Ctrl+Alt+Shift+D |

Screenshots go to Downloads as PNG and to the clipboard. Dark pages is also the moon
button at the right end of the address row, the **Dark Pages** row of the command bar
and, on the Mac, of the View menu (with its chord beside it), and a switch in Settings →
Stedding → Pages and menus. ⌥⇧⌘D takes no key of Chromium's
or Stedding's: ⇧⌘D stays the address row's, and ⌥⌘D the Dock's.

## Where Stedding differs from Chromium

Stedding takes a few chords Chromium uses for other commands. The old command keeps
its menu item; only the key moves.

| Chord | Stedding | Chromium had |
|---|---|---|
| ⌘T / Ctrl+T | Open the command bar | New Tab |
| ⌘L / Ctrl+L | Open the command bar with the page's address | Focus the address bar |
| ⌘W / Ctrl+W on a pinned tab | Put it to sleep | Close Tab |
| ⌘S / Ctrl+S | Collapse or expand the sidebar | Save Page As… (now ⇧⌘S / Ctrl+Shift+S) |
| ⌘D / Ctrl+D | Pin the tab in its Space | Bookmark This Tab… (keeps its menu row) |
| ⇧⌘D / Ctrl+Shift+D | Show or hide the address row | Bookmark All Tabs… (keeps its menu row) |
| ⇧⌘C | Copy the link | Inspect Elements, as a second chord (⌥⌘C stays) |
| Ctrl+Shift+C | Copy the link | Inspect (F12 and Ctrl+Shift+I stay) |
| Ctrl+Shift+P | Open the bar in actions mode | Print using the system dialog (now Ctrl+Alt+P) |
| ⌃⇥ / Ctrl+Tab | Most recent tab of the Space | Next tab, in strip order |
| ⌥⌘→ / ⌥⌘← | Next / previous Space | Next / previous tab |
| ⌥⌘↓ / ⌥⌘↑ | Next / previous tab in the sidebar | Focus the next / previous pane (now F6 / ⇧F6) |
| ⇧⌘K / Ctrl+Shift+K | Clear the Space | unbound |

The four keys added in beta 14 (⌃M, ⇧⌘E, ⌥⇧⌘P and ⌥⇧⌘R; Ctrl+M, Ctrl+Shift+E,
Ctrl+Alt+Shift+P and Ctrl+Alt+Shift+R) were free in Chromium on both platforms, so they move
none of its keys.

Independent session is not a shortcut: it is a check item on the Space chip
menu, a toggle on each Space in Settings → Stedding → Spaces, and an **Independent
Session** row in the command bar (⇧⌘P). Off by default.

## Notes

- **macOS:** ⌃1–⌃9 are also Mission Control's "Switch to Desktop N" once a second
  desktop exists, and macOS takes them first. The Spaces menu in the menu bar keeps
  the commands reachable.
- **macOS:** muting a tab is ⌃M, not ⌘M: ⌘M still minimizes the window.
- **macOS:** a clipboard manager that owns ⇧⌘C system-wide (Maccy does by default)
  takes it before the browser does; the File menu row always works.
- **macOS:** while Arc is running it takes ⌥⌘N from every app for its Little Arc window,
  so ⌥⌘N, Chromium's chord for the split, opens Arc instead of a split here. Quit Arc, or
  use **New Split View with Current Tab** on a tab's right-click menu. From the first
  release after beta 17, ⌃⌘N, the menu's chord, splits whether Arc runs or not.
- **Windows:** a tap of Alt on its own still focuses the app menu, as in Chromium; the
  digit goes with the key held.
- **Windows:** Ctrl+Alt with an arrow is also the display-rotation hotkey some Intel
  graphics drivers install; turn that off in the driver if the two collide.
- **Windows:** Ctrl+Esc opens the Start menu, and Windows takes it before any app sees
  it, so Escape does not cancel a Ctrl+Tab walk on Windows: the Start menu opens and the
  walk stops on the tab it had reached. To back out of a walk, keep Ctrl held and press
  Shift+Tab until the tab you started from is highlighted again, then let go: you are back
  where you began, and the order of recent tabs is as it was. Or let go and press Ctrl+Tab
  once: that takes you back too, but the tab you had reached moves up the recent tabs, right
  behind the one you are on. After Ctrl+Esc, close the Start menu with Escape first.
- **Windows:** on a keyboard with AltGr, Windows treats Ctrl+Alt as AltGr. Where AltGr
  types a character with one of the Ctrl+Alt chords (Polish (Programmers) gives Ctrl+Alt+Shift+C
  as Ć and Ctrl+Alt+Shift+N as Ń), press the chord with Ctrl and the **left** Alt: that runs
  the command, and AltGr (the right Alt) still types the character. With a digit, the right
  Alt on such a keyboard is AltGr too, so it types; Space 1–9 are the left Alt's.
- Remapping shortcuts yourself is not available yet; it is planned for 1.0 (`BACKLOG.md`
  S-91).
- Chromium's tab-group chords are removed, with the tab-group rows of the menus.
