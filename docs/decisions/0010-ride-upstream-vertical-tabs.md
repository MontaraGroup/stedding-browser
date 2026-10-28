# 0010 — Build the sidebar on upstream's vertical tabs, not on a replaced tab strip

Status: Accepted. The series edits `VerticalTabStripRegionView` in place. A subclass was not built (BACKLOG S-175).
Date: 2026-08-30

## Context

The sidebar is the product. Chromium already ships a vertical tab strip, `VerticalTabStripRegionView`, with collapse, width, pinning, drag-reorder, favicons and audio indicators. Upstream enables the feature and registers `prefs::kVerticalTabsEnabled` off, so a stock build hides the strip until Settings (patch 0001). Replacing `TabStrip` would mean owning that view on every rebase.

## Decision

The sidebar is Chromium's vertical tab strip. Patch 0001 registers `prefs::kVerticalTabsEnabled` as true. `TabStripModel` stays the data. Stedding does not replace `TabStrip`, does not add another tab renderer, and does not put the tab strip in Chromium's side panel.

Look and feel is patched into `VerticalTabStripRegionView`, which is `final`. A subclass in a new directory was the original plan. The series did not do that. Moving that logic into Stedding's own files is part of [BACKLOG.md](../../BACKLOG.md) S-175.

Chromium's switch to a horizontal strip stays ([PLAN.md](../../PLAN.md) decision 1, menus M9). Spaces, pins and folders work in that mode. Stedding builds no horizontal layout of its own.

## Consequences

Collapse, reorder, favicons, audio indicators and saved width come from upstream. The rebase cost is the edits to `VerticalTabStripRegionView` and `browser_view.cc`. New product logic belongs in Stedding's own files.

What the sidebar is for, once Chromium has vertical tabs, is [ADR 0011](0011-full-arc-parity.md).
