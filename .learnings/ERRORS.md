# Project Error Log

## 2026-07-22 — PowerShell reserved-variable collision during bundle rebuild
- Symptom: The profile-build loop failed before invoking the build script.
- Root cause: The loop variable was named `$host`, which collides with PowerShell's read-only
  automatic `$Host` variable.
- Correction: Renamed the loop variable to `$targetHost`.
- Prevention: Avoid PowerShell automatic-variable names for loop and temporary variables.
- Verification: All four host bundles subsequently rebuilt and passed package validation.

## 2026-07-22 — UTF-8 BOM broke a Node validation script
- Symptom: `node scripts/check-logic-entry.js` failed with `SyntaxError: Invalid or unexpected token` at the first character.
- Root cause: PowerShell `Set-Content -Encoding utf8` wrote a BOM before the JavaScript shebang.
- Correction: Rewrote the script as UTF-8 without BOM.
- Prevention: Preserve BOM-free UTF-8 for Node/JavaScript entrypoints after PowerShell-based edits; run `node --check` before package validation.
- Verification: `node scripts/check-logic-entry.js` and package validation passed.
