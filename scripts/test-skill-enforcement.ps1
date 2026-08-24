# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)
$ErrorActionPreference = 'Stop'
$root = Join-Path ([IO.Path]::GetTempPath()) ("agentlogic-skill-enforcement-test-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $root | Out-Null
function Expect-Failure([scriptblock]$Action, [string]$Label) {
    $failed = $false
    try { & $Action } catch { $failed = $true }
    if (-not $failed) { throw "Expected failure did not occur: $Label" }
}
try {
    & (Join-Path $RepoRoot 'scripts\validate-skill-registry.ps1') -RepoRoot $RepoRoot
    & (Join-Path $RepoRoot 'scripts\validate-skill-routing.ps1') -RepoRoot $RepoRoot

    $statePath = Join-Path $root 'feature.json'
    $gate = Join-Path $RepoRoot 'scripts\skill-enforcement.ps1'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $statePath -TaskId feature -TaskClass major_feature -ChangeScope multi_file -UiScope none -ExternalEffect none -ClaimType behavior_change
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $statePath -AvailableSkill product-requirements-grilling,tdd-guide
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId requirements-grilling -Evidence skill_file_read
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId requirements-grilling -Evidence single_question_dialogue,approved_requirements_brief,brief_validator_result
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId test-design -Evidence test_plan
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId test-design -Evidence relevant_test_or_explicit_gap,command_result

    $uiPath = Join-Path $root 'ui.json'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $uiPath -TaskId ui -TaskClass major_feature -ChangeScope multi_file -UiScope substantial_refactor -ExternalEffect none -ClaimType behavior_change -AvailableSkill product-requirements-grilling,imagegen,senior-frontend,tdd-guide,screenshot
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $uiPath -AvailableSkill product-requirements-grilling,imagegen,senior-frontend,tdd-guide,screenshot
    Expect-Failure { & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-implementation -Evidence senior_frontend_run } 'UI implementation invocation before requirements and UI design close'

    $releasePath = Join-Path $root 'release.json'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $releasePath -TaskId release -TaskClass release -ChangeScope isolated -UiScope none -ExternalEffect remote_release -ClaimType release_review -AvailableSkill code-review,release-manager
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $releasePath -AvailableSkill release-manager,code-review
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId code-review -Evidence code_review_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId code-review -Evidence review_report,severity_and_evidence
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId package-release -Evidence release_manager_run
    Expect-Failure { & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId package-release -Evidence artifact_validation,post_result_inspection } 'remote release without exact target confirmation'

    $packagePath = Join-Path $root 'package.json'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $packagePath -TaskId package -TaskClass package -ChangeScope isolated -UiScope none -ExternalEffect local_package -ClaimType none
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $packagePath
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $packagePath -RouteId package-release -Evidence native_package_validation_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $packagePath -RouteId package-release -Evidence artifact_validation,post_result_inspection



    $fixtureSkills = Join-Path $root 'registry-fixture\skills\example'
    New-Item -ItemType Directory -Force -Path $fixtureSkills | Out-Null
    Set-Content -LiteralPath (Join-Path $fixtureSkills 'SKILL.md') -Value '# example' -Encoding utf8
    $emptyRegistry = Join-Path $root 'registry-fixture\registry.json'
    '{"schema_version":1,"lifecycle_states":["mandatory","conditional","manual_only","archived","deprecated"],"records":[]}' | Set-Content -LiteralPath $emptyRegistry -Encoding utf8
    Expect-Failure { & (Join-Path $RepoRoot 'scripts\validate-skill-registry.ps1') -RepoRoot $RepoRoot -RegistryPath $emptyRegistry -SkillsRoot (Join-Path $root 'registry-fixture\skills') } 'unregistered portable skill'

    $projectRoot = Join-Path $root 'project'
    New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot '.agentlogic') | Out-Null
    '{"schema_version":1,"reviewed_commit":"abc123","skills":[{"skill_id":"tdd-guide","capability":"test_engineering","flows":["validation"],"trigger":"behavior_change","source":"host","status":"active"}]}' | Set-Content -LiteralPath (Join-Path $projectRoot '.agentlogic\skill-usage.json') -Encoding utf8
    "# Code Map`n`n## Skill Usage`n| Flow | Skill | Trigger | Source of truth |`n| --- | --- | --- | --- |`n| validation | tdd-guide | behavior_change | .agentlogic/skill-usage.json |" | Set-Content -LiteralPath (Join-Path $projectRoot 'CODE_MAP.md') -Encoding utf8
    & $gate -Mode validate-project-usage -RepoRoot $RepoRoot -ProjectRoot $projectRoot
    & $gate -Mode validate-project-usage -ProjectRoot $projectRoot

    Write-Host 'Skill enforcement tests passed.'
}
finally {
    if (Test-Path -LiteralPath $root) { Remove-Item -LiteralPath $root -Recurse -Force }
}
