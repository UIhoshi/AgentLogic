param(
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"

if (-not $TargetPath) {
    $TargetPath = Join-Path $UserHome ".gemini\AgentLogic\GEMINI.md"
}

$targetDir = Split-Path -Parent $TargetPath
if ($targetDir) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost gemini -OutputPath $TargetPath

Write-Host "Built Gemini-ready AgentLogic bundle."
Write-Host "Bundle path: $TargetPath"
Write-Host "If your Gemini host uses a different global entrypoint, point it at this file or rerun with -TargetPath."
