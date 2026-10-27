# 0029 — The sidebar syncs through a folder the user picks

Status: Proposed (awaiting the owner); built 2026-10-25 on each open question's recommended answer, released in 0.3.0 beta 16 (`docs/features/sidebar-file.md` Sf7–Sf41)
Date: 2026-10-25

## Context

A user with Stedding on several computers asked for sync with no server (GitHub issue 20,
BACKLOG `S-282`): the sidebar (Spaces, pins, folders, essentials) written to a folder they
choose, such as a NAS share or a folder kept by Syncthing, OneDrive or iCloud Drive, and read
and merged by each install on launch and on change. No account, no Stedding server. The owner
took it up on 2026-10-23 (`PLAN.md` decision 18). The same idea was written once as the
sidebar folder (`docs/features/sidebar-file.md` Sf3–Sf5) and withdrawn on 2026-09-26.

`docs/ROADMAP.md` keeps sync services off the path to 1.0 and asks for an ADR before one
enters it. This is not a service: Stedding makes no network request for it. The user's own
sync tool, or a shared drive, moves the files.

What exists:

- Settings › Stedding › Spaces has **Export Space…**, which writes the active Space to a file
  in Downloads, and **Import sidebar…**, which reads a file back. An import only adds: it
  never closes, moves, renames or deletes anything that is open.
- The first slice of `S-282`, being built now and not yet released (sidebar-file Sf2, Sf6):
  ids that survive a restart (a Space is its registry token, a pin or essential is
  `tab:<tab token>`, a folder is `folder:<FolderId>`); **Export all Spaces…**, which writes
  every Space with its pinned run, pinned folders, essentials, exact colours and whether it
  has its own session, atomically; and an import that merges by those ids across every window
  of the profile.

An import cannot be sync. Sync must carry renames, recolours, moves, reorders and deletions
both ways, and must lose nothing when a file is missing, late, copied by the sync tool, or
written by a computer whose clock is wrong.

## Decision

Sync through a folder is off by default and set per profile, in Settings › Stedding › Spaces.

**The folder.** The user picks a folder that already exists. Stedding creates only
`Stedding Sidebar` inside it (or uses the folder itself when it already is one), and each
install writes one file there, `stedding-sidebar-<16 hex>.json`, which no other install
writes. Writes are atomic, in the same directory. Nothing else is written. A folder inside
Stedding's own data, a folder it cannot write, and a folder macOS blocks are refused, each with
one sentence.

**The file.** Each file holds the whole merged sidebar, not only what its writer made, so a
third computer learns everything even after a writer's file is gone. Its body is the Export
all Spaces format, so Import sidebar… reads it on a computer that does not sync. A
`stedding_sync` block adds: the format number, the install id, the device name, a sequence
number and a nonce per write; each record (a Space, folder, pin or essential) with a time
stamp per field, an optional tombstone, and any keys from a newer version kept as they came;
each list's order (the Spaces, each pinned run, each folder, each essentials row) with its own
stamp; and the aliases made by pairing. The synced fields are a Space's name, icon, colours
and whether it has its own session; a pin's home (a web page only) and the user's own name
for it; a folder's title; and each item's parent. A pin made an essential is therefore a move,
not a delete and an add. A file is at most 4 MiB and 5,000 records.

**What each install keeps** in its profile, never in the folder: a ledger in the file's
format, plus local state (when each tombstone arrived, the size and time of each peer file,
held decisions, choices made for this computer only); a journal of the last 10 applied
batches within 30 days, for Undo; and the last 5 backups, each an Export all Spaces file,
taken before the first join and before any held batch is applied.

**The merge.** A hybrid logical clock: a local edit is stamped with the later of now and the
highest time seen plus one, and the install id breaks a tie, so every install reaches the same
result. Each field is its own register and the later stamp wins, so a rename on one computer
and a recolour on the other both survive. Each list is one register: the newer list wins, and
an item the other side added meanwhile stays beside its neighbour. The merge does not depend
on the order files are read in. At the first join, everything already here is stamped older
than any real edit, so on a tie the folder's existing content wins.

**Pairing at the first join** runs only after the user chooses Combine. Spaces pair by name
(trimmed, case-folded) only when each side has exactly one Space of that name. Inside a
paired Space, a pin pairs only with one candidate of the same home and the same name, and a
folder with one of the same title; essentials pair by home. The smaller of the two ids becomes
the shared one on every computer and is written as an alias. Aliases from every file are
combined, so two computers joining at once, and a third, settle. No local id is changed, so
child tabs keep their parents. Anything ambiguous stays as two items. A computer first seen
later that has an unpaired Space of the same name has that Space held until the user answers
Combine or Keep apart.

**What applies by itself:** additions, renames, icons, colours, homes, pin names, reorders and
moves. A new pin, folder or essential arrives unloaded, in its Space, folder and place, in the
window that already holds that Space's synced pins, otherwise the last-active ordinary window.
It never goes into a Blank Window, the little window or Peek, and never into two windows. Sync
never activates a tab, a Space or a window. A change to the tab the user is on waits until
they leave it; a change during a sidebar drag waits for the drop.

**Deletions.** A tombstone is written only when both of these hold:

1. The user removed the item in a live window: unpinned a pin, really closed one (a close that
   only puts a pin to sleep removes nothing), removed an essential, unpinned, ungrouped or
   closed a pinned folder, or deleted a Space. A window closing, the browser quitting or a
   session restoring is never such an action.
2. Two seconds later the item is in no window of the profile, the little window and Peek
   included. A pin moved to another window, made an essential or dragged into Peek is a move.

Absence alone never deletes. Closing a window, quitting, a launch that restores nothing, and a
peer file that is missing, shorter than before, unreadable, not yet downloaded or a conflict
copy delete nothing. A removal path that misses its hook keeps the item, and the user removes
it again: that is the accepted failure. An edit made after a deletion keeps the item.
Tombstones are dropped 180 days after they arrived here, never while a decision about them
waits.

When another computer removes something: a pin or essential that sync put here and that was
never opened here goes to Recently Closed; any other becomes an ordinary tab in its Space and
keeps its page. A removed folder releases its tabs.

**What waits for the user.** Each is a row in Settings and one toast with Review, and none has
a deadline:

- a Space deleted elsewhere, held together with its pins' moves. Delete here asks the usual
  delete question; Keep brings the Space back on every computer. The last Space here is never
  deleted.
- a change elsewhere to an existing Space's own session, with the number of pages it would
  reload and sign out here (Turn on here, or Not on this computer). A new Space with its own
  session arrives with an empty jar; a jar, a partition or a sign-in never travels.
- a batch from one computer with 5 or more removals, a third or more of the synced pins, more
  than 50 additions after the join, or any Space deletion. It is held whole (Apply or Keep).
- a move that would reload a loaded tab into another session. It applies by itself once the
  tab is unloaded, or at once on Move now.
- synced pins that are in no window here. They are never put back on their own; the row
  offers Bring them here.
- a sync tool's conflict copy (Show in folder, Dismiss).

**Files are not trusted.** Peer files are read and parsed off the UI thread, within the caps,
and a file with a cycle, a duplicate id or a bad value is refused whole. Only web homes are
kept. Only a name that is exactly `stedding-sidebar-<16 hex>.json` is read; any other
`stedding-sidebar-` name is a conflict copy, never applied and never deleted. A file in a
newer format is not applied, and Settings says to update Stedding. A computer whose clock runs
more than 24 hours ahead is held whole and named, and its times never move this computer's
clock. An older copy of this computer's own file, brought back by a sync tool, is ignored and
overwritten. A profile copied to another computer is noticed: the copy takes a new install id
and leaves the old file alone.

**Timing.** A change is written 2 seconds after the last edit to the synced sidebar, and at
quit. A title, a load or a navigation inside a pin writes nothing. Another computer's change
applies about 2 seconds after its file changes: on the Mac through FSEvents (a recursive watch,
which sees a file rewritten in place), on Windows through ReadDirectoryChangesW. A network
share may send no events, so the folder is also checked when a Stedding window becomes active
(at most every 5 seconds), every 10 seconds while one is in front, and on Sync now; never in
the background. A read that is still running is never queued behind.

**Platforms.** The first folder access of a launch waits for a Stedding window and for session
restore, and the first access ever comes right after the pick, so a Mac privacy prompt shows
only in context. The Mac's folder usage strings go beside the existing ones in
`infoplist_strings_util.cc`. An iCloud Drive or OneDrive file not yet downloaded is fetched in
the background and shown as waiting, never as broken. On Windows, a file another program holds
open is retried after 10 and 60 seconds, then at the next change, with one sentence; never in
a loop. A write to the folder never holds up quitting; one that quitting cut short is made at
the next launch.

**What the user sees.** Set up… opens the system folder picker, then a sheet before anything
is written. The sheet has this computer's name (by default "Mac" or "Windows PC" plus 4 hex
characters, editable) and says what will happen: for an empty folder, where the file goes; for
a folder with sidebars, the other computers, their counts and the pairs, each with a tick box,
then Combine, Keep both or Cancel. Cancel leaves sync off and the folder untouched. Once on,
Settings shows the folder, one status sentence ("Syncing with Office PC. Last change from
Office PC, 12 seconds ago: 2 pins added, Work renamed." with Undo), at most one problem
sentence, the waiting rows, the last 10 changes with Undo each, the 5 backups with Import, and
Sync now and Stop syncing. Stop syncing changes nothing in the sidebar and leaves the files;
this computer's file is removed only when that box is ticked. The row is hidden for Guest, in
a private window and on a Blank Window's settings. Every control is reachable by keyboard and
has an accessible name.

**What never travels:** open tabs below the Clear line and unpinned folders; any tab's current
address or title; child-tab nesting, splits, collapsed states, the active Space or tab, and
which window holds what; history, Recently Closed, cookies, site data, passwords, autofill and
payment data; extensions, bookmarks and downloads; routes, settings and permissions; a Space's
partition or jar; the computer's host name; and anything from a Blank Window, a private
window, Guest, the little window or Peek, which also never receive anything. Stedding makes no
network request for sync.

## Options considered

Three designs were written from the same brief. Three reviewers scored each out of 10:

| Design | Safety | Simplicity | User value | Buildable |
|---|---|---|---|---|
| Safety first | 9, 9, 9 | 3, 3, 3 | 6, 6, 6 | 5, 5, 5 |
| Simplicity first | 6, 4, 6 | 9, 9, 8 | 6, 5, 6 | 8, 8, 8 |
| User first | 8, 7, 8 | 5, 5, 5 | 9, 9, 9 | 6, 6, 6 |

- **Safety first.** Sync may add and edit, but never removes, signs out, reloads or merges
  anything without a yes. Tombstones come only from explicit actions. The safest, but every
  unpin on one computer becomes a question on the other, sidebars differ until someone
  answers, and it is the largest to build.
- **Simplicity first.** Polling only, the newer whole record wins, and an item missing from a
  live window is a deletion. No toasts and no preview. The smallest and easiest to build, but a
  pin moved into Peek or the little window would be deleted, nothing guarded against a mass
  deletion, a Space deleted elsewhere was deleted here at once unless it had its own session,
  the join merged with no preview, a rename and a recolour made at once lost one of the two,
  the host name was written, and a closed window's pins were put back into another window.
- **User first.** Changes in seconds, a set-up sheet, a register per field, held decisions,
  Undo, a hold on bulk removals. All three reviewers chose it. Its gaps: deletions still came
  from absence in a window (the Peek case again), a loaded tab in the background could reload
  into another session, a clock far ahead was not held, and Undo covered one batch.

The decision is the user-first design with its gaps closed. From safety first: a tombstone
needs an explicit action and absence at commit; moves into Peek and the little window are
moves; a move that would reload a loaded tab is held; the bulk guard covers additions and
Space deletions; a clock far ahead is held; unknown keys are written back; backups are taken
before the join and before a held batch; only unopened pins go to Recently Closed; the device
name is neutral by default; Undo covers 10 batches. From simplicity first: the join stamp that
lets the folder win a tie, the ledger in the file's format, polling only while a window is in
front, a check skipped while a read is outstanding, one synchronous apply, the same essentials
cap on every computer, and the Mac usage strings in the right file.

## Consequences

- New code beside the importer: a pure merge model, the file reader and writer, the ledger, a
  tracker of each window, the applier and a profile service. The service starts with the
  profile but holds only a preference observer while sync is off. The importer stays add-only
  and sync never calls it; the two share the id helpers and the unloaded-tab insert.
- New hooks: SpaceModel observers for a pin's and a folder's pinned state, a SpaceRegistry
  observer for a removed Space, and one small hunk in the tab strip observer for a removed
  folder (Stedding's own folder code). Upstream hunks for one toast id (67), the service's
  registration and the Mac usage strings. Each pin move re-applies them.
- Profile preferences under `stedding.sidebar_sync` and a `Stedding Sidebar Sync` folder in
  the profile (ledger, journal, backups). Renaming either needs a migration. The file carries a
  format number; a later format still reads format 1.
- A computer away for more than 180 days can bring removed items back as additions, which the
  bulk guard holds. A removal path without a hook brings an item back on that computer. Both
  are clutter, never loss.
- A closed window's synced pins stay in the ledger and keep travelling, but come back only
  through Bring them here or by reopening the window, until windows G2 (`S-94`) shows pins in
  every window.
- Both platforms ship together. Acceptance needs a signed Mac build (privacy prompts, iCloud
  Drive placeholders, a network share) and the PC (OneDrive placeholders, a file held open).
- If accepted, other docs follow: sidebar-file gets rows Sf7–Sf41; `docs/PRIVACY.md` gets a
  defaults row (off; what the file holds, including the device name; no network request);
  `docs/ROADMAP.md`'s "sync services" line, `docs/PRODUCT.md` §10's sync row and
  `docs/VISION.md`'s "No sync" weakness say this is not a service; `docs/FAQ.md` answers "Can I
  sync without an account?".

## Open questions for the owner

Each with the recommended answer.

1. Thresholds (bulk guard at 5 removals, a third of the pins or over 50 additions; clock hold at 24 h; tombstones 180 days; Undo for 10 batches over 30 days; 5 backups; a 10 s poll in front)? Recommended: as listed.
2. A pin removed elsewhere that was never opened here goes to Recently Closed: does that fit "sync never closes a page you have open"? Recommended: yes; nothing open closes, and reopening a closed tab brings it back.
3. Default device name: neutral "Mac" or "Windows PC" plus 4 hex, or the computer's own name? Recommended: neutral and editable, so no host name is written by default (`docs/PRIVACY.md`).
4. Synced pins in no window here are never put back on their own, only by Bring them here? Recommended: yes, until windows G2 (`S-94`).
5. A command-bar row "Sync sidebar now" while sync is on? Recommended: Settings only at first; changes arrive within seconds without it.
6. Should a Space's unpinned folders travel? Recommended: no; only pinned folders and essentials, as open tabs never travel.

Still to be measured before building (each changes a detail, not the decision):

- A folder emptied by dragging out its last tab: removed by the tab collection, or left empty? Check the empty-folder removal in `components/tabs`; if removed there, the folder hook fires from that spot too.
- A launch set to open the New Tab page: are pins restored at all? Check on both platforms; if not, Bring them here is how synced pins come back.
- An iCloud Drive file evicted on macOS 14 and 15: does a read wait for the download or fail? Check with Remove Download on the signed Mac build.
- Does a folder picked in the open panel stay allowed across relaunches of the signed app, and do the usage strings show in the prompts? Check with a folder in Documents and a network volume.
- Does FSEvents report writes another computer makes on an SMB share? Check from the PC; if it does, the 10 s poll can be relaxed.

## Spec rows (planned)

For `docs/features/sidebar-file.md`. None is built; each row gets its tests when it is written
there.

- Sf7 (planned): "Sync through a folder", off by default; hidden for Guest, in a private window and on a Blank Window's settings; every control keyboard-reachable and named.
- Sf8 (planned): Set up… opens the folder picker; refuses a folder in Stedding's data, an unwritable one and one macOS blocks; creates only `Stedding Sidebar`, never the picked folder.
- Sf9 (planned): before anything is written, a sheet with the editable computer name, the other computers, counts and pairs; Combine, Keep both, Cancel; a backup first.
- Sf10 (planned): pairing at the first join by unique name, home and title; the smaller id wins everywhere; nothing re-keyed; ambiguity stays as two items; the folder wins a tie.
- Sf11 (planned): a computer first seen later with a same-named, unpaired Space has that Space held for Combine or Keep apart; its other changes apply.
- Sf12 (planned): each install writes only its own file, atomically, 2 s after a change and at quit; a title or navigation writes nothing; a write cut short by quitting is made at launch.
- Sf13 (planned): another computer's change applies about 2 s after its file changes, an in-place rewrite included; network shares are checked on window activation and every 10 s while in front.
- Sf14 (planned): at launch the folder is first read after a window and session restore, or at once when nothing restores; no pin is added twice; changes with no window apply on the next.
- Sf15 (planned): each field keeps its later edit on a clock that never runs backwards, ties broken by install id; a rename and a recolour both survive; a replaced edit offers Undo.
- Sf16 (planned): each list keeps the order of its newest version; an item added elsewhere meanwhile stays beside its neighbour.
- Sf17 (planned): a new pin, folder or essential arrives unloaded in its place, in the window holding its Space, never twice; sync activates nothing; an empty remote folder waits.
- Sf18 (planned): a deletion travels only from a user's removal in a live window with the item then in no window; a pin made an essential or moved to another window or Peek is a move.
- Sf19 (planned): nothing else deletes: closing a window or the last one, quitting, a launch without restore, a Blank Window drag, or a peer file missing, short, unread, newer or a copy.
- Sf20 (planned): synced pins in no window here are never put back on their own; Bring them here inserts them; a reopened window's pins take newer values.
- Sf21 (planned): a pin removed elsewhere goes to Recently Closed if sync put it here and it was never opened, otherwise becomes an ordinary tab; the active tab waits; a folder releases its tabs.
- Sf22 (planned): a batch with 5 or more removals, a third of the pins, over 50 additions or a Space deletion is held whole with Apply and Keep; a backup before Apply.
- Sf23 (planned): a Space deleted elsewhere stays here with its pins until the user chooses; Delete here asks the usual question; Keep brings it back everywhere.
- Sf24 (planned): a new Space with its own session arrives with an empty jar; a later session change elsewhere asks, with the pages it would reload; Not on this computer is remembered.
- Sf25 (planned): a remote move that would reload a loaded tab into another session waits for unload or Move now; a change to a dragged tab waits for the drop.
- Sf26 (planned): an edit after a deletion keeps the item; tombstones drop 180 days after arrival here, never while a decision waits.
- Sf27 (planned): a computer whose clock runs more than 24 h ahead is held and named; its times never move this computer's clock.
- Sf28 (planned): only `stedding-sidebar-<16 hex>.json` is read; a sync tool's conflict copy is named with Show in folder and Dismiss, never applied or deleted; temporary files and stubs are ignored.
- Sf29 (planned): an older copy of this computer's own file is ignored and overwritten; a copied profile takes a new install id and never deletes the other copy's file.
- Sf30 (planned): an iCloud Drive or OneDrive file not yet downloaded is fetched in the background and shown as waiting, with how to keep it downloaded; it deletes nothing.
- Sf31 (planned): an unreachable folder, a blocked folder or a file held open is said once; a failed write retries after 10 s and 60 s, then waits for the next change; no loop.
- Sf32 (planned): on the Mac the folder usage strings are in the app, and the folder is never opened before a window has been active, so a prompt shows only in context.
- Sf33 (planned): peer files are parsed off the UI thread within caps (4 MiB, 5,000 records); cycles, duplicate ids and non-web homes are refused; a bad file is never applied in part.
- Sf34 (planned): a file in a newer format is not applied and Settings says to update; fields this version does not know are written back unchanged.
- Sf35 (planned): the last 10 changes from other computers (30 days) each have Undo, which travels; the last 5 backups can be imported.
- Sf36 (planned): only the sidebar travels; never open tabs, child nesting, splits, collapsed state, history, cookies, passwords, extensions, jars, routes, settings or the host name; no network request.
- Sf37 (planned): Stop syncing changes nothing and leaves the files, removing this computer's file only when ticked; turning sync on again merges by the same ids.
- Sf38 (planned): every file in the folder is a whole sidebar that Import sidebar… reads on a computer that does not sync.
- Sf39 (planned): with sync off the service observes and reads nothing; a Blank Window, a private window, Guest, the little window and Peek never take part; each profile has its own setting.
- Sf40 (planned): every message the sync box sends has a handler that answers, on both platforms.
- Sf41 (planned): essentials past the twelfth become pins at the end of the first Space's pinned run, the same way on every computer.
