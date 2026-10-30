# Changelog

## V6.9.0 — 2026-10-31

### Added
- **Turn 1 Autonomous Role Recommendation & Selection Gate (`role-persona-router`)**: Automatically recommends the `#1` best-fit Lead Role with a 1-sentence rationale and presents a 7-role menu at the start of every new project or non-continuation task across Antigravity, Claude Code, and OpenAI Codex/GPT.
- **Pure UI/UX Design + Mandatory Text-to-Image Coupling (`ui-ux-pro-max`)**: Synthesizes industry color palettes, typography pairings, and spatial grids (based on `nextlevelbuilder/ui-ux-pro-max-skill` + `taste-skill`, excluding Anthropic's `frontend-design`) and mandatorily couples with text-to-image mockup generation before any UI code is written.
- **Autonomous Multimodal Media Director (`multimodal-media-director`)**: Zero-manual-selection orchestration for Text-to-Image, Text-to-Video camera storyboards, and Text-to-Music arrangement sheets.
- **Professional Office Design & Standardization Suite (`office-pro-suite`)**: Executive typography and table standards for Word (`.docx`), dynamic-formula and blue/black/green financial modeling standards for Excel (`.xlsx`), and 16:9 action-title slide architecture for PowerPoint (`.pptx`).
- **Long-Form Novel & Script Creation Engine (`novel-story-architect`)**: `.story-bible/` continuity compiler, scene beat sheets, and strict anti-AI-cliché prose filtering.
- **Enterprise Flowchart & Architecture Diagramming (`diagram-flowchart-architect`)**: Native `.drawio` XML, color-zoned `.excalidraw` JSON, and syntax-validated themed `Mermaid` generation.
- **Autonomous Decompilation (`decompile-reconstruction`) & Code Refinement (`code-simplifier`)**: Clean-room source reconstruction from binaries/bundles and post-implementation AST/guard-clause simplification.

### Changed
- Upgraded `manifest.json`, `versions/AgentLogic_V6_9_0.md`, and `modules/54_V6_9_RoleAndMultimodalCreativeGovernance.md` to `V6.9.0`.
- Expanded portable skill registry to **124 skills**, workflow graph to **15 nodes / 8 default pipelines**, and autonomous routing to **19 routes**.
- Embedded V6.9 mandatory blocking gates (Gates 1–4) and all **9 first-party skills** directly into the cross-host bundles and installers for Antigravity (`~/.gemini/`), Claude Code (`~/.claude/`), and Codex (`~/.codex/`).

## V6.8.7 — 2026-08-27

### Added
- Product-first automatic skill workflow for substantial website/UI work: requirements, design direction, mockup approval or opt-out, implementation, behavior testing, browser and visual verification, review, and handover.
- Workflow-graph contract, complete portable-skill catalog (116 skills), route-state validation, and durable artifact hash evidence.

### Changed
- Mandatory routes choose a verified available primary or conditional capability and validate prerequisite closure before invocation and completion.
- The host deployment payload now carries routing, registry, graph, and enforcement contracts consistently across supported hosts.

### Removed
- No global Codex Hook is installed or configured; project workflows remain stateful, explicit, and host-agnostic.

## V6.8.6 — 2026-08-23

### Added
- Programming-level skill enforcement: portable-skill registry, explicit lifecycle states, schema-v3 routing, recorded invocation/closure evidence, and validation scripts.
- Cross-host enforcement deployment for Codex, Claude, Antigravity, and generic installations.
- Project `.agentlogic/skill-usage.json` and `CODE_MAP.md` Skill Usage summaries for future skill replacement and upgrade planning.

### Changed
- Mandatory skill routes now select an available primary capability deterministically and block unsupported verified claims instead of silently degrading.
- Added the portable `code-review` skill as an approved conditional code-review route when installed.
- Release/package flows retain native local artifact-validation fallback with explicit disclosure; remote releases still require exact-target and post-result evidence.
