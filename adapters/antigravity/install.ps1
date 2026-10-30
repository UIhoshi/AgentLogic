# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"
$skillsGovernanceScript = Join-Path $repoRoot "scripts\skills-governance.ps1"
$deploySkillScript = Join-Path $repoRoot "scripts\deploy-first-party-skill.ps1"
$deployEnforcementScript = Join-Path $repoRoot 'scripts\deploy-skill-enforcement.ps1'
$skillsRoot = Join-Path $UserHome '.gemini\skills'
$productSkillTarget = Join-Path $skillsRoot 'product-requirements-grilling'
$enforcementTarget = Join-Path $UserHome '.gemini\antigravity-cli\AgentLogic\skill-enforcement'

if (-not $TargetPath) {
    $TargetPath = Join-Path $UserHome ".gemini\GEMINI.md"
}

$bundlePath = Join-Path $UserHome ".gemini\antigravity-cli\AgentLogic\AGENTS_BUNDLE.md"
$bundleDir = Split-Path -Parent $bundlePath
if ($bundleDir) {
    New-Item -ItemType Directory -Force -Path $bundleDir | Out-Null
}

# 1. Build the profile bundle to the dedicated bundle path
powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost antigravity -OutputPath $bundlePath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-skill-enforcement.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget -Verify
if ($LASTEXITCODE -ne 0) { throw "Skill enforcement payload verification failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost antigravity -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

# 2. Ensure ~/.gemini/config/skills.json registers ~/.gemini/skills so deployed skills are discoverable across all workspaces
$configSkillsPath = Join-Path $UserHome ".gemini\config\skills.json"
$configSkillsDir = Split-Path -Parent $configSkillsPath
if ($configSkillsDir -and -not (Test-Path -LiteralPath $configSkillsDir)) {
    New-Item -ItemType Directory -Force -Path $configSkillsDir | Out-Null
}
$skillsEntryPath = "~/.gemini/skills"
$skillsConfigObj = $null
if (Test-Path -LiteralPath $configSkillsPath) {
    try {
        $rawSkillsJson = Get-Content -Raw -Encoding UTF8 -LiteralPath $configSkillsPath
        if (-not [string]::IsNullOrWhiteSpace($rawSkillsJson)) {
            $skillsConfigObj = $rawSkillsJson | ConvertFrom-Json
        }
    } catch {
        $skillsConfigObj = $null
    }
}
if (-not $skillsConfigObj) {
    $skillsConfigObj = [pscustomobject]@{ entries = @([pscustomobject]@{ path = $skillsEntryPath }) }
} else {
    $existingEntries = @()
    if ($skillsConfigObj.PSObject.Properties.Name -contains 'entries' -and $null -ne $skillsConfigObj.entries) {
        $existingEntries = @($skillsConfigObj.entries)
    }
    $alreadyRegistered = @($existingEntries | Where-Object { $_.path -eq $skillsEntryPath -or $_.path -eq (Join-Path $UserHome ".gemini\skills").Replace('\', '/') })
    if ($alreadyRegistered.Count -eq 0) {
        $existingEntries += [pscustomobject]@{ path = $skillsEntryPath }
        $skillsConfigObj | Add-Member -Force -NotePropertyName entries -NotePropertyValue @($existingEntries)
    }
}
[System.IO.File]::WriteAllText($configSkillsPath, ($skillsConfigObj | ConvertTo-Json -Depth 10), [System.Text.UTF8Encoding]::new($false))

# 3. Add / Update the delegation hook in target GEMINI.md without overwriting other content
$repoRootUri = $repoRoot.Replace('\', '/')
$bundlePathUri = $bundlePath.Replace('\', '/')
$enforcementScriptUri = (Join-Path $enforcementTarget 'scripts\skill-enforcement.ps1').Replace('\', '/')
$skillsRootUri = $skillsRoot.Replace('\', '/')

$emDash = [regex]::Unescape('\u2014')
$zhStartupPrompt = [regex]::Unescape('\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002')
$zhSkipMockup = [regex]::Unescape('\u4e0d\u9700\u8981\u5148\u753b\u56fe')

$hookTemplate = @'

# Local AgentLogic Precedence Rule

- The agent MUST prioritize the local AgentLogic rule-set (located at [AgentLogic](file:///__REPO_ROOT_URI__)) as the highest-priority logic and execute its mandatory reading chain and blocking gates first.
- The compiled master rules are stored in [AGENTS_BUNDLE.md](file:///__BUNDLE_PATH_URI__). Because Antigravity caps individual rule files at 24 KB, the four non-negotiable blocking gates and automatic skill triggers from `AGENTS_BUNDLE.md` are inlined directly below and MUST be executed in every workspace:

## Gate 1: Startup Context-Reset & Autonomous Role Recommendation Gate (Turn 1 Blocking __EM_DASH__ All Projects)
- **EXECUTION vs SUMMARIZATION MANDATE**: You MUST NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or non-continuation task, you MUST ACTUALLY EXECUTE BOTH steps below interactively:
  1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to `forget/compress context` in the user's interaction language:
     - Chinese: "__ZH_STARTUP_PROMPT__"
     - English: "Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context."
  2. **Autonomous Role Recommendation & Selection ([role-persona-router](file:///__SKILLS_ROOT_URI__/role-persona-router/SKILL.md))**:
     - Analyze the user's project/task, **recommend the #1 best-fit Lead Role (with a 1-sentence rationale)**, and display the compact 7-role selection menu so the user can approve or switch roles:
       - `[1] Principal Systems Architect & Full-Stack Lead`
       - `[2] UI/UX Creative Design Director & Frontend Craftsman`
       - `[3] Reverse Engineering & Clean-Room Reconstruction Specialist`
       - `[4] Management Consultant & Financial/Office Architect`
       - `[5] Multimodal Creative Director (Text-to-Image / Video / Music)`
       - `[6] Chief Showrunner & Long-Form Novel Architect`
       - `[7] Enterprise Architecture & Flowchart Cartographer`
- To prevent the "limited initial view" issue, proactively scan the `AgentLogic` directory or read [AGENTS_BUNDLE.md](file:///__BUNDLE_PATH_URI__) immediately upon startup.

## Gate 2: Pure UI Design (`ui-ux-pro-max`) + Mandatory Text-to-Image Mockup Gate (BLOCKING Before Any UI Code)
- **WHEN TRIGGERED**: Whenever starting a new project with a UI, adding a net-new page/screen/component, or performing a substantial UI refactor/redesign.
- **HARD BLOCK**: You MUST NOT write or edit production UI/frontend code (`.html`, `.css`, `.scss`, `.jsx`, `.tsx`, `.vue`, `.svelte`, or UI layout/style blocks) until ALL of the following steps are completed, **UNLESS the user explicitly opts out** (e.g., explicitly says "__ZH_SKIP_MOCKUP__" / "skip mockup"):
  1. **Single-Question Requirements Grilling**: Read and follow [product-requirements-grilling](file:///__SKILLS_ROOT_URI__/product-requirements-grilling/SKILL.md). Ask one unresolved product/UI decision question at a time, write `.specify/<task>/requirements-brief.md`, and obtain user approval.
  2. **Pure UI/UX Design Specification First ([ui-ux-pro-max](file:///__SKILLS_ROOT_URI__/ui-ux-pro-max/SKILL.md))**:
     - Before generating any mockup or writing any code, run `ui-ux-pro-max` to derive the **Structured Visual Design Specification** (domain aesthetic archetype, exact HSL/Hex palette, typography pairing, spatial grid & whitespace density).
  3. **Mandatory Text-to-Image Mockup Generation (`image-generator` / [multimodal-media-director](file:///__SKILLS_ROOT_URI__/multimodal-media-director/SKILL.md) / `nano-banana-pro`)**:
     - Combine the `ui-ux-pro-max` design specification into a high-precision visual prompt and invoke Antigravity's built-in **`image-generator` subagent** (`invoke_subagent` with `TypeName: "image-generator"`) or `nano-banana-pro` to generate the visual UI mockup image.
     - Save/copy the generated mockup image to `.specify/mockups/` (or artifact directory), present both the **Design Specification** and **Mockup Image** to the user, and wait for user approval before writing UI implementation code.
  4. **Workflow State Recording**: Record route progression (`requirements-grilling` -> `design-direction` -> `ui-design` -> `ui-implementation`) using [skill-enforcement.ps1](file:///__ENFORCEMENT_SCRIPT_URI__).

## Gate 3: Encounter -> Auto-Use Domain Capabilities (Zero Manual Skill Selection)
- **ZERO MANUAL SKILL SELECTION**: Never wait for the user to name a skill. Automatically read and execute the matching first-party skill when encountering any of the following tasks:
  1. **Compiled Binaries, Bytecode, or Obfuscated Bundles** -> [decompile-reconstruction](file:///__SKILLS_ROOT_URI__/decompile-reconstruction/SKILL.md) (orchestrating IDA Pro MCP `idapro_*`, Ghidra MCP/headless, `jadx`, `ilspycmd`, `pycdc`, `webcrack` -> clean-room source reconstruction).
  2. **Post-Implementation Polish & Code Refactoring** -> [code-simplifier](file:///__SKILLS_ROOT_URI__/code-simplifier/SKILL.md) (lock green baseline -> flatten nesting with guard clauses -> `ast-grep` (`sg`) structural rewrites -> verify zero behavior change).
  3. **Word (`.docx`), Excel (`.xlsx`), & PowerPoint (`.pptx`) Professional Design** -> [office-pro-suite](file:///__SKILLS_ROOT_URI__/office-pro-suite/SKILL.md) (executive typography & three-line/zebra tables in Word; live formulas & blue/black/green financial modeling standard in Excel; 16:9 action-title visual variety in PPT).
  4. **Text-to-Image, Text-to-Video, & Text-to-Music Generation** -> [multimodal-media-director](file:///__SKILLS_ROOT_URI__/multimodal-media-director/SKILL.md) (art-direction prompts for Imagen/Gemini/Flux; shot-by-shot camera storyboards for Veo/Kling/Hailuo; BPM/Key/Instrumentation/Metatag production sheets for Lyria/MiniMax/Suno).
  5. **Long-Form Novel, Fiction, & Script Writing** -> [novel-story-architect](file:///__SKILLS_ROOT_URI__/novel-story-architect/SKILL.md) (`.story-bible/` continuity compiler, scene beat sheets, and strict anti-AI-cliche prose filter).
  6. **Flowcharts, Swimlanes, & System Architecture Diagrams** -> [diagram-flowchart-architect](file:///__SKILLS_ROOT_URI__/diagram-flowchart-architect/SKILL.md) (automatic `.drawio` XML, `.excalidraw` JSON, and syntax-validated themed `Mermaid`).

## Gate 4: Project-Native Knowledge Sync & Verification Matrix
- Before business-project implementation, run `git fetch --prune` (when available) and read the project's tracked `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. Update `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md` in the same commit as structural, key-flow, or error-lesson changes.
- After UI implementation, always verify visual rendering, container/layout boundaries, and overflow using browser/screenshot evidence before claiming completion.
'@

$hookContent = $hookTemplate.
    Replace('__REPO_ROOT_URI__', $repoRootUri).
    Replace('__BUNDLE_PATH_URI__', $bundlePathUri).
    Replace('__ENFORCEMENT_SCRIPT_URI__', $enforcementScriptUri).
    Replace('__SKILLS_ROOT_URI__', $skillsRootUri).
    Replace('__EM_DASH__', $emDash).
    Replace('__ZH_STARTUP_PROMPT__', $zhStartupPrompt).
    Replace('__ZH_SKIP_MOCKUP__', $zhSkipMockup)

$targets = @($TargetPath)
if ($TargetPath -eq (Join-Path $UserHome ".gemini\GEMINI.md")) {
    $legacyTarget = Join-Path $UserHome ".gemini\AgentLogic\GEMINI.md"
    $legacyTargetDir = Split-Path -Parent $legacyTarget
    if ($legacyTargetDir -and -not (Test-Path $legacyTargetDir)) {
        New-Item -ItemType Directory -Force -Path $legacyTargetDir | Out-Null
    }
    $targets += $legacyTarget
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
foreach ($target in $targets) {
    if (Test-Path -LiteralPath $target) {
        $existingContent = [System.IO.File]::ReadAllText($target, $utf8NoBom)
        if ($existingContent -notmatch "Local AgentLogic Precedence Rule") {
            Write-Host "Appending AgentLogic delegation hook to '$target'..." -ForegroundColor Cyan
            [System.IO.File]::WriteAllText($target, ($existingContent.TrimEnd() + "`r`n" + $hookContent), $utf8NoBom)
        } else {
            Write-Host "Updating delegation hook in '$target'..." -ForegroundColor Cyan
            $updatedContent = [System.Text.RegularExpressions.Regex]::Replace($existingContent, "(?s)# Local AgentLogic Precedence Rule.*$", $hookContent.TrimStart())
            [System.IO.File]::WriteAllText($target, $updatedContent, $utf8NoBom)
        }
    } else {
        Write-Host "Creating new '$target' with AgentLogic delegation hook..." -ForegroundColor Cyan
        [System.IO.File]::WriteAllText($target, $hookContent.TrimStart(), $utf8NoBom)
    }
}

Write-Host "Built Antigravity-ready AgentLogic bundle."
Write-Host "Bundle path: $bundlePath"
Write-Host "Workspace rule hook configured at: $TargetPath"
Write-Host "Registered global skills discovery at: $configSkillsPath"
Write-Host "Skill governance inventory: complete (no archive moves applied)"
