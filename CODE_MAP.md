# Code Map

This text-first map is the default navigation index for this repository. Confirm active facts with
current source and matching verification before making a strong claim.

## Key flows

| Flow | Owner / path | Change-impact route | Validation |
| --- | --- | --- | --- |
| Profile compilation | `manifest.json` -> `scripts/build-profile.ps1` -> `dist/` | profile file list, adapters, generated bundles (with cross-host Gates 1–3 header) | `scripts/validate-package.ps1` |
| Entry & Role Selection Gate | `00_START_HERE.md`, `AGENTS.md`, `README.md`, Module 15, Module 54, `contracts/role-personas.json`, `skills/productivity/role-persona-router/SKILL.md` | Turn 1 context-reset check + 11-role Lead recommendation & dual-axis Subagent squad assignment across Antigravity, Claude, Codex, and Generic | `node scripts/check-logic-entry.js`, `scripts/validate-role-personas.ps1`, `scripts/test-skill-enforcement.ps1` |
| Map-first code navigation | Modules 46 and 51 -> `PROJECT_MAP.md` / `CODE_MAP.md` | map -> owner -> callers/callees/config -> targeted reads; search only for a map gap | source reads plus the matching evidence route |
| Tool and skill routing | Modules 27, 29-31, 48-49, 53-54; `contracts/skill-*.json` | classify -> preflight -> recorded invocation -> closure -> project handover | registry, routing, workflow-gate, and package validation |
| Pure UI Design + Text-to-Image Coupling | `skills/design/ui-ux-pro-max/SKILL.md` -> `skills/creative/multimodal-media-director/SKILL.md` -> `contracts/skill-routing.json` | `requirements-grilling` -> `ui-ux-pro-max` pure design specification -> mandatory text-to-image mockup preview -> user approval -> `ui-implementation` | state-machine regression test and visual containment check |
| Multimodal, Office/PDF, Novel, Script & Diagram Auto-Routes | Module 54; `skills/creative/*`, `skills/productivity/office-pro-suite/*`, `skills/engineering/diagram-flowchart-architect/*` | `multimodal_media` -> `multimodal-media-director` (+ Remotion/HyperFrames); `office_document` -> `office-pro-suite` (`.docx`/`.xlsx`/`.pptx`/`.pdf`); `novel_writing` -> `novel-story-architect`; `screenplay_manga_video` -> `screenplay-manga-director`; `diagram_flowchart` -> `diagram-flowchart-architect` | `scripts/validate-skill-routing.ps1`, `scripts/test-skill-enforcement.ps1` |
| AppSec, Data Viz, Browser Games, GH PR/CI & Skill Eval | `skills/engineering/appsec-review/*`, `skills/frontend/web-data-visualization/*`, `skills/frontend/web-game-studio/*`, `skills/engineering/gh-pr-ci-triage/*`, `skills/engineering/skill-evaluator/*` | `security_review` -> `appsec-review`; `data_visualization` -> `web-data-visualization`; `web_game` -> `web-game-studio`; `gh_ci_or_pr_triage` -> `gh-pr-ci-triage`; `skill_evaluation` -> `skill-evaluator` | `scripts/validate-skill-routing.ps1`, `scripts/eval-skills.ps1`, `scripts/test-skill-enforcement.ps1` |
| Automatic decompilation & code refinement | `skills/engineering/decompile-reconstruction/SKILL.md`, `skills/engineering/code-simplifier/SKILL.md`, `contracts/skill-routing.json` | `decompile_or_reconstruct` -> `decompile-reconstruction`; `refactor` or `code_refinement` -> `code-refinement` (`code-simplifier` + `ast-grep` + `ponytail`) | `scripts/validate-skill-routing.ps1`, `scripts/test-skill-enforcement.ps1` |
| Portable-skill inventory, catalog & evaluation | `contracts/skill-registry.json` -> `scripts/audit-skill-duplicates.ps1` -> `scripts/eval-skills.ps1` -> registry validator -> `scripts/skill-catalog.ps1` | discover `SKILL.md` -> activation metadata + token-budget audit -> deterministic catalog/query | duplicate audit, skill evaluator, registry validator, catalog query |
| Host installation (All Hosts + Codex Plugin) | `install.ps1`, `adapters/antigravity/install.ps1`, `adapters/claude/install.ps1`, `adapters/codex/install.ps1`, `adapters/generic/install.ps1`, `scripts/build-codex-plugin.ps1` | target host -> generated V6.9.2 bundle + Codex plugin -> deploy all 17 first-party skills -> deploy & verify enforcement payload | `scripts/maintainer-check.ps1` and installed-path inspection |

## Interfaces and state

- `manifest.json`: current version (`V6.9.2`), profile membership, host output contract.
- `versions/AgentLogic_V6_9_2.md`: stable version-source narrative.
- `contracts/role-personas.json`: 11 orthogonal Lead Roles + 2 universal Subagent functional roles + dual-axis Subagent dispatch guardrails.
- `contracts/skill-registry.json`: explicit lifecycle record for every portable `SKILL.md` (164 skills).
- `contracts/skill-routing.json`: 26 ordered capability routes, dependencies, closure evidence, and required durable artifact kinds.
- `contracts/skill-enforcement.json`: classification and workflow-gate state contract.
- `contracts/skill-workflow-graph.json`: 22 workflow nodes, 15 default pipelines, artifacts, blocked transitions, and verification contract.
- `scripts/skill-enforcement.ps1`: preflight, invocation, closure, and project Skill Usage validator.
- `scripts/validate-role-personas.ps1`: validates `contracts/role-personas.json`.
- `scripts/eval-skills.ps1`: `SKILL.md` frontmatter, trigger, link, and token-budget evaluator.
- `scripts/build-codex-plugin.ps1`: standard `.codex-plugin/plugin.json` + `.agents/plugins/marketplace.json` generator (`dist/codex-plugin/`).
- `contracts/host-skill-capabilities.json`: first-party skill (17 skills) and workflow-enforcement payload deployment locations across Codex, Claude, Antigravity, and Generic.
- `.specify/`: scoped specification, plan, task, and ship records for non-trivial work.
- `PROJECT_MAP.md`: repository L1-L4 map and validation boundary index.
- `.learnings/ERRORS.md`: redacted material-error records only.


## Skill Usage

| Durable flow | Capability / skill | Trigger | Source of truth | Reviewed commit |
| --- | --- | --- | --- | --- |
| Turn 1 startup role recommendation and persona selection | `role-persona-router` | `role_selection` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Major feature specification | `product-requirements-grilling` | `major_feature` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Pure UI/UX design specification coupled with text-to-image mockup | `ui-ux-pro-max` | `net_new_ui` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic text-to-image, text-to-video, and text-to-music direction | `multimodal-media-director` | `multimodal_media` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic Word, Excel, and PowerPoint professional design and standardization | `office-pro-suite` | `office_document` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic Story Bible continuity compilation and anti-AI-cliche novel drafting | `novel-story-architect` | `novel_writing` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic Draw.io, Excalidraw, and themed Mermaid flowchart generation | `diagram-flowchart-architect` | `diagram_flowchart` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Behavior-change validation | `tdd-guide` | `behavior_change` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic code refinement and AST refactoring | `code-simplifier` | `code_refinement` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| Automatic binary/bundle decompilation and clean-room reconstruction | `decompile-reconstruction` | `decompile_reconstruction` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
| V6.9.2 release review | `code-review` | `release_review` | `.agentlogic/skill-usage.json` | `056c70b + V6.9.2 release worktree` |
> This summary is intentionally concise. Per-task invocation evidence for the programming-level
> enforcement upgrade is stored in `.specify/skill-enforcement-hardening/skill-execution.json`.

## Map maintenance

- When inheriting a project, refresh the maps and reconcile them with the working tree before broad discovery.
- When owning a project, add each new key flow at its first implementation and update affected owner, interface, state, and validation rows in the same change.
- A map is a navigation aid, not runtime or remote-state proof.
