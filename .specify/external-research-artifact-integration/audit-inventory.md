# External Source Audit Inventory — Partial / Not Trusted

## Scope and status

Read-only clones were made outside the AgentLogic repository on 2026-07-28. No repository code,
plugin, model, service, package, browser, credential, or container was installed or executed.
The required `skill-security-auditor` capability is unavailable on this host, so this is an
inventory for a later extension-trust audit, **not** a verified security audit or trust decision.

| Source | Audited revision | Declared license | Initial posture |
| --- | --- | --- | --- |
| Bento | `43d1168f39fad75094f16b76434330715f813bd4` | MIT | Do not install its plugin or fetch its runtime automatically. |
| PixelRAG | `7a3c3041bd37b1868d8573039ebdc60607ddb936` | Apache-2.0 | Do not install its CLI, plugin, models, or browser dependencies. |
| Firecrawl | `35d9146f93d8fe59cebe68bbbe18b5a523a0073a` | AGPL-3.0 | Do not self-host, use its API, or enable its skills/MCP path. |

## Static inventory findings

### Bento

- The `bento-slides` skill explicitly directs an agent to download a current Bento HTML runtime
  and fetch further online instructions when starting from a new deck.
- Its repository contains plugin/skill, Node build, release, and publishing surfaces.
- Integration remains limited to the policy for a user-requested artifact format. Any use needs a
  pinned release, content/data review, and artifact rendering inspection.

### PixelRAG

- The plugin setup script installs the local package into a `uv` tool environment and attempts to
  install Chromium; its skill also tells the host to install `pixelrag` if `pixelshot` is missing.
- The Python package declares rendering dependencies in the core and optional heavy ML, FAISS,
  server, GPU, Playwright, document, distributed, and evaluation dependency groups.
- Its indexing and evaluation surfaces use subprocesses and can invoke external programs or
  networked resources. It remains discovery-only policy, not an approved browser-proof tool.

### Firecrawl

- The repository includes API, crawler, browser service, CLI/skill pointers, container build, and
  multi-service compose surfaces; its API package has a `prepare` hook and runtime harness process
  spawning.
- The compose configuration accepts provider, proxy, webhook, database, queue, and browser
  settings, and publishes an API port. It must be treated as a deployment and data-egress surface.
- The root project license is AGPL-3.0; copying source or SDK implementation into AgentLogic is
  prohibited by the current policy.

## Required next audit steps

1. Make the first-party `skill-security-auditor` capability available, then audit the pinned
   revisions above for dependency scripts, network endpoints, credential handling, prompts, host
   modifications, and declared permissions.
2. Independently verify release provenance/checksums before any package, plugin, CLI, model, or
   container installation.
3. For Firecrawl, decide hosted versus self-hosted processing, approved domains, data egress,
   retention, authentication, and side-effect policy before any API call.
4. For Bento and PixelRAG, inspect the exact selected plugin/skill revision rather than trusting
   repository-level documentation.

## Trust decision

**Untrusted / not approved for installation or activation.**
