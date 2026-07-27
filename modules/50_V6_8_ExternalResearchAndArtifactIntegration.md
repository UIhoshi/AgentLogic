# V6.8 External Research and Artifact Integration

Status: **Optional external-source policy, active in enhanced profiles.**

This module records policy patterns reviewed from Bento, PixelRAG, and Firecrawl. It imports no
source code, plugin, skill, service, binary, model, API key, or automatic installation path.
Discovery of any of those capabilities is not approval, trust, availability, or verification.

## 1. Shared operating boundary

Before using a source-specific capability, classify its intended role: a stakeholder artifact,
visual-document discovery, or external web collection. Then confirm the smallest acceptable
scope, the applicable permission posture, data destination, provenance, and matching evidence
path. Modules 29–31 remain authoritative for verification strength; Modules 35 and 44 govern
external-extension trust.

- Pin a reviewed release or commit before an installation, integration, or template adoption.
- Run the external skill/plugin security-audit route before trusting executable instructions.
- Obtain explicit user intent before an installation, a hosted service request, a credential use,
  or a side-effecting browser action.
- Keep credentials in approved secret storage or environment variables only. Do not record them
  in a bundle, map, specification, generated artifact, or repository file.
- Never represent an optional source as present on a host merely because this policy names it.

## 2. Bento — optional single-file stakeholder artifact

Source: `https://github.com/nyblnet/bento` (MIT). Bento's self-contained `.bento.html` format
can carry presentation content and its viewer/editor together. AgentLogic may use that idea only
as an optional delivery format for a user-requested proposal, handover, or architecture briefing.

### Allowed path

1. Confirm that an interactive single-file presentation is wanted instead of Markdown, PDF, or
   slides already supported by the project.
2. Review and pin the source/version and any document-format instructions.
3. Generate only approved, non-sensitive content into a target-project artifact.
4. Open or render the artifact and inspect it before handover.

### Non-goals and restrictions

- Do not install Bento's host plugin, download an application, or add marketplace sources by
  default; a plugin path that downloads software requires separate explicit consent and audit.
- Do not add Bento runtime code or generated stakeholder artifacts to AgentLogic bundles.
- Do not use it as a substitute for project documentation, SRA evidence, or source verification.

## 3. PixelRAG — optional visual-document discovery accelerator

Source: `https://github.com/StarTrail-org/PixelRAG` (Apache-2.0). PixelRAG's approach renders
pages, PDFs, and images into screenshot tiles and retrieves visual structure. Use it only when
permitted source material depends on tables, charts, diagrams, infographic layout, or PDF/page
composition that text extraction would materially lose.

### Allowed path

1. Confirm ownership/permission for the source URL or file and whether rendering leaves the
   device or calls a hosted index.
2. Prefer a supplied local file or the narrowest approved public URL set.
3. Use visual retrieval to locate candidate evidence or produce a constrained reference brief.
4. Verify any consequential finding with targeted reads, browser/runtime evidence, or an actual
   screenshot as required by Module 29.

### Non-goals and restrictions

- It does not replace Playwright/agent-browser for dynamic browser-flow observation.
- It does not replace screenshot evidence for a UI-visible claim or user approval of a mockup.
- Do not install its CLI, model, browser patches, or plugin without a reviewed, pinned source and
  explicit user approval.

## 4. Firecrawl — optional external web-collection path

Source: `https://github.com/firecrawl/firecrawl` (AGPL-3.0). Firecrawl can search, scrape, map,
crawl, batch-extract, and interact with public web pages. It is suitable only for a user-approved,
bounded collection task where ordinary official-source lookup or a narrow browser path is
insufficient.

### Allowed path

1. Record the purpose, allowed domains/URLs, page or depth limit, requested output fields, and
   whether self-hosted or hosted processing is proposed.
2. Obtain explicit consent for hosted processing and any data egress; do not send private,
   authenticated, paywalled, or credential-bearing content by default.
3. Use read-oriented search/scrape/map/crawl operations first and retain source URLs/provenance.
4. Treat click, scroll, write, wait, press, login, submission, or prompt-driven interaction as a
   permission-sensitive side effect. Confirm the exact target and post-result state before use.
5. Store API credentials only in approved secrets/environment configuration and inspect results
   for accidental sensitive-data capture.

### Non-goals and restrictions

- Do not copy AGPL-licensed source or SDK code into AgentLogic bundles.
- Firecrawl is not the default browser verification tool and does not prove visible UI behavior.
- Self-hosting, persistent installation, proxy configuration, and MCP/plugin enablement are
  separate high-risk deployment tasks requiring their own specification and audit.

## 5. Selection guide

| Need | First choice | Optional source path | Required closure |
| --- | --- | --- | --- |
| Stakeholder-ready portable briefing | Existing project format | Bento artifact when explicitly requested | Open/render the final artifact; retain normal documentation and SRA evidence. |
| Visual PDF/page/table/chart analysis | Supplied file plus approved visual capture | PixelRAG when visual retrieval is justified | Confirm conclusions with matching source, runtime, or screenshot evidence. |
| Broad public website discovery or structured collection | Official sources and narrow lookup | Firecrawl after scope/data-egress approval | Preserve provenance and meet the evidence requirements for the claim. |
| Dynamic browser flow or final visible UI proof | Playwright / screenshot route | None by default | Fresh browser observation or screenshot with layout-boundary check. |

## 6. Registered comparison sources

- Bento: `https://github.com/nyblnet/bento`; reviewed 2026-07-28; policy-only artifact pattern.
- PixelRAG: `https://github.com/StarTrail-org/PixelRAG`; reviewed 2026-07-28; policy-only
  visual-document discovery pattern.
- Firecrawl: `https://github.com/firecrawl/firecrawl`; reviewed 2026-07-28; policy-only
  consent-bound external collection pattern.
