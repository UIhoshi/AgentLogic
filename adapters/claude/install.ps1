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

$repoRoot = (Resolve-Path ([IO.Path]::Combine($PSScriptRoot, '..', '..'))).Path
$buildScript = [IO.Path]::Combine($repoRoot, 'scripts', 'build-profile.ps1')
$skillsGovernanceScript = [IO.Path]::Combine($repoRoot, 'scripts', 'skills-governance.ps1')
$deploySkillScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-first-party-skill.ps1')
$deployEnforcementScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-skill-enforcement.ps1')
$hookScript = [IO.Path]::Combine($repoRoot, 'scripts', 'install-hook.ps1')
$skillsRoot = [IO.Path]::Combine($UserHome, '.claude', 'skills')
$productSkillTarget = [IO.Path]::Combine($skillsRoot, 'product-requirements-grilling')
$enforcementTarget = [IO.Path]::Combine($UserHome, '.claude', 'AgentLogic', 'skill-enforcement')

if (-not $TargetPath) {
    $TargetPath = [IO.Path]::Combine($UserHome, '.claude', 'AgentLogic', 'CLAUDE.md')
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost claude -OutputPath $TargetPath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }

# Install a compact (~11 KB) bounded executive hook into ~/.claude/CLAUDE.md non-destructively (pointing to ~/.claude/AgentLogic/CLAUDE.md on disk)
$rootClaudeMd = [IO.Path]::Combine($UserHome, '.claude', 'CLAUDE.md')
if ($TargetPath -eq ([IO.Path]::Combine($UserHome, '.claude', 'AgentLogic', 'CLAUDE.md'))) {
    powershell -NoProfile -ExecutionPolicy Bypass -File $hookScript -TargetHost claude -TargetPath $rootClaudeMd -RepoRoot $repoRoot -BundlePath $TargetPath -SkillsRoot $skillsRoot -EnforcementRoot $enforcementTarget -UserHome $UserHome
    if ($LASTEXITCODE -ne 0) { throw "install-hook.ps1 failed for '$rootClaudeMd' with exit code $LASTEXITCODE." }
}

powershell -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-skill-enforcement.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget -Verify
if ($LASTEXITCODE -ne 0) { throw "Skill enforcement payload verification failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost claude -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

Write-Host "Built Claude-ready AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
Write-Host "Skill governance inventory: complete (no archive moves applied)"
Write-Host "If your Claude host uses a different global entrypoint, point it at this file or rerun with -TargetPath."
