# AgentLogic

AgentLogic is a versioned primary-logic package intended to be pulled into local AI coding hosts and used as their default operating logic.

It is designed to govern:

- project starts
- project updates
- version iteration
- refactors
- reviews
- release preparation
- forget/compress-context decisions

## Stable Entry

The stable machine-facing entrypoint is:

- `MAIN.md`

Hosts should bind to `MAIN.md` or to a generated bundle built from `manifest.json`.

Hosts should not bind directly to `versions/AgentLogic_V6.md` or any future versioned file name.

## Architecture

This repository now has four responsibilities:

- source logic
  versioned logic files and supporting rule documents
- profile definition
  machine-readable bundle membership in `manifest.json`
- host adaptation
  installation scripts in `adapters/`
- bundle generation
  host-ready outputs built by `scripts/build-profile.ps1`

## Current Default Profile

- `core-enhanced`

This profile is the recommended default for general coding work and includes:

- startup chain rules
- project update rules
- version iteration rules
- forget/compress-context rules
- agentic loop rules
- permissions and safety rules
- enforcement rules

## Repository Layout

- `MAIN.md`
  - stable host binding entrypoint
- `manifest.json`
  - machine-readable package contract
- `profiles/`
  - profile documentation
- `adapters/`
  - host installation layer
- `scripts/`
  - bundle generation
- `versions/`
  current stable and future versioned logic sources
- `modules/`
  core operating rules and optional publishing modules
- `reference/raw_tools/`, `reference/raw_tooling/`, `reference/raw_permissions/`, `reference/raw_extensions/`, `reference/raw_commands/`
  reference layers, not default prompt material

## One-Command Host Setup

Install into any supported host through the root installer:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost codex
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost claude
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost gemini
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost generic
```

Shell environments can use the same installer through `install.sh`:

```bash
./install.sh --host codex
```

Direct host adapter calls remain available when a host needs custom target paths.

Build a host-ready bundle directly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-profile.ps1 -ProfileName core-enhanced -TargetHost generic
```

Install into Codex:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\codex\install.ps1
```

Build a Claude-ready bundle:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\claude\install.ps1
```

Build a Gemini-ready bundle:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\gemini\install.ps1
```

## Usage Rules

For any host using AgentLogic as its primary local logic:

1. Sync the repository.
2. Read `manifest.json`.
3. Build the selected profile bundle.
4. Bind that bundle to the host's primary instruction surface.
5. Rebuild and refresh on future updates.

## Package Validation

Validate the package contract after any refactor, version bump, or profile change:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

The validation checks:

- stable entry and human entry exist
- `manifest.json` and `manifest.schema.json` stay aligned
- every declared profile file exists
- optional modules and adapters resolve
- `current_version` matches `main_logic_file`

For maintainers, run the full lightweight local gate:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1
```

## Version Release

Prepare the next version by copying the current version file, updating the manifest, and rewriting active documentation references:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\release-version.ps1 -NewVersion V7
```

Then run validation again:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

GitHub Actions also runs package validation and one default bundle build on every push and pull request through `.github/workflows/validate-package.yml`.

## Contribution Contract

Maintenance rules for entry surfaces, version bumps, and required local checks are documented in `CONTRIBUTING.md`.

## Important Boundaries

- This repository is logic infrastructure, not a business project workspace.
- `00_START_HERE.md` remains the human-readable mandatory first-entry control file for the logic source.
- `MAIN.md` is the stable host entrypoint.
- Versioned logic should remain versioned; the stable host binding should remain version-agnostic.
- Reference raw layers must not be injected as default prompt material unless a host or user explicitly opts in.
