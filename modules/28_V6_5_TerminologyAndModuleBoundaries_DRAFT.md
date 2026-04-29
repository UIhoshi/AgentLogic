# V6.5 Draft Module: Terminology And Module Boundaries

Status: draft only.
This module exists to reduce vocabulary drift and overlap inside the V6.5 draft line.

---

## 1. Why this module exists

A draft line becomes hard to promote when:

- several files use near-synonyms inconsistently
- one concept appears in too many modules
- readers cannot tell which file is normative for which question

This module defines the preferred vocabulary and the intended ownership boundary of each V6.5 draft module.

---

## 2. Preferred terminology

### 2.1 Runtime mode

Use this term for the execution surface the system is currently operating in.

Preferred examples:

- REPL / interactive
- headless / pipe
- SDK / programmatic
- daemon / background worker
- bridge / remote
- packaging / installer

Do not casually replace this with:

- channel
- environment
- interface
- output mode

unless the project truly means something narrower.

### 2.2 Tool family

Use this term for a class of tools that share similar behavior and risk.

Preferred examples:

- search/listing
- local file read
- local edit/write
- local shell read-only
- local shell mutating
- external read-only lookup
- external write/change
- delegation/orchestration

Do not mix this up with:

- one concrete tool implementation
- one provider-specific command
- one repository-specific feature name

### 2.3 Permission posture

Use this term for the default approval stance a tool family should have.

Preferred values:

- allow by default
- ask by default
- deny by default unless explicitly required

This is different from:

- risk class
- tool capability
- trust boundary

### 2.4 Risk class

Use this term for the expected damage potential of a tool action.

Preferred values:

- low
- medium
- high
- irreversible / high-impact

Risk class answers:

- how dangerous is this action if it goes wrong?

It does **not** answer:

- whether the tool is useful
- whether the tool is available
- whether the action is currently authorized

### 2.5 Evidence requirement

Use this term for what must be known before and after tool use.

Typical examples:

- pre-read required
- path confirmation required
- runtime verification required
- post-change verification required

This is one of the most important practical V6.5 terms.

### 2.6 Output target

Use this term for where a result is meant to go.

Preferred examples:

- terminal output
- machine-readable output
- remote protocol output
- background state update
- notification output
- persistent artifact output

### 2.7 Capability mapping

Use this term for the relationship between a tool family and the question types it is best suited to answer.

This is different from a usage matrix.

### 2.8 Usage matrix

Use this term for a decision table showing preferred tool families by:

- task type
- execution phase
- runtime mode
- risk level

### 2.9 Governance module

Use this term for a module that directly constrains how an agent should act.

Current V6.5 governance modules are:

- tool usage and selection
- tool usage matrix
- tool capability mapping
- tool permission risk matrix

### 2.10 Supporting structural module

Use this term for a module that explains architectural context rather than directly giving first-step behavior rules.

Current V6.5 supporting structural modules are:

- runtime modes
- hook lifecycle
- permission/output pipeline

---


### 2.6 Verification matrix

Use this term for a hard mapping from conclusion type to:

- required tool family
- minimum pass condition
- default failure state

This term is narrower than general tool policy.
It answers what verification is mandatory for a given claim category.

### 2.7 Question-boundary matrix

Use this term for a hard mapping from tool family to:

- strongly answerable question types
- support-only question types
- forbidden-alone question types

This term answers what a tool family is strong enough to conclude by itself.

### 2.8 Anti-pattern matrix

Use this term for a structured list of invalid closure paths, correction recipes, and downgrade labels.

This term answers how to recognize false certainty and what to do after it appears.

## 3. Module ownership boundaries

### 3.1 `20_V6_5_RuntimeModes_DRAFT.md`

Owns:

- definition of runtime modes
- multi-mode vs single-mode distinction
- mode-specific validation/permission/output awareness

Does **not** own:

- detailed tool matrices
- detailed permission posture by tool family

### 3.2 `21_V6_5_ToolUsageAndSelection_DRAFT.md`

Owns:

- general principles for tool choice
- sequencing logic
- what kinds of tool misuse are prohibited
- broad guidance on when to prefer low-risk tools

Does **not** own:

- the dense matrix tables
- the per-question capability map
- the full permission-risk gating table

### 3.3 `24_V6_5_ToolUsageMatrix_DRAFT.md`

Owns:

- decision-table style guidance
- tool preference by task type, phase, runtime mode, and risk level

Does **not** own:

- deep narrative rationale
- full capability explanations
- full permission posture detail

### 3.4 `25_V6_5_ToolCapabilityMapping_DRAFT.md`

Owns:

- which question types each tool family answers well
- what evidence each family tends to produce
- what follow-up tool is usually needed

Does **not** own:

- phase matrix logic
- runtime-mode matrix logic
- permission posture table

### 3.5 `27_V6_5_ToolPermissionRiskMatrix_DRAFT.md`

Owns:

- permission posture by tool family
- risk class by tool family
- high-risk execution gates
- runtime-mode-sensitive risk tightening

Does **not** own:

- question-to-tool matching logic
- general onboarding sequence rules
- full output-target taxonomy outside its permission/output interaction scope

### 3.6 `22_V6_5_HookLifecycle_DRAFT.md`

Owns:

- lifecycle stages
- hook-point mapping
- side-effect placement awareness

Does **not** own:

- tool family selection rules

### 3.7 `23_V6_5_PermissionAndOutputPipeline_DRAFT.md`

Owns:

- permission pipeline shape
- output target pipeline shape
- cross-boundary propagation questions

Does **not** own:

- the detailed tool-family risk table

---

## 4. Preferred reading model

When the question is:

- "What mode am I in?" -> read `20`
- "How should I generally choose tools?" -> read `21`
- "Which tool family is preferred here?" -> read `24`
- "What question is this tool family good at answering?" -> read `25`
- "How dangerous is this tool family and what gates apply?" -> read `27`
- "Where are lifecycle interception points?" -> read `22`
- "How do permissions and outputs cross boundaries?" -> read `23`

---

## 5. Consolidation rule

If future promotion happens, the stable V6.5 line should preserve these ownership boundaries as much as possible.
The goal is not to maximize file count.
The goal is to keep each governance question answerable from one primary place.


### 3.8 `29_V6_5_MandatoryVerificationMatrix_DRAFT.md`

Owns:

- conclusion type -> required tool family mapping
- minimum pass conditions
- default failure states when verification is incomplete

Does not own:

- question-strength boundaries for tool families
- anti-pattern catalogs
- broader runtime-mode modeling

### 3.9 `30_V6_5_ToolQuestionBoundaryMatrix_DRAFT.md`

Owns:

- tool family -> strongly answerable question types
- tool family -> support-only question types
- tool family -> forbidden-alone question types

Does not own:

- required verification pass criteria for each conclusion type
- correction recipes after anti-patterns occur
- permission posture tables

### 3.10 `31_V6_5_ToolMisuseAndAntiPatternMatrix_DRAFT.md`

Owns:

- common invalid closure paths
- why those paths are invalid
- correction recipes
- safe downgrade labels

Does not own:

- the full decision matrix for normal tool selection
- the full question-boundary model
- the full permission/risk model
