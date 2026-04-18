[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern("^V[0-9A-Za-z._-]+$")]
    [string]$NewVersion,
    [string]$RepoRoot,
    [switch]$SkipVersionFileCopy
)

$ErrorActionPreference = "Stop"

if (-not $RepoRoot) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Read-Utf8File {
    param([string]$Path)
    return [System.IO.File]::ReadAllText($Path, [System.Text.UTF8Encoding]::new($false))
}

function Write-Utf8File {
    param(
        [string]$Path,
        [string]$Content
    )

    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Replace-InFile {
    param(
        [string]$Path,
        [string]$OldValue,
        [string]$NewValue
    )

    $content = Read-Utf8File -Path $Path
    $updated = $content.Replace($OldValue, $NewValue)
    if ($updated -ne $content) {
        if ($PSCmdlet.ShouldProcess($Path, "Replace '$OldValue' with '$NewValue'")) {
            Write-Utf8File -Path $Path -Content $updated
        }
    }
}

$manifestPath = Join-Path $RepoRoot "manifest.json"
if (-not (Test-Path $manifestPath)) {
    throw "manifest.json not found at $manifestPath"
}

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json
$oldVersion = [string]$manifest.current_version
$oldMainLogicFile = [string]$manifest.main_logic_file
$newMainLogicFile = "versions/AgentLogic_{0}.md" -f $NewVersion
$oldVersionToken = "AgentLogic_{0}" -f $oldVersion
$newVersionToken = "AgentLogic_{0}" -f $NewVersion

if ($oldVersion -eq $NewVersion) {
    throw "NewVersion matches the current version '$oldVersion'."
}

$oldMainLogicPath = Join-Path $RepoRoot $oldMainLogicFile
$newMainLogicPath = Join-Path $RepoRoot $newMainLogicFile

if (-not (Test-Path $oldMainLogicPath)) {
    throw "Current main logic file not found: $oldMainLogicFile"
}

if ((Test-Path $newMainLogicPath) -and -not $SkipVersionFileCopy) {
    throw "Target version file already exists: $newMainLogicFile"
}

if (-not $SkipVersionFileCopy) {
    $versionContent = Read-Utf8File -Path $oldMainLogicPath
    $versionContent = $versionContent.Replace($oldVersionToken, $newVersionToken)
    $versionContent = $versionContent.Replace($oldMainLogicFile, $newMainLogicFile)

    if ($PSCmdlet.ShouldProcess($newMainLogicPath, "Create new version file from $oldMainLogicFile")) {
        $newMainLogicDir = Split-Path -Parent $newMainLogicPath
        if ($newMainLogicDir) {
            New-Item -ItemType Directory -Force -Path $newMainLogicDir | Out-Null
        }
        Write-Utf8File -Path $newMainLogicPath -Content $versionContent
    }
}

$manifest.current_version = $NewVersion
$manifest.main_logic_file = $newMainLogicFile

foreach ($profile in $manifest.profiles.PSObject.Properties.Value) {
    for ($i = 0; $i -lt $profile.files.Count; $i++) {
        if ($profile.files[$i] -eq $oldMainLogicFile) {
            $profile.files[$i] = $newMainLogicFile
        }
    }
}

if ($PSCmdlet.ShouldProcess($manifestPath, "Update manifest current_version and main_logic_file")) {
    $manifestJson = $manifest | ConvertTo-Json -Depth 10
    Write-Utf8File -Path $manifestPath -Content ($manifestJson + "`r`n")
}

$gitPrefix = (Join-Path $RepoRoot ".git") + [System.IO.Path]::DirectorySeparatorChar
$distPrefix = (Join-Path $RepoRoot "dist") + [System.IO.Path]::DirectorySeparatorChar

$markdownFiles = Get-ChildItem -Path $RepoRoot -Recurse -File -Filter *.md |
    Where-Object {
        $_.FullName -ne $oldMainLogicPath -and
        -not $_.FullName.StartsWith($gitPrefix, [System.StringComparison]::OrdinalIgnoreCase) -and
        -not $_.FullName.StartsWith($distPrefix, [System.StringComparison]::OrdinalIgnoreCase)
    }

foreach ($file in $markdownFiles) {
    Replace-InFile -Path $file.FullName -OldValue $oldMainLogicFile -NewValue $newMainLogicFile
    Replace-InFile -Path $file.FullName -OldValue $oldVersionToken -NewValue $newVersionToken
}

Write-Host "Prepared AgentLogic release update."
Write-Host "Old version: $oldVersion"
Write-Host "New version: $NewVersion"
Write-Host "Main logic file: $newMainLogicFile"
Write-Host "Next step: run scripts/validate-package.ps1"
