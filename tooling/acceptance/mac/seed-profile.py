#!/usr/bin/env python3
"""Seed a fresh profile for the core-loop acceptance run (BACKLOG S-173).

    seed-profile.py <profile-dir>

Writes <profile-dir>/Default/Preferences with three Spaces -- Home, Work and
Play -- and the welcome flow marked as shown, so the first launch opens on
the window and not on the welcome pages; and <profile-dir>/Local State with
this repository's VERSION as the version that last ran, so a build that
carries a version (an installed one) does not open the update's thank-you
page as an extra tab (docs/features/updates.md Up10). Refuses a directory that already
holds a profile: the run starts from nothing every time.

The Spaces are the profile's registry (stedding.spaces.registry), the list a
window reads its Spaces from. Tabs are not seeded: 10-setup.steps files them
through the product's own keys.
"""

import json
import os
import sys

SPACES = [
    ("5ED1D9A1A0C04B0B9C1F0A11C0FE0001", "Home"),
    ("5ED1D9A1A0C04B0B9C1F0A11C0FE0002", "Work"),
    ("5ED1D9A1A0C04B0B9C1F0A11C0FE0003", "Play"),
]
# The default Space colour of a profile Stedding made itself.
DEFAULT_COLOR = -10785908


def main(argv):
    if len(argv) != 2:
        print(__doc__.strip(), file=sys.stderr)
        return 2
    profile = argv[1]
    default = os.path.join(profile, "Default")
    prefs = os.path.join(default, "Preferences")
    if os.path.exists(prefs):
        print("%s already holds a profile; use a new directory" % profile,
              file=sys.stderr)
        return 1
    os.makedirs(default, exist_ok=True)
    registry = [{
        "id": space_id,
        "name": name,
        "color": DEFAULT_COLOR,
        "color_chosen": False,
        "icon": "",
        "isolated": False,
        "pins_collapsed": False,
        "profile": "",
    } for space_id, name in SPACES]
    seed = {
        "stedding": {
            "welcome": {"shown": True},
            "spaces": {"registry": registry},
        },
    }
    with open(prefs, "w", encoding="utf-8") as handle:
        json.dump(seed, handle)
    repo = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
    with open(os.path.join(repo, "VERSION"), encoding="utf-8") as handle:
        version = handle.read().strip()
    with open(os.path.join(profile, "Local State"), "w", encoding="utf-8") as handle:
        json.dump({"stedding": {"updates": {"last_run_version": version}}}, handle)
    print("seeded %s: %s" % (profile, ", ".join(name for _, name in SPACES)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
