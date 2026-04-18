# Profiles

Profiles define which files are bundled into a host-ready primary-logic output.

The source of truth for profile membership is `manifest.json`.

Current profiles:

- `minimal`
- `core-enhanced`
- `github-publishing`

Build bundles with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-profile.ps1 -ProfileName core-enhanced -TargetHost codex
```
