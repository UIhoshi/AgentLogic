# Shipping Review — V6.8.3 Skills, Tools, and Reference Routing

## Scope

Adds Modules 47 and 48, registers them in enhanced profiles, and promotes the stable line to
V6.8.3. No external skill, executable dependency, browser tool, or host configuration was
installed or enabled.

## Reviewability and Self-Refutation

- **Finding:** The workflow could accidentally imply external tools are trusted.
  - Evidence: Module 47 explicitly requires the Module 35/44 trust path and user consent before
    any state-changing installation.
  - Counter-argument checked: merely citing MengTo/Skills might still be read as an import.
  - Resolution: the module and version source state that no external code, scripts, assets, or
    runtime dependencies are imported. **Status: verified by targeted read.**
- **Finding:** A router could weaken the existing verification matrix.
  - Evidence: Module 48 requires selecting evidence first and explicitly preserves Modules 29–31
    as authoritative.
  - Counter-argument checked: a quick matrix might permit skill-first closure.
  - Resolution: the mandatory procedure requires post-result verification and downgrade labels.
    **Status: verified by targeted read.**

## Validation

- `node scripts/check-logic-entry.js` — passed.
- `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1` — passed.
- `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1` — passed.
- All default host bundles rebuilt from `scripts/build-profile.ps1`.
