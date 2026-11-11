# V6.9.0 Role Persona Routing & Multimodal Creative Governance

Status: **Current Stable V6.9.0 Line**.

This module defines the V6.9.0 cross-host execution rules for **Autonomous Startup Role Recommendation (`role-persona-router`)**, **Pure UI/UX Design + Mandatory Text-to-Image Coupling (`ui-ux-pro-max`)**, **Multimodal Media Generation (`multimodal-media-director` for Image / Video / Music)**, **Office Professional Design & Standardization (`office-pro-suite` for Word / Excel / PPT)**, **Long-Form Novel & Story Engineering (`novel-story-architect`)**, and **Multi-Format Flowchart & Architecture Diagramming (`diagram-flowchart-architect`)**.

---

## 1. Cross-Host Parity Mandate (`Antigravity` / `Claude Code` / `OpenAI Codex` / `Generic`)

Every host adapter (`adapters/antigravity/install.ps1`, `adapters/claude/install.ps1`, `adapters/codex/install.ps1`, `adapters/generic/install.ps1`) and every compiled bundle (`dist/antigravity/AGENTS.md`, `dist/claude/CLAUDE.md`, `dist/codex/model_instructions.md`, `dist/generic/AGENTLOGIC.md`) MUST enforce identical Turn 1 Role Recommendation, UI Design + Mockup Preview, and Encounter-Driven Auto-Use gates, and deploy all 9 first-party portable skills to the host's skill directory (`.gemini/skills/`, `.claude/skills/`, `.codex/skills/`, or `<bundle>/skills/`).

---

## 2. Gate 1 Extension: Startup Autonomous Role Recommendation (`role-persona-router`)

At the beginning of **every new project or non-continuation coding round**, alongside the `forget/compress context` check, the agent MUST automatically invoke `skills/productivity/role-persona-router/SKILL.md`:

1. **Recommend the #1 Best-Fit Lead Role** (or Lead + Supporting Squad) with a concise 1-sentence reason based on the user's task.
2. **Present the Compact 7-Role Selection Menu**:
   - `[1] Principal Systems Architect & Full-Stack Lead` (`systems-architect-lead`)
   - `[2] UI/UX Creative Design Director & Frontend Craftsman` (`ui-ux-creative-director`)
   - `[3] Reverse Engineering & Clean-Room Reconstruction Specialist` (`reverse-reconstruction-specialist`)
   - `[4] Management Consultant & Financial/Office Architect` (`executive-office-consultant`)
   - `[5] Multimodal Creative Director (Image / Video / Music)` (`multimodal-creative-director`)
   - `[6] Chief Showrunner & Long-Form Novel Architect` (`master-novelist-showrunner`)
   - `[7] Enterprise Architecture & Flowchart Cartographer` (`visual-systems-diagrammer`)
3. **Bind Confirmed Persona**: Once the user confirms the recommendation or selects another role, lock that persona's quality standards and automatic skill pipeline for the duration of the project.

---

## 3. Gate 2 Extension: Pure UI Design (`ui-ux-pro-max`) + Text-to-Image Coupling

For any net-new UI or substantial UI redesign (unless the user explicitly opts out of mockups):
1. **Requirements Brief (`product-requirements-grilling`)**: Clarify unresolved product/UI decisions one question at a time.
2. **Pure UI/UX Design Reasoning (`ui-ux-pro-max`)**: Derive the **Structured Visual Design Specification** (domain aesthetic archetype, exact HSL/Hex palette, typography pairing, spatial grid & whitespace density) **before** any mockup generation or code writing.
3. **Mandatory Text-to-Image Mockup (`imagegen` / `image-generator` / `multimodal-media-director` / `nano-banana-pro`)**: Feed the `ui-ux-pro-max` specification directly into the text-to-image generator to produce a high-craft visual preview image, present both the specification and mockup image to the user, and wait for approval before writing UI code.

---

## 4. Gate 3 Extension: Encounter -> Auto-Use Domain Matrix (Zero Manual Skill Selection)

The agent MUST never require the user to manually invoke a skill name. Whenever the task encounters any of the following domains, the corresponding route and first-party skill activate automatically:

| Encountered Task / Signal | Automatic Route ID | Primary First-Party Skill | Core Enforcement & Deliverable Standard |
| :--- | :--- | :--- | :--- |
| **New Project Start (Turn 1)** | `role-selection` | `role-persona-router` | Recommend #1 Lead Role + present `[1]`–`[7]` role menu for user confirmation. |
| **UI / Frontend Design & Mockup** | `design-direction` $\rightarrow$ `ui-design` | `ui-ux-pro-max` + `multimodal-media-director` | Pure design-system specification first (192 industry rules, 80 styles, Master+Overrides, Resilient Text, `tasteskill 2.5.1`), coupled with mandatory text-to-image mockup preview. |
| **Text-to-Image / Video / Music** | `multimodal-media` | `multimodal-media-director` | Art-direction prompts (Image), shot-by-shot camera storyboards (Video), BPM/Key/Metatag arrangement sheets (Music). |
| **Word / Excel / PPT (`.docx`/`.xlsx`/`.pptx`)** | `office-document` | `office-pro-suite` | Named styles & three-line/zebra tables in Word; live formulas & blue/black/green modeling convention in Excel; 16:9 action-title visual variety in PPT. |
| **Novel / Fiction / Script Writing** | `novel-writing` | `novel-story-architect` | `.story-bible/` continuity ledger (`_tracking-state.json`), 3-layer epistemic separation (`作者真相`/`读者已知`/`角色当下认知`), scene beat sheets, 5 deterministic `story-deslop` lint rules, 5-point continuity check. |
| **Flowcharts / Swimlanes / Architecture** | `diagram-flowchart` | `diagram-flowchart-architect` | Real-source extraction (16 source types), spatial zoning, semantic palette, zero-overlap orthogonal routing across `.drawio` XML, `.excalidraw` JSON, and themed `Mermaid`. |
| **Binaries / Bytecode / Obfuscated Bundles** | `decompile-reconstruction` | `decompile-reconstruction` | Static triage (`GhidraMCP`/`ghidra-reverse`/`ida-reverse`/`binary-ninja-reverse`/`go-rust-reverse`/`jadx`/`ilspycmd`/`pycdc`/`webcrack`) $\rightarrow$ clean-room source reconstruction. |
| **Post-Implementation / Code Refactor** | `code-refinement` | `code-simplifier` | Lock green test baseline $\rightarrow$ guard-clause flattening $\rightarrow$ `ast-grep` (`sg`) structural rewrites $\rightarrow$ preserve `shortcut:` debt markers $\rightarrow$ zero behavior regression. |
