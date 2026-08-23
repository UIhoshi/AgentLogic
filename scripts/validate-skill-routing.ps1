# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)
$ErrorActionPreference = 'Stop'
$routingPath = Join-Path $RepoRoot 'contracts\skill-routing.json'
$registryPath = Join-Path $RepoRoot 'contracts\skill-registry.json'
$enforcementPath = Join-Path $RepoRoot 'contracts\skill-enforcement.json'
$modulePath = Join-Path $RepoRoot 'modules\49_V6_8_AutonomousSkillEnforcement.md'
$hostCapabilitiesPath = Join-Path $RepoRoot 'contracts\host-skill-capabilities.json'
foreach ($path in @($routingPath,$registryPath,$enforcementPath,$modulePath,$hostCapabilitiesPath)) { if (-not (Test-Path $path)) { throw "Missing autonomous enforcement asset: $path" } }
try { $routing = Get-Content -Raw -Encoding UTF8 $routingPath | ConvertFrom-Json } catch { throw "Invalid skill routing JSON: $($_.Exception.Message)" }
try { $enforcement = Get-Content -Raw -Encoding UTF8 $enforcementPath | ConvertFrom-Json } catch { throw "Invalid skill enforcement JSON: $($_.Exception.Message)" }
try { $hostCapabilities = Get-Content -Raw -Encoding UTF8 $hostCapabilitiesPath | ConvertFrom-Json } catch { throw "Invalid host skill capability JSON: $($_.Exception.Message)" }
if ($routing.schema_version -ne 3) { throw 'Unsupported skill routing schema version; expected 3.' }
if ($enforcement.schema_version -ne 1) { throw 'Unsupported skill enforcement schema version; expected 1.' }
if ($hostCapabilities.schema_version -ne 2 -or $hostCapabilities.first_party_skill -ne 'product-requirements-grilling') { throw 'Unsupported host skill capability schema version; expected 2.' }
if ($routing.enforcement_contract -ne 'contracts/skill-enforcement.json') { throw 'Skill routing must reference the enforcement contract.' }
$required = @('requirements-grilling','ui-design','ui-implementation','code-review','security-review','extension-security-review','browser-verification','visual-verification','test-design','package-release')
$seen = @{}
$orders = @{}
foreach ($route in @($routing.routes)) {
    if ([string]::IsNullOrWhiteSpace($route.id) -or $seen.ContainsKey($route.id)) { throw 'Route ids must be unique and non-empty.' }; $seen[$route.id] = $true
    foreach ($field in @('capability','fallback','selection_rule','order','exemption_policy')) { if ($null -eq $route.$field -or [string]::IsNullOrWhiteSpace([string]$route.$field)) { throw "Route '$($route.id)' is missing $field." } }
    if ($orders.ContainsKey([int]$route.order)) { throw "Routes '$($orders[[int]$route.order])' and '$($route.id)' share order $($route.order)." }; $orders[[int]$route.order] = $route.id
    foreach ($arrayField in @('triggers','primary_host_skill_aliases','closure_evidence','requires_routes','blocked_transitions','invocation_evidence')) { if ($null -eq $route.$arrayField) { throw "Route '$($route.id)' is missing $arrayField." } }
    if (@($route.triggers).Count -eq 0 -or @($route.primary_host_skill_aliases).Count -eq 0 -or @($route.closure_evidence).Count -eq 0 -or @($route.invocation_evidence).Count -eq 0) { throw "Route '$($route.id)' needs triggers, primary aliases, invocation evidence, and closure evidence." }
}
foreach ($id in $required) { if (-not $seen.ContainsKey($id)) { throw "Missing required autonomous route '$id'." } }
foreach ($route in @($routing.routes)) { foreach ($dependency in @($route.requires_routes)) { if (-not $seen.ContainsKey($dependency)) { throw "Route '$($route.id)' requires unknown route '$dependency'." } } }
$uiDesign = @($routing.routes | Where-Object id -eq 'ui-design')[0]
$uiImplementation = @($routing.routes | Where-Object id -eq 'ui-implementation')[0]
$visual = @($routing.routes | Where-Object id -eq 'visual-verification')[0]
$package = @($routing.routes | Where-Object id -eq 'package-release')[0]
if (@($uiDesign.primary_host_skill_aliases) -notcontains 'imagegen') { throw 'UI-design must require imagegen as a primary mockup capability.' }
if (@($uiImplementation.primary_host_skill_aliases) -notcontains 'senior-frontend') { throw 'UI implementation must route to senior-frontend.' }
if (@($uiImplementation.requires_routes) -notcontains 'ui-design') { throw 'UI implementation must depend on UI design closure.' }
if (@($visual.triggers) -notcontains 'small_visual_correction') { throw 'Visual verification must cover small visual corrections.' }
if (@($package.conditional_closure_evidence | ForEach-Object { @($_.evidence) }) -notcontains 'exact_remote_target_confirmation') { throw 'Package/release must require exact remote target confirmation for remote releases.' }
foreach ($field in @('required_fields','signal_rules')) { if ($null -eq $enforcement.task_classification.$field) { throw "Enforcement contract is missing task classification $field." } }
foreach ($field in @('task_execution_record','project_skill_usage','enforcement_levels')) { if ($null -eq $enforcement.$field) { throw "Enforcement contract is missing $field." } }
$knownSignals = @($enforcement.task_classification.signal_rules | ForEach-Object { @($_.signals) } | Sort-Object -Unique)
foreach ($route in @($routing.routes)) {
    foreach ($trigger in @($route.triggers)) {
        if ($knownSignals -notcontains $trigger) { throw "Route '$($route.id)' has trigger '$trigger' that cannot be produced by the deterministic classification contract." }
    }
}
if (-not $hostCapabilities.enforcement_payload -or $hostCapabilities.enforcement_payload.level -ne 'workflow_enforced' -or $hostCapabilities.enforcement_payload.native_tool_interception -ne $false) { throw 'Host capability contract must honestly declare the workflow enforcement payload.' }
foreach ($hostName in @('codex','claude','antigravity','generic')) {
    $hostEntry = $hostCapabilities.hosts.$hostName
    if (-not $hostEntry.target_relative -or -not $hostEntry.enforcement) { throw "Host deployment contract is missing enforcement data for '$hostName'." }
    foreach ($field in @('level','native_tool_interception','target_relative','command_relative','required_files')) { if ($null -eq $hostEntry.enforcement.$field) { throw "Host '$hostName' enforcement contract is missing $field." } }
    if ($hostEntry.enforcement.level -ne 'workflow_enforced' -or $hostEntry.enforcement.native_tool_interception -ne $false) { throw "Host '$hostName' must not claim unsupported native tool interception." }
    if (@($hostEntry.enforcement.required_files).Count -eq 0) { throw "Host '$hostName' has no required enforcement payload files." }
}

& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RepoRoot 'scripts\validate-skill-registry.ps1') -RepoRoot $RepoRoot
if ($LASTEXITCODE -ne 0) { throw 'Skill registry validation failed.' }
$module = Get-Content -Raw -Encoding UTF8 $modulePath
foreach ($anchor in @('Strict missing-capability policy','Software candidate reporting','invocation evidence')) { if ($module -notmatch [regex]::Escape($anchor)) { throw "Enforcement module missing anchor: $anchor" } }
Write-Host "Autonomous skill routing validation passed ($(@($routing.routes).Count) routes)."
