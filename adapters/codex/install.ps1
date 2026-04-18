param(
    [string]$ProfileName = "core-enhanced",
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$buildScript = Join-Path $repoRoot "scripts\build-profile.ps1"
$targetDir = Join-Path $UserHome ".codex\agentlogic"
$targetPath = Join-Path $targetDir "model_instructions.md"
$configPath = Join-Path $UserHome ".codex\config.toml"

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $ProfileName -TargetHost codex -OutputPath $targetPath

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
    $prefix = if ([string]::IsNullOrWhiteSpace($config)) { "" } else { $config.TrimEnd() + "`r`n" }
    $updated = $prefix + $line + "`r`n"
}

[System.IO.File]::WriteAllText($configPath, $updated, [System.Text.UTF8Encoding]::new($false))

Write-Host "Installed AgentLogic into Codex."
Write-Host "Instructions path: $targetPath"
Write-Host "Updated config: $configPath"
