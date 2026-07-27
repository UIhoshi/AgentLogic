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

# AgentLogic Main Entry

This file is the stable machine-facing entrypoint for AgentLogic.

Hosts that want to install this repository as their primary local logic should bind to this file, or to a bundle built from the profile declared in `manifest.json`.

For local installation discovery:

- AI agents should read `AGENT_INSTALL.md` first.
- Humans should read `INSTALL.md` first.
- The diagnostic command is:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

Do not bind hosts directly to `versions/AgentLogic_V6_8_4.md` or any future versioned file name.

## Purpose

AgentLogic is intended to become the default operating logic for local AI coding hosts.

That means the rules here are meant to apply across:

- new project starts
- project updates
- refactors
- reviews
- release preparation
- version iteration
- context reset or forget/compress decisions

## Stable Entry Rules

1. Treat `manifest.json` as the machine-readable source of truth for:
   - current stable version
   - default profile
   - files included in each profile
   - host-specific output targets
2. Use the `core-enhanced` profile by default unless a host or user explicitly selects another profile.
3. Preserve the mandatory startup and forget/compress rules contained in the bundled files.
4. Keep versioned files as historical sources; keep `MAIN.md` as the only stable host binding target.
5. Treat `reference/raw_*` directories as reference layers, not default prompt material.

## Recommended Host Behavior

When a host installs AgentLogic as its primary logic, it should:

1. Sync the repository locally.
2. Read `manifest.json`.
3. Build the default profile bundle.
4. Write that bundle to the host's main instruction surface.
5. Re-sync and rebuild on future host startups or explicit refresh actions.

## Current Default Profile

- `core-enhanced`

## Current Stable Version File

- `versions/AgentLogic_V6_8_4.md`

## Host Adapters

- Codex: `adapters/codex/install.ps1`
- Claude: `adapters/claude/install.ps1`
- Antigravity: `adapters/antigravity/install.ps1`
- Generic host output: `adapters/generic/install.ps1`
