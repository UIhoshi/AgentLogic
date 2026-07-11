param(
    [string]$ProfileName = "core-enhanced",
    [ValidateSet("codex", "claude", "antigravity", "generic")]
    [string]$TargetHost = "generic",
    [string]$OutputPath
)

$ErrorActionPreference = "Stop"

function Get-RepoRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Get-Manifest {
    param([string]$RepoRoot)

    $manifestPath = Join-Path $RepoRoot "manifest.json"
    return Get-Content -Raw -Path $manifestPath | ConvertFrom-Json
}

function Resolve-OutputPath {
    param(
        [string]$RepoRoot,
        [object]$Manifest,
        [string]$TargetHost,
        [string]$RequestedOutputPath
    )

    if ($RequestedOutputPath) {
        return $RequestedOutputPath
    }

    $relative = $Manifest.host_outputs.$TargetHost
    if (-not $relative) {
        throw "No host output configured for '$TargetHost'."
    }

    return Join-Path $RepoRoot $relative
}

function Build-Bundle {
    param(
        [string]$RepoRoot,
        [object]$Manifest,
        [string]$ProfileName,
        [string]$TargetHost
    )

    $profile = $Manifest.profiles.$ProfileName
    if (-not $profile) {
        throw "Unknown profile '$ProfileName'."
    }

    $files = @($profile.files)
    if ($files.Count -eq 0) {
        throw "Profile '$ProfileName' has no files."
    }

    $builder = New-Object System.Text.StringBuilder
    $timestamp = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")

    [void]$builder.AppendLine("# AgentLogic Bundle")
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("- Host target: $TargetHost")
    [void]$builder.AppendLine("- Profile: $ProfileName")
    [void]$builder.AppendLine("- Generated at: $timestamp")
    [void]$builder.AppendLine("- Stable entry: $($Manifest.entry)")
    [void]$builder.AppendLine("- Version: $($Manifest.current_version)")
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("This is a generated primary-logic bundle. Regenerate it from scripts/build-profile.ps1 instead of editing it by hand.")
    [void]$builder.AppendLine()

    foreach ($relativePath in $files) {
        $fullPath = Join-Path $RepoRoot $relativePath
        if (-not (Test-Path $fullPath)) {
            throw "Profile file missing: $relativePath"
        }

        $content = Get-Content -Raw -Path $fullPath
        $content = $content -replace 'file:///REPO_ROOT_PLACEHOLDER/', "file:///$($RepoRoot.Replace('\', '/'))/"
        [void]$builder.AppendLine("---")
        [void]$builder.AppendLine()
        [void]$builder.AppendLine("## BEGIN FILE: $relativePath")
        [void]$builder.AppendLine()
        [void]$builder.AppendLine($content.TrimEnd())
        [void]$builder.AppendLine()
        [void]$builder.AppendLine("## END FILE: $relativePath")
        [void]$builder.AppendLine()
    }

    return $builder.ToString()
}

$repoRoot = Get-RepoRoot
$manifest = Get-Manifest -RepoRoot $repoRoot
$resolvedOutputPath = Resolve-OutputPath -RepoRoot $repoRoot -Manifest $manifest -TargetHost $TargetHost -RequestedOutputPath $OutputPath
$bundle = Build-Bundle -RepoRoot $repoRoot -Manifest $manifest -ProfileName $ProfileName -TargetHost $TargetHost

$outputDir = Split-Path -Parent $resolvedOutputPath
if ($outputDir) {
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
}

[System.IO.File]::WriteAllText($resolvedOutputPath, $bundle, [System.Text.UTF8Encoding]::new($false))
Write-Host "Built profile '$ProfileName' for host '$TargetHost' -> $resolvedOutputPath"
