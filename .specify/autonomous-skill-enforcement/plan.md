# Plan — Autonomous Skill Enforcement and Software Candidate Registry

## Design

- Keep Modules 29–31 authoritative for evidence strength. Add Module 49 as the mandatory
  orchestration and closure contract rather than duplicating verification rules.
- Store canonical routes in `contracts/skill-routing.json`. Canonical capabilities map to
  host-specific aliases; aliases are capabilities, not proof of installation.
- Add `scripts/validate-skill-routing.ps1` to validate registry structure and cross-reference the
  profile-shipped Module 49. Invoke it from package validation.
- Update Modules 35, 39, 43, and 48 only at their integration boundaries: mandatory code review,
  UI discovery-before-image, and canonical routing reference.
- Store recommendations in `docs/software-candidates.md`; it is a review queue, never an install
  script or endorsement of an unreviewed binary.

## Red-Team Review

| Assumption | Counter-argument | Mitigation |
| --- | --- | --- |
| A strict missing-capability block improves quality | It can stop harmless work when a host has an equivalent skill under another name | Canonical aliases allow host-specific equivalents; only mandatory routes block, and the result must explain the gap. |
| A UI grilling gate improves collaboration | It can burden typo-level visual fixes | Limit it to net-new/substantial UI work; small corrections retain visual verification without forced image generation. |
| JSON makes routing enforceable | A validator cannot prove an LLM invoked a skill | Require an invocation record in task state and use validation to prevent malformed or incomplete route declarations; do not overclaim runtime enforcement. |
| Candidate lists help decisions | A list can be mistaken for approval | Mark every entry `review-required`, pin exact release/commit at decision time, and prohibit auto-install. |

## Tasks

1. Add the registry, enforcement module, and candidate registry.
2. Update routing/UI/grilling/skill-governance integration points and active version references.
3. Add deterministic registry validation and connect it to package validation.
4. Rebuild bundles, run validation, and perform code review of changed scripts/docs.

## Extension approach

- Add a concise first-party skill under `skills/productivity/product-requirements-grilling` with a
  brief template, rather than modifying the audited generic source skill.
- Add `scripts/validate-requirements-brief.ps1` for deterministic section and approval checks.
- Deploy the skill through the Codex adapter; do not copy third-party skill directories.
- Update Module 49 and the routing registry to distinguish new/UI-idea mockup consent from
  existing-layout dissatisfaction, which first requires screenshot evidence and a change brief.
