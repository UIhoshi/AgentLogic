# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [Parameter(Mandatory)][string]$TargetPath,
    [switch]$Verify
)

$ErrorActionPreference = 'Stop'
$payload = @(
    'scripts/skill-enforcement.ps1',
    'contracts/skill-enforcement.json',
    'contracts/skill-routing.json',
    'contracts/skill-registry.json',
    'contracts/skill-workflow-graph.json'
)
foreach ($relative in $payload) {
    $source = Join-Path $RepoRoot $relative
    $target = Join-Path $TargetPath $relative
    if ($Verify) {
        if (-not (Test-Path -LiteralPath $target)) { throw "Skill enforcement payload is missing: $target" }
        if ((Get-FileHash -Algorithm SHA256 -LiteralPath $source).Hash -ne (Get-FileHash -Algorithm SHA256 -LiteralPath $target).Hash) { throw "Skill enforcement payload differs from source: $relative" }
        continue
    }
    $parent = Split-Path -Parent $target
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    Copy-Item -LiteralPath $source -Destination $target -Force
}
if ($Verify) {
    Write-Host "Verified skill enforcement payload: $TargetPath"
} else {
    Write-Host "Deployed skill enforcement payload: $TargetPath"
}
