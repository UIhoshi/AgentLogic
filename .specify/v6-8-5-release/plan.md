# Plan — V6.8.5 Release Promotion

## Approach

1. Copy the V6.8.4 stable source to V6.8.5, revise its active title/status/mandate, and retain the
   old file unchanged as history.
2. Switch manifest/profile and entry-document pointers, then update current-version labels in
   installation and map surfaces.
3. Regenerate all `dist/` bundles exclusively through `scripts/build-profile.ps1` and run the
   normal release validation chain.

## Load-Bearing Assumptions / Red-Team Results

| Assumption | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| Copy-forward preserves the complete stable policy | V6.8.5 is a patch promotion of the completed V6.8.4 work | A current policy is lost or V6.8.4 is accidentally edited | Copy then inspect source diff; preserve the old file unchanged. |
| All active pointers can be distinguished from history | Entry and install documents name the current source while old specs record past work | Broad replacement rewrites historical evidence | Limit replacements to known active files; use targeted search before validation. |
| Rebuilt bundles faithfully represent the promoted source | The manifest drives generation and package validation compares generated output | One host retains V6.8.4 or bundle drift occurs | Rebuild all hosts and run maintainer check, which verifies every default bundle. |

## Design Decision

Use a patch promotion to V6.8.5, with no change to host targets, permissions, installation state,
or external-extension trust.
