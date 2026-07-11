# AgentLogic V6.5 Draft

Status: historical exploratory draft that fed the promoted stable V6.5 line.

This file remains a local exploratory record.
It does not replace the current stable file `versions/AgentLogic_V6_7_0.md`.
Its purpose is to preserve the draft-stage reasoning, comparisons, and module-shaping decisions that led to the promoted V6.5 line.

---

## 1. Why V6.5 instead of V7

This comparison suggests a **mid-line expansion**, not a full generation change.

The newly observed value is not a different philosophy from V6.
It is a deeper operationalization of the same V6 concerns in a large agentic CLI system:

- entry discipline
- agent loop structure
- tool orchestration
- permissions
- extensibility
- packaging boundaries
- capability-state labeling

Therefore the current recommendation is:

- keep `V6` as the stable baseline
- collect the additional structure as `V6.5` draft material
- promote only after the added rules are validated across more than one project

---

## 2. External source baseline used for this draft

Primary comparison target cloned locally:

- Repository: `https://github.com/claude-code-best/claude-code`
- Local path: `D:\workspace\claude-code`
- Checked commit: `4f1649e2490adf930272ada3b54b1b48115e6dd2`

Current AgentLogic baseline used for comparison:

- Repository: `https://github.com/UIhoshi/AgentLogic`
- Local path: `D:\workspace\AgentLogic`
- Checked commit: `64583409522d4243f755a6c067004d099d4bae69`

Key comparison evidence files from `claude-code`:

- `README.md`
- `AGENTS.md`
- `V6.md`
- `package.json`
- `src/entrypoints/cli.tsx`
- `src/main.tsx`
- `src/query.ts`
- `src/QueryEngine.ts`
- `src/services/api/claude.ts`
- `src/services/acp/`
- `src/bridge/`
- `src/Tool.ts`
- `src/tools.ts`
- `packages/builtin-tools/src/tools/`
- `packages/acp-link/`
- `packages/remote-control-server/`
- `docs/features/`

Observed repository scale indicators during inspection:

- `src/` TypeScript files: about `2142`
- `packages/` subdirectories: about `261`
- `docs/features/` files: `43`
- builtin tool subdirectories: `59`

These numbers matter because they show the comparison target is large enough to reveal coordination rules that do not surface in smaller repositories.

---

## 3. What V6 already covers well

Current `AgentLogic_V6` already captures the following correctly:

- read-before-write discipline
- project markdown precedence
- distinction between method layer and project fact layer
- tool and permission integration as system-level concerns
- capability-state recording (`implemented`, `stub`, `conditionally enabled`, etc.)
- logic-entry enforcement
- packaging boundaries for logic packages
- README/publication discipline

Those foundations should remain the base of any V6.5 work.

---

## 4. What the claude-code comparison adds beyond current V6 wording

### 4.1 Runtime mode taxonomy should become explicit

In large agentic CLIs, "the program" is not one mode.
It is multiple runtime surfaces with different constraints.

Observed in `claude-code`:

- `src/entrypoints/cli.tsx` dispatches multiple fast paths before the full CLI boots
- `src/main.tsx` contains the main interactive CLI command surface
- the repository separately supports REPL, headless/pipe, MCP/server modes, remote control, ACP, daemon workers, and maintenance commands

Therefore V6.5 should explicitly require agents to distinguish:

- interactive terminal mode
- headless / pipe / structured-output mode
- SDK or programmatic mode
- server / daemon / background-worker mode
- bridge / remote-control mode
- installer / updater / packaging mode

This distinction should be treated as an architectural fact, not a UI detail.

### 4.2 Feature-flag governance should be a first-class architecture rule

Observed in `claude-code`:

- `package.json` and build scripts expose a substantial feature-flag surface
- `README.md` documents `FEATURE_<FLAG_NAME>=1`
- `V6.md` treats feature-gated capabilities as a core architectural dimension

Current V6 discusses capability state, but V6.5 should go further and require explicit recording of:

- where a feature flag is defined
- whether it affects build-time or runtime behavior
- the default state in dev vs build vs release
- whether a capability is disabled, hidden, partial, or internal-only

This closes the gap between "code exists" and "capability is actually available".

### 4.3 The agent loop should include a hook lifecycle model

Observed in `claude-code`:

- `src/query.ts` handles the turn loop
- `src/QueryEngine.ts` adds session-level orchestration
- the repository architecture documents pre/post tool hooks, compaction, notifications, permission callbacks, and stop/recovery paths

V6.5 should promote a more explicit lifecycle model around the agent loop:

- pre-query
- pre-tool-use
- post-tool-use
- permission decision point
- pre-compact
- post-compact
- session start/end
- stop/abort/recovery
- sub-agent stop or handoff

This is important because large systems become difficult to extend safely when hook points are implicit.

### 4.4 Provider, auth, transport, and stream adaptation should be separated conceptually

Observed in `claude-code`:

- `src/services/api/claude.ts` is not only a model caller; it mediates request shape and stream processing
- multiple providers are supported
- `V6.md` proposes adapter separation between provider, auth, stream normalization, and network layer

V6.5 should require agents to distinguish these layers when documenting or restructuring large AI systems:

- provider adapter
- auth provider
- stream adapter / event normalization
- network / proxy / CA / mTLS layer
- model catalog / model selection layer

Without this separation, provider support is often incorrectly documented as a single monolith.

### 4.5 Tool registration needs layered source-of-truth classification

Observed in `claude-code`:

- `src/Tool.ts` defines the tool contract
- `src/tools.ts` assembles runtime tool registration
- `packages/builtin-tools/src/tools/` contains the actual builtin tool implementations
- docs separately expose MCP, browser, computer-use, ACP, and feature-specific tool surfaces

V6 already cares about tools, but V6.5 should explicitly classify tool sources as:

- builtin static tools
- dynamically registered MCP tools
- plugin-provided tools
- user or workspace-local tools
- remote-only tools
- feature-flagged tools

Agents should record not only what a tool does, but also how it enters the registry.

### 4.6 Permission systems should be modeled as pipelines, not isolated checks

Observed in `claude-code`:

- permission-related logic spans tool usage, ACP bridging, planning, and remote modes
- the repository documents permission mode synchronization and ACP permission fallback paths

V6.5 should add a rule that the permission layer must be mapped as a pipeline:

- request origin
- tool classification
- policy/rule match
- ask/allow/deny decision
- fallback behavior
- denial tracking or behavior adaptation
- cross-mode propagation (e.g. REPL to bridge to ACP)

This is stronger than simply listing permission files.

### 4.7 Output targets should be documented independently from business logic

Observed in `claude-code` architecture materials:

- terminal UI, JSON/SDK output, bridge output, and remote-control delivery are separate concerns

V6.5 should require output-target mapping in agentic systems:

- terminal/TTY output
- JSON or machine-readable output
- web/socket/event-stream output
- silent/background output
- notification output

That output map should be documented separately from the core reasoning loop.

### 4.8 Large monolith detection should become a formal refactor trigger

Observed in `claude-code`:

- `V6.md` explicitly calls out oversized files and "god component" patterns such as very large `main.tsx`, `REPL.tsx`, and session task files

V6 currently says to plan before refactoring, but V6.5 should explicitly allow and encourage architectural diagnosis when the agent sees:

- oversized entry files
- giant action handlers
- god components
- state objects that mix too many domains
- feature branches collapsed into string-based dispatch chains

The rule should not force refactors automatically.
It should force the diagnosis to be recorded.

### 4.9 Domain packages should be separated from UI packages in system maps

Observed in `claude-code`:

- `packages/builtin-tools/`
- `packages/acp-link/`
- `packages/remote-control-server/`
- `packages/@ant/*`
- native or transport packages

V6.5 should require package-level classification in large monorepos:

- pure domain logic packages
- UI framework packages
- platform/native bridge packages
- transport/protocol packages
- operational infrastructure packages
- documentation-only or support packages

This helps future maintainers avoid treating every package as equal.

### 4.10 Telemetry and operational diagnostics should be recognized as first-class subsystems

Observed in `claude-code`:

- `README.md` exposes Langfuse monitoring
- the architecture notes mention analytics, tracing, and feature experimentation surfaces

V6.5 should say that telemetry is not just optional logging when the project already depends on it for real operations.
Agents should record:

- whether telemetry is local, remote, optional, or mandatory
- whether it affects feature rollout
- whether it changes behavior in dev vs release
- whether it carries security or privacy implications

---

## 5. Candidate V6.5 additions to the main logic line

The following additions appear strong enough to become draft V6.5 material:

1. **Runtime Mode Taxonomy Rule**
   - distinguish REPL, headless, SDK, daemon, bridge, server, packaging modes explicitly
2. **Feature Flag Architecture Rule**
   - treat flag definition, default state, and enablement path as architectural facts
3. **Agent Loop Hook Lifecycle Rule**
   - document pre/post query, tool, compact, permission, abort, and handoff hooks
4. **Provider/Auth/Transport Separation Rule**
   - do not flatten multi-provider systems into a single API-client description
5. **Tool Source Layering Rule**
   - builtin vs MCP vs plugin vs user vs remote-only vs feature-gated tools
6. **Permission Pipeline Rule**
   - map permission flow end-to-end across modes
7. **Output Target Mapping Rule**
   - document where results go, not just how they are computed
8. **Monolith Diagnosis Trigger Rule**
   - explicitly record oversized-file / god-component architecture debt when observed
9. **Monorepo Package Role Rule**
   - classify packages by role, not just by directory name
10. **Telemetry Subsystem Rule**
   - capture observability as a behavioral subsystem when it materially affects operations

---

## 6. What should not be promoted blindly

The comparison target is powerful, but some of its patterns should **not** be imported into AgentLogic as universal rules without further validation:

- repository-specific command names
- repository-specific provider combinations
- repository-specific package names
- reverse-engineered implementation quirks
- assumptions caused by Bun-specific runtime choices
- assumptions caused by this repository's unusually large UI and bridge surfaces

V6.5 should absorb **structural lessons**, not project-specific implementation taste.

---

## 7. Recommended integration path

### Phase 1: research capture (historical phase)

- at that time, `versions/AgentLogic_V6.md` was still the stable line
- new findings were recorded in draft form only
- `manifest.json` and stable host entrypoints were intentionally left unchanged until promotion

### Phase 2: draft module extraction

If the V6.5 direction is accepted, create one or more dedicated draft modules such as:

- runtime mode taxonomy
- feature flag governance
- hook lifecycle mapping
- permission pipeline mapping
- monorepo package role mapping

### Phase 3: validation across more repositories

Promote only after confirming the same rules help at least:

- one large agentic CLI system
- one medium-sized tool-centric repository
- one project where feature-gating and tool layering both matter

### Phase 4: controlled promotion

Only then consider:

- a true `AgentLogic_V6_7_0.md`
- updated module chain references
- package validation changes if the draft becomes a stable line

---

## 8. Current recommendation

Yes - based on the local comparison, this work **can** become a meaningful `V6.5` line.

But the current evidence supports a **draft / research promotion**, not a stable replacement yet.

The safest current conclusion is:

- `V6` remains the stable operating baseline
- `V6.5` is justified as a draft extension focused on advanced agentic CLI architecture
- the next correct step is to extract these deltas into modular draft rules rather than immediately replacing the stable version

---

## 9. Immediate local result of this round

During this round:

- `D:\workspace\AgentLogic` was replaced with a fresh clone of the current `UIhoshi/AgentLogic` repository
- the previous local folder was preserved as backup at `D:\workspace\AgentLogic_backup_20260429`
- `D:\workspace\claude-code` was cloned from `claude-code-best/claude-code`
- this draft file was created to capture the first-pass V6.5 feasibility analysis

---

## 10. Draft module map created during this round

The following draft modules were added to make the V6.5 direction more actionable:

- `modules/20_V6_5_RuntimeModes_DRAFT.md`
- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/22_V6_5_HookLifecycle_DRAFT.md`
- `modules/23_V6_5_PermissionAndOutputPipeline_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/26_V6_5_DRAFT_INDEX.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

Among them, the highest-priority practical additions are:

- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/26_V6_5_DRAFT_INDEX.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`
- `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

because together they turn the abstract idea of "the agent has tools" into operational guidance about:

- when each tool family should be used
- when a tool must not be used
- how to prefer lower-risk tools before higher-risk tools
- how to chain search, read, edit, shell, web, and orchestration tools in the correct order
- how to record evidence from tool usage rather than treating tool output as self-justifying truth
- tool usage matrix by task type, phase, risk level, and runtime mode
- which kinds of questions each tool family is actually good at answering
- how tool families should be gated by permission posture and risk class

## 11. Immediate interpretation for future V6.5 work

If V6.5 continues, tool governance should stay near the center of the line.

Reason:

- runtime modes tell the agent **where it is operating**
- tool usage rules tell the agent **how it is allowed to act**
- permission/output pipelines tell the agent **what may cross trust boundaries**

Together, these three areas are the most important practical expansion beyond the current stable V6 wording.


---

## 11.1 Mandatory verification matrix addition

- `29_V6_5_MandatoryVerificationMatrix_DRAFT.md` adds the hard mapping layer from conclusion type to required tool family, minimum pass condition, and default failure state.
- `30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md` adds the hard boundary layer from tool family to strongly-answerable questions, support-only questions, and forbidden-alone questions.
- `31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md` adds the anti-pattern layer for weak closure paths, correction recipes, and safe downgrade labels.
- This module is meant to make the tool-governance line executable rather than merely advisory.

## 12. First consolidation result

The current draft line now separates **core governance modules** from **supporting structural modules**.

### Core governance modules

- `modules/21_V6_5_ToolUsageAndSelection_DRAFT.md`
- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`
- `modules/25_V6_5_ToolCapabilityMapping_DRAFT.md`
- `modules/27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`

These are the modules most likely to produce immediate behavior improvements in future agents.

### Supporting structural modules

- `modules/20_V6_5_RuntimeModes_DRAFT.md`
- `modules/22_V6_5_HookLifecycle_DRAFT.md`
- `modules/23_V6_5_PermissionAndOutputPipeline_DRAFT.md`

These modules explain the surrounding architecture that makes the governance layer more precise.

### Consolidation/support module

- `modules/28_V6_5_TerminologyAndModuleBoundaries_DRAFT.md`

This module reduces vocabulary drift and keeps the draft line promotion-ready.

### Practical implication

If future time is limited, the governance modules should be matured first.
The supporting structural modules should be refined second.


---

## 13. Candidate future stable V6.5 structure

If the current draft line later stabilizes, a likely future structure is:

### Overview

- one version overview file

### Core governance

- one general tool-usage module
- one decision-matrix module
- one capability-mapping module
- one permission-risk module

### Supporting structural layer

- one runtime mode module
- one hook lifecycle module
- one permission/output pipeline module

### Consolidation layer

- one terminology and module-boundary module, or an absorbed glossary section inside the stable overview

This structure is useful because it keeps the future stable line centered on execution behavior rather than on repository-specific architectural detail.


---

## 14. Keep-vs-merge recommendation

At the current draft stage, the recommended future preservation strategy is:

### Keep independent

- tool usage and selection
- tool usage matrix
- tool capability mapping
- tool permission risk matrix

These four modules form the practical execution-governance center of the line.

### Likely keep independent if the stable line remains modular

- runtime modes
- hook lifecycle
- permission/output pipeline

### Most likely merge later

- terminology and module-boundary draft

The terminology module is very useful during draft cleanup, but its eventual stable value may be better preserved as:

- a glossary in the overview file
- a stable appendix
- short boundary notes inside the kept modules


## 15. Local consolidation note

The tool-governance branch of the V6.5 draft has now expanded into three tighter enforcement companions:

- `29_V6_5_MandatoryVerificationMatrix_DRAFT.md`
- `30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`
- `31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

These should be treated as the hardening layer that turns general tool-governance advice into:

- required verification paths
- question-strength boundaries
- anti-pattern detection and downgrade labels

This means the current V6.5 tool-governance cluster is no longer only about "how to choose tools".
It is now also about:

- when a tool family is mandatory
- when a tool family is too weak to close a question
- when a conclusion must be downgraded because the evidence path was invalid
