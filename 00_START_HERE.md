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

# 00_START_HERE.md

This file is the mandatory first entry for this logic repository.

## Local Installation Entry

For local installation, read `AGENT_INSTALL.md` first if you are an AI agent.
For human installation, read `INSTALL.md` first.

Recommended first diagnostic command:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

## File Boundary

This file is logic, not project content.

- Do not treat this file as a business-project README.
- Do not use this file to record normal project changes.
- Do not modify this file unless the user explicitly allows a logic-entry update or rule update.
- If the task is normal project work, read this file and continue to the mandatory reading chain instead of editing it.

## Mandatory Full-Read Chain

Before any formal planning, implementation, modification, validation, review, packaging, or rule synchronization work, the agent MUST fully read all of the following files from beginning to end in this exact order:

1. `README.md`
2. `versions/AgentLogic_V6_5.md`
3. `modules/01_MasterLogic.md`
4. `modules/15_LogicEntryChecklist.md`

## Non-Negotiable Rules

- All listed files are mandatory.
- Full reading is mandatory.
- Skimming is not allowed.
- Partial reading is not allowed.
- Keyword-only reading is not allowed.
- Summary-based substitution is not allowed.
- Reading only selected sections is not allowed.
- Previous-session memory does not replace a new full read.
- The agent must not treat itself as ready for formal work until all listed files have been fully read.

## Startup Chain

After the mandatory full-read chain is complete, every new coding round must follow this exact order:

1. Confirm the current logic entry.
2. Judge whether the task is an extension of the previous coding round.
3. If it is not an extension, ask the user whether to `forget/compress context` before continuing.

Until the reading chain and the startup chain are both satisfied, the agent is not in a formal implementation-ready state.

## Host Binding Note

For local AI host installation, the stable binding target is `MAIN.md`.

- Humans should start from `00_START_HERE.md`.
- Hosts should bind to `MAIN.md` or to a generated profile bundle.
- Versioned files under `versions/` remain source-of-truth history, not direct host binding targets.


## Continuous Execution Override

The startup chain exists to prevent context drift, forgotten constraints, and accidental task switching.
It does **not** exist to force repeated confirmation during one continuous execution track.

If the user explicitly says any equivalent of:

- "unless I say stop, keep going"
- "do not stop to ask me again"
- "follow the plan continuously"
- "keep writing until I tell you to stop"

then the agent must treat that statement as an active continuous-execution authorization for the current task scope.

Under that authorization:

- the task should default to being treated as an extension of the current coding round
- the agent must continue through the planned sequence without repeated confirmation at ordinary implementation boundaries
- the agent should only stop for user input when one of the following is true:
  - the user explicitly says to stop
  - the current plan has been completed and a new strategic direction is needed
  - a true blocker exists that cannot be resolved from local context
  - a high-risk irreversible action is about to be taken

This authorization should also be interpreted as meaning the work is still in an implementation / build-out phase by default, not yet in the formal product-test or acceptance-test phase, unless the user explicitly says the work has entered testing.
