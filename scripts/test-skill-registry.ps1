# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)

$ErrorActionPreference = 'Stop'
$registryPath = Join-Path $RepoRoot 'contracts\skill-registry.json'
$skillsRoot = Join-Path $RepoRoot 'skills'
$validator = Join-Path $RepoRoot 'scripts\validate-skill-registry.ps1'
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ("agentlogic-skill-registry-test-" + [guid]::NewGuid())
New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null

function Assert-ValidatorFails([string]$Label, [scriptblock]$Mutate) {
    $candidatePath = Join-Path $tempRoot ("$Label.json")
    $candidate = Get-Content -Raw -Encoding UTF8 -LiteralPath $registryPath | ConvertFrom-Json
    & $Mutate $candidate
    [IO.File]::WriteAllText($candidatePath, ($candidate | ConvertTo-Json -Depth 20), [Text.UTF8Encoding]::new($false))
    $failedAsExpected = $false
    try {
        & powershell -NoProfile -ExecutionPolicy Bypass -File $validator -RepoRoot $RepoRoot -RegistryPath $candidatePath -SkillsRoot $skillsRoot 2>$null | Out-Null
        $failedAsExpected = $LASTEXITCODE -ne 0
    } catch {
        $failedAsExpected = $true
    }
    if (-not $failedAsExpected) { throw "Registry validator accepted invalid activation fixture '$Label'." }
}

try {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $validator -RepoRoot $RepoRoot -RegistryPath $registryPath -SkillsRoot $skillsRoot
    if ($LASTEXITCODE -ne 0) { throw 'Registry validator rejected the valid registry.' }
    Assert-ValidatorFails -Label 'route-trigger-drift' -Mutate {
        param($candidate)
        $target = @($candidate.records | Where-Object { $_.lifecycle -in @('mandatory','conditional') })[0]
        $target.activation.triggers = @('incorrect_trigger')
    }
    Assert-ValidatorFails -Label 'manual-trigger-drift' -Mutate {
        param($candidate)
        $target = @($candidate.records | Where-Object { $_.lifecycle -eq 'manual_only' })[0]
        $target.activation.triggers = @('incorrect_trigger')
    }
    Write-Host 'Skill registry activation regression tests passed.'
}
finally {
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}
