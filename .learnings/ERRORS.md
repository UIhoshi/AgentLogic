# Project Error Log

## 2026-07-22 鈥?PowerShell reserved-variable collision during bundle rebuild
- Symptom: The profile-build loop failed before invoking the build script.
- Root cause: The loop variable was named `$host`, which collides with PowerShell's read-only
  automatic `$Host` variable.
- Correction: Renamed the loop variable to `$targetHost`.
- Prevention: Avoid PowerShell automatic-variable names for loop and temporary variables.
- Verification: All four host bundles subsequently rebuilt and passed package validation.

## 2026-07-22 鈥?UTF-8 BOM broke a Node validation script
- Symptom: `node scripts/check-logic-entry.js` failed with `SyntaxError: Invalid or unexpected token` at the first character.
- Root cause: PowerShell `Set-Content -Encoding utf8` wrote a BOM before the JavaScript shebang.
- Correction: Rewrote the script as UTF-8 without BOM.
- Prevention: Preserve BOM-free UTF-8 for Node/JavaScript entrypoints after PowerShell-based edits; run `node --check` before package validation.
- Verification: `node scripts/check-logic-entry.js` and package validation passed.

## 2026-07-22 – Skill adapter copy can create an unintended nested directory
- Symptom: The installed product-requirements skill was not discovered at the expected `SKILL.md` path.
- Root cause: Copying a wildcard into an already-created target directory nested the source directory.
- Correction: Remove the target and copy the skill directory itself; create only its parent first.
- Prevention: Verify the exact deployed `<skill>/SKILL.md` path after each adapter install.

## 2026-07-23 – Reserved PowerShell `$Host` variable in host-contract validation
- Symptom: skill-routing validation failed before inspecting the host deployment contract.
- Root cause: a foreach loop used `$host`, colliding with PowerShell's read-only automatic `$Host` variable.
- Correction: renamed the loop variable to `$targetHostName`.
- Prevention: avoid PowerShell automatic-variable names in scripts and run the route validator immediately after edits.

## 2026-07-23 – Antigravity installer backed up its own compatibility hook
- Symptom: a smoke install created the legacy compatibility hook and then the top-level installer moved it to backup.
- Root cause: Antigravity's adapter intentionally writes `.gemini/AgentLogic/GEMINI.md`, but `install.ps1` did not list that path as an installed/protected target.
- Correction: include the compatibility hook in Antigravity post-install targets when using the default path.
- Prevention: smoke-test every adapter through the top-level installer, including legacy-file protection behavior.
