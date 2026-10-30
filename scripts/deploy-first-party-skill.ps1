# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [Parameter(Mandatory)][string]$TargetPath
)
$ErrorActionPreference = 'Stop'
$source = Join-Path $RepoRoot 'skills\productivity\product-requirements-grilling'
if (-not (Test-Path (Join-Path $source 'SKILL.md'))) { throw "Missing first-party product requirements skill: $source" }
$parent = Split-Path -Parent $TargetPath
if (-not $parent) { throw "Skill target must have a parent directory: $TargetPath" }
New-Item -ItemType Directory -Force -Path $parent | Out-Null
if (Test-Path $TargetPath) { Remove-Item -LiteralPath $TargetPath -Recurse -Force }
Copy-Item -LiteralPath $source -Destination $TargetPath -Recurse -Force
if (-not (Test-Path (Join-Path $TargetPath 'SKILL.md'))) { throw "Skill deployment did not create SKILL.md: $TargetPath" }
Write-Host "Deployed first-party product requirements skill: $TargetPath"

$companionSkills = @(
    @{ Name = 'role-persona-router'; Relative = 'skills\productivity\role-persona-router' },
    @{ Name = 'ui-ux-pro-max'; Relative = 'skills\design\ui-ux-pro-max' },
    @{ Name = 'multimodal-media-director'; Relative = 'skills\creative\multimodal-media-director' },
    @{ Name = 'office-pro-suite'; Relative = 'skills\productivity\office-pro-suite' },
    @{ Name = 'novel-story-architect'; Relative = 'skills\creative\novel-story-architect' },
    @{ Name = 'diagram-flowchart-architect'; Relative = 'skills\engineering\diagram-flowchart-architect' },
    @{ Name = 'code-simplifier'; Relative = 'skills\engineering\code-simplifier' },
    @{ Name = 'decompile-reconstruction'; Relative = 'skills\engineering\decompile-reconstruction' }
)
foreach ($skill in $companionSkills) {
    $skillSource = Join-Path $RepoRoot $skill.Relative
    if (-not (Test-Path (Join-Path $skillSource 'SKILL.md'))) { throw "Missing first-party skill '$($skill.Name)': $skillSource" }
    $skillDest = Join-Path $parent $skill.Name
    if (Test-Path $skillDest) { Remove-Item -LiteralPath $skillDest -Recurse -Force }
    Copy-Item -LiteralPath $skillSource -Destination $skillDest -Recurse -Force
    if (-not (Test-Path (Join-Path $skillDest 'SKILL.md'))) { throw "Skill deployment did not create SKILL.md: $skillDest" }
    Write-Host "Deployed first-party skill: $skillDest"
}
