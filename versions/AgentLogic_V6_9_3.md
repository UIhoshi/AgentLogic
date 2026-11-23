# AgentLogic V6.9.3

Status: **Current Stable V6.9.3 Line**.
Promoted from V6.9.2 with **Bounded ~11 KB Non-Destructive Executive Hooks (`scripts/install-hook.ps1`)** for Antigravity, Claude Code & Codex (eliminating 774 KB inline prompt bloat and protecting user-authored rules with automatic `.agentlogic-backup/` snapshots), **Zero-`pwsh` Cross-Platform Node.js Installer (`scripts/install.js` + `install.sh` fallback)**, **Closed `skill-enforcement.ps1` Bypass & Dynamic 21-`TaskClass` Validation**, **Strict Image-Generator Gating on `ui-design`**, **42 Verified External Reference Registrations**, **Self-Validating `.agentlogic/skill-usage.json` & `dist/generic` Parity**, and **Full Regression + CI Enforcement** alongside **Habitual Skill-First Reflex ("Encounter -> Auto-Use Habit")**, **11 Orthogonal Lead Roles + Dual-Axis Subagent Squads**, **17 First-Party Auto-Deployed Skills**, **164 Registered Portable Skills**, and **26 Deterministic Auto-Routes**.

---

## 1. The V6.9.3 Mandate

V6.9.3 hardens execution reliability, context-window efficiency, and cross-platform portability across Antigravity, Claude Code, OpenAI Codex/GPT, and Generic bundles while keeping every V6.9.x role, Design QA, and Skill-First governance gate intact.

Key Enhancements:
- **Bounded ~11 KB Non-Destructive Host Hooks & Context Efficiency (`scripts/install-hook.ps1`, `scripts/install.js`)**: Strips the 338 KB `contracts/skill-registry.json` from prompt bundles, compacts embedded JSON contracts, and installs `<!-- BEGIN AGENTLOGIC HOOK --> ... <!-- END AGENTLOGIC HOOK -->` marker-bounded hooks across `~/.gemini/GEMINI.md`, `~/.claude/CLAUDE.md`, and `~/.codex/agentlogic/model_instructions.md` (with automatic `.agentlogic-backup/` snapshots before first hook insertion and zero truncation of user-authored rules), while `install.sh` falls back natively to Node.js (`scripts/install.js`) on macOS/Linux without requiring PowerShell.
- **Closed State-Machine, Routing & Validator Bypasses (`scripts/skill-enforcement.ps1`, `scripts/check-logic-entry.js`, `scripts/eval-skills.ps1`)**: Validates all 21 `task_class` values directly from `contracts/skill-enforcement.json`, rejects unclosed routes in `-Mode validate` unless `-AllowIncomplete` is explicitly passed, strips text-only aliases (`ui-ux-pro-max`, `taste-skill`) from `ui-design` image-generator aliases, detects YAML `#` truncation & escaping skill links in `eval-skills.ps1`, and enforces CI execution of all regression suites in `.github/workflows/validate-package.yml`.

---

## 2. Core Governance Modules

The V6.9.3 line is supported by the complete modular suite of governance rules:

### 2.1 Entry & Master Logic
- `modules/01_MasterLogic.md`, `modules/03_AgenticLoop.md`, `modules/12_AgentEnforcement.md`, `modules/13_MandatoryLogicGateTemplate.md`, `modules/15_LogicEntryChecklist.md`.

### 2.2 System & Code Mapping
- `modules/11_CrossDirectoryMap.md`, `modules/40_AgentLogicSystemMap.md`, `modules/45_V6_8_GraphifyCodeMapIntegration.md`, `modules/46_V6_8_ProjectKnowledgeSync.md`.

### 2.3 Tool Execution, Risk & Verification
- `modules/05_PermissionsAndSafety.md`, `modules/21_V6_5_ToolUsageAndSelection.md`, `modules/23_V6_5_PermissionAndOutputPipeline.md`, `modules/24_V6_5_ToolUsageMatrix.md`, `modules/25_V6_5_ToolCapabilityMapping.md`, `modules/27_V6_5_ToolPermissionRiskMatrix.md`, `modules/29_MandatoryVerificationMatrix.md`, `modules/30_ToolQuestionBoundaryMatrix.md`, `modules/31_ToolMisuseAndAntiPatternMatrix.md`.

### 2.4 Domain, Skill Routing & V6.9 Creative/Role Modules
- `modules/35_V6_5_SkillGovernanceAndMandatoryUse.md`, `modules/36_V6_5_SkillZoneSeparation.md`, `modules/37_V6_6_CybersecuritySkillsRouter.md`, `modules/38_V6_6_SpecDrivenDevelopment.md`, `modules/39_V6_6_TasteFrontendDesign.md`, `modules/41_V6_7_AIShippingAndReviewabilityAudit.md`, `modules/42_V6_7_PonytailLazySeniorDevLadder.md`, `modules/43_V6_7_MattPocockSkillsIntegration.md`, `modules/44_V6_8_GrokBuildOperationalIntegration.md`, `modules/47_V6_8_ReferenceToInterfaceWorkflow.md`, `modules/48_V6_8_SkillAndToolRouting.md`, `modules/49_V6_8_AutonomousSkillEnforcement.md`, `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`, `modules/51_V6_8_AffordanceFirstToolUse.md`, `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`, `modules/53_V6_8_ProgrammingLevelSkillEnforcement.md`, `modules/54_V6_9_RoleAndMultimodalCreativeGovernance.md`.

---

## 3. Stable Promotion Summary

- **Stable Entry**: `MAIN.md`
- **Current Version**: `V6.9.3`
- **Default Profile**: `core-enhanced`

---

## 4. Reference Source Registration

The V6.9.3 stable line integrates the following external source repositories:

- **Cybersecurity Skills Router**:
  - Source URL: `https://github.com/zhaoxuya520/reverse-skill`
  - Integration path: `skills/reverse-skill/`
- **Spec Kit**:
  - Source URL: `https://github.com/github/spec-kit`
  - Integration path: `spec-kit/`
- **Taste Skill**:
  - Source URL: `https://github.com/Leonxlnx/taste-skill`
  - Integration path: `skills/taste-skill/`
- **Agent Browser**:
  - Source URL: `https://github.com/vercel-labs/agent-browser`
  - Integration path: `skills/agent-browser/`
- **Nano Banana Pro**:
  - Source URL: `https://ai.google.dev/`
  - Integration path: `skills/nano-banana-pro/`
- **Self-Improvement Agent**:
  - Source URL: `https://github.com/peterskoett/self-improving-agent`
  - Integration path: `skills/self-improvement/`
- **Ponytail**:
  - Source URL: `https://github.com/DietrichGebert/ponytail`
  - Integration path: `skills/ponytail/`
- **Matt Pocock Skills**:
  - Source URL: `https://github.com/mattpocock/skills`
  - Integration path: `skills/productivity/grilling/`, `skills/productivity/grill-me/`, `skills/engineering/grill-with-docs/`
- **Grok Build (comparative reference)**:
  - Source URL: `https://github.com/xai-org/grok-build`
  - Integration path: `modules/44_V6_8_GrokBuildOperationalIntegration.md`
- **Graphify (external code-map reference)**:
  - Source URL: `https://github.com/Graphify-Labs/graphify`
  - Integration path: `modules/45_V6_8_GraphifyCodeMapIntegration.md`
- **MengTo Skills (workflow comparison)**:
  - Source URL: `https://github.com/MengTo/Skills`
  - Integration path: `modules/47_V6_8_ReferenceToInterfaceWorkflow.md`
- **OfficeCLI (Office-document workflow comparison)**:
  - Source URL: `https://github.com/iOfficeAI/OfficeCLI`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`, `skills/productivity/office-pro-suite/SKILL.md`
- **PixelRAG (visual-document workflow comparison)**:
  - Source URL: `https://github.com/StarTrail-org/PixelRAG`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
- **Firecrawl (external-collection workflow comparison)**:
  - Source URL: `https://github.com/firecrawl/firecrawl`
  - Integration path: `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
- **img2threejs (interactive 3D-web workflow comparison)**:
  - Source URL: `https://github.com/img2threejs/img2threejs`
  - Integration path: `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`
- **Reverse Engineer Anything (REA — decompilation & clean-room reconstruction reference)**:
  - Source URL: `https://github.com/morluto/rea`
  - Integration path: `skills/engineering/decompile-reconstruction/SKILL.md`
- **GhidraMCP (headless binary decompilation reference)**:
  - Source URL: `https://github.com/LaurieWired/GhidraMCP`
  - Integration path: `skills/engineering/decompile-reconstruction/SKILL.md`
- **Anthropic Official Claude Plugins (`code-simplifier` reference)**:
  - Source URL: `https://github.com/anthropics/claude-plugins-official`
  - Integration path: `skills/engineering/code-simplifier/SKILL.md`
- **ast-grep (structural AST search & rewrite reference)**:
  - Source URL: `https://github.com/ast-grep/ast-grep`
  - Integration path: `skills/engineering/code-simplifier/SKILL.md`
- **Superpowers (test-verified refactoring loop reference)**:
  - Source URL: `https://github.com/obra/superpowers`
  - Integration path: `skills/engineering/code-simplifier/SKILL.md`
- **UI/UX Pro Max Skill (pure UI/UX design-system intelligence reference)**:
  - Source URL: `https://github.com/nextlevelbuilder/ui-ux-pro-max-skill`
  - Integration path: `skills/design/ui-ux-pro-max/SKILL.md`
- **Modern Web Guidance (`GoogleChrome/modern-web-guidance` — Apache-2.0 209 web platform guides, `legacy-scan`, & Chrome Extension MV3 references)**:
  - Source URL: `https://github.com/GoogleChrome/modern-web-guidance`
  - Integration path: `skills/frontend/modern-web-guidance/SKILL.md`, `skills/frontend/chrome-extensions/SKILL.md`
- **Google Cloud GenMedia Creative Studio (Imagen / Veo / Lyria multimodal reference)**:
  - Source URL: `https://github.com/GoogleCloudPlatform/vertex-ai-creative-studio`
  - Integration path: `skills/creative/multimodal-media-director/SKILL.md`
- **EachLabs Multimodal Agent Skills (image / video / music workflow reference)**:
  - Source URL: `https://github.com/eachlabs/skills`
  - Integration path: `skills/creative/multimodal-media-director/SKILL.md`
- **MiniMax MCP (Hailuo Video & MiniMax Music MCP reference)**:
  - Source URL: `https://github.com/MiniMax-AI/MiniMax-MCP`
  - Integration path: `skills/creative/multimodal-media-director/SKILL.md`
- **Claude Image Gen (reference-guided image generation reference)**:
  - Source URL: `https://github.com/guinacio/claude-image-gen`
  - Integration path: `skills/creative/multimodal-media-director/SKILL.md`
- **Anthropic Official Document Skills (`docx`, `xlsx`, `pptx` standardization reference)**:
  - Source URL: `https://github.com/anthropics/skills`
  - Integration path: `skills/productivity/office-pro-suite/SKILL.md`
- **The Agency (`agency-agents` specialist persona reference)**:
  - Source URL: `https://github.com/msitarzewski/agency-agents`
  - Integration path: `skills/productivity/role-persona-router/SKILL.md`
- **BMAD-METHOD (multi-role agile orchestration reference)**:
  - Source URL: `https://github.com/bmad-code-org/BMAD-METHOD`
  - Integration path: `skills/productivity/role-persona-router/SKILL.md`
- **Oh-Story ClaudeCode (web-novel & anti-AI-slop fiction reference)**:
  - Source URL: `https://github.com/zenstory-ai/oh-story-claudecode`
  - Integration path: `skills/creative/novel-story-architect/SKILL.md`
- **Story Skills (Story Bible continuity compiler reference)**:
  - Source URL: `https://github.com/danjdewhurst/story-skills`
  - Integration path: `skills/creative/novel-story-architect/SKILL.md`
- **Awesome Novel Studio (5-stage narrative beat pipeline reference)**:
  - Source URL: `https://github.com/MJbae/awesome-novel-studio`
  - Integration path: `skills/creative/novel-story-architect/SKILL.md`
- **Draw.io Official MCP & Skill (`jgraph/drawio-mcp` reference)**:
  - Source URL: `https://github.com/jgraph/drawio-mcp`
  - Integration path: `skills/engineering/diagram-flowchart-architect/SKILL.md`
- **Agents365 Draw.io Architecture Skill (`Agents365-ai/drawio-skill` reference)**:
  - Source URL: `https://github.com/Agents365-ai/drawio-skill`
  - Integration path: `skills/engineering/diagram-flowchart-architect/SKILL.md`
- **Excalidraw Diagram Skill (`coleam00/excalidraw-diagram-skill` reference)**:
  - Source URL: `https://github.com/coleam00/excalidraw-diagram-skill`
  - Integration path: `skills/engineering/diagram-flowchart-architect/SKILL.md`
- **OpenAI Plugins (`openai/plugins` — MIT / Apache-2.0 skills & Codex plugin packaging; Proprietary plugins referenced clean-room only)**:
  - Source URL: `https://github.com/openai/plugins`
  - Integration path: `skills/frontend/web-data-visualization/SKILL.md`, `skills/engineering/skill-evaluator/SKILL.md`, `skills/frontend/web-game-studio/SKILL.md`, `scripts/build-codex-plugin.ps1`, `modules/39_V6_6_TasteFrontendDesign.md`
- **OpenAI Skills (`openai/skills` — Apache-2.0 curated AppSec, GitHub PR/CI, and PDF workflows; upstream repo noted as deprecated)**:
  - Source URL: `https://github.com/openai/skills`
  - Integration path: `skills/engineering/appsec-review/SKILL.md`, `skills/engineering/gh-pr-ci-triage/SKILL.md`, `skills/productivity/office-pro-suite/SKILL.md`
- **Drama Skills (`zenstory-ai/drama-skills` — MIT AI short-drama & motion-comic 12-stage workflow & independent cross-shot review)**:
  - Source URL: `https://github.com/zenstory-ai/drama-skills`
  - Integration path: `skills/creative/screenplay-manga-director/SKILL.md`, `skills/creative/screenplay-manga-director/references/production-checklists.md`
- **Shuohao Skills (`eternityspring/shuohao-skills` — Apache-2.0 opening spatial blocking `novel-staging` & single-root character anchor sheets `character-refs`)**:
  - Source URL: `https://github.com/eternityspring/shuohao-skills`
  - Integration path: `skills/creative/screenplay-manga-director/SKILL.md`, `skills/creative/screenplay-manga-director/references/production-checklists.md`
- **Muse Video Skill (`LuoJiangYong/muse-video-skill` — MIT six-role virtual film-crew Subagent squad, asset-ID reference chain & 6-part prompt compilation)**:
  - Source URL: `https://github.com/LuoJiangYong/muse-video-skill`
  - Integration path: `skills/creative/screenplay-manga-director/SKILL.md`, `skills/creative/screenplay-manga-director/references/production-checklists.md`
- **ManjuForge (`mengxiujie/ManjuForge` — MIT-0 serialized comic-drama memory, identity invariants vs state variables & Foreshadow Engine)**:
  - Source URL: `https://github.com/mengxiujie/ManjuForge`
  - Integration path: `skills/creative/screenplay-manga-director/SKILL.md`, `skills/creative/screenplay-manga-director/references/production-checklists.md`
- **Hand-Drawn Video Prompts (`kaomei/hand-drawn-video-prompts` — MIT 9:16 vertical hand-drawn/chibi storyboard & animation prompt discipline)**:
  - Source URL: `https://github.com/kaomei/hand-drawn-video-prompts`
  - Integration path: `skills/creative/screenplay-manga-director/SKILL.md`

---

## 5. Skill-System Integration & Cross-Host Execution Rule

V6.9.3 enforces identical automatic routing across Antigravity (`~/.gemini/GEMINI.md` + `AGENTS_BUNDLE.md`), Claude Code (`~/.claude/CLAUDE.md` + `~/.claude/AgentLogic/CLAUDE.md`), OpenAI Codex (`~/.codex/agentlogic/model_instructions.md`), and Generic bundles (`dist/generic/AGENTLOGIC.md`):
- Every new project starts with **Gate 1 (Context-Reset + 11-Role Recommendation & Optional Subagent Squad)** via `role-persona-router` and `contracts/role-personas.json`.
- Every new UI or substantial UI refactor passes **Gate 2 (`product-requirements-grilling` $\rightarrow$ `ui-ux-pro-max` pure design specification $\rightarrow$ text-to-image mockup preview $\rightarrow$ user approval $\rightarrow$ side-by-side Design QA)** before and after UI code is written.
- Every encountered domain task activates its matching first-party skill automatically via the **Skill-First Reflex Habit** (`decompile-reconstruction`, `code-simplifier`, `office-pro-suite`, `multimodal-media-director`, `novel-story-architect`, `screenplay-manga-director`, `diagram-flowchart-architect`, `modern-web-guidance`, `chrome-extensions`, `appsec-review`, `web-data-visualization`, `web-game-studio`, `gh-pr-ci-triage`, `skill-evaluator`) without manual skill selection.
