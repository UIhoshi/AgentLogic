# Reviewed Software Candidates

Status: **review-required; not approved for automatic installation.**

Use this directory when a user asks what tooling is missing. Report only candidates relevant to the
active project. Before installation, jointly choose an exact release/commit, verify publisher,
license, checksum/signature, dependencies, permissions, and run the skill/security audit where a
skill or GitHub repository is involved.

| Need trigger | Candidate | Source class | Pre-install decision requirement |
| --- | --- | --- | --- |
| Infrastructure as code | OpenTofu | Official project / `opentofu/opentofu` | Pin release; confirm cloud/provider scope and MPL-2.0 compatibility. |
| Kubernetes cluster operation | kubectl | Kubernetes official distribution | Match client within one minor version of the target cluster; do not install by default. |
| PostgreSQL project or remote database debugging | PostgreSQL `psql` client | PostgreSQL download channel; Windows installer is EDB-hosted | Confirm client-only scope, supplier, version, and connection/credential handling. |
| Video, audio, recording, or media conversion | FFmpeg | FFmpeg source; Windows binaries are third-party builds | Prefer source/officially linked build source; pin binary, verify checksum, review licensing/codecs. |
| Go application or Go-based tooling | Go | Official Go distribution / `golang/go` | Pin toolchain version and confirm a Go build/test need. |
| Browser UI automation | Playwright | Microsoft official project | Prefer the existing skill wrapper first; pin package/browser versions before persistent install. |
| Agent-specific browser automation | agent-browser | `vercel-labs/agent-browser` candidate | Audit pinned checkout for network, background service, cloud-provider, and credential behavior before any install. |
| Interactive stakeholder handover artifact | Bento | `nyblnet/bento` candidate | Pin a release/commit; audit any plugin/download behavior; use only for an explicitly requested target-project artifact. |
| Visual PDF/page/chart retrieval | PixelRAG | `StarTrail-org/PixelRAG` candidate | Pin source and audit CLI/model/plugin behavior, local-vs-hosted data flow, and browser patch effects before installation. |
| Broad public-web collection | Firecrawl | `firecrawl/firecrawl` candidate | Confirm AGPL-3.0 implications, hosted/self-hosted data boundary, URL scope, credentials, and interaction side effects before install or API use. |
| Containers/local dependency services | Docker Desktop or an approved open-source alternative | Vendor/open-source candidate | Confirm licensing, WSL/virtualization impact, and organization policy before install. |

Never interpret a listed candidate as trusted, installed, or permitted.
