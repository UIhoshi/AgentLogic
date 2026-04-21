# Host Adapters

These adapters are the installation layer for pulling AgentLogic into local AI hosts as the primary logic.

For first-time local installation, start at the repository root:

- AI agents: `AGENT_INSTALL.md`
- Humans: `INSTALL.md`
- Diagnostic command: `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1`

Goals:

- build a stable bundle from `manifest.json`
- place that bundle in a host-ready location
- keep the host bound to a stable entry instead of a versioned file name

Current adapters:

- `codex/`
  - writes a built bundle to the Codex instructions path
  - updates `~/.codex/config.toml` to point at the built bundle
- `claude/`
  - writes a host-ready `CLAUDE.md` bundle
  - supports explicit `-TargetPath` for the user's preferred Claude entrypoint
- `gemini/`
  - writes a host-ready `GEMINI.md` bundle
  - supports explicit `-TargetPath` for the user's preferred Gemini entrypoint
- `generic/`
  - writes a host-neutral bundle for any other local AI shell

The adapters are intentionally conservative:

- they automate the parts that are stable
- they avoid guessing opaque private host internals when those are not guaranteed
