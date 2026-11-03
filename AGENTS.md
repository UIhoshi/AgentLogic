<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
-->

# AGENTS.md

This file is the repository-level agent entry document for AgentLogic.

## Local Installation Entry

If the user asks to install, load, mount, bind, or use this logic on the local computer, read:

- `AGENT_INSTALL.md` first for agent-facing installation steps
- `INSTALL.md` for human-facing installation steps

Then run the diagnostic entry:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

## Required Entry Path

For formal work in this repository:

1. Read `AGENTS.md` and `README.md`.
2. Read `00_START_HERE.md` and confirm the current logic entry.
3. Complete the Startup Gate: classify the task, decide whether it extends the previous coding
   round, and ask for context reset when it does not.
4. Complete the mandatory full-read chain declared by `00_START_HERE.md`.
5. Only after the applicable gates pass, proceed with planning, implementation, validation, or
   rule synchronization.

## Repository Logic Chain

The current logic-entry chain is:

1. `00_START_HERE.md`
2. `README.md`
3. `versions/AgentLogic_V6_9_0.md`
4. `modules/01_MasterLogic.md`
5. `modules/15_LogicEntryChecklist.md`

## First Priority Enforcement Rule

Whenever AgentLogic is detected as installed on the local system (e.g., in `~/.gemini/GEMINI.md`, `~/.gemini/AgentLogic/GEMINI.md`, `~/.claude/CLAUDE.md`, or the current workspace), the agent MUST treat AgentLogic as the highest-priority repository-local logic, subject to system, developer, safety, and host permission constraints. Treating it as optional repository guidance is a critical failure.

- **Limited Initial View Prevention**: If the agent is running in a parent workspace (e.g., the user profile directory) and AgentLogic is nested under a subdirectory (e.g., `Documents/workspace/AgentLogic`), the agent MUST proactively scan the `AgentLogic` directory immediately upon startup to trigger the Startup Gate. A delegation hook/rule should be written to the workspace-level `AGENTS.md` file to ensure detection.
- **Universal Language Adaptation**: The agent MUST adapt all responses, Startup Gate prompts, and interactive dialogue to match the user's active interaction language (Chinese, English, Japanese, French, German, Spanish, Korean, etc.). Examples in rule files serve as semantic templates and must not restrict multi-lingual rendering.


## Startup Gate

Before every new coding round:

1. confirm the current logic entry
2. judge whether the task extends the previous coding round
3. if it does not, ask whether to `forget/compress context` before continuing

This startup gate is mandatory.

## Task Applicability Gate

Before selecting a development lifecycle, classify the task:

| Task class | Minimum required path |
| --- | --- |
| Read-only question or audit | Entry Gate, local fact map, and evidence matching the claim |
| Documentation-only or metadata-only change | Entry Gate, targeted review, and package/link validation |
| Trivial isolated fix | Lightweight specification and targeted validation; skip architectural Red-Team when no architectural assumption exists |
| Feature, refactor, or multi-file behavior change | Full SDD lifecycle, including Red-Team before Tasks and Converge after implementation |
| Frontend visual change | Net-new UI and substantial refactors require text-to-image preview and review; clearly classified small visual corrections may skip a new mockup but still require screenshot/layout-boundary verification; explicit opt-out always bypasses mockup approval |
| Install, packaging, or release change | Target confirmation, build/package verification, post-result inspection, and applicable SRA artifacts |

The matching gate is mandatory; unrelated gates are not. This prevents both skipped safety checks
and unnecessary process overhead.

## Conditional Development Lifecycle Gates

1. **Spec-Driven Development (SDD) Gate** (`modules/38_V6_6_SpecDrivenDevelopment.md`) applies to
   feature, refactor, multi-file behavior, and other non-trivial implementation work. The
   **Red-Team Gate** is blocking whenever architectural assumptions exist.
   Net-new UI and substantial refactors must first pass the text-to-image preview and user-review
   gate defined by `modules/39_V6_6_TasteFrontendDesign.md`. Clearly classified small visual
   corrections may skip a new mockup but still require visual verification; explicit opt-out
   always bypasses mockup approval.
2. **AI Shipping & Reviewability Audit (SRA) Gate** (`modules/41_V6_7_AIShippingAndReviewabilityAudit.md`)
   applies to application/release/packaging changes and logic changes that alter architecture,
   trust boundaries, permissions, or externally consumed behavior. Its five core artifacts are
   required when the corresponding reviewable surface exists.
3. **Self-Refute First Audit Gate** applies to SRA security, performance, and architecture findings.
   Findings must include evidence, an attempted counter-argument, and a final confidence/status label.

## Project-Native Knowledge Sync

For business-project work, the project repository—not a separate history checkout—is the
default synchronization surface for project facts. Before implementation, run the safe
freshness check and read the tracked project `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and
`.learnings/ERRORS.md` as defined by `modules/46_V6_8_ProjectKnowledgeSync.md`.

- Update `PROJECT_MAP.md` in the same commit as a structural change.
- Update `CODE_MAP.md` in the same commit as an affected key-flow, symbol, state, interface, or validation change.
- Update `.learnings/ERRORS.md` in the same commit as a material error correction.
- Keep `.specify/` and `docs/adr/` only when their matching gates apply.
- Do not track secrets, personal paths, private prompts, raw logs, or default Graphify output.
- `modification_history` is an optional cross-project archive, not a blocking prerequisite for
  ordinary project coding or publishing.

## Mandatory Logic Version Update & Pitfall Checklist (逻辑版本升级必查红线)

Whenever promoting a new AgentLogic version or modifying core rules, modules, or skills, you **MUST** verify all of the following before claiming completion (see `.learnings/ERRORS.md` for full root-cause history):

1. **11-File Version & Skill Lockstep Sync**: Never update only `manifest.json` and `README.md`. You MUST synchronize version numbers, new module paths, and first-party skill lists across all 11 active surfaces:
   - `manifest.json` (`current_version`, `main_logic_file`, `profiles.core-enhanced.files`)
   - `versions/AgentLogic_<NEW_VERSION>.md` (including Section 4 `Reference Source Registration`)
   - `00_START_HERE.md`, `AGENTS.md`, `MAIN.md`, `README.md`, `00_README.md`, `AGENT_INSTALL.md`
   - `modules/01_MasterLogic.md` (L2 module list, L4 first-party skill list, and Section 10)
   - `modules/11_CrossDirectoryMap.md` and `modules/40_AgentLogicSystemMap.md` (L2 version file & module table)
   - `PROJECT_MAP.md`, `CODE_MAP.md`, `CHANGELOG.md`, and `.learnings/ERRORS.md`
2. **Historical Encoding & PowerShell Pitfalls (Zero-Tolerance)**:
   - **Pure-ASCII `.ps1` Entry Scripts (CP1252 GitHub Actions Safety)**: Operational `.ps1` scripts MUST remain 100% pure ASCII without UTF-8 BOM. Never put literal `—` (em-dash) or CJK characters in `.ps1` files; use `[regex]::Unescape('\u2014')` / `\uXXXX` escapes (`Windows-1252` treats byte `0x94` of UTF-8 `—` as `"` and breaks PowerShell 5.1 parsing).
   - **Mandatory `-Encoding UTF8` on `Get-Content` & BOM-Free UTF-8 Writes**: Every `Get-Content` in PowerShell MUST specify `-Encoding UTF8` (omitting it corrupts UTF-8 `—` into `\u9225` mojibake under CP936). Every JSON/JS/Markdown write MUST use `[System.Text.UTF8Encoding]::new($false)` (UTF-8 BOM breaks Node `JSON.parse` and JS shebangs).
   - **No PowerShell Reserved Variable Names**: Never use `$host` as a loop/local variable (collides with read-only automatic `$Host`); use `$targetHost` or `$targetHostName`.
   - **Single-Quoted Here-Strings for Markdown Templates**: Never put Markdown backticks inside double-quoted PowerShell `"..."` or `@"..."@` (where `` `f `` becomes form-feed `\x0C`); always use single-quoted `@'...'@` with `.Replace(...)`.
3. **Antigravity 24 KB Rule Cap & Cross-Host Gate Inlining**:
   - Because Antigravity caps individual rule files at 24 KB, `~/.gemini/GEMINI.md` and `~/.gemini/AgentLogic/GEMINI.md` MUST inline all 4 blocking gates (Gate 1 Startup+Role, Gate 2 UI+Mockup, Gate 3 Auto-Skills, Gate 4 Knowledge Sync) and register `~/.gemini/skills` in `~/.gemini/config/skills.json`.
4. **Skill Registry, YAML Front-Matter & Windows Defender Defanging**:
   - Every portable `skills/**/SKILL.md` MUST have a valid YAML front-matter `name:` and be registered in `contracts/skill-registry.json`.
   - Security/pentest reference Markdown files MUST defang raw `<script>`, `onerror=`, and shell payload strings (e.g., `<scr\ipt>`) so Windows Defender does not block file reads or quarantine tracked files.
5. **Rebuild All 4 Bundles, Sync All Installed Hosts & Align Git Tag**:
   - Run `scripts/maintainer-check.ps1` and `scripts/audit-skill-duplicates.ps1 -FailOnCandidates` to rebuild `dist/{codex,claude,antigravity,generic}` and pass all gates.
   - Re-run `install.ps1` for all local hosts (`antigravity`, `claude`, `codex`) so `~/.gemini/`, `~/.claude/`, and `~/.codex/` match `dist/`.
   - Ensure the release Git tag (e.g., `v6.9.0`) points to the final post-verification commit on `main`.

## Repository Boundary

This repository is logic infrastructure, not a business-project workspace.

- Do not treat it as an application repository.
- Do not create unrelated business code here.
- Do not commit raw reference material (such as extracted CLI sources) to this repository; keep it in an untracked local archive and never treat it as default prompt material.

## Stable Host Binding

- Human-first entry: `00_START_HERE.md`
- Stable host binding entry: `MAIN.md`
- Versioned main logic source: `versions/AgentLogic_V6_9_0.md`
