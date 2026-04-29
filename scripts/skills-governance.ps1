param(
    [ValidateSet("codex", "claude", "gemini", "generic")]
    [string]$TargetHost = "generic",
    [string]$UserHome = $env:USERPROFILE,
    [switch]$Apply
)

$ErrorActionPreference = "Stop"

$recommendedActive = @(
    ".system",
    "engineering",
    "engineering-team",
    "playwright",
    "screenshot",
    "security-best-practices",
    "figma",
    "figma-implement-design",
    "gh-fix-ci"
)

$recommendedArchive = @(
    "business-growth",
    "c-level-advisor",
    "finance",
    "marketing-skill",
    "product-team",
    "project-management",
    "ra-qm-team"
)

function Get-SkillsRoot {
    param(
        [string]$TargetName,
        [string]$UserRoot
    )

    switch ($TargetName) {
        "codex" { return Join-Path $UserRoot ".codex\skills" }
        "claude" { return Join-Path $UserRoot ".claude\skills" }
        "gemini" { return Join-Path $UserRoot ".gemini\skills" }
        default { return $null }
    }
}

function Get-SkillInventory {
    param([string]$SkillsRoot)

    if (-not $SkillsRoot -or -not (Test-Path $SkillsRoot)) {
        return @()
    }

    $items = @()
    foreach ($dir in Get-ChildItem -Path $SkillsRoot -Directory | Sort-Object Name) {
        $count = (Get-ChildItem -Path $dir.FullName -Recurse -Filter SKILL.md -File -ErrorAction SilentlyContinue | Measure-Object).Count
        $items += [pscustomobject]@{
            Name = $dir.Name
            Path = $dir.FullName
            SkillCount = $count
            RecommendedAction = if ($recommendedArchive -contains $dir.Name) { "archive-default" } elseif ($recommendedActive -contains $dir.Name) { "keep-active" } else { "review-manually" }
        }
    }

    return $items
}

function Invoke-ArchivePlan {
    param(
        [string]$SkillsRoot,
        [array]$Inventory
    )

    $archiveRoot = Join-Path (Split-Path -Parent $SkillsRoot) ("skills-archive\{0}" -f (Get-Date -Format "yyyy-MM-dd-AgentLogic-host-local"))
    New-Item -ItemType Directory -Force -Path $archiveRoot | Out-Null

    $moved = @()
    foreach ($item in $Inventory | Where-Object { $_.RecommendedAction -eq "archive-default" }) {
        if (Test-Path $item.Path) {
            Move-Item -LiteralPath $item.Path -Destination $archiveRoot -Force
            $moved += $item.Name
        }
    }

    $readmePath = Join-Path $archiveRoot "README.txt"
    $readme = @"
Archived by AgentLogic host-local skill governance.

Date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Host: $TargetHost

Reason:
- These skill families are not treated as duplicates.
- They are archived off-by-default because they are budget-heavy domain packs and can degrade the visible-skill budget during normal engineering sessions.

Moved families:
$($moved | ForEach-Object { "- $_" } | Out-String)
"@
    Set-Content -Path $readmePath -Value $readme -Encoding UTF8

    return [pscustomobject]@{
        ArchiveRoot = $archiveRoot
        Moved = $moved
    }
}

$skillsRoot = Get-SkillsRoot -TargetName $TargetHost -UserRoot $UserHome

Write-Host "AgentLogic Skill Governance"
Write-Host "==========================="
Write-Host "Target host: $TargetHost"
Write-Host "Rule scope: required on fresh install and host-local logic update"

if (-not $skillsRoot) {
    Write-Host "No host-local skill directory policy applies for this target."
    exit 0
}

Write-Host "Skills root: $skillsRoot"
Write-Host "Portable logic-carried skills: not governed by this pass unless AgentLogic explicitly ships them in a future version."

$inventory = Get-SkillInventory -SkillsRoot $skillsRoot

if ($inventory.Count -eq 0) {
    Write-Host "No skills directory found or no skill families detected."
    exit 0
}

$totalFamilies = $inventory.Count
$totalSkills = ($inventory | Measure-Object SkillCount -Sum).Sum

Write-Host ""
Write-Host "Inventory"
Write-Host "---------"
$inventory | Format-Table Name, SkillCount, RecommendedAction -AutoSize

Write-Host ""
Write-Host "Summary"
Write-Host "-------"
Write-Host "Families: $totalFamilies"
Write-Host "Nested SKILL.md count: $totalSkills"
Write-Host ("Keep-active defaults: {0}" -f (($inventory | Where-Object RecommendedAction -eq "keep-active").Count))
Write-Host ("Archive-default families present: {0}" -f (($inventory | Where-Object RecommendedAction -eq "archive-default").Count))
Write-Host ("Manual-review families present: {0}" -f (($inventory | Where-Object RecommendedAction -eq "review-manually").Count))

if ($Apply) {
    Write-Host ""
    Write-Host "Apply mode"
    Write-Host "----------"
    $result = Invoke-ArchivePlan -SkillsRoot $skillsRoot -Inventory $inventory
    if ($result.Moved.Count -gt 0) {
        Write-Host "Archived families:"
        $result.Moved | ForEach-Object { Write-Host "- $_" }
        Write-Host "Archive root: $($result.ArchiveRoot)"
    }
    else {
        Write-Host "No archive-default families were present to move."
    }
}
else {
    Write-Host ""
    Write-Host "Dry-run only. Re-run with -Apply to archive recommended domain packs."
}
