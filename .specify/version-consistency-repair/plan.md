# Implementation Plan: Version Consistency and Bundle Verification

## Scope

This is a release/packaging logic change. It updates active documentation, adds a
read-only generated-bundle verification mode, extends package validation, regenerates
the four tracked host bundles, and records a concise shipping review.

## Implementation

1. Correct active V6.8.1 labels while preserving historical V6.8.0 artifacts.
2. Add `-Verify` to `build-profile.ps1`; it builds the profile in memory and compares
   it with the configured output rather than writing it.
3. Make `validate-package.ps1` apply V6.8 contract checks to `V6.8.*` and invoke the
   non-mutating verification for every configured host output.
4. Regenerate the tracked bundles once using the existing generator.
5. Run package, logic-entry, and maintainer checks; confirm a clean diff; create a
   local commit.

## Red-Team Results

### Claim: A V6.8 prefix check preserves future validation coverage

- Steelman: all V6.8 patch releases retain the operational integration introduced in
  V6.8.0.
- Attack: a future V6.8 patch could intentionally remove the integration.
- Fails if: the integration is removed deliberately but the prefix check still makes it
  mandatory.
- Mitigation: this repair is scoped to the declared V6.8.1 line, whose default profile
  already includes Module 44; a deliberate removal must change the release contract and
  validation in the same change.

### Claim: In-memory comparison detects meaningful bundle drift

- Steelman: the generator deterministically assembles content from the manifest profile.
- Attack: encoding or newline behavior could make a semantically valid output differ.
- Fails if: the generator writes a different encoding from the verifier's expected text.
- Mitigation: use the same `Build-Bundle` result and UTF-8 no-BOM write convention; test
  the regenerated tracked outputs through package validation.

### Claim: Regenerating tracked bundles is safe

- Steelman: `dist/` is explicitly generated from the current source.
- Attack: bundles could include host-local paths or unstaged unrelated inputs.
- Fails if: generated output differs by host-specific machine state.
- Mitigation: inspect the diff, run the package absolute-path guard, and commit only the
  four configured outputs plus bounded source and SDD changes.

