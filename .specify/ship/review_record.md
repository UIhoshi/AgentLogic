# V6.8.1 Version Consistency Repair — Shipping Review

## Scope

This is a portable logic-package and build-validation change. It has no application
database, user authorization model, secrets, network provider call, scheduled job, or
UI surface. `permissions.md` and `variables.md` are therefore not applicable.

## Architecture and Flow

`manifest.json` selects the current version and default profile. `build-profile.ps1`
assembles that profile into each configured host bundle. `validate-package.ps1` checks
the manifest and profiles, validates V6.8 operational requirements, and verifies that
each tracked bundle equals a fresh in-memory build. Install adapters run validation
before writing host-local targets.

## Risks and Self-Refutation

- **Bundle drift could evade validation.** Evidence: prior maintainer generation changed
  tracked `dist/` files while package validation passed. Counter-argument: headers were
  already version-correct. Residual risk remains because header checks do not compare full
  generated content; the new exact verification addresses it.
- **A V6.8.1 patch could skip Module 44 checks.** Evidence: the old condition matched
  only `V6.8.0`. Counter-argument: the module is still in the default V6.8.1 profile.
  Residual risk remains for accidental future removal; the V6.8 prefix condition addresses
  the current release family.

## Verification Plan

- Run logic-entry, package, and maintainer checks.
- Confirm all configured bundles pass non-mutating verification.
- Inspect the final diff and working-tree status before the local commit.

## Verification Results

- The non-mutating verifier failed against the pre-regeneration Codex bundle, confirming
  that it detects stale output.
- All four bundles were regenerated and each passed `build-profile.ps1 -Verify`.
- `node scripts/check-logic-entry.js`, `scripts/validate-package.ps1`, and
  `scripts/maintainer-check.ps1` passed after the repair.

## CI Follow-up

GitHub Actions run `29645724052` rejected the committed bundle as stale even though local
validation passed. The runner used Windows PowerShell; the remaining load-bearing cause is
host-dependent line endings from `StringBuilder.AppendLine()` and code-page-dependent decoding
of UTF-8 source files by Windows PowerShell. The repair canonicalizes the complete generated
bundle to LF and explicitly decodes source inputs as UTF-8 before write and comparison.

The regenerated `codex`, `claude`, `antigravity`, and `generic` bundles contain no carriage
return bytes and all pass the non-mutating verifier, package validator, logic-entry check, and
maintainer check locally.
