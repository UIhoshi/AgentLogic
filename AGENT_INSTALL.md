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

# Agent Installation Guide (V6.8.6 Stable)

This is the shortest installation path for AI agents.

Goal: Install **AgentLogic V6.8.6** into the current local host without guessing the entrypoint, target bundle, or validation command.

## Do Not Guess

Before installing, identify:

1.  Whether the current directory is the AgentLogic repository root.
2.  The target host: `codex`, `claude`, `antigravity`, or `generic`.
3.  The selected profile: **`core-enhanced`** is the default for full V6.8.6 governance support.
4.  Whether the host should bind to `MAIN.md` directly or to a generated bundle.

If uncertain, run the doctor first:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1
```

## V6.8.6 Stable Facts

- **Current Version**: V6.8.6 (including project-native L1-L4 maps and project error synchronization).
- **Repository Role**: Primary local logic package (Method Layer).
- **Stable Host Entry**: `MAIN.md`.
- **Default Profile**: `core-enhanced` (Includes the current runtime, verification, SDD, SRA, skill, and reviewability governance modules).
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

### Antigravity
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost antigravity
```

### Generic
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost generic
```

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

## Agent Decision Rule (V6.8.6)

If the user asks to "load", "install", "mount", "bind", or "use this logic locally", the agent **MUST** follow this protocol:

1.  **Doctor Check**: Run `scripts/doctor.ps1` to verify environment and path integrity.
2.  **Target Selection**: Choose the target host (`codex`, `claude`, `antigravity`, or `generic`) based on the current environment.
3.  **Install & Legacy Backup**: Run the matching `install.ps1 -TargetHost ...` command using the `core-enhanced` profile. The installer verifies the new target first, then moves other legacy logic files into a timestamped `.agentlogic-backup` directory instead of deleting them.
4.  **Validation**: Run `scripts/validate-package.ps1`.
5.  **Skill Governance Audit**: Run a dry-run host-local skill inventory for the target host. Applying archive moves is a separate, explicit operation after review. The default install path executes:
    - `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\skills-governance.ps1 -TargetHost <host>`
    The purpose is:
    - identify budget-heavy domain skill packs
    - preserve engineering-critical skills in the visible set
    - report host-local skill sprawl without silently mutating it
6.  **Adoption**: Immediately after installation, the agent must:
    -   Read `versions/AgentLogic_V6_8_6.md` to understand the new line.
    -   Adopt the **Mandatory Verification Matrix** (Module 29) for all subsequent claims.

## Workflow Skill-Enforcement Payload

Every supported adapter also deploys and verifies a self-contained skill-enforcement payload. It
contains the preflight, invocation-record, and closure validator plus its machine-readable
contracts. The installed level is `workflow_enforced`: it blocks incomplete recorded route
transitions, but it must **not** be described as host-native interception of arbitrary tool calls
unless a separately verified host hook exists. See
`modules/53_V6_8_ProgrammingLevelSkillEnforcement.md`.
    -   Adopt the **4-Tier Memory Taxonomy** (User, Feedback, Project, Reference) for project notes.
    -   Adopt the **Spec-Driven Development (SDD) Lifecycle** (Module 38) for technical tasks.
    -   Adopt the **Taste Frontend Design Standards** (Module 39) for interface and visual changes.
7.  **Report**: State the installed host, version (V6.8.6), profile, and confirmation that the new governance rules are active.

## Install-Time And Update-Time Skill Rule (V6.8.6)

Every local installation **and every local logic update** of AgentLogic should perform a host-local
skill inventory pass. Moving or archiving host-local skills requires a separate explicit `-Apply`
operation after the inventory has been reviewed.

This is required because:

- each machine may have a different host-local skill inventory
- old machines and old host installs may have accumulated stale or oversized host-local skill sets
- large domain skill packs can crowd out the most useful engineering skills
- duplicate-or-overlapping skill families must be classified instead of guessed
- host-local skills must stay separate from any logic-carried skill layer so one machine's local packs do not become another machine's default logic state

The V6.8.6 install/update rule is:

1. identify the host-local skill zone for the target host
2. keep that host-local zone separate from the logic-carried layer
3. inspect only the host-local skills directory during the governance pass
4. classify active-by-default vs archive-by-default families
5. preserve engineering-critical skill families in the visible pool
6. archive budget-heavy domain packs off-by-default unless the user explicitly wants them active

Use:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\skills-governance.ps1 -TargetHost codex -Apply
```

Replace `codex` with `claude` or `antigravity` when needed.

The install/update governance pass is for the **host-local skill zone only**. It must not treat host-local skill state as portable repository truth.

See also:
- `modules/35_V6_5_SkillGovernanceAndMandatoryUse.md`
- `modules/36_V6_5_SkillZoneSeparation.md`
- `modules/37_V6_6_CybersecuritySkillsRouter.md`
- `modules/38_V6_6_SpecDrivenDevelopment.md`
- `modules/39_V6_6_TasteFrontendDesign.md`

Do not search through unrelated project files or treat the AgentLogic repository as a business workspace.
