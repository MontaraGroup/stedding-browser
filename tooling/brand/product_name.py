"""Rewrite the product name in Chromium's branded string tables.

Chromium's user-facing strings say "Chromium" in some seven hundred places --
"Chromium is being controlled", "Chromium PDF Document", the shortcut name,
the uninstall entry -- and they come from grit tables that a build reads as
files, never from the BRANDING file. The name reaches every one of them by
rewriting the tables in the checkout before the build, the way
tooling/apply-branding copies the icons over: a build-time transform, not a
patch, so it never conflicts on a rebase.

What is rewritten: the word "Chromium" inside message bodies of the branded
tables (chrome/app/chromium_strings.grd and its .grdp siblings, components'
and extensions' branded tables) and inside every locale's translations of
them (the .xtb files), since the name is a proper noun in every language.
It is rewritten where it is part of a longer word too -- a Finnish
"Chromiumin", a Korean "Chromium이", a Chinese "装Chromium" -- which a match
on word boundaries left alone in some twenty languages -- and where Hindi and
Nepali write it in Devanagari. What is not: the
`desc=` attributes translators read, "ChromiumOS" and "ChromiumUpdater"
(different products), and anything lowercase such as chromium.org. "The
Chromium Authors" becomes "The Stedding Authors", as the BRANDING file's
copyright line already says and as the earlier one-liner did.

grit finds a message's translation by a fingerprint of its English text, so
a rewritten English message no longer matches the translation an .xtb file
holds for Chromium's text, and every language fell back to English for it:
"About Stedding" and "Customize and control Stedding" in a German menu
(docs/features/windows.md N4, BACKLOG S-128). Each table is fingerprinted
before and after the rewrite with grit itself (the checkout's tools/grit),
and the translations move to the new fingerprints.

Every run starts from the tables and translations the checkout commits (git
show HEAD:<path>), whatever an earlier run left in the working tree, so a
run on a branded checkout gives what a run on a fresh one does.

Usage:
  python3 tooling/brand/product_name.py <chromium-src> [--check] [--name Stedding]

--check writes nothing and exits 3 when a file would change.
"""
import argparse
import io
import pathlib
import re
import subprocess
import sys

# Each branded table, with the translations of its messages.
TABLES = {
    "chrome/app/chromium_strings.grd":
        "chrome/app/resources/chromium_strings_*.xtb",
    "chrome/app/settings_chromium_strings.grdp":
        "chrome/app/resources/chromium_strings_*.xtb",
    "components/components_chromium_strings.grd":
        "components/strings/components_chromium_strings_*.xtb",
    # A part of extensions_strings.grd: its translations share that table's
    # files with the unbranded messages, and only its own are rewritten.
    "extensions/strings/extensions_chromium_strings.grdp":
        "extensions/strings/extensions_strings_*.xtb",
}
# Translation files that hold branded messages alone: every translation in
# them is rewritten.
BRANDED_ONLY = (
    "chrome/app/resources/chromium_strings_",
    "components/strings/components_chromium_strings_",
)
KEEP = ("ChromiumOS", "ChromiumUpdater")
# The name, and the name as two languages spell it in their own script: the
# Hindi and Nepali translations write it in Devanagari. Stedding goes in as
# it is, in Latin letters, as every other translation writes the name.
DEVANAGARI_CHROMIUM = "\u0915\u094d\u0930\u094b\u092e\u093f\u092f\u092e"
WORD = re.compile("Chromium|" + DEVANAGARI_CHROMIUM)
MESSAGE = re.compile(r"<message\b.*?</message>", re.S)
TRANSLATION = re.compile(r'(<translation id=")(\d+)(">)(.*?)(</translation>)',
                         re.S)
# A table of the messages alone, which grit parses and fingerprints as the
# real table's.
GRD_HEAD = """<?xml version="1.0" encoding="UTF-8"?>
<grit latest_public_release="0" current_release="1">
  <outputs></outputs>
  <release seq="1"><messages fallback_to_english="true">
"""
GRD_TAIL = "</messages></release></grit>\n"


def rewrite_text(text: str, name: str) -> str:
    out = []
    pos = 0
    for m in WORD.finditer(text):
        start = m.start()
        if any(text.startswith(k, start) for k in KEEP):
            continue
        # The About page's license line links the Chromium project by name:
        # "<name> is made possible by the Chromium open source project". The
        # subject is ours, the project is theirs; the placeholder that closes
        # the link marks it, in the English table and in every translation.
        if text.startswith('<ph name="END_LINK_CHROMIUM"', m.end()):
            continue
        out.append(text[pos:start])
        out.append(name)
        pos = m.end()
    out.append(text[pos:])
    return "".join(out)


def rewrite_table(text: str, name: str) -> str:
    # Tag lines carry descriptions and ids; the name only lives in text lines.
    # A message's opening tag (its desc= is for translators) is kept.
    return "".join(line if line.lstrip().startswith("<message")
                   else rewrite_text(line, name)
                   for line in text.splitlines(keepends=True))


def fingerprints(src: pathlib.Path, table: str) -> list:
    """grit's fingerprint of every message of `table`, in order."""
    # grit is imported from the checkout, which it must not write into.
    sys.dont_write_bytecode = True
    grit_dir = str(src / "tools" / "grit")
    if grit_dir not in sys.path:
        sys.path.insert(0, grit_dir)
    from grit import grd_reader
    from grit.node import message
    root = grd_reader.Parse(
        io.StringIO(GRD_HEAD + "\n".join(MESSAGE.findall(table)) + GRD_TAIL),
        dir=".", skip_validation_checks=True)
    return [node.GetCliques()[0].GetId() for node in root.Preorder()
            if isinstance(node, message.MessageNode)]


def committed(src: pathlib.Path, path: str):
    """The file as the checkout commits it, or None."""
    result = subprocess.run(["git", "-C", str(src), "show", f"HEAD:{path}"],
                            capture_output=True, encoding="utf-8")
    return result.stdout if result.returncode == 0 else None


def plan(src: pathlib.Path, name: str):
    """{path: text} for every branded table and translation file, and the
    number of translations moved to a new fingerprint."""
    out = {}
    moves_by_glob = {}
    for table, glob in TABLES.items():
        before = committed(src, table)
        if before is None:
            print(f"  missing: {table}", file=sys.stderr)
            continue
        after = rewrite_table(before, name)
        out[table] = after
        old, new = fingerprints(src, before), fingerprints(src, after)
        if len(old) != len(new):
            raise SystemExit(f"{table}: the rewrite changed the messages")
        moves = moves_by_glob.setdefault(glob, {})
        for o, n in zip(old, new):
            if o != n:
                if moves.get(o, n) != n:
                    raise SystemExit(f"{table}: {o} moves two ways")
                moves[o] = n
    moved = 0
    for glob, moves in moves_by_glob.items():
        for path in sorted(src.glob(glob)):
            rel = path.relative_to(src).as_posix()
            before = committed(src, rel)
            if before is None:
                before = path.read_text(encoding="utf-8")
            branded = rel.startswith(BRANDED_ONLY)

            def translate(m):
                nonlocal moved
                fingerprint = m.group(2)
                if fingerprint in moves:
                    moved += 1
                    fingerprint = moves[fingerprint]
                elif not branded:
                    return m.group(0)
                return (m.group(1) + fingerprint + m.group(3) +
                        rewrite_text(m.group(4), name) + m.group(5))

            out[rel] = TRANSLATION.sub(translate, before)
    return out, moved


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("src")
    ap.add_argument("--name", default="Stedding")
    ap.add_argument("--check", action="store_true",
                    help="write nothing; exit 3 when a file would change")
    args = ap.parse_args()
    root = pathlib.Path(args.src)
    files, moved = plan(root, args.name)
    changed = [p for p, text in files.items()
               if (root / p).read_text(encoding="utf-8") != text]
    if not args.check:
        for p in changed:
            (root / p).write_text(files[p], encoding="utf-8", newline="\n")
    verb = "would rewrite" if args.check else "rewrote"
    print(f"product name: {verb} {len(changed)} of {len(files)} files; "
          f"{moved} translations follow their message's new text")
    return 3 if args.check and changed else 0


if __name__ == "__main__":
    sys.exit(main())
