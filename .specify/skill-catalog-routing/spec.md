# Specification — Guided Selection for the Portable Skill Catalog

## Goal

Make every portable skill understandable and selectable through the same layered model:
explicit user intent first, bounded inference second, one confirmation question when a material
choice remains ambiguous, and manual-only handling for restricted capabilities.

## Requirements

1. Every registry record has a concise purpose, explicit signals, inferred signals, a confirmation
   policy, and a selection posture.
2. Selection postures are: `route_candidate` (already route-enforced), `guided_candidate`
   (suggest/select only through the catalog policy), and `manual` (never inferred into execution).
3. A guided candidate may be suggested from a matching user brief; if multiple mutually exclusive
   candidates match, the agent asks one concise decision question rather than guessing.
4. Security/CTF, credential-bearing provider integrations, external-write workflows, legacy
   compatibility modes, and persistent-memory workflows remain manual unless their existing
   higher-risk contracts separately close.
5. Existing canonical automatic routes and lifecycle guarantees remain compatible.
6. A query command and checked-in catalog render the rationale, candidate skills, and any required
   confirmation before invocation.

## Acceptance Criteria

- All 116 records validate against the selection metadata schema.
- The catalog exposes actual purpose, explicit/inferred signals, confirmation policy, and posture.
- Conflicting visual styles are reported as a one-question confirmation requirement.
- No reverse-skill or persistent-memory record becomes inferred/automatic.
- Existing registry, routing, enforcement, package, and generated-bundle validation passes.