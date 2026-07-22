# Ship Review — Autonomous Skill Enforcement

## Scope

Adds a canonical capability registry, strict missing-capability policy, UI discovery-before-image
contract, explicit code-review route, software-candidate review queue, validator, and regenerated
host bundles.

## Evidence

- `node scripts/check-logic-entry.js`: passed.
- `scripts/validate-skill-routing.ps1`: passed with 8 required routes.
- `scripts/validate-package.ps1`: passed and verified all four generated bundles.
- Codex installation rerun and installed bundle contains `Autonomous Skill Enforcement`.
- `git diff --check`: passed.

## Self-refute review

| Finding / assumption | Counter-check | Status |
| --- | --- | --- |
| Registry enforces actual skill invocation | Static registry validation cannot observe model/tool invocation | Retained as a documented limitation; invocation records and evidence are mandatory, not claimed as mechanically proven. |
| Host aliases prove a capability exists | Alias strings can be semantically mismatched or unavailable | Module 49 explicitly treats aliases as candidates requiring availability and fit confirmation. |
| Candidate registry approves software | Candidate entries contain no install commands and state `review-required` | Verified; no external software or skill was installed by this change. |
| UI gate is too broad for small fixes | Module 49 preserves a classified small-correction path while requiring visual verification | Mitigated. |

## Security / permissions

No secrets, user authorization, database schema, network endpoint, or new runtime permission was
introduced. The change adds policy and deterministic local validation only. External GitHub
candidates remain untrusted until a pinned-version security audit and explicit user decision.

## Remaining limitation

This is enforceable at the rule, registry, and validation-contract layers, not a host-level event
interceptor. A future host integration could collect invocation telemetry, but must not be claimed
as present now.

## Post-push audit correction

The first shipping review found that Module 49 referenced the canonical registry and software candidate directory, but neither asset was profile-bundled. Add both to enhanced profiles so installed hosts retain the routing data and candidate directory without relying on the source checkout.
