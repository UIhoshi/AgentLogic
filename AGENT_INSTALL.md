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

# Agent Installation Guide (V6.5 Stable)

This is the shortest installation path for AI agents. 

Goal: Install **AgentLogic V6.5** into the current local host without guessing the entrypoint, target bundle, or validation command.

## Do Not Guess

Before installing, identify:

1.  Whether the current directory is the AgentLogic repository root.
2.  The target host: `codex`, `claude`, `gemini`, or `generic`.
3.  The selected profile: **`core-enhanced`** is mandatory for full V6.5 governance support.
4.  Whether the host should bind to `MAIN.md` directly or to a generated bundle.

If uncertain, run the doctor first:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

## V6.5 Stable Facts

- **Current Version**: V6.5 (The "Tool Governance & Verification" Expansion).
- **Repository Role**: Primary local logic package (Method Layer).
- **Stable Host Entry**: `MAIN.md`.
- **Default Profile**: `core-enhanced` (Includes modules 20-34 for advanced governance).
- **Machine-readable Contract**: `manifest.json`.
- **Root Installer**: `install.ps1`.
- **Validation Command**: `scripts/validate-package.ps1`.

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

## Agent Decision Rule (V6.5)

If the user asks to "load", "install", "mount", "bind", or "use this logic locally", the agent **MUST** follow this protocol:

1.  **Doctor Check**: Run `scripts/doctor.ps1` to verify environment and path integrity.
2.  **Target Selection**: Choose the target host (`codex`, `claude`, `gemini`, or `generic`) based on the current environment.
3.  **Install**: Run the matching `install.ps1 -TargetHost ...` command using the `core-enhanced` profile.
4.  **Validation**: Run `scripts/validate-package.ps1`.
5.  **Adoption**: Immediately after installation, the agent must:
    -   Read `versions/AgentLogic_V6_5.md` to understand the new line.
    -   Adopt the **Mandatory Verification Matrix** (Module 29) for all subsequent claims.
    -   Adopt the **4-Tier Memory Taxonomy** (User, Feedback, Project, Reference) for project notes.
6.  **Report**: State the installed host, version (V6.5), profile, and confirmation that the new governance rules are active.

Do not search through unrelated project files or treat the AgentLogic repository as a business workspace.
