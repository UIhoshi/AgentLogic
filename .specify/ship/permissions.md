# Permissions

## Repository writes

- `scripts/build-profile.ps1` writes only the requested generated output path.
- `maintainer-check.ps1` writes the four tracked `dist/` bundles as its explicit build step.
- Documentation and logic changes require the repository SDD path selected by task applicability.

## Host writes

- Host adapters write their selected instruction bundle and host configuration where applicable.
- `install.ps1` may move legacy files only after successful target verification and only into a
  timestamped backup directory.
- Host-local skill files are inventory-only during install; `-Apply` is required for archive moves.

## Safety rules

- No remote state is changed by the repository scripts.
- No generated bundle may contain a machine-specific absolute file URI.
- Nested PowerShell commands must return exit code zero before the next side effect proceeds.
