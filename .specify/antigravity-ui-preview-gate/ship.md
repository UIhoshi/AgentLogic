# Shipping Review Record — Antigravity UI Preview Gate Enforcement

## Scope

Adapter, routing contract, and rule-module synchronization so Antigravity enforces the Mandatory UI Preview & Requirements Gate (`product-requirements-grilling` + visual mockup generation via `image-generator` / `nano-banana-pro` before UI code unless explicitly opted out) with the same reliability as Codex (`gpt`).

## Reviewable flow

Antigravity session starts in any workspace -> loads `~/.gemini/GEMINI.md` (`<RULE[user_global]>`, 3.4 KB, well within the 24 KB rule cap) and discovers `~/.gemini/skills` via `~/.gemini/config/skills.json` -> executes Gate 1 (Startup & Context-Reset Gate) -> when UI creation or substantial UI refactoring is requested, executes Gate 2 (Mandatory UI Preview & Requirements Gate: single-question requirements grilling -> visual UI mockup via `invoke_subagent(TypeName="image-generator")` or `nano-banana-pro` -> user approval or explicit opt-out) before writing any production UI code -> verifies layout/containment boundaries via Gate 3.

## Self-refute audit

| Potential finding | Counter-check | Status |
| --- | --- | --- |
| Inlining gates in `~/.gemini/GEMINI.md` could exceed Antigravity's 24 KB per-file rule cap | Verified `~/.gemini/GEMINI.md` is ~3.4 KB, well below the 24,000-byte limit | Cleared by file-size check |
| Windows PowerShell 5.1 could misparse raw UTF-8 Chinese literals in BOM-free `.ps1` scripts or turn `` `f `` into `\x0C` | Used single-quoted Here-String `@'...'@` for Markdown backticks and `\uXXXX` Unicode escapes for non-ASCII literals, written with `[System.Text.UTF8Encoding]::new($false)` | Cleared by post-install inspection of `~/.gemini/GEMINI.md` |
| Registering `~/.gemini/skills` in `~/.gemini/config/skills.json` could overwrite user custom skill paths | `adapters/antigravity/install.ps1` parses existing `skills.json` and appends `~/.gemini/skills` only if absent | Cleared by code inspection |
| Adding `image-generator` to `ui-design` in `contracts/skill-routing.json` could break portable skill registry validation | `image-generator` is listed in `conditional_host_skill_aliases`; `validate-skill-registry.ps1`, `validate-skill-routing.ps1`, and `test-skill-enforcement.ps1` all pass | Cleared by automated test execution |

## Verification

- `node scripts/check-logic-entry.js`: passed.
- `scripts/validate-package.ps1` and `scripts/maintainer-check.ps1`: passed; all 4 host bundles (`codex`, `claude`, `antigravity`, `generic`) rebuilt and verified.
- `scripts/test-skill-enforcement.ps1` and `scripts/test-skill-workflow-graph.ps1`: passed.
- `install.ps1 -TargetHost antigravity`: passed; verified `~/.gemini/GEMINI.md`, `~/.gemini/AgentLogic/GEMINI.md`, `~/.gemini/config/skills.json`, and `~/.gemini/antigravity-cli/AgentLogic/AGENTS_BUNDLE.md`.
