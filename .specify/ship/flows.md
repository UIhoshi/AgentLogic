# Flows

## Maintainer validation flow

1. `check-logic-entry.js` checks repository and operational entry headers, active-version
   references, path hygiene, startup order, and map anchors.
2. `maintainer-check.ps1` builds all four host bundles from `manifest.json`.
3. `validate-package.ps1` checks manifest structure, current version headers, stale references,
   and machine-specific absolute URIs in every tracked output.

Trust boundary: repository -> generated artifact. The generated artifact must be deterministic and
must not encode the build machine path.

## UI implementation flow

1. Classify the task as formal UI implementation.
2. Generate a text-to-image preview and show it to the user.
3. Wait for user approval or an explicit user opt-out.
4. Only then implement UI code and run screenshot/layout-boundary verification.

## Host installation flow

1. `install.ps1` validates the repository logic entry and package before host mutation.
2. The selected adapter builds the target bundle and runs a dry-run host-local skill inventory.
3. The root installer verifies the expected target files exist.
4. Other legacy files are moved into a timestamped `.agentlogic-backup` directory; the selected
   target is protected.

Trust boundary: repository -> host configuration. Failure before target verification leaves legacy
files unchanged.
