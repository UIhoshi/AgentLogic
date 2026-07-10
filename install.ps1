param(
    [ValidateSet("codex", "claude", "gemini", "antigravity", "generic")]
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

# Legacy logic detection & cleanup block (mandatory step during installation)
if (-not $TargetPath) {
    $legacyFiles = @()
    if ($TargetHost -eq "gemini") {
        $legacyFiles += Join-Path $UserHome ".gemini\GEMINI.md"
    } elseif ($TargetHost -eq "claude") {
        $legacyFiles += Join-Path $UserHome ".claude\CLAUDE.md"
    } elseif ($TargetHost -eq "codex") {
        $legacyFiles += Join-Path $UserHome ".codex\model_instructions.md"
    }

    foreach ($legacyFile in $legacyFiles) {
        if (Test-Path $legacyFile) {
            Write-Host "WARNING: Legacy logic file detected at '$legacyFile'" -ForegroundColor Yellow
            Write-Host "Cleaning up legacy logic file to prevent configuration conflicts..." -ForegroundColor Cyan
            try {
                Remove-Item -Path $legacyFile -Force -ErrorAction Stop
                Write-Host "Cleanup successful: Legacy logic file removed." -ForegroundColor Green
            } catch {
                Write-Warning "Could not remove legacy logic file: $_"
            }
        }
    }
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
    "antigravity" {
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
