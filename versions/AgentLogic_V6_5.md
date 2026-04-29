# AgentLogic V6.5

Status: **Current Stable V6.5 Line**.
Promoted from the comparative research of advanced agentic CLI systems (including `claude-code`).

This file defines the stable V6.5 logic line. It operationalizes the core V6 philosophy with deeper rules for tool governance, runtime awareness, and mandatory verification.

---

## 1. The V6.5 Mandate

V6.5 is a **mid-line expansion** designed for high-scale agentic systems where "code exists" is insufficient proof of "capability is available."

Key Enhancements:
- **Runtime Mode Taxonomy**: Explicitly distinguishes between REPL, Headless, SDK, Daemon, Bridge, and Packaging modes.
- **Tool Governance Matrix**: Standardizes tool choice by task type, phase, and risk level.
- **Mandatory Verification**: Requires explicit evidence chains (build, runtime, or visual) before declaring a task "Verified."
- **Permission & Output Pipelines**: Models trust and result delivery as end-to-end pipelines.
- **Architecture Debt Diagnosis**: Mandates the recording of "God Components" and oversized files as formal debt.

---

## 2. Core Governance Modules

The V6.5 line is supported by a modular suite of governance rules:

### 2.1 Tool Execution & Mapping
- `modules/21_V6_5_ToolUsageAndSelection.md`: General principles and tool choreography.
- `modules/24_V6_5_ToolUsageMatrix.md`: Decision table for preferred tools.
- `modules/25_V6_5_ToolCapabilityMapping.md`: Maps tool families to specific question types.
- `modules/30_V6_5_ToolQuestionBoundaryMatrix.md`: Defines tool-family strength and forbidden-alone claims.

### 2.2 Risk & Verification
- `modules/27_V6_5_ToolPermissionRiskMatrix.md`: Permission posture and risk class gating.
- `modules/29_V6_5_MandatoryVerificationMatrix.md`: Mapping of conclusion types to required evidence tools.
- `modules/31_V6_5_ToolMisuseAndAntiPatternMatrix.md`: Anti-pattern detection, correction recipes, and downgrade labels.

### 2.3 Context & Lifecycle
- `modules/20_V6_5_RuntimeModes.md`: Operational awareness of the current execution surface.
- `modules/22_V6_5_HookLifecycle.md`: Mapping of event hooks and side-effect points.
- `modules/32_V6_5_ContextAssemblyAndInstructionStacking.md`: Priority-based layering of instructions and memories.
- `modules/33_V6_5_BackgroundConsolidationAndIdleLifecycle.md`: The "Dream Phase" for post-task memory extraction and cleanup.

### 2.4 Project Fact Mapping
- `modules/34_V6_5_ProjectFactMap_V2.md`: Standardized 4-tier fact map (User, Feedback, Project, Reference).

---

## 3. Stable Promotion Summary

The V6.5 line is now promoted from draft status.
- **Stable Entry**: `MAIN.md`
- **Current Version**: `V6.5`
- **Default Profile**: `core-enhanced` (now includes all V6.5 modules)

Agents adopting this line must strictly follow the **Mandatory Verification Matrix** and the **Tool Usage Choreography** defined in the modules above.


---

## 4. Reference Source Registration

The V6.5 stable line was derived in part from structured comparison against the following external source repository:

- Primary external reference source: `https://github.com/claude-code-best/claude-code`
- Local comparison path used during promotion: `D:\workspace\claude-code`

This reference source informed the V6.5 additions around:

- runtime mode taxonomy
- tool governance
- mandatory verification
- question-boundary mapping
- tool anti-pattern detection

## 5. Future Iteration Reference-Source Rule

For future logic iterations, a version line must explicitly record its external or comparative reference source when such a source materially influenced the update.

At minimum, record:

- source repository URL
- local comparison path when used
- whether the source fed the stable line or only a draft line
- tag, commit, or inspection date when practical

A version iteration should not be treated as fully documented if the reference source baseline was materially used but never recorded.
