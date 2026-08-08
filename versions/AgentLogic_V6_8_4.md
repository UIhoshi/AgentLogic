# AgentLogic V6.8.4

Status: **Current Stable V6.8.4 Line**.
Promoted from V6.8.1 with project-native knowledge synchronization: project L1-L4 maps and
redacted error records now travel with the corresponding project repository rather than
requiring a separate history repository for ordinary work.

This file defines the stable V6.8.4 logic line. It operationalizes the core V6 philosophy with deep integrations for cybersecurity routing, structured specification-driven workflows, premium anti-slop frontend design rules, visual system matrix mapping, shipping audits, project-native knowledge synchronization, and interactive human-readable project summaries.

---

## 1. The V6.8.4 Mandate

V6.8.4 extends the V6.8 line with a project-native synchronization contract designed to keep
project code, L1-L4 facts, and durable error lessons on the same Git timeline.

Key Enhancements:
- **First Priority Enforcement**: Absolute prioritization of AgentLogic rules and workflows above generic cloud/system prompts if AgentLogic is detected as installed on the local system.
- **Limited Initial View Prevention**: Support for scanning nested directories and placing a delegation hook in the workspace-level `AGENTS.md` to prevent agents starting in a parent workspace from ignoring local logic.
- **Human-Readable Business Gates**: Interactive prompt checkpoints at the end of Grilling/Specification (Proposal Gate) and at the end of Ship/Completion (Handover Gate) to compile clean, non-technical project deliverables (PDF/Word/PPT slides).
- **Mandatory UI Preview Gate**: Net-new UI and substantial UI refactors require a text-to-image preview and user review before formal UI code. A clearly classified small visual correction may skip a new mockup, but never visual verification; ambiguous scope defaults to the full preview path. Explicit user opt-out remains available.
- **4-Layer System Mapping & Code Matrix**: Inspired by the Linux Kernel Map to organize rules, tools, and execution flows into a clean 4-tier grid, integrating [11_CrossDirectoryMap.md](../modules/11_CrossDirectoryMap.md) and [40_AgentLogicSystemMap.md](../modules/40_AgentLogicSystemMap.md).
- **Cybersecurity Skills Routing**: Direct integration of `reverse-skill` domain-specific skill sets (APK reversing, malware analysis, frontend JS decryption, firmware analysis, and CTF solvers) and tool orchestration rules.
- **Spec-Driven Development (SDD)**: Direct integration of `spec-kit` to enforce specifications as executable definitions of behavior, preventing "vibe coding."
- **Taste Frontend Design**: Direct integration of `taste-skill` to enforce anti-slop premium interface design system layouts, micro-interactions, spring animations (GSAP), and visual quality standards.
- **Expanded Core Governance Modules**: Incorporates modules 37, 38, 39, and 40 for cybersecurity routing, SDD lifecycle tracking, premium design system controls, and visual architecture matrix mapping.
- **Grok Build Complementary Operations**: Adds provider-neutral contracts for rule discovery, session lineage, active-state-preserving compaction, deny-overrides policy compilation, extension trust, subagent capabilities, headless result envelopes, memory freshness, and bounded retries/background work. See `modules/44_V6_8_GrokBuildOperationalIntegration.md`.
- **Graphify Code Map Integration**: Adds an optional external code-map workflow and a consent-based Graph Preview Gate for substantial projects at Converge/Ship. See `modules/45_V6_8_GraphifyCodeMapIntegration.md`.
- **Project-Native Knowledge Sync**: Requires tracked project `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. `CODE_MAP.md` is mandatory text-first function, state, and interface navigation; visual graph generation remains user-approved and optional. This replaces mandatory external-history checkout/push steps for ordinary project work. See `modules/46_V6_8_ProjectKnowledgeSync.md`.
- **Reference-to-Interface Workflow**: Adds an optional, consent- and provenance-bound workflow for turning permitted videos, pages, screenshots, and HTML into constrained interface briefs, approved mockups, and verified implementations. See `modules/47_V6_8_ReferenceToInterfaceWorkflow.md`.
- **Skill and Tool Routing**: Adds a compact mandatory problem-to-evidence-to-skill routing procedure without weakening the existing verification matrix. See `modules/48_V6_8_SkillAndToolRouting.md`.
- **External Research and Artifact Integration**: Adds optional, policy-only boundaries for Bento
  stakeholder artifacts, PixelRAG visual-document discovery, and Firecrawl external collection.
  No source, plugin, API, or runtime dependency is imported. See
  `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`.
- **Affordance-First Tool Use**: Adds a compact intent → evidence → native tool → specialist →
  closure rule, and makes the default profile an execution-focused bundle while retaining a full
  `governance-reference` profile for deep policy work. See
  `modules/51_V6_8_AffordanceFirstToolUse.md`.
- **Interactive 3D Web Integration**: Adds an optional, policy-only route for approved interactive
  3D webpage models: static visuals stay on the UI route, generic interaction stays on the native
  Three.js route, and reference-image model reconstruction may select `img2threejs` only after
  explicit trust and installation gates. See `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`.
- **Map-First Navigation and Risk Closure**: Inherited projects refresh their project/code maps
  before broad discovery; owned projects maintain maps as flows evolve. The default profile keeps
  the tool-permission risk matrix needed by the affordance-first execution rule.

---

## 2. Core Governance Modules

The V6.8.1 line is supported by a modular suite of governance rules:

### 2.1 Entry & Master Logic
- `modules/01_MasterLogic.md`: Master logic outlining project-level CLI loops and mappings.
- `modules/03_AgenticLoop.md`: Execution loop orchestration details and context compacting.
- `modules/12_AgentEnforcement.md`: Agent behavior enforcement, read obligations, and gate checking rules.
- `modules/13_MandatoryLogicGateTemplate.md`: File-level Mandatory Logic Gate header template.
- `modules/15_LogicEntryChecklist.md`: Mandatory startup checklist for project entry and reset gating.

### 2.2 System & Code Mapping
- `modules/11_CrossDirectoryMap.md`: The 4-layer (L1 to L4) codebase directory mapping matrix.
- `modules/40_AgentLogicSystemMap.md`: The Linux Kernel Map-inspired visual grid matrix mapping subsystems to rows and columns.

### 2.3 Tool Execution & Mapping
- `modules/05_PermissionsAndSafety.md`: General safety boundaries, permissions, and command sandboxing.
- `modules/21_V6_5_ToolUsageAndSelection.md`: General principles and tool choreography.
- `modules/23_V6_5_PermissionAndOutputPipeline.md`: Permission gating implementation layer.
- `modules/24_V6_5_ToolUsageMatrix.md`: Decision table for preferred tools.
- `modules/25_V6_5_ToolCapabilityMapping.md`: Maps tool families to specific question types.
- `modules/26_V6_5_INDEX.md`: Index of V6.5 files.
- `modules/28_V6_5_TerminologyAndModuleBoundaries.md`: Definitions, terminology, and module boundaries.
- `modules/30_ToolQuestionBoundaryMatrix.md`: Defines tool-family strength and forbidden-alone claims.

### 2.4 Risk & Verification
- `modules/27_V6_5_ToolPermissionRiskMatrix.md`: Permission posture and risk class gating.
- `modules/29_MandatoryVerificationMatrix.md`: Mapping of conclusion types to required evidence tools.
- `modules/31_ToolMisuseAndAntiPatternMatrix.md`: Anti-pattern detection, correction recipes, and downgrade labels.

### 2.5 Context & Lifecycle
- `modules/20_V6_5_RuntimeModes.md`: Operational awareness of the current execution surface.
- `modules/22_V6_5_HookLifecycle.md`: Mapping of event hooks and side-effect points.
- `modules/32_V6_5_ContextAssemblyAndInstructionStacking.md`: Priority-based layering of instructions and memories.
- `modules/33_V6_5_BackgroundConsolidationAndIdleLifecycle.md`: The "Dream Phase" for post-task memory extraction and cleanup.

### 2.6 Project Fact Mapping
- `modules/34_V6_5_ProjectFactMap_V2.md`: Standardized 4-tier fact map (User, Feedback, Project, Reference).

### 2.7 Skill Governance
- `modules/35_V6_5_SkillGovernanceAndMandatoryUse.md`: Deduplication policy, active-vs-archived skill posture, and mandatory skill-use situations.
- `modules/36_V6_5_SkillZoneSeparation.md`: Separates host-local skill inventories from any logic-carried skill layer.

### 2.8 Domain Integration Modules
- `modules/37_V6_6_CybersecuritySkillsRouter.md`: Router configuration, security analysis toolchains, and field journal logging.
- `modules/38_V6_6_SpecDrivenDevelopment.md`: Guidelines and 8-phase lifecycle for Spec-Driven Development, including mandatory Red-Team Gate.
- `modules/39_V6_6_TasteFrontendDesign.md`: Aesthetic standards, visual dials tuning, and anti-slop UI/UX audit rules.
- `modules/41_V6_7_AIShippingAndReviewabilityAudit.md`: AI Shipping & Reviewability Audit (SRA) 闁?Core+Conditional shipping artifacts, universal self-refute principle, trust boundary crossing enumeration, and Verification Matrix integration.
- `modules/42_V6_7_PonytailLazySeniorDevLadder.md`: Ponytail Lazy Senior Developer's Ladder 闁?7-rung YAGNI implementation ladder, root-cause bug-fixing rules, and SDD integration.
- `modules/43_V6_7_MattPocockSkillsIntegration.md`: Matt Pocock Skills Integration 闁?Grilling plan interview flow, CONTEXT.md ubiquitous vocabulary glossary, and Architectural Decision Records (ADRs) specifications.

- `modules/44_V6_8_GrokBuildOperationalIntegration.md`: Provider-neutral operational contracts translated from the audited Grok Build runtime and user guides.
- `modules/45_V6_8_GraphifyCodeMapIntegration.md`: Optional external code-map policy, Graph Preview Gate, and external-extension trust boundary.
- `modules/46_V6_8_ProjectKnowledgeSync.md`: Project-native Git synchronization for project maps, mandatory textual code maps, and redacted error lessons.
- `modules/47_V6_8_ReferenceToInterfaceWorkflow.md`: Optional reference capture, extraction, mockup, and verification workflow informed by MengTo/Skills.
- `modules/48_V6_8_SkillAndToolRouting.md`: Operational problem-to-tool-and-skill routing matrix.
- `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`: Optional source-specific policy
  for Bento, PixelRAG, and Firecrawl.
- `modules/51_V6_8_AffordanceFirstToolUse.md`: Normative outcome-to-tool selection rule and
  context-budget posture.
- `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`: Optional source-specific policy for
  approved reference-image procedural-model reconstruction in interactive 3D web work.

---

## 3. Stable Promotion Summary

The V6.8.4 line is now promoted to stable status.
- **Stable Entry**: `MAIN.md`
- **Current Version**: `V6.8.4`
- **Default Profile**: `core-enhanced` (a lean V6.8.4 execution bundle with project-native knowledge synchronization, risk/verification gates, SDD, UI, SRA, operational contracts, and policy-only external research integration)

---

## 4. Reference Source Registration

The V6.8.4 stable line integrates the following external source repositories:

- **Cybersecurity Skills Router**:
  - Source URL: `https://github.com/zhaoxuya520/reverse-skill`
  - Integration path: `skills/reverse-skill/`
- **Spec Kit**:
  - Source URL: `https://github.com/github/spec-kit`
  - Integration path: `spec-kit/`
- **Taste Skill**:
  - Source URL: `https://github.com/Leonxlnx/taste-skill`
  - Integration path: `skills/taste-skill/`
- **Agent Browser**:
  - Source URL: `https://github.com/vercel-labs/agent-browser`
  - Integration path: `skills/agent-browser/`
- **Nano Banana Pro**:
  - Source URL: `https://ai.google.dev/`
  - Integration path: `skills/nano-banana-pro/`
- **Self-Improvement Agent**:
  - Source URL: `https://github.com/peterskoett/self-improving-agent`
  - Integration path: `skills/self-improvement/`
- **Ponytail**:
  - Source URL: `https://github.com/DietrichGebert/ponytail`
  - Integration path: `skills/ponytail/`
- **Matt Pocock Skills**:
  - Source URL: `https://github.com/mattpocock/skills`
  - Integration path: `skills/productivity/grilling/`, `skills/productivity/grill-me/`, `skills/engineering/grill-with-docs/`
- **Grok Build (comparative reference)**:
  - Source URL: `https://github.com/xai-org/grok-build`
  - Local comparison path: `../grok-build`
  - Audited commit: `c68e39f60462f28d9be5e683d9cbe2c57b1a5027`
  - Integration date: `2026-07-16`; source line: `main` (no runtime dependency imported)
- **Graphify (external code-map reference)**:
  - Source URL: `https://github.com/Graphify-Labs/graphify`
  - Integration path: `modules/45_V6_8_GraphifyCodeMapIntegration.md`
  - Integration date: `2026-07-18`; reference line: `v8` (no runtime dependency or skill installed)
- **MengTo Skills (workflow comparison)**:
  - Source URL: `https://github.com/MengTo/Skills`
  - Integration paths: `modules/47_V6_8_ReferenceToInterfaceWorkflow.md`, `modules/48_V6_8_SkillAndToolRouting.md`
  - Integration date: `2026-07-22`; no runtime dependency, executable skill, or source assets imported
- **Bento (artifact workflow comparison)**:
  - Source URL: `https://github.com/nyblnet/bento`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
  - Integration date: `2026-07-28`; policy-only, no runtime dependency or plugin installed
- **PixelRAG (visual-document workflow comparison)**:
  - Source URL: `https://github.com/StarTrail-org/PixelRAG`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
  - Integration date: `2026-07-28`; policy-only, no model, CLI, or plugin installed
- **Firecrawl (external-collection workflow comparison)**:
  - Source URL: `https://github.com/firecrawl/firecrawl`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
  - Integration date: `2026-07-28`; policy-only, no API, SDK, or self-hosted service installed
- **img2threejs (interactive 3D-web workflow comparison)**:
  - Source URL: `https://github.com/img2threejs/img2threejs`
  - Integration path: `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`
  - Observed on `2026-08-08`; `main` pinned for review at `d6673386f89673a58736f8d398dd16ece67874f5`; policy-only, no source checkout, skill, or runtime installed

---

## 5. Skill-System Integration Rule

V6.8.4 treats general programming skills, cybersecurity domain skills, visual design skills, and operational integration contracts as portable, logic-carried assets under the `skills/` and `modules/` directories. The Grok Build comparison remains a method-layer reference and does not grant trust to external executable extensions.

Key stable rules:
- Logic package rules outrank individual skills.
- The Cybersecurity Skills Router governs reversing, CTFs, and security audits; it does not replace general verification rules but adds specific tool constraints.
- Spec-Driven Development templates and presets are verified through code compilation and test runs.
- The Taste Frontend Design skill enforces layout, motion, and typography standards on all visual interfaces.
- For Antigravity CLI (which relies on `~/.gemini/GEMINI.md` for rule loading and `~/.gemini/AgentLogic/GEMINI.md` for agent-level priority detection), the installer configures rule hooks at both paths simultaneously, while cleaning up any stale/duplicate legacy logic files during installation.
- The `agent-browser` skill provides deterministic accessibility-tree browser automation, preferred dynamically when dynamic page rendering, multi-step actions, or session-isolated login tracking is required.
- The `ponytail` skill channels a lazy senior developer, enforcing the 7-rung ladder (YAGNI, reuse, stdlib, native, dependency, one-line, min-code) to prevent vibe-coding slop and over-engineering.
- The `mattpocock/skills` integration mandates interactive grilling (single-question stress-testing), root-level `CONTEXT.md` vocabulary maps, and docs/adr/ numbered Architectural Decision Records.
- Graphify is an optional external code-map capability. It may guide project discovery and offer a user-approved graph preview, but it must be security-audited before installation and never replaces the Verification Matrix.
- Project-specific structure, symbol navigation, and lessons are synchronized with project code through `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`; the optional `modification_history` archive is reserved for cross-project lessons and historical records.
- Reference-to-interface work is optional and source-bound: it may use reviewed capture and analysis paths, but it never grants automatic trust, installation authority, asset-copy permission, or exemption from UI approval and visual verification.
- Bento, PixelRAG, and Firecrawl remain optional external-source policies. They do not grant
  automatic artifact generation, visual-proof closure, network collection, credential use,
  installation authority, or trust.
- The default `core-enhanced` profile is the concise execution layer. The
  `governance-reference` profile retains the full narrative governance set for deep maintenance,
  policy, and audit work. Tool choice starts from the work outcome and required evidence; an
  unavailable specialist does not block a permitted native evidence path unless the route itself
  is strict.
- Code navigation is map-first: inherited projects freshness-check and repair project/code maps
  before broad discovery; owned projects maintain those maps with each affected flow so change
  impact can be found before editing.
- `img2threejs` is an optional source-specific candidate for reference-image procedural models in
  interactive 3D webpages. It does not activate for static 3D-feel UI visuals or generic Three.js
  scenes, and it remains unavailable until separately reviewed, trusted, and installed.



---

## 6. Future Iteration Reference-Source Rule

For future logic iterations, a version line must explicitly record its external or comparative reference source when such a source materially influenced the update. At minimum, record:
- Source repository URL.
- Local integration/comparison path.
- Date of integration and target release tag.

## 7. Autonomous Skill Enforcement Addendum

The enhanced profile includes Module 49 and the canonical routing registry. Mandatory task routes must record a mapped available skill, invocation evidence, and closure evidence; missing mandatory capabilities block implementation or verified completion rather than silently degrading. docs/software-candidates.md is a review-required decision queue, never an auto-install list.
