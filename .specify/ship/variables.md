# Variables and Secrets

## Repository variables

- `manifest.json.current_version`: stable package version (`V6.8.0`).
- `manifest.json.default_profile`: default profile (`core-enhanced`).
- `manifest.json.host_outputs`: tracked generated bundle locations.
- `ProfileName`: selected manifest profile, default `core-enhanced`.
- `TargetHost`: one of `codex`, `claude`, `antigravity`, or `generic`.
- `TargetPath`: optional explicit installation target.
- `UserHome`: host user root used by adapters.
- `ModificationHistoryPath`: optional explicit local path for the sibling `modification_history`
  repository; default is the current project's parent directory plus `modification_history`.

## Secrets

The remediation adds no credentials, tokens, or third-party secrets. Host configuration paths are
treated as sensitive target locations and are confirmed by post-install existence checks.
