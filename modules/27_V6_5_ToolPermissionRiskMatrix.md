# V6.5 Stable Module: Tool Permission Risk Matrix

Status: stable V6.5 module.
This module links tool families to permission expectations, risk class, and execution constraints.

---

## 1. Why this module exists

A tool is not only defined by what it can do.
It is also defined by:

- what permission posture it should default to
- what kinds of damage it can cause
- what verification is required before and after using it
- whether the same tool becomes more dangerous in different runtime modes

Without this layer, an agent may have many tools but no reliable sense of:

- which ones are effectively read-only
- which ones cross trust boundaries
- which ones should be delayed
- which ones should be blocked until preconditions are satisfied

---

## 2. Core model

Each meaningful tool family should be evaluated on at least these dimensions:

1. **Mutation level**
   - read-only
   - local state-changing
   - external state-changing
2. **Permission posture**
   - allow by default
   - ask by default
   - deny by default unless explicitly required
3. **Risk class**
   - low
   - medium
   - high
   - irreversible/high-impact
4. **Scope radius**
   - single file
   - repository
   - workspace
   - external system
5. **Evidence requirement**
   - none/minimal
   - pre-read required
   - path confirmation required
   - runtime verification required
   - post-change verification required

---

## 3. Default family-level matrix

| Tool Family | Mutation | Default Permission Posture | Risk | Typical Scope | Minimum Preconditions |
|---|---|---|---|---|---|
| Search/listing | Read-only | Allow | Low | repo/workspace | correct root path |
| Local file read | Read-only | Allow | Low | single file/repo | target file known or strongly suspected |
| Local edit/write | Local state-changing | Ask/guarded by reasoning | Medium to High | single file/repo | pre-read + boundary clarity + rollback awareness |
| Local shell read-only | Read-only | Allow | Low to Medium | repo/workspace | command effect understood |
| Local shell mutating | Local state-changing | Ask/guarded by reasoning | High | repo/workspace | path confirmation + command effect understood |
| Build/test/verification commands | Usually local state-changing but controlled | Allow or Ask depending on environment | Medium | repo/workspace | target runtime/build path known |
| External read-only lookup | Read-only external | Allow when freshness matters | Low to Medium | remote docs/repos | local insufficiency or recency need |
| External write/change | External state-changing | Ask or explicit user intent only | High to Irreversible | external system | target confirmed + local validation complete |
| Delegation/orchestration | Indirect state change / coordination | Ask conceptually unless host/user has allowed | Medium to High | task graph/system | boundary, ownership, and host permission clear |

---

## 4. Permission posture by runtime mode

### 4.1 REPL / interactive

Defaults:

- read-only local tools: normally allow
- local writes: often acceptable with strong reasoning and visible continuity
- high-risk external writes: delay until explicit intent is clear
- ask flows are practical here

### 4.2 Headless / pipe

Defaults:

- read-only local tools: allow
- local writes: stricter than REPL because interactive clarification is weaker
- external writes: strongly delayed
- output formatting requirements increase the cost of exploratory tool use

### 4.3 SDK / programmatic

Defaults:

- read-only inspection: allow
- local mutation: only if clearly part of the contract
- interactive ask flows may not exist
- unexpected side effects are especially dangerous

### 4.4 Daemon / background worker

Defaults:

- commands that affect lifecycle, scheduling, logs, or persisted state become higher risk
- repeated automatic tool use must be treated more strictly than one-off REPL use
- cleanup and idempotency matter more

### 4.5 Bridge / remote

Defaults:

- permission posture should become stricter across trust boundaries
- request origin must be considered part of the permission decision
- tools that are safe locally may become medium/high risk remotely

### 4.6 Packaging / installer

Defaults:

- build and artifact commands are central and expected
- destructive cleanup commands are still high risk
- path verification is mandatory because packaging often changes path models

---

## 5. Execution gates by risk class

### 5.1 Low-risk tools

Examples:

- search
- listing
- file read
- clearly read-only status commands

Required gate:

- correct target path

### 5.2 Medium-risk tools

Examples:

- bounded file edits
- controlled test/build commands
- local config changes

Required gates:

- relevant docs/source read
- target file/path known
- expected effect understood

### 5.3 High-risk tools

Examples:

- mutating shell commands
- broad codemods
- repository-wide writes
- environment or dependency mutation

Required gates:

- path confirmation
- mutation scope understood
- rollback or recovery path known
- validation plan known before execution

### 5.4 Irreversible/high-impact tools

Examples:

- release publication
- remote visibility/settings changes
- remote destructive configuration changes

Required gates:

- explicit user intent
- exact target confirmation
- local validation already complete
- post-change verification plan

---

## 6. Tool-family constraints

### 6.1 Search/listing tools

Permission posture:

- allow by default

Risk notes:

- low direct risk
- high indirect risk only if the agent treats search output as proof instead of a candidate set

Constraint:

- must usually be followed by file read before conclusions are treated as implementation truth

### 6.2 Local file read tools

Permission posture:

- allow by default

Risk notes:

- low direct risk
- can still create false confidence if only one isolated file is read in a cross-file behavior chain

Constraint:

- when behavior crosses modules, read at least one adjacent caller, callee, or config file

### 6.3 Local edit/write tools

Permission posture:

- not first-step tools
- effectively ask/guarded by reasoning

Risk notes:

- medium for bounded edits
- high when touching entrypoints, shared config, or cross-cutting modules

Constraints:

- do not use before reading
- do not use for speculation
- do not use broad write tools when a bounded edit is sufficient

### 6.4 Local shell read-only commands

Permission posture:

- allow if truly read-only

Risk notes:

- many commands only look read-only but may mutate caches, lockfiles, or state

Constraint:

- classify the command before using it, not after

### 6.5 Local shell mutating commands

Permission posture:

- high-risk guarded

Risk notes:

- scope damage can exceed the intended target quickly

Constraints:

- confirm working directory
- confirm target path
- avoid shell-composed destructive chains when safer native commands exist
- know whether the command is recursive, external, or cross-directory

### 6.6 Build/test/verification commands

Permission posture:

- usually allowed if they are the normal project validation path

Risk notes:

- may generate artifacts, caches, logs, lockfiles, or downloads

Constraints:

- know what byproducts are acceptable
- clean temporary validation artifacts when required
- do not confuse build success with behavior correctness when runtime/UI verification is needed

### 6.7 External read-only tools

Permission posture:

- allow when justified by freshness or missing local context

Risk notes:

- source-of-truth inversion if used too early
- recommendation drift if relying on weak sources

Constraints:

- prefer authoritative sources
- explicitly label remote fact vs local fact vs inference

### 6.8 External write/change tools

Permission posture:

- explicit-intent only

Risk notes:

- highest impact because mistakes leave the local sandbox

Constraints:

- never first-step tools
- never substitute for local validation
- always verify result after the change

### 6.9 Delegation/orchestration tools

Permission posture:

- conditional on host capability and task fit

Risk notes:

- can multiply confusion faster than they multiply productivity if used too early

Constraints:

- do not delegate the immediate blocking task just to avoid local work
- do not delegate without ownership boundaries
- do not assume repository support equals permission to use

---

## 7. Required preflight checks before high-risk tool use

Before any high-risk or external-write tool use, the agent should be able to answer:

1. What exact state will change?
2. What is the narrowest possible target?
3. What local evidence justifies the change?
4. What verification will prove the change worked?
5. What is the recovery path if the result is wrong?

If these are not answerable, the high-risk tool use should be delayed.

---

## 8. Required post-use checks by family

| Tool Family | Required Post-Use Check |
|---|---|
| Search/listing | confirm with file read before making strong claims |
| File read | note what is still unconfirmed |
| Edit/write | run validation and update docs if needed |
| Shell mutate | inspect outputs/logs/path effects |
| Build/test | record pass/fail scope and remaining gaps |
| External read-only | separate source-backed fact from inference |
| External write/change | verify target state actually changed correctly |
| Delegation/orchestration | integrate result and verify ownership boundaries stayed clean |

---

## 9. Fast risk recipes

### Safe discovery recipe

`search/list -> file read -> file read -> conclusion`

### Controlled implementation recipe

`search/list -> file read -> bounded edit -> local validation -> doc sync`

### High-risk mutation recipe

`file read -> path confirmation -> command/edit -> validation -> cleanup/recovery check`

### External publication recipe

`local validation -> remote target confirmation -> external change -> post-change verification`

---

## 10. Promotion value

This module is one of the strongest candidates for future stable promotion because it converts vague caution into explicit execution gates.
It is especially useful for making the agent's "hands and feet" more capable without making them uncontrolled.
