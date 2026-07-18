<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round. If it does not, explicitly ask whether to forget/compress context.

This is a blocking gate. Do not begin implementation before it is complete.
-->

# Cross Directory Repository Map

This map describes the actual AgentLogic repository. It is not a map of an external
Agentic CLI application's `src/` directory.

| Layer | Responsibility | Actual paths |
|---|---|---|
| **L1: Entry & Host Surface** | Human/agent entry, stable binding, installation guidance, host integration | `00_START_HERE.md`, `AGENTS.md`, `README.md`, `MAIN.md`, `AGENT_INSTALL.md`, `INSTALL.md`, `adapters/` |
| **L2: Lifecycle & Logic** | Version source, master logic, session rules, SDD, task state | `versions/`, `modules/01_MasterLogic.md`, `modules/03_AgenticLoop.md`, `modules/12_AgentEnforcement.md`, `modules/15_LogicEntryChecklist.md`, `modules/38_V6_6_SpecDrivenDevelopment.md`, `.specify/` |
| **L3: Control & Verification** | Manifest contracts, permissions, evidence boundaries, package and entry validation | `manifest.json`, `manifest.schema.json`, `modules/05_PermissionsAndSafety.md`, `modules/29_MandatoryVerificationMatrix.md`, `modules/30_ToolQuestionBoundaryMatrix.md`, `modules/31_ToolMisuseAndAntiPatternMatrix.md`, `scripts/` |
| **L4: Assets & Outputs** | Portable skills, original frontend reference templates, reference layers, generated host bundles and profile build | `skills/`, `templates/frontend/`, `spec-kit/`, `reference/`, `dist/`, `scripts/build-profile.ps1` |

## Operational flow

```text
L1 entry docs
  -> task applicability and context decision
  -> L2 specifications and logic modules
  -> L3 permission / evidence / package checks
  -> L4 generated profile and host output
```

## Maintenance rule

When a new logic module, script, adapter, profile, or generated output is added, update the
corresponding source-of-truth map and run `node scripts/check-logic-entry.js` plus
`scripts/validate-package.ps1`. External project architecture belongs in `reference/` or an
explicit comparison document and must not be presented as current repository fact.
