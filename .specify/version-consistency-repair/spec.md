# V6.8.1 Version Consistency and Bundle Verification

## Status

Approved for implementation by the user after the V6.8.1 repository audit.

## Problem

The manifest declares V6.8.1, but active installation guidance and the master-logic
title still report V6.8.0. The package validator applies V6.8 operational-contract
checks only when the version equals V6.8.0, and it does not prove that tracked host
bundles match their source profile.

## Requirements

1. Active installation guidance, master-logic metadata, and the current V6.8.1 source
   must identify the active version consistently as V6.8.1.
2. V6.8 operational-contract checks must apply to every V6.8 patch release.
3. `build-profile.ps1` must provide a non-mutating verification path for an existing
   generated output.
4. `validate-package.ps1` must verify every configured host bundle against the default
   profile without changing tracked files.
5. Tracked `dist/` bundles must be regenerated from current sources and committed.

## Non-goals

- Renaming historical V6.8.0 specifications or the V6.8.0 integration module.
- Changing host installation targets, permissions, or profile contents.
- Pushing the resulting commit to a remote repository.

## Acceptance Criteria

- `AGENT_INSTALL.md`, `modules/01_MasterLogic.md`, and
  `versions/AgentLogic_V6_8_1.md` have no accidental active V6.8.0 version claim.
- The validator checks the V6.8 operational module for V6.8.1.
- Mutating a generated bundle would make package validation fail; an untouched bundle
  passes verification.
- Rebuilt `dist/` files are clean immediately after package and maintainer checks.

