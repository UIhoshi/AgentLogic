# AgentLogic V6.7.2 Logic Audit Remediation Specification

## Status

Approved for implementation by the user after the read-only logic audit.

## Problem

The repository declares V6.7.2 as stable, but active documentation, generated host bundles,
entry-gate sequencing, validation scripts, and installation behavior are not governed by one
consistent contract. Several expensive or destructive steps are also unconditional even when
the task does not use the related capability.

## Goals

1. Make the active entry chain unambiguous and internally ordered.
2. Make stable-version metadata and all tracked host bundles converge on V6.7.2.
3. Keep generated bundles portable and deterministic.
4. Make SDD, SRA, visual, glossary, skill, security, and performance gates conditional on
   task type and capability rather than universal.
5. Strengthen repository validation so stale bundles and stale active-version references fail.
6. Make installation fail-safe: validate before mutation, check child-process failures, verify
   the installed target, and back up legacy files instead of deleting them irreversibly.

## Non-goals

- Rewriting historical version files.
- Auditing the imported raw skill content as part of this change.
- Changing host-specific configuration formats beyond what is needed for safe installation.
- Creating business-project documentation in this logic repository.

## Acceptance Criteria

- `AGENTS.md`, `00_START_HERE.md`, and `15_LogicEntryChecklist.md` describe the same startup order.
- Non-extension rounds always require an explicit context-reset decision; no token-based silent
  exception remains in the mandatory checklist.
- The active docs and modules use V6.7.2 labels; historical version files remain unchanged.
- `build-profile.ps1` emits deterministic bundles without machine-specific absolute paths.
- All four tracked host bundles are rebuilt from the current `core-enhanced` profile.
- `check-logic-entry.js` catches stale active references, absolute machine paths, and chain-order drift.
- `validate-package.ps1` verifies generated host outputs and their current version headers.
- Installation checks nested command failures, verifies outputs, and backs up legacy files after
  successful installation without deleting the newly selected target.
- SDD/SRA requirements explicitly distinguish read-only audits, documentation-only changes,
  trivial fixes, feature work, frontend work, and release/packaging work.
- `doctor.ps1`, `validate-package.ps1`, `check-logic-entry.js`, and `maintainer-check.ps1` pass.
