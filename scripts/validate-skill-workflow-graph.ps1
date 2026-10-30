# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$GraphPath,
    [string]$RoutingPath
)
$ErrorActionPreference = 'Stop'

function Read-Contract([string]$Path, [string]$Label) {
    if (-not (Test-Path -LiteralPath $Path)) { throw "Missing ${Label}: $Path" }
    try { return Get-Content -Raw -Encoding UTF8 -LiteralPath $Path | ConvertFrom-Json }
    catch { throw "Invalid $Label JSON: $($_.Exception.Message)" }
}
function Assert-UniqueStrings([object[]]$Values, [string]$Label) {
    $items = @($Values)
    if ($items.Count -eq 0 -or @($items | Where-Object { [string]::IsNullOrWhiteSpace([string]$_) }).Count -gt 0 -or @($items | Sort-Object -Unique).Count -ne $items.Count) {
        throw "$Label must be a non-empty list of unique strings."
    }
}

if ([string]::IsNullOrWhiteSpace($GraphPath)) { $GraphPath = Join-Path $RepoRoot 'contracts\skill-workflow-graph.json' }
if ([string]::IsNullOrWhiteSpace($RoutingPath)) { $RoutingPath = Join-Path $RepoRoot 'contracts\skill-routing.json' }
$graph = Read-Contract $GraphPath 'skill workflow graph contract'
$routing = Read-Contract $RoutingPath 'skill routing contract'
if ($graph.schema_version -ne 1) { throw "Unsupported skill workflow graph schema version: $($graph.schema_version)" }
if ((@($graph.selection_postures | Sort-Object) -join '|') -ne (@('guided','manual','route') -join '|')) { throw 'Skill workflow graph must declare the route, guided, and manual postures.' }
if ($null -eq $graph.orchestration_policy -or $graph.orchestration_policy.standard_product_workflow -ne 'automatic_from_task_classification' -or $graph.orchestration_policy.user_skill_selection_required -ne $false) { throw 'Skill workflow graph must prohibit user skill selection for the standard product workflow.' }
Assert-UniqueStrings @($graph.orchestration_policy.restricted_manual_paths) 'restricted_manual_paths'
Assert-UniqueStrings $graph.external_inputs 'external_inputs'

$routeIds = @($routing.routes | ForEach-Object id)
$nodes = @($graph.nodes)
if ($nodes.Count -eq 0) { throw 'Skill workflow graph requires at least one node.' }
$byId = @{}
$artifactProducer = @{}
foreach ($node in $nodes) {
    foreach ($field in @('id','posture','user_skill_selection_required','requires','consumes','produces','blocks','verification','route_ids')) {
        if ($null -eq $node.$field) { throw "Workflow node '$($node.id)' is missing '$field'." }
    }
    if ([string]::IsNullOrWhiteSpace([string]$node.id) -or $byId.ContainsKey([string]$node.id)) { throw "Workflow node ids must be unique and non-empty: $($node.id)" }
    if ($node.user_skill_selection_required -ne $false) { throw "Workflow node '$($node.id)' must not require user skill selection." }
    if (@($graph.selection_postures) -notcontains $node.posture) { throw "Workflow node '$($node.id)' has invalid posture '$($node.posture)'." }
    foreach ($field in @('consumes','produces','blocks','verification')) { Assert-UniqueStrings @($node.$field) "Workflow node '$($node.id)' $field" }
    if ($node.posture -eq 'route' -and @($node.route_ids).Count -eq 0) { throw "Route workflow node '$($node.id)' requires at least one route id." }
    if ($node.posture -ne 'route' -and @($node.route_ids).Count -ne 0) { throw "Non-route workflow node '$($node.id)' must not declare route ids." }
    foreach ($routeId in @($node.route_ids)) { if ($routeIds -notcontains $routeId) { throw "Workflow node '$($node.id)' references unknown route '$routeId'." } }
    foreach ($artifact in @($node.produces)) { if ($artifactProducer.ContainsKey($artifact)) { throw "Workflow artifact '$artifact' has multiple producers." }; $artifactProducer[$artifact] = $node.id }
    $byId[$node.id] = $node
}

function Get-Ancestors([string]$NodeId, [hashtable]$Nodes, [hashtable]$Cache, [string[]]$Stack = @()) {
    if ($Cache.ContainsKey($NodeId)) { return @($Cache[$NodeId]) }
    if ($Stack -contains $NodeId) { throw "Workflow graph contains a dependency cycle: $($Stack -join ' -> ') -> $NodeId" }
    $result = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($dependency in @($Nodes[$NodeId].requires)) {
        if (-not $Nodes.ContainsKey($dependency)) { throw "Workflow node '$NodeId' requires unknown node '$dependency'." }
        [void]$result.Add($dependency)
        foreach ($ancestor in @(Get-Ancestors $dependency $Nodes $Cache @($Stack + $NodeId))) { [void]$result.Add($ancestor) }
    }
    $Cache[$NodeId] = @($result)
    return @($result)
}
$ancestorCache = @{}
foreach ($node in $nodes) {
    $ancestors = @(Get-Ancestors $node.id $byId $ancestorCache)
    if ($ancestors -contains $node.id) { throw "Workflow graph contains a dependency cycle at '$($node.id)'." }
    foreach ($artifact in @($node.consumes)) {
        if (@($graph.external_inputs) -contains $artifact) { continue }
        if (-not $artifactProducer.ContainsKey($artifact)) { throw "Workflow node '$($node.id)' consumes undeclared artifact '$artifact'." }
        if ($ancestors -notcontains $artifactProducer[$artifact]) { throw "Workflow node '$($node.id)' consumes '$artifact' without requiring its producer '$($artifactProducer[$artifact])'." }
    }
    foreach ($routeId in @($node.route_ids)) {
        $route = @($routing.routes | Where-Object id -eq $routeId)[0]
        $missingEvidence = @($route.closure_evidence | Where-Object { @($node.verification) -notcontains $_ })
        if ($missingEvidence.Count -gt 0) { throw "Workflow node '$($node.id)' omits closure evidence for route '$routeId': $($missingEvidence -join ', ')." }
        $missingBlocks = @($route.blocked_transitions | Where-Object { @($node.blocks) -notcontains $_ })
        if ($missingBlocks.Count -gt 0) { throw "Workflow node '$($node.id)' omits blocked transition for route '$routeId': $($missingBlocks -join ', ')." }
    }
}

$requiredNodes = @('role-selection','requirements-grilling','design-direction-selection','image-mockup','frontend-implementation','code-refinement','decompile-reconstruction','multimodal-media','office-document','novel-writing','diagram-flowchart','behavior-verification','browser-and-visual-verification','code-review','handover')
foreach ($id in $requiredNodes) { if (-not $byId.ContainsKey($id)) { throw "Skill workflow graph is missing required node '$id'." } }
$websitePipelines = @($graph.default_pipelines | Where-Object id -eq 'website-delivery')
if ($websitePipelines.Count -ne 1) { throw 'Skill workflow graph requires exactly one website-delivery default pipeline.' }
$website = $websitePipelines[0]
if ($website.user_skill_selection_required -ne $false) { throw 'website-delivery must not require user skill selection.' }
$expectedWebsiteNodes = @('requirements-grilling','design-direction-selection','image-mockup','frontend-implementation','behavior-verification','browser-and-visual-verification','code-review','handover')
if ((@($website.nodes) -join '|') -ne ($expectedWebsiteNodes -join '|')) { throw 'website-delivery must declare the complete product-first workflow in order.' }
foreach ($trigger in @('net_new_ui','substantial_ui_refactor')) { if (@($website.triggers) -notcontains $trigger) { throw "website-delivery is missing trigger '$trigger'." } }
Write-Host "Skill workflow graph validation passed ($($nodes.Count) nodes)."
