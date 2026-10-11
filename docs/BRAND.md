# Brand

How Stedding presents itself: the name, the voice, the look, and the rules
that keep all three safe to use. The naming decision record — the candidates and
the criteria they were vetted against — is in `docs/NAMING.md`.

## The name

**Stedding Browser.** "Stedding Browser" on first mention; "Stedding" after
that. The binary, bundle, and package identifiers use `stedding`.

### Meaning and story

Stedding means a haven: a settled, kept place. The name is shaped on the
English word "steading", a farmstead or homestead — a farmhouse and its
outbuildings. "Steading" comes from Middle English "steding" ("place, farm"),
and that from Old English "stede" ("locality, place, site"); "stead" is an old
English word for a place.

That meaning maps precisely onto what this browser is for: a place to use the
web where surveillance and vendor control cannot reach. What shapes the rest
of the web — tracking, telemetry, ad-driven defaults, roadmaps set by someone
else's business model — stops at the door.

The name says what it is: a quiet, held ground.

### Pronunciation

**STED-ding.** Rhymes with "wedding." Two syllables, stress on the first.

## Voice

Calm, precise, no hype. Stedding writes the way a good engineer explains
something to a colleague: plainly, accurately, without selling.

- **Say what the software does.** Not what it "revolutionizes," "supercharges,"
  or "reimagines." If a sentence would survive on a competitor's site
  unchanged, it says nothing; cut it.
- **Be concrete.** "No telemetry by default" beats "privacy-first." Numbers
  only when they are real and measured; write TBD rather than invent one.
- **Be quiet.** No exclamation marks in product copy. No emoji in docs or
  release notes. No countdowns, no FOMO, no "last chance."
- **Respect the reader.** The audience is technical. Do not pad, do not
  over-explain, do not hide limitations. State trade-offs plainly.
- **Admit what is unfinished.** "Not implemented yet" is a complete sentence
  and better brand-building than a vague promise.

The same register applies everywhere: website, release notes, error messages,
settings copy, and social posts. If it would sound wrong in a commit message,
it is wrong on the website.

## Taglines

Chosen with the website (stedding.dev, 2026-09-16): **"Your haven on the web."** leads,
and **"A quiet place to get things done."** is kept for where the workflow features are
the subject. The first is the name's meaning in five words; the second is honest about
what daily use feels like.

## Visual direction

The mark and the palette exist. The mark is generated from one geometry file,
`tooling/brand/mark.py`, into `branding/` (an arch over a hearth); its colours are slate
`#2F4858`, cream `#F2E9DE`, amber `#E8B04B` and ink `#1C2B33`, deliberately not blue,
since every Chromium browser is blue. The browser's own chrome is sand by day and a
blue-to-plum gradient by night, each Space's colour tinting the sidebar (patch 0007). How
the assets are made and applied is `branding/README.md`. Neither the mark nor the palette
has an ADR.

The rules any new visual work keeps:

- **Mood: quiet and settled.** The name means a settled, kept place. Calm,
  grounded, unhurried. The opposite of neon gradients, glassy chrome, and
  startup confetti.
- **Motifs: shelter and ground.** A roof line, an arch, a threshold, a hearth,
  stone. Abstract geometry derived from these beats literal illustration —
  and material from anyone else's work is ruled out entirely (see trademark
  hygiene).
- **Both themes.** Everything holds up in light and dark, since the browser chrome
  is where the brand lives daily.
- **Typography.** A clear, unremarkable-in-the-best-way sans-serif for UI and
  docs. Nothing decorative in the product; any display face is for the website
  only, and its licence must permit open-source redistribution.
- **Iconography.** Simple, geometric, legible at 16 px. The app icon must read
  at dock size next to Chrome, Arc, and Firefox without shouting.

Test for any visual proposal: does it feel like a place you would go to
concentrate? If it feels like a place someone is trying to sell you something,
it fails.

## Trademark hygiene

The name is shaped on ordinary English words. These rules keep it clear of
anyone else's brand or work.

- **We use only the word.** Only the word "Stedding" is used, as this
  browser's name. No artwork, logos, names, quotations or other material from
  any book, film, game or other brand — not in the product, the website, the
  docs, marketing, or community spaces we control. Every piece of artwork is
  our own.
- **No claimed affiliation.** We do not state or imply endorsement by, or
  association with, anyone.
- **Plain English roots.** The name is shaped on plain English: "steading",
  a farmstead or homestead, from "stead", an old word for a place. This is a
  hygiene policy, not legal advice; if anyone ever objects to the name, we
  engage in good faith.
- **BSD clause 3 protects the name from forks.** BSD-3-Clause forbids using
  the names of the copyright holder or contributors to endorse or promote
  derived products without written permission. Anyone may fork the code — that
  is the point of the license — but a fork may not market itself as endorsed
  by, or pass itself off as, Stedding. Written guidance for naming a fork does not
  exist yet.
- **Registration status: TBD.** No trademark registration has been filed as of
  2026-08-30. Whether and where to file is an open question; the decision gets
  an ADR when it is made.

When in doubt: the word, its meaning, our own artwork — nothing else.
