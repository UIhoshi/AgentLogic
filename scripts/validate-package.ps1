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
Assert-Exists -Root $RepoRoot -RelativePath "INSTALL.md" -Label "Human install guide"
Assert-Exists -Root $RepoRoot -RelativePath "AGENT_INSTALL.md" -Label "Agent install guide"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/doctor.ps1" -Label "Install doctor"

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json
$schema = Get-Content -Raw -Path $schemaPath | ConvertFrom-Json

$schemaHostNames = @($schema.properties.host_outputs.required)
foreach ($hostName in $manifest.host_outputs.PSObject.Properties.Name) {
    if ($schemaHostNames -notcontains $hostName) {
        Fail "Manifest host output '$hostName' is not declared by manifest.schema.json."
    }
}
$schemaAdapterHostNames = @($schema.properties.adapters.required)
foreach ($hostName in $manifest.adapters.PSObject.Properties.Name) {
    if ($schemaAdapterHostNames -notcontains $hostName) {
        Fail "Manifest adapter '$hostName' is not declared by manifest.schema.json."
    }
}

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
    "install",
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

if ($manifest.current_version -eq "V6.8.0") {
    $operationalModule = "modules/44_V6_8_GrokBuildOperationalIntegration.md"
    Assert-Exists -Root $RepoRoot -RelativePath $operationalModule -Label "V6.8 operational integration module"

    $defaultFiles = @($manifest.profiles.$($manifest.default_profile).files)
    if ($defaultFiles -notcontains $operationalModule) {
        Fail "Default profile '$($manifest.default_profile)' does not include '$operationalModule'."
    }

    $operationalContent = Get-Content -Raw -Path (Join-Path $RepoRoot $operationalModule)
    foreach ($requiredContract in @(
        "Instruction and project-rule discovery contract",
        "Active-state-preserving compaction",
        "Policy compilation and command safety",
        "Extensions, skills, plugins, hooks, and MCP trust",
        "Subagent contract",
        "Headless and automation result contract",
        "Memory and revalidation"
    )) {
        if ($operationalContent -notmatch [regex]::Escape($requiredContract)) {
            Fail "V6.8 operational module is missing required contract: $requiredContract"
        }
    }

    if ($operationalContent -notmatch "https://github.com/xai-org/grok-build") {
        Fail "V6.8 operational module is missing its comparative Grok Build source URL."
    }
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

if (-not $manifest.install) {
    Fail "manifest.json missing install section."
}

Assert-Exists -Root $RepoRoot -RelativePath $manifest.install.stable_entry -Label "Install stable entry"
Assert-Exists -Root $RepoRoot -RelativePath $manifest.install.agent_guide -Label "Install agent guide"
Assert-Exists -Root $RepoRoot -RelativePath $manifest.install.human_guide -Label "Install human guide"
Assert-Exists -Root $RepoRoot -RelativePath $manifest.install.doctor.script -Label "Install doctor script"
Assert-Exists -Root $RepoRoot -RelativePath $manifest.install.validation.script -Label "Install validation script"

foreach ($hostProperty in $manifest.install.hosts.PSObject.Properties) {
    $hostName = $hostProperty.Name
    $installHost = $hostProperty.Value
    Assert-Exists -Root $RepoRoot -RelativePath $installHost.adapter -Label "Install host '$hostName' adapter"
    if (-not $installHost.command) {
        Fail "Install host '$hostName' is missing command."
    }
    if (-not $installHost.output) {
        Fail "Install host '$hostName' is missing output."
    }
}

foreach ($outputProperty in $manifest.host_outputs.PSObject.Properties) {
    $parent = Split-Path -Parent (Join-Path $RepoRoot $outputProperty.Value)
    if (-not $parent) {
        Fail "Host output '$($outputProperty.Name)' has no parent directory."
    }

    $outputPath = Join-Path $RepoRoot $outputProperty.Value
    Assert-Exists -Root $RepoRoot -RelativePath $outputProperty.Value -Label "Host output '$($outputProperty.Name)'"
    $outputContent = Get-Content -Raw -Path $outputPath
    if ($outputContent -notmatch [regex]::Escape("- Version: $($manifest.current_version)")) {
        Fail "Host output '$($outputProperty.Name)' does not declare current version '$($manifest.current_version)'."
    }
    if ($outputContent -match 'file:///([A-Za-z]:|Users/|home/)') {
        Fail "Host output '$($outputProperty.Name)' contains a machine-specific absolute file URI."
    }
    if ($outputContent -match 'AgentLogic_V6_7_0|V6\.7\.0|AgentLogic_V6_7_1') {
        Fail "Host output '$($outputProperty.Name)' contains stale stable-version references."
    }
}

$versionFileToken = ($manifest.current_version -replace '\.', '_')
$expectedMainLogic = "versions/AgentLogic_{0}.md" -f $versionFileToken
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
