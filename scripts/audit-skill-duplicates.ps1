# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param(
    [string]$SkillsRoot = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot '..')) 'skills'),
    [switch]$FailOnCandidates
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $SkillsRoot)) { throw "Missing portable skills root: $SkillsRoot" }
$resolvedRoot = (Resolve-Path -LiteralPath $SkillsRoot).Path

function Get-DeclaredSkillName([string]$Path) {
    $lines = @(Get-Content -LiteralPath $Path -TotalCount 80 -Encoding UTF8)
    if ($lines.Count -lt 3 -or $lines[0] -ne '---') { return $null }
    $end = [Array]::IndexOf($lines, '---', 1)
    if ($end -lt 0) { return $null }
    foreach ($line in @($lines[1..($end - 1)])) {
        if ($line -match '^name\s*:\s*(?<value>.+?)\s*$') {
            return $Matches.value.Trim().Trim('"', "'")
        }
    }
    return $null
}

$entries = foreach ($file in Get-ChildItem -LiteralPath $resolvedRoot -Recurse -File -Filter SKILL.md) {
    [pscustomobject]@{
        Path = 'skills/' + $file.FullName.Substring($resolvedRoot.Length).TrimStart([char]'\', [char]'/' ).Replace([string][char]'\', '/')
        Hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
        DeclaredName = Get-DeclaredSkillName -Path $file.FullName
    }
}
$exact = @($entries | Group-Object Hash | Where-Object Count -gt 1)
$names = @($entries | Where-Object { -not [string]::IsNullOrWhiteSpace($_.DeclaredName) } | Group-Object DeclaredName | Where-Object Count -gt 1)
$missingNames = @($entries | Where-Object { [string]::IsNullOrWhiteSpace($_.DeclaredName) })

Write-Host "Audited $($entries.Count) portable SKILL.md entries."
if ($exact.Count -eq 0) { Write-Host 'Exact-content duplicate candidates: none.' }
else {
    Write-Host 'Exact-content duplicate candidates:'
    foreach ($group in $exact) { Write-Host "- SHA-256 $($group.Name)"; $group.Group | ForEach-Object { Write-Host "  - $($_.Path)" } }
}
if ($names.Count -eq 0) { Write-Host 'Duplicate declared-name candidates: none.' }
else {
    Write-Host 'Duplicate declared-name candidates:'
    foreach ($group in $names) { Write-Host "- $($group.Name)"; $group.Group | ForEach-Object { Write-Host "  - $($_.Path)" } }
}
if ($missingNames.Count -gt 0) { Write-Host "Entries without a YAML front-matter name: $($missingNames.Count)." }

if ($FailOnCandidates -and ($exact.Count -gt 0 -or $names.Count -gt 0)) { throw 'Duplicate candidates require human equivalence review before deletion.' }
