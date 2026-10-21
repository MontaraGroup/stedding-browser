# Plan: the owner's decisions and the rules of done

The order of work is [BACKLOG.md](BACKLOG.md). This file holds what does not change from item
to item: the owner's standing decisions, and when an item counts as done. The audit of
2026-09-26 that used to fill this file, with every item it raised (TAB-1, SPC-4, WIN-29, ...)
and their status notes, is [docs/history/plan-2026-09-26.md](docs/history/plan-2026-09-26.md);
its items still open on 2026-10-14 are BACKLOG rows that name their ids.

## The owner's decisions (2026-09-26)

1. Horizontal tab mode stays. Do not remove or hide the toggle. Switching either way must not
   crash, Stedding's views are torn down and rebuilt with the strip, menu ids are
   range-checked, and Spaces, pins and folders keep working in horizontal mode.
2. Peek is off by default until it is rebuilt (`S-93`).
3. The Space sleep timer defaults to Never until sleep is gated.
4. Every cut the audit listed is approved (the list is in the history file, section 2; patch
   0055 applied them, `S-61`).
5. ⌘9 selects the last row.
6. Collapsing the folder that holds the active tab keeps that tab showing under the header. No
   tab switch.
7. Deleting the active Space switches to its neighbour first. Only the last Space cannot be
   deleted.
8. The docs claim no import from Chrome, Brave or Edge until it exists; the importer is
   built later (`S-101`).
9. Little windows get no Space commands. "Open in main window" is enough (built as the
   window's "Open in Stedding", `docs/features/little.md` E7).
10. Tests that pin a bug are decided from the spec row and Arc's behaviour. Ask the owner only
    where those two disagree.

## Later decisions

11. Closing a pinned tab works the Arc way (2026-10-20): ⌘W, its close button, a middle click
    and the tab menu's Close unload a Space pin or an essential and send it back to its home,
    in its place, whatever it is doing, after the page's own "Leave site?" if it asks. The
    setting off makes ⌘W, the close button and a middle click close it (`docs/features/pins.md`
    H3, H9, H16).
12. A top-level folder can join a Space's pinned run, and its tabs are then pins
    (2026-10-20; `docs/features/folders.md` F38). Essentials take no folder.
13. On Windows the extension chord is Ctrl+Alt+E (2026-10-20; `docs/features/toolbar.md` T39).
14. Essentials stay shared by every Space, as in Arc (2026-10-21): no essentials of one Space,
    and no setting for them (`S-254`, GitHub issue 8).
15. Spaces switch with a sideways scroll over the sidebar, as in Arc (2026-10-21, GitHub
    issue 10): a tilt wheel and Shift with the wheel, on Windows also a touchpad's sideways
    scroll and Ctrl with the wheel; no Control with the wheel on the Mac, and a vertical
    scroll never switches (`docs/features/spaces.md` B39).
16. An issue a user files on GitHub is a suggestion unless it reports a bug (2026-10-21):
    bugs are fixed, a requested feature is built only once the owner has said yes, and
    nothing is said, labelled or closed on GitHub (`AGENTS.md`, red lines).

The operator's own request in chat comes before any of this and before BACKLOG's order.

## When an item is done

A green unit test does not close anything. An item is closed when all of these hold:

1. Its check passes on a real build: the shipping configuration of the current pin, launched
   as the app and used through its interface. The date, the commit and the result go into the
   item's row or `docs/PROJECT-LOG.md`.
2. A test that goes through the user's path, not a helper, was seen red before the fix and
   green after, and a `tooling/dev test` filter runs it. Input, focus, drag and restore need a
   browser test (`chrome/test/stedding/`, with `PRE_` steps for a restart). A unit test is fine
   for pure logic, but it never proves a spec row on its own. A capture proves pixels only.
3. The spec row cites that test, and the spec and the code's comments say what the code now
   does.
4. Suites that touch lifetimes ran clean with DCHECKs and the dangling-pointer detector on
   (`win-checks`, `mac-checks`), and under ASan before a release (`docs/QUALITY.md`).

## How items are taken

- **One root cause is one change.** Items that share a cause are fixed together; finish one
  change's check before starting the next. A fix goes into the patch that introduced the code
  (`tooling/fold-fix`, `patches/README.md`).
- **Confirm before fixing.** A finding that was read in the code but not seen happening is
  reproduced first: a failing test, or the failure on a real build. If an honest attempt does
  not reproduce it, record the attempt and close it as not reproduced. Nothing is fixed blind.
- **Defects before features.** New features wait until the core-loop gate in `BACKLOG.md`
  ("Checks still owed", its first row, `S-173`) passes, unless the operator asks for one in
  chat; its script and the record of each run are `docs/features/acceptance.md`. A
  crash, data loss or a broken privacy promise is built at once.
