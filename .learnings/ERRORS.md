# Project Error Log

## 2026-07-22 — PowerShell reserved-variable collision during bundle rebuild
- Symptom: The profile-build loop failed before invoking the build script.
- Root cause: The loop variable was named `$host`, which collides with PowerShell's read-only
  automatic `$Host` variable.
- Correction: Renamed the loop variable to `$targetHost`.
- Prevention: Avoid PowerShell automatic-variable names for loop and temporary variables.
- Verification: All four host bundles subsequently rebuilt and passed package validation.
