# Feature: Sidebar file

Status: **Sf2 and Sf6 built** (2026-10-25, BACKLOG S-282 step 1, S-61); **sync through a
folder, Sf7–Sf41, built in its first form** (2026-10-25, BACKLOG S-282, ADR 0029), each row's
state below; none of it released or yet run on a build. **Sf1, Sf3–Sf5 withdrawn** in patch
0055 (owner decision, 2026-09-26). Owner: import I18–I20.

The sidebar travels as a file, or, with sync through a folder on, as a file each computer
keeps in a folder the user's own sync tool or shared drive carries. No Stedding account, no
Stedding host, no network request.

Settings › Stedding › Spaces has three buttons. **Export Space…** writes the active Space,
**Export all Spaces…** writes every Space of the window with its pins, pinned folders and
essentials, both to Downloads, and **Import sidebar…** reads either file back, on the same
computer or another one. The file is the importer's format (import I20, `sidebar_backup.cc`):
Arc's own shape, with what Arc's shape has no place for in a block of its own. Importing is a
merge: it adds what is missing and never closes, moves or renames anything that is open.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Sf1 | A portable `stedding.sidebar` version 2 catalog would round-trip a window. | none | withdrawn |
| Sf2 | **Import sidebar…** merges by durable id and never closes an open tab (import I18). Every id in a file Stedding writes survives a restart: a Space is its registry token, a pin, tab or essential is `tab:<tab token>` (the token kept in the tab's session data, `stedding.tab_token`, made at the first export of a tab that has none), a folder is `folder:<FolderId>`. Two tabs are never written under one id. An import skips what is open now under one of the file's ids, in any window of the profile, and makes each tab and folder it adds with the file's id; it keeps none of those ids in the profile's list of Arc's ids, so a tab closed since an import comes back at the next one. A file exported before a restart and imported after it adds nothing. A Space-pinned folder comes back pinned, in its place in the run, with its nesting; a Space keeps its exact colour and its dark colour, where Arc's colours take the nearest swatch (I10). A token makes no tab a parent: child tabs (tabs R57) are unchanged. The tabs an import makes are unloaded, and the session writes a tab's page as it commits: until the session was next written whole, a quit soon after an import lost every tab it made. Each is written to the session as it is made (2026-10-25, found by `SidebarFileTest.TheSameFileAfterARestartAddsNothing`). A file Stedding wrote before tabs kept a token names its tabs by a launch's number: those ids are remembered in the profile, as Arc's are, so such a file adds its tabs once (`SidebarBackupTest.AnOlderFileAddsItsTabsOnce`). | `SidebarBackupTest.RestoreClosesNothing`, `.IdsSurviveARestart`, `.ATokenMakesNoParent`, `.TwoTabsAreNeverWrittenUnderOneId`, `.AClosedPinComesBackFromTheFile`, `.RoundTripIsIdentity`, `.AnArcFilesColourStillTakesASwatch`; browser `SidebarFileTest.PRE_TheSameFileAfterARestartAddsNothing` / `.TheSameFileAfterARestartAddsNothing` | built · not yet run |
| Sf3 | Settings **Sidebar folder**: a user-chosen directory. Stedding writes `sidebar.stedding.json` on the backup tick and on quit, atomically. A newer file on launch is merged. Stedding never talks to Syncthing or iCloud. | none | withdrawn · its successor is S-282's later steps |
| Sf4 | A `.sync-conflict-*` copy is not applied silently; a toast names it. | none | withdrawn · as Sf3 |
| Sf5 | Unpinned tabs would not travel unless the user opted in. Passwords, history, extensions and partitions never travel. | none | withdrawn · as Sf3 |
| Sf6 | **Export all Spaces…** writes every Space of the window, in the switcher's order, as one file in Downloads, `Stedding sidebar <date> <time>.json`: each Space's name, icon, colour or colour pair, and whether it has its own session; its pinned run (pins with their homes, Space-pinned folders with their nesting) and its other tabs and folders; the shared essentials row, and the essentials a Space with its own session has as its own, with that Space. The file is written atomically, and a second export in the same minute is a file of its own. **Import sidebar…** on another install brings all of it in, unloaded: a Space it makes with its own session gets a jar of its own, empty (nothing signed in travels), and that Space's own essentials go into it. | `SidebarBackupTest.ExportAllSpacesImportsBack`, `.ExportAllCarriesTheEssentials`, `.ASecondExportIsAFileOfItsOwn`, `.SnapshotCarriesEveryField`; browser `SidebarFileTest.ExportAllSpacesWritesEverySpace` | built · not yet run |
| Sf7 | Settings › Stedding › Spaces has **Sync through a folder**, off by default, under the export and import row. It is not shown for Guest, in a private window or on a Blank Window's settings. Every control is a button, a field or a box with its own name, reached by Tab. | browser `SidebarSyncTest.TheServiceIsOffByDefault`, `.APrivateProfileHasNoService`, `.EverySyncMessageAnswers` | built · not yet run; the Blank Window case has no test yet |
| Sf8 | **Set up…** opens the system folder picker. A folder inside Stedding's own data, one Stedding cannot write and one the system will not let it open are refused, each with one sentence. Stedding never makes the folder picked, only `Stedding Sidebar` in it, and uses the picked folder itself when it is one already or holds sidebar files. | browser `SidebarSyncTest.AFolderInsideTheUserDataIsRefused`; `SidebarSyncFileTest.APickedSteddingSidebarFolderIsNotNested` | built · not yet run; the unwritable and blocked cases have no test yet |
| Sf9 | Before anything is written, a sheet shows this computer's name (by default "Mac" or "Windows PC" and four characters of its install id, editable) and what will happen: where its file goes, or the other computers with their counts and the pairs, each with a box. **Combine**, **Keep both** and **Cancel**; Cancel leaves sync off and the folder untouched. A backup of the sidebar is taken first. | browser `SidebarSyncTest.FirstJoinWritesNothingBeforeAnswer`, `.AnotherInstallsPinArrivesUnloaded`; `SidebarSyncFileTest.TheDefaultDeviceNameIsNeutral` | built · not yet run; the backup at the join has no test yet |
| Sf10 | Pairing at the first join: Spaces pair by trimmed, case-folded name when each side has exactly one of that name; inside a paired Space a pin pairs by home and name, a folder by title, an essential by home, always one candidate each side. The smaller id becomes the shared one on every computer, even when two join at once, through aliases written in the files; no local id changes, so child tabs keep their parents. Anything ambiguous stays two items; **Keep both** pairs nothing. What existed at the join is older than any edit, and the folder's content wins a tie. | `SidebarSyncPairTest.SmallerIdWinsOnBothSides`, `.TwoSimultaneousJoinsSettle`, `.AThirdInstallSettlesThroughAliases`, `.AmbiguousNamesStayApart`, `.CanonicalizeMergesAPair`; `SidebarSyncMergeTest.TheFolderWinsATieAtJoin` | built · not yet run |
| Sf11 | A computer first seen after the join, with an unpaired Space of a name this computer has, has that Space held for **Combine** or **Keep apart**. | none | gap |
| Sf12 | Each install writes only `<folder>/Stedding Sidebar/stedding-sidebar-<16 hex>.json`, atomically: two seconds after the last change to the synced sidebar, after a merge that changed it, and as quitting starts. Only a field changed here is stamped; a title, a load or a navigation in a pin writes nothing. A write quitting beat is made at the next launch. | `SidebarSyncFileTest.EachInstallWritesItsWholeSidebar`; `SidebarSyncMergeTest.OnlyChangedFieldsGetANewTime`; browser `SidebarSyncTest.AnotherInstallsPinArrivesUnloaded` | built · not yet run; the write at quit has no test yet |
| Sf13 | Another computer's change applies about two seconds after its file changes: a recursive watch (FSEvents on the Mac, which sees a file rewritten in place; ReadDirectoryChangesW on Windows). A folder that sends no events is read when a Stedding window becomes active (at most every five seconds), every ten seconds while one is in front, never in the background, and on **Sync now**. A read still running is never queued behind. | browser `SidebarSyncTest.ARemoteRenameApplies` | built · not yet run; the watch and the poll have no test yet |
| Sf14 | At launch the folder is first opened once a Stedding window is up and session restore is over. A restored pin is never added twice; changes that arrived with no window open apply when one opens. | none | partial · written, not built or tested · no test yet |
| Sf15 | Each field (a Space's name, icon, colours and own session; a pin's home, its own name and its place; a folder's title and place) keeps its later edit on a clock that never runs backwards, the install id breaking a tie, so a rename on one computer and a recolour on the other both survive. A batch that replaced an edit made here says so beside its Undo. | `SidebarSyncMergeTest.TheNewerEditWins`, `.DifferentFieldsBothSurvive`, `.ASlowClockStillMovesForward`, `.TiesBreakOnTheInstallId`, `.MergeIsOrderIndependent`; browser `SidebarSyncTest.ARemoteRenameApplies` | built · not yet run |
| Sf16 | The Space list, each pinned run, each folder and each essentials row keep the order of their newest list; an item added elsewhere meanwhile stays after the item it followed. | `SidebarSyncMergeTest.OrderFollowsTheNewerListAndKeepsTheRest`, `.AReorderAndAnAddBothSurvive` | partial · partly built: merged for every list, applied to the windows for the Space list only |
| Sf17 | A pin, folder or essential another computer added arrives unloaded, in its Space and folder, in the window that holds most of that Space's pins, else the last-active one; never a Blank Window, the little window or a peek, never twice, never activated, and routing does not move it. A remote folder with no tab yet waits. | browser `SidebarSyncTest.AnotherInstallsPinArrivesUnloaded` | built · not yet run; a new pin joins the end of its run rather than its place |
| Sf18 | A removal travels only when the user made it in a live window (unpinned or really closed a pin, removed an essential, unpinned, ungrouped or closed a pinned folder, deleted a Space) and the item is then in no window of the profile. A pin made an essential, or moved to another window, the little window or a peek, is a move. A pin removed here and reopened is alive again. | browser `SidebarSyncTest.UnpinTravelsAsADeletion`; `SidebarSyncMergeTest.AbsenceWithoutIntentIsNoDelete`, `.AReopenedPinComesBack` | built · not yet run; the moves have no test yet |
| Sf19 | Nothing else removes: closing a window or the last one, quitting, a launch before or without restore, or a peer file that is missing, shorter, unreadable, not downloaded, newer, held or a copy. | browser `SidebarSyncTest.ClosingAWindowWithPinsWritesNoTombstone`; `SidebarSyncMergeTest.AMissingFileDeletesNothing`, `.AShorterFileDeletesNothing` | built · not yet run |
| Sf20 | Synced pins in no window here are never put back on their own; a row says how many and offers **Bring them here**. | none | partial · written, not built or tested · no test yet |
| Sf21 | A pin or essential another computer removed goes into Recently Closed when sync put it here and it was never opened here; otherwise it stays open as an ordinary tab of its Space. The tab the user is on is left alone until they leave it. A folder removed elsewhere lets its tabs go, in its place. | none | partial · written, not built or tested · no test yet |
| Sf22 | A batch from one computer with five or more removals, a third or more of the synced pins, more than fifty additions or a Space deletion waits whole, in one row naming the computer and the counts, with **Apply** and **Keep**. Keep stamps the removed items again so they come back everywhere; a backup is taken before Apply. | `SidebarSyncMergeTest.ABulkRemovalIsHeldWhole`, `.ManyAdditionsAreHeld`; browser `SidebarSyncTest.ABulkRemovalWaits` | built · not yet run |
| Sf23 | A Space deleted on another computer stays here, with its pins, until the user chooses: **Delete here…** asks first, then deletes it and clears its own session; **Keep** brings it back everywhere. The last Space is never deleted. | `SidebarSyncMergeTest.ASpaceDeleteIsHeld` | built · not yet run in a browser |
| Sf24 | A Space made here from another computer with its own session gets a jar of its own, empty. A later change of an existing Space's own session elsewhere is a row with the pages it would reload: **Turn on here** (through the Space model) or **Not on this computer**, which holds until a newer change. | none | partial · written, not built or tested · no test yet |
| Sf25 | A move into another session of a pin whose page is loaded waits until it sleeps, or **Move now**. A change to a tab being dragged waits for the drop. | none | partial · partly written, no test yet: the session case; the drag case is not written |
| Sf26 | An edit made after a removal keeps the item. Tombstones are dropped 180 days after they arrived here, by this computer's clock, never while a decision about them waits. | `SidebarSyncMergeTest.AnEditAfterADeleteKeepsTheItem`, `.TombstonesPruneByReceiptTime`, `.AHeldTombstoneIsNotPruned` | built · not yet run |
| Sf27 | A computer whose clock runs more than 24 hours ahead has its changes held and named; its times never move this computer's clock. | `SidebarSyncMergeTest.AClockFarAheadIsHeld` | built · not yet run |
| Sf28 | Only a file named exactly `stedding-sidebar-<16 hex>.json` is read. A sync tool's copy (`… 2.json`, `(1)`, `-COMPUTER`, `.sync-conflict-…`, a conflicted copy) is named in a row with **Show in folder** and **Dismiss**, never applied or deleted; temporary files and `.icloud` stubs are ignored. | `SidebarSyncFileTest.OnlyExactNamesArePeers` | built · not yet run; no toast yet |
| Sf29 | An older copy of this computer's own file, brought back by a sync tool, is ignored and written over. A copy of the profile writing under the same id is noticed: this computer takes a new id and leaves that file alone. | `SidebarSyncLedgerTest.AnEchoIsNotAProfileCopy` | built · not yet run |
| Sf30 | A cloud drive's file not downloaded yet (iCloud Drive on the Mac, OneDrive on Windows) shows as waiting, with how to keep the folder downloaded, and deletes nothing. | manual, acceptance | built · not yet run |
| Sf31 | An unreachable folder, a folder the system blocks, or a file another program holds open is said in one sentence. A failed write is tried again after 10 and 60 seconds, then at the next change or **Sync now**; never in a loop. | none | partial · written, not built or tested · no test yet |
| Sf32 | On the Mac the folder usage strings are in the app, and the folder is first opened right after the pick or, at a launch, once a window is up, so a system prompt shows only in context. | manual, acceptance (signed build) | built · not yet run |
| Sf33 | Another computer's file is not trusted: read and parsed off the UI thread, at most 4 MiB and 5,000 records, names and addresses capped, a parent cycle, a folder nested too deep, an id twice in a list or a bad id refusing it whole; a home that is no web page is dropped. | `SidebarSyncFileTest.AnOversizedFileIsRefused`, `.ACycleIsRefused`, `.AJavascriptHomeIsDropped`, `.AMalformedFileAppliesNothing` | built · not yet run |
| Sf34 | A file in a newer format is not applied, and Settings names the computer and says to update. Fields this version does not know are written back unchanged. | `SidebarSyncFileTest.ANewerFormatIsNotApplied`; `SidebarSyncMergeTest.UnknownFieldsSurviveARewrite` | built · not yet run |
| Sf35 | Settings lists the last ten batches from other computers (30 days), each with **Undo**, which puts the earlier values back here and on the other computers and brings removed pins back unloaded; and the last five backups, each with **Import**. | `SidebarSyncLedgerTest.TheJournalKeepsTenBatches`, `.TheLedgerRoundTrips`, `.BackupsRotateAtFive`, `.BackupNamesMatchNoSidebarPattern` | built · not yet run; Undo has no browser test yet |
| Sf36 | Only the sidebar travels: Spaces (name, icon, colours, order, own session), pins with their home and own name, pinned folders with their nesting, essentials. Never open tabs, addresses or titles, child nesting, splits, collapsed states, history, cookies, passwords, extensions, jars, routes, settings or the host name. Stedding makes no network request for sync. | `SidebarSyncFileTest.NoSecretTravels` | built · not yet run |
| Sf37 | **Stop syncing** changes nothing in the sidebar and leaves the files; this computer's own goes only when its box is ticked. The ledger is forgotten and the install id kept, so turning sync on again is a fresh join by the same ids. | browser `SidebarSyncTest.TurningSyncOffStopsWritingAndKeepsEverything` | built · not yet run |
| Sf38 | Every file in the folder is a whole sidebar that **Import sidebar…** reads on a computer that does not sync. | `SidebarSyncFileTest.TheFileIsAnImportableSidebar` | built · not yet run |
| Sf39 | With sync off the service watches one preference and reads nothing. A Blank Window, a private window, Guest, the little window and a peek never take part. Each profile has its own setting. | browser `SidebarSyncTest.TheServiceIsOffByDefault`, `.APrivateProfileHasNoService` | built · not yet run |
| Sf40 | Every message the box sends has a handler that answers. | browser `SidebarSyncTest.EverySyncMessageAnswers` (all but the folder picker, which opens a system dialog) | built · not yet run |
| Sf41 | Essentials past the twelfth become pins at the end of the first Space's pinned run, the same way on every computer. | `SidebarSyncMergeTest.ThirteenEssentialsMakeOnePin` | built · not yet run |

## What a file holds

- The top level is Arc's: `sidebar.containers[1]` with `spaces`, `items` and
  `topAppsContainerIDs`, then `"version": 1` and `"writer": "Stedding"`. `ParseArcSidebar`
  reads both, so one parser serves Arc's file and Stedding's; `"writer": "Stedding"` is what
  makes an import merge by the durable ids (Sf2), and a reader of Arc's shape skips the rest.
- Each Space entry has a `stedding` block: `color` and `darkColor` (`#RRGGBB`), `isolated`
  (the Space has its own session; never its partition or anything in its jar), and
  `essentials`, the id of a top-apps container holding the essentials that are that Space's
  own. That container is not listed in `topAppsContainerIDs`, so a reader that knows only
  Arc's shape does not make them shared.
- What a file never holds: history, cookies, passwords, extensions, a Space's partition,
  routes, settings, child-tab nesting, splits, collapsed states.

## Limits

- A file written before Sf2 named tabs by their session ids (`tab:<number>`) and folders by
  an address. Those ids are read as foreign ones: importing such a file into the window it
  came from, after a restart, adds its tabs a second time, once. Its Spaces are still found by
  their tokens.
- An import only adds. It does not rename, recolour, move, unpin or delete anything that is
  already here, and it does not change the session setting of a Space that exists. A folder
  that is already here keeps its place; what the file adds to it goes in.
- A Space's own essential comes in as its own only when the Space has its own session here;
  otherwise it joins the shared row.
- Arc's folders in a pinned run still come in under the Clear line, as they always have: only a
  file Stedding wrote says a folder was pinned.

## Sync through a folder

ADR 0029 has the design and the options weighed; this is what was built.

- **The folder.** Settings stores the folder the files live in (`stedding.sidebar_sync.folder`),
  this install's id (16 hex characters) and its name. Each install writes only its own file;
  every other exact name is a peer. A file is the Export all Spaces format with a
  `stedding_sync` block: the format number, the install id and name, a write number and a
  random value per write, the times, and `records`, `lists` and `aliases`.
- **Records.** A Space, a folder or a tab, by its durable id (Sf2). Each field is
  `[value, time, install]`; a removal is a `del` time. Containers are `spaces`, `essentials`,
  `space:<id>/pins`, `space:<id>/essentials` and each folder's own id; a tab's `parent` field
  says which, so a pin made an essential is a move.
- **What each install keeps** in its profile, never in the folder: `Stedding Sidebar
  Sync/ledger.json` (the same block, plus when each tombstone arrived, what it last read of
  each peer, what sync inserted and nobody opened yet, what waits for a window, the Spaces
  whose session this computer keeps as it is, dismissed copies, the journal) and
  `backups/before-sync-<UTC>.json` (five kept).
- **The merge** is per field, per list and per tombstone: the later `[time, install]` wins.
  A local edit is stamped with the later of now and the highest time seen plus one. The
  user's edits are found by comparing what the windows show with what they showed at the last
  look, never with the ledger, so a newer value not applied yet is never undone.
- **Removals** come only from the user's own action in a live window: an unpin (the new
  `SpaceModel::Observer::OnTabSpacePinChanged`), a folder unpinned
  (`OnFolderSpacePinChanged`), an essential unpinned, a real close (a close that only puts a pin
  to sleep is none), a folder ungrouped while its tabs stay, a Space deleted (the new
  `SpaceRegistry::Observer::OnRegistrySpaceRemoved`). Two seconds later the item must be in no
  window of the profile, the little window and peeks included. Nothing is recorded while a
  window closes, while quitting, during session restore or while sync itself applies a change.
- **Code.** `chrome/browser/ui/spaces/sidebar_sync_state` (the pure merge),
  `sidebar_sync_file` (names, parsing, writing), `sidebar_sync_ledger`, `sidebar_sync_tracker`
  (what the windows show), `sidebar_sync_apply` (the windows brought in line, one pass, routing
  paused), `sidebar_sync_service` and its factory, made with the profile. The importer's id
  helpers and its unloaded-tab insert moved to `sidebar_ids` and `unloaded_tab`, shared by
  both. Settings' box is `settings-stedding-sync-section`.

## Sync limits

- A computer away for more than 180 days can bring removed items back as additions; a batch
  of many is held (Sf22). A removal path without a hook leaves the item here, and the user
  removes it again. Both are clutter, never loss.
- Pins in a closed window stay in the ledger and keep travelling, but come back only through
  **Bring them here** or by reopening the window, until windows G2 (`S-94`) shows pins in every
  window.
- A folder renamed here is noticed at the next look (a tab change, a window activation, the
  ten-second poll), not at once: the folder's title has no notification of its own. A title
  another computer gave a folder shows in the row at its next redraw.
- The order of pins inside a run, a folder or an essentials row is merged and written but not
  yet applied to the windows; a pin another computer added joins the end of its run.
- Not built yet: a computer first seen later asking before its same-named Space pairs (Sf11),
  waiting for a drag to end (Sf25), the toast for a held decision or a copy (Settings is the
  place of record), and the notice "kept because another computer changed it after you removed
  it".
