# Project Map

## L1 — Entry & Surface
- Entrypoints: `00_START_HERE.md`, `AGENTS.md`, `MAIN.md`, and `README.md`.
- User/API/CLI surfaces: host adapters, `install.ps1`, `install.sh`, and generated `dist/` bundles.

## L2 — Flow & Lifecycle
- Core flows: entry gate → task classification → applicable SDD/verification → profile build.
- State and task lifecycle: `.specify/` contains scoped specification, plan, tasks, and ship records.
- Key modules: `modules/01_MasterLogic.md`, Modules 29–31, 35, 38–39, 41, 44–48.

## L3 — Control & Verification
- Controls: permissions, extension trust, skill routing, package validation, and entry-gate checks.
- Validation commands: `node scripts/check-logic-entry.js`; `scripts/validate-package.ps1`; and
  `scripts/maintainer-check.ps1` for release-level changes.

## L4 — Base & Dependencies
- Base assets: `skills/`, `spec-kit/`, `manifest.json`, scripts, and generated `dist/` bundles.
- External comparison sources are policy-only unless explicitly installed and trusted.

## Unconfirmed Points
- [ ] No host-local availability of optional browser, screenshot, security, or profiling skills is
  implied by this repository map.
