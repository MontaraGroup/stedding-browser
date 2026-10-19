# Frequently asked questions

## About the project

**What is Stedding?**
An open-source desktop browser with Arc's way of working: a sidebar with vertical tabs,
Spaces, pinned tabs and folders, and a command bar. It is Chromium plus a documented series of
patches. See the [README](../README.md).

**What does it have that Arc did not, and the other way round?**
Dark pages for every website, apps made from any page, Undo after every close, the whole
address in the page's colour, and one-step site cleanup; and no account at all. Arc still has
Peek, Boosts, Easels, the sidebar's mini player, sync and AI. Both lists are at the top of the
[README](../README.md#five-things-arc-never-had).

**Is it a fork of Arc?**
No. Arc is closed source, so nothing of it can be reused. Everything here was written for this
project on Chromium's open-source code.

**Why does it exist when Arc still runs?**
Arc gets only security and Chromium updates since 2025, and its maker was acquired. Stedding's
core is BSD-licensed and forkable, so no pivot or acquisition can take it away
([COMPETITORS.md](COMPETITORS.md)).

**Does it have AI?**
No bundled model and no chat in the command bar ([ADR 0020](decisions/0020-no-bundled-model.md)).
An extension can add one if you want it.

**What does "Stedding" mean?**
A haven. It is shaped on "steading", a farmstead, from "stead", an old word for a place
([NAMING.md](NAMING.md)).

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
Yes, on the Mac from beta 16 and on Windows from beta 19. Once a day it looks for a new version,
downloads it in the background and shows **New Stedding Version Available** at the bottom of the
sidebar; a click restarts into it. Every update is signed and checked before it installs, and
the check sends nothing that identifies you ([PRIVACY.md](PRIVACY.md)). Settings › Stedding ›
Updates turns it off. A Windows copy older than beta 19 needs beta 19 installed by hand once.

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

**Where did the bookmark bar go?**
Pinned tabs play its part. Imported bookmarks stay bookmarks, and ⇧⌘B (Ctrl+Shift+B) still shows
the bar. The command bar's **Turn Bookmarks into Pinned Tabs** makes them pins and folders.

**Where is Peek?**
Switched off: its page came out blank, so it waits to be rebuilt with little windows (`S-93`).

**What happens to tabs I do not close?**
Nothing, until you choose a time in Settings → Stedding → Tabs → **Archive tabs nobody has
looked at for** (6 hours to 7 days). Then idle loose tabs move to the Archived view at the
bottom of the sidebar, by day and Space, one click from coming back. Pinned tabs never archive;
⌘W puts a pin to sleep instead.

**I closed a tab by mistake.**
The toast after a close has **Undo**, which puts the tabs back in their Space and folder. ⇧⌘T
(Ctrl+Shift+T) reopens closed tabs one at a time after the toast has gone.

**Can I be signed into the same site twice?**
Yes. Right-click a Space chip and turn on **Independent session**: that Space keeps its own
cookies and site data, so another Space can use a different account. Essentials, extensions,
history and passwords stay shared. **Clear Independent Session** on the same menu signs that
Space out of everything.

**Is there sync?**
No: there is no account anywhere in the product. Export a Space as a file (Settings → Stedding →
Spaces → Export Space…) and import it on the other machine.

**Do my extensions work?**
Yes. It is Chromium; extensions install from the Chrome Web Store.

**Why does ⌃1 switch desktops instead of Spaces?**
With a second desktop, macOS Mission Control takes ⌃1–⌃9 before the browser sees them. The
Spaces menu keeps every command reachable ([SHORTCUTS.md](SHORTCUTS.md)).

**Why does ⌥⌘N open Arc?**
While Arc runs it takes ⌥⌘N from every app for Little Arc. From beta 20, split with ⌃⌘N, which
Arc leaves alone; before beta 20, quit Arc or use the tab menu's **New Split View with Current Tab**.

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

## Contributing

**How can I help?**
Use a beta for a day and open an issue for each thing that is worse than what you use now. See
[CONTRIBUTING.md](../CONTRIBUTING.md).

**I found a security problem.**
Use private vulnerability reporting on the repository's Security tab
([SECURITY.md](../SECURITY.md)), not a public issue.

**Where does a new contributor start?**
[AGENTS.md](../AGENTS.md), then [HANDOFF.md](HANDOFF.md).
