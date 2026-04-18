param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

function Fail {
    param([string]$Message)
    throw $Message
}

function Assert-Exists {
    param(
        [string]$Root,
        [string]$RelativePath,
        [string]$Label
    )

    $fullPath = Join-Path $Root $RelativePath
    if (-not (Test-Path $fullPath)) {
        Fail "$Label missing: $RelativePath"
    }
}

$manifestPath = Join-Path $RepoRoot "manifest.json"
$schemaPath = Join-Path $RepoRoot "manifest.schema.json"

Assert-Exists -Root $RepoRoot -RelativePath "manifest.json" -Label "Manifest"
Assert-Exists -Root $RepoRoot -RelativePath "manifest.schema.json" -Label "Manifest schema"
Assert-Exists -Root $RepoRoot -RelativePath "MAIN.md" -Label "Stable entry"
Assert-Exists -Root $RepoRoot -RelativePath "00_START_HERE.md" -Label "Human entry"
Assert-Exists -Root $RepoRoot -RelativePath "install.ps1" -Label "PowerShell installer"
Assert-Exists -Root $RepoRoot -RelativePath "install.sh" -Label "Shell installer"

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json

$requiredTopLevelKeys = @(
    "name",
    "role",
    "description",
    "entry",
    "current_version",
    "main_logic_file",
    "default_profile",
    "profiles",
    "optional_modules",
    "host_outputs",
    "adapters",
    "notes"
)

foreach ($key in $requiredTopLevelKeys) {
    if (-not ($manifest.PSObject.Properties.Name -contains $key)) {
        Fail "manifest.json missing required key: $key"
    }
}

Assert-Exists -Root $RepoRoot -RelativePath $manifest.entry -Label "Manifest entry"
Assert-Exists -Root $RepoRoot -RelativePath $manifest.main_logic_file -Label "Main logic file"

if (-not ($manifest.profiles.PSObject.Properties.Name -contains $manifest.default_profile)) {
    Fail "Default profile '$($manifest.default_profile)' is not defined in manifest.profiles."
}

foreach ($profileProperty in $manifest.profiles.PSObject.Properties) {
    $profileName = $profileProperty.Name
    $profile = $profileProperty.Value

    if (-not $profile.description) {
        Fail "Profile '$profileName' is missing description."
    }

    $files = @($profile.files)
    if ($files.Count -eq 0) {
        Fail "Profile '$profileName' has no files."
    }

    foreach ($file in $files) {
        Assert-Exists -Root $RepoRoot -RelativePath $file -Label "Profile '$profileName' file"
    }
}

foreach ($groupProperty in $manifest.optional_modules.PSObject.Properties) {
    foreach ($item in @($groupProperty.Value)) {
        Assert-Exists -Root $RepoRoot -RelativePath $item -Label "Optional module '$($groupProperty.Name)' item"
    }
}

foreach ($adapterProperty in $manifest.adapters.PSObject.Properties) {
    Assert-Exists -Root $RepoRoot -RelativePath $adapterProperty.Value -Label "Adapter '$($adapterProperty.Name)'"
}

foreach ($outputProperty in $manifest.host_outputs.PSObject.Properties) {
    $parent = Split-Path -Parent (Join-Path $RepoRoot $outputProperty.Value)
    if (-not $parent) {
        Fail "Host output '$($outputProperty.Name)' has no parent directory."
    }
}

$expectedMainLogic = "versions/AgentLogic_{0}.md" -f $manifest.current_version
if ($manifest.main_logic_file -ne $expectedMainLogic) {
    Fail "main_logic_file '$($manifest.main_logic_file)' does not match current_version '$($manifest.current_version)'. Expected '$expectedMainLogic'."
}

$startHere = Get-Content -Raw -Path (Join-Path $RepoRoot "00_START_HERE.md")
if ($startHere -notmatch [regex]::Escape($manifest.main_logic_file)) {
    Fail "00_START_HERE.md does not reference the current main_logic_file."
}

$readme = Get-Content -Raw -Path (Join-Path $RepoRoot "README.md")
if ($readme -notmatch [regex]::Escape($manifest.entry)) {
    Fail "README.md does not reference the stable entry defined by manifest.entry."
}

Write-Host "AgentLogic package validation passed."
Write-Host "Repo root: $RepoRoot"
Write-Host "Default profile: $($manifest.default_profile)"
Write-Host "Current version: $($manifest.current_version)"
