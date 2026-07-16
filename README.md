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

# 🌌 AgentLogic: Autonomous Evolving Rule Engine (V6.8.1)

[![Agentic Code](https://img.shields.io/badge/Agent-Autonomous-blueviolet?style=flat-square)](https://github.com/UIhoshi/AgentLogic)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-V6.8.1_Stable-emerald?style=flat-square)](./versions/AgentLogic_V6_8_1.md)

AgentLogic is a versioned primary-logic package designed to be pulled into local AI coding hosts (such as Codex, Claude Code, Gemini Pro) and used as their default operating mind. It consolidates multi-turn session workflows, tool selection matrix, security sandbox auditing, and dynamic domain extensions.

> [!IMPORTANT]
> **Repository Gating Warning**: This repository represents core logic infrastructure, not a generic business workspace.
> Before starting any code modifications or host installations, AI agents **MUST** anchor to `00_START_HERE.md` and complete the mandatory startup logic entry check.

---

## 🚀 Quick Start & Deployment

For local diagnostic runs and host deployment, execute the following commands in sequence:

| Step | PowerShell Command | Primary Purpose |
| :--- | :--- | :--- |
| **1. Diagnosis** | `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1` | Analyzes repository layout, checks manifests, and recommends installers |
| **2. Install** | `powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost antigravity` | Validates, builds, verifies, and deploys the fresh host-ready ruleset |
| **3. Validation** | `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1` | Verifies structural link integrity and validates the compiled adapter bundles |

---

## 🏗️ 4-Layer Architecture Matrix (Grid & Subsystems)

We organize rules and code into a **4-layer progressive abstraction model** to prevent context budget bloat:

```mermaid
graph TD
    subgraph L1 [L1: Strategy & Entry Layer]
        Entry[MAIN.md / AGENTS.md] --> Startup{Startup Gate}
        Startup --> Check[00_START_HERE.md]
    end
    subgraph L2 [L2: Session & Loop Layer]
        Check --> Loop[03_AgenticLoop.md]
        Loop --> SDD[38_SpecDrivenDevelopment.md]
    end
    subgraph L3 [L3: Control & Auditing Layer]
        SDD --> Verify[29_MandatoryVerificationMatrix.md]
        Verify --> Taste[39_TasteFrontendDesign.md]
    end
    subgraph L4 [L4: Base & Drivers Layer]
        Taste --> Skills[skills/ agent-browser & nano-banana-pro]
    end
```

### Detailed Module Mapping

| Abstraction Layer | Primary Core Responsibility | Included Files / Directories |
| :--- | :--- | :--- |
| **L1: Strategy & Entry** | Defines entrypoints, environment injection, REPL startup gates, and context forget/reset rules. | - [00_START_HERE.md](./00_START_HERE.md) (起手式)<br>- [MAIN.md](./MAIN.md) (Stable Host Binding)<br>- [AGENTS.md](./AGENTS.md) (Agent Entry)<br>- [15_LogicEntryChecklist.md](./modules/15_LogicEntryChecklist.md) (Gate Checklist)<br>- [13_MandatoryLogicGateTemplate.md](./modules/13_MandatoryLogicGateTemplate.md) (Header Gating) |
| **L2: Session & Loop** | Manages the single-turn execution cycle, prevents vibe-coding, and structures the SDD lifecycle. | - [03_AgenticLoop.md](./modules/03_AgenticLoop.md) (Agentic Cycle)<br>- [38_SpecDrivenDevelopment.md](./modules/38_V6_6_SpecDrivenDevelopment.md) (SDD Lifecycle)<br>- [20_V6_5_RuntimeModes.md](./modules/20_V6_5_RuntimeModes.md) (Context Adaptation)<br>- [28_V6_5_TerminologyAndModuleBoundaries.md](./modules/28_V6_5_TerminologyAndModuleBoundaries.md) (Boundary Rules) |
| **L3: Control & Auditing** | Establishes high-friction verification rules, security-risk matrix, and visual frontend taste checks. | - [29_MandatoryVerificationMatrix.md](./modules/29_MandatoryVerificationMatrix.md) (Verification Matrix)<br>- [39_TasteFrontendDesign.md](./modules/39_V6_6_TasteFrontendDesign.md) (Aesthetic & Spacing Audit)<br>- [30_ToolQuestionBoundaryMatrix.md](./modules/30_ToolQuestionBoundaryMatrix.md) (Credential Boundary)<br>- [31_ToolMisuseAndAntiPatternMatrix.md](./modules/31_ToolMisuseAndAntiPatternMatrix.md) (Anti-Pattern Gating) |
| **L4: Base & Drivers** | Low-level command execution, raw tool controllers, and active portable skill files. | - `skills/` (Logic-Carried Domain Skills)<br>  * [agent-browser](./skills/agent-browser/) (Accessibility Browser CLI)<br>  * [nano-banana-pro](./skills/nano-banana-pro/) (Gemini Mockup Engine)<br>  * [self-improvement](./skills/self-improvement/) (Error Log & Self-Correction)<br>- [35_V6_5_SkillGovernanceAndMandatoryUse.md](./modules/35_V6_5_SkillGovernanceAndMandatoryUse.md) (Governance Rules) |

---

## 🛠️ Self-Improvement & Learning Feed

This rule package supports **automated self-evolution** and developer logging:

```
[Unexpected Error / User Correction / Best Practice Found]
                      │
                      ▼ (1) Automatically log to:
       .learnings/ (LEARNINGS.md / ERRORS.md)
                      │
                      ▼ (2) Exceeds threshold (Recurrence >= 3)
      Systemic rules extracted and merged into:
            CLAUDE.md / AGENTS.md
```

> [!TIP]
> **Design-First Prototyping Gate**: Before any formal UI implementation, the agent must use text-to-image generation to produce a mockup, show it to the user, and wait for review. The only bypass is an explicit user instruction not to use this step.

---

## 📚 External References & Integrated Sources

During its evolutionary cycles, AgentLogic has integrated concepts and structures from the following open-source GitHub projects:

| Project Source | GitHub Repository | Primary Concept Integrated |
| :--- | :--- | :--- |
| **Linux Kernel Map** | [makelinux/linux_kernel_map](https://github.com/makelinux/linux_kernel_map) | Inspired the 4-layer structural system layout grid ([40_AgentLogicSystemMap.md](./modules/40_AgentLogicSystemMap.md)) |
| **Agent Browser** | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | Provided deterministic ref-based headless browser automation optimized for AI agents |
| **Nano Banana Pro** | [google-gemini/imagen](https://ai.google.dev/) | Supported high-fidelity visual UI mockup generation and layout prototyping for design-first workflows |
| **Self-Improvement Agent** | [peterskoett/self-improving-agent](https://github.com/peterskoett/self-improving-agent) | Enabled structured error logging, user-correction tracking, and recursive pattern hardening |
| **Spec Kit** | [github/spec-kit](https://github.com/github/spec-kit) | Formulated Spec-Driven Development (SDD) code-writing phases and task constraints |
| **Taste Skill** | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | Outlined physics spring animations, HSL palette controls, and typographical kerning guidelines |
| **PM Skills (AI Shipping)** | [phuryn/pm-skills](https://github.com/phuryn/pm-skills) | Establishes the AI Shipping & Reviewability Audit (SRA) protocol to restore human reviewability |
| **Ponytail (Lazy Dev)** | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | Enforces the 7-rung ladder (YAGNI, reuse, stdlib, native, dependency, one-line, min-code) to cut code bloat |
| **Matt Pocock Skills** | [mattpocock/skills](https://github.com/mattpocock/skills) | Integrates interactive grilling, `CONTEXT.md` vocabulary maps, and Architecture Decision Records (ADRs) |
| **Cybersecurity Skills Router** | [zhaoxuya520/reverse-skill](https://github.com/zhaoxuya520/reverse-skill) | Outlines malware analysis, APK reversing, frontend JS decryption, and firmware audit routing |
| **Grok Build (comparative reference)** | [xai-org/grok-build](https://github.com/xai-org/grok-build) | Compares provider-neutral runtime execution, state-preserving compaction, and deny-overrides policies |

---

## ⚖️ Maintenance Constraints

1. **Keep it Pure**: No business logic or project-specific implementations should be written into `AgentLogic` rule files.
2. **Specify Before Writing**: Always compile technical blueprints to `.specify/spec.md` and `.specify/plan.md` before touching code.
3. **Generate via Bundle**: Never edit `dist/` bundles manually. Always write updates to version files (e.g. `versions/AgentLogic_V6_8_1.md`), then run `build-profile.ps1` to rebuild the adapter targets.
## V6.8 Operational Integration

The default `core-enhanced` profile includes
[`modules/44_V6_8_GrokBuildOperationalIntegration.md`](./modules/44_V6_8_GrokBuildOperationalIntegration.md).
It translates useful provider-neutral patterns from
[`xai-org/grok-build`](https://github.com/xai-org/grok-build) into contracts for
rule discovery, session state, compaction, permissions, extension trust,
subagents, headless execution, memory freshness, and bounded background work.
These contracts complement—not replace—the existing SDD, Red-Team, SRA,
verification, and history-synchronization gates.
