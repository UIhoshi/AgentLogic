# V6.8 External Research and Artifact Integration

Status: **Optional external-source policy, active in enhanced profiles.**

This module records policy patterns reviewed from OfficeCLI, PixelRAG, and Firecrawl. It imports no
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

## 2. OfficeCLI — mandatory route for requested Office-file processing

Source: `https://github.com/iOfficeAI/OfficeCLI` (Apache-2.0). OfficeCLI is an optional
external executable, not an installed AgentLogic skill or runtime. When a user requests that the
agent read, inspect, create, edit, repair, or verify a Microsoft Office file (`.docx`, `.xlsx`,
or `.pptx`), the agent must use OfficeCLI as the document-processing route. Generic ZIP/XML
editing, static text extraction, or a hand-written replacement script must not be presented as an
equivalent route.

### Availability, trust, and install boundary

- If OfficeCLI is not installed, trusted, and permitted in the current target project or host, do
  not mutate the Office file and do not claim a verified Office-file result. State the missing
  capability and request the separate installation decision.
- Installation requires explicit user consent, a pinned release or commit, publisher/license and
  checksum or signature verification, and the external skill/plugin security-audit route. Do not
  execute `curl | bash`, `irm | iex`, or any installer behavior that automatically deploys skills
  into detected AI hosts.
- Disable or explicitly approve automatic update checks before use. An Office document may contain
  sensitive material; do not upload it, enable hosted processing, or record its contents in project
  knowledge without separate authorization.

### Required processing and verification path

1. Confirm the exact input file, output path, requested operation, and whether the output must
   remain editable in Microsoft Office.
2. Preserve an untouched source copy or verified backup. Use OfficeCLI's outline/structured JSON
   inspection to establish the relevant document, worksheet, slide, element, formula, or style
   boundary before editing.
3. Prefer bounded, atomic batches. `--best-effort` or partial-success behavior requires explicit
   user approval because it can leave a document only partly changed.
4. Flush and close the document before another program, delivery channel, or renderer consumes it.
5. For visible Word, Excel, or PowerPoint claims, render the changed output to HTML or PNG and
   inspect the actual pages/sheets/slides for containment, clipping, pagination, formula/chart
   presentation, and layout regressions. When the target Office application is available, perform
   the compatible-open check as a second evidence path.
6. Record the exact OfficeCLI version, executed commands, changed paths, and remaining rendering or
   compatibility gaps. A successful command or JSON response alone is not visual proof.

### Non-goals and restrictions

- This route does not make OfficeCLI a default tool for Markdown, PDF, or ordinary webpage work.
- It does not guarantee lossless repair of macros, embedded objects, proprietary features, or
  malformed Office files. Report unsupported features and preserve the source file.
- OfficeCLI's browser HTML output is a render/preview path; it is not evidence that a generated
  `.pptx` is a browser-native editable presentation.

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
| User-requested `.docx`, `.xlsx`, or `.pptx` processing | Trusted OfficeCLI route | OfficeCLI only after the availability/trust gate above | Structured inspection, bounded mutation, flushed output, and matching render/compatible-open evidence. |
| Visual PDF/page/table/chart analysis | Supplied file plus approved visual capture | PixelRAG when visual retrieval is justified | Confirm conclusions with matching source, runtime, or screenshot evidence. |
| Broad public website discovery or structured collection | Official sources and narrow lookup | Firecrawl after scope/data-egress approval | Preserve provenance and meet the evidence requirements for the claim. |
| Dynamic browser flow or final visible UI proof | Playwright / screenshot route | None by default | Fresh browser observation or screenshot with layout-boundary check. |

## 6. Registered comparison sources

- OfficeCLI: `https://github.com/iOfficeAI/OfficeCLI`; reviewed 2026-08-16; release
  `v1.0.144`; policy-only Office-document processing route, no binary, skill, plugin, or runtime
  installed.
- PixelRAG: `https://github.com/StarTrail-org/PixelRAG`; reviewed 2026-07-28; policy-only
  visual-document discovery pattern.
- Firecrawl: `https://github.com/firecrawl/firecrawl`; reviewed 2026-07-28; policy-only
  consent-bound external collection pattern.
