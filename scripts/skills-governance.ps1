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


$recommendedGeminiFlatKeep = @(
    "agent-designer",
    "agent-protocol",
    "agent-workflow-designer",
    "api-design-reviewer",
    "api-test-suite-builder",
    "aws-solution-architect",
    "browserstack",
    "changelog-generator",
    "ci-cd-pipeline-builder",
    "code-reviewer",
    "codebase-onboarding",
    "context-engine",
    "coverage",
    "database-designer",
    "database-schema-designer",
    "dependency-auditor",
    "engineering-bundle",
    "engineering-main",
    "engineering-team-bundle",
    "env-secrets-manager",
    "extract",
    "fix",
    "generate",
    "git-worktree-manager",
    "incident-commander",
    "init",
    "mcp-server-builder",
    "migrate",
    "migration-architect",
    "monorepo-navigator",
    "observability-designer",
    "performance-profiler",
    "playwright-pro",
    "pr-review-expert",
    "promote",
    "rag-architect",
    "release-manager",
    "remember",
    "report",
    "review",
    "runbook-generator",
    "self-improving-agent",
    "senior-architect",
    "senior-backend",
    "senior-computer-vision",
    "senior-data-engineer",
    "senior-data-scientist",
    "senior-devops",
    "senior-frontend",
    "senior-fullstack",
    "senior-ml-engineer",
    "senior-prompt-engineer",
    "senior-qa",
    "senior-secops",
    "senior-security",
    "skill-security-auditor",
    "skills-review",
    "skill-tester",
    "status",
    "stripe-integration-expert",
    "tdd",
    "tdd-guide",
    "tech-debt",
    "tech-debt-tracker",
    "tech-stack-evaluator",
    "testrail",
    "ui-design-system"
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
    param(
        [string]$SkillsRoot,
        [string]$TargetName
    )

    if (-not $SkillsRoot -or -not (Test-Path $SkillsRoot)) {
        return @()
    }

    $dirs = Get-ChildItem -Path $SkillsRoot -Directory | Sort-Object Name
    $counts = @{}
    foreach ($dir in $dirs) {
        $counts[$dir.Name] = (Get-ChildItem -Path $dir.FullName -Recurse -Filter SKILL.md -File -ErrorAction SilentlyContinue | Measure-Object).Count
    }

    $isGeminiFlatMode = $false
    if ($TargetName -eq "gemini") {
        $singleCount = ($counts.Values | Where-Object { $_ -eq 1 } | Measure-Object).Count
        if ($dirs.Count -ge 80 -and $singleCount -ge [Math]::Floor($dirs.Count * 0.9)) {
            $isGeminiFlatMode = $true
        }
    }

    $items = @()
    foreach ($dir in $dirs) {
        $count = $counts[$dir.Name]
        $action = "review-manually"

        if ($recommendedArchive -contains $dir.Name) {
            $action = "archive-default"
        }
        elseif ($recommendedActive -contains $dir.Name) {
            $action = "keep-active"
        }
        elseif ($TargetName -eq "gemini" -and ($recommendedGeminiFlatKeep -contains $dir.Name)) {
            $action = "keep-active"
        }
        elseif ($isGeminiFlatMode) {
            if ($recommendedGeminiFlatKeep -contains $dir.Name) {
                $action = "keep-active"
            }
            else {
                $action = "archive-default"
            }
        }

        $items += [pscustomobject]@{
            Name = $dir.Name
            Path = $dir.FullName
            SkillCount = $count
            RecommendedAction = $action
        }
    }

    return $items
}

function Invoke-ArchivePlan {
    param(
        [string]$SkillsRoot,
        [array]$Inventory
    )

    $archiveRoot = Join-Path (Split-Path -Parent $SkillsRoot) ("skills-archive\{0}" -f ((Get-Date -Format "yyyy-MM-dd") + "-AgentLogic-host-local"))
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
if ($TargetHost -eq "gemini") {
    Write-Host "Flat Gemini inventories are treated with a stricter engineering-first active set by default."
}

$inventory = Get-SkillInventory -SkillsRoot $skillsRoot -TargetName $TargetHost

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
