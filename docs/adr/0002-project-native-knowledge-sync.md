# ADR-0002: Project-Native Knowledge Sync

- **Status:** Accepted
- **Date:** 2026-07-18

## Context

The former mandatory `modification_history` workflow stored project-specific error records
outside the corresponding project repository. A new machine or agent therefore needed a
second checkout and a manual mapping step before it could recover the project's actual
structure and lessons. The records could also drift from the code revision they described.

## Decision

1. AgentLogic remains the globally installed method layer; it is not copied into projects.
2. A business project using the full workflow tracks three minimal knowledge artifacts with
   its code: root `AGENTS.md`, root `PROJECT_MAP.md`, and `.learnings/ERRORS.md`.
3. `PROJECT_MAP.md` holds only redacted, factual L1-L4 structure and verification knowledge.
   `.learnings/ERRORS.md` holds concise redacted error/correction records.
4. Project entry checks remote freshness with `git fetch --prune` and repository status before
   relying on the tracked knowledge. A pull remains a separately confirmed state change.
5. `.specify/` and `docs/adr/` remain conditional artifacts, used only when the matching SDD
   or hard-to-reverse-decision gate applies.
6. `modification_history` becomes an optional cross-project reference/archive. It is no longer
   a blocking prerequisite for ordinary business-project work or publication.

## Consequences

- Project code, maps, and durable local lessons travel together in normal Git commits.
- Public or shared repositories must keep these records free of secrets, personal prompts,
  machine paths, raw logs, and unreviewed generated artifacts.
- Recurring lessons may still be promoted to AgentLogic or the optional cross-project archive.
- Existing `modification_history` records are retained as historical material and need not be
  migrated automatically.
