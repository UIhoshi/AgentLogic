# V6.8.3 Project-Native Knowledge Sync

Status: **Active in the enhanced profiles.**

This module keeps a business project's operational knowledge with the project code rather
than requiring a separate history checkout. It is a synchronization contract, not a copy of
the globally installed AgentLogic method layer.

## 1. Minimal tracked project knowledge

Every business project using the full AgentLogic workflow must track these files in its own
Git repository:

```text
AGENTS.md
PROJECT_MAP.md
CODE_MAP.md
.learnings/ERRORS.md
```

- `AGENTS.md` contains concise **project-only** instructions, common commands, and local
  verification requirements. It must point to the installed AgentLogic layer instead of
  duplicating global rules.
- `PROJECT_MAP.md` contains factual L1-L4 project mapping: entrypoints, main flows,
  control/permission boundaries, base dependencies, validation commands, and explicitly
  unconfirmed points.
- `.learnings/ERRORS.md` contains concise records of material project errors: symptom, root
  cause, correction, prevention, and verification.
- `CODE_MAP.md` is the mandatory text-first handover map for implementation projects. It records
  entrypoints, module ownership, navigation-critical functions/classes, state or storage keys,
  interface/event surfaces, validation commands, and a reviewed commit or freshness marker. It is
  not a source dump, runtime proof, or replacement for targeted reads.

Treat the map as the default code-navigation index: for an inherited project, repair it before
repeated broad discovery; for an owned project, establish it with the first implementation flow
and update it with every affected key symbol or impact path. Before editing, use the map to find
the owning flow and its likely callers/callees, then confirm that narrow source chain.

These files travel with the code in the same normal project commits. They are project facts,
not private agent memory.

## 2. Required project-entry synchronization

Before relying on a tracked project map or error record, the agent must:

1. identify the repository root and current branch/worktree;
2. run `git fetch --prune` when a remote is configured and network access is available;
3. inspect `git status --short --branch` and the relevant local/remote divergence;
4. read the current `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`;
5. compare those records with current source and `git diff` before making strong claims.

`git fetch --prune` is a read-oriented freshness check. `git pull`, checkout, merge, rebase,
or any other worktree-changing action remains separate: confirm the target, ensure the
workspace is clean or intentionally managed, and prefer `git pull --ff-only` when a
fast-forward update is intended.

When offline, state that remote freshness is unverified and continue only from the current
working tree and tracked records.

## 3. Update contract

- A structural change (new/moved entrypoint, module boundary, flow, permission boundary,
  dependency boundary, or validation command) must update `PROJECT_MAP.md` in the same
  project commit.
- An affected key-flow, symbol-ownership, state/storage, interface/event, or validation change
  must update `CODE_MAP.md` in the same project commit.
- A material unexpected failure, user correction, or root-cause repair must update
  `.learnings/ERRORS.md` in the same project commit after the correction is understood.
- Do not write speculative, duplicate, or low-value chatter into either file.
- Re-read both files after checkout, branch, worktree, or major multi-agent changes.

## 4. Conditional companion artifacts

Use only when the matching task requires them:

- `.specify/` for non-trivial SDD work, preserving approved specification, plan, task state,
  and relevant shipping records;
- `docs/adr/` for hard-to-reverse architecture, trust-boundary, data, or deployment decisions;
- tests, CI, scripts, lockfiles, and formatter configuration as normal source-controlled proof
  of repeatable validation.

Graphify output remains optional. Do not commit `graphify-out/` by default; record durable,
verified graph conclusions in `PROJECT_MAP.md` or `CODE_MAP.md` instead.

## 5. Privacy and repository boundary

Never add any of the following to the tracked project-knowledge files:

- secrets, tokens, credentials, `.env` contents, or private API material;
- machine-specific absolute paths, personal configuration, or private prompts;
- raw terminal logs, caches, build artifacts, or unreviewed generated graph output;
- private conversation transcripts or memory that is not safe for all repository readers.

If private knowledge must follow a user across machines, use an explicitly approved private or
encrypted mechanism. A project repository cannot simultaneously publish content and keep that
content private.

## 6. Relationship to modification_history

`modification_history` may remain as an optional cross-project reference and as historical
archive material. It is no longer a blocking checkout, retrieval, or pre-push dependency for
ordinary business-project work. Promote a lesson to AgentLogic or that optional archive only
when it is demonstrably reusable beyond one project.

## 7. Reusable project templates

### `PROJECT_MAP.md`

```md
# Project Map

## L1 — Entry & Surface
- Entrypoints:
- User/API/CLI surfaces:

## L2 — Flow & Lifecycle
- Core flows:
- State and task lifecycle:

## L3 — Control & Verification
- Services, permissions, trust boundaries:
- Validation commands:

## L4 — Base & Dependencies
- Data stores, providers, foundational tools:

## Unconfirmed Points
- [ ]
```

### `.learnings/ERRORS.md`

```md
# Project Error Log

## YYYY-MM-DD — Short issue title
- Symptom:
- Root cause:
- Correction:
- Prevention:
- Verification:
```

### `CODE_MAP.md`

Use `templates/CODE_MAP.md`. Every full-workflow business project tracks this concise
symbol-level navigation map. A project with no implementation code may explicitly record that
fact and defer symbol rows until implementation exists.

## 8. Verification boundary

Project knowledge accelerates onboarding and prevents repeated mistakes. It does not replace
current source reads, runtime/build checks, visual evidence, permission checks, or authoritative
remote verification required by `modules/29_MandatoryVerificationMatrix.md`.
