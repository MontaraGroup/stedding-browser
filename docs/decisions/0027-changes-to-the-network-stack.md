# 0027 — Three changes to the network stack, and the rule for the next one

Status: Accepted
Date: 2026-10-21

## Context

`docs/ARCHITECTURE.md` says the series avoids the engine (`net/`, `services/`, `content/`,
Blink, V8) and that an engine patch needs an ADR. By 0.3.0 beta 1 the series changes the
network stack in three places, none of which had one:

1. **The root store's version rules** (patch 0073, `S-72`). Windows builds carry Stedding's
   own product number in `chrome/VERSION` so the installer can update itself; the certificate
   verifier's root store rules, the Web Store, Safe Browsing, GCM, sync, OAuth, image search
   and DIAL read Chromium's version instead, so a server that keys on the browser's version
   sees the Chromium it expects.
2. **Chrome's launched defaults** (patch 0074, `S-236`, `S-237`, `S-240`): features Chrome
   turns on for all its users through its field trials, Google's key pins, and Certificate
   Transparency, with none of Chrome's certificate reports.
3. **The certificate verifier's change notices** (patch 0077, `S-251`). The service told the
   network context of every change of its setup, and the context dropped every idle socket and
   every connect in progress, plain http included. Two such changes arrive in the first second
   of a launch, before anything has been verified, so the connections opened ahead for tabs
   given on the command line were dropped and could fail to load. The service now passes a
   change on only once it has verified a certificate.

## Decision

The three stay, each in the patch that carries it, with its header naming the reason and the
tests that fail without it. Each is small, sits at an edge of the stack (version strings
handed out, feature defaults, one notification gate), and leaves the stack's own logic as
Chromium wrote it.

The rule for the next change: one goes into `net/` or `services/network/` only for a fault
a user can see or a privacy promise (`docs/PRIVACY.md`), with an upstream bug or a reason it
is Stedding's alone, a test that fails without it, and a line in this file's list. A
behaviour Chromium would plausibly take upstream is reported there as well.

## Consequences

- Each pin move re-applies these hunks. A conflict in one of them is resolved by reading the
  upstream change first, not by forcing the old hunk.
- Patch 0077's gate means a profile's very first change of verifier setup never reaches the
  network context. Nothing exists then that it could make stale, and every later change is
  passed on as before. An https address given on the command line still sees the second
  change, once its connect has verified a certificate.
- `docs/ARCHITECTURE.md`'s paragraph on the network stack points here.
