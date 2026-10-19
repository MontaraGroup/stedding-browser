# Frequently asked questions

## About the project

**What is Stedding?**
An open-source desktop browser with Arc's way of working: a sidebar with vertical
tabs, Spaces, pinned tabs and folders, and a command bar. It is Chromium plus a series
of patches, built for people who want that interface without trusting a company's
roadmap or servers. See the [README](../README.md).

**Does it have AI?**
No. There is no bundled model, no chat in the command bar, and no intern that reads
a Space's cookies. Extensions can add a chatbot if you want one. The decision is
[ADR 0020](decisions/0020-no-bundled-model.md).

**Is it a fork of Arc?**
No. Arc is closed source, so nothing of it can be reused. Stedding is built on
Chromium's open-source code; the sidebar, Spaces, the command bar and everything else
were written for this project as a documented patch series (`patches/`).

**Why does it exist when Arc still runs?**
Arc's maker announced in 2025 that Arc would receive only security and Chromium
updates while the company moved on to another product, and the company was later
acquired. Arc users are on a maintenance-mode product owned by someone else. Stedding's
core is BSD-licensed and forkable, so no pivot or acquisition can take it away.
Details and the other browsers in this space: [COMPETITORS.md](COMPETITORS.md).

**What does "Stedding" mean?**
A haven. The name is shaped on the English word "steading", a farmstead or homestead,
which comes from "stead", an old word for a place. It stands for using the web outside
anyone's surveillance or control. How the name was chosen: [NAMING.md](NAMING.md).

**Who makes it?**
One maintainer, in the open, on this repository. Most of the work follows feedback
from real use: open work is in [BACKLOG.md](../BACKLOG.md), and what each round built is
in [PROJECT-LOG.md](PROJECT-LOG.md).

## Installing and updating

**Is the build signed, and is it safe?**
From beta 10 the macOS image is signed with the project's Developer ID and notarized by
Apple, so macOS opens it like any other app. The Windows installer is not signed yet:
SmartScreen asks once ([INSTALL.md](INSTALL.md)). Every release is built from this
repository's patch series, and its SHA-256 checksum is published beside the file so you
can check what you downloaded.

**Will it update itself?**
On the Mac from beta 16 on, and on Windows from beta 19 on: it checks once a day, downloads a new version in the
background and shows "New Stedding Version Available" at the bottom of the sidebar; a click
restarts into it. Every update is signed with the project's key and checked before it
installs, and the check sends nothing that identifies you
([PRIVACY.md](PRIVACY.md)). Settings › Stedding › Updates turns it off. A Windows copy
older than beta 19 has no updater: install beta 19 from the Releases page once.

**What is planned after that?**
The rest of the Windows port (little windows, signing), then Linux. Alongside
them, things Arc never had: ad and tracker blocking built in, tracking parameters
stripped from every link you open, web apps keeping their own shortcuts, shortcuts you
can change, child tabs, the sidebar on the right, a mini player, Peek rebuilt, and import
from Dia. Arc's own features still to come include folders inside the pinned list. The
order is the Features section of [BACKLOG.md](../BACKLOG.md); the milestone for what is
past Arc is M10 in [ROADMAP.md](ROADMAP.md).

**Does it run on Intel Macs? On Linux?**
Not yet. Today: macOS on Apple silicon and Windows x64 (a preview). Linux is the next
platform after the Windows port is complete ([ROADMAP.md](ROADMAP.md)).

**Can it be my default browser?**
Yes. The welcome flow offers it, and Settings → Default browser does it at any time.

## Using it

**How do I move from Arc?**
On a Mac, start Stedding: the welcome flow's **Move everything from Arc** brings over
Spaces, the essentials row, pinned tabs, folders, tabs, history and passwords, from Arc's
files on your disk. Passwords need one macOS keychain prompt. You can run it again
later from Settings → Stedding → Spaces → Import from Arc; nothing is duplicated. On
Windows, Stedding does not read Arc's files yet (`S-81`).

**Can the sidebar get out of the way completely?**
Yes. Settings → Stedding → Sidebar → **When the sidebar closes: Hide it completely**.
Then ⌘S (Ctrl+S on Windows) hides it and the page fills the window, with no border.
Move the pointer to the window's left edge and the sidebar slides back over the
page; ⌘S brings it back for good. The command bar's actions (⇧⌘P) have "Hide
Sidebar", "Collapse Sidebar to Icons" and "Show Sidebar". The same Sidebar section
sets the tab rows' height, the text size and the sidebar's width (a double click on the
sidebar's edge returns it to the default), and **Page flush against the window** takes
away the margin and rounded corners around the page while the sidebar shows.

**Where did the bookmark bar go?**
Pinned tabs play its part. Bookmarks you import stay bookmarks, in the bookmark
manager, and Chromium's bookmark bar still opens with ⇧⌘B (Ctrl+Shift+B). The command
bar's "Turn Bookmarks into Pinned Tabs" makes them pinned tabs and folders in the Space
you are in whenever you want; after that the bookmark bar no longer shows.

**Where is Peek?**
Switched off. It opened a link from a pinned tab over the window, but its page came out
blank, so it is off until it is rebuilt together with little windows (`S-93`).

**What happens to tabs I do not close?**
Nothing, until you choose a time: Settings → Stedding → Tabs → **Archive tabs nobody has
looked at for** (6 hours to 7 days), the welcome flow's **Choose how Stedding behaves**
step, or the command bar's "Archive idle tabs after". Then unpinned tabs outside folders
that nobody has looked at for that long move to the Archived view at the bottom of the
sidebar, grouped by day and Space; restore any of them with a click. This is so since
beta 14; earlier betas archived after 12 hours, and on update a profile that never changed
the setting stops archiving while one that chose a time keeps it. Pinned tabs never
archive; ⌘W puts a pinned tab to sleep instead of closing it.

**I closed a tab by mistake. How do I get it back?**
The toast that appears after a close has **Undo**: it puts the tabs back in their Space
and folder. ⇧⌘T (Ctrl+Shift+T) reopens closed tabs one at a time, also after the toast
has gone. Settings → Stedding → Tabs → **Offer Undo after closing tabs** turns the toast
off. Since beta 14.

**Is there sync?**
No service, by design: there is no account anywhere in the product. Instead a Space
can be exported as a file (Settings → Stedding → Spaces → Export Space…) and imported on
another machine with **Import sidebar…** next to it.

**Do my extensions work?**
Yes. It is Chromium; extensions install from the Chrome Web Store as in Chrome.

**Why does ⌃1 switch desktops instead of Spaces?**
macOS Mission Control takes ⌃1–⌃9 for "Switch to Desktop N" once you have a second
desktop, before the browser sees them. The Spaces menu in the menu bar keeps every
command reachable. Full list of collisions: [SHORTCUTS.md](SHORTCUTS.md).

**Why does ⌥⌘N open Arc?**
While Arc is running it takes ⌥⌘N from every app to open its Little Arc window, so the key
never reaches Stedding. Use ⌃⌘N, the split's own chord from the first release after
beta 17, which Arc leaves alone; ⌥⌘N splits again once Arc is quit. In beta 17 and
earlier, quit Arc or split from a tab's right-click menu (**New Split View with Current
Tab**).

**How do I get the old Chromium tab menu back?**
Settings → Stedding → Pages and menus: turn off **Short context menus**. Stedding's short
menus are the default.

**Can I be signed into the same site twice?**
Yes. Right-click a Space chip (or open Settings → Stedding → Spaces) and turn on
**Independent session**. That Space keeps its own cookies, cache and site data;
a second isolated Space can use a different account on the same site. Essentials
(the top pinned row, visible in every Space) stay on the shared jar, as do
extensions, history and saved passwords. Off by default: Spaces share one login
until you opt in. Turning it off moves the Space's tabs, open ones too, back to the
shared jar (each loads there when you come to it); the stored session stays on disk
until you isolate that Space again. To sign that
Space out of everything at once, right-click its chip and choose **Clear
Independent Session**; deleting the Space clears it too.

## Privacy

**Does it send anything to Google, or to you?**
No telemetry, no crash reports, no experiment downloads, no identifiers. Google's
sign-in and services are removed from the interface. Google is still contacted for what
Chromium itself does: component updates, Safe Browsing list requests and network time.
Two more calls at start, Google's push service and its account check, stopped with beta 15
(`S-54`, `S-67`); beta 14 and earlier still make them. The Safe Browsing requests carry no API
key and are refused, so Safe Browsing does not protect you in these builds (`S-75`). The Chrome Web Store is contacted only when you
install or update an extension. [PRIVACY.md](PRIVACY.md) lists the connections and
records what a fresh profile actually contacted; anything else is a bug.

**What is on by default?**
Third-party cookies blocked, HTTPS-first, Global Privacy Control, quiet permission
prompts, Chromium's ad-measurement APIs off, search suggestions off, and DuckDuckGo
until you choose a search engine. Most are a switch in Settings → Stedding → Privacy;
the search engine is in Settings → Search engine.

**Where is my data?**
On your machine only: `~/Library/Application Support/Stedding` on macOS,
`%LOCALAPPDATA%\Stedding` on Windows.

## Contributing

**How can I help?**
Use a beta for a day and open an issue for each thing that is worse than what you use
now; that feedback is what most of the work follows. Documentation fixes and Chromium
fork experience are welcome too. See [CONTRIBUTING.md](../CONTRIBUTING.md).

**I found a security problem.**
Use GitHub's private vulnerability reporting on the repository's Security tab
([SECURITY.md](../SECURITY.md)). Please do not open a public issue for it.

**I am a new contributor. Where do I start?**
[AGENTS.md](../AGENTS.md), then [HANDOFF.md](HANDOFF.md).
