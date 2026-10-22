# Frequently asked questions

## About the project

**What is Stedding?**
An open-source desktop browser with Arc's way of working: a sidebar with vertical tabs,
Spaces, pinned tabs and folders, and a command bar. It is Chromium plus a documented series of
patches. See the [README](../README.md).

**What does it have that Arc did not, and the other way round?**
It is open source and needs no account. A Space can keep its own sign-ins inside one profile,
so one site can be signed in as work in one Space and as you in another. One switch turns
every website dark, any page can become an app with a window of its own, and one step signs
you out of the site in front of you and nothing else. Arc still has Peek, Boosts, Easels, the
sidebar's mini player, the Library panel and Live Folders, sync and AI. The README has both
lists: [What Arc never had](../README.md#what-arc-never-had) and
[what Arc has that Stedding does not, yet](../README.md#what-arc-has-that-stedding-does-not-yet).

**Is it a fork of Arc?**
No. Arc is closed source, so nothing of it can be reused. Everything here was written for this
project on Chromium's open-source code.

**Why does it exist when Arc still runs?**
Arc gets only security and Chromium updates since 2025, and its maker was acquired. Stedding's
core is BSD-licensed and forkable, so no pivot or acquisition can take it away
([the comparison](VISION.md#competitors)).

**Does it have AI?**
No bundled model and no chat in the command bar ([ADR 0020](decisions/0020-no-bundled-model.md)).
An extension can add one if you want it.

**What does "Stedding" mean?**
A haven. It is shaped on "steading", a farmstead, from "stead", an old word for a place
([how it was chosen](VISION.md#the-name)).

**Who makes it?**
One maintainer, in the open. Open work is in [BACKLOG.md](../BACKLOG.md); what each round built
is in [PROJECT-LOG.md](PROJECT-LOG.md).

## Installing and updating

**Is the build signed, and is it safe?**
The macOS image is signed with the project's Developer ID and notarized by Apple (from beta 10).
The Windows installer is not signed yet, so SmartScreen asks once ([INSTALL.md](INSTALL.md)).
Every release is built from this repository's patch series, with its SHA-256 checksum published
beside the file.

**Will it update itself?**
Yes, on the Mac from 0.2.0 beta 16 and on Windows from 0.2.0 beta 19. It looks for a new version
when you open it, unless it looked in the past hour, and every six hours while it runs (versions
before 0.3.0 beta 2 look once a day); it downloads a new version in the background and shows
**New Stedding Version Available** at the bottom of the sidebar; a click restarts into it. Every
update is signed and checked before it installs, and the check sends nothing that identifies you
([PRIVACY.md](PRIVACY.md)). Settings › Stedding › Updates turns it off. A Windows copy older
than 0.2.0 beta 19 needs one newer release installed by hand once.

**Intel Mac? Linux?**
Not yet. Today: macOS on Apple silicon and Windows x64. Linux comes after the Windows port
([ROADMAP.md](ROADMAP.md)).

**Can it be my default browser?**
Yes: in the welcome flow, or Settings → Default browser.

## Using it

**How do I move from Arc?**
On a Mac, the welcome flow's **Move everything from Arc** brings over Spaces, essentials, pinned
tabs, folders, tabs, history and passwords from Arc's files on your disk (one keychain prompt
for the passwords). Run it again from Settings → Stedding → Spaces; nothing is duplicated. On
Windows, Arc's files are not read yet (`S-81`).

**Can the sidebar get out of the way completely?**
Yes. Settings → Stedding → Sidebar → **When the sidebar closes: Hide it completely**; then ⌘S
(Ctrl+S) gives the page the whole window, and the pointer at the left edge slides the sidebar
back. The same section sets row height, text size, width, and **Page flush against the window**.

**What does closing a pinned tab do?**
The same as in Arc: ⌘W (Ctrl+W), the tab's ✕, a middle click or **Close** on its menu unloads
it and puts it back to the page you pinned, in its place, so it costs nothing until you open it
again. A page that asks "Leave site?" asks first. To remove a pinned tab, choose **Unpin from
This Space** or **Remove from Essentials** on its menu; or turn the rule off in Settings →
Stedding → Tabs, and ⌘W, the ✕ and a middle click then close a pinned tab.

**Can a folder hold pinned tabs?**
Yes. Drag a folder over the line into the pinned tabs, or choose **Pin Folder** on its menu: every
tab in it becomes a pinned tab and the folder stays a folder. **Unpin Folder**, or a drag back
under the line, undoes it. Essentials take no folders.

**Can essentials belong to one Space?**
In a Space with an **Independent session**, yes: a tab you add to the essentials there is that
Space's own, stays signed in with the Space's session, and shows in that Space alone, which
shows only its own essentials. Elsewhere, essentials are shared by every Space, as in Arc. For a
tab that belongs to one Space, you can also pin it there (⌘D, Ctrl+D): pinned tabs are each
Space's own. Turning the Space's session off makes its essentials its pinned tabs.

**Where did the bookmark bar go?**
Pinned tabs play its part. Imported bookmarks stay bookmarks, and ⇧⌘B (Ctrl+Shift+B) still shows
the bar. The command bar's **Turn Bookmarks into Pinned Tabs** makes them pins and folders, and
then hides the bar and the star, since the sidebar holds them; above 50 bookmarks it asks first.
Settings → Stedding → Tabs → **Show the bookmark bar and the star** brings both back.

**Where is Peek?**
Switched off: its page came out blank, so it waits to be rebuilt with little windows (`S-93`).

**What happens to tabs I do not close?**
Nothing, until you choose a time in Settings → Stedding → Tabs → **Archive tabs nobody has
looked at for** (6 hours to 7 days). Then idle loose tabs move to the Archived view at the
bottom of the sidebar, by day and Space, one click from coming back. Pinned tabs never archive.

**Why do most tabs look dimmed after a restart?**
They are asleep. A launch loads only the tab you were on (both sides of a split), so a long
sidebar costs nothing until you open a tab, which loads it with its history. Settings →
Stedding → Tabs → **On startup, load** can load the essentials too, or every tab of the Space
on screen.

**Can tabs I am not using free their memory?**
Yes. Settings → Stedding → Tabs → **Put tabs to sleep after** (5 minutes to 4 hours; Never by
default) puts a tab you have not looked at for that long to sleep: its row stays, and it
reloads when you open it. Essentials, and tabs playing sound, in a call or holding typed text,
stay awake. The command bar's **Sleep Other Tabs** does it at once for every Space and window.
When memory runs short, the tab seen longest ago sleeps first.

**I closed a tab by mistake.**
⇧⌘T (Ctrl+Shift+T) reopens closed tabs one at a time, each in its Space and folder. For a toast
with **Undo** after every close, which puts a whole close back at once, turn on Settings → Stedding →
Tabs → **Offer Undo after closing tabs** (off by default).

**How do I leave full screen?**
⌃⌘F, the green button, or hold Esc (on Windows F11, or hold Esc). Stedding does not show
Chromium's note about it unless Settings → Stedding → Pages and menus → **Show how to leave full
screen** is on. A page that fills the screen by itself, such as a video, always shows its note,
so a page cannot pass itself off as the browser.

**Can a tab sit indented under the page it came from?**
Yes, if you want it. A link you open in a new tab (a middle click, ⌘-click or Ctrl+click)
opens just below its page, at the same depth. Settings → Stedding → Tabs → **Show tabs under the
tab that opened them** draws it a level to the right, under that page, and a link opened from
it a level further; close the page and its tabs move up a level. Essentials and pinned tabs keep
their links at the left. It is off unless you turn it on.

**Which tab do I see after I close one?**
The tab you used before it in the same Space, the one a quick ⌃⇥ (Ctrl+Tab) would show, as long
as its row is in view in the sidebar, so the list does not jump. If that row is scrolled out of
view, or you have not used another tab there since the browser started, the tab below it, else
the one above.
Putting a tab to sleep, and ⌘W on a pinned tab, land on the same tab. When a Space's last tab
closes, it shows the essential you used there last, or opens a new tab if you have none.

**Can I be signed into the same site twice?**
Yes. Right-click a Space chip and turn on **Independent session**: that Space keeps its own
cookies and site data, so another Space can use a different account. The essentials you add in
that Space are its own and use its session; extensions, history and passwords stay shared. **Clear Independent Session** on the same menu signs that
Space out of everything.

**Is there sync?**
No: there is no account anywhere in the product. Export a Space as a file (Settings → Stedding →
Spaces → Export Space…) and import it on the other machine.

**Do my extensions work?**
Yes. It is Chromium; extensions install from the Chrome Web Store. ⌘E (Ctrl+Alt+E on Windows)
runs one from the keyboard: keep the keys down and press E again to choose, let go to run it.
The command bar's actions mode lists them too, which matters when the address row is hidden.

**Can I switch Spaces with the mouse?**
Yes. Over the sidebar or its icons, scroll sideways: a two-finger swipe on a touchpad, a mouse's
tilting wheel, or Shift with the wheel. On Windows, Ctrl with the wheel over the sidebar does it
too. Scrolling up and down still scrolls your tabs ([SHORTCUTS.md](SHORTCUTS.md)).

**Why does ⌃1 switch desktops instead of Spaces?**
With a second desktop, macOS Mission Control takes ⌃1–⌃9 before the browser sees them. The
Spaces menu keeps every command reachable ([SHORTCUTS.md](SHORTCUTS.md)).

**How do I put two pages side by side?**
Drag a tab, from the sidebar or the tab strip, onto the page you are looking at. The left or
right half lights in the Space's colour; let go, and the two pages share the window, the one you
dragged on that half. ⌃⌘N (Alt+Shift+N) splits the current tab with a new one, and a tab's
right-click menu has **New Split View with Current Tab**.

**A link from another app opened in a small window. How do I keep it?**
On the Mac a link from another app opens in a little window, to read and close. Its **Open in
Stedding** button, ⌘O, or the page's right-click menu moves the page into a tab of your window,
without reloading it; ⇧⌘O puts it in a split instead. Settings → Stedding → Pages and menus
turns little windows off. On Windows such links open as tabs.

**Why does ⌥⌘N open Arc?**
While Arc runs it takes ⌥⌘N from every app for Little Arc. Split with ⌃⌘N, which Arc leaves
alone (from 0.2.0 beta 20), or use the tab menu's **New Split View with Current Tab**.

**How do I get Chromium's full tab menu back?**
Settings → Stedding → Pages and menus → turn off **Short context menus**.

## Privacy

**Does it send anything to Google, or to you?**
No telemetry, crash reports, experiments or identifiers, and no Google sign-in. Chromium itself
still contacts Google for component updates, Safe Browsing lists and network time. The Safe
Browsing requests carry no API key and are refused, so Safe Browsing does not protect you in
these builds (`S-75`). The Web Store is contacted only when you install or update an extension.
Every connection is listed in [PRIVACY.md](PRIVACY.md); anything else is a bug.

**What is on by default?**
Third-party cookies blocked, HTTPS-First, Global Privacy Control, quiet permission prompts,
Chromium's ad-measurement APIs off, search suggestions off, and DuckDuckGo until you choose an
engine. Most are switches in Settings → Stedding → Privacy.

**Where is my data?**
On your machine only: `~/Library/Application Support/Stedding` on macOS,
`%LOCALAPPDATA%\Stedding` on Windows.

**Does the hover card keep pictures of my tabs?**
Only in memory. Hovering a tab that is not on screen shows a picture of its page as you last
saw it; the picture is never written to disk or sent, and it goes when the tab closes or the
browser quits. Settings → Appearance → **Show tab preview images** turns the pictures off.

## Contributing

**How can I help?**
Use a beta for a day and open an issue for each thing that is worse than what you use now. See
[CONTRIBUTING.md](../CONTRIBUTING.md).

**I found a security problem.**
Use private vulnerability reporting on the repository's Security tab
([SECURITY.md](../SECURITY.md)), not a public issue.

**Where does a new contributor start?**
[AGENTS.md](../AGENTS.md), then [HANDOFF.md](HANDOFF.md).
