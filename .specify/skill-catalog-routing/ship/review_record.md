# Review Record - Inter-Skill Workflow Graph

## Scope

- Added a seven-node, artifact-level workflow graph for requirements, design direction, mockup,
  implementation, behavior verification, browser/visual verification, and handover.
- Added deterministic validation, a cyclic-dependency regression fixture, payload deployment, and
  generated bundle updates.

## Implemented reality

- `contracts/skill-workflow-graph.json` declares `requires`, `consumes`, `produces`, `blocks`,
  and `verification` for every node.
- Route nodes reference existing canonical routes; guided and manual nodes cannot add a route or
  elevate a manual skill.
- The validator rejects unknown nodes/routes, cycles, duplicate artifact producers, artifact use
  without a required producer, and route nodes that omit canonical closure evidence or blocked
  transitions.
- All host workflow-enforcement payloads now contain the graph contract. This is recorded
  workflow validation, not host-native interception of tool calls.

## Self-refuted findings

| Potential concern | Evidence | Counter-argument | Status |
| --- | --- | --- | --- |
| The graph could bypass existing routing controls. | Route-node ids are validated against `skill-routing.json`; non-route nodes must have no route ids. | The graph only describes sequencing and artifacts; `skill-enforcement.ps1` remains the route lifecycle gate. | Cleared / verified statically. |
| A graph may permit a consumer before its producer. | Validation requires a consumed artifact to be an external input or to be produced by a required ancestor. | The cyclic-fixture regression test proves a dependency cycle is rejected. | Cleared / verified. |
| Generated bundles or installed payload declarations may omit the graph. | Package validation checks profile membership; routing validation checks payload file lists; all four bundles were rebuilt. | This verifies generated artifacts and deployment contracts, not a live host installation. | Verified for package generation. |

## Validation

- `node scripts/check-logic-entry.js`: pass.
- `scripts/test-skill-registry.ps1`: pass.
- `scripts/validate-skill-workflow-graph.ps1`: pass (7 nodes).
- `scripts/test-skill-workflow-graph.ps1`: pass.
- `scripts/test-skill-enforcement.ps1`: pass.
- `scripts/validate-package.ps1`: pass.
- `scripts/maintainer-check.ps1`: pass.

## Conditional surfaces

No user authorization, database, secret, network hot path, or external runtime mutation was added;
separate permissions, variables, performance, and runtime-flow documents are not applicable to
this repository-local contract/tooling change.
