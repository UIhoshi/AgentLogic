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

$repoRoot = (Resolve-Path $PSScriptRoot).Path
$adapterScript = Join-Path $repoRoot ("adapters\{0}\install.ps1" -f $TargetHost)
$logicEntryScript = Join-Path $repoRoot "scripts\check-logic-entry.js"
$validateScript = Join-Path $repoRoot "scripts\validate-package.ps1"

if (-not (Test-Path $adapterScript)) {
    throw "Unsupported host adapter: $TargetHost"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    throw "node is required to validate the repository logic entry before installation."
}

Write-Host "Preflight: checking repository logic entry..."
& node $logicEntryScript
if ($LASTEXITCODE -ne 0) {
    throw "Repository logic-entry validation failed with exit code $LASTEXITCODE."
}

Write-Host "Preflight: checking package and generated host bundles..."
& powershell -NoProfile -ExecutionPolicy Bypass -File $validateScript -RepoRoot $repoRoot
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
& powershell @arguments
if ($LASTEXITCODE -ne 0) {
    throw "Host installation failed for '$TargetHost' with exit code $LASTEXITCODE. Legacy files were not changed."
}

$installedTargets = @()
switch ($TargetHost) {
    "codex" { $installedTargets += Join-Path $UserHome ".codex\agentlogic\model_instructions.md" }
    "claude" { $installedTargets += if ($TargetPath) { $TargetPath } else { Join-Path $UserHome ".claude\AgentLogic\CLAUDE.md" } }
    "antigravity" {
        $installedTargets += if ($TargetPath) { $TargetPath } else { Join-Path $UserHome ".gemini\GEMINI.md" }
        $installedTargets += Join-Path $UserHome ".gemini\antigravity-cli\AgentLogic\AGENTS_BUNDLE.md"
    }
    "generic" { $installedTargets += if ($TargetPath) { $TargetPath } else { Join-Path $repoRoot "dist\generic\AGENTLOGIC.md" } }
}

foreach ($installedTarget in $installedTargets) {
    if (-not (Test-Path $installedTarget)) {
        throw "Post-install verification failed; expected target was not created: $installedTarget"
    }
}

# Legacy files are moved only after the new target is verified. The selected target is protected.
$legacyFiles = @()
if ($TargetHost -eq "antigravity") {
    $legacyFiles += Join-Path $UserHome ".gemini\AgentLogic\GEMINI.md"
    $legacyFiles += Join-Path $UserHome ".gemini\GEMINI.md"
} elseif ($TargetHost -eq "claude") {
    $legacyFiles += Join-Path $UserHome ".claude\CLAUDE.md"
} elseif ($TargetHost -eq "codex") {
    $legacyFiles += Join-Path $UserHome ".codex\model_instructions.md"
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
        $backupRoot = Join-Path $UserHome (".agentlogic-backup\{0}" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
        New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
    }

    Write-Host "Backing up legacy logic file '$legacyFile'..." -ForegroundColor Yellow
    Move-Item -LiteralPath $legacyFile -Destination $backupRoot -Force
}

Write-Host "Installed AgentLogic into $TargetHost."
Write-Host ("Verified targets: {0}" -f ($installedTargets -join ", "))
if ($backupRoot) {
    Write-Host "Legacy files were backed up to: $backupRoot"
}
