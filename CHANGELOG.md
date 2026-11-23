# Changelog

## V6.9.2 — 2026-11-24

### Added
- **11 Orthogonal Lead Roles + Dual-Axis Subagent Squad Contract (`contracts/role-personas.json` + `scripts/validate-role-personas.ps1`)**:
  - Expanded Turn 1 Lead Role matrix from 7 to **11 orthogonal roles**: added **`[8]` AppSec & DevSecOps Security Guardian**, **`[9]` Data Analytics & Visualization Architect**, **`[10]` Interactive Game & Creative Graphics Lead**, and **`[11]` Screenwriter, Manga-Script & Short-Video Showrunner**.
  - Added **Dual-Axis Subagent Squad Assignment** (`explore|plan|implement|review|verify` × `[1]`–`[11]` or universal sub-roles `codebase-explorer` / `independent-verifier`) with mandatory `Bound Skills` propagation, disjoint write ownership, and `max_depth = 1` guardrails across `role-persona-router`, Module 44, Module 54, and cross-host adapters.
- **Habitual Skill-First Reflex & 6 New First-Party Auto-Triggered Skills (158 $\rightarrow$ 164 Registered Skills; 11 $\rightarrow$ 17 Auto-Deployed First-Party Skills; 21 $\rightarrow$ 26 Auto-Routes)**:
  - **`screenplay-manga-director`** (`skills/creative/screenplay-manga-director/SKILL.md` + `references/production-checklists.md`): Panel-by-panel manga/webtoon scripting, 0–3s hook short-video/micro-drama multi-track tables, and `INT./EXT.` screenplays, enriched with verified MIT/Apache-2.0/MIT-0 workflows from `zenstory-ai/drama-skills` (5-doc spine & `REV-xxx` cross-shot review), `eternityspring/shuohao-skills` (single-root `character-refs` & `novel-staging` blocking), `LuoJiangYong/muse-video-skill` (six-role virtual film-crew Subagents, asset-ID chain & 6-part video prompts), `mengxiujie/ManjuForge` (identity invariants vs state variables & Foreshadow Engine), and `kaomei/hand-drawn-video-prompts` (9:16 vertical comic framing).
  - **`appsec-review`** (`skills/engineering/appsec-review/SKILL.md`): Synthesizes Apache-2.0 `openai/skills` security workflows (`security-best-practices`, `security-threat-model`, `security-ownership-map`) with clean-room diff-scoped reachability, `SECURITY.md` policy resolution, and tri-state verdicts (`confirmed` / `not_actionable` / `needs_review`).
  - **`web-data-visualization`** (`skills/frontend/web-data-visualization/SKILL.md`): Synthesizes MIT `openai/plugins/plugins/build-web-data-visualization` as a single progressive-disclosure orchestrator for charts, dashboards, maps, Gantt, D3/Vega-Lite/Canvas2D, URL state, and dual desktop/mobile views.
  - **`gh-pr-ci-triage`** (`skills/engineering/gh-pr-ci-triage/SKILL.md`): Synthesizes Apache-2.0 `openai/skills` `gh-fix-ci` & `gh-address-comments` via `gh` CLI.
  - **`skill-evaluator`** (`skills/engineering/skill-evaluator/SKILL.md` + `scripts/eval-skills.ps1`): Synthesizes MIT `openai/plugins/plugins/plugin-eval` to audit frontmatter, trigger precision, progressive disclosure, broken links, and token budgets.
  - **`web-game-studio`** (`skills/frontend/web-game-studio/SKILL.md`): Synthesizes MIT `openai/plugins/plugins/game-studio` for 2D Phaser/Canvas2D and 3D Three.js/R3F browser games and deterministic playtesting.
- **Standard Codex Plugin Packaging (`scripts/build-codex-plugin.ps1`)**: Generates `.codex-plugin/plugin.json` + `.agents/plugins/marketplace.json` + all 16 first-party skills under `dist/codex-plugin/` and deploys it during Codex installation.

### Changed
- **Skill-First Reflex Protocol ("Encounter -> Auto-Use Habit")**: Baked the mandatory 3-second Scenario -> Skill scan, `[Skill Activated: <name>]` announcement, and multi-skill chaining discipline into Gate 3 across `scripts/build-profile.ps1`, `adapters/antigravity/install.ps1`, `modules/54_V6_9_RoleAndMultimodalCreativeGovernance.md`, and `modules/48_V6_8_SkillAndToolRouting.md`.
- **Upgraded Existing First-Party Skills & Visual QA**:
  - `office-pro-suite`: Added PDF (`.pdf`) visual-render QA (`pdftoppm` + `read_file`, Apache-2.0 `openai/skills` `pdf`) and clean-room Excel three-statement tie-out / PPT deck QC checklists.
  - `multimodal-media-director`: Added programmatic video composition guidance (`Remotion` MIT / `HyperFrames` Apache-2.0).
  - `modules/39_V6_6_TasteFrontendDesign.md` & `ui-ux-pro-max`: Added clean-room side-by-side Design QA & `P0`/`P1`/`P2` blocking remediation loop.
- Upgraded `manifest.json`, `versions/AgentLogic_V6_9_2.md`, entry documents, contracts (`skill-registry.json`, `skill-routing.json`, `skill-enforcement.json`, `skill-workflow-graph.json`, `host-skill-capabilities.json`), and compiled `dist/` host bundles to **`V6.9.2`**.

## V6.9.1 — 2026-11-11

### Added
- **Expanded Portable Skill Ecosystem (124 $\rightarrow$ 157 Registered Skills)**:
  - **Matt Pocock Engineering & Productivity Suite (18 new skills)**: Added `code-review`, `codebase-design`, `diagnosing-bugs`, `domain-modeling`, `implement`, `implement-spec`, `improve-codebase-architecture`, `pr`, `retro`, `tdd`, `to-Prompt`, `to-questionnaire`, `to-spec`, `to-tickets`, `ubiquitous-language`, `wait-what`, `wizard`, and `writing-for-agents`.
  - **Taste Skill 2.5.1 Suite (5 new skills + UI asset fragments)**: Added `minimalist-skill`, `redesign-skill`, `soft-skill`, `stitch-skill`, and `taste-Tokens` alongside modular HTML/CSS/JS UI component fragments and lint scripts.
  - **Reverse Engineering & Security Expansion (10 new skills)**: Added `ghidra-reverse`, `binary-ninja-reverse`, `go-rust-reverse`, `protocol-reverse`, `vulnerability-validation`, and CTF Sandbox Orchestrator modules (`competition-ad-certificate-abuse`, `competition-agent-cloud`, `competition-android-hooking`, `competition-browser-persistence`, `competition-container-escape`).

### Changed
- Upgraded `manifest.json`, `versions/AgentLogic_V6_9_2.md`, entry documents, and compiled `dist/` host bundles to **`V6.9.1`**.
- Synchronized all vendored & referenced upstream GitHub repositories (`agent-browser` v0.41.2, `spec-kit` v1.3.3.dev0, `taste-skill` 2.5.1, `ponytail`, `mattpocock/skills`, `self-improving-agent`, `reverse-skill`, `ui-ux-pro-max` v2.5+, `morluto/rea`, `oh-story-claudecode` v0.10.2, `Agents365-ai/drawio-skill` v3.4.4, `jgraph/drawio-mcp` v1.7.0, `obra/superpowers` v7.0.2, `anthropics/skills` Apache 2.0).
- Enhanced first-party skills (`ui-ux-pro-max`, `novel-story-architect`, `diagram-flowchart-architect`, `decompile-reconstruction`, `code-simplifier`, `office-pro-suite`) and governance modules (`modules/37`–`39`, `42`–`43`, `54`) with upstream capabilities.

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
