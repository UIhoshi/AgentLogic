# V6.5 Stable Module: Tool Usage Matrix

Status: stable V6.5 module.
This module operationalizes tool governance into reusable matrices.

---

## 1. Why this module exists

Narrative rules are useful, but agents need something more executable.
A matrix helps answer quickly:

- which tool family should be preferred first
- which tool family is allowed but secondary
- which tool family should be delayed
- which tool family should be avoided by default

---

## 2. Legend

- **P1 Preferred first**: default first choice
- **P2 Preferred after local confirmation**: good second-step tool
- **P3 Allowed but not default**: use only with reason
- **H High-risk / delayed**: do not use early
- **X Avoid by default**: only if the task explicitly requires it

Tool families used in this matrix:

- **LS** = local search/listing (`grep`, `glob`, tree, symbol search)
- **LR** = local file read
- **LE** = local edit/write
- **LC** = local commands/build/test/shell
- **ER** = external read-only lookup (web/docs/remote repo)
- **EW** = external write/change (push/release/settings mutation)
- **OR** = orchestration / plan / worktree / delegation tools

---

## 3. Matrix by task type

| Task Type | LS | LR | LE | LC | ER | EW | OR |
|---|---|---|---|---|---|---|---|
| New repo onboarding | P1 | P1 | X | P3 | P2 | X | P3 |
| Bug investigation | P1 | P1 | P2 | P2 | P3 | X | P3 |
| Small local fix | P2 | P1 | P1 | P2 | X | X | X |
| Multi-module refactor | P1 | P1 | P2 | P2 | P3 | X | P2 |
| Runtime/build failure | P2 | P2 | P3 | P1 | P3 | X | X |
| UI/visual regression | P2 | P2 | P2 | P2 | X | X | P3 |
| Dependency/version verification | P2 | P2 | P3 | P2 | P1 | X | X |
| Release packaging | P2 | P2 | P3 | P1 | P2 | P2 | P3 |
| Publication/repo settings | P3 | P2 | X | P3 | P2 | P1 | X |
| Architecture analysis | P1 | P1 | X | P3 | P3 | X | P2 |

---

## 4. Matrix by execution phase

| Phase | LS | LR | LE | LC | ER | EW | OR |
|---|---|---|---|---|---|---|---|
| Pre-entry | P1 | P1 | X | X | P2 | X | X |
| Fact mapping | P1 | P1 | X | P3 | P2 | X | P2 |
| Planning | P2 | P1 | X | P3 | P2 | X | P2 |
| Implementation | P2 | P2 | P1 | P2 | X | X | P3 |
| Validation | P2 | P2 | P3 | P1 | P2 | X | X |
| Packaging | P2 | P2 | P3 | P1 | P2 | P3 | P3 |
| Publication | P3 | P2 | X | P3 | P2 | P1 | X |

---

## 5. Matrix by risk level

### 5.1 Low-risk questions

Examples:

- where is the entrypoint?
- which file owns this behavior?
- does this symbol exist?

Preferred:

- LS, LR

Avoid:

- LE, EW

### 5.2 Medium-risk changes

Examples:

- bounded code fix
- config update
- small refactor with local verification

Preferred sequence:

- LS -> LR -> LE -> LC

Add ER only if freshness matters.

### 5.3 High-risk operations

Examples:

- release publishing
- repository visibility changes
- destructive file operations
- cross-environment configuration changes

Preferred sequence:

- LS -> LR -> LC/ER for confirmation -> EW only at the end

Never start with EW.

---

## 6. Matrix by runtime mode

| Runtime Mode | LS | LR | LE | LC | ER | EW | OR | Notes |
|---|---|---|---|---|---|---|---|---|
| REPL / interactive | P1 | P1 | P2 | P2 | P2 | H | P2 | ask/confirm flows are practical |
| Headless / pipe | P2 | P1 | P2 | P2 | P2 | H | X | output discipline is stricter |
| SDK / programmatic | P2 | P1 | P3 | P2 | P2 | X | X | stable contracts matter more than UI |
| Daemon / background | P2 | P1 | P2 | P1 | P2 | H | P2 | lifecycle, cleanup, logs matter |
| Bridge / remote | P2 | P1 | P3 | P2 | P2 | H | P2 | cross-boundary permission propagation matters |
| Packaging / installer | P2 | P2 | P3 | P1 | P2 | P2 | X | artifact/path verification first |

---

## 7. Tool-family playbooks

### 7.1 Search-first playbook

Use when the question is still structural.

Pattern:

1. locate path candidates with LS
2. open the most likely files with LR
3. only then decide whether LE or LC is necessary

### 7.2 Read-before-edit playbook

Use for nearly all code changes.

Pattern:

1. LR the owning file
2. LR at least one caller or adjacent dependency if the behavior spans boundaries
3. LE only after the landing change is obvious
4. LC to validate

### 7.3 Verify-before-publish playbook

Use for release/public changes.

Pattern:

1. LR packaging docs and targets
2. LC build/package locally
3. LC or runtime verification of artifact
4. ER if remote release metadata needs current confirmation
5. EW only last

### 7.4 Remote-fact confirmation playbook

Use when the answer may have changed recently.

Pattern:

1. confirm whether local files are insufficient
2. use ER against the most authoritative source
3. explicitly mark what came from remote truth versus local truth
4. do not let ER replace repository reading if the local code still decides the implementation

---

## 8. Matrix for delegation/orchestration tools

| Situation | OR Guidance |
|---|---|
| Small single-file fix | X |
| Medium multi-step task in one repo | P3 unless explicit plan tooling helps |
| Large multi-module refactor | P2 |
| Parallelizable research across separate questions | P2 |
| Critical-path blocking local task | X or delayed |
| Host does not explicitly allow delegation | X |

Key rule:

Delegation is a force multiplier, not a permission substitute.

---

## 9. Anti-pattern matrix

| Anti-pattern | Why rejected |
|---|---|
| LE before LR | writing without evidence |
| LC mutation before path confirmation | accidental scope damage |
| ER before local code read for repository facts | source-of-truth inversion |
| EW before local validation | externalizes mistakes |
| OR before task boundary clarity | multiplies confusion |
| build success used as proof of UI correctness | wrong validation mode |

---

## 10. Fast default recipes

### New repository

`LS -> LR -> LR -> PFM/project fact map -> OR only if clearly useful`

### Small bug fix

`LS -> LR -> LR -> LE -> LC -> doc sync`

### Current-version verification

`LR -> ER -> LR -> conclusion`

### Packaging/release

`LR -> LC build -> LC verify -> ER remote metadata if needed -> EW`

### Large architecture task

`LS -> LR -> LR -> OR(plan) -> staged LE/LC -> doc sync`

---

## 11. Promotion rule

If this matrix proves stable across multiple repositories, it should be promoted into the future stable V6.x line as one of the practical "how the agent uses its hands" modules.
