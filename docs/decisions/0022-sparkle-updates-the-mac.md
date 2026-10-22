# 0022 — Sparkle updates the Mac, from a signed feed in this repository

Status: Accepted
Date: 2026-10-16
Partly supersedes: 0014 (the check's endpoint and its default; the site staying
off the update path stands)

## Context

ADR 0014 chose GitHub Releases as the update channel and left applying updates
to M7, with signing. The Mac's image has been signed and notarized since beta 10,
so an update can be verified before it replaces the app. On 2026-10-16 the owner
asked for automatic updates "like Arc": on by default, downloaded in the
background, a "New Stedding Version Available" button at the sidebar's foot, and
a restart into the new version. The same day the owner chose Sparkle 2 for it,
and asked for a thank-you page on stedding.dev after the install and after each
update.

ADR 0014's own endpoint does not fit. `/releases/latest` returns only full
releases, and every Stedding release so far is a pre-release. The Releases API
cannot carry what an updater must check before it installs anything: a
signature over the image made with a key only the project holds.

## Decision

- **Sparkle 2 (2.10.0, MIT) applies updates on the Mac.** `tooling/fetch-sparkle`
  takes the release archive, checked against the digest GitHub publishes for it,
  and the build bundles `Sparkle.framework` without its XPC services (they are
  for sandboxed apps). The browser drives Sparkle through its own user driver:
  no Sparkle window ever opens; the sidebar, the command bar, the About page and
  the app menu show what it is doing (`docs/features/updates.md`).
- **The feed is a file in this repository**, `updates/appcast.xml`, read from
  `main` on `raw.githubusercontent.com`. Still GitHub, still no server of ours.
  `tooling/publish-appcast` writes it after a release; the release's image is
  the download. Each image is signed with the project's EdDSA key and the feed
  is signed too (`SURequireSignedFeed`, `SUVerifyUpdateBeforeExtraction`): a
  change to the repository or a tampered download cannot get anything installed
  that the key did not sign. The private key lives in the release machine's
  keychain and in the owner's backup, never here.
- **On by default** (the owner, 2026-10-16), checked once a day, with a switch in
  Settings › Stedding › Updates. Since the owner's decision of 2026-10-21 it checks at
  a launch more than an hour after the last check and every six hours
  (`docs/features/updates.md` Up1). Off, the browser does not start Sparkle at all,
  so it makes no update request until the user chooses Check for Updates.
- **A locally built copy never updates itself.** Only a bundle signed by a
  team (a release, or a test build signed the same way) starts the updater, so
  a development build cannot be replaced by a release at its next quit.
- **The thank-you pages are on stedding.dev and are not on the update path.**
  If the site is down, the update still installs; only the page fails to load.
  The update's page carries the version in the URL's fragment, which the
  browser never sends; the pages load nothing from another host.
- **Windows is not covered yet.** Its installer needs version numbers Sparkle's
  counterpart there can compare (`BACKLOG.md` S-72) and its own mechanism.

## Consequences

- One more kind of request leaves the browser by default: a daily GET of the
  feed from `raw.githubusercontent.com`, and the image from `github.com` when one
  is newer. `docs/PRIVACY.md` names both, and the two pages.
- The release gains a step: offering it (`tooling/publish-appcast --push`) after it
  has been tried as a user gets it. Not offering a release is a way to hold it.
- Sparkle never downgrades. Rolling back means releasing a later version
  (`docs/ROADMAP.md#the-quality-bar`).
- `CFBundleVersion` now carries Stedding's version (10020.16 for 0.2.0-beta.16),
  not Chromium's build number, because Sparkle and LaunchServices compare it.
- A fork that keeps this feed URL and key would be updated to this project's
  releases. A fork changes both (`chrome/app/app-Info.plist`).
