# Antigravity UI Preview Gate Enforcement — Tasks

- [x] Diagnose why Codex enforces the UI Preview Gate while Antigravity did not.
- [x] Update `contracts/skill-routing.json`, `modules/39_V6_6_TasteFrontendDesign.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, and `versions/AgentLogic_V6_8_7.md` to recognize Antigravity's `image-generator` subagent and inline UI Preview Gate enforcement.
- [x] Update `adapters/antigravity/install.ps1` to fix BOM-free UTF-8 and form-feed (`\x0C`) escaping, inline the Mandatory UI Preview & Requirements Gate in `~/.gemini/GEMINI.md`, and register `~/.gemini/skills` in `~/.gemini/config/skills.json`.
- [x] Update `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md` to synchronize project knowledge.
- [x] Rebuild all host bundles (`scripts/maintainer-check.ps1`), run skill enforcement tests, and re-run `install.ps1 -TargetHost antigravity` to deploy and verify locally.
