param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"
$skillsGovernanceScript = Join-Path $repoRoot "scripts\skills-governance.ps1"

if (-not $TargetPath) {
    $TargetPath = Join-Path $UserHome "AGENTS.md"
}

$bundlePath = Join-Path $UserHome ".gemini\antigravity-cli\AgentLogic\AGENTS_BUNDLE.md"
$bundleDir = Split-Path -Parent $bundlePath
if ($bundleDir) {
    New-Item -ItemType Directory -Force -Path $bundleDir | Out-Null
}

# 1. Build the profile bundle to the dedicated bundle path
powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost antigravity -OutputPath $bundlePath
powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost antigravity -UserHome $UserHome -Apply

# 2. Add / Update the delegation hook in target AGENTS.md without overwriting other content
$hookContent = @"

# Local AgentLogic Precedence Rule

- The agent MUST prioritize the local AgentLogic rule-set (located at [AgentLogic](file:///$($repoRoot.Replace('\', '/')))) as the highest-priority logic and execute its mandatory reading chain and Startup Gate first.
- To prevent the "limited initial view" issue (where the agent only scans the parent directory or user profile folder in the first turn, sees a generic `AGENTS.md` and `package.json`, and misses the local main logic), the agent MUST proactively scan the `AgentLogic` directory immediately upon startup.
- The compiled master rules are stored in [AGENTS_BUNDLE.md](file:///$($bundlePath.Replace('\', '/'))). When AgentLogic is activated, the agent should read this bundle to align on all governance, validation, and design rules.
"@

if (Test-Path $TargetPath) {
    $existingContent = Get-Content -Raw -Path $TargetPath
    if ($existingContent -notmatch "Local AgentLogic Precedence Rule") {
        Write-Host "Appending AgentLogic delegation hook to '$TargetPath'..." -ForegroundColor Cyan
        Add-Content -Path $TargetPath -Value $hookContent -NoNewline
    } else {
        Write-Host "Delegation hook already present in '$TargetPath'." -ForegroundColor Green
    }
} else {
    Write-Host "Creating new '$TargetPath' with AgentLogic delegation hook..." -ForegroundColor Cyan
    Set-Content -Path $TargetPath -Value $hookContent -NoNewline
}

Write-Host "Built Antigravity-ready AgentLogic bundle."
Write-Host "Bundle path: $bundlePath"
Write-Host "Workspace rule hook configured at: $TargetPath"
Write-Host "Skill governance audit: applied"
