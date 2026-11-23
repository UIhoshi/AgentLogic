# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$TargetPath,
    [int]$MaxFirstPartyBytes = 32768,
    [int]$MaxWarnBytes = 16384,
    [switch]$FailOnFirstPartyErrors
)

$ErrorActionPreference = 'Stop'

function Get-FrontmatterInfo {
    param([string]$RawText)
    $lines = @($RawText -split "\r?\n")
    if ($lines.Count -lt 3 -or $lines[0].Trim() -ne '---') {
        return [pscustomobject]@{ HasFrontmatter = $false; Name = $null; Description = $null; UnquotedHashComment = $false }
    }
    $endIdx = -1
    for ($i = 1; $i -lt [Math]::Min($lines.Count, 80); $i++) {
        if ($lines[$i].Trim() -eq '---') {
            $endIdx = $i
            break
        }
    }
    if ($endIdx -lt 0) {
        return [pscustomobject]@{ HasFrontmatter = $false; Name = $null; Description = $null; UnquotedHashComment = $false }
    }
    $nameVal = $null
    $descVal = $null
    $hasHashTruncation = $false
    for ($i = 1; $i -lt $endIdx; $i++) {
        $line = $lines[$i]
        if ($line -match '^name\s*:\s*(?<v>.+?)\s*$') {
            $rawV = $Matches.v.Trim()
            if ($rawV -notmatch '^[''"]' -and $rawV -match '\s#') { $hasHashTruncation = $true }
            $nameVal = $rawV.Trim('"', "'")
        } elseif ($line -match '^description\s*:\s*(?<v>.*)\s*$') {
            $rawV = $Matches.v.Trim()
            if ($rawV -match '^[\|\>][+-]?$') {
                $blockLines = @()
                while (($i + 1) -lt $endIdx -and $lines[$i + 1] -match '^\s+\S') {
                    $i++
                    $blockLines += $lines[$i].Trim()
                }
                $descVal = ($blockLines -join ' ').Trim()
            } else {
                if ($rawV -notmatch '^[''"]' -and $rawV -match '\s#') { $hasHashTruncation = $true }
                $descVal = $rawV.Trim('"', "'")
            }
        }
    }
    return [pscustomobject]@{
        HasFrontmatter = $true
        Name = $nameVal
        Description = $descVal
        UnquotedHashComment = $hasHashTruncation
    }
}

$firstPartyList = @(
    'skills/productivity/product-requirements-grilling/SKILL.md',
    'skills/productivity/role-persona-router/SKILL.md',
    'skills/design/ui-ux-pro-max/SKILL.md',
    'skills/creative/multimodal-media-director/SKILL.md',
    'skills/productivity/office-pro-suite/SKILL.md',
    'skills/creative/novel-story-architect/SKILL.md',
    'skills/engineering/diagram-flowchart-architect/SKILL.md',
    'skills/engineering/code-simplifier/SKILL.md',
    'skills/engineering/decompile-reconstruction/SKILL.md',
    'skills/frontend/modern-web-guidance/SKILL.md',
    'skills/frontend/chrome-extensions/SKILL.md',
    'skills/engineering/appsec-review/SKILL.md',
    'skills/frontend/web-data-visualization/SKILL.md',
    'skills/engineering/gh-pr-ci-triage/SKILL.md',
    'skills/engineering/skill-evaluator/SKILL.md',
    'skills/frontend/web-game-studio/SKILL.md',
    'skills/creative/screenplay-manga-director/SKILL.md'
)

$scanRoot = if ($TargetPath) {
    if ([System.IO.Path]::IsPathRooted($TargetPath)) { $TargetPath } else { Join-Path $RepoRoot $TargetPath }
} else {
    Join-Path $RepoRoot 'skills'
}

if (-not (Test-Path -LiteralPath $scanRoot)) {
    throw "Skill evaluation target not found: $scanRoot"
}

$skillFiles = if ((Get-Item -LiteralPath $scanRoot).PSIsContainer) {
    @(Get-ChildItem -LiteralPath $scanRoot -Recurse -File -Filter 'SKILL.md')
} else {
    @(Get-Item -LiteralPath $scanRoot)
}

$utf8 = [System.Text.UTF8Encoding]::new($false)
$resolvedRepo = (Resolve-Path -LiteralPath $RepoRoot).Path
$results = @()
$firstPartyFailures = @()
$totalBytes = 0
$totalTokens = 0

foreach ($file in $skillFiles) {
    $raw = [System.IO.File]::ReadAllText($file.FullName, $utf8)
    $bytes = ([System.Text.Encoding]::UTF8.GetByteCount($raw))
    $estTokens = [int][Math]::Ceiling($bytes / 4.0)
    $totalBytes += $bytes
    $totalTokens += $estTokens

    $rel = $file.FullName
    if ($rel.StartsWith($resolvedRepo, [System.StringComparison]::OrdinalIgnoreCase)) {
        $rel = $rel.Substring($resolvedRepo.Length).TrimStart('\', '/').Replace('\', '/')
    }
    $isFirstParty = ($firstPartyList -contains $rel)
    $fm = Get-FrontmatterInfo -RawText $raw

    $brokenLinks = 0
    $escapingLinks = 0
    if ($isFirstParty) {
        $skillDirFull = [System.IO.Path]::GetFullPath((Split-Path -Parent $file.FullName))
        if (-not $skillDirFull.EndsWith([string][System.IO.Path]::DirectorySeparatorChar)) {
            $skillDirFull += [System.IO.Path]::DirectorySeparatorChar
        }
        $linkMatches = [System.Text.RegularExpressions.Regex]::Matches($raw, '\[[^\]]*\]\(([^)]+)\)')
        foreach ($m in $linkMatches) {
            $linkTarget = $m.Groups[1].Value.Split('#')[0].Trim().Trim('<', '>')
            if ([string]::IsNullOrWhiteSpace($linkTarget) -or $linkTarget -match '^(https?:|mailto:|file:|app:)') { continue }
            $resolvedFull = [System.IO.Path]::GetFullPath((Join-Path $skillDirFull ($linkTarget.Replace('/', [System.IO.Path]::DirectorySeparatorChar))))
            if (-not $resolvedFull.StartsWith($skillDirFull, [System.StringComparison]::OrdinalIgnoreCase)) {
                $escapingLinks++
            } elseif (-not (Test-Path -LiteralPath $resolvedFull)) {
                $brokenLinks++
            }
        }
    }

    $issues = @()
    if (-not $fm.HasFrontmatter) { $issues += 'missing_frontmatter' }
    if ([string]::IsNullOrWhiteSpace($fm.Name)) { $issues += 'missing_name' }
    if ([string]::IsNullOrWhiteSpace($fm.Description)) { $issues += 'missing_description' }
    if ($fm.UnquotedHashComment) { $issues += 'unquoted_yaml_hash_comment' }
    if ($isFirstParty -and $bytes -gt $MaxFirstPartyBytes) { $issues += "oversized_first_party($bytes>$MaxFirstPartyBytes)" }
    elseif ($bytes -gt $MaxWarnBytes) { $issues += "oversized_warn($bytes>$MaxWarnBytes)" }
    if ($brokenLinks -gt 0) { $issues += "broken_links($brokenLinks)" }
    if ($escapingLinks -gt 0) { $issues += "escaping_skill_dir_links($escapingLinks)" }

    $blockingIssues = @($issues | Where-Object { $_ -notmatch '^oversized_warn\(' })
    if ($isFirstParty -and $blockingIssues.Count -gt 0) {
        $firstPartyFailures += "$rel`: $($blockingIssues -join ', ')"
    }

    $results += [pscustomobject]@{
        Path = $rel
        FirstParty = $isFirstParty
        Name = $fm.Name
        Bytes = $bytes
        EstTokens = $estTokens
        Issues = ($issues -join '; ')
    }
}

$missingDescCount = @($results | Where-Object { $_.Issues -match 'missing_description' }).Count
$missingNameCount = @($results | Where-Object { $_.Issues -match 'missing_name' }).Count
$oversizedCount = @($results | Where-Object { $_.Issues -match 'oversized_' }).Count

Write-Host "Skill Evaluation Summary (At a Glance)"
Write-Host "  Evaluated SKILL.md files : $($results.Count)"
Write-Host "  First-party skills found : $(@($results | Where-Object FirstParty).Count)"
Write-Host "  Total size / est tokens  : $totalBytes bytes (~$totalTokens tokens)"
Write-Host "  Missing name / desc      : $missingNameCount / $missingDescCount"
Write-Host "  Oversized warnings       : $oversizedCount"

if ($firstPartyFailures.Count -gt 0) {
    Write-Host "Fix First (First-Party Skill Issues):"
    foreach ($failItem in $firstPartyFailures) {
        Write-Host "  - $failItem"
    }
    if ($FailOnFirstPartyErrors) {
        throw "First-party skill evaluation failed ($($firstPartyFailures.Count) issue(s))."
    }
} else {
    Write-Host "First-party skill hygiene, frontmatter, token budgets, and links: PASS."
}
