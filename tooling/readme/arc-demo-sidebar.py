#!/usr/bin/env python3
"""Write a made-up Arc sidebar for the welcome flow's import still.

Usage: tooling/readme/arc-demo-sidebar.py <home>

Writes <home>/Library/Application Support/Arc/StorableSidebar.json in Arc's shape (the
shape chrome/browser/ui/spaces/arc_sidebar_importer_unittest.cc's fixture has): four
Spaces, pinned tabs and folders, open tabs and four essentials, on example sites. The
import step reads the Arc sidebar under the home folder it is given, so a capture launched
with this home shows these, never the profile of the Mac it runs on.
"""
import json
import os
import sys

SPACES = [
    # (id, title, emoji, pinned [(title, url) or (folder, [(title, url)])], open tabs)
    ("work", "Work", "💼",
     [("GitHub", "https://github.com/"),
      ("Docs", [("MDN Web Docs", "https://developer.mozilla.org/"),
                ("Django", "https://docs.djangoproject.com/"),
                ("Python", "https://docs.python.org/3/")]),
      ("Issues", "https://github.com/issues")],
     [("Hacker News", "https://news.ycombinator.com/"),
      ("Wikipedia", "https://en.wikipedia.org/")]),
    ("personal", "Personal", "🏡",
     [("Calendar", "https://example.com/calendar"),
      ("Reading", [("Example article", "https://example.com/article"),
                   ("Example essay", "https://example.org/essay")])],
     [("Example", "https://example.com/")]),
    ("reading", "Reading", "📚",
     [("Wikipedia", "https://en.wikipedia.org/wiki/Main_Page")],
     [("Example news", "https://example.net/news")]),
    ("side", "Side project", "🛠",
     [("Repository", "https://github.com/ysalitrynskyi/stedding-browser"),
      ("Notes", [("Plan", "https://example.com/plan"),
                 ("Design", "https://example.com/design")])],
     []),
]
ESSENTIALS = [
    ("GitHub", "https://github.com/"),
    ("MDN Web Docs", "https://developer.mozilla.org/"),
    ("DuckDuckGo", "https://duckduckgo.com/"),
    ("Hacker News", "https://news.ycombinator.com/"),
]


def main():
    home = sys.argv[1]
    items = []
    counter = [0]

    def new_id(prefix):
        counter[0] += 1
        return f"{prefix}-{counter[0]}"

    def tab(parent, title, url):
        tid = new_id("tab")
        items.extend([tid, {"id": tid, "parentID": parent, "childrenIds": [], "title": "",
                            "data": {"tab": {"savedURL": url, "savedTitle": title}}}])
        return tid

    def container(cid, children):
        items.extend([cid, {"id": cid, "parentID": None, "childrenIds": children, "title": "",
                            "data": {"itemContainer": {"containerType": {"spaceItems": {}}}}}])

    spaces = []
    for sid, title, emoji, pinned, unpinned in SPACES:
        pinned_id, unpinned_id = f"cont-{sid}-pinned", f"cont-{sid}-unpinned"
        pinned_children = []
        for name, value in pinned:
            if isinstance(value, list):
                lid = new_id("list")
                children = [tab(lid, t, u) for t, u in value]
                items.extend([lid, {"id": lid, "parentID": pinned_id, "childrenIds": children,
                                    "title": name, "data": {"list": {}}}])
                pinned_children.append(lid)
            else:
                pinned_children.append(tab(pinned_id, name, value))
        container(pinned_id, pinned_children)
        container(unpinned_id, [tab(unpinned_id, t, u) for t, u in unpinned])
        spaces.extend([f"space-{sid}", {
            "id": f"space-{sid}", "title": title, "profile": {"default": {}},
            "containerIDs": ["unpinned", unpinned_id, "pinned", pinned_id],
            "customInfo": {"iconType": {"emoji_v2": emoji}},
        }])
    top_children = [tab("cont-top", t, u) for t, u in ESSENTIALS]
    items.extend(["cont-top", {"id": "cont-top", "parentID": None, "childrenIds": top_children,
                               "title": "",
                               "data": {"itemContainer": {"containerType": {"topApps": {}}}}}])
    sidebar = {"version": 1, "sidebar": {"containers": [
        {"global": {}},
        {"spaces": spaces, "items": items,
         "topAppsContainerIDs": [{"default": "cont-top"}, "cont-top"]},
    ]}}
    arc = os.path.join(home, "Library", "Application Support", "Arc")
    os.makedirs(arc, exist_ok=True)
    with open(os.path.join(arc, "StorableSidebar.json"), "w", encoding="utf-8") as f:
        json.dump(sidebar, f, ensure_ascii=False, indent=1)
    print(os.path.join(arc, "StorableSidebar.json"))


if __name__ == "__main__":
    main()
