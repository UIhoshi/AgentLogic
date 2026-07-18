# V6.8 Graphify Code Map and Graph Preview Gate

Status: **Optional external code-map integration, active in enhanced profiles**.

This module integrates the Graphify method as an on-demand project fact-mapping and
reviewability capability. It ships policy only: Graphify itself, its dependencies, and
its generated artifacts remain external to AgentLogic.

## 1. Purpose

Graphify can build a queryable graph from a target project and export:

- `graphify-out/graph.html`: an interactive, user-visible code-view preview;
- `graphify-out/GRAPH_REPORT.md`: architecture highlights and suggested questions;
- `graphify-out/graph.json`: reusable graph data for scoped queries.

Use it to accelerate discovery of entry points, cross-module paths, subsystem clusters,
and high-connectivity concepts in substantial projects. It complements the Project Fact
mandatory textual `CODE_MAP.md`, the Project Fact Map, and repository system map; it does not replace them.

Source: `https://github.com/Graphify-Labs/graphify` (v8 reference line).

## 2. Evidence Boundary

Graph output is **discovery evidence**, not final behavioral proof.

- `EXTRACTED` edges can guide targeted source reads.
- `INFERRED` and `AMBIGUOUS` edges require especially careful confirmation.
- Runtime, permissions, visual behavior, current remote state, and packaging conclusions
  remain governed by `modules/29_MandatoryVerificationMatrix.md`.
- The graph must not be treated as proof that dynamic calls, feature flags, authorization,
  generated code, or UI behavior actually execute.

## 3. Graph Preview Gate

At **Converge or Ship**, ask the user once whether they want a code-view preview when the
current task is any of the following:

- a multi-module feature or refactor;
- architecture or dependency-boundary work;
- release/packaging work with meaningful code or infrastructure surface;
- an explicit request for code maps, graph exploration, or visual architecture review.

Default question:

> This task now has enough structure for a code-map preview. Would you like me to generate
> an interactive Graphify view for the target project?

Do **not** ask or generate by default for trivial isolated fixes, documentation-only work,
metadata-only work, or a project that already has a current graph for the same reviewed
commit. A user can request the graph at any time, which overrides the phase trigger.

The gate is a consent checkpoint:

- user approval permits a bounded graph-generation plan;
- declining records no failure and continues normal handover;
- approval does not authorize installation, host-hook changes, uploads, or generated-artifact
  commits beyond the separately confirmed scope.

## 4. Installation and Trust Boundary

Before installing or trusting Graphify, use the host's external-skill security-audit path
when available, as required by `modules/35_V6_5_SkillGovernanceAndMandatoryUse.md`.

Graphify installation is state-changing because it can add assistant instructions and hooks.
Therefore, before any command such as `uv tool install graphifyy` or
`graphify install --platform codex`:

1. confirm the exact target host/project and whether installation is global or project-scoped;
2. inspect the external skill/package and its installation effects;
3. obtain explicit user intent for the installation;
4. inspect the resulting host/project changes afterward.

This module does not imply that Graphify is installed, approved, or available on the host.

## 5. Data and Output Boundary

- Run Graphify only against the intended **business project**, never against AgentLogic by
  default and never against unrelated workspace folders.
- Keep `graphify-out/` in the target project. Do not add it to AgentLogic profiles or bundles.
- Treat `graph.html` as an external visual artifact; show or link it only after it exists.
- Code AST analysis is described by Graphify as local-first, but document/media semantic
  processing and URL ingestion can use configured model/API or network paths. Confirm the
  selected mode and data boundary before generation.
- Do not commit graph artifacts unless the user explicitly asks and the target project's
  repository policy allows them. By default, record durable, verified graph conclusions in
  `PROJECT_MAP.md` and keep `graphify-out/` out of the tracked project-knowledge surface.

## 6. Recommended Workflow After Consent

1. Confirm target repository, current commit, graph scope, and privacy mode.
2. Build or refresh the target project's graph using the reviewed installation.
3. Inspect `GRAPH_REPORT.md` and use scoped graph queries to identify candidate paths.
4. Verify important graph findings with targeted source reads and the matching runtime or
   visual evidence tools.
5. Present `graph.html` as the optional code-view preview and record whether it reflects the
   reviewed commit.

## 7. Relationship to Existing Gates

- The UI Preview Gate creates a proposed UI design **before** formal UI code.
- The Graph Preview Gate offers a codebase visualization **after** substantial implementation
  has converged or while shipping.
- The Graph Preview Gate is opt-in and does not replace SDD, Red-Team, SRA, or the Mandatory
  Verification Matrix.
