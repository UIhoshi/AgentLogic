# Project Map

## L1 — Entry & Surface
- Entrypoints: `00_START_HERE.md`, `AGENTS.md`, `MAIN.md`, and `README.md`.
- User/API/CLI surfaces: host adapters, `install.ps1`, `install.sh`, and generated `dist/` bundles.

## L2 — Flow & Lifecycle
- Core flows: entry gate → task classification → project/code map consultation or refresh → applicable SDD/verification → profile build.
- State and task lifecycle: `.specify/` contains scoped specification, plan, tasks, and ship records.
- Key modules: `modules/01_MasterLogic.md`, Modules 29–31, 35, 38–39, 41, 44–53.

## L3 — Control & Verification
- Controls: permissions, tool-permission risk gates, extension trust, programming-level skill routing and workflow enforcement, package validation, and entry-gate checks.
- Validation commands: `node scripts/check-logic-entry.js`; `scripts/validate-skill-registry.ps1`; `scripts/validate-skill-routing.ps1`; `scripts/test-skill-enforcement.ps1`; `scripts/validate-package.ps1`; and
  `scripts/maintainer-check.ps1` for release-level changes.

## L4 — Base & Dependencies
- Base assets: `skills/`, `spec-kit/`, `manifest.json`, scripts, and generated `dist/` bundles.
- External comparison sources are policy-only unless explicitly installed and trusted. Requested
  `.docx`, `.xlsx`, and `.pptx` processing routes through OfficeCLI after its separate availability,
  trust, and install gates close.
- `img2threejs` is a review-required optional source candidate for approved reference-image
  reconstruction in interactive 3D webpages; it is not an installed host skill.

## Unconfirmed Points
- [ ] No host-local availability of optional browser, screenshot, security, or profiling skills is
  implied by this repository map.

- Autonomous routing: contracts/skill-routing.json and Module 49 define canonical capabilities, strict gaps, and software-candidate reporting.

- Product/UI discovery: `skills/productivity/product-requirements-grilling/` produces a user-approved requirements brief; `scripts/validate-requirements-brief.ps1` checks it before mockup/UI implementation. The Codex adapter deploys this first-party skill to `.codex/skills/`.

- Ordered skill routing: schema-v3 contracts/skill-routing.json separates primary from conditional skills, splits UI mockup generation from UI implementation, orders dependency closure, records required invocation evidence, and marks persistent-memory/high-impact skills non-default.

- Cross-host requirements and enforcement skill payload: contracts/host-skill-capabilities.json and scripts/deploy-first-party-skill.ps1 require every adapter to deploy and verify product-requirements-grilling; generic output colocates it with the bundle; every adapter also deploys and verifies the workflow-enforcement payload.

- Programming-level skill enforcement: `contracts/skill-registry.json`, `contracts/skill-routing.json`, and `contracts/skill-enforcement.json` define complete portable-skill coverage and stateful route closure. `scripts/skill-enforcement.ps1` validates preflight, invocation, closure, and project Skill Usage records; `scripts/deploy-skill-enforcement.ps1` deploys the verified workflow payload for every host adapter.
