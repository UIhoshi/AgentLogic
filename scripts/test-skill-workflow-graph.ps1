# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)
$ErrorActionPreference = 'Stop'
$validator = Join-Path $RepoRoot 'scripts\validate-skill-workflow-graph.ps1'
$source = Join-Path $RepoRoot 'contracts\skill-workflow-graph.json'
$temp = Join-Path ([IO.Path]::GetTempPath()) ("agentlogic-skill-workflow-graph-" + [guid]::NewGuid().ToString('N') + '.json')
try {
    & $validator -RepoRoot $RepoRoot
    $invalid = Get-Content -Raw -Encoding UTF8 -LiteralPath $source | ConvertFrom-Json
    @($invalid.nodes | Where-Object id -eq 'requirements-grilling')[0].requires = @('handover')
    [IO.File]::WriteAllText($temp, ($invalid | ConvertTo-Json -Depth 20), [Text.UTF8Encoding]::new($false))
    $failed = $false
    try { & $validator -RepoRoot $RepoRoot -GraphPath $temp } catch { $failed = $true }
    if (-not $failed) { throw 'Workflow graph validator accepted a cyclic dependency fixture.' }
    $invalid = Get-Content -Raw -Encoding UTF8 -LiteralPath $source | ConvertFrom-Json
    @($invalid.nodes | Where-Object id -eq 'image-mockup')[0].user_skill_selection_required = $true
    [IO.File]::WriteAllText($temp, ($invalid | ConvertTo-Json -Depth 20), [Text.UTF8Encoding]::new($false))
    $failed = $false
    try { & $validator -RepoRoot $RepoRoot -GraphPath $temp } catch { $failed = $true }
    if (-not $failed) { throw 'Workflow graph validator accepted a user-skill-selection fixture.' }
    Write-Host 'Skill workflow graph regression tests passed.'
}
finally {
    Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
}
