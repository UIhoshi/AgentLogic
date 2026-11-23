# Project Map

## L1 — Entry & Surface
- Entrypoints: `00_START_HERE.md`, `AGENTS.md`, `MAIN.md`, and `README.md`.
- User/API/CLI surfaces: host adapters (`codex`, `claude`, `antigravity`, `generic`), `install.ps1`, `install.sh`, `scripts/install.js` (pure Node.js cross-platform installer), `scripts/install-hook.ps1` (~11 KB bounded non-destructive host hooks), and generated `dist/` bundles (`V6.9.3`).

## L2 — Flow & Lifecycle
- Core flows: Turn 1 entry + autonomous role recommendation gate (`role-persona-router`) → task classification → project/code map consultation or refresh → applicable SDD / domain auto-skill execution / verification → profile build.
- State and task lifecycle: `.specify/` contains scoped specification, plan, tasks, and ship records.
- Key modules: `modules/01_MasterLogic.md`, Modules 29–31, 35, 38–39, 41, 44–54.

## L3 — Control & Verification
- Controls: permissions, tool-permission risk gates, extension trust, Turn 1 autonomous role selection, pure UI/UX design (`ui-ux-pro-max`) coupled with mandatory text-to-image mockup preview, encounter-driven auto-use routes (`decompile-reconstruction`, `code-simplifier`, `office-pro-suite`, `multimodal-media-director`, `novel-story-architect`, `diagram-flowchart-architect`), graph-derived route dependencies, artifact-path/hash integrity checks, guided catalog query, workflow enforcement, package validation, and entry-gate checks.
- Validation commands: `node scripts/check-logic-entry.js`; `scripts/eval-skills.ps1`; `scripts/audit-skill-duplicates.ps1`; `scripts/validate-skill-registry.ps1`; `scripts/test-skill-registry.ps1`; `scripts/validate-skill-routing.ps1`; `scripts/validate-skill-workflow-graph.ps1`; `scripts/test-skill-workflow-graph.ps1`; `scripts/test-skill-enforcement.ps1`; `scripts/validate-package.ps1`; and
  `scripts/maintainer-check.ps1` for release-level changes.

## L4 — Base & Dependencies
- Base assets: `skills/` (164 registered portable skills including 17 first-party auto-deployed skills), `contracts/role-personas.json` (11 orthogonal Lead Roles + 2 universal Subagent functional roles), `spec-kit/`, `manifest.json`, scripts, generated `dist/` bundles, and standard Codex plugin output (`dist/codex-plugin/` via `scripts/build-codex-plugin.ps1`).
- External comparison sources are policy-only unless explicitly installed and trusted. Requested
  `.docx`, `.xlsx`, `.pptx`, and `.pdf` processing routes through `office-pro-suite` (and `OfficeCLI` when installed).
- `img2threejs` is a review-required optional source candidate for approved reference-image
  reconstruction in interactive 3D webpages; it is not an installed host skill.

## Unconfirmed Points
- [ ] No host-local availability of optional browser, screenshot, security, or profiling skills is
  implied by this repository map.

- Autonomous routing: contracts/skill-routing.json and Modules 49 & 54 define 26 canonical capabilities, the Skill-First Reflex Habit, strict gaps, software-candidate reporting, and a single scoped consent bundle for disclosed installation prerequisites without waiving audits or host permissions.

- Product/UI discovery & pure design coupling: `skills/productivity/product-requirements-grilling/` produces a user-approved requirements brief; `skills/design/ui-ux-pro-max/` derives a pure UI/UX design specification (palettes, typography, spatial grid), couples directly with text-to-image mockup generation before UI implementation, and closes with side-by-side Design QA.

- Cross-host parity & 17 first-party skills deployment: `contracts/host-skill-capabilities.json` and `scripts/deploy-first-party-skill.ps1` require every adapter (`codex`, `claude`, `antigravity`, `generic`) to deploy `product-requirements-grilling`, `role-persona-router`, `ui-ux-pro-max`, `multimodal-media-director`, `office-pro-suite`, `novel-story-architect`, `screenplay-manga-director`, `diagram-flowchart-architect`, `code-simplifier`, `decompile-reconstruction`, `modern-web-guidance`, `chrome-extensions`, `appsec-review`, `web-data-visualization`, `gh-pr-ci-triage`, `skill-evaluator`, and `web-game-studio`, and embed identical Gates 1–3 (11-role menu + dual-axis Subagent squads + Skill-First Reflex) in every host bundle and global entry hook (`~/.gemini/GEMINI.md`, `~/.claude/CLAUDE.md`, `~/.codex/agentlogic/model_instructions.md`).
