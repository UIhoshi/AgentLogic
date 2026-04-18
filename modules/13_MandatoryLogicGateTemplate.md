# Mandatory Logic Gate Template

This file defines the mandatory header template that must be added to every major entry file.

It is not a suggestion.
It is not a style preference.
It is not a documentation nicety.

It is a blocking execution gate.

The purpose of this template is to reduce AI entry errors at the exact point where implementation usually begins.

Those errors include, but are not limited to:

- skipping repository entry documents
- treating a new task as an automatic continuation of the previous coding round
- silently carrying stale context into a new task
- starting deeper reading, writes, deletions, or implementation before the logic-entry loop is complete
- treating mandatory startup behavior as guidance instead of a hard gate

This template exists because repeated testing shows that AI agents often start from major entry files first.
Therefore, the gate must be placed exactly there.

---

## 1. Status

This template is mandatory.

It must be treated as:

- a blocking gate
- an execution precondition
- a repository-level enforcement target

It must not be treated as:

- optional guidance
- a reminder only
- a stylistic comment
- a replaceable local habit

---

## 2. Scope

This template must be added to every major entry file.

Typical required targets include:

- process entry files
- CLI entry files
- main backend control files
- route entry files
- preload bridge files
- major renderer entry files
- main admin UI entry files
- other high-frequency implementation entrypoints

This template should not be mechanically added to every file in the repository.

Do not spread it across:

- utility files
- leaf components
- helper modules
- pure style files
- unrelated test fixtures
- low-level implementation files that are not real entrypoints

The rule is:

- mandatory on major entry files
- not universal on all files

---

## 3. Repository Link Rule

The header template must point to repository-relative entry documents first.

Default required repository-relative targets:

- `AGENTS.md`
- `README.md`

The code-file header must not use:

- machine-specific absolute paths
- local-user absolute paths
- temporary working-directory assumptions
- hardcoded host-specific locations

If the repository depends on an external logic package, that external path should be declared in repository-level entry documents, not hardcoded into every source-file header.

The preferred chain is:

1. entry-file header points to `AGENTS.md` and `README.md`
2. repository entry documents point to the current logic-entry chain
3. the logic-entry chain points to the real control files

This preserves portability across machines and repositories.

---

## 4. Required Logic Chain

The mandatory logic gate must force the agent back into the repository-declared logic-entry chain.

That chain should include, when applicable:

- `00_START_HERE.md`
- `modules/01_MasterLogic.md`
- `modules/15_LogicEntryChecklist.md`

If the repository declares a different or extended logic chain, that repository-declared chain takes precedence.

The header template should not attempt to duplicate the full logic package.
Its purpose is to block premature implementation and redirect the agent into the proper chain.

---

## 5. Mandatory Startup Gate Behavior

The template must enforce all of the following behaviors before implementation:

1. read repository entry documents first
2. follow the declared logic-entry chain
3. explicitly determine whether the current task is an extension of the previous coding round
4. if it is not an extension, explicitly ask whether to forget/compress context first
5. treat this startup loop as a blocking gate
6. do not infer continuation automatically
7. do not skip the context-reset question for efficiency
8. do not continue deeper reading, writes, deletions, or implementation before the loop is complete

This behavior is mandatory because the highest-risk failure pattern is not lack of capability.
It is inconsistent entry behavior.

---

## 6. Language Rule

Header-level mandatory rules must default to English.

This applies to:

- source files
- script files
- markup files
- style files
- repository markdown files when using header-level mandatory notices

The purpose is consistency across:

- agents
- models
- environments
- future repository checks

Local-language explanation may still exist in normal document bodies.
But the header-level mandatory gate must default to English unless the repository explicitly declares otherwise.

---

## 7. Noise Rule

The template must stay short and high-signal.

It must not become:

- a project summary
- a module explanation
- a changelog
- a TODO area
- a debugging notebook
- a business description

Its only role is to block premature implementation and redirect the agent into the logic-entry chain.

---

## 8. Standard Long Template

Use the following as the default long-form template.

### Plain text form

```txt
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
```

---

## 9. Standard Short Template

Use the short form only when the file type or entry-file constraints make the long form impractical.

### Plain text form

```txt
MANDATORY LOGIC GATE

Read `AGENTS.md` and `README.md` before making changes here.
Then follow the repository-declared logic entry chain.

Before every new coding round, explicitly decide whether this task extends the previous round.
If not, explicitly ask whether to forget/compress context first.

This is a blocking gate.
Do not infer continuation by yourself.
Do not start deeper reading, writes, or implementation before this loop is completed.
```

The short version is a fallback, not the default.

---

## 10. Language-Specific Header Forms

### 10.1 JS / TS / TSX

```ts
/**
 * MANDATORY LOGIC GATE
 *
 * Before making changes here, read `AGENTS.md` and `README.md` first.
 * Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
 * `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
 *
 * Before every new coding round, explicitly decide whether the current task extends
 * the previous coding round.
 * If it does not, explicitly ask whether to forget/compress context before continuing.
 *
 * Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
 * Do not infer continuation by yourself.
 * Do not skip the context-reset question for efficiency.
 *
 * Do not continue deeper reading, modify files, delete files, perform write actions,
 * or begin implementation before the logic-entry loop above has been completed.
 */
```

### 10.2 Python

```py
# MANDATORY LOGIC GATE
#
# Before making changes here, read `AGENTS.md` and `README.md` first.
# Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
# `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
#
# Before every new coding round, explicitly decide whether the current task extends
# the previous coding round.
# If it does not, explicitly ask whether to forget/compress context before continuing.
#
# Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
# Do not infer continuation by yourself.
# Do not skip the context-reset question for efficiency.
#
# Do not continue deeper reading, modify files, delete files, perform write actions,
# or begin implementation before the logic-entry loop above has been completed.
```

### 10.3 Markdown

```md
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
```

### 10.4 PowerShell / Shell

```powershell
# MANDATORY LOGIC GATE
#
# Before making changes here, read `AGENTS.md` and `README.md` first.
# Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
# `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
#
# Before every new coding round, explicitly decide whether the current task extends
# the previous coding round.
# If it does not, explicitly ask whether to forget/compress context before continuing.
#
# Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
# Do not infer continuation by yourself.
# Do not skip the context-reset question for efficiency.
#
# Do not continue deeper reading, modify files, delete files, perform write actions,
# or begin implementation before the logic-entry loop above has been completed.
```

---

## 11. Enforcement Intent

This template should be backed by repository-level enforcement when possible.

Recommended repository-level check responsibilities include:

- verify that major entry files still contain the mandatory gate
- verify that the header remains in English
- verify that `AGENTS.md` and `README.md` are still referenced
- verify that the repository entry docs still point to the current logic-entry chain
- verify that machine-specific absolute paths are not used in the gate

A typical enforcement command may look like:

```bash
node scripts/check-logic-entry.js
```

The script is not a replacement for reading the logic package.
Its job is to prevent silent drift.

---

## 12. Validation Targets

When implementing repository-level checks for this template, the repository should prefer validating the presence of stable anchor phrases such as:

- `MANDATORY LOGIC GATE`
- ``read `AGENTS.md` and `README.md` first``
- `forget/compress context`
- `blocking gate`
- `Do not infer continuation by yourself`

The exact string policy may vary by repository, but the enforcement should remain strict enough to detect deletion, weakening, or accidental rewriting of the gate.

---

## 13. Why This Template Is Mandatory

This template is mandatory because it solves a real execution problem.

Repeated observation shows that AI agents often begin from major entry files.
That makes those files the highest-leverage place to stop incorrect execution paths before they become file edits, deletions, or stale-context implementation.

Therefore this template must be treated as:

- a tested execution-control mechanism
- a mandatory repository safeguard
- a structural reduction of agent error rate

It must not be downgraded into a soft recommendation.

---

## 14. Relationship To Other Logic Files

This template does not replace:

- `00_START_HERE.md`
- `versions/AgentLogic_V6.md`
- `modules/01_MasterLogic.md`
- `modules/12_AgentEnforcement.md`
- `modules/15_LogicEntryChecklist.md`

Instead, it forces the agent back into them at the exact moment where implementation would otherwise start too early.

Its role is not to carry the whole logic package.
Its role is to stop premature action.

---

## 15. Recommended Repository Adoption Rule

Repositories using AgentLogic should treat the following as the default adoption stack:

1. repository entry docs declare the logic-entry chain
2. all major entry files carry the Mandatory Logic Gate header
3. repository enforcement script checks the gate mechanically
4. updates to the gate are synchronized with the main logic when promoted

This stack should be treated as the default engineering baseline, not a special-case hardening step.
