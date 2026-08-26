# Changelog

## V6.8.7 — 2026-08-27

### Added
- Product-first automatic skill workflow for substantial website/UI work: requirements, design direction, mockup approval or opt-out, implementation, behavior testing, browser and visual verification, review, and handover.
- Workflow-graph contract, complete portable-skill catalog (116 skills), route-state validation, and durable artifact hash evidence.

### Changed
- Mandatory routes choose a verified available primary or conditional capability and validate prerequisite closure before invocation and completion.
- The host deployment payload now carries routing, registry, graph, and enforcement contracts consistently across supported hosts.

### Removed
- No global Codex Hook is installed or configured; project workflows remain stateful, explicit, and host-agnostic.

## V6.8.6 — 2026-08-23

### Added
- Programming-level skill enforcement: portable-skill registry, explicit lifecycle states, schema-v3 routing, recorded invocation/closure evidence, and validation scripts.
- Cross-host enforcement deployment for Codex, Claude, Antigravity, and generic installations.
- Project `.agentlogic/skill-usage.json` and `CODE_MAP.md` Skill Usage summaries for future skill replacement and upgrade planning.

### Changed
- Mandatory skill routes now select an available primary capability deterministically and block unsupported verified claims instead of silently degrading.
- Added the portable `code-review` skill as an approved conditional code-review route when installed.
- Release/package flows retain native local artifact-validation fallback with explicit disclosure; remote releases still require exact-target and post-result evidence.
