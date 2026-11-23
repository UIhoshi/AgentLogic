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

$repoRoot = (Resolve-Path ([IO.Path]::Combine($PSScriptRoot, '..', '..'))).Path
$buildScript = [IO.Path]::Combine($repoRoot, 'scripts', 'build-profile.ps1')
$skillsGovernanceScript = [IO.Path]::Combine($repoRoot, 'scripts', 'skills-governance.ps1')
$targetDir = [IO.Path]::Combine($UserHome, '.codex', 'agentlogic')
$bundlePath = [IO.Path]::Combine($targetDir, 'AGENTLOGIC_BUNDLE.md')
$targetPath = [IO.Path]::Combine($targetDir, 'model_instructions.md')
$configPath = [IO.Path]::Combine($UserHome, '.codex', 'config.toml')
$deploySkillScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-first-party-skill.ps1')
$deployEnforcementScript = [IO.Path]::Combine($repoRoot, 'scripts', 'deploy-skill-enforcement.ps1')
$buildCodexPluginScript = [IO.Path]::Combine($repoRoot, 'scripts', 'build-codex-plugin.ps1')
$hookScript = [IO.Path]::Combine($repoRoot, 'scripts', 'install-hook.ps1')
$skillsRoot = [IO.Path]::Combine($UserHome, '.codex', 'skills')
$productSkillTarget = [IO.Path]::Combine($skillsRoot, 'product-requirements-grilling')
$enforcementTarget = [IO.Path]::Combine($targetDir, 'skill-enforcement')
$codexPluginTarget = [IO.Path]::Combine($targetDir, 'codex-plugin')

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost codex -OutputPath $bundlePath
if ($LASTEXITCODE -ne 0) { throw "build-profile.ps1 failed with exit code $LASTEXITCODE." }

powershell -NoProfile -ExecutionPolicy Bypass -File $hookScript -TargetHost codex -TargetPath $targetPath -RepoRoot $repoRoot -BundlePath $bundlePath -SkillsRoot $skillsRoot -EnforcementRoot $enforcementTarget -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "install-hook.ps1 failed for '$targetPath' with exit code $LASTEXITCODE." }

if (-not (Test-Path $configPath)) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $configPath) | Out-Null
    [System.IO.File]::WriteAllText($configPath, "", [System.Text.UTF8Encoding]::new($false))
}

$config = Get-Content -Raw -Encoding UTF8 -Path $configPath
$tomlPathValue = $targetPath.Replace('\', '/').Replace('"', '\"')
$line = "model_instructions_file = `"$tomlPathValue`""

if ($config -match "(?m)^model_instructions_file\s*=") {
    $existingLine = [System.Text.RegularExpressions.Regex]::Match($config, "(?m)^model_instructions_file\s*=.*$").Value.Trim()
    if ($existingLine -ne $line -and $UserHome) {
        $backupDir = [IO.Path]::Combine($UserHome, '.agentlogic-backup', (Get-Date -Format 'yyyyMMdd-HHmmss'))
        New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
        Copy-Item -LiteralPath $configPath -Destination (Join-Path $backupDir 'codex.config.toml.bak') -Force
    }
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $line }
    $updated = [System.Text.RegularExpressions.Regex]::Replace($config, "(?m)^model_instructions_file\s*=.*$", $evaluator)
} else {
    $firstTableMatch = [System.Text.RegularExpressions.Regex]::Match($config, "(?m)^\[")
    if ($firstTableMatch.Success) {
        $beforeTables = $config.Substring(0, $firstTableMatch.Index).TrimEnd()
        $tables = $config.Substring($firstTableMatch.Index).TrimStart("`r", "`n")
        $prefix = if ([string]::IsNullOrWhiteSpace($beforeTables)) { "" } else { $beforeTables + "`n" }
        $updated = $prefix + $line + "`n" + $tables
    } else {
        $prefix = if ([string]::IsNullOrWhiteSpace($config)) { "" } else { $config.TrimEnd() + "`n" }
        $updated = $prefix + $line + "`n"
    }
}

[System.IO.File]::WriteAllText($configPath, $updated, [System.Text.UTF8Encoding]::new($false))

powershell -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $repoRoot -TargetPath $productSkillTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-first-party-skill.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget
if ($LASTEXITCODE -ne 0) { throw "deploy-skill-enforcement.ps1 failed with exit code $LASTEXITCODE." }
powershell -NoProfile -ExecutionPolicy Bypass -File $deployEnforcementScript -RepoRoot $repoRoot -TargetPath $enforcementTarget -Verify
if ($LASTEXITCODE -ne 0) { throw "Skill enforcement payload verification failed with exit code $LASTEXITCODE." }

powershell -NoProfile -ExecutionPolicy Bypass -File $buildCodexPluginScript -RepoRoot $repoRoot -OutputDir $codexPluginTarget
if ($LASTEXITCODE -ne 0) { throw "build-codex-plugin.ps1 failed with exit code $LASTEXITCODE." }

powershell -NoProfile -ExecutionPolicy Bypass -File $skillsGovernanceScript -TargetHost codex -UserHome $UserHome
if ($LASTEXITCODE -ne 0) { throw "skills-governance.ps1 failed with exit code $LASTEXITCODE." }

Write-Host "Installed AgentLogic into Codex."
Write-Host "Instructions path: $targetPath"
Write-Host "Reference bundle: $bundlePath"
Write-Host "Updated config: $configPath"
Write-Host "Skill governance inventory: complete (no archive moves applied)"
