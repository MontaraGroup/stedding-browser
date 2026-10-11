# Performance measurements

**There is no current measurement.** The budgets in `docs/QUALITY.md` are overheads
against vanilla Chromium at the same pin, configuration and hardware. The only
comparison so far is from 2026-09-02, on the Mac, of the series of 8 patches as it was
on 2026-08-31, on 153.0.8010.12. The pin has moved to M155 and the series has grown
since (`tooling/dev status`), and nothing has been re-measured; the published images
are also built in the `release` configuration, not the `official` one measured here.
The numbers below are a record of that build, not of any release.

## How to measure

`tooling/measure/harness.py` on an otherwise idle Mac, never while a build runs. It
takes a macOS app bundle, so Windows has no measurement yet (`docs/ROADMAP.md` M8).

```bash
tooling/measure/harness.py all --sites local --app <vanilla app> --out docs/perf/<date>-vanilla-<config>-local.json
tooling/measure/harness.py all --sites local --app <Stedding app> --out docs/perf/<date>-<config>-local.json
```

Measure the two builds back to back, at the same pin and in the same configuration.
`tooling/args/vanilla.gn` is identical to `official.gn`; the vanilla app is built from
the checkout detached at the pin, with the branding reverted (`tooling/apply-branding
--revert`), and `build-chromium` checks the tree. `--sites local` (ten
deterministic pages under `tooling/measure/local-sites/`, no network) is the list for
the overhead budgets; the live list (`--sites live`, `tooling/measure/sites.txt`) serves
only the absolute budgets. Each new file names the build, the configuration and the pin
it measured.

## The record of 2026-09-02

Apple M1 Max, 64 GB; both apps built in `official` at 153.0.8010.12, Stedding with the
series of 2026-08-31 (before Peek and the settings section). Both build directories
were deleted afterwards for disk.

| File | What it is |
|---|---|
| `2026-09-02-official.json` | Stedding, live sites, the morning run |
| `2026-09-02-official-rerun.json` | Stedding, live sites, back to back with vanilla |
| `2026-09-02-vanilla-official.json` | Vanilla, live sites, the same afternoon |
| `2026-09-02-official-local.json`, `2026-09-02-vanilla-official-local.json` | The same two apps with `--sites local` |

The deterministic pair (`--sites local`), medians and spreads, overhead =
(Stedding − vanilla) / vanilla:

| Measure | Vanilla | Stedding | Overhead | Budget |
|---|---|---|---|---|
| Cold startup to first paint | 0.65 s (0.57–0.82) | 0.66 s (0.64–0.87) | +2.3% | within 10% |
| Warm startup, ten local pages restored | 0.79 s (0.77–0.93) | 0.78 s (0.70–0.96) | −2.0% | within 10% |
| Physical footprint, ten local pages after 60 s idle | 823 MB (821–825) | 823 MB (819–824) | +0.0% | within 10% |

The live pair, back to back:

| Measure | Vanilla | Stedding | Overhead | Budget |
|---|---|---|---|---|
| Cold startup to first paint | 0.67 s | 0.76 s | +12.2% | over 10% |
| Warm startup, ten tabs restored | 0.78 s | 0.77 s | −0.6% | within 10% |
| Physical footprint, ten tabs after 60 s idle | 1.26 GB | 1.71 GB | +35.9% | over 10% (20 and 35 processes) |

The live pair's two misses were put down to third-party frames and machine state, since
the deterministic pair shows none, and `S-37` was closed on that reading. The live
memory swings widely with the sites: the morning run of the same Stedding build summed
5.7 GB over about 107 processes. The difference in process count between the pair was
not explained. Of the six budgets, three were measured; sidebar tab switching and the
command bar have no measurement in the harness.
