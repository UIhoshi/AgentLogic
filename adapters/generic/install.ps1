param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"

if (-not $TargetPath) {
    $TargetPath = Join-Path $repoRoot "dist\generic\AGENTLOGIC.md"
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost generic -OutputPath $TargetPath

Write-Host "Built generic AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
