# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath
)

$ErrorActionPreference = "Stop"
$psExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh' } else { 'powershell' }
$resolvedUserHome = if ($env:USERPROFILE) { $env:USERPROFILE } else { $HOME }

$repoRoot = (Resolve-Path ([IO.Path]::Combine($PSScriptRoot, '..', '..'))).Path
$buildScript = [IO.Path]::Combine($repoRoot, 'scripts', 'build-profile.ps1')
$skillsGovernanceScript = [IO.Path]::Combine($repoRoot, 'scripts', 'skills-governance.ps1')
$deploySkillScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-first-party-skill.ps1')
$deployEnforcementScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-skill-enforcement.ps1')

if (-not $TargetPath) {
    $TargetPath = [IO.Path]::Combine($repoRoot, 'dist', 'generic', 'AGENTLOGIC.md')
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

& $psExe -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost generic -OutputPath $TargetPath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }
$productSkillTarget = [IO.Path]::Combine((Split-Path -Parent $TargetPath), 'skills', 'product-requirements-grilling')
$enforcementTarget = [IO.Path]::Combine((Split-Path -Parent $TargetPath), 'skill-enforcement')
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-skill-enforcement.ps1 failed with exit code $LASTEXITCODE." }
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget -Verify
if ($LASTEXITCODE -ne 0) { throw "Skill enforcement payload verification failed with exit code $LASTEXITCODE." }

& $psExe -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost generic -UserHome $resolvedUserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

Write-Host "Built generic AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
