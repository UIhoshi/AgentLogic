# Project Error Log
## 2026-11-03 - Stale V6.8.7 references, CP936 em-dash mojibake in `AGENTS.md`, and Windows Defender false-positive on raw XSS reference docs
- Symptom: (1) `AGENTS.md` line 111 contained a CP936-corrupted em-dash (`repository—not a separate history checkout—is`), which propagated into all four compiled `dist/` bundles; (2) `AGENT_INSTALL.md` and `modules/40_AgentLogicSystemMap.md` still referenced `V6.8.7` / `versions/AgentLogic_V6_8_7.md`; (3) full-repo Markdown scans on Windows failed with `Operation did not complete successfully because the file contains a virus or potentially unwanted software` when reading three reference files under `skills/reverse-skill/` (`playbooks/xss.md`, `payloader/by-category/web/xss跨站脚本.md`, and `payloader/waf-bypass.md`).
- Root cause: `scripts/check-logic-entry.js` and `scripts/validate-package.ps1` only checked for `V6.7.0`/`V6.7.1` stale versions and did not scan active Markdown files or generated bundles for CP936/CP1252 mojibake (`\u9225`, `\uFFFD`); additionally, three vendored security reference files contained raw `<script>` / `onerror=` / payload strings that triggered Windows Defender's real-time file filter on read.
- Correction: Repaired the em-dash in `AGENTS.md`, `.learnings/ERRORS.md`, and `.specify/autonomous-skill-enforcement/ship.md`; updated `AGENT_INSTALL.md`, `modules/40_AgentLogicSystemMap.md`, and `modules/01_MasterLogic.md` to `V6.9.0`; added YAML front-matter `name:` headers to 8 `reverse-skill` `SKILL.md` files; defanged raw script/payload tags in the three security reference files; added explicit `-Encoding UTF8` to `Get-Content` calls across PowerShell scripts; and extended `scripts/check-logic-entry.js` and `scripts/validate-package.ps1` to reject `V6.8.x` stale references and mojibake characters.
- Prevention: Enforce automated mojibake and stale-version checks across all active entry/module Markdown files and compiled `dist/` bundles in `check-logic-entry.js` and `validate-package.ps1`, and keep security reference examples defanged so host antivirus filters do not block file reads.
- Verification: `node scripts/check-logic-entry.js`, `scripts/audit-skill-duplicates.ps1`, `scripts/maintainer-check.ps1`, and full-repository Markdown read scans pass with zero errors or Defender blocks.
## 2026-10-31 - Un-BOMed UTF-8 em-dash in `build-profile.ps1` broke Windows PowerShell 5.1 on GitHub Actions (CP1252)
- Symptom: GitHub Actions workflow `Validate AgentLogic Package #85` (`windows-latest`) failed during `./scripts/validate-package.ps1` with `ParserError: Missing ')' in method call` at `scripts/build-profile.ps1:81` (`> **Gate 1 [CP1252-garbled em-dash] Startup Context-Reset...`), while passing locally on a CP936 Windows machine; additionally, `~/.gemini/GEMINI.md` displayed a garbled CP936 em-dash instead of `—` in the Gate 1 header.
- Root cause: `scripts/build-profile.ps1` and `adapters/antigravity/install.ps1` were saved as UTF-8 without BOM and contained literal em-dash characters (`—`, UTF-8 bytes `0xE2 0x80 0x94`). When `validate-package.ps1` invoked Windows PowerShell 5.1 (`powershell.exe`), PowerShell 5.1 decoded un-BOMed `.ps1` scripts using the system default ANSI code page (`Windows-1252` on GitHub Actions `windows-latest`, `CP936` locally). In `Windows-1252`, byte `0x94` maps to the right double quotation mark (`”`), which PowerShell's lexer treats as a closing string delimiter (`"`), prematurely terminating the double-quoted string literal at line 81.
- Correction: Replaced literal non-ASCII characters (`—` and Chinese prompt text) in `scripts/build-profile.ps1` and `adapters/antigravity/install.ps1` with pure ASCII `[regex]::Unescape('\u2014')` / `\uXXXX` escapes, stripped the stray UTF-8 BOM from `scripts/deploy-skill-enforcement.ps1`, and added both a Node byte-level ASCII/BOM check in `scripts/check-logic-entry.js` and a simulated `CP1252` AST parse gate (`[System.Management.Automation.Language.Parser]::ParseInput`) in `scripts/validate-package.ps1`.
- Prevention: Keep all operational `.ps1` scripts 100% pure ASCII (using `\uXXXX` escapes for any non-ASCII output text) and validate every `.ps1` file against `Windows-1252` parsing in `validate-package.ps1`.
- Verification: `node scripts/check-logic-entry.js`, `scripts/validate-package.ps1`, and `scripts/maintainer-check.ps1` pass with CP1252 parser simulation enabled.

## 2026-10-16 - Antigravity delegation hook omitted UI Preview Gate and corrupted backtick/UTF-8 text
- Symptom: Codex (`gpt`) reliably enforced the UI Preview Gate (generating a UI mockup before writing UI code unless opted out), whereas Antigravity sessions skipped straight to writing UI code after the Startup Gate; additionally, `~/.gemini/GEMINI.md` contained a form-feed control character (`\x0C`) in `` `forget/compress context` `` and garbled Chinese text.
- Root cause: (1) Because Antigravity caps rule files at 24 KB, `adapters/antigravity/install.ps1` wrote only a 1.5 KB delegation hook in `~/.gemini/GEMINI.md` that mentioned the Startup Gate (`forget/compress context`) and omitted the Mandatory UI Preview & Requirements Gate; (2) `install.ps1` used a double-quoted PowerShell Here-String (`@"..."@`) where `` `f `` was interpreted as form-feed and `Set-Content` lacked BOM-free UTF-8 encoding; (3) `~/.gemini/config/skills.json` did not register `~/.gemini/skills`, hiding `product-requirements-grilling` and `nano-banana-pro` from global skill discovery, and `ui-design` in `contracts/skill-routing.json` did not list Antigravity's built-in `image-generator` subagent.
- Correction: Replaced the double-quoted Here-String in `adapters/antigravity/install.ps1` with a single-quoted template written in BOM-free UTF-8, inlined the Mandatory UI Preview & Requirements Gate directly in `~/.gemini/GEMINI.md`, registered `~/.gemini/skills` in `~/.gemini/config/skills.json`, and added `image-generator` to `ui-design` in `contracts/skill-routing.json`.
- Prevention: For hosts that rely on a short rule pointer due to per-file size caps, always inline all blocking gates (Startup Gate + UI Preview & Requirements Gate + Knowledge Sync Gate) directly in the global rule file, use single-quoted PowerShell templates for Markdown containing backticks, and write with `[System.Text.UTF8Encoding]::new($false)`.
- Verification: `scripts/maintainer-check.ps1`, `scripts/test-skill-enforcement.ps1`, and `install.ps1 -TargetHost antigravity` pass, and `~/.gemini/GEMINI.md` is verified as clean UTF-8 without control characters.

## 2026-10-06 - Installation prerequisites caused repeated confirmation prompts
- Symptom: A requested OfficeCLI setup expanded into separate questions for review tooling, audits, and installation, despite one bounded objective.
- Root cause: The strict missing-capability and consent rules did not say to disclose the full prerequisite chain before asking.
- Correction: Module 49 now requires a scoped prerequisite bundle and one explicit decision for the listed review/setup/install sequence; Module 50 follows it for OfficeCLI.
- Prevention: Re-ask only for a failed gate or materially changed source, target, permission, data destination, or risk; never treat bundle approval as audit bypass.
- Verification: Generated bundles and package/maintainer checks pass; no installer execution is implied by this rule change.

## 2026-08-27 - PowerShell interpolation treated a label followed by a colon as a drive-qualified variable
- Symptom: The new workflow-graph validator failed to parse at `"Missing $Label: $Path"`.
- Root cause: PowerShell interpreted `$Label:` as a variable reference with a drive qualifier.
- Correction: Delimited the variable as `${Label}` before the colon.
- Prevention: Use `${name}` whenever a PowerShell variable is immediately followed by `:` in an interpolated string; run the new script directly before broader validation.
- Verification: `validate-skill-workflow-graph.ps1` and its cyclic-fixture regression test pass.

## 2026-08-24 – `$PSScriptRoot` was unavailable in a PowerShell parameter default
- Symptom: Running `scripts/skill-enforcement.ps1` without `-RepoRoot` failed before validation with an empty `Join-Path` argument.
- Root cause: Windows PowerShell evaluated the parameter default before `$PSScriptRoot` was reliably available.
- Correction: Resolve the default repository root after parameter binding instead of inside the parameter declaration.
- Prevention: Cover the documented no-`-RepoRoot` invocation path in the script's regression test.
- Verification: `validate-project-usage` succeeds against the fixture when invoked without `-RepoRoot`.
## 2026-08-11 - Direct HTTP anti-bot response was treated as page inaccessibility
- Symptom: A public-page collection task initially stopped after a direct HTTP request returned a site verification page.
- Root cause: The execution path treated a transport-level response as conclusive and did not immediately use the available real-browser rendering path.
- Correction: Opened the page in a browser session and used an accessibility snapshot to verify the rendered article and extract the requested links.
- Prevention: For public web-content tasks, when rendered-page evidence is required and a browser tool is available, attempt a normal browser snapshot before declaring the content inaccessible. Do not bypass CAPTCHA, authentication, or other access controls.
- Verification: The browser snapshot exposed the article title, content sections, and external resource links while no resource downloads were performed.

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

## 2026-08-23 – UTF-8 BOM invalidated a JSON contract
- Symptom: `node scripts/check-logic-entry.js` could not parse `manifest.json` after a PowerShell edit.
- Root cause: Windows PowerShell `Set-Content -Encoding utf8` added a BOM that Node's JSON parser did not accept.
- Correction: Rewrote generated/edited JSON contracts with an explicit BOM-free UTF-8 encoding.
- Prevention: For JSON consumed by Node, use `[System.IO.File]::WriteAllText(..., [System.Text.UTF8Encoding]::new($false))` and run the entry checker immediately.
- Verification: `node scripts/check-logic-entry.js` passed after the rewrite.
