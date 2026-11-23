# V6.9 Role Persona Routing, Dual-Axis Subagent Squads, Skill-First Reflex & Multimodal Creative Governance

Status: **Current Stable V6.9.3 Line**.

This module defines the V6.9 cross-host execution rules for **Autonomous Startup Role Recommendation (`role-persona-router`, 11 orthogonal Lead Roles `[1]`–`[11]`)**, **Dual-Axis Subagent Squad Assignment (`contracts/role-personas.json`)**, **Habitual Skill-First Reflex ("Encounter -> Auto-Use Habit")**, **Pure UI/UX Design + Mandatory Text-to-Image Coupling (`ui-ux-pro-max`)**, **Multimodal & Programmatic Media (`multimodal-media-director`)**, **Office & PDF Standardization (`office-pro-suite`)**, **Long-Form Novel & Story Engineering (`novel-story-architect`)**, **Manga, Short-Video & Screenplay Direction (`screenplay-manga-director`)**, **Diagramming (`diagram-flowchart-architect`)**, **Application Security (`appsec-review`)**, **Web Data Visualization (`web-data-visualization`)**, **Browser Game Engineering (`web-game-studio`)**, **GitHub PR & CI Triage (`gh-pr-ci-triage`)**, and **Skill Evaluation (`skill-evaluator`)**.

---

## 1. Cross-Host Parity Mandate (`Antigravity` / `Claude Code` / `OpenAI Codex` / `Generic`)

Every host adapter (`adapters/antigravity/install.ps1`, `adapters/claude/install.ps1`, `adapters/codex/install.ps1`, `adapters/generic/install.ps1`) and every compiled bundle (`dist/antigravity/AGENTS.md`, `dist/claude/CLAUDE.md`, `dist/codex/model_instructions.md`, `dist/generic/AGENTLOGIC.md`) MUST enforce identical Turn 1 11-Role Recommendation, Dual-Axis Subagent Squad Assignment, UI Design + Mockup Preview, and Skill-First Reflex gates, and deploy all **17 first-party portable skills** to the host's skill directory (`.gemini/skills/`, `.claude/skills/`, `.codex/skills/`, or `<bundle>/skills/`).

---

## 2. Gate 1 Extension: Startup 11-Role Recommendation & Dual-Axis Subagent Squads (`role-persona-router`)

At the beginning of **every new project or non-continuation coding round**, alongside the `forget/compress context` check, the agent MUST automatically invoke `skills/productivity/role-persona-router/SKILL.md`:

1. **Recommend the #1 Best-Fit Lead Role** with a concise 1-sentence reason based on the user's task. For cross-domain/multi-module complex tasks, include a 1-line **Supporting Subagent Squad** suggestion in the same Turn 1 prompt (single-domain/simple tasks stay Lead-only).
2. **Present the Compact 11-Role Orthogonal Selection Menu (`contracts/role-personas.json`)**:
   - `[1] Principal Systems Architect & Full-Stack Lead` (`systems-architect-lead`)
   - `[2] UI/UX Creative Design Director & Frontend Craftsman` (`ui-ux-creative-director`)
   - `[3] Reverse Engineering & Clean-Room Reconstruction Specialist` (`reverse-reconstruction-specialist`)
   - `[4] Management Consultant & Financial/Office Architect` (`executive-office-consultant`)
   - `[5] Multimodal Creative Director (Image / Video / Code Video / Music)` (`multimodal-creative-director`)
   - `[6] Chief Showrunner & Long-Form Novel Architect` (`master-novelist-showrunner`)
   - `[7] Enterprise Architecture & Flowchart Cartographer` (`visual-systems-diagrammer`)
   - `[8] AppSec & DevSecOps Security Guardian` (`appsec-security-guardian`)
   - `[9] Data Analytics & Visualization Architect` (`data-viz-architect`)
   - `[10] Interactive Game & Creative Graphics Lead` (`game-graphics-lead`)
   - `[11] Screenwriter, Manga-Script & Short-Video Showrunner` (`screenplay-manga-video-director`)
3. **Bind Confirmed Persona & Dual-Axis Subagent Guardrails**: Once confirmed, lock the Lead persona. Whenever spawning a subagent in complex tasks, explicitly assign BOTH Axis A (`explore|plan|implement|review|verify`) and Axis B (`[1]`–`[11]` or universal sub-roles `codebase-explorer` / `independent-verifier`), propagate required `SKILL.md` paths (`Bound Skills`), enforce disjoint write ownership (`max_depth = 1`), and synthesize/update `PROJECT_MAP.md` & `CODE_MAP.md` from the Lead Agent.

---

## 3. Gate 2 Extension: Pure UI Design (`ui-ux-pro-max`) + Text-to-Image Coupling

For any net-new UI or substantial UI redesign (unless the user explicitly opts out of mockups):
1. **Requirements Brief (`product-requirements-grilling`)**: Clarify unresolved product/UI decisions one question at a time.
2. **Pure UI/UX Design Reasoning (`ui-ux-pro-max`)**: Derive the **Structured Visual Design Specification** (domain aesthetic archetype, exact HSL/Hex palette, typography pairing, spatial grid & whitespace density) **before** any mockup generation or code writing.
3. **Mandatory Text-to-Image Mockup (`imagegen` / `image-generator` / `multimodal-media-director` / `nano-banana-pro`)**: Feed the `ui-ux-pro-max` specification directly into the text-to-image generator to produce a high-craft visual preview image, present both the specification and mockup image to the user, and wait for approval before writing UI code.

---

## 4. Gate 3 Extension: Skill-First Reflex Protocol & Encounter -> Auto-Use Matrix

### 4.1 The 3-Step Habit Loop ("Encounter -> Auto-Use Habit")
Before writing code, designing UI/charts, reviewing diffs/PRs, creating Office/PDF/media/games, or auditing skills, the agent MUST treat skill activation as a mandatory reflex rather than an optional afterthought:
1. **3-Second Scenario Scan**: Map the incoming request against the 17 first-party skills and `contracts/skill-routing.json`.
2. **Read & Announce Before Acting**: On any match, read the matching `SKILL.md` first, announce `[Skill Activated: <name>]` in working reasoning/output, and follow its closure checklist by default—never improvise from memory.
3. **Chain Multi-Domain Tasks**: When a task spans multiple domains (e.g., new dashboard UI -> `product-requirements-grilling` + `ui-ux-pro-max` + `web-data-visualization` + `modern-web-guidance` + `code-simplifier` + `appsec-review`), activate each matching skill in sequence without asking the user to pick skill names.

### 4.2 Encounter -> Auto-Use Domain Matrix (17 First-Party Skills)

| Encountered Task / Signal | Automatic Route ID | Primary First-Party Skill | Core Enforcement & Deliverable Standard |
| :--- | :--- | :--- | :--- |
| **New Project Start (Turn 1)** | `role-selection` | `role-persona-router` | Recommend #1 Lead Role (+ optional Subagent Squad for complex tasks) & present `[1]`–`[11]` menu. |
| **UI / Feature Requirements** | `requirements-grilling` | `product-requirements-grilling` | Clarify unresolved product/UI decisions one question at a time into `.specify/<task>/requirements-brief.md`. |
| **UI / Frontend Design & Mockup** | `design-direction` $\rightarrow$ `ui-design` | `ui-ux-pro-max` + `multimodal-media-director` | Pure design-system specification first + mandatory text-to-image mockup preview + side-by-side Design QA (`P0`/`P1`/`P2`). |
| **Modern Web Platform & Legacy Scan** | `ui-implementation` / `web-platform-modernization` | `modern-web-guidance` | Query Baseline guides (`npx` or `guides/`) first for HTML/CSS/DOM/JS/CWV/a11y and `legacy-scan`. |
| **Chrome / Browser Extensions (MV3)** | `chrome-extension-development` | `chrome-extensions` | MV3 service workers, side panels, CSP-safe sandboxes, permission justifications, and Store checklist. |
| **Web Data Visualization (Charts / Maps)** | `data-visualization` | `web-data-visualization` | Truthful evidence-bearing encodings, dual desktop/mobile views, URL state, and accessible fallbacks. |
| **2D / 3D Browser Games** | `web-game-development` | `web-game-studio` | Modular `core/entities/ui` architecture, Phaser/Canvas2D or Three.js/R3F, and deterministic playtest verification. |
| **Text-to-Image / Video / Code Video / Music** | `multimodal-media` | `multimodal-media-director` | Art-direction prompts, Veo/Kling storyboards, Remotion/HyperFrames programmatic video, BPM/Key/Metatag sheets. |
| **Word / Excel / PPT / PDF Documents** | `office-document` | `office-pro-suite` | Word named styles/three-line tables; Excel live formulas + tie-out QA; 16:9 action-title PPT + QC; PDF `pdftoppm` visual check. |
| **Novel / Fiction Prose Writing** | `novel-writing` | `novel-story-architect` | `.story-bible/` continuity ledger (`_tracking-state.json`), 3-layer epistemic separation, scene beats, `story-deslop`. |
| **Manga / Short-Video / Screenplays** | `screenplay-manga-video` | `screenplay-manga-director` | Panel breakdown / 0–3s hook multi-track audio-visual table / `INT./EXT.` format + `.story-bible/` & `multimodal-media-director` handoff. |
| **Flowcharts / Swimlanes / Architecture** | `diagram-flowchart` | `diagram-flowchart-architect` | Real-source extraction, spatial zoning, semantic palette, zero-overlap routing across `.drawio`, `.excalidraw`, and `Mermaid`. |
| **Security Review / Diff / Threat Model** | `security-review` | `appsec-review` | Diff-scoped reachability, root/scoped `SECURITY.md` policy, `confirmed`/`not_actionable`/`needs_review` verdicts, STRIDE & ownership map. |
| **GitHub Actions CI & PR Review Threads** | `gh-pr-ci-triage` | `gh-pr-ci-triage` | Check `gh auth status`, inspect Actions logs/review comments, plan before bounded edits. |
| **Skill / Plugin Quality & Token Budget** | `skill-evaluation` | `skill-evaluator` | `At a Glance` / `Fix First` audit for frontmatter, trigger precision, progressive disclosure, links, and token budget. |
| **Binaries / Bytecode / Obfuscated Bundles** | `decompile-reconstruction` | `decompile-reconstruction` | Static triage (`GhidraMCP`/`ida-reverse`/`jadx`/`ilspycmd`/`pycdc`/`webcrack`) $\rightarrow$ clean-room source reconstruction. |
| **Post-Implementation / Code Refactor** | `code-refinement` | `code-simplifier` | Lock green test baseline $\rightarrow$ guard-clause flattening $\rightarrow$ `ast-grep` (`sg`) structural rewrites $\rightarrow$ zero behavior regression. |
