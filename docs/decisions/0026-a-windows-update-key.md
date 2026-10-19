# 0026 — Windows updates are signed with a key of their own, kept on the Windows PC

Status: Accepted
Date: 2026-10-19
Partly supersedes: 0023 (its "one key" rule for Windows; the rest of 0023 stands)

## Context

ADR 0023 planned the Windows updater (`S-215`) with one signing key for every platform: the
EdDSA key in the release Mac's keychain would sign the Windows installers too, and the Mac
would write the Windows feed after the PC published. Since beta 13 the Windows installer has
been built, tried and published from the Windows PC, which cannot reach the Mac; every Windows
update would then wait for the Mac to sign it, and the PC could not test an update end to end
with the key its builds trust.

On 2026-10-19 the owner chose, among the two, a key of the Windows PC's own.

## Decision

- **A separate Ed25519 key signs Windows updates.** It is made and kept on the Windows release
  PC by `tooling/win/update-key.ps1`: the private key as encrypted PKCS#8 (AES-256), its
  passphrase protected by Windows' DPAPI for the operator's account on that machine, both
  under `%USERPROFILE%\.stedding\update-key`, never in this repository and never in AppData
  (trap 40). The operator keeps a backup (`update-key.ps1 -Backup`), apart from the PC.
- **Every Windows build carries that key's public half** and trusts nothing else: the feed's
  signature and the installer's are both checked against it. The Mac's key and feed are
  untouched; a Mac build never trusts the Windows key, nor a Windows build the Mac's.
- **The PC publishes Windows updates alone.** `tooling/win/publish-appcast.ps1` signs the
  release's installer and the feed, `updates/appcast-windows.xml`, after
  `tooling/publish-release`, the same way `tooling/publish-appcast` does on the Mac.

## Consequences

- Two keys to keep instead of one. A stolen Windows key can sign Windows updates and nothing
  else; replacing it means a release, installed by hand, that carries the new public key.
- A Windows release no longer waits for the Mac, and the PC can run the n-1 check with a local
  feed signed by the real key.
- The rest of ADR 0023 stands: the browser's own updater behind `stedding::AppUpdater`, a
  Sparkle-format feed, the installer run silently beside the running browser, the version
  numbers of `S-72`.
