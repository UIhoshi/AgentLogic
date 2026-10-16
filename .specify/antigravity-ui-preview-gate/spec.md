# Antigravity UI Preview Gate Enforcement — Specification

## Intent

Ensure that when AgentLogic is installed into the `antigravity` host, net-new UI work and substantial UI refactors reliably enforce the requirements-grilling and UI Preview Gate (generating a visual mockup first unless the user explicitly opts out), matching the enforcement reliability already observed on Codex (`gpt`).

## Root Cause Summary

1. **Delegation Hook Context Gap**: Unlike Codex (`model_instructions_file` injecting the full 531 KB bundle directly), Antigravity enforces a 24 KB per-rule-file cap (`~/.gemini/GEMINI.md`) and uses a short delegation hook (`< 2 KB`). Previously, that hook only mentioned the Turn 1 Startup Gate (`forget/compress context`) and omitted the UI Preview Gate, requirements-grilling gate, and workflow enforcement rules. In external business workspaces, agents read only the inline hook and bypassed `AGENTS_BUNDLE.md` and the UI mockup protocol.
2. **PowerShell String Escaping & Encoding Bug**: `adapters/antigravity/install.ps1` used a double-quoted PowerShell Here-String (`@"..."@`) containing `` `forget/compress context` ``, turning `` `f `` into a form-feed control character (`\x0C`), and wrote `~/.gemini/GEMINI.md` without explicit UTF-8 encoding, corrupting non-ASCII Chinese text on Windows PowerShell.
3. **Host Skill Discovery Gap**: Antigravity discovers global skills from `~/.gemini/config/skills.json`, whereas `adapters/antigravity/install.ps1` deployed `product-requirements-grilling` to `~/.gemini/skills/` without registering `~/.gemini/skills` in `~/.gemini/config/skills.json`.
4. **Image-Generation Alias & Subagent Mapping**: In Antigravity, first-party image generation is exposed via the built-in `image-generator` subagent (`invoke_subagent(TypeName="image-generator")`) or `nano-banana-pro`, whereas `ui-design` in `contracts/skill-routing.json` only listed `imagegen` as a primary alias and `nano-banana-pro` as conditional without documenting `image-generator` for Antigravity.

## Acceptance Criteria

1. `adapters/antigravity/install.ps1` writes `~/.gemini/GEMINI.md` and `~/.gemini/AgentLogic/GEMINI.md` using BOM-free UTF-8 without form-feed (`\x0C`) corruption, and stays well within Antigravity's 24 KB rule limit.
2. The Antigravity delegation hook in `~/.gemini/GEMINI.md` explicitly inlines the **Mandatory UI Preview & Requirements Gate (Blocking)** alongside the **Startup Gate**, instructing the agent that before writing or editing any UI/frontend code for a new project, new screen/component, or substantial UI refactor, it MUST:
   - Run single-question requirements discovery (`product-requirements-grilling`) and produce a user-approved brief unless already completed;
   - Generate a visual UI mockup image first (using Antigravity's built-in `image-generator` subagent or `nano-banana-pro` / `imagegen`), save/present it to the user, and wait for explicit approval — unless the user explicitly states that a UI mockup is not needed (explicit opt-out).
3. `adapters/antigravity/install.ps1` ensures `~/.gemini/config/skills.json` registers `~/.gemini/skills` so `product-requirements-grilling` and `nano-banana-pro` are discoverable in Antigravity sessions across all workspaces.
4. `contracts/skill-routing.json`, `modules/39_V6_6_TasteFrontendDesign.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, and `versions/AgentLogic_V6_8_7.md` recognize `image-generator` as an approved conditional/host-equivalent image-generation alias for `ui-design` on Antigravity.
5. All generated bundles (`dist/`) and validation scripts (`check-logic-entry.js`, `validate-package.ps1`, `maintainer-check.ps1`, `test-skill-enforcement.ps1`, `test-skill-workflow-graph.ps1`) pass, and the updated Antigravity installation is re-deployed and verified locally.
