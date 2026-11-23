# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [ValidateSet("codex", "claude", "antigravity", "generic")]
    [string]$TargetHost = "generic",
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($UserHome)) { $UserHome = $HOME }

$repoRoot = (Resolve-Path $PSScriptRoot).Path
$adapterScript = [IO.Path]::Combine($repoRoot, 'adapters', $TargetHost, 'install.ps1')
$logicEntryScript = [IO.Path]::Combine($repoRoot, 'scripts', 'check-logic-entry.js')
$validateScript = [IO.Path]::Combine($repoRoot, 'scripts', 'validate-package.ps1')

if (-not (Test-Path $adapterScript)) {
    throw "Unsupported host adapter: $TargetHost"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    throw "node is required to validate the repository logic entry before installation."
}

$psExe = if (Get-Command pwsh -ErrorAction SilentlyContinue) { 'pwsh' } else { 'powershell' }

Write-Host "Preflight: checking repository logic entry..."
& node $logicEntryScript
if ($LASTEXITCODE -ne 0) {
    throw "Repository logic-entry validation failed with exit code $LASTEXITCODE."
}

Write-Host "Preflight: checking package and generated host bundles..."
& $psExe -NoProfile -ExecutionPolicy Bypass -File $validateScript -RepoRoot $repoRoot
if ($LASTEXITCODE -ne 0) {
    throw "Package validation failed with exit code $LASTEXITCODE. No host files were changed."
}

$arguments = @(
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", $adapterScript,
    "-ProfileName", $ProfileName
)

switch ($TargetHost) {
    "codex" {
        if ($UserHome) { $arguments += @("-UserHome", $UserHome) }
    }
    "claude" {
        if ($TargetPath) { $arguments += @("-TargetPath", $TargetPath) }
        if ($UserHome) { $arguments += @("-UserHome", $UserHome) }
    }
    "antigravity" {
        if ($TargetPath) { $arguments += @("-TargetPath", $TargetPath) }
        if ($UserHome) { $arguments += @("-UserHome", $UserHome) }
    }
    "generic" {
        if ($TargetPath) { $arguments += @("-TargetPath", $TargetPath) }
    }
}

Write-Host "Installing $TargetHost profile '$ProfileName'..."
& $psExe @arguments
if ($LASTEXITCODE -ne 0) {
    throw "Host installation failed for '$TargetHost' with exit code $LASTEXITCODE. Legacy files were not changed."
}

$installedTargets = @()
switch ($TargetHost) {
    "codex" {
        $installedTargets += [IO.Path]::Combine($UserHome, '.codex', 'agentlogic', 'model_instructions.md')
        $installedTargets += [IO.Path]::Combine($UserHome, '.codex', 'agentlogic', 'AGENTLOGIC_BUNDLE.md')
    }
    "claude" {
        $installedTargets += if ($TargetPath) { $TargetPath } else { [IO.Path]::Combine($UserHome, '.claude', 'AgentLogic', 'CLAUDE.md') }
        if (-not $TargetPath) { $installedTargets += [IO.Path]::Combine($UserHome, '.claude', 'CLAUDE.md') }
    }
    "antigravity" {
        $installedTargets += if ($TargetPath) { $TargetPath } else { [IO.Path]::Combine($UserHome, '.gemini', 'GEMINI.md') }
        $installedTargets += [IO.Path]::Combine($UserHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'AGENTS_BUNDLE.md')
        if (-not $TargetPath) { $installedTargets += [IO.Path]::Combine($UserHome, '.gemini', 'AgentLogic', 'GEMINI.md') }
    }
    "generic" { $installedTargets += if ($TargetPath) { $TargetPath } else { [IO.Path]::Combine($repoRoot, 'dist', 'generic', 'AGENTLOGIC.md') } }
}

foreach ($installedTarget in $installedTargets) {
    if (-not (Test-Path $installedTarget)) {
        throw "Post-install verification failed; expected target was not created: $installedTarget"
    }
}

$installedSkillPath = switch ($TargetHost) {
    "codex" { [IO.Path]::Combine($UserHome, '.codex', 'skills', 'product-requirements-grilling', 'SKILL.md') }
    "claude" { [IO.Path]::Combine($UserHome, '.claude', 'skills', 'product-requirements-grilling', 'SKILL.md') }
    "antigravity" { [IO.Path]::Combine($UserHome, '.gemini', 'skills', 'product-requirements-grilling', 'SKILL.md') }
    "generic" {
        $genericBundle = if ($TargetPath) { $TargetPath } else { [IO.Path]::Combine($repoRoot, 'dist', 'generic', 'AGENTLOGIC.md') }
        [IO.Path]::Combine((Split-Path -Parent $genericBundle), 'skills', 'product-requirements-grilling', 'SKILL.md')
    }
}
if (-not (Test-Path $installedSkillPath)) {
    throw "Post-install verification failed; required first-party skill was not deployed: $installedSkillPath"
}

$enforcementPayloadRoot = switch ($TargetHost) {
    "codex" { [IO.Path]::Combine($UserHome, '.codex', 'agentlogic', 'skill-enforcement') }
    "claude" { [IO.Path]::Combine($UserHome, '.claude', 'AgentLogic', 'skill-enforcement') }
    "antigravity" { [IO.Path]::Combine($UserHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'skill-enforcement') }
    "generic" {
        $genericBundle = if ($TargetPath) { $TargetPath } else { [IO.Path]::Combine($repoRoot, 'dist', 'generic', 'AGENTLOGIC.md') }
        [IO.Path]::Combine((Split-Path -Parent $genericBundle), 'skill-enforcement')
    }
}
$enforcementDeployer = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-skill-enforcement.ps1')
& $psExe -NoProfile -ExecutionPolicy Bypass -File $enforcementDeployer -RepoRoot $repoRoot -TargetPath $enforcementPayloadRoot -Verify
if ($LASTEXITCODE -ne 0) {
    throw "Post-install verification failed; skill enforcement payload is missing or stale: $enforcementPayloadRoot"
}

# Legacy files are moved only after the new target is verified. The selected target is protected.
$legacyFiles = @()
if ($TargetHost -eq "antigravity") {
    $legacyFiles += [IO.Path]::Combine($UserHome, '.gemini', 'AgentLogic', 'GEMINI.md')
    $legacyFiles += [IO.Path]::Combine($UserHome, '.gemini', 'GEMINI.md')
} elseif ($TargetHost -eq "claude") {
    $legacyFiles += [IO.Path]::Combine($UserHome, '.claude', 'CLAUDE.md')
} elseif ($TargetHost -eq "codex") {
    $legacyFiles += [IO.Path]::Combine($UserHome, '.codex', 'model_instructions.md')
}

$backupRoot = $null
foreach ($legacyFile in $legacyFiles) {
    if (-not (Test-Path $legacyFile)) { continue }
    $isProtected = $installedTargets | Where-Object { [IO.Path]::GetFullPath($_) -eq [IO.Path]::GetFullPath($legacyFile) }
    if ($isProtected) {
        Write-Host "Keeping selected installation target: $legacyFile"
        continue
    }

    if (-not $backupRoot) {
        $backupRoot = [IO.Path]::Combine($UserHome, '.agentlogic-backup', (Get-Date -Format 'yyyyMMdd-HHmmss'))
        New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
    }

    Write-Host "Backing up legacy logic file '$legacyFile'..." -ForegroundColor Yellow
    Move-Item -LiteralPath $legacyFile -Destination $backupRoot -Force
}

Write-Host "Installed AgentLogic into $TargetHost."
Write-Host ("Verified targets: {0}" -f ($installedTargets -join ", "))
Write-Host "Verified first-party skill: $installedSkillPath"
Write-Host "Verified workflow-enforcement payload: $enforcementPayloadRoot"
if ($backupRoot) {
    Write-Host "Legacy files were backed up to: $backupRoot"
}
