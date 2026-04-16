# AgentLogic

This repository is the dedicated logic-package repository for the current Agent workflow.

It is not a business project repository. It is an external rules brain that defines how project work should be entered, checked, executed, validated, and synced.

## Current Logic Entry

Start from:

- `00_START_HERE.md`

Then fully read the mandatory chain defined there.

For this repository, the required full-read chain is:

1. `README.md`
2. `AgentLogic_V6.md`
3. `01_MasterLogic.md`
4. `15_LogicEntryChecklist.md`

The agent must not treat itself as ready for formal work until the full-read chain has been completed.

## What This Repository Contains

- `AgentLogic_V6.md`
  The main logic file and highest-priority workflow rule set.
- `01_MasterLogic.md`
  A project-level reinforcement and mapping layer for the main logic.
- `02_Architecture.md` to `15_LogicEntryChecklist.md`
  Supporting layers for architecture, tools, safety, extensibility, packaging, and logic-entry templates.
- `raw_tools/`
  Raw tool source layer.
- `raw_tooling/`
  Tool registration and execution infrastructure layer.
- `raw_permissions/`
  Permission and safety core layer.
- `raw_extensions/`
  MCP, skills, and agent-extension layer.
- `raw_commands/`
  Command-surface raw source layer.

## How To Use This Repository

For project work:

1. Confirm where the current project's logic entry is declared.
2. If the project points to this repository, re-read:
   - `00_START_HERE.md`
   - `README.md`
   - `AgentLogic_V6.md`
   - `01_MasterLogic.md`
   - `15_LogicEntryChecklist.md`
3. Read the project's own markdown and fact files.
4. Read the relevant code files.
5. Re-check the intended change through the logic lens.
6. Implement and validate.

If a project no longer points to this repository or the logic-entry path is missing, do not guess. Ask the user where the current logic package is located first.

## Important Boundaries

- This repository is versioned logic, not a business workspace.
- `00_START_HERE.md` is logic-entry control, not project content, and must not be modified unless the user explicitly asks for a logic update.
- Do not create project code, logs, builds, or runtime artifacts here.
- Main entry code files in business projects should point back to repository-relative entry docs such as `AGENTS.md` and `README.md`, not to machine-specific absolute paths.
- Logic-entry rules should stay version-agnostic. Do not assume future projects will always remain on `V6`.
- Business projects should also provide a repository-level enforcement script, such as `node scripts/check-logic-entry.js`, so logic-entry reminders can be checked mechanically instead of relying only on chat memory or human discipline.

## Related File

- `00_START_HERE.md`
  The mandatory first-entry file for this logic repository.
- `00_README.md`
  The package-internal structure overview.
