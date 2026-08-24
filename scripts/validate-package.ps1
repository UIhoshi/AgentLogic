# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

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
Assert-Exists -Root $RepoRoot -RelativePath "scripts/deploy-first-party-skill.ps1" -Label "First-party skill deployer"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/deploy-skill-enforcement.ps1" -Label "Skill enforcement deployer"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/skill-enforcement.ps1" -Label "Skill enforcement workflow gate"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/validate-skill-registry.ps1" -Label "Skill registry validator"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/audit-skill-duplicates.ps1" -Label "Skill duplicate auditor"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/test-skill-registry.ps1" -Label "Skill registry activation test"
Assert-Exists -Root $RepoRoot -RelativePath "scripts/test-skill-enforcement.ps1" -Label "Skill enforcement test"
Assert-Exists -Root $RepoRoot -RelativePath "contracts/host-skill-capabilities.json" -Label "Host skill deployment contract"
Assert-Exists -Root $RepoRoot -RelativePath "contracts/skill-registry.json" -Label "Portable skill registry"
Assert-Exists -Root $RepoRoot -RelativePath "contracts/skill-enforcement.json" -Label "Skill enforcement contract"

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

if ($manifest.current_version -match '^V6\.8\.') {
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

if ($manifest.current_version -match '^V6\.8\.[2-9]') {
    $knowledgeModule = "modules/46_V6_8_ProjectKnowledgeSync.md"
    Assert-Exists -Root $RepoRoot -RelativePath $knowledgeModule -Label "V6.8 project-native knowledge-sync module"

    $defaultFiles = @($manifest.profiles.$($manifest.default_profile).files)
    if ($defaultFiles -notcontains $knowledgeModule) {
        Fail "Default profile '$($manifest.default_profile)' does not include '$knowledgeModule'."
    }

    $knowledgeContent = Get-Content -Raw -Path (Join-Path $RepoRoot $knowledgeModule)
    Assert-Exists -Root $RepoRoot -RelativePath "templates/CODE_MAP.md" -Label "project code-map template"
    foreach ($requiredAnchor in @("AGENTS.md", "PROJECT_MAP.md", "CODE_MAP.md", ".learnings/ERRORS.md", "git fetch --prune")) {
        if ($knowledgeContent -notmatch [regex]::Escape($requiredAnchor)) {
            Fail "V6.8 project-knowledge module is missing required contract: $requiredAnchor"
        }
    }
}

& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RepoRoot 'scripts\validate-skill-routing.ps1') -RepoRoot $RepoRoot
if ($LASTEXITCODE -ne 0) { Fail 'Autonomous skill routing validation failed.' }

if ($manifest.current_version -match '^V6\.8\.[3-9]') {
    $referenceWorkflowModule = "modules/47_V6_8_ReferenceToInterfaceWorkflow.md"
    $routingModule = "modules/48_V6_8_SkillAndToolRouting.md"
    Assert-Exists -Root $RepoRoot -RelativePath $referenceWorkflowModule -Label "V6.8 reference-to-interface workflow module"
    Assert-Exists -Root $RepoRoot -RelativePath $routingModule -Label "V6.8 skill-and-tool routing module"

    $defaultFiles = @($manifest.profiles.$($manifest.default_profile).files)
    foreach ($module in @($referenceWorkflowModule, $routingModule, "modules/49_V6_8_AutonomousSkillEnforcement.md", "contracts/skill-routing.json", "contracts/host-skill-capabilities.json")) {
        if ($defaultFiles -notcontains $module) {
            Fail "Default profile '$($manifest.default_profile)' does not include '$module'."
        }
    }

    foreach ($enforcementAsset in @("modules/53_V6_8_ProgrammingLevelSkillEnforcement.md", "contracts/skill-enforcement.json")) {
        if ($defaultFiles -notcontains $enforcementAsset) {
            Fail "Default profile '$($manifest.default_profile)' does not include '$enforcementAsset'."
        }
    }

    foreach ($adapter in @($manifest.adapters.PSObject.Properties.Value)) {
        $adapterContent = Get-Content -Raw -Path (Join-Path $RepoRoot $adapter)
        if ($adapterContent -notmatch [regex]::Escape("deploy-first-party-skill.ps1")) {
            Fail "Adapter '$adapter' does not deploy the required first-party skill."
        }
        if ($adapterContent -notmatch [regex]::Escape("deploy-skill-enforcement.ps1") -or $adapterContent -notmatch [regex]::Escape("-Verify")) {
            Fail "Adapter '$adapter' does not deploy and post-verify the skill enforcement payload."
        }
    }

    $referenceContent = Get-Content -Raw -Path (Join-Path $RepoRoot $referenceWorkflowModule)
    foreach ($requiredAnchor in @("MengTo/Skills", "UI Preview Gate", "does not import")) {
        if ($referenceContent -notmatch [regex]::Escape($requiredAnchor)) {
            Fail "Reference-to-interface workflow is missing required contract: $requiredAnchor"
        }
    }

    $routingContent = Get-Content -Raw -Path (Join-Path $RepoRoot $routingModule)
    foreach ($requiredAnchor in @("Mandatory routing procedure", "Problem-to-path matrix", "Skill available")) {
        if ($routingContent -notmatch [regex]::Escape($requiredAnchor)) {
            Fail "Skill-and-tool routing module is missing required contract: $requiredAnchor"
        }
    }
}

$buildScript = Join-Path $RepoRoot "scripts\build-profile.ps1"
foreach ($hostName in $manifest.host_outputs.PSObject.Properties.Name) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $buildScript -ProfileName $manifest.default_profile -TargetHost $hostName -Verify
    if ($LASTEXITCODE -ne 0) {
        Fail "Host output '$hostName' does not match a generated '$($manifest.default_profile)' profile bundle."
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
