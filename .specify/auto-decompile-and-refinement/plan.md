# Autonomous Decompilation Reconstruction & Post-Implementation Code Refinement — Plan

## 1. Architecture & Integration Design

### 1.1 Two New First-Party Portable Skills (`skills/engineering/`)
1. **`skills/engineering/code-simplifier/SKILL.md`** (`name: code-simplifier`):
   - Synthesizes Anthropic's official `code-simplifier` plugin (`anthropics/claude-plugins-official`), `ast-grep` structural search/rewrite (`ast-grep/ast-grep`), and `obra/superpowers` Red-Green-Refactor discipline.
   - **Automatic Trigger**: Runs automatically after any `feature`, `major_feature`, or `refactor` implementation (or when the user asks to clean up, simplify, polish, or refactor code) **after** initial behavior/tests pass and **before** final review/completion.
   - **4-Step Execution Protocol**:
     1. **Baseline Lock**: Confirm existing tests/build pass before touching structure.
     2. **80/20 Smell & Bloat Triage**: Scan only modified/target files for high-impact friction: deep nesting (`> 3` levels), nested ternaries, duplicated logic shapes, mysterious names violating `CONTEXT.md`, and redundant AI-generated defensive wrappers.
     3. **AST-First Structural Rewrite**: When the same pattern or call-site transformation spans `>= 3` sites or multiple files, prefer `ast-grep` (`sg run -p ... -r ...`) if installed; otherwise perform atomic bounded edits one transformation at a time.
     4. **Zero-Behavior-Change Verification**: Re-run the test/build command immediately. If any check fails, revert the simplification hunk immediately.
2. **`skills/engineering/decompile-reconstruction/SKILL.md`** (`name: decompile-reconstruction`):
   - Synthesizes `morluto/rea` (Reverse Engineer Anything) and `LaurieWired/GhidraMCP`, plus our existing `ida-reverse`, `jadx`, `ilspycmd`/`dnSpyEx`, `pycdc`, and `webcrack` toolchains.
   - **Automatic Trigger**: Runs automatically whenever the user provides or points to a compiled binary, library, installer, APK/JAR, `.NET` assembly, `.pyc`, WASM, or minified/bundled JS/Electron archive and asks what it does, how an algorithm/protocol works, or wants it decompiled/reconstructed into clean source code.
   - **5-Stage Clean-Room Reconstruction Pipeline**:
     1. **Format & Toolchain Triage (Non-Destructive)**: Identify target format (`file`, PE CLR header, ELF/Mach-O, APK/JAR, ASAR/JS bundle, Python bytecode) and select the highest-fidelity available decompiler:
        - Native PE/ELF/Mach-O/SO/DLL: `idapro_*` (`ida-pro-mcp`) -> `ghidra-mcp` / Ghidra headless (`analyzeHeadless`) -> `r2ghidra` / `radare2` + `objdump`.
        - JVM / Android APK / JAR: `jadx` / `apktool`.
        - .NET / C# Assembly: `ilspycmd` / `dnSpyEx` + `de4dot`.
        - Python `.pyc` / PyInstaller: `pyinstxtractor` + `pycdc` / `uncompyle6`.
        - Bundled / Obfuscated JS / Electron: `asar` + `webcrack` / `ast-grep` + `js-reverse`.
     2. **Structural & Symbol Survey**: Map entrypoints, exports, imports, string xrefs, and call graphs before reading raw assembly.
     3. **Pseudocode & IR Extraction**: Extract decompiler pseudocode for target functions and save structured evidence artifacts.
     4. **Type, Struct & Control-Flow Recovery**: Replace pointer arithmetic (`*(int *)(a1 + 16)`) with named `struct`/`enum` definitions, eliminate compiler/decompiler artifacts (`v1`, `a1`, `LABEL_`, `goto`), and recover idiomatic loops and error handling.
     5. **Equivalence Verification**: Verify reconstructed source via compilation/typecheck and input-output vector comparison (or documented static equivalence boundary when dynamic execution is unsafe/unavailable).

### 1.2 Deterministic Routing & Enforcement Contracts
- **`contracts/skill-enforcement.json` & `scripts/skill-enforcement.ps1`**:
  - Add `"decompile_or_reconstruct"` to `task_class`.
  - Add `"code_refinement"` and `"decompile_reconstruction"` to `claim_types`.
  - Update `signal_rules`:
    - `task_class` in `["feature", "refactor"]` -> emits `["behavior_change", "code_refinement"]`
    - `task_class` in `["major_feature"]` -> emits `["major_feature", "behavior_change", "code_refinement"]`
    - `task_class` in `["decompile_or_reconstruct"]` -> emits `["decompile_reconstruction"]`
    - `claim_types` in `["code_refinement"]` -> emits `["code_refinement"]`
    - `claim_types` in `["decompile_reconstruction"]` -> emits `["decompile_reconstruction"]`
- **`contracts/skill-routing.json`**:
  - Add route `decompile-reconstruction` (`order: 35`, triggers: `["decompile_reconstruction"]`, primary alias: `"decompile-reconstruction"`, conditional aliases: `["ida-reverse", "ghidra-mcp", "reverse-engineering", "dotnet-reverse", "apk-reverse", "js-reverse"]`, fallback: `"allow_native_decompile_triage_with_disclosure"`, closure evidence: `["target_format_and_toolchain_triage", "decompiled_or_reconstructed_artifact"]`).
  - Add route `code-refinement` (`order: 45`, triggers: `["code_refinement"]`, primary alias: `"code-simplifier"`, conditional aliases: `["ponytail", "improve-codebase-architecture"]`, fallback: `"allow_native_code_refinement"`, closure evidence: `["refinement_or_smell_check", "behavior_preserved_verification"]`).
- **`contracts/skill-workflow-graph.json`**:
  - Add `code-refinement` node (`posture: "route"`, `route_ids: ["code-refinement"]`, `requires: ["frontend-implementation"]`, `consumes: ["implementation_result"]`, `produces: ["refined_implementation_result"]`) and include it in `website-delivery` so UI/feature pipelines also run post-implementation code refinement automatically.
- **First-Party Skill Deployment (`scripts/deploy-first-party-skill.ps1`, `contracts/host-skill-capabilities.json`, and `adapters/*/install.ps1`)**:
  - Deploy `product-requirements-grilling`, `code-simplifier`, and `decompile-reconstruction` to every host's skills directory so all three first-party skills are always present locally.
  - Update `adapters/antigravity/install.ps1` so `~/.gemini/GEMINI.md` inlines **Gate 4: Automatic Code Refinement & Decompilation Reconstruction Routing** (staying well under the 24 KB limit).

## 2. Red-Team Results

1. **Fails if** adding `code_refinement` to `feature`, `major_feature`, and `refactor` signal rules breaks existing tests in `scripts/test-skill-enforcement.ps1` or `scripts/test-skill-workflow-graph.ps1`.
   - *Steelman*: Existing tests initialize `major_feature` tasks and assert exact route progression and `website-delivery` nodes.
   - *Attack / Mitigation*: In `test-skill-enforcement.ps1`, `feature` and `ui` fixtures initialize `major_feature` tasks. If `code-refinement` is matched automatically on `major_feature` with `fallback: "allow_native_code_refinement"`, `preflight` will succeed even when `code-simplifier` is not passed in `-AvailableSkill` (falling back to `native-code_refinement`), and `ui` workflow graph tests must include `code-refinement` closure and artifact (`refinement_record`) where required. To keep `feature` minimal while enforcing artifact checks on `website-delivery`, `code-refinement` can require closure evidence `refinement_or_smell_check` and `behavior_preserved_verification` without a mandatory file artifact hash (or with an artifact only when in `website-delivery`), and we will update `test-skill-enforcement.ps1` and `validate-skill-workflow-graph.ps1` to test both `code-refinement` and `decompile-reconstruction` end-to-end!
2. **Fails if** `check-logic-entry.js` rejects new external reference URLs in `versions/AgentLogic_V6_8_7.md`.
   - *Steelman*: `check-logic-entry.js` parses every `Source URL:` in Section 4 of `versions/AgentLogic_V6_8_7.md` and requires the exact URL to appear in both `README.md` and `00_README.md`.
   - *Attack / Mitigation*: Add the exact URLs (`https://github.com/morluto/rea`, `https://github.com/LaurieWired/GhidraMCP`, `https://github.com/anthropics/claude-plugins-official`, `https://github.com/ast-grep/ast-grep`, `https://github.com/obra/superpowers`) to `versions/AgentLogic_V6_8_7.md`, `README.md`, and `00_README.md` simultaneously.
3. **Fails if** `validate-skill-registry.ps1` fails because new `SKILL.md` files are added under `skills/` without matching entries in `contracts/skill-registry.json`, or because `route_candidate` triggers in `skill-registry.json` do not match the sorted union of triggers in `skill-routing.json`.
   - *Attack / Mitigation*: Register both new `SKILL.md` files in `contracts/skill-registry.json` with exact matching `route_ids` and sorted `triggers`, and update `skills/ponytail/SKILL.md` or `skills/reverse-skill/skills/ida-reverse/SKILL.md` if their `route_ids` change.
