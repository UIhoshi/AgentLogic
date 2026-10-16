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
$productSkillTarget = Join-Path $UserHome '.gemini\skills\product-requirements-grilling'
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
$grillingSkillUri = (Join-Path $productSkillTarget 'SKILL.md').Replace('\', '/')

$zhStartupPrompt = [regex]::Unescape('\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002')
$zhSkipMockup = [regex]::Unescape('\u4e0d\u9700\u8981\u5148\u753b\u56fe')

$hookTemplate = @'

# Local AgentLogic Precedence Rule

- The agent MUST prioritize the local AgentLogic rule-set (located at [AgentLogic](file:///__REPO_ROOT_URI__)) as the highest-priority logic and execute its mandatory reading chain and blocking gates first.
- The compiled master rules are stored in [AGENTS_BUNDLE.md](file:///__BUNDLE_PATH_URI__). Because Antigravity caps individual rule files at 24 KB, the three non-negotiable blocking gates from `AGENTS_BUNDLE.md` are inlined directly below and MUST be executed in every workspace:

## Gate 1: Startup & Context-Reset Gate (Turn 1 Blocking)
- **EXECUTION vs SUMMARIZATION MANDATE**: You MUST NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any task/session, you MUST ACTUALLY EXECUTE the Startup Gate protocol and explicitly ask the user whether to `forget/compress context` in the user's interaction language unless the task is an explicit continuation:
  - Chinese: "__ZH_STARTUP_PROMPT__"
  - English: "Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context."
  - Other languages: Output the matching context-reset confirmation in the user's language.
- To prevent the "limited initial view" issue (where the agent only scans the parent directory or user profile folder in the first turn, sees a generic `AGENTS.md` and `package.json`, and misses the local main logic), the agent MUST proactively scan the `AgentLogic` directory or read [AGENTS_BUNDLE.md](file:///__BUNDLE_PATH_URI__) immediately upon startup.

## Gate 2: Mandatory UI Preview & Requirements Gate (BLOCKING Before Any UI Code)
- **WHEN TRIGGERED**: Whenever starting a new project with a UI, adding a net-new page/screen/component, or performing a substantial UI refactor/redesign.
- **HARD BLOCK**: You MUST NOT write or edit production UI/frontend code (`.html`, `.css`, `.scss`, `.jsx`, `.tsx`, `.vue`, `.svelte`, or UI layout/style blocks) until ALL of the following steps are completed, **UNLESS the user explicitly opts out** (e.g., explicitly says "__ZH_SKIP_MOCKUP__" / "skip mockup"):
  1. **Single-Question Requirements Grilling**: Read and follow [product-requirements-grilling](file:///__GRILLING_SKILL_URI__). Ask one unresolved product/UI decision question at a time, write `.specify/<task>/requirements-brief.md`, and obtain user approval before generating a mockup or writing UI code.
  2. **Visual UI Mockup Generation First (`image-generator` / `nano-banana-pro`)**:
     - Before writing any UI code, formulate a detailed visual prompt (layout, typography, HSL palette, spacing/density) from the approved brief.
     - For an existing UI layout the user dislikes, capture a screenshot of the current UI first and include it with the user's change brief.
     - Invoke Antigravity's built-in **`image-generator` subagent** (`invoke_subagent` with `TypeName: "image-generator"`) or the `nano-banana-pro` skill to generate a visual UI mockup image. Never skip mockup generation merely because the tool is named `image-generator` instead of `imagegen`.
     - Save/copy the generated mockup image to the project workspace (e.g., `.specify/mockups/`) or artifact directory, clearly state the file path, and present it to the user.
  3. **User Approval or Explicit Opt-Out**: Wait for the user to approve the UI mockup image (or explicitly state that no mockup is needed) before writing UI implementation code.
  4. **Workflow State Recording**: For non-trivial UI tasks, record route progression (`requirements-grilling` -> `design-direction` -> `ui-design` -> `ui-implementation`) using [skill-enforcement.ps1](file:///__ENFORCEMENT_SCRIPT_URI__).

## Gate 3: Project-Native Knowledge Sync & Verification Matrix
- Before business-project implementation, run `git fetch --prune` (when available) and read the project's tracked `AGENTS.md`, `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. Update `PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md` in the same commit as structural, key-flow, or error-lesson changes.
- After UI implementation, always verify visual rendering, container/layout boundaries, and overflow using browser/screenshot evidence before claiming completion.
'@

$hookContent = $hookTemplate.
    Replace('__REPO_ROOT_URI__', $repoRootUri).
    Replace('__BUNDLE_PATH_URI__', $bundlePathUri).
    Replace('__ENFORCEMENT_SCRIPT_URI__', $enforcementScriptUri).
    Replace('__GRILLING_SKILL_URI__', $grillingSkillUri).
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
