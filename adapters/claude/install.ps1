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
$productSkillTarget = Join-Path $UserHome '.claude\skills\product-requirements-grilling'
$enforcementTarget = Join-Path $UserHome '.claude\AgentLogic\skill-enforcement'

if (-not $TargetPath) {
    $TargetPath = Join-Path $UserHome ".claude\AgentLogic\CLAUDE.md"
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost claude -OutputPath $TargetPath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }

# Also mirror to ~/.claude/CLAUDE.md when installing to the default ~/.claude/AgentLogic/CLAUDE.md path so Claude Code CLI loads it automatically
$rootClaudeMd = Join-Path $UserHome ".claude\CLAUDE.md"
if ($TargetPath -eq (Join-Path $UserHome ".claude\AgentLogic\CLAUDE.md")) {
    Copy-Item -LiteralPath $TargetPath -Destination $rootClaudeMd -Force
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
