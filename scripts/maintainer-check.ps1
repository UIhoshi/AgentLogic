param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$validateScript = Join-Path $RepoRoot "scripts\validate-package.ps1"
$buildScript = Join-Path $RepoRoot "scripts\build-profile.ps1"
$logicEntryScript = Join-Path $RepoRoot "scripts\check-logic-entry.js"

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    throw "node is required to run scripts/check-logic-entry.js."
}

Write-Host "Checking logic-entry enforcement..."
& node $logicEntryScript

if ($LASTEXITCODE -ne 0) {
    throw "check-logic-entry.js failed with exit code $LASTEXITCODE."
}

$targets = @("codex", "claude", "antigravity", "generic")
foreach ($target in $targets) {
    Write-Host "Building default $target bundle..."
    & powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName core-enhanced -TargetHost $target
    if ($LASTEXITCODE -ne 0) {
        throw "build-profile.ps1 failed for '$target' with exit code $LASTEXITCODE."
    }
}

Write-Host "Running AgentLogic package validation..."
& powershell -NoProfile -ExecutionPolicy Bypass -File $validateScript -RepoRoot $RepoRoot
if ($LASTEXITCODE -ne 0) {
    throw "validate-package.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Maintainer check passed."
