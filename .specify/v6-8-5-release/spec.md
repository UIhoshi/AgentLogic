# V6.8.5 Release Promotion

## Goal

Promote the completed optional img2threejs interactive-3D-web policy to AgentLogic V6.8.5 while
preserving V6.8.4 as historical source material.

## Requirements

1. Create `versions/AgentLogic_V6_8_5.md` as the active stable source, carrying V6.8.4 content
   forward and recording the img2threejs policy as the V6.8.5 promotion.
2. Update every active entrypoint, manifest pointer, current-version label, installation guide,
   system map, and code map to V6.8.5 without rewriting historical records.
3. Update profile file lists to consume only the V6.8.5 stable source, then rebuild all generated
   host bundles using the existing generator.
4. Preserve the policy-only/non-install status of img2threejs and do not push or publish a release.

## Acceptance Criteria

- `manifest.json` declares `V6.8.5` and `versions/AgentLogic_V6_8_5.md`.
- Every active document points to V6.8.5; V6.8.4 references remain only in historical sources or
  historical SDD records.
- Generated bundle headers report V6.8.5 and include the new stable source.
- Entry, package, and maintainer checks pass after regeneration.
