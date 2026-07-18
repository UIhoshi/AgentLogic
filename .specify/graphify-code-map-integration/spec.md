# Graphify Code Map and Graph Preview Gate

## Status

Approved by the user for implementation.

## Problem

AgentLogic has a static repository system map but no optional, queryable code-graph
workflow for complex target projects. Users also need an explicit choice to generate a
visual code view near the end of substantial work, rather than an automatic and
potentially unwanted graph build.

## Requirements

1. Add Graphify as an optional external code-map integration in V6.8.1.
2. Add a Graph Preview Gate at Converge/Ship for eligible multi-module features,
   major refactors, architecture work, and release work.
3. The gate must ask once per eligible task whether to generate a code-view preview;
   it must never generate or install Graphify automatically.
4. Keep `graph.html` and other `graphify-out/` artifacts in the target project as
   external, on-demand outputs; do not place them in AgentLogic bundles by default.
5. Require an external-skill security audit and explicit installation intent before
   executing Graphify installation commands or allowing it to modify host instructions/hooks.
6. Preserve normal evidence rules: graph findings guide discovery but do not replace
   targeted source reads, runtime checks, visual checks, or shipping validation.

## Non-goals

- Installing Graphify locally or in any project.
- Bundling Graphify code, dependencies, or generated visual assets into AgentLogic.
- Generating a graph for AgentLogic during this rule-only integration.

## Acceptance Criteria

- `core-enhanced` and `github-publishing` profiles include the new integration module.
- Active version and README reference Graphify with its source URL.
- The module defines trigger, consent, privacy, trust, output, and verification rules.
- Package, entry, and maintainer validation pass after regenerated bundles.

