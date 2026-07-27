# Shipping Review — Affordance Routing and Context Optimization

## Delivered behavior

- `modules/51_V6_8_AffordanceFirstToolUse.md` defines the normal reflex:
  intent → needed evidence/artifact → native tool family → specialist when useful → closure.
- `core-enhanced` is now the lean default execution profile; `governance-reference` retains the
  former broad governance set for deep audit and policy maintenance.
- The package/install route now permits disclosed native validation when the release specialist is
  unavailable; strict evidence, UI, security, and untrusted-extension routes remain strict.

## Context-size comparison

| Profile state | Files | Characters | Lines |
| --- | ---: | ---: | ---: |
| Previous `core-enhanced` | 47 | 281,520 | 6,581 |
| Optimized `core-enhanced` | 25 | 171,260 | 3,170 |
| Reduction | 22 | 110,260 (39.2%) | 3,411 (51.8%) |
| `governance-reference` | 48 | 287,389 | 6,670 |

## Self-refutation

| Risk | Counter-check | Status |
| --- | --- | --- |
| Lean profile loses required controls | It retains entry, permissions, verification, SDD, UI, shipping, project sync, routing, and both contracts; package validation passed | Cleared |
| Fallback weakens strict routes | Only `package-release` permits the native evidence fallback; Module 49 keeps strict routes and missing required evidence blocked | Cleared |
| Reference content was deleted | The full prior source set is retained under `governance-reference` and was built for all four hosts before cleanup | Cleared |
| Host still uses the pre-optimization bundle | Codex was reinstalled after rebuild; the installed bundle reports V6.8.4 | Cleared |

## Validation

- `node scripts/check-logic-entry.js` — passed.
- `scripts/validate-package.ps1` — passed.
- `scripts/maintainer-check.ps1` — passed.
- `git diff --check` — passed.

## Publication boundary

No commit, push, release, or GitHub synchronization was performed.

## Audit remediation
- Resolved the UI-preview scope conflict: net-new/substantial UI uses preview approval; clear small corrections may skip only the mockup and still require visual proof; ambiguous scope uses the full gate.
- Restored Module 27 to the default execution profile because Module 51 depends on its risk gates.
- Made CODE_MAP.md readable UTF-8 and added mechanical UTF-8/control-character validation to scripts/check-logic-entry.js.
