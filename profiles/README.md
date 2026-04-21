# Profiles

Profiles define which files are bundled into a host-ready primary-logic output.

For first-time local installation, read `AGENT_INSTALL.md` or `INSTALL.md` from the repository root before choosing a profile.

The source of truth for profile membership is `manifest.json`.

Current profiles:

- `minimal`
- `core-enhanced`
- `github-publishing`

Build bundles with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-profile.ps1 -ProfileName core-enhanced -TargetHost codex
```
