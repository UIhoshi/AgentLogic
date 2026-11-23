# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [Parameter(Mandatory)][ValidateSet('antigravity', 'claude', 'codex')][string]$TargetHost,
    [Parameter(Mandatory)][string]$TargetPath,
    [Parameter(Mandatory)][string]$RepoRoot,
    [Parameter(Mandatory)][string]$BundlePath,
    [Parameter(Mandatory)][string]$SkillsRoot,
    [Parameter(Mandatory)][string]$EnforcementRoot,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = 'Stop'

$beginMarker = '<!-- BEGIN AGENTLOGIC HOOK -->'
$endMarker = '<!-- END AGENTLOGIC HOOK -->'

$repoRootUri = $RepoRoot.Replace('\', '/')
$bundlePathUri = $BundlePath.Replace('\', '/')
$enforcementScriptUri = ([IO.Path]::Combine($EnforcementRoot, 'scripts', 'skill-enforcement.ps1')).Replace('\', '/')
$rolePersonasUri = ([IO.Path]::Combine($EnforcementRoot, 'contracts', 'role-personas.json')).Replace('\', '/')
$skillsRootUri = $SkillsRoot.Replace('\', '/')
$bundleFileName = Split-Path -Leaf $BundlePath

$emDash = [regex]::Unescape('\u2014')
$zhStartupPrompt = [regex]::Unescape('\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002')
$zhSkipMockup = [regex]::Unescape('\u4e0d\u9700\u8981\u5148\u753b\u56fe')

$hookTemplate = @'
<!-- BEGIN AGENTLOGIC HOOK -->
# Local AgentLogic Precedence Rule

- The agent MUST prioritize the local AgentLogic rule-set (located at [AgentLogic](file:///__REPO_ROOT_URI__)) as the highest-priority logic and execute its mandatory reading chain and blocking gates first.
- Full reference rules and contracts live on disk in [__BUNDLE_FILENAME__](file:///__BUNDLE_PATH_URI__) and [role-personas.json](file:///__ROLE_PERSONAS_URI__). Read them on demand rather than duplicating them inline; the four non-negotiable blocking gates and automatic skill triggers are inlined directly below and MUST be executed in every workspace:

## Gate 1: Startup Context-Reset & Autonomous Role Recommendation Gate (Turn 1 Blocking __EM_DASH__ Formal Projects)
- **EXECUTION vs SUMMARIZATION MANDATE**: You MUST NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or formal non-continuation task (coding, planning, UI, creative, Office, or audit __EM_DASH__ trivial single-turn read-only Q&A with no edits or artifacts may answer directly), you MUST ACTUALLY EXECUTE BOTH steps below interactively:
  1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to `forget/compress context` in the user's interaction language:
     - Chinese: "__ZH_STARTUP_PROMPT__"
     - English: "Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context."
  2. **Autonomous Role Recommendation & Dual-Axis Subagent Squads ([role-persona-router](file:///__SKILLS_ROOT_URI__/role-persona-router/SKILL.md))**:
     - Analyze the user's project/task, **recommend the #1 best-fit Lead Role (with a 1-sentence rationale)** (plus a 1-line **Supporting Subagent Squad** ONLY when cross-domain/multi-module complexity warrants it), and display the compact 11-role selection menu so the user can approve or switch roles:
       - `[1] Principal Systems Architect & Full-Stack Lead`
       - `[2] UI/UX Creative Design Director & Frontend Craftsman`
       - `[3] Reverse Engineering & Clean-Room Reconstruction Specialist`
       - `[4] Management Consultant & Financial/Office Architect`
       - `[5] Multimodal Creative Director (Image / Video / Code Video / Music)`
       - `[6] Chief Showrunner & Long-Form Novel Architect`
       - `[7] Enterprise Architecture & Flowchart Cartographer`
       - `[8] AppSec & DevSecOps Security Guardian`
       - `[9] Data Analytics & Visualization Architect`
       - `[10] Interactive Game & Creative Graphics Lead`
       - `[11] Screenwriter, Manga-Script & Short-Video Showrunner`
     - **Subagent Role Assignment**: When spawning any subagent in complex tasks, assign BOTH Axis A (`explore|plan|implement|review|verify`) and Axis B (`[1]`-`[11]` or `codebase-explorer` / `independent-verifier`), propagate required `SKILL.md` paths (`Bound Skills`), enforce disjoint write ownership, and keep `max_depth = 1`.
- To prevent the "limited initial view" issue, proactively scan the `AgentLogic` directory or read [__BUNDLE_FILENAME__](file:///__BUNDLE_PATH_URI__) on demand when deeper module rules are needed.

## Gate 2: Pure UI Design (`ui-ux-pro-max`) + Mandatory Text-to-Image Mockup Gate (BLOCKING Before Any UI Code)
- **WHEN TRIGGERED**: Whenever starting a new project with a UI, adding a net-new page/screen/component, or performing a substantial UI refactor/redesign.
- **HARD BLOCK**: You MUST NOT write or edit production UI/frontend code (`.html`, `.css`, `.scss`, `.jsx`, `.tsx`, `.vue`, `.svelte`, or UI layout/style blocks) until ALL of the following steps are completed, **UNLESS the user explicitly opts out** (e.g., explicitly says "__ZH_SKIP_MOCKUP__" / "skip mockup"):
  1. **Single-Question Requirements Grilling**: Read and follow [product-requirements-grilling](file:///__SKILLS_ROOT_URI__/product-requirements-grilling/SKILL.md). Ask one unresolved product/UI decision question at a time, write `.specify/<task>/requirements-brief.md`, and obtain user approval.
  2. **Pure UI/UX Design Specification First ([ui-ux-pro-max](file:///__SKILLS_ROOT_URI__/ui-ux-pro-max/SKILL.md))**:
     - Before generating any mockup or writing any code, run `ui-ux-pro-max` to derive the **Structured Visual Design Specification** (domain aesthetic archetype, exact HSL/Hex palette, typography pairing, spatial grid & whitespace density).
  3. **Mandatory Text-to-Image Mockup Generation (`image-generator` / [multimodal-media-director](file:///__SKILLS_ROOT_URI__/multimodal-media-director/SKILL.md) / `nano-banana-pro`)**:
     - Combine the `ui-ux-pro-max` design specification into a high-precision visual prompt and invoke your host's text-to-image generator (`image-generator`, `imagegen`, or `nano-banana-pro`) to generate the visual UI mockup image.
     - Save/copy the generated mockup image to `.specify/mockups/` (or artifact directory), present both the **Design Specification** and **Mockup Image** to the user, and wait for user approval before writing UI implementation code.
  4. **Workflow State Recording**: Record route progression (`requirements-grilling` -> `design-direction` -> `ui-design` -> `ui-implementation`) using [skill-enforcement.ps1](file:///__ENFORCEMENT_SCRIPT_URI__).
  5. **Real-World Visual & Motion Reference Grounding & Side-by-Side Design QA**:
     - **Real-World Existing Subject** (e.g., globe, zebra, animal, anatomy, landmark, real mechanism): NEVER draw or animate from blind text priors or text-only `search_web` summaries. First download real reference photos AND real GIF/short video/gait references locally (e.g., `references/media/`) and visually inspect them via `read_file` to extract continuous anatomical silhouettes, joint musculature, pattern flow, and keyframe phases before writing SVG/Canvas/CSS/JS animation code (avoid bare ovals + stick-puppet tube limbs).
     - **Non-Existent / Purely Abstract Subject**: Proceed directly to creative design without mandatory real-world reference lookup.
     - **Side-by-Side Design QA**: Compare the approved mockup/source visual and the rendered implementation screenshot side-by-side at matching viewports (`?t=` for animations); fix any P0/P1/P2 gap before claiming completion.

## Gate 3: Skill-First Reflex & Auto-Use Domain Capabilities (Zero Manual Skill Selection)
- **SKILL-FIRST REFLEX HABIT (NON-NEGOTIABLE)**: Never wait for the user to name a skill. Before writing code, designing UI/charts, reviewing security/PRs, creating Office/PDF/media/games, or auditing skills, ALWAYS run a 3-second Scenario -> Skill scan. On ANY match, immediately read its `SKILL.md`, announce `[Skill Activated: <name>]`, and execute it by default (chaining multiple skills when a task spans domains) __EM_DASH__ never improvise from memory:
  1. **Compiled Binaries, Bytecode, or Obfuscated Bundles** -> [decompile-reconstruction](file:///__SKILLS_ROOT_URI__/decompile-reconstruction/SKILL.md) (IDA/Ghidra/`jadx`/`ilspycmd`/`pycdc`/`webcrack` -> clean-room source).
  2. **Post-Implementation Polish & Code Refactoring** -> [code-simplifier](file:///__SKILLS_ROOT_URI__/code-simplifier/SKILL.md) (green baseline -> guard clauses -> `ast-grep` (`sg`) rewrites -> zero regression).
  3. **Word (`.docx`), Excel (`.xlsx`), PowerPoint (`.pptx`), & PDF (`.pdf`)** -> [office-pro-suite](file:///__SKILLS_ROOT_URI__/office-pro-suite/SKILL.md) (Word styles/three-line tables; Excel live formulas + tie-out QA; 16:9 action-title PPT + QC; PDF `pdftoppm` visual inspection).
  4. **Text-to-Image, Text-to-Video, Programmatic Video, & Music** -> [multimodal-media-director](file:///__SKILLS_ROOT_URI__/multimodal-media-director/SKILL.md) (Imagen/Gemini/Flux; Veo/Kling/Hailuo storyboards; Remotion/HyperFrames code video; Lyria/MiniMax/Suno).
  5. **Long-Form Novel, Fiction, & Script Writing** -> [novel-story-architect](file:///__SKILLS_ROOT_URI__/novel-story-architect/SKILL.md) (`.story-bible/` continuity compiler, scene beats, anti-AI-cliche filter).
  6. **Flowcharts, Swimlanes, & System Architecture Diagrams** -> [diagram-flowchart-architect](file:///__SKILLS_ROOT_URI__/diagram-flowchart-architect/SKILL.md) (`.drawio` XML, `.excalidraw` JSON, themed `Mermaid`).
  7. **Modern Web Frontend (HTML / CSS / DOM / Client-Side JS / CWV / A11y)** -> [modern-web-guidance](file:///__SKILLS_ROOT_URI__/modern-web-guidance/SKILL.md) (query `npx -y modern-web-guidance@latest` or local `guides/` FIRST, and `legacy-scan` for modernization).
  8. **Chrome / Browser Extensions (Manifest V3 & Chrome Web Store)** -> [chrome-extensions](file:///__SKILLS_ROOT_URI__/chrome-extensions/SKILL.md) (MV3 service workers, side panels, CSP sandboxes, store compliance).
  9. **Security Review, Diff Audit, Threat Model, & Ownership Map** -> [appsec-review](file:///__SKILLS_ROOT_URI__/appsec-review/SKILL.md) (diff-scoped reachability, `SECURITY.md` policy, `confirmed`/`not_actionable`/`needs_review` verdicts, STRIDE).
  10. **Web Data Visualization (Charts / Dashboards / Maps / D3 / Vega / Canvas2D)** -> [web-data-visualization](file:///__SKILLS_ROOT_URI__/web-data-visualization/SKILL.md) (truthful encodings, dual desktop/mobile views, URL state, a11y).
  11. **2D / 3D Browser Games (Phaser / Canvas2D / Three.js / R3F)** -> [web-game-studio](file:///__SKILLS_ROOT_URI__/web-game-studio/SKILL.md) (modular `core/entities/ui`, asset pipeline, browser playtest loop).
  12. **GitHub Actions CI Failures & PR Review Threads (`gh` CLI)** -> [gh-pr-ci-triage](file:///__SKILLS_ROOT_URI__/gh-pr-ci-triage/SKILL.md) (check `gh auth status`, inspect failed logs, plan before fixing).
  13. **Skill & Plugin Quality / Token-Budget Evaluation** -> [skill-evaluator](file:///__SKILLS_ROOT_URI__/skill-evaluator/SKILL.md) (`At a Glance` / `Fix First` audit, frontmatter/links/token budget).
  14. **Manga/Webtoon Scripts, Short-Video/Micro-Drama Scripts, & Screenplays** -> [screenplay-manga-director](file:///__SKILLS_ROOT_URI__/screenplay-manga-director/SKILL.md) (panel breakdown, 0-3s hook multi-track table, `INT./EXT.` format, `.story-bible/` & media handoff).

## Gate 4: Project-Native Knowledge Sync & Verification Matrix
- Before business-project implementation, run `git fetch --prune` (when available) and read the project's tracked `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. Update `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md` in the same commit as structural, key-flow, or error-lesson changes.
- After UI implementation, always verify visual rendering, container/layout boundaries, and overflow using browser/screenshot evidence before claiming completion.
<!-- END AGENTLOGIC HOOK -->
'@

$hookContent = $hookTemplate.
    Replace('__REPO_ROOT_URI__', $repoRootUri).
    Replace('__BUNDLE_FILENAME__', $bundleFileName).
    Replace('__BUNDLE_PATH_URI__', $bundlePathUri).
    Replace('__ROLE_PERSONAS_URI__', $rolePersonasUri).
    Replace('__ENFORCEMENT_SCRIPT_URI__', $enforcementScriptUri).
    Replace('__SKILLS_ROOT_URI__', $skillsRootUri).
    Replace('__EM_DASH__', $emDash).
    Replace('__ZH_STARTUP_PROMPT__', $zhStartupPrompt).
    Replace('__ZH_SKIP_MOCKUP__', $zhSkipMockup).Trim()

$parentDir = Split-Path -Parent $TargetPath
if ($parentDir -and -not (Test-Path -LiteralPath $parentDir)) {
    New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
if (-not (Test-Path -LiteralPath $TargetPath)) {
    Write-Host "Creating bounded AgentLogic hook at '$TargetPath'..." -ForegroundColor Cyan
    [System.IO.File]::WriteAllText($TargetPath, ($hookContent + "`n"), $utf8NoBom)
    exit 0
}

$existing = [System.IO.File]::ReadAllText($TargetPath, $utf8NoBom)
$beginIdx = $existing.IndexOf($beginMarker, [System.StringComparison]::Ordinal)
$endIdx = $existing.IndexOf($endMarker, [System.StringComparison]::Ordinal)

if ($beginIdx -ge 0 -and $endIdx -gt $beginIdx) {
    $afterEnd = $endIdx + $endMarker.Length
    $before = $existing.Substring(0, $beginIdx).TrimEnd("`r", "`n")
    $after = $existing.Substring($afterEnd).TrimStart("`r", "`n")
    $parts = @()
    if (-not [string]::IsNullOrWhiteSpace($before)) { $parts += $before }
    $parts += $hookContent
    if (-not [string]::IsNullOrWhiteSpace($after)) { $parts += $after }
    $updated = ($parts -join "`n`n") + "`n"
    Write-Host "Updating bounded AgentLogic hook in '$TargetPath'..." -ForegroundColor Cyan
    [System.IO.File]::WriteAllText($TargetPath, $updated, $utf8NoBom)
    exit 0
}

if ($UserHome) {
    $backupDir = [IO.Path]::Combine($UserHome, '.agentlogic-backup', (Get-Date -Format 'yyyyMMdd-HHmmss'))
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    $bakName = ("{0}.{1}.bak" -f $TargetHost, (Split-Path -Leaf $TargetPath))
    Copy-Item -LiteralPath $TargetPath -Destination (Join-Path $backupDir $bakName) -Force
    Write-Host "Backed up existing '$TargetPath' to '$(Join-Path $backupDir $bakName)'." -ForegroundColor Yellow
}

$legacyHookIdx = $existing.IndexOf('# Local AgentLogic Precedence Rule', [System.StringComparison]::Ordinal)
$legacyBundleIdx = $existing.IndexOf('# MANDATORY AGENT EXECUTIVE PROTOCOL (AgentLogic', [System.StringComparison]::Ordinal)

if ($legacyHookIdx -ge 0) {
    $before = $existing.Substring(0, $legacyHookIdx).TrimEnd("`r", "`n")
    $updated = if ([string]::IsNullOrWhiteSpace($before)) { $hookContent + "`n" } else { $before + "`n`n" + $hookContent + "`n" }
} elseif ($legacyBundleIdx -eq 0 -or ($TargetHost -eq 'codex' -and (Split-Path -Leaf $TargetPath) -eq 'model_instructions.md')) {
    $updated = $hookContent + "`n"
} else {
    $trimmed = $existing.TrimEnd()
    $updated = if ([string]::IsNullOrWhiteSpace($trimmed)) { $hookContent + "`n" } else { $trimmed + "`n`n" + $hookContent + "`n" }
}

[System.IO.File]::WriteAllText($TargetPath, $updated, $utf8NoBom)
Write-Host "Installed bounded AgentLogic hook into '$TargetPath'." -ForegroundColor Green
