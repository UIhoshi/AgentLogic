# V6.5 Draft Index

Status: draft only.
This file is the local index for the current V6.5 exploration line.
It is not a stable host entrypoint.

---

## 1. Purpose

The V6.5 draft line exists to capture structural lessons from advanced agentic CLI systems without prematurely replacing the stable V6 line.

The strongest current themes are:

- runtime awareness
- tool governance
- mandatory verification discipline
- question-strength boundaries for tool families
- anti-pattern detection and downgrade labeling
- hook lifecycle clarity
- permission/output pipeline clarity

---

## 2. Current draft files

### Core draft overview

- `versions/AgentLogic_V6_5_DRAFT.md`

### Core governance modules

These are the most practically important modules in the current draft line.
They describe how the agent should act.

- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `modules/29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
- `modules/30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
- `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

### Supporting structural modules

These modules explain the surrounding system structure that tool governance depends on.

- `modules/20_V6_5_RuntimeModes_DRAFT.md`
- `modules/22_V6_5_HookLifecycle_DRAFT.md`
- `modules/23_V6_5_PermissionAndOutputPipeline_DRAFT.md`

### Consolidation/support modules

These modules help keep the draft line readable and promotion-ready.

- `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

---

## 3. Recommended reading order for V6.5 draft work

### Fast practical path

Use this path when the immediate goal is to improve agent execution behavior.

1. `versions/AgentLogic_V6_5_DRAFT.md`
2. `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
3. `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
4. `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
5. `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
6. `modules/29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
7. `modules/30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
8. `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`
9. `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

### Full structural path

Use this path when the goal is broader system modeling or future promotion work.

1. `versions/AgentLogic_V6_5_DRAFT.md`
2. `modules/20_V6_5_RuntimeModes_DRAFT.md`
3. `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
4. `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
5. `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
6. `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
7. `modules/29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
8. `modules/30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
9. `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`
10. `modules/22_V6_5_HookLifecycle_DRAFT.md`
11. `modules/23_V6_5_PermissionAndOutputPipeline_DRAFT.md`
12. `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

---

## 4. Module relationship map

The intended relationship is:

- `20_RuntimeModes` explains **where the agent is operating**
- `21_ToolUsageAndSelection` explains **how the agent should choose tools**
- `24_ToolUsageMatrix` explains **which tool family should be preferred in which task/phase/mode**
- `25_ToolCapabilityMapping` explains **what kinds of questions each tool family is good at answering**
- `27_ToolPermissionRiskMatrix` explains **how each tool family should be gated by permission posture and risk class**
- `29_MandatoryVerificationMatrix` explains **which conclusion types require which tool families and what counts as minimum pass evidence**
- `30_ToolQuestionBoundaryMatrix` explains **which question types each tool family may answer strongly, support only, or never close alone**
- `31_ToolMisuseAndAntiPatternMatrix` explains **what common tool anti-patterns look like, why they are invalid, and which correction paths should replace them**
- `22_HookLifecycle` explains **where extension points and side effects sit in the execution loop**
- `23_PermissionAndOutputPipeline` explains **how permissions and outputs travel across boundaries**
- `28_TerminologyAndModuleBoundaries` explains **the glossary and ownership boundary of each draft module**

---

## 5. Which draft files matter most right now

### Highest immediate practical value

- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `modules/29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
- `modules/30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
- `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

Reason:

These files are the most direct answer to the question:

> how does the agent gain more useful hands and feet without becoming more dangerous or more falsely certain?

They define:

- which tool families exist conceptually
- when each family should be used
- when each family must not be used
- what kinds of questions each family is actually good at answering
- which conclusion types require stronger verification paths
- what common weak-closure patterns must be rejected

---

## 6. First promotion targets

If V6.5 later promotes into a stable V6.x line, the most likely first promotion candidates are:

1. `21_V6_5_ToolUsageAndSelection_DRAFT.md`
2. `24_V6_5_ToolUsageMatrix_DRAFT.md`
3. `25_V6_5_ToolCapabilityMapping_DRAFT.md`
4. `27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
5. `29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
6. `30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
7. `31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

Reason:

These modules create the strongest practical behavior change with the least dependence on repository-specific architecture.

---

## 7. Local organization summary

The current local split is:

### Stable-line hardening work

- `versions/AgentLogic_V6_5.md`
- `modules/01_MasterLogic.md`
- `modules/04_Tools.md`
- `modules/12_AgentEnforcement.md`
- `modules/29_MandatoryVerificationMatrix.md`
- `modules/30_ToolQuestionBoundaryMatrix.md`
- `modules/31_ToolMisuseAndAntiPatternMatrix.md`

### Draft-line expansion work

- `versions/AgentLogic_V6_5_DRAFT.md`
- `modules/20_V6_5_RuntimeModes_DRAFT.md`
- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/22_V6_5_HookLifecycle_DRAFT.md`
- `modules/23_V6_5_PermissionAndOutputPipeline_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/26_V6_5_DRAFT_INDEX.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`
- `modules/29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
- `modules/30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
- `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

---

## 8. Promotion criteria for future stable adoption

The V6.5 draft line should not be promoted just because the modules exist.
By default, promotion should require:

1. validation across more than one repository type
2. proof that the tool-governance matrices reduce bad tool choices in practice
3. proof that runtime-mode distinctions improve analysis or validation quality
4. proof that permission/output pipeline mapping reduces cross-mode confusion
5. proof that the mandatory-verification, question-boundary, and anti-pattern modules reduce false certainty in real tasks

---

## 9. Current recommendation

Treat V6.5 as:

- a draft research line
- a modular experimentation layer
- a staging area for future stable V6.x promotion

Treat `versions/AgentLogic_V6_5.md` as the promoted stable file, and treat this index as the organization layer for the local draft/archive line.

---

## 10. Candidate future stable V6.5 shape

If this line is later promoted, the most likely stable structure is:

1. one overview/version file
2. one runtime mode module
3. one general tool governance module
4. one tool decision matrix module
5. one tool capability mapping module
6. one tool permission/risk module
7. one mandatory verification matrix module
8. one tool question-boundary matrix module
9. one tool misuse/anti-pattern matrix module
10. one hook lifecycle module
11. one permission/output pipeline module
12. one terminology/glossary appendix or absorbed overview section

The exact file count can still change, but the **concept structure** should remain close to this.

---

## 11. Updated keep-vs-merge recommendation

### Keep as long-term core governance modules

- `21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `24_V6_5_ToolUsageMatrix_DRAFT.md`
- `25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
- `30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
- `31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

### Keep as supporting structural modules

- `20_V6_5_RuntimeModes_DRAFT.md`
- `22_V6_5_HookLifecycle_DRAFT.md`
- `23_V6_5_PermissionAndOutputPipeline_DRAFT.md`

### Most likely merge-back candidate

- `28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

This file remains useful during draft-stage consolidation, but in a stable line it is more likely to be absorbed into a glossary, overview, or appendix layer.
