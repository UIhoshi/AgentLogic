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

## Product-first workflow hardening addendum

The standard website-delivery flow must be executable rather than only documented.

1. Design direction and handover are recorded routes. Design direction must close before a mockup
   can be invoked; handover must close after code review.
2. A closure claim that represents a durable artifact must include a structured artifact record:
   an allowed artifact kind, an existing path, and the SHA-256 observed when the record is made.
   The workflow state stores these records and re-checks them before later transitions.
3. The standard website route requires artifacts for: requirements brief, design-direction record,
   mockup-or-opt-out record, implementation validation, behavior result, browser observation,
   visual capture, review report, and handover.
4. Preflight must choose a currently available primary alias, then an available conditional alias,
   before applying a route's explicit native fallback. It must not remain blocked merely because
   the first listed alias is unavailable while another approved alias is present.
5. A verified host-native interception hook is not assumed. The contracts must retain the honest
   `workflow_enforced` boundary until an actual Codex hook is separately evidenced.
