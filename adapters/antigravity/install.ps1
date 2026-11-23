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
    [string]$UserHome = $(if ($env:USERPROFILE) { $env:USERPROFILE } else { $HOME })
)

$ErrorActionPreference = "Stop"
$psExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh' } else { 'powershell' }

$repoRoot = (Resolve-Path ([IO.Path]::Combine($PSScriptRoot, '..', '..'))).Path
$buildScript = [IO.Path]::Combine($repoRoot, 'scripts', 'build-profile.ps1')
$skillsGovernanceScript = [IO.Path]::Combine($repoRoot, 'scripts', 'skills-governance.ps1')
$deploySkillScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-first-party-skill.ps1')
$deployEnforcementScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-skill-enforcement.ps1')
$hookScript = [IO.Path]::Combine($repoRoot, 'scripts', 'install-hook.ps1')
$skillsRoot = [IO.Path]::Combine($UserHome, '.gemini', 'skills')
$productSkillTarget = [IO.Path]::Combine($skillsRoot, 'product-requirements-grilling')
$enforcementTarget = [IO.Path]::Combine($UserHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'skill-enforcement')

if (-not $TargetPath) {
    $TargetPath = [IO.Path]::Combine($UserHome, '.gemini', 'GEMINI.md')
}

$bundlePath = [IO.Path]::Combine($UserHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'AGENTS_BUNDLE.md')
$bundleDir = Split-Path -Parent $bundlePath
if ($bundleDir) {
    New-Item -ItemType Directory -Force -Path $bundleDir | Out-Null
}

# 1. Build the profile bundle to the dedicated bundle path
& $psExe -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost antigravity -OutputPath $bundlePath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-skill-enforcement.ps1 failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget -Verify
if ($LASTEXITCODE -ne 0) { throw "Skill enforcement payload verification failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost antigravity -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

# 2. Ensure ~/.gemini/config/skills.json registers ~/.gemini/skills so deployed skills are discoverable across all workspaces
$configSkillsPath = [IO.Path]::Combine($UserHome, '.gemini', 'config', 'skills.json')
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
    $alreadyRegistered = @($existingEntries | Where-Object { $_.path -eq $skillsEntryPath -or $_.path -eq ([IO.Path]::Combine($UserHome, '.gemini', 'skills')).Replace('\', '/') })
    if ($alreadyRegistered.Count -eq 0) {
        $existingEntries += [pscustomobject]@{ path = $skillsEntryPath }
        $skillsConfigObj | Add-Member -Force -NotePropertyName entries -NotePropertyValue @($existingEntries)
    }
}
[System.IO.File]::WriteAllText($configSkillsPath, ($skillsConfigObj | ConvertTo-Json -Depth 10), [System.Text.UTF8Encoding]::new($false))

# 3. Install/update bounded AgentLogic delegation hook without clobbering user rules
$targets = @($TargetPath)
if ($TargetPath -eq ([IO.Path]::Combine($UserHome, '.gemini', 'GEMINI.md'))) {
    $legacyTarget = [IO.Path]::Combine($UserHome, '.gemini', 'AgentLogic', 'GEMINI.md')
    $targets += $legacyTarget
}

foreach ($target in $targets) {
    & $psExe -NoProfile -ExecutionPolicy Bypass -File $hookScript -TargetHost antigravity -TargetPath $target -RepoRoot $repoRoot -BundlePath $bundlePath -SkillsRoot $skillsRoot -EnforcementRoot $enforcementTarget -UserHome $UserHome
    if ($LASTEXITCODE -ne 0) { throw "install-hook.ps1 failed for '$target' with exit code $LASTEXITCODE." }
}

Write-Host "Built Antigravity-ready AgentLogic bundle."
Write-Host "Bundle path: $bundlePath"
Write-Host "Workspace rule hook configured at: $TargetPath"
Write-Host "Registered global skills discovery at: $configSkillsPath"
Write-Host "Skill governance inventory: complete (no archive moves applied)"
