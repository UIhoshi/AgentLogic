# Autonomous Decompilation Reconstruction & Post-Implementation Code Refinement — Specification

## 1. Intent

Integrate two high-leverage programming capability routes into AgentLogic V6.8.7 so they activate **automatically from task classification and problem context** without requiring the user to remember or invoke any skill name (`/skill`):

1. **Engineering Decompilation & Clean-Room Reconstruction (`decompile-reconstruction`)**:
   - Informed by [`morluto/rea`](https://github.com/morluto/rea) (Reverse Engineer Anything) and [`LaurieWired/GhidraMCP`](https://github.com/LaurieWired/GhidraMCP).
   - Automatically triggers whenever a task involves analyzing, decompiling, deobfuscating, or reconstructing readable/compilable source code or architecture from compiled binaries (`exe`/`dll`/`so`/`elf`/`macho`), bytecode/packages (`jar`/`apk`/`.pyc`/`wasm`/`.NET`), or bundled/minified/obfuscated JS/Electron targets (`task_class = decompile_or_reconstruct` or `claim_types` includes `decompile_reconstruction`).
   - Distinguishes **engineering source/architecture reconstruction** (automatic product-first workflow) from **offensive CTF/exploit/malware operations** (which remain restricted manual paths).
2. **AST-Aware Refactoring & Post-Implementation Code Simplification (`code-refinement`)**:
   - Informed by [`anthropics/claude-plugins-official`](https://github.com/anthropics/claude-plugins-official) (`code-simplifier`), [`ast-grep/ast-grep`](https://github.com/ast-grep/ast-grep) (`ast-grep/agent-skill`), and [`obra/superpowers`](https://github.com/obra/superpowers).
   - Automatically triggers on every `feature`, `major_feature`, and `refactor` task (`behavior_change` or `code_refinement` signal) as an automatic post-implementation refinement pass before final completion/review.
   - Complements `ponytail` (pre-implementation YAGNI subtraction) and `improve-codebase-architecture` (macro module deepening) by enforcing:
     - **AST-first multi-site structural rewrites** (`ast-grep` / `sg` when available, rather than fragile regex/text edits across files);
     - **Zero-behavior-change post-implementation code simplification** (flattening deep nesting, replacing dense nested ternaries, removing dead/redundant defensive wrappers, and aligning naming with `CONTEXT.md`);
     - **80/20 Fowler code-smell triage and atomic test-verified steps** (preserving green test baseline before and after each refinement).

## 2. User-Facing Behavior Contract ("Encounter -> Auto-Use")

- Users describe **what they have or want** (e.g., *"把这段功能写好"*, *"重构一下这个模块"*, *"帮我看看这个 DLL/APK/混淆 JS 里面的算法并还原成代码"*), never internal skill names.
- The agent automatically classifies the task, selects the matching route (`code-refinement` or `decompile-reconstruction`), loads the deployed first-party skill, executes the workflow, and verifies closure evidence.
- First-party portable skills (`product-requirements-grilling`, `code-simplifier`, `decompile-reconstruction`) are automatically deployed to all supported hosts (`codex`, `claude`, `antigravity`, `generic`) by `scripts/deploy-first-party-skill.ps1`, and inlined in Antigravity's `~/.gemini/GEMINI.md` global rule hook so automatic triggering works in every workspace.

## 3. Acceptance Criteria

1. Portable skills `skills/engineering/code-simplifier/SKILL.md` and `skills/engineering/decompile-reconstruction/SKILL.md` exist, are registered in `contracts/skill-registry.json` with `lifecycle: "conditional"` and `activation.mode: "route_candidate"`, and are deployed to host skill directories via `scripts/deploy-first-party-skill.ps1`.
2. `contracts/skill-enforcement.json` and `scripts/skill-enforcement.ps1` support `decompile_or_reconstruct` task classification and `code_refinement` / `decompile_reconstruction` signals, automatically deriving `code-refinement` (order `45`) and `decompile-reconstruction` (order `35`).
3. `contracts/skill-routing.json` defines `code-refinement` and `decompile-reconstruction` routes with explicit primary/conditional aliases, native fallback policies (`allow_native_code_refinement` and `allow_native_decompile_triage_with_disclosure`), and closure evidence.
4. `contracts/skill-workflow-graph.json` includes `code-refinement` in the automatic workflow graph (between implementation and verification/review).
5. `docs/software-candidates.md`, `README.md`, `00_README.md`, `versions/AgentLogic_V6_8_7.md`, `modules/37_V6_6_CybersecuritySkillsRouter.md`, `modules/42_V6_7_PonytailLazySeniorDevLadder.md`, `modules/48_V6_8_SkillAndToolRouting.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, `modules/51_V6_8_AffordanceFirstToolUse.md`, and `modules/53_V6_8_ProgrammingLevelSkillEnforcement.md` are synchronized.
6. All validation and regression suites (`node scripts/check-logic-entry.js`, `scripts/validate-skill-registry.ps1`, `scripts/test-skill-registry.ps1`, `scripts/validate-skill-routing.ps1`, `scripts/validate-skill-workflow-graph.ps1`, `scripts/test-skill-workflow-graph.ps1`, `scripts/test-skill-enforcement.ps1`, `scripts/maintainer-check.ps1`, and `install.ps1 -TargetHost antigravity`) pass.
