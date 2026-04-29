# V6.5 Draft Module: Tool Usage And Selection

Status: draft only.
This module is the main V6.5 expansion for tool timing, tool choice, and tool choreography.

---

## 1. Why this module exists

In agentic engineering work, tool quality is not only about whether a tool exists.
It is about:

- when to use it
- when not to use it
- what must be known before using it
- what evidence must be captured after using it
- how multiple tools should be chained together

Bad tool choice causes:

- premature writes
- noisy browsing
- weak validation
- accidental scope expansion
- fake certainty

Therefore V6.5 should treat tool selection as a first-class execution rule.

---

## 2. Five tool classes

### 2.1 Local read-only tools

Examples:

- file read
- grep
- glob
- tree / directory listing
- source indexing
- structure search

Use them when:

- locating entrypoints
- building a project fact map
- confirming module boundaries
- checking whether a capability actually exists

Do **not** skip them and jump directly into edits.

### 2.2 External read-only tools

Examples:

- web search
- web fetch
- official documentation lookup
- remote repository inspection

Use them when:

- facts may have changed
- the user explicitly asks to look something up
- the referenced page is not already available locally
- current docs, releases, versions, or ecosystem status matter

Do **not** use them as a substitute for reading the local repository when the answer should come from the codebase.

### 2.3 Local state-changing tools

Examples:

- file write
- file edit
- shell commands that modify files
- build commands
- package install
- formatting and codemods

Use them only after:

- the relevant docs were read
- the target paths are known
- the change boundary is clear
- the rollback path is understood

These tools are never the first step in a new repository round.

### 2.4 External state-changing tools

Examples:

- git push
- release publication
- remote configuration change
- external service mutation
- repository visibility or settings changes

Use them only when:

- the user clearly wants the external state to change
- the target is confirmed
- the change is reversible or the risk is explicitly understood

These tools are the highest-risk class by default.

### 2.5 Delegation / orchestration tools

Examples:

- sub-agent spawning
- plan mode entry/exit
- worktree switching
- task queues
- teammate/remote worker dispatch

Use them when:

- the task truly benefits from decomposition
- boundaries are explicit
- ownership is clear
- the host actually allows delegation

Do **not** use them just because the repository contains them.

---

## 3. Default tool-use order

Unless the task clearly demands otherwise, the preferred order is:

1. locate documentation entrypoint
2. inspect directory / entry files
3. search for relevant symbols and paths
4. read the smallest sufficient set of source files
5. decide task layer and boundary
6. choose the lowest-risk tool that can answer the next question
7. edit only after the target and effect are understood
8. validate with the narrowest meaningful verification first
9. broaden validation if risk is high
10. sync documentation

This order exists to minimize irreversible mistakes.

---

## 4. Tool choice hierarchy when multiple tools overlap

When more than one tool can answer the same question, prefer:

1. the **highest-signal read-only local** tool
2. then the **targeted local edit** tool
3. then the **targeted command** tool
4. then external lookup
5. then broad or expensive orchestration

Examples:

- prefer grep/glob before opening random files
- prefer reading a specific file before launching builds
- prefer a targeted edit before a large script-based rewrite
- prefer official docs before forum summaries

---

## 5. Tool timing matrix

### 5.1 Before planning

Allowed preference:

- local read-only tools
- targeted external read-only tools when freshness matters

Avoid:

- write tools
- destructive shell commands
- broad refactors

### 5.2 During planning

Allowed preference:

- structure search
- entrypoint inspection
- package and dependency mapping
- plan-mode/orchestration tools if the host supports them

Avoid:

- implementation disguised as planning

### 5.3 During implementation

Allowed preference:

- targeted file edit/write
- constrained shell commands
- tests/builds for the modified boundary

Avoid:

- unrelated browsing
- broad repo-wide rewrites without recorded reason

### 5.4 During validation

Allowed preference:

- build/test commands
- runtime smoke checks
- screenshot or UI verification for visible behavior
- log/path verification

Avoid:

- declaring success from code inspection alone when behavior is what matters

### 5.5 During release/publication

Allowed preference:

- packaging commands
- artifact verification
- release metadata checks
- source-archive completeness checks

Avoid:

- mixing release work with unrelated refactors

---

## 6. Specific guidance by tool family

### 6.1 Search tools

Use when:

- you need symbol locations
- you need entrypoint discovery
- you need to compare repeated patterns

Do not use search output alone as proof of behavior.
Search must usually be followed by direct file reading.

### 6.2 File read tools

Use when:

- confirming exact implementation
- verifying contracts
- checking header rules or entry reminders

Prefer direct reads of specific files over unfocused large-file scanning when possible.

### 6.3 File edit/write tools

Use when:

- the landing file is already known
- the exact change boundary is small enough to describe
- docs or source already justify the change

Do not use them to explore.
Writing is not discovery.

### 6.4 Shell/command tools

Use when:

- builds, tests, installs, or repository operations are required
- the command gives higher-fidelity truth than static reading
- platform-specific behavior must be verified

Requirements:

- record working directory
- know whether the command is read-only or state-changing
- know whether it can escape the intended target
- prefer native shell-safe operations over string-built destructive chains

### 6.5 Web tools

Use when:

- current versions, releases, docs, or remote facts matter
- the user explicitly asks to verify online
- local docs are missing or stale

Avoid:

- substituting web summaries for repository facts
- browsing when the fact is stable and already local

### 6.6 Planning tools

Use when:

- the task is multi-step or multi-module
- the project supports explicit plan state
- you need to separate exploration from execution

Do not enter plan mode just as ritual.
Use it when it clarifies execution.

### 6.7 Worktree / environment-switch tools

Use when:

- isolation is needed
- parallel lines of work need separation
- release or experiment boundaries must not mix

Avoid using them if a simple local branch or current workspace suffices.

### 6.8 Sub-agent / worker / teammate tools

Use only when all are true:

- the host explicitly allows delegation
- the user request or task context justifies parallel work
- ownership boundaries are explicit
- the result will materially advance the main task

Do not treat repository support for agents as automatic permission to delegate.

---

## 7. Tool choreography patterns

### 7.1 Repository onboarding pattern

- directory listing
- README / entry markdown read
- entrypoint search
- targeted file reads
- task-layer judgment
- project fact map output

### 7.2 Bug-fix pattern

- symptom capture
- log/search inspection
- relevant source read
- narrow fix
- local verification
- documentation sync

### 7.3 Refactor pattern

- boundary map
- dependency/search pass
- explicit plan
- staged edits
- broad validation
- updated architectural docs

### 7.4 Release pattern

- build path confirmation
- artifact generation
- unpacked verification first
- installer/release verification second
- release asset completeness check
- cleanup of temporary artifacts

---

## 8. Tool evidence requirement

After meaningful tool use, the agent should be able to state:

- which tool was used
- why that tool was chosen instead of a lower-risk alternative
- what fact it confirmed
- what remains uncertain
- whether the result came from local truth, remote truth, or inference

---

## 9. Tool misuse patterns that V6.5 should reject

Reject these patterns by default:

- editing before reading
- broad shell mutation before path verification
- using web search to answer local code questions
- treating search hits as implementation proof
- using sub-agents without explicit host/user allowance
- declaring a UI fix from build success alone
- using high-risk tools because they are convenient rather than necessary

---

## 10. Minimal tool matrix for project fact maps

For tool-centric repositories, record at least:

- tool family
- source of registration
- default visibility
- default availability
- permission mode
- parallel-safety status
- expected output form
- main risks


---

## 11. Relationship to the tool matrix module

This module defines the principles.
The executable matrix version lives in:

- `modules/24_V6_5_ToolUsageMatrix_DRAFT.md`

The intended relationship is:

- `21_...ToolUsageAndSelection...` explains the rules and reasoning
- `24_...ToolUsageMatrix...` turns those rules into fast operational choices

Future stable promotion should usually preserve both layers rather than collapsing them into one file.
