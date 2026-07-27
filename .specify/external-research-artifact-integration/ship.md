# Shipping Review Record — External Research and Artifact Integration

## Scope

Policy-only integration of Bento, PixelRAG, and Firecrawl. No executable dependency, plugin,
service, credential, external installation, or remote state was changed.

## Reviewable changes

- Module 50 owns the source-specific policies and their opt-in, privacy, licensing, and
  verification boundaries.
- Modules 47 and 48 link only to the policy decision points.
- The active profile, version source, repository maps, candidate queue, and generated host
  bundles include the new module.

## Self-refuted findings

| Initial risk | Counter-check | Status |
| --- | --- | --- |
| A named source could be mistaken for an installed capability | Module 50, Module 48, and the version source explicitly state policy-only/non-import rules | Cleared |
| PixelRAG could weaken final visual verification | Module 50 limits it to discovery and directs closure to Module 29; Module 47 repeats this boundary | Cleared |
| Firecrawl interaction could bypass side-effect controls | Module 50 classifies interaction as permission-sensitive and requires target/post-result confirmation | Cleared |
| Generated bundle could omit the new policy | All four bundles were rebuilt and package validation verified their exact profile content | Cleared |

## Validation evidence

- `node scripts/check-logic-entry.js` — passed; 28 active links and 14 external references in
  both README surfaces verified.
- `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1` — passed.
- `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1` — passed.

## Residual constraints

The three external capabilities remain uninstalled and untrusted. A future use or installation
requires a pinned revision, external security audit, explicit user consent, and task-scoped
verification under the new policy.
