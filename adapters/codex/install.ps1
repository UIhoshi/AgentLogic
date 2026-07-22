# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$ProfileName = "core-enhanced",
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"
$skillsGovernanceScript = Join-Path $repoRoot "scripts\skills-governance.ps1"
$targetDir = Join-Path $UserHome ".codex\agentlogic"
$targetPath = Join-Path $targetDir "model_instructions.md"
$configPath = Join-Path $UserHome ".codex\config.toml"
$deploySkillScript = Join-Path $repoRoot 'scripts\deploy-first-party-skill.ps1'
$productSkillTarget = Join-Path $UserHome '.codex\skills\product-requirements-grilling'

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost codex -OutputPath $targetPath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }

if (-not (Test-Path $configPath)) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $configPath) | Out-Null
    [System.IO.File]::WriteAllText($configPath, "", [System.Text.UTF8Encoding]::new($false))
}

$config = Get-Content -Raw -Path $configPath
$line = "model_instructions_file = '$targetPath'"

if ($config -match "(?m)^model_instructions_file\s*=") {
    $updated = [System.Text.RegularExpressions.Regex]::Replace($config, "(?m)^model_instructions_file\s*=.*$", $line)
}
else {
    $firstTableMatch = [System.Text.RegularExpressions.Regex]::Match($config, "(?m)^\[")

    if ($firstTableMatch.Success) {
        $beforeTables = $config.Substring(0, $firstTableMatch.Index).TrimEnd()
        $tables = $config.Substring($firstTableMatch.Index).TrimStart("`r", "`n")
        $prefix = if ([string]::IsNullOrWhiteSpace($beforeTables)) { "" } else { $beforeTables + "`r`n" }
        $updated = $prefix + $line + "`r`n" + $tables
    }
    else {
        $prefix = if ([string]::IsNullOrWhiteSpace($config)) { "" } else { $config.TrimEnd() + "`r`n" }
        $updated = $prefix + $line + "`r`n"
    }
}

[System.IO.File]::WriteAllText($configPath, $updated, [System.Text.UTF8Encoding]::new($false))

powershell -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }

powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost codex -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

Write-Host "Installed AgentLogic into Codex."
Write-Host "Instructions path: $targetPath"
Write-Host "Updated config: $configPath"
Write-Host "Skill governance inventory: complete (no archive moves applied)"
