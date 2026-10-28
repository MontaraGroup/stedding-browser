# 0017 — Privacy defaults are preference defaults, in one block

Status: Accepted
Date: 2026-09-05

## Context

[PRIVACY.md](../PRIVACY.md) promises defaults Chromium does not ship with. Two ways to ship one: change the value where Chromium registers the preference, or write the value into every new profile. A written value is user-set, so Chromium’s settings no longer show it as the default, and profiles that already exist need a migration. A new registered default leaves a choice the user already made.

Blocking third-party cookies breaks some sign-in flows and embedded widgets.

## Decision

These are registered defaults of Chromium’s own preferences, in patch 0030 ([privacy.md](../features/privacy.md)):

- Third-party cookies are blocked in normal windows. `profile.cookie_controls_mode` is Block third-party. Chromium blocks them in Incognito only. Q1.
- HTTPS-First balanced mode is on (`https_first_balanced_mode_enabled`). Q2.
- “Show Stedding’s own error pages” is on. The switch is inverted on `alternate_error_pages.enabled`, which defaults to false. Q3.
- Quiet notification and geolocation prompts are on, and the adaptive (CPSS) choice of those settings is off. The settings page treats the two as one control and checks they are never both on. Q5.
- Search suggestions are off (`search.suggest_enabled`). Q7.

Global Privacy Control has no Chromium preference. It is the local-state preference `stedding.privacy.gpc`, on by default, and it turns on Chromium’s `GlobalPrivacyControlForce` at startup. A change applies after a restart. Q4.

Topics, Protected Audience and Attribution already default off in Chromium. Stedding does not turn them on. Q6.

Q1 is one menu. Q2, Q3, Q4 and Q7 are one switch each. Q5 is two switches, for notifications and for geolocation. Q6 is a text row with no switch. The protective choice is the default. A row that binds a Chromium preference is not a `stedding.*` preference. Settings T2 lists Stedding’s own toggles, and several of those start off. The third-party-cookie row says “If a site breaks, the eye in the address row allows them there” (patch 0109).

## Consequences

A profile Stedding creates gets these defaults with no migration. A profile that already set one of them keeps that choice.

[PRIVACY.md](../PRIVACY.md) is the list of defaults. [privacy.md](../features/privacy.md) is the test per row. Rows from Q9 on are later cuts, not more registered-default flips of this decision.
