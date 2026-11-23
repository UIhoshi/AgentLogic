---
name: skill-evaluator
description: Evaluate, audit, benchmark, and improve local AgentLogic skills and plugin directories for frontmatter validity, trigger precision, progressive disclosure, link integrity, and token budget efficiency. Trigger automatically when auditing, evaluating, benchmarking, or refactoring any SKILL.md or plugin package.
---

# Skill & Plugin Evaluator (`skill-evaluator`)

This skill synthesizes the **MIT**-licensed `plugin-eval` workflow (`openai/plugins`: `evaluate-skill`, `evaluate-plugin`, `improve-skill`, `metric-pack-designer`) tailored for AgentLogic's portable skill registry and multi-host token budgets.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill whenever the user asks to:
- Evaluate, audit, score, or benchmark a `SKILL.md`, a skill folder, or a plugin bundle.
- Diagnose why a skill fails to trigger reliably, consumes too many context tokens, or needs structural cleanup (`improve-skill`).

---

## 2. Six Evaluation Dimensions

Audit every target `SKILL.md` / plugin directory across six deterministic dimensions:
1. **Frontmatter Validity**: Valid YAML `---` header with non-empty `name` (hyphen-case matching directory/registry) and actionable `description`.
2. **Trigger Precision & Scope Boundaries**: Clear positive trigger signals ("Trigger automatically when...") AND negative/exclusion boundaries ("Do NOT use for...") to prevent false activation or route collisions.
3. **Progressive Disclosure & Token Budget**: Keep active `SKILL.md` entrypoints concise (ideally `< 8 KB` / `~2,000 tokens`, hard review threshold `16 KB`), offloading deep lookup tables, schemas, or multi-language playbooks into `references/` or `scripts/`.
4. **Relative Link & Asset Integrity**: Verify zero broken relative Markdown links, zero machine-specific absolute paths (`C:\Users\...`, `/home/...`), and valid encoding (UTF-8 without BOM).
5. **Security & Encoding Hygiene**: Zero un-defanged exploit payloads that trigger AV quarantine, and pure-ASCII CP1252-safe `.ps1` helper scripts with explicit `-Encoding UTF8` on `Get-Content`.
6. **Contract & Host Registration Parity**: Verify registry entry (`contracts/skill-registry.json`), route alignment (`contracts/skill-routing.json`), and duplicate/name-collision freedom (`scripts/audit-skill-duplicates.ps1`).

---

## 3. Execution & Report Format

1. **Run Automated Evaluator (when inside AgentLogic)**:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\eval-skills.ps1
   ```
   Or target a single skill path with `-TargetPath <path-to-skill-or-dir>`.
2. **Present Findings Using the Structured 4-Section Report**:
   - **At a Glance**: Overall status, file size / estimated tokens, link health, and trigger readiness.
   - **Why It Matters**: Concrete impact on host context budget, routing determinism, or cross-host portability.
   - **Fix First**: Prioritized, actionable remediation list (Structural -> Budget -> Trigger Clarity -> Script/Hygiene).
   - **Recommended Next Step**: Whether to split references, tighten triggers, or run a before/after scenario benchmark.
3. **Benchmarking Discipline**: When rewriting a skill, define 3–5 concrete prompt scenarios (positive triggers, negative boundary cases, and expected closure artifacts) and compare token cost and output compliance before vs. after.

---

## 4. Attribution
- Synthesized from `openai/plugins` (`plugins/plugin-eval`, `MIT` License).
