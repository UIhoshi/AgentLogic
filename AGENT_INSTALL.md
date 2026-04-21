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

# Agent Installation Guide

This is the shortest installation path for AI agents.

Goal: install AgentLogic into the current local AI host without guessing the entrypoint, target bundle, or validation command.

## Do Not Guess

Before installing, identify:

1. whether the current directory is the AgentLogic repository root;
2. the target host: `codex`, `claude`, `gemini`, or `generic`;
3. the selected profile, normally `core-enhanced`;
4. whether the host should bind to `MAIN.md` directly or to a generated bundle.

If uncertain, run the doctor first.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

## Stable Facts

- Repository role: primary local logic package.
- Stable host entry: `MAIN.md`.
- Default profile: `core-enhanced`.
- Machine-readable contract: `manifest.json`.
- Root installer: `install.ps1`.
- Validation command: `scripts/validate-package.ps1`.

## Install Commands

### Codex

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost codex
```

### Claude

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost claude
```

### Gemini

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost gemini
```

### Generic

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost generic
```

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

## Agent Decision Rule

If the user asks to "load", "install", "mount", "bind", or "use this logic locally", do this:

1. run `scripts/doctor.ps1`;
2. choose the target host from local context or the user request;
3. run the matching `install.ps1 -TargetHost ...` command;
4. run `scripts/validate-package.ps1`;
5. report the installed host, profile, output path, and any remaining manual binding step.

Do not search through unrelated project files or treat the AgentLogic repository as a business workspace.
