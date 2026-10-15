"""The default favicon: Tabler's world-www icon (MIT, branding/favicon/LICENSE-tabler-icons).

Chromium draws IDR_DEFAULT_FAVICON for a page with no icon of its own -- a tab's row, a
bookmark, a history entry, the command bar -- and IDR_DEFAULT_FAVICON_DARK on a dark
ground. Both are PNGs at 16, 32 and 64 px for 1x and twice that for 2x. This renders them
from branding/favicon/world-www.svg in the colours of the globe they replace, so the
contrast against every ground stays what it was.

Usage:
  python3 tooling/brand/favicon.py            # writes branding/favicon/scaled_{100,200}/

Needs rsvg-convert (librsvg; `brew install librsvg` on the Mac).
"""
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
SOURCE = ROOT / "branding" / "favicon" / "world-www.svg"
OUT = ROOT / "branding" / "favicon"
# The replaced globe's own colours (ui/resources default_favicon*.png).
COLOURS = {"": "#5F6368", "_dark": "#9AA0A6"}
# File suffix -> size at 1x.
SIZES = {"": 16, "_32": 32, "_64": 64}


def main() -> int:
    svg = SOURCE.read_text()
    for scale_dir, factor in (("scaled_100", 1), ("scaled_200", 2)):
        (OUT / scale_dir).mkdir(parents=True, exist_ok=True)
        for scheme, colour in COLOURS.items():
            coloured = svg.replace('stroke="currentColor"', f'stroke="{colour}"')
            for suffix, size in SIZES.items():
                target = OUT / scale_dir / f"default_favicon{scheme}{suffix}.png"
                px = str(size * factor)
                subprocess.run(["rsvg-convert", "-w", px, "-h", px, "-o", str(target)],
                               input=coloured.encode(), check=True)
                print(target.relative_to(ROOT))
    return 0


if __name__ == "__main__":
    sys.exit(main())
