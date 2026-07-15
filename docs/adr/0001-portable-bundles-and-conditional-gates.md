# ADR-0001: Portable Bundles and Conditional Governance Gates

- **Status:** Accepted
- **Date:** 2026-07-15

## Context

AgentLogic is a portable logic package, but generated bundles previously resolved repository
placeholders to absolute paths from the build machine. At the same time, SDD, SRA, visual design,
glossary, skill, security, and performance steps were described as universal even when a task did
not exercise those capabilities.

## Decision

1. Generated bundles remain deterministic and preserve repository-relative placeholders. They must
   not contain machine-specific absolute file URIs.
2. The task-applicability gate selects the smallest workflow that still matches the risk and
   capability of the task. Full SDD and SRA remain mandatory for the task classes that require them.
3. Host installation verifies the new target before moving legacy files into a timestamped backup.

## Consequences

- Bundles are portable across machines, but source links inside a single-file bundle are descriptive
  placeholders rather than machine-local clickable links.
- Small audits and documentation fixes avoid irrelevant architecture and business-reporting work.
- Feature, trust-boundary, packaging, and release changes retain the full evidence and review gates.
- Historical version files are not rewritten; active documentation and generated outputs must be rebuilt
  from the current manifest.
