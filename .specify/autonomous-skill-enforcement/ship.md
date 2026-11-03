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

## Product requirements extension

Adds the first-party `product-requirements-grilling` skill, structured requirements brief template, brief validator, and Codex deployment. The workflow requires a user-approved substantive brief before a UI mockup or UI implementation; existing-layout revisions record a current screenshot and the user's dissatisfaction before image editing.

## Ordered-routing audit

- Static review initially found a trust-boundary flaw: `untrusted_extension` shared the generic
  source-security route, which could make `security-best-practices` appear to substitute for the
  required external-skill audit. The final registry has a separate `extension-security-review`
  route with `skill-security-auditor` as its primary capability.
- UI mockup generation and UI implementation are separate routes. The validator rejects a registry
  that lists `senior-frontend` as a UI mockup provider.
- Remaining limitation: ordered aliases are an auditable selection contract, not host telemetry;
  invocation evidence remains required.

## Cross-host routing repair

The audit found that only Codex received the mandatory first-party requirements skill, and that legacy Modules 35/48 named conflicting mandatory skills. All adapters now deploy the skill, the installer verifies its exact path, a host deployment contract is profile-shipped, and legacy modules defer concrete mandatory choices to schema-v2 routing.

## Installation smoke correction

A cross-host smoke test also found and fixed Antigravity's compatibility-hook backup conflict. Its default compatibility hook is now a protected post-install target. First-party requirements skills are classified keep-active by skill governance rather than manual-review.
