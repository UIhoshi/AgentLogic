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

# Install AgentLogic Locally

This page is the human-facing installation entry for AgentLogic.

If you are an AI agent, start with [`AGENT_INSTALL.md`](./AGENT_INSTALL.md) instead.

## What "Install" Means

AgentLogic is not a normal app dependency. Installing it means:

1. build the selected AgentLogic profile into a host-ready bundle;
2. copy or bind that bundle to the target AI host;
3. verify that the local host can use `MAIN.md` or the generated bundle as its primary logic.

The stable host binding entry is:

- `MAIN.md`

The default profile is:

- `core-enhanced`

## Legacy Logic Detection & Backup (Mandatory Step)

To prevent conflicts where the AI client loads stale or outdated rules, the `install.ps1` script
checks legacy files after the new target has been verified. Other legacy files are moved into a
timestamped `.agentlogic-backup` directory; the selected new target is never removed.


## First Diagnostic Command

Run this before guessing which command to use:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

The doctor checks the repository shape, reads `manifest.json`, lists supported hosts, and prints the recommended install commands.

## One-Command Install

Choose the host that should receive the local logic.

### Codex

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost codex
```

### Claude

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost claude
```

### Antigravity

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost antigravity
```

### Generic bundle

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost generic
```

On shell environments:

```bash
./install.sh --host codex
```

## Validate The Package

Installation also deploys a verified `workflow_enforced` skill-routing payload for the selected
host. This validates recorded preflight, invocation, and closure states; it does not claim
host-native interception without a separately verified host hook.

After installation or repository changes:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

For maintainers:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1
```

## Important Boundaries

- Do not treat this repository as a business project workspace.
- Do not create unrelated project files inside this repository.
- Hosts should bind to `MAIN.md` or to a generated bundle, not directly to a versioned file.
- Generated bundles are built from `manifest.json` and `scripts/build-profile.ps1`.
