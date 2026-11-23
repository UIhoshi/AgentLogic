# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$OutputDir
)

$ErrorActionPreference = 'Stop'

$manifestPath = Join-Path $RepoRoot 'manifest.json'
if (-not (Test-Path -LiteralPath $manifestPath)) {
    throw "Missing manifest.json: $manifestPath"
}

$manifest = Get-Content -Raw -Encoding UTF8 -LiteralPath $manifestPath | ConvertFrom-Json
$rawVersion = ([string]$manifest.current_version).TrimStart('V', 'v')
if ([string]::IsNullOrWhiteSpace($OutputDir)) {
    $OutputDir = [IO.Path]::Combine($RepoRoot, 'dist', 'codex-plugin')
}

$pluginMetaDir = Join-Path $OutputDir '.codex-plugin'
$marketplaceDir = [IO.Path]::Combine($OutputDir, '.agents', 'plugins')
$skillsDestRoot = Join-Path $OutputDir 'skills'
$firstSkillTarget = Join-Path $skillsDestRoot 'product-requirements-grilling'

New-Item -ItemType Directory -Force -Path $pluginMetaDir | Out-Null
New-Item -ItemType Directory -Force -Path $marketplaceDir | Out-Null
New-Item -ItemType Directory -Force -Path $skillsDestRoot | Out-Null

$psExe = if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh' } else { 'powershell' }
$deploySkillScript = [IO.Path]::Combine($RepoRoot, 'scripts', 'deploy-first-party-skill.ps1')
& $psExe -NoProfile -ExecutionPolicy Bypass -File $deploySkillScript -RepoRoot $RepoRoot -TargetPath $firstSkillTarget
if ($LASTEXITCODE -ne 0) {
    throw "deploy-first-party-skill.ps1 failed while building Codex plugin bundle."
}

$pluginManifest = [ordered]@{
    name = 'agentlogic'
    version = $rawVersion
    description = 'AgentLogic cross-host governance, Turn 1 11-role & Subagent squad routing, design-first UI mockups, and 17 habitual auto-triggered first-party skills.'
    author = [ordered]@{
        name = 'UIhoshi'
        url = 'https://github.com/UIhoshi/AgentLogic'
    }
    homepage = 'https://github.com/UIhoshi/AgentLogic'
    repository = 'https://github.com/UIhoshi/AgentLogic'
    license = 'MIT'
    keywords = @(
        'agentlogic',
        'codex',
        'governance',
        'sdd',
        'ui-ux',
        'appsec',
        'data-visualization',
        'skills'
    )
    skills = './skills/'
    interface = [ordered]@{
        displayName = 'AgentLogic'
        shortDescription = 'Habitual auto-triggered skills and blocking quality gates'
        longDescription = 'Bundles AgentLogic first-party portable skills (requirements grilling, 11-role + Subagent squad routing, pure UI/UX design, modern web, Chrome MV3, data visualization, web games, Office/PDF, multimodal video/audio, novel continuity, manga/short-video/screenplay scripts, diagrams, AppSec review, GitHub PR/CI triage, code simplification, decompilation, and skill evaluation).'
        developerName = 'UIhoshi'
        category = 'Developer Tools'
        capabilities = @(
            'Interactive',
            'Read',
            'Write'
        )
        websiteURL = 'https://github.com/UIhoshi/AgentLogic'
        defaultPrompt = @(
            'Start a new project with AgentLogic Gate 1 role recommendation and skill routing.',
            'Review my diff with AppSec three-state triage and Self-Refute First rigor.',
            'Evaluate a local SKILL.md for trigger precision and token budget.'
        )
    }
}

$marketplaceManifest = [ordered]@{
    name = 'agentlogic-local'
    interface = [ordered]@{
        displayName = 'AgentLogic Local Plugin Marketplace'
    }
    plugins = @(
        [ordered]@{
            name = 'agentlogic'
            source = [ordered]@{
                source = 'local'
                path = './'
            }
            policy = [ordered]@{
                installation = 'AVAILABLE'
                authentication = 'ON_INSTALL'
            }
            category = 'Developer Tools'
        }
    )
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$pluginJsonPath = Join-Path $pluginMetaDir 'plugin.json'
$marketplaceJsonPath = Join-Path $marketplaceDir 'marketplace.json'

[System.IO.File]::WriteAllText($pluginJsonPath, (($pluginManifest | ConvertTo-Json -Depth 10) + "`n"), $utf8NoBom)
[System.IO.File]::WriteAllText($marketplaceJsonPath, (($marketplaceManifest | ConvertTo-Json -Depth 10) + "`n"), $utf8NoBom)

Write-Host "Built standard Codex plugin bundle -> $OutputDir"
Write-Host "Plugin manifest : $pluginJsonPath"
Write-Host "Marketplace json: $marketplaceJsonPath"
