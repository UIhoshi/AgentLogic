# Code Map

This text-first map is the default navigation index for this repository. Confirm active facts with
current source and matching verification before making a strong claim.

## Key flows

| Flow | Owner / path | Change-impact route | Validation |
| --- | --- | --- | --- |
| Profile compilation | `manifest.json` -> `scripts/build-profile.ps1` -> `dist/` | profile file list, adapters, generated bundles | `scripts/validate-package.ps1` |
| Entry enforcement | `00_START_HERE.md`, `AGENTS.md`, `README.md`, Module 15 | entry documents, logic-chain references, operational entry files | `node scripts/check-logic-entry.js` |
| Map-first code navigation | Modules 46 and 51 -> `PROJECT_MAP.md` / `CODE_MAP.md` | map -> owner -> callers/callees/config -> targeted reads; search only for a map gap | source reads plus the matching evidence route |
| Tool and skill routing | Modules 27, 29-31, 48-49, 53; `contracts/skill-*.json` | classify -> preflight -> recorded invocation -> closure -> project handover; for blocked installs, list missing reviews/dependencies and ask once for a scoped bundle before execution | registry, routing, workflow-gate, and package validation |
| Product-first inter-skill workflow | `contracts/skill-workflow-graph.json` -> `scripts/skill-enforcement.ps1` -> `scripts/validate-skill-workflow-graph.ps1` -> `scripts/skill-catalog.ps1 -Mode website-pipeline` | matching UI classification automatically adds requirements -> design direction -> mockup -> implementation -> verification -> review -> handover; graph dependencies and artifact hashes block early transitions; users never choose skills | state-machine regression test, graph validator, and derived pipeline output |
| Portable-skill inventory and catalog | `contracts/skill-registry.json` -> `scripts/audit-skill-duplicates.ps1` -> registry validator -> `scripts/skill-catalog.ps1` | discover `SKILL.md` -> activation metadata -> deterministic catalog/query | duplicate audit, registry validator, catalog query |
| UI work | Modules 38-39 and 49 | requirements -> mockup when required -> approved scope -> implementation | visual artifact and containment check |
| External research, artifacts, and Office files | Modules 47 and 50 | provenance -> consent/trust -> bounded capture/artifact or OfficeCLI structure -> bounded mutation -> render | matching source/runtime/visual evidence; Office files require OfficeCLI availability and trust |
| Reference-image interactive 3D web model | Module 52 / img2threejs candidate -> target-project Three.js integration | clarify static vs interactive vs reference-model outcome -> audit/consent -> staged model route -> in-page verification | browser/runtime, visual, containment, performance, and accessibility evidence |
| Host installation | `install.ps1`, adapters, deployment scripts | target host -> generated bundle -> first-party skill and enforcement payload deployment -> post-check | package validation and installed-path inspection |

## Interfaces and state

- `manifest.json`: current version, profile membership, host output contract.
- `versions/AgentLogic_V6_8_7.md`: stable version-source narrative.
- `contracts/skill-registry.json`: explicit lifecycle record for every portable `SKILL.md`.
- `contracts/skill-routing.json`: ordered capability routes, dependencies, closure evidence, and required durable artifact kinds.
- `contracts/skill-enforcement.json`: classification and workflow-gate state contract.
- `contracts/skill-workflow-graph.json`: selected-skill prerequisites, artifacts, blocked transitions, and verification contract.
- `scripts/skill-enforcement.ps1`: preflight, invocation, closure, and project Skill Usage validator.
- `contracts/host-skill-capabilities.json`: first-party skill and workflow-enforcement payload deployment locations.
- `.specify/`: scoped specification, plan, task, and ship records for non-trivial work.
- `PROJECT_MAP.md`: repository L1-L4 map and validation boundary index.
- `.learnings/ERRORS.md`: redacted material-error records only.


## Skill Usage

| Durable flow | Capability / skill | Trigger | Source of truth | Reviewed commit |
| --- | --- | --- | --- | --- |
| Major feature specification | `product-requirements-grilling` | `major_feature` | `.agentlogic/skill-usage.json` | `34eab55 + V6.8.7 release worktree` |
| Behavior-change validation | `tdd-guide` | `behavior_change` | `.agentlogic/skill-usage.json` | `34eab55 + V6.8.7 release worktree` |
| V6.8.7 release review | `code-review` | `release_review` | `.agentlogic/skill-usage.json` | `34eab55 + V6.8.7 release worktree` |
> This summary is intentionally concise. Per-task invocation evidence for the programming-level
> enforcement upgrade is stored in `.specify/skill-enforcement-hardening/skill-execution.json`.

## Map maintenance

- When inheriting a project, refresh the maps and reconcile them with the working tree before broad discovery.
- When owning a project, add each new key flow at its first implementation and update affected owner, interface, state, and validation rows in the same change.
- A map is a navigation aid, not runtime or remote-state proof.
