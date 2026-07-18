# Project-Knowledge Sync Protocol

## Status

Approved by the user for implementation.

## Problem

The current mandatory `modification_history` workflow separates project code from its
project-specific L1-L4 map and error history. That makes cross-machine recovery depend
on a second repository and risks a mismatch between the current code revision and the
knowledge used to operate it.

## Requirements

1. Replace the mandatory external-history dependency for business-project work with a
   project-native, Git-tracked knowledge contract.
2. Require every project using the full AgentLogic workflow to keep these three tracked
   files:
   - `AGENTS.md` for concise project-only instructions, commands, and verification rules;
   - `PROJECT_MAP.md` for the project's factual L1-L4 map, entrypoints, key boundaries,
     validation commands, and confirmed/unconfirmed state;
   - `.learnings/ERRORS.md` for concise, redacted project mistakes, root causes,
     corrections, prevention, and verification.
3. Require structural changes to update `PROJECT_MAP.md` in the same project commit and
   material error corrections to update `.learnings/ERRORS.md` in the same project commit.
4. At project entry, require a safe remote freshness check (`git fetch --prune` plus
   branch/worktree inspection) before relying on the tracked project knowledge. A
   mutating pull must remain conditional on a clean workspace and confirmed target.
5. Treat `.specify/` as required only for matching non-trivial SDD work and `docs/adr/`
   as required only for hard-to-reverse decisions.
6. Keep generated `graphify-out/` artifacts out of the default Git sync surface; record
   durable graph findings in `PROJECT_MAP.md` instead.
7. Prohibit secrets, tokens, local absolute paths, personal prompts, raw terminal logs,
   caches, and build artifacts from the tracked knowledge files.
8. Retire `modification_history` as a blocking prerequisite for ordinary business-project
   coding and publishing. It may remain an optional, cross-project reference archive;
   AgentLogic's own release history may still be maintained there during migration.

## Non-goals

- Copying the full global AgentLogic bundle into every business project.
- Automatically pulling remote Git changes, installing Graphify, or committing generated
  graph outputs.
- Synchronizing private user memory or credentials through a project repository.

## Acceptance Criteria

- The active version, entry rules, enforcement module, fact-map template, SDD/SRA/Graphify
  integrations, and system map describe the project-native protocol consistently.
- A reusable template for `PROJECT_MAP.md` and `.learnings/ERRORS.md` is available.
- The default profiles include the new protocol module and rebuilt bundles.
- Validation detects the active project-knowledge contract and no active rule still makes
  `modification_history` mandatory for ordinary project work.
- Entry, package, and maintainer validation pass after regeneration.
