# Review Record — Portable Skill Deduplication and Activation Metadata

## Scope

- Added explicit, validated activation metadata for all 116 portable skills.
- Added a read-only duplicate-candidate audit and activation-metadata regression tests.
- Rebuilt all four generated `core-enhanced` host bundles.

## Implemented reality

- Lifecycle remains `mandatory`/`conditional` only for the existing 6 routed records; their
  `route_candidate` trigger lists are derived from `contracts/skill-routing.json`.
- All 110 `manual_only` records are explicitly `manual` and use controlled selection conditions.
- SHA-256 and YAML-front-matter-name audit found no duplicate candidates; no skill file was
  removed by this task.

## Self-refuted findings

| Potential concern | Evidence | Counter-argument | Status |
| --- | --- | --- | --- |
| Manual metadata could silently auto-enable a security or CTF skill. | Registry validator requires non-routable records to use `manual`; reverse-skill records use authorization and isolated-environment conditions. | Metadata alone does not add a routing-contract entry or permit invocation. | Cleared / verified statically. |
| Similar skills may have been deleted without proof. | Duplicate audit found no exact-content or duplicate-name candidates. | Hash/name equality is only candidate evidence; Module 35 still requires full equivalence review. | Cleared / verified. |
| Registry triggers could drift from automatic routes. | Regression test corrupts a routed trigger and the validator rejects it. | Routing itself was not changed; validation confirms all existing 10 routes remain valid. | Cleared / verified. |
| Generated bundles could be stale. | All four bundles rebuilt, then package and maintainer verification passed. | Bundle verification checks profile-derived output, not host-runtime behavior. | Verified for generation; no host-runtime claim made. |

## Validation

- `scripts/audit-skill-duplicates.ps1`: 116 entries; no exact-content or duplicate declared-name candidate.
- `scripts/validate-skill-registry.ps1`: pass.
- `scripts/test-skill-registry.ps1`: pass.
- `scripts/validate-skill-routing.ps1`: pass (10 routes).
- `scripts/test-skill-enforcement.ps1`: pass.
- `node scripts/check-logic-entry.js`: pass.
- `scripts/validate-package.ps1`: pass.
- `scripts/maintainer-check.ps1`: pass.

## Known boundary

An unrelated pre-existing deletion under `skills/reverse-skill/.../payloader/tools/` remained
untouched and is not part of this change.