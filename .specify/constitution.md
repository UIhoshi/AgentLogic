# AgentLogic Constitution

## Purpose

AgentLogic is portable local AI-host logic infrastructure. Changes must preserve a
single source of truth in `manifest.json`, generated host bundles, and auditable
installation and validation behavior.

## Governing Principles

1. `manifest.json` is the machine-readable source of truth for the active version,
   profiles, adapters, and host outputs.
2. Active entry and installation documents must agree with the manifest's current
   version; historical version references remain historical only.
3. Generated files under `dist/` are produced only by `scripts/build-profile.ps1`.
   Validation must detect drift without mutating tracked outputs.
4. Validation changes must be provider-neutral, deterministic, and fail with useful
   diagnostics before host installation changes local configuration.
5. All shipped claims require matching local evidence; release-facing changes require
   an SDD record and a concise shipping audit.

