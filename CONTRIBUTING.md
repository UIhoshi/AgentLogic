# Contributing To AgentLogic

This repository is not a normal application repo. It is logic infrastructure that other AI hosts bind to as their primary operating logic.

That changes the maintenance bar:

- treat entry files as interfaces, not prose
- treat `manifest.json` as a machine contract, not documentation
- preserve stable host binding even when versioned logic changes
- prefer additive versioning over in-place replacement of historical logic

## Non-Negotiable Entry Surfaces

These files are protected interfaces and must be changed deliberately:

- `MAIN.md`
  stable machine-facing host entrypoint
- `00_START_HERE.md`
  stable human first-read entrypoint
- `manifest.json`
  machine contract for profiles, outputs, adapters, and current version
- `install.ps1`
  root PowerShell installation entry
- `install.sh`
  root shell installation entry

Do not rename, relocate, or repurpose these files casually.

## Directory Contract

- `versions/`
  historical and current versioned logic sources
- `modules/`
  reusable operating-rule modules
- `reference/`
  non-default reference material
- `adapters/`
  host-specific installation layer
- `scripts/`
  validation, release, and bundle tooling
- `dist/`
  generated output only, not source of truth

If you change this structure, you must update:

- `manifest.json`
- `README.md`
- `00_START_HERE.md`
- any affected adapter or script

## Required Checks Before Merge

Run the maintainer check:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1
```

Minimum required checks:

- package validation passes
- default generic bundle builds
- documentation still matches actual structure

If you changed adapters or install entrypoints, also run the relevant installer manually.

## Version Bump Rules

Do not hand-edit version bumps across multiple files.

Use:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\release-version.ps1 -NewVersion V7
```

Then rerun:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1
```

Version bump expectations:

- create a new file under `versions/`
- keep the old version file intact
- update `manifest.json`
- update active documentation references
- do not rewrite history by mutating old version files

## Change Policy

Safe change classes:

- adding a new profile
- adding a new adapter
- improving validation or release tooling
- adding documentation that clarifies the package contract
- adding a new version file and promoting it through the manifest

High-risk change classes:

- moving entry files
- changing profile membership semantics
- changing adapter invocation parameters
- changing bundle generation format
- changing the startup-chain semantics in the core logic

High-risk changes must be validated end to end.

## Do Not Do These

- Do not bind hosts directly to files under `versions/`
- Do not treat `reference/` content as default bundle material unless explicitly opting in
- Do not edit generated files in `dist/` by hand
- Do not change `current_version` without also changing `main_logic_file`
- Do not introduce a new host path convention without documenting it in `README.md`

## Practical Workflow

1. Make the structural or logic change.
2. Update `manifest.json` if profiles, outputs, adapters, or version pointers changed.
3. Update `README.md` and `00_START_HERE.md` if the public contract changed.
4. Run `.\scripts\maintainer-check.ps1`.
5. If releasing a new version, use `.\scripts\release-version.ps1` rather than manual edits.

## Pull Request Notes

In the PR description, state explicitly:

- whether entry surfaces changed
- whether profile membership changed
- whether a host adapter changed
- whether this is a version promotion
- which scripts you ran locally
