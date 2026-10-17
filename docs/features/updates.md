# Feature: Updates

Status: **Up1–Up13 built** in patch `0068` (2026-10-16): both platforms' suites pass, and
the Mac's n-1 check passed on two Developer-ID-signed builds, and from the released beta 16
to the 156 build (docs/HANDOFF.md, "The updater"). The first update through the real feed
waits for the release after the first one built with the updater (BACKLOG S-74). On
Windows only Up9–Up11 apply (no updater there yet).
Owner docs: `docs/decisions/0022-sparkle-updates-the-mac.md`, `docs/decisions/0023-updates-on-windows-and-linux.md`
(Windows and Linux, planned), `docs/PRIVACY.md` (the update check), `docs/QUALITY.md` (rollback).
Patch: `0068`.

Stedding updates itself on the Mac the way Arc does: it checks once a day, downloads a new
version in the background, and shows "New Stedding Version Available" at the sidebar's foot;
a click restarts into it, and quitting installs it otherwise. Sparkle 2 does the work
(ADR 0022), driven by the browser: no Sparkle window opens, and what it does shows in the
sidebar, the command bar, the About page and the app menu. After the install and after each
update the browser opens one thank-you page on stedding.dev.

How it fits together:

- `tooling/fetch-sparkle` puts Sparkle 2.10.0 at `third_party/stedding_sparkle/` in the
  checkout; `tooling/build-chromium` runs it and sets `stedding_sparkle = true`, and
  `chrome/BUILD.gn` bundles the framework into `Contents/Frameworks`. Chromium's signer signs
  its helpers and the framework before the app (`chrome/installer/mac/signing/parts.py`).
- `chrome/app/app-Info.plist` names the feed and the public key; `CFBundleVersion` carries
  Stedding's version (Up11).
- `stedding::AppUpdater` (`chrome/browser/ui/stedding/app_updater.h`) is the one interface;
  `app_updater_mac.mm` loads Sparkle at runtime and is its user driver and delegate.
- `tooling/publish-appcast` offers a release: it signs the image and writes and signs
  `updates/appcast.xml`, which Sparkle reads from `main`.

Windows and Linux are planned, not built (ADR 0023, 2026-10-16). Windows gets the browser's
own updater behind the same `stedding::AppUpdater`, reading a feed of its own,
`updates/appcast-windows.xml`, signed with the same key (`S-215`, after the installer's
version numbers, `S-72`). On Linux the package system updates Stedding, and the pill follows
what Chromium's upgrade detector sees (`S-216`). `updates/appcast.xml` stays the Mac's alone.

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| Up1 | With "Update Stedding automatically" on (Settings › Stedding › Updates, the default), Sparkle checks the signed feed ten seconds after launch when a day has passed since the last check, then once a day, and downloads a later version in the background; quitting installs it. The setting is the browser's (`stedding.updates.automatic`, local state) and sets Sparkle's own two each launch. | live, 2026-10-16: the n-1 check (docs/HANDOFF.md, "The updater"): the older build fetched the local feed ten seconds after launch and the image right after, with no window of Sparkle's | built |
| Up2 | No Sparkle window, alert or permission prompt ever opens: the browser is Sparkle's user driver and shows its state itself. Sparkle sends nothing about the machine (no system profile, no feed parameters). | live, 2026-10-16: the n-1 check, from launch to relaunch | built |
| Up3 | While a downloaded version waits, the sidebar's foot shows "New Stedding Version Available", above the Space row, in the selected tab's colours; its tooltip names the version. A click restarts into it: the browser saves the session as a restart does, Sparkle installs while the browser is closed and opens the new version, and the session comes back. The rail shows the pill's icon alone, named for VoiceOver. A quit the browser cancels ("Leave site?", a download) brings the pill back after 20 seconds, and its next click asks again. | unit: `UpdatePillTest.ShowsWhileAVersionWaitsAndRestartsOnClick`, `UpdatePillTest.TheRailShowsTheIconAlone`; browser: `UpdatesTest.ThePillShowsAboveTheSpacesAndRestarts` (it sits on the tab rows' column: the first live check drew it from edge to edge); live, 2026-10-16: the n-1 check, about twenty seconds after launch the pill showed, a press quit the older build cleanly and opened the newer one with its tab back; the same that evening from the released beta 16 to the 156 build, the new version running a second after the press | built |
| Up4 | A version Sparkle found but could not install alone (installing it needs an administrator's password: the app is not the user's to replace) shows the same pill; a click downloads it, asks for the password, and restarts. While restarting the pill reads "Restarting…" and takes no click. | unit: `UpdatePillTest.AvailableShowsThePillAndInstallingGreysIt` | built |
| Up5 | chrome://settings/help checks when it opens while automatic updates are on, as Chrome's does, and shows Checking, Updating (with the download's percentage), Nearly up to date with Relaunch, Up to date, or the failure in Sparkle's words; a later version found there downloads at once. Relaunch restarts through the updater, never through Chromium's own relaunch, which would open the old bundle while Sparkle replaced it. The failure line has no "Learn more" link: that was Google's page about Google Update. | browser: `UpdatesTest.AboutsRelaunchRestartsThroughTheUpdater`, `UpdatesTest.AboutChecksOnlyWithAutomaticUpdatesOn` | built |
| Up6 | With automatic updates off the browser does not start Sparkle at all and makes no update request; the About page says "Automatic updates are off. To look for a new version now, choose Stedding › Check for Updates…". A version already downloaded before the switch went off still installs at the quit. | browser: `UpdatesTest.AboutChecksOnlyWithAutomaticUpdatesOn`; unit: `SteddingPrefsTest.TheBrowserWidePreferencesRegisterWithTheirDefaults` | built |
| Up7 | The command bar lists "Restart to Update Stedding" while a version waits, and "Check for Updates" wherever the build has an updater; Check for Updates asks now, whatever the setting, and opens the About page with the answer. | browser: `UpdatesTest.TheCommandBarRestartsAndChecks` | built |
| Up8 | The app menu has Stedding › Check for Updates… under About Stedding, as Mac apps put it: it checks now, whatever the setting, and opens the About page. It is enabled only where the build has an updater. | live, 2026-10-16: on the signed build the item sits under About Stedding, enabled, and choosing it fetched the feed and opened About with "Stedding is up to date" | built |
| Up9 | After a fresh install, when the welcome flow is finished or skipped, the browser opens <https://stedding.dev/thanks/> in one tab: thanks, and an invitation to sponsor the project on GitHub. Once per installation (`stedding.updates.thanks_after_install_shown`), not for a second profile's welcome, and never for a welcome forced by `--stedding-welcome` (the captures) or on a build with no version. | unit: `ThanksPagesTest.TheInstallPageOpensOnce`; browser: `UpdatesTest.TheWelcomeFlowsEndOpensTheInstallsPage` | built |
| Up10 | The first window of a later version opens <https://stedding.dev/thanks/updated/#v>*version* in one tab: thanks, that version's release notes, and the sponsor link. The version rides in the fragment, which the browser never sends. Once per version: the version that ran is recorded in local state (`stedding.updates.last_run_version`) every launch. Never for an older or unreadable version, under `--no-first-run`, on the install's own first run (its page comes with the welcome flow), or with "Show a thank-you page after an update" off (Settings › Stedding › Updates; on by default). A profile from before versions were recorded counts as updated. On Windows it follows an update installed by hand. | unit: `ThanksPagesTest.ALaterVersionOpensTheUpdatePageOnce`, `ThanksPagesTest.NoRecordedVersionIsAnUpdateUnlessWelcomeIsToCome`, `ThanksPagesTest.TheUpdatePageStaysClosedWhenItShould`, `ThanksPagesTest.TheUpdatePageNamesTheVersionInItsFragment`; browser: `UpdatesTest.ALaterVersionOpensTheThanksPageOnce`, `UpdatesTest.TheSettingKeepsTheThanksPageClosed` | built |
| Up11 | Stedding's versions are VERSION's and the tags' shape, `<major>.<minor>.<patch>[-beta.<n>]`, ordered with each beta before its release. On the Mac `CFBundleVersion` carries it as `<10000 + 1000·major + 10·minor + patch>.<n>`, with 999 for a release (0.2.0-beta.16 is 10020.16), so Sparkle and LaunchServices order versions as the releases do, above the Chromium build numbers (8059.12) earlier betas carried. A version past that room (minor over 99, patch over 9) stops the build. | unit: `SteddingVersionTest.VersionsCompareInReleaseOrder`, `SteddingVersionTest.OtherStringsAreNotVersions`; `tooling/publish-appcast --check` reads the image's `CFBundleVersion` | built |
| Up12 | An update installs only if its image is signed with the project's EdDSA key, checked before it is unpacked, and comes from a feed signed with the same key; an entry Sparkle marks as from a feed whose signature failed, or an informational entry, is never offered. Only a bundle signed by a team runs the updater: a build made locally (signed ad hoc) never replaces itself with a release. | live, 2026-10-16: the n-1 check (image and feed signed with the key, the newer app's signature verifying after the install); the ad hoc `out/release` build started no updater. A tampered feed has not been tried | built · a tampered feed not yet tried |
| Up13 | A release is offered by `tooling/publish-appcast` after `tooling/publish-release`, once tried as a user gets it: it refuses an image that is not the release's or whose app has no updater, another key, or another `CFBundleVersion`; the feed keeps the newest five releases; it commits the feed, and `--push` publishes it. Rolling back is releasing a later version (`docs/QUALITY.md`). | `python3 tooling/appcast.py selftest`; `tooling/publish-appcast --check` | built |
