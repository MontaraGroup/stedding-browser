# Security Policy

## Reporting a vulnerability

Please report vulnerabilities through **GitHub private vulnerability reporting** on
this repository: go to the **Security** tab and click **Report a vulnerability**.
This creates a private advisory visible only to you and the maintainers.

Please do not open public issues for security problems, and do not report them by
email or social media — the Security tab is the only monitored channel.

A good report includes:

- What is affected (file, document, or component and version).
- Steps to reproduce, or a clear explanation of the flaw.
- Impact as you understand it.

## Response expectations

This is a small project without a dedicated security team. Honestly stated:

- We aim to acknowledge reports within **7 days**.
- Triage and a fix timeline depend on severity and maintainer availability; there is
  no guaranteed SLA.
- We will keep you informed inside the private advisory and credit you in the fix
  (unless you prefer otherwise).

## Scope

Stedding ships beta binaries on
[Releases](https://github.com/ysalitrynskyi/stedding-browser/releases): a macOS image
(Apple silicon), signed and notarized, and an unsigned Windows x64 preview.
Anything in one of those builds is in scope:

- The Stedding patch series on top of Chromium (`patches/`) and the branding applied to
  the build — our code, our bugs.
- The release and supply-chain setup: CI, the release scripts in `tooling/`, the
  checksums published beside each image, and the update mechanism (the signed feeds,
  `updates/appcast.xml` for the Mac and `updates/appcast-windows.xml` for Windows, and the
  scripts that write them, `tooling/publish-appcast` and `tooling/win/publish-appcast.ps1`).
- The contents of this repository, including documentation that would lead a user into
  an unsafe configuration.

Two things about the current builds that are not vulnerabilities, because they are
documented properties of a beta:

- **The Windows installer is not code-signed** (`BACKLOG.md` S-56). SmartScreen asks
  once, and the release notes give the step: **More info → Run anyway**. The macOS
  image is signed with the project's Developer ID and notarized from 0.2.0 beta 10 on.
- **Safe Browsing does not protect.** The builds carry no Google API key, so the list
  updates are refused and no site gets a warning page (`docs/PRIVACY.md`, `BACKLOG.md`
  S-75).

Both platforms update themselves from a signed feed: the Mac from 0.2.0 beta 16 on and
Windows from 0.2.0 beta 19 on (ADR 0022, ADR 0023, ADR 0026). The Chromium pin is watched
daily (`.github/workflows/upstream.yml`, `tooling/check-pin`) and the rebase timetable is in
`docs/QUALITY.md`.

Vulnerabilities in upstream Chromium should be reported to the
[Chromium security team](https://www.chromium.org/Home/chromium-security/reporting-security-bugs/),
not here — unless the Stedding patch series changes the behaviour, in which case it is
ours.

## Supported versions

Only the newest pre-release for each platform is supported: some releases carry one
platform's image only, so the newest macOS image and the newest Windows installer can
come from different betas. Older betas are superseded on the day a newer one for their
platform is published and receive no fixes; there is no long-term support line, and
there will not be one before 1.0.

| Version | Supported |
|---|---|
| The newest pre-release on [Releases](https://github.com/ysalitrynskyi/stedding-browser/releases) with an image for your platform | Yes |
| Any earlier pre-release | No — install the newest |

`VERSION` at the repository root is the version this tree builds.
