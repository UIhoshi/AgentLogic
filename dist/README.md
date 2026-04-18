# Dist

This directory is reserved for generated host-ready bundles.

Do not treat files in `dist/` as the source of truth.

Generate bundles with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-profile.ps1 -ProfileName core-enhanced -TargetHost generic
```

Typical outputs:

- `dist/codex/model_instructions.md`
- `dist/claude/CLAUDE.md`
- `dist/gemini/GEMINI.md`
- `dist/generic/AGENTLOGIC.md`
