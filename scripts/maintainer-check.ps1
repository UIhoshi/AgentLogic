# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
$psExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh' } else { 'powershell' }

$validateScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'validate-package.ps1')
$buildScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'build-profile.ps1')
$logicEntryScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'check-logic-entry.js')
$genericAdapterScript = [IO.Path]::Combine($RepoRoot, 'adapters', 'generic', 'install.ps1')

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
    & $psExe -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName core-enhanced -TargetHost $target
    if ($LASTEXITCODE -ne 0) {
        throw "build-profile.ps1 failed for '$target' with exit code $LASTEXITCODE."
    }
}

Write-Host "Syncing dist/generic skills and skill-enforcement payload..."
& $psExe -NoProfile -ExecutionPolicy Bypass -File $genericAdapterScript -ProfileName core-enhanced
if ($LASTEXITCODE -ne 0) {
    throw "adapters/generic/install.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Running first-party skill quality and token-budget evaluation..."
$evalScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'eval-skills.ps1')
& $psExe -NoProfile -ExecutionPolicy Bypass -File $evalScript -RepoRoot $RepoRoot -FailOnFirstPartyErrors
if ($LASTEXITCODE -ne 0) {
    throw "eval-skills.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Auditing portable skills for duplicates..."
& $psExe -NoProfile -ExecutionPolicy Bypass -File ([IO.Path]::Combine($RepoRoot, 'scripts', 'audit-skill-duplicates.ps1')) -FailOnCandidates
if ($LASTEXITCODE -ne 0) {
    throw "audit-skill-duplicates.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Building standard Codex plugin bundle..."
$codexPluginScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'build-codex-plugin.ps1')
& $psExe -NoProfile -ExecutionPolicy Bypass -File $codexPluginScript -RepoRoot $RepoRoot
if ($LASTEXITCODE -ne 0) {
    throw "build-codex-plugin.ps1 failed with exit code $LASTEXITCODE."
}

Write-Host "Running AgentLogic package validation..."
& $psExe -NoProfile -ExecutionPolicy Bypass -File $validateScript -RepoRoot $RepoRoot
if ($LASTEXITCODE -ne 0) {
    throw "validate-package.ps1 failed with exit code $LASTEXITCODE."
}

foreach ($testScript in @('test-skill-registry.ps1', 'test-skill-workflow-graph.ps1', 'test-skill-enforcement.ps1')) {
    Write-Host "Running regression test: $testScript..."
    & $psExe -NoProfile -ExecutionPolicy Bypass -File ([IO.Path]::Combine($RepoRoot, 'scripts', $testScript)) -RepoRoot $RepoRoot
    if ($LASTEXITCODE -ne 0) {
        throw "$testScript failed with exit code $LASTEXITCODE."
    }
}

Write-Host "Maintainer check passed."
