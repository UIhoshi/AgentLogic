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
