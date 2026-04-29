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
    $TargetPath = Join-Path $UserHome ".claude\AgentLogic\CLAUDE.md"
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost claude -OutputPath $TargetPath
powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost claude -UserHome $UserHome -Apply

Write-Host "Built Claude-ready AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
Write-Host "Skill governance audit: applied"
Write-Host "If your Claude host uses a different global entrypoint, point it at this file or rerun with -TargetPath."
