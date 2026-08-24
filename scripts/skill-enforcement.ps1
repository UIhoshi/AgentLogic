# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param(
    [Parameter(Mandatory)]
    [ValidateSet('initialize','preflight','record-invocation','closure','validate-project-usage')]
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
    [string]$RouteId,
    [string[]]$Evidence = @(),
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
function Assert-ClosedDependencies([object]$State, [object]$Route, [string]$Transition) {
    foreach ($dependency in @($Route.requires_routes)) {
        if ((Get-RouteRecord -State $State -Id $dependency).state -ne 'closed') {
            throw "Route '$($Route.id)' cannot $Transition before required route '$dependency' closes."
        }
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
function Get-MatchedRouteIds([object]$Classification, [object]$Routing, [object]$Contract) {
    $signals = Get-Signals -Classification $Classification -Contract $Contract
    $matches = foreach ($route in @($Routing.routes)) {
        if (@($route.triggers | Where-Object { $signals -contains $_ }).Count -gt 0) { $route }
    }
    return @($matches | Sort-Object order | ForEach-Object id)
}
function Assert-TaskState([object]$State, [object]$Routing, [object]$Contract) {
    if ($State.schema_version -ne 1) { throw "Unsupported task state schema version: $($State.schema_version)" }
    foreach ($field in @($Contract.task_execution_record.required_fields)) { if ($null -eq $State.$field) { throw "Task state is missing '$field'." } }
    $expected = @(Get-MatchedRouteIds -Classification $State.classification -Routing $Routing -Contract $Contract)
    $actual = @($State.matched_route_ids)
    if (($expected -join '|') -ne ($actual -join '|')) { throw "Task state matched routes do not match deterministic classification. Expected '$($expected -join ',')'; found '$($actual -join ',')'." }
    foreach ($routeId in $expected) { [void](Get-RouteRecord -State $State -Id $routeId) }
}
function Add-UniqueEvidence([object]$RouteRecord, [string]$Property, [string[]]$Values) {
    $existing = @($RouteRecord.$Property)
    foreach ($value in $Values) { if ($existing -notcontains $value) { $existing += $value } }
    $RouteRecord | Add-Member -Force -NotePropertyName $Property -NotePropertyValue @($existing)
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

$routing = Read-Json -Path (Join-Path $RepoRoot 'contracts\skill-routing.json') -Label 'skill routing contract'
$contract = Read-Json -Path (Join-Path $RepoRoot 'contracts\skill-enforcement.json') -Label 'skill enforcement contract'
if ($routing.schema_version -ne 3 -or $contract.schema_version -ne 1) { throw 'Unsupported enforcement contract versions.' }

if ($Mode -eq 'validate-project-usage') {
    if (-not $ProjectRoot) { throw 'validate-project-usage requires -ProjectRoot.' }
    $usagePath = Join-Path $ProjectRoot '.agentlogic\skill-usage.json'
    $codeMapPath = Join-Path $ProjectRoot 'CODE_MAP.md'
    $usage = Read-Json -Path $usagePath -Label 'project skill usage'
    foreach ($field in @($contract.project_skill_usage.required_fields)) { if ($null -eq $usage.$field) { throw "Project skill usage is missing '$field'." } }
    if ($usage.schema_version -ne 1) { throw "Unsupported project skill usage schema version: $($usage.schema_version)" }
    foreach ($skill in @($usage.skills)) { foreach ($field in @($contract.project_skill_usage.required_skill_fields)) { if ($null -eq $skill.$field -or [string]::IsNullOrWhiteSpace([string]$skill.$field)) { throw "Project skill usage record is missing '$field'." } } }
    if (-not (Test-Path -LiteralPath $codeMapPath)) { throw "Missing project CODE_MAP.md: $codeMapPath" }
    if ((Get-Content -Raw -Encoding UTF8 -LiteralPath $codeMapPath) -notmatch '(?m)^## Skill Usage\s*$') { throw 'CODE_MAP.md is missing the required ## Skill Usage summary.' }
    Write-Host "Project skill usage validation passed: $ProjectRoot"
    exit 0
}

if (-not $TaskStatePath) { throw "$Mode requires -TaskStatePath." }
if ($Mode -eq 'initialize') {
    foreach ($pair in @(@{name='TaskId';value=$TaskId},@{name='TaskClass';value=$TaskClass},@{name='ChangeScope';value=$ChangeScope},@{name='UiScope';value=$UiScope},@{name='ExternalEffect';value=$ExternalEffect})) { if ([string]::IsNullOrWhiteSpace([string]$pair.value)) { throw "initialize requires -$($pair.name)." } }
    $classification = [ordered]@{ task_class=$TaskClass; change_scope=$ChangeScope; ui_scope=$UiScope; external_effect=$ExternalEffect; claim_types=@($ClaimType) }
    $matched = @(Get-MatchedRouteIds -Classification ([pscustomobject]$classification) -Routing $routing -Contract $contract)
    $routeRecords = foreach ($id in $matched) {
        $route = Get-Route -Routing $routing -Id $id
$availablePrimary = @($route.primary_host_skill_aliases | Where-Object { @($AvailableSkill) -contains $_ })
        $selectedSkill = if ($availablePrimary.Count -gt 0) { $availablePrimary[0] } else { @($route.primary_host_skill_aliases)[0] }
        [ordered]@{ route_id=$id; state='pending'; selected_skill=$selectedSkill; available_skills=@(); invocation_evidence=@(); closure_evidence=@(); blocked_reason=$null }
    }
    $state = [ordered]@{ schema_version=1; task_id=$TaskId; classification=$classification; matched_route_ids=$matched; routes=@($routeRecords) }
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Initialized skill enforcement task state with routes: $($matched -join ', ')"
    exit 0
}

$state = Read-Json -Path $TaskStatePath -Label 'skill execution state'
Assert-TaskState -State $state -Routing $routing -Contract $contract
if ($Mode -eq 'preflight') {
    foreach ($id in @($state.matched_route_ids)) {
        $route = Get-Route -Routing $routing -Id $id
        $record = Get-RouteRecord -State $state -Id $id
        if ($record.state -notin @('pending','preflight_passed')) { throw "Route '$id' cannot enter preflight from state '$($record.state)'." }
        if (@($AvailableSkill) -notcontains $record.selected_skill) {
            $nativeFallbackAllowed = $route.fallback -match '^allow_native'
            if (-not $nativeFallbackAllowed) { $record.state = 'blocked'; $record.blocked_reason = "Required selected skill '$($record.selected_skill)' is unavailable."; Write-Json -Path $TaskStatePath -Value $state; throw "Route '$id' is blocked: selected skill '$($record.selected_skill)' is unavailable." }
            $record.selected_skill = 'native-package-validation'
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
$route = Get-Route -Routing $routing -Id $RouteId
$record = Get-RouteRecord -State $state -Id $RouteId
if ($Mode -eq 'record-invocation') {
    if ($record.state -notin @('preflight_passed','invoked')) { throw "Route '$RouteId' requires preflight before invocation." }
    Assert-ClosedDependencies -State $state -Route $route -Transition 'record invocation'
    if (@($Evidence).Count -eq 0) { throw 'record-invocation requires at least one -Evidence value.' }
    Add-UniqueEvidence -RouteRecord $record -Property 'invocation_evidence' -Values @('invocation_record') + @($Evidence)
    $record.state = 'invoked'
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Recorded skill invocation for route '$RouteId'."
    exit 0
}

if ($Mode -eq 'closure') {
    if ($record.state -ne 'invoked') { throw "Route '$RouteId' requires an invocation record before closure." }
    Assert-ClosedDependencies -State $state -Route $route -Transition 'close'
    Add-UniqueEvidence -RouteRecord $record -Property 'closure_evidence' -Values @($Evidence)
    $missingInvocation = @($route.invocation_evidence | Where-Object { @($record.invocation_evidence) -notcontains $_ })
    $missingClosure = @(Get-RequiredClosureEvidence -Route $route -Classification $state.classification | Where-Object { @($record.closure_evidence) -notcontains $_ })
    if ($missingInvocation.Count -gt 0 -or $missingClosure.Count -gt 0) { throw "Route '$RouteId' cannot close. Missing invocation evidence: $($missingInvocation -join ', '); missing closure evidence: $($missingClosure -join ', ')." }
    $record.state = 'closed'
    Write-Json -Path $TaskStatePath -Value $state
    Write-Host "Closed skill enforcement route '$RouteId'."
    exit 0
}
