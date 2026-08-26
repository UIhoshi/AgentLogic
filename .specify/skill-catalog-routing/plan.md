# Plan — Guided Selection for the Portable Skill Catalog

## Design

### Three selection postures

- `route_candidate`: existing mandatory/conditional route entries; triggers still derive from
  `contracts/skill-routing.json` and progress through enforcement preflight/invocation/closure.
- `guided_candidate`: low-risk, narrowly-described skill selected from explicit or inferred task
  signals. It can produce a recommendation, but needs one user question when multiple competing
  candidates match. It does not bypass route enforcement for an execution claim.
- `manual`: restricted or niche capability. It appears in the catalog only after explicit user
  intent and its separate trust/permission gates; no semantic inference selects it.

### Metadata and catalog

Extend each registry record's activation metadata with `purpose`, `explicit_signals`,
`inferred_signals`, and `confirmation_policy`. Use a deterministic catalog script to render
`documentation/skill-catalog.md` and to query a user brief. The validator enforces metadata,
posture boundaries, and the rule that security/CTF and persistent-memory paths stay manual.

### Initial guided candidates

Promote only reviewed, low-risk workflow selectors: bug diagnosis, codebase design, domain
modeling, merge-conflict resolution, research, triage, long-running wayfinding, handoff,
existing-UI redesign, and dogfooding. UI style variants remain guided only when explicitly named
or selected after a single confirmation question. Provider-specific, security/CTF, and
persistent-memory skills remain manual.

## Red-Team Results

| Fails if ___ | Mitigation |
| --- | --- |
| inference selects a visually incompatible style | competing candidates require one confirmation question and mockup approval remains mandatory |
| a generic word auto-selects a high-risk tool | restricted path families are validator-enforced `manual` |
| catalog metadata becomes stale or misleading | derive purpose from reviewed registry metadata and validate every record |
| guided selection is mistaken for tool permission | document and enforce availability, permission, trust, and route closure separately |

## Validation

- Catalog query tests: one unambiguous candidate, one ambiguous visual choice, one restricted
  security request.
- Registry validator and negative fixtures.
- Existing routing/enforcement/package/maintainer validation and bundle regeneration.
## Inter-skill workflow graph

Do not treat skill selection as a flat list. Add a workflow-graph contract in the next session in
which each selected skill declares `requires`, `consumes`, `produces`, `blocks`, and
`verification`.

Implemented UI-chain topology:

```text
product classification -> requirements grilling -> design-direction selection -> image mockup -> user approval
-> frontend implementation -> behavior + browser/screenshot verification -> code review -> handover
```

- Requirements grilling produces an approved requirements brief.
- Taste selection consumes that brief and produces a selected or user-confirmed design direction.
- Image generation consumes the brief and design direction, and produces the mockup required for
  approval.
- Frontend implementation is blocked until the approved mockup or an explicit opt-out exists.
- Test and visual-verification routes consume implementation results and close behavior and visible
  claims separately; code review consumes that evidence before handover.

The standard website pipeline is selected from product classification, so the user answers product,
content, risk, and design questions rather than choosing skills. `skill-enforcement.ps1` adds the
graph routes to the task record and blocks review until the graph's behavior and browser/visual
verification predecessors close. The graph does not elevate restricted manual capabilities or claim
host-native tool interception; route preflight, availability, permissions, and closure evidence remain required.
