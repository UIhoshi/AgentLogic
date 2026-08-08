# Project Map

## L1 — Entry & Surface
- Entrypoints: `00_START_HERE.md`, `AGENTS.md`, `MAIN.md`, and `README.md`.
- User/API/CLI surfaces: host adapters, `install.ps1`, `install.sh`, and generated `dist/` bundles.

## L2 — Flow & Lifecycle
- Core flows: entry gate → task classification → project/code map consultation or refresh → applicable SDD/verification → profile build.
- State and task lifecycle: `.specify/` contains scoped specification, plan, tasks, and ship records.
- Key modules: `modules/01_MasterLogic.md`, Modules 29–31, 35, 38–39, 41, 44–52.

## L3 — Control & Verification
- Controls: permissions, tool-permission risk gates, extension trust, skill routing, package validation, and entry-gate checks.
- Validation commands: `node scripts/check-logic-entry.js`; `scripts/validate-package.ps1`; and
  `scripts/maintainer-check.ps1` for release-level changes.

## L4 — Base & Dependencies
- Base assets: `skills/`, `spec-kit/`, `manifest.json`, scripts, and generated `dist/` bundles.
- External comparison sources are policy-only unless explicitly installed and trusted.
- `img2threejs` is a review-required optional source candidate for approved reference-image
  reconstruction in interactive 3D webpages; it is not an installed host skill.

## Unconfirmed Points
- [ ] No host-local availability of optional browser, screenshot, security, or profiling skills is
  implied by this repository map.

- Autonomous routing: contracts/skill-routing.json and Module 49 define canonical capabilities, strict gaps, and software-candidate reporting.

- Product/UI discovery: `skills/productivity/product-requirements-grilling/` produces a user-approved requirements brief; `scripts/validate-requirements-brief.ps1` checks it before mockup/UI implementation. The Codex adapter deploys this first-party skill to `.codex/skills/`.

- Ordered skill routing: schema-v2 contracts/skill-routing.json separates primary from conditional skills, splits UI mockup generation from UI implementation, and marks persistent-memory/high-impact skills non-default.

- Cross-host requirements skill: contracts/host-skill-capabilities.json and scripts/deploy-first-party-skill.ps1 require every adapter to deploy and verify product-requirements-grilling; generic output colocates it with the bundle.
