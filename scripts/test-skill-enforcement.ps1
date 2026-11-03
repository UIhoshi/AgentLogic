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
function New-Artifact([string]$Name) {
    $path = Join-Path $root ("artifacts\\$Name.txt")
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $path) | Out-Null
    Set-Content -LiteralPath $path -Value "evidence:$Name" -Encoding utf8
    return $path
}
try {
    & (Join-Path $RepoRoot 'scripts\validate-skill-registry.ps1') -RepoRoot $RepoRoot
    & (Join-Path $RepoRoot 'scripts\validate-skill-routing.ps1') -RepoRoot $RepoRoot

    $statePath = Join-Path $root 'feature.json'
    $gate = Join-Path $RepoRoot 'scripts\skill-enforcement.ps1'
    $featureBrief = New-Artifact 'feature-requirements-brief'
    $featureBehavior = New-Artifact 'feature-behavior-result'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $statePath -TaskId feature -TaskClass major_feature -ChangeScope multi_file -UiScope none -ExternalEffect none -ClaimType behavior_change
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $statePath -AvailableSkill product-requirements-grilling,tdd-guide
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId requirements-grilling -Evidence skill_file_read
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId requirements-grilling -Evidence single_question_dialogue,approved_requirements_brief,brief_validator_result -Artifact "requirements_brief=$featureBrief"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId test-design -Evidence test_plan
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $statePath -RouteId test-design -Evidence relevant_test_or_explicit_gap,command_result -Artifact "behavior_result=$featureBehavior"

    $uiPath = Join-Path $root 'ui.json'
    $uiBrief = New-Artifact 'ui-requirements-brief'; $designDirection = New-Artifact 'ui-design-direction'; $mockup = New-Artifact 'ui-mockup'; $implementation = New-Artifact 'ui-implementation-validation'; $behavior = New-Artifact 'ui-behavior-result'; $browser = New-Artifact 'ui-browser-observation'; $visual = New-Artifact 'ui-visual-capture'; $review = New-Artifact 'ui-review-report'; $handover = New-Artifact 'ui-handover'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $uiPath -TaskId ui -TaskClass major_feature -ChangeScope multi_file -UiScope substantial_refactor -ExternalEffect none -ClaimType behavior_change
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $uiPath -AvailableSkill product-requirements-grilling,ui-ux-pro-max,imagegen,senior-frontend,tdd-guide,playwright,screenshot,code-reviewer
    $uiState = Get-Content -Raw -Encoding UTF8 -LiteralPath $uiPath | ConvertFrom-Json
    if (@($uiState.routes | Where-Object route_id -eq 'design-direction')[0].selected_skill -ne 'ui-ux-pro-max') { throw 'Preflight did not select ui-ux-pro-max as the primary design-direction skill.' }
    if (@($uiState.routes | Where-Object route_id -eq 'code-review')[0].selected_skill -ne 'code-reviewer') { throw 'Preflight did not switch code review to an available approved alias.' }
    Expect-Failure { & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-implementation -Evidence senior_frontend_run } 'UI implementation invocation before requirements and UI design close'
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId requirements-grilling -Evidence skill_file_read
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId requirements-grilling -Evidence single_question_dialogue,approved_requirements_brief,brief_validator_result -Artifact "requirements_brief=$uiBrief"
    Set-Content -LiteralPath $uiBrief -Value 'tampered' -Encoding utf8
    Expect-Failure { & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId design-direction -Evidence native_design_direction_run } 'Design direction after a tampered requirements artifact'
    Set-Content -LiteralPath $uiBrief -Value 'evidence:ui-requirements-brief' -Encoding utf8
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId design-direction -Evidence ui_ux_pro_max_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId design-direction -Evidence selected_or_user_confirmed_design_direction -Artifact "design_direction_record=$designDirection"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-design -Evidence imagegen_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-design -Evidence approved_requirements_brief,mockup_requested_or_explicit_opt_out,approved_mockup_or_explicit_opt_out,visual_verification_plan -Artifact "mockup_or_opt_out_record=$mockup"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-implementation -Evidence senior_frontend_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId ui-implementation -Evidence approved_requirements_brief,approved_mockup_or_explicit_opt_out,implementation_validation,visual_verification_plan -Artifact "implementation_validation_record=$implementation"
    Expect-Failure { & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId code-review -Evidence code_review_run } 'Website code review before behavior and browser/visual verification close'
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId test-design -Evidence test_plan
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId test-design -Evidence relevant_test_or_explicit_gap,command_result -Artifact "behavior_result=$behavior"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId browser-verification -Evidence playwright_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId browser-verification -Evidence fresh_browser_observation,captured_artifact -Artifact "browser_observation=$browser"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId visual-verification -Evidence screenshot_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId visual-verification -Evidence screenshot_or_equivalent,boundary_check -Artifact "visual_capture=$visual"
    Expect-Failure { & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId handover -Evidence native_handover_run } 'Handover before code review closes'
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId code-review -Evidence code_review_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId code-review -Evidence review_report,severity_and_evidence -Artifact "review_report=$review"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId handover -Evidence native_handover_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $uiPath -RouteId handover -Evidence reviewable_handover -Artifact "handover_record=$handover"
    & $gate -Mode validate -RepoRoot $RepoRoot -TaskStatePath $uiPath

    $refactorPath = Join-Path $root 'refactor.json'
    $refactorBehavior = New-Artifact 'refactor-behavior-result'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $refactorPath -TaskId refactor -TaskClass refactor -ChangeScope multi_file -UiScope none -ExternalEffect none -ClaimType code_refinement
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $refactorPath -AvailableSkill code-simplifier,tdd-guide
    $refactorState = Get-Content -Raw -Encoding UTF8 -LiteralPath $refactorPath | ConvertFrom-Json
    if (@($refactorState.routes | Where-Object route_id -eq 'code-refinement')[0].selected_skill -ne 'code-simplifier') { throw 'Refactor did not automatically select code-simplifier on code-refinement route.' }
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $refactorPath -RouteId code-refinement -Evidence code_simplifier_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $refactorPath -RouteId code-refinement -Evidence refinement_or_smell_check,behavior_preserved_verification
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $refactorPath -RouteId test-design -Evidence test_plan
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $refactorPath -RouteId test-design -Evidence relevant_test_or_explicit_gap,command_result -Artifact "behavior_result=$refactorBehavior"
    & $gate -Mode validate -RepoRoot $RepoRoot -TaskStatePath $refactorPath

    $decompilePath = Join-Path $root 'decompile.json'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $decompilePath -TaskId decompile -TaskClass decompile_or_reconstruct -ChangeScope isolated -UiScope none -ExternalEffect none -ClaimType decompile_reconstruction
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $decompilePath -AvailableSkill decompile-reconstruction
    $decompileState = Get-Content -Raw -Encoding UTF8 -LiteralPath $decompilePath | ConvertFrom-Json
    if (@($decompileState.routes | Where-Object route_id -eq 'decompile-reconstruction')[0].selected_skill -ne 'decompile-reconstruction') { throw 'Decompile task did not automatically select decompile-reconstruction route.' }
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $decompilePath -RouteId decompile-reconstruction -Evidence decompile_reconstruction_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $decompilePath -RouteId decompile-reconstruction -Evidence target_format_and_toolchain_triage,decompiled_or_reconstructed_artifact
    & $gate -Mode validate -RepoRoot $RepoRoot -TaskStatePath $decompilePath

    $v69Path = Join-Path $root 'v69-domains.json'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $v69Path -TaskId v69 -TaskClass office_document -ChangeScope isolated -UiScope none -ExternalEffect none -ClaimType role_selection,office_document,multimodal_media,novel_writing,diagram_flowchart
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $v69Path -AvailableSkill role-persona-router,office-pro-suite,multimodal-media-director,novel-story-architect,diagram-flowchart-architect
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId role-selection -Evidence role_persona_router_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId role-selection -Evidence recommended_role_menu_presented,selected_or_confirmed_role_persona
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId multimodal-media -Evidence multimodal_media_director_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId multimodal-media -Evidence structured_media_prompt_or_storyboard,generated_media_or_production_sheet
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId office-document -Evidence office_pro_suite_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId office-document -Evidence office_design_and_formula_standard_check,generated_or_verified_office_artifact
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId novel-writing -Evidence novel_story_architect_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId novel-writing -Evidence story_bible_and_scene_beat_check,anti_ai_cliche_and_continuity_audit
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId diagram-flowchart -Evidence diagram_flowchart_architect_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $v69Path -RouteId diagram-flowchart -Evidence spatial_zoning_and_zero_overlap_check,diagram_artifact_or_mermaid_preview
    & $gate -Mode validate -RepoRoot $RepoRoot -TaskStatePath $v69Path

    $releasePath = Join-Path $root 'release.json'
    $releaseReview = New-Artifact 'release-review-report'
    & $gate -Mode initialize -RepoRoot $RepoRoot -TaskStatePath $releasePath -TaskId release -TaskClass release -ChangeScope isolated -UiScope none -ExternalEffect remote_release -ClaimType release_review -AvailableSkill code-review,release-manager
    & $gate -Mode preflight -RepoRoot $RepoRoot -TaskStatePath $releasePath -AvailableSkill release-manager,code-review
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId code-review -Evidence code_review_run
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId code-review -Evidence review_report,severity_and_evidence -Artifact "review_report=$releaseReview"
    & $gate -Mode record-invocation -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId package-release -Evidence release_manager_run
    Expect-Failure { & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId package-release -Evidence artifact_validation,post_result_inspection } 'remote release without exact target confirmation'
    & $gate -Mode closure -RepoRoot $RepoRoot -TaskStatePath $releasePath -RouteId package-release -Evidence artifact_validation,post_result_inspection,exact_remote_target_confirmation -RemoteTarget 'UIhoshi/AgentLogic@v6.9.0'
    $releaseState = Get-Content -Raw -Encoding UTF8 -LiteralPath $releasePath | ConvertFrom-Json
    $recordedRemoteTarget = @($releaseState.routes | Where-Object { $_.route_id -eq 'package-release' } | Select-Object -ExpandProperty remote_target)
    if ($recordedRemoteTarget.Count -ne 1 -or $recordedRemoteTarget[0] -ne 'UIhoshi/AgentLogic@v6.9.0') { throw 'Remote release target was not recorded.' }

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
    "# Code Map`n`n## Skill Usage`n| Durable flow | Capability / skill | Trigger | Source of truth | Reviewed commit |`n| --- | --- | --- | --- | --- |`n| validation | tdd-guide | behavior_change | .agentlogic/skill-usage.json | abc123 |" | Set-Content -LiteralPath (Join-Path $projectRoot 'CODE_MAP.md') -Encoding utf8
    & $gate -Mode validate-project-usage -RepoRoot $RepoRoot -ProjectRoot $projectRoot
    & $gate -Mode validate-project-usage -ProjectRoot $projectRoot
    (Get-Content -Raw -LiteralPath (Join-Path $projectRoot 'CODE_MAP.md')).Replace('behavior_change','incorrect_trigger') | Set-Content -LiteralPath (Join-Path $projectRoot 'CODE_MAP.md') -Encoding utf8
    Expect-Failure { & $gate -Mode validate-project-usage -RepoRoot $RepoRoot -ProjectRoot $projectRoot } 'inconsistent CODE_MAP Skill Usage row'

    Write-Host 'Skill enforcement tests passed.'
}
finally {
    if (Test-Path -LiteralPath $root) { Remove-Item -LiteralPath $root -Recurse -Force }
}
