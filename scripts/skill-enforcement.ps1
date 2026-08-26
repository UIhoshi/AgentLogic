# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param(
    [Parameter(Mandatory)]
    [ValidateSet('initialize','preflight','record-invocation','closure','validate','validate-project-usage')]
    [string]$Mode,
    [string]$RepoRoot,
    [string]$TaskStatePath,
    [string]$TaskId,
    [ValidateSet('read_only','documentation','trivial_fix','feature','major_feature','refactor','code_audit','security_review','install','package','release')]
    [string]$TaskClass,
    [ValidateSet('isolated','multi_file','architectural')]
    [string]$ChangeScope,
    [ValidateSet('none','small_correction','net_new','substantial_refactor')]
    [string]$UiScope,
    [ValidateSet('none','local_package','remote_release')]
    [string]$ExternalEffect,
    [string[]]$ClaimType = @('none'),
    [string[]]$AvailableSkill = @(),
    [string[]]$Artifact = @(),
    [string]$RouteId,
    [string[]]$Evidence = @(),
    [string]$RemoteTarget,
    [string]$ProjectRoot
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
}
function Read-Json([string]$Path, [string]$Label) {
    if (-not (Test-Path -LiteralPath $Path)) { throw "Missing ${Label}: $Path" }
    try { return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json } catch { throw "Invalid $Label JSON: $($_.Exception.Message)" }
}
function Write-Json([string]$Path, [object]$Value) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [IO.File]::WriteAllText($Path, ($Value | ConvertTo-Json -Depth 30), [Text.UTF8Encoding]::new($false))
}
function Get-Route([object]$Routing, [string]$Id) {
    $route = @($Routing.routes | Where-Object { $_.id -eq $Id })
    if ($route.Count -ne 1) { throw "Unknown or duplicate route id: $Id" }
    return $route[0]
}
function Get-RouteRecord([object]$State, [string]$Id) {
    $record = @($State.routes | Where-Object { $_.route_id -eq $Id })
    if ($record.Count -ne 1) { throw "Task state is missing exactly one record for route '$Id'." }
    return $record[0]
}
function Assert-ClosedDependencies([object]$State, [object]$Route, [object]$RouteRecord, [string]$Transition) {
    foreach ($dependency in @($Route.requires_routes) + @($RouteRecord.workflow_requires) | Sort-Object -Unique) {
        $dependencyRecord = Get-RouteRecord -State $State -Id $dependency
        if ($dependencyRecord.state -ne 'closed') {
            throw "Route '$($Route.id)' cannot $Transition before required route '$dependency' closes."
        }
        Assert-ArtifactIntegrity -RouteRecord $dependencyRecord -Route (Get-Route -Routing $script:routing -Id $dependency)
    }
}
function Get-Signals([object]$Classification, [object]$Contract) {
    $signals = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($field in @($Contract.task_classification.required_fields)) {
        if ($null -eq $Classification.$field) { throw "Task classification is missing '$field'." }
        $allowed = @($Contract.task_classification.$field)
        $actual = @($Classification.$field)
        if ($allowed.Count -gt 0 -and @($actual | Where-Object { $allowed -notcontains $_ }).Count -gt 0) {
            throw "Task classification '$field' contains an unsupported value: $(@($actual | Where-Object { $allowed -notcontains $_ }) -join ', ')."
        }
    }
    foreach ($rule in @($Contract.task_classification.signal_rules)) {
        $current = @($Classification.($rule.field))
        if (@($current | Where-Object { @($rule.values) -contains $_ }).Count -gt 0) {
            foreach ($signal in @($rule.signals)) { [void]$signals.Add([string]$signal) }
        }
    }
    return @($signals | Sort-Object)
}
function Get-WorkflowPipelineIds([object]$Classification, [object]$Graph, [object]$Contract) {
    $signals = Get-Signals -Classification $Classification -Contract $Contract
    return @($Graph.default_pipelines | Where-Object { @($_.triggers | Where-Object { $signals -contains $_ }).Count -gt 0 } | ForEach-Object id | Sort-Object -Unique)
}
function Get-MatchedRouteIds([object]$Classification, [object]$Routing, [object]$Contract, [object]$Graph) {
    $signals = Get-Signals -Classification $Classification -Contract $Contract
    $matches = foreach ($route in @($Routing.routes)) {
        if (@($route.triggers | Where-Object { $signals -contains $_ }).Count -gt 0) { $route }
    }
    $workflowRouteIds = foreach ($pipelineId in @(Get-WorkflowPipelineIds -Classification $Classification -Graph $Graph -Contract $Contract)) {
        $pipeline = @($Graph.default_pipelines | Where-Object id -eq $pipelineId)[0]
        foreach ($nodeId in @($pipeline.nodes)) { @($Graph.nodes | Where-Object id -eq $nodeId)[0].route_ids }
    }
    return @($matches.id + $workflowRouteIds | Sort-Object -Unique | ForEach-Object { @($Routing.routes | Where-Object id -eq $_)[0] } | Sort-Object order | ForEach-Object id)
}
function Get-WorkflowRequires([string]$RouteId, [object]$Classification, [object]$Graph, [object]$Contract) {
    $required = @()
    foreach ($pipelineId in @(Get-WorkflowPipelineIds -Classification $Classification -Graph $Graph -Contract $Contract)) {
        $pipeline = @($Graph.default_pipelines | Where-Object id -eq $pipelineId)[0]
        foreach ($nodeId in @($pipeline.nodes)) {
            $node = @($Graph.nodes | Where-Object id -eq $nodeId)[0]
            if (@($node.route_ids) -contains $RouteId) {
                foreach ($dependencyNodeId in @($node.requires)) {
                    $required += @(@($Graph.nodes | Where-Object id -eq $dependencyNodeId)[0].route_ids)
                }
            }
        }
    }
    return @($required | Where-Object { $_ -and $_ -ne $RouteId } | Sort-Object -Unique)
}
function Assert-TaskState([object]$State, [object]$Routing, [object]$Contract, [object]$Graph) {
    if ($State.schema_version -ne 1) { throw "Unsupported task state schema version: $($State.schema_version)" }
    foreach ($field in @($Contract.task_execution_record.required_fields)) { if ($null -eq $State.$field) { throw "Task state is missing '$field'." } }
    $expected = @(Get-MatchedRouteIds -Classification $State.classification -Routing $Routing -Contract $Contract -Graph $Graph)
    $expectedPipelines = @(Get-WorkflowPipelineIds -Classification $State.classification -Graph $Graph -Contract $Contract)
    if ((@($State.workflow_pipeline_ids) -join '|') -ne ($expectedPipelines -join '|')) { throw "Task state workflow pipelines do not match deterministic classification. Expected '$($expectedPipelines -join ',')'; found '$(@($State.workflow_pipeline_ids) -join ',')'." }
    $actual = @($State.matched_route_ids)
    if (($expected -join '|') -ne ($actual -join '|')) { throw "Task state matched routes do not match deterministic classification. Expected '$($expected -join ',')'; found '$($actual -join ',')'." }
    foreach ($routeId in $expected) { [void](Get-RouteRecord -State $State -Id $routeId) }
}
function Add-UniqueEvidence([object]$RouteRecord, [string]$Property, [string[]]$Values) {
    $existing = @($RouteRecord.$Property)
    foreach ($value in $Values) { if ($existing -notcontains $value) { $existing += $value } }
    $RouteRecord | Add-Member -Force -NotePropertyName $Property -NotePropertyValue @($existing)
}
function Add-ArtifactEvidence([object]$RouteRecord, [string[]]$Specs) {
    $records = @($RouteRecord.artifacts)
    foreach ($spec in @($Specs)) {
        $parts = $spec -split '=',2
        if ($parts.Count -ne 2 -or [string]::IsNullOrWhiteSpace($parts[0]) -or [string]::IsNullOrWhiteSpace($parts[1])) { throw "Artifact must use kind=path: $spec" }
        $kind = $parts[0].Trim()
        $path = $parts[1].Trim()
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Artifact '$kind' does not exist as a file: $path" }
        $resolved = (Resolve-Path -LiteralPath $path).Path
        $hash = (Get-FileHash -LiteralPath $resolved -Algorithm SHA256).Hash
        $records = @($records | Where-Object { $_.kind -ne $kind }) + @([pscustomobject]@{kind=$kind;path=$path;sha256=$hash})
    }
    $RouteRecord | Add-Member -Force -NotePropertyName artifacts -NotePropertyValue @($records)
}
function Assert-ArtifactIntegrity([object]$RouteRecord, [object]$Route) {
    foreach ($kind in @($Route.artifact_requirements)) {
        $artifact = @($RouteRecord.artifacts | Where-Object kind -eq $kind)
        if ($artifact.Count -ne 1) { throw "Route '$($Route.id)' requires exactly one '$kind' artifact record." }
        if (-not (Test-Path -LiteralPath $artifact[0].path -PathType Leaf)) { throw "Route '$($Route.id)' artifact '$kind' no longer exists: $($artifact[0].path)" }
        $currentHash = (Get-FileHash -LiteralPath $artifact[0].path -Algorithm SHA256).Hash
        if ($currentHash -ne $artifact[0].sha256) { throw "Route '$($Route.id)' artifact '$kind' changed after it was recorded." }
    }
}
function Get-RequiredClosureEvidence([object]$Route, [object]$Classification) {
    $required = @($Route.closure_evidence)
    foreach ($rule in @($Route.conditional_closure_evidence)) {
        if ($null -ne $Classification.($rule.field) -and @($Classification.($rule.field) | Where-Object { @($rule.values) -contains $_ }).Count -gt 0) {
            $required += @($rule.evidence)
        }
    }
    return @($required | Sort-Object -Unique)
}

$script:routing = Read-Json -Path (Join-Path $RepoRoot 'contracts\skill-routing.json') -Label 'skill routing contract'
$contract = Read-Json -Path (Join-Path $RepoRoot 'contracts\skill-enforcement.json') -Label 'skill enforcement contract'
$graph = Read-Json -Path (Join-Path $RepoRoot 'contracts\skill-workflow-graph.json') -Label 'skill workflow graph contract'
if ($script:routing.schema_version -ne 3 -or $contract.schema_version -ne 1 -or $graph.schema_version -ne 1) { throw 'Unsupported enforcement contract versions.' }

if ($Mode -eq 'validate-project-usage') {
    if (-not $ProjectRoot) { throw 'validate-project-usage requires -ProjectRoot.' }
    $usagePath = Join-Path $ProjectRoot '.agentlogic\skill-usage.json'
    $codeMapPath = Join-Path $ProjectRoot 'CODE_MAP.md'
    $usage = Read-Json -Path $usagePath -Label 'project skill usage'
    foreach ($field in @($contract.project_skill_usage.required_fields)) { if ($null -eq $usage.$field) { throw "Project skill usage is missing '$field'." } }
    if ($usage.schema_version -ne 1) { throw "Unsupported project skill usage schema version: $($usage.schema_version)" }
    foreach ($skill in @($usage.skills)) { foreach ($field in @($contract.project_skill_usage.required_skill_fields)) { if ($null -eq $skill.$field -or [string]::IsNullOrWhiteSpace([string]$skill.$field)) { throw "Project skill usage record is missing '$field'." } } }
    if (-not (Test-Path -LiteralPath $codeMapPath)) { throw "Missing project CODE_MAP.md: $codeMapPath" }
    $codeMap = Get-Content -Raw -Encoding UTF8 -LiteralPath $codeMapPath
    if ($codeMap -notmatch '(?m)^## Skill Usage\s*$') { throw 'CODE_MAP.md is missing the required ## Skill Usage summary.' }
    $rows = @($codeMap -split '\r?\n' | Where-Object { $_ -match '^\|\s*[^|-].*\|\s*$' -and $_ -notmatch '^\|\s*Durable flow\s*\|' })
    foreach ($skill in @($usage.skills)) {
        foreach ($flow in @($skill.flows)) {
            $found = $false
            foreach ($row in $rows) {
                $cells = @($row.Trim().Trim('|').Split('|') | ForEach-Object { $_.Trim().Trim('`') })
                if ($cells.Count -ge 5 -and $cells[0] -ieq $flow -and $cells[1] -eq $skill.skill_id -and $cells[2] -eq $skill.trigger -and $cells[3] -eq '.agentlogic/skill-usage.json' -and $cells[4] -eq $usage.reviewed_commit) { $found = $true; break }
            }
            if (-not $found) { throw "CODE_MAP.md is missing a matching Skill Usage row for '$($skill.skill_id)' flow '$flow'." }
        }
    }
    Write-Host "Project skill usage validation passed: $ProjectRoot"
    exit 0
}

if (-not $TaskStatePath) { throw "$Mode requires -TaskStatePath." }
if ($Mode -eq 'initialize') {
    foreach ($pair in @(@{name='TaskId';value=$TaskId},@{name='TaskClass';value=$TaskClass},@{name='ChangeScope';value=$ChangeScope},@{name='UiScope';value=$UiScope},@{name='ExternalEffect';value=$ExternalEffect})) { if ([string]::IsNullOrWhiteSpace([string]$pair.value)) { throw "initialize requires -$($pair.name)." } }
    $classification = [ordered]@{ task_class=$TaskClass; change_scope=$ChangeScope; ui_scope=$UiScope; external_effect=$ExternalEffect; claim_types=@($ClaimType) }
    $classificationObject = [pscustomobject]$classification
    $matched = @(Get-MatchedRouteIds -Classification $classificationObject -Routing $script:routing -Contract $contract -Graph $graph)
    $routeRecords = foreach ($id in $matched) {
        $route = Get-Route -Routing $script:routing -Id $id
$availablePrimary = @($route.primary_host_skill_aliases | Where-Object { @($AvailableSkill) -contains $_ })
        $selectedSkill = if ($availablePrimary.Count -gt 0) { $availablePrimary[0] } else { @($route.primary_host_skill_aliases)[0] }
        [ordered]@{ route_id=$id; state='pending'; selected_skill=$selectedSkill; workflow_requires=@(Get-WorkflowRequires -RouteId $id -Classification $classificationObject -Graph $graph -Contract $contract); available_skills=@(); invocation_evidence=@(); closure_evidence=@(); remote_target=$null; blocked_reason=$null }
    }
    $state = [ordered]@{ schema_version=1; task_id=$TaskId; classification=$classification; workflow_pipeline_ids=@(Get-WorkflowPipelineIds -Classification $classificationObject -Graph $graph -Contract $contract); matched_route_ids=$matched; routes=@($routeRecords) }
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Initialized skill enforcement task state with routes: $($matched -join ', ')"
    exit 0
}

$state = Read-Json -Path $TaskStatePath -Label 'skill execution state'
Assert-TaskState -State $state -Routing $script:routing -Contract $contract -Graph $graph
if ($Mode -eq 'validate') {
    foreach ($record in @($state.routes | Where-Object state -eq 'closed')) { Assert-ArtifactIntegrity -RouteRecord $record -Route (Get-Route -Routing $script:routing -Id $record.route_id) }
    Write-Host "Skill enforcement task state validation passed: $($state.task_id)"
    exit 0
}
if ($Mode -eq 'preflight') {
    foreach ($id in @($state.matched_route_ids)) {
        $route = Get-Route -Routing $script:routing -Id $id
        $record = Get-RouteRecord -State $state -Id $id
        if ($record.state -notin @('pending','preflight_passed')) { throw "Route '$id' cannot enter preflight from state '$($record.state)'." }
        if (@($AvailableSkill) -notcontains $record.selected_skill) {
            $approvedAliases = @($route.primary_host_skill_aliases) + @($route.conditional_host_skill_aliases)
            $replacement = @($approvedAliases | Where-Object { @($AvailableSkill) -contains $_ })[0]
            if ($replacement) { $record.selected_skill = $replacement }
        }
        if (@($AvailableSkill) -notcontains $record.selected_skill) {
            $nativeFallbackAllowed = $route.fallback -match '^allow_native'
            if (-not $nativeFallbackAllowed) { $record.state = 'blocked'; $record.blocked_reason = "Required selected skill '$($record.selected_skill)' is unavailable."; Write-Json -Path $TaskStatePath -Value $state; throw "Route '$id' is blocked: selected skill '$($record.selected_skill)' is unavailable." }
            $record.selected_skill = "native-$($route.capability)"
        }
        $record.available_skills = @($AvailableSkill)
        Add-UniqueEvidence -RouteRecord $record -Property 'invocation_evidence' -Values @('selected_skill','availability_check')
        $record.state = 'preflight_passed'
    }
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Skill enforcement preflight passed: $($state.task_id)"
    exit 0
}

if (-not $RouteId) { throw "$Mode requires -RouteId." }
$route = Get-Route -Routing $script:routing -Id $RouteId
$record = Get-RouteRecord -State $state -Id $RouteId
if ($Mode -eq 'record-invocation') {
    if ($record.state -notin @('preflight_passed','invoked')) { throw "Route '$RouteId' requires preflight before invocation." }
    Assert-ClosedDependencies -State $state -Route $route -RouteRecord $record -Transition 'record invocation'
    if (@($Evidence).Count -eq 0) { throw 'record-invocation requires at least one -Evidence value.' }
    Add-UniqueEvidence -RouteRecord $record -Property 'invocation_evidence' -Values @('invocation_record') + @($Evidence)
    $record.state = 'invoked'
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Recorded skill invocation for route '$RouteId'."
    exit 0
}

if ($Mode -eq 'closure') {
    if ($record.state -ne 'invoked') { throw "Route '$RouteId' requires an invocation record before closure." }
    Assert-ClosedDependencies -State $state -Route $route -RouteRecord $record -Transition 'close'
    $requiresRemoteTarget = $false
    foreach ($conditional in @($route.conditional_closure_evidence)) {
        $actual = @($state.classification.($conditional.field))
        if ($conditional.requires_remote_target -and @($actual | Where-Object { @($conditional.values) -contains $_ }).Count -gt 0) {
            $requiresRemoteTarget = $true
            break
        }
    }
    if ($requiresRemoteTarget) {
        if ([string]::IsNullOrWhiteSpace($RemoteTarget)) { throw "Route '$RouteId' requires an exact -RemoteTarget before closure." }
        $record | Add-Member -Force -NotePropertyName remote_target -NotePropertyValue $RemoteTarget
    }
    Add-UniqueEvidence -RouteRecord $record -Property 'closure_evidence' -Values @($Evidence)
    Add-ArtifactEvidence -RouteRecord $record -Specs @($Artifact)
    $missingInvocation = @($route.invocation_evidence | Where-Object { @($record.invocation_evidence) -notcontains $_ })
    $missingClosure = @(Get-RequiredClosureEvidence -Route $route -Classification $state.classification | Where-Object { @($record.closure_evidence) -notcontains $_ })
    if ($missingInvocation.Count -gt 0 -or $missingClosure.Count -gt 0) { throw "Route '$RouteId' cannot close. Missing invocation evidence: $($missingInvocation -join ', '); missing closure evidence: $($missingClosure -join ', ')." }
    Assert-ArtifactIntegrity -RouteRecord $record -Route $route
    $record.state = 'closed'
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Closed skill enforcement route '$RouteId'."
    exit 0
}
