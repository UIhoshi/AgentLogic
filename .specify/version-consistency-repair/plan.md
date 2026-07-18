# Implementation Plan: Version Consistency and Bundle Verification

## Scope

This is a release/packaging logic change. It updates active documentation, adds a
read-only generated-bundle verification mode, extends package validation, regenerates
the four tracked host bundles, and records a concise shipping review.

## Implementation

1. Correct active V6.8.1 labels while preserving historical V6.8.0 artifacts.
2. Add `-Verify` to `build-profile.ps1`; it builds the profile in memory and compares
   it with the configured output rather than writing it.
3. Normalize generated bundle text to LF and read manifest/profile source files as UTF-8
   before writing or comparing it, so build output is deterministic across Windows and CI
   checkout environments.
4. Make `validate-package.ps1` apply V6.8 contract checks to `V6.8.*` and invoke the
   non-mutating verification for every configured host output.
5. Regenerate the tracked bundles once using the existing generator.
6. Run package, logic-entry, and maintainer checks; confirm a clean diff; create a
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
- Mitigation: normalize the complete generated text to LF, decode all source inputs as UTF-8,
  write UTF-8 without a BOM, and test the regenerated tracked outputs through package validation.

### Claim: Local validation proves CI will compare the same bytes

- Steelman: both environments run PowerShell and invoke the same generator.
- Attack: `StringBuilder.AppendLine()` uses the host newline, while Git checkout rules can
  present committed files with a different newline convention.
- Fails if: a Windows runner regenerates CRLF text against an LF checkout and reports a
  stale bundle even after a successful local validation.
- Mitigation: canonicalize generated text to LF, explicitly decode inputs as UTF-8 before
  both write and verification, then regenerate the tracked outputs.

### Claim: Regenerating tracked bundles is safe

- Steelman: `dist/` is explicitly generated from the current source.
- Attack: bundles could include host-local paths or unstaged unrelated inputs.
- Fails if: generated output differs by host-specific machine state.
- Mitigation: inspect the diff, run the package absolute-path guard, and commit only the
  four configured outputs plus bounded source and SDD changes.
