param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

function Write-Status {
    param(
        [string]$Label,
        [bool]$Ok,
        [string]$Detail = ""
    )

    $state = if ($Ok) { "OK" } else { "MISSING" }
    if ($Detail) {
        Write-Host ("{0}: {1} - {2}" -f $Label, $state, $Detail)
    }
    else {
        Write-Host ("{0}: {1}" -f $Label, $state)
    }
}

function Test-RelativePath {
    param([string]$RelativePath)
    return Test-Path (Join-Path $RepoRoot $RelativePath)
}

$manifestPath = Join-Path $RepoRoot "manifest.json"

Write-Host "AgentLogic Doctor"
Write-Host "================="
Write-Host "Repo root: $RepoRoot"
Write-Host ""

Write-Status -Label "Repository root" -Ok (Test-RelativePath "README.md") -Detail "README.md"
Write-Status -Label "Human entry" -Ok (Test-RelativePath "00_START_HERE.md") -Detail "00_START_HERE.md"
Write-Status -Label "Agent entry" -Ok (Test-RelativePath "AGENT_INSTALL.md") -Detail "AGENT_INSTALL.md"
Write-Status -Label "Install guide" -Ok (Test-RelativePath "INSTALL.md") -Detail "INSTALL.md"
Write-Status -Label "Root installer" -Ok (Test-RelativePath "install.ps1") -Detail "install.ps1"
Write-Status -Label "Manifest" -Ok (Test-Path $manifestPath) -Detail "manifest.json"
Write-Host ""

if (-not (Test-Path $manifestPath)) {
    throw "manifest.json was not found. Run this command from the AgentLogic repository root or pass -RepoRoot."
}

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json

Write-Host "Package"
Write-Host "-------"
Write-Host "Name: $($manifest.name)"
Write-Host "Role: $($manifest.role)"
Write-Host "Stable entry: $($manifest.entry)"
Write-Host "Current version: $($manifest.current_version)"
Write-Host "Main logic file: $($manifest.main_logic_file)"
Write-Host "Default profile: $($manifest.default_profile)"
Write-Host ""

Write-Host "Supported hosts"
Write-Host "---------------"
foreach ($adapter in $manifest.adapters.PSObject.Properties) {
    $hostName = $adapter.Name
    $adapterPath = $adapter.Value
    $exists = Test-RelativePath $adapterPath
    $output = $manifest.host_outputs.$hostName
    $command = "powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost $hostName"

    Write-Host "- $hostName"
    Write-Host "  Adapter: $adapterPath"
    Write-Host "  Adapter exists: $exists"
    Write-Host "  Output: $output"
    Write-Host "  Command: $command"
}
Write-Host ""

$detected = @()
if ($env:CODEX_HOME -or (Test-Path (Join-Path $HOME ".codex"))) {
    $detected += "codex"
}
if ($env:CLAUDE_CONFIG_DIR -or (Test-Path (Join-Path $HOME ".claude"))) {
    $detected += "claude"
}
if ($env:GEMINI_HOME -or (Test-Path (Join-Path $HOME ".gemini"))) {
    $detected += "gemini"
}

Write-Host "Local host hints"
Write-Host "----------------"
if ($detected.Count -gt 0) {
    Write-Host ("Detected possible host(s): {0}" -f ($detected -join ", "))
}
else {
    Write-Host "No host-specific directory or environment variable was detected."
}

$recommendedHost = if ($detected.Count -gt 0) { $detected[0] } else { "generic" }
Write-Host ""
Write-Host "Recommended next command"
Write-Host "------------------------"
Write-Host ("powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost {0}" -f $recommendedHost)
Write-Host ""
Write-Host "Validation command"
Write-Host "------------------"
Write-Host "powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1"
