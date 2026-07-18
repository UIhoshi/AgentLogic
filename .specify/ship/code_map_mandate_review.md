# Shipping Review: Mandatory Textual Code Map

## Scope

V6.8.2 project knowledge-sync rules now require tracked `CODE_MAP.md` as the text-first,
symbol-level handover map. Visual Graphify output remains optional and consent-gated.

## Evidence

- `templates/CODE_MAP.md` defines bounded entrypoint, symbol, state, interface, validation, and
  freshness sections.
- Module 46, entry/enforcement, SDD, master-map, Graphify, version, README, manifest, and package
  validation rules carry the contract.
- All generated host bundles were rebuilt by `scripts/build-profile.ps1`.

## Self-refute

- Concern: a mandatory map becomes stale documentation. Counter-evidence: the template requires a
  reviewed commit marker and same-commit updates for affected ownership/state/interface changes;
  it explicitly remains non-proof.
- Concern: visual graph tooling becomes mandatory. Counter-evidence: Module 45 remains
  user-approved and optional, and no Graphify package or output is bundled.

## Validation

- `node scripts/check-logic-entry.js` — passed.
- `scripts/validate-package.ps1` — passed.
- `scripts/maintainer-check.ps1` — passed.

## Status

Verified for package structure and generated-bundle consistency. The policy is a documentation
contract; individual business projects still need current source and runtime evidence.
