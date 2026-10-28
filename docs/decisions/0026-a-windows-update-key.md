# 0026 — Windows updates are signed with a key of their own, kept on the Windows PC

Status: Accepted
Date: 2026-10-19
Partly supersedes: 0023 (its one-key rule for Windows). The rest of 0023 stands.

## Context

ADR 0023 planned one EdDSA key, kept on the release Mac, for every platform. The Windows installer is built and published on the Windows PC, which cannot use the Mac’s key. On 2026-10-19 the owner chose a key of the Windows PC’s own.

## Decision

- **A separate Ed25519 key signs Windows updates.** `tooling/win/update-key.ps1` makes it and keeps it on the Windows release PC: the private key as encrypted PKCS#8 (AES-256), its passphrase protected by DPAPI for the operator’s account on that machine, both under `%USERPROFILE%\.stedding\update-key`. The private key is never in this repository and never in AppData (trap 40). The operator keeps a backup (`update-key.ps1 -Backup`), apart from the PC.
- **Every Windows build carries that key’s public half** and trusts nothing else. The feed’s signature and the installer’s are both checked against it. The Mac’s key and feed are untouched. A Mac build does not trust the Windows key, and a Windows build does not trust the Mac’s.
- **The PC publishes Windows updates alone.** After `tooling/publish-release`, `tooling/win/publish-appcast.ps1` signs the installer and `updates/appcast-windows.xml`, as `tooling/publish-appcast` does on the Mac.

## Consequences

- Two keys to keep. A stolen Windows key can sign Windows updates and nothing else. Replacing it means a release, installed by hand, that carries the new public key.
- A Windows release does not wait for the Mac. The PC can run the n-1 check against a local feed signed by the key its builds trust.
- The rest of ADR 0023 stands: the browser’s own updater behind `stedding::AppUpdater`, a Sparkle-format feed, the installer run silently beside the running browser, and the version numbers of `S-72`.
