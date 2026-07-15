param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"
$skillsGovernanceScript = Join-Path $repoRoot "scripts\skills-governance.ps1"

if (-not $TargetPath) {
    $TargetPath = Join-Path $repoRoot "dist\generic\AGENTLOGIC.md"
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost generic -OutputPath $TargetPath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }

powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost generic -UserHome $env:USERPROFILE
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

Write-Host "Built generic AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
