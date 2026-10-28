# 0008 — Proprietary codecs (H.264, AAC)

Status: Accepted. The patent terms are still unwritten.
Date: 2026-08-30

## Context

Upstream leaves `proprietary_codecs` off and `ffmpeg_branding` as `"Chromium"`. VP8, VP9, AV1, Opus and Vorbis play. H.264 and AAC do not. Google Chrome ships those codecs under licences Google holds. A fork does not inherit them. The code is in the tree; two build flags turn it on.

A browser that fails on a large share of the web's video misses the bar in [AGENTS.md](../../AGENTS.md): a technical user should prefer it to Chrome within a day.

## Decision

Ship them. Every file under [`tooling/args/`](../../tooling/args/) sets `proprietary_codecs = true` and `ffmpeg_branding = "Chrome"`, so H.264, AAC, MP3 and the MP4 container decode. [`tooling/verify-build`](../../tooling/verify-build) fails if an H.264+AAC frame does not decode.

The product stays Chromium-branded, with Stedding's name on top ([ARCHITECTURE.md](../ARCHITECTURE.md#branding)). `ffmpeg_branding = "Chrome"` is the codec switch. It does not make the browser Google Chrome, and it does not use a Google licence. The codecs are compiled in. [PRIVACY.md](../PRIVACY.md) has no codec endpoint to list.

Distributing binaries that decode AVC/H.264 and AAC carries patent obligations, administered by Via LA. A local build is not distribution. A published disk image or installer is. Public releases already ship these codecs. Terms and cost are TBD. A superseding ADR records them before the 1.0 checklist in [ROADMAP.md](../ROADMAP.md#the-quality-bar) can pass.

## Consequences

Every Stedding configuration plays H.264 and AAC. The licence is an open cost of shipping.
