param(
    [ValidateSet("codex", "claude", "gemini", "generic")]
    [string]$TargetHost = "generic",
    [string]$ProfileName = "core-enhanced",
    [string]$TargetPath,
    [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path $PSScriptRoot).Path
$adapterScript = Join-Path $repoRoot ("adapters\{0}\install.ps1" -f $TargetHost)

if (-not (Test-Path $adapterScript)) {
    throw "Unsupported host adapter: $TargetHost"
}

$arguments = @(
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", $adapterScript,
    "-ProfileName", $ProfileName
)

switch ($TargetHost) {
    "codex" {
        if ($UserHome) {
            $arguments += @("-UserHome", $UserHome)
        }
    }
    "claude" {
        if ($TargetPath) {
            $arguments += @("-TargetPath", $TargetPath)
        }
        if ($UserHome) {
            $arguments += @("-UserHome", $UserHome)
        }
    }
    "gemini" {
        if ($TargetPath) {
            $arguments += @("-TargetPath", $TargetPath)
        }
        if ($UserHome) {
            $arguments += @("-UserHome", $UserHome)
        }
    }
    "generic" {
        if ($TargetPath) {
            $arguments += @("-TargetPath", $TargetPath)
        }
    }
}

& powershell @arguments

if ($LASTEXITCODE -ne 0) {
    throw "Host installation failed for '$TargetHost' with exit code $LASTEXITCODE."
}
