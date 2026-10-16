# Antigravity UI Preview Gate Enforcement — Plan

## Approach

1. **Update `contracts/skill-routing.json`, `modules/39_V6_6_TasteFrontendDesign.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, and `versions/AgentLogic_V6_8_7.md`**:
   - Add `"image-generator"` to `conditional_host_skill_aliases` of the `ui-design` route in `contracts/skill-routing.json` and update its `selection_rule` to clarify that on Antigravity, the built-in `image-generator` subagent (`invoke_subagent` with `TypeName="image-generator"`) and `nano-banana-pro` are approved equivalents to `imagegen`.
   - Document the Antigravity delegation-hook UI Preview Gate inline contract and `~/.gemini/config/skills.json` registration in `modules/39_V6_6_TasteFrontendDesign.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, and `versions/AgentLogic_V6_8_7.md`.
2. **Harden `adapters/antigravity/install.ps1`**:
   - Replace the double-quoted PowerShell Here-String with a single-quoted template (or properly escaped string) and write with `[System.IO.File]::WriteAllText(..., [System.Text.UTF8Encoding]::new($false))` so `` `forget/compress context` `` and Chinese characters are never corrupted.
   - Expand the `# Local AgentLogic Precedence Rule` hook in `~/.gemini/GEMINI.md` (~3.5 KB, well under the 24 KB limit) to directly enforce:
     - **Gate 1: Startup & Context-Reset Gate (Turn 1 Blocking)**
     - **Gate 2: Mandatory UI Preview & Requirements Gate (Blocking Before Any UI Code)** — explicitly requiring single-question requirements confirmation and visual UI mockup generation via `invoke_subagent(TypeName="image-generator")` or `nano-banana-pro` before writing HTML/CSS/JS/TSX/Vue/UI code for any new project or UI change, unless the user explicitly opts out ("不需要先画图" / explicit opt-out).
     - **Gate 3: Project-Native Knowledge Sync & Verification Matrix**
   - Ensure `~/.gemini/config/skills.json` exists and includes `{"path": "~/.gemini/skills"}` in `entries` without clobbering existing entries.
3. **Update `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`**:
   - Record the material root cause (Antigravity 24 KB rule pointer omitting UI Preview Gate + PowerShell `` `f `` form-feed & encoding corruption + missing `skills.json` discovery) in `.learnings/ERRORS.md`.
   - Update `PROJECT_MAP.md` and `CODE_MAP.md`.
4. **Rebuild & Validate**:
   - Run `scripts/maintainer-check.ps1`, `scripts/test-skill-enforcement.ps1`, `scripts/test-skill-workflow-graph.ps1`, and `install.ps1 -TargetHost antigravity`.

## Red-Team Results

1. **Fails if** expanding `~/.gemini/GEMINI.md` exceeds Antigravity's 24 KB per-file rule cap (`defaultRulesBudget`), causing truncation.
   - *Mitigation*: Keep the delegation hook concise (~3.5 KB), containing only the non-negotiable blocking gates (Startup Gate, UI Preview & Requirements Gate, Verification & Knowledge Sync Gate) and pointers to `AGENTS_BUNDLE.md` and `skill-enforcement.ps1`.
2. **Fails if** `adapters/antigravity/install.ps1` overwrites a user's existing custom entries in `~/.gemini/config/skills.json`.
   - *Mitigation*: Parse existing `skills.json` if present, check whether `~/.gemini/skills` (or equivalent resolved path) is already in `entries`, and merge non-destructively.
3. **Fails if** adding `image-generator` to `contracts/skill-routing.json` breaks `scripts/validate-skill-registry.ps1` because `image-generator` is a host built-in subagent rather than a portable `skills/**/SKILL.md` file.
   - *Counter-check*: Check how `validate-skill-registry.ps1` validates aliases in `skill-routing.json` before editing.
