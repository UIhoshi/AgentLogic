param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$validateScript = Join-Path $RepoRoot "scripts\validate-package.ps1"
$buildScript = Join-Path $RepoRoot "scripts\build-profile.ps1"

Write-Host "Running AgentLogic package validation..."
& powershell -NoProfile -ExecutionPolicy Bypass -File $validateScript -RepoRoot $RepoRoot

if ($LASTEXITCODE -ne 0) {
    throw "validate-package.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Building default generic bundle..."
& powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName core-enhanced -TargetHost generic

if ($LASTEXITCODE -ne 0) {
    throw "build-profile.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Maintainer check passed."
