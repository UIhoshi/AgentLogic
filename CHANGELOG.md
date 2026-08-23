# Changelog

## V6.8.6 — 2026-08-23

### Added
- Programming-level skill enforcement: portable-skill registry, explicit lifecycle states, schema-v3 routing, recorded invocation/closure evidence, and validation scripts.
- Cross-host enforcement deployment for Codex, Claude, Antigravity, and generic installations.
- Project `.agentlogic/skill-usage.json` and `CODE_MAP.md` Skill Usage summaries for future skill replacement and upgrade planning.

### Changed
- Mandatory skill routes now select an available primary capability deterministically and block unsupported verified claims instead of silently degrading.
- Added the portable `code-review` skill as an approved conditional code-review route when installed.
- Release/package flows retain native local artifact-validation fallback with explicit disclosure; remote releases still require exact-target and post-result evidence.
