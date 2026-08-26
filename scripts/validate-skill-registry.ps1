# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$RegistryPath,
    [string]$SkillsRoot
)

$ErrorActionPreference = 'Stop'
if (-not $RegistryPath) { $RegistryPath = Join-Path $RepoRoot 'contracts\skill-registry.json' }
if (-not $SkillsRoot) { $SkillsRoot = Join-Path $RepoRoot 'skills' }
if (-not (Test-Path -LiteralPath $RegistryPath)) { throw "Missing skill registry: $RegistryPath" }
if (-not (Test-Path -LiteralPath $SkillsRoot)) { throw "Missing portable skills root: $SkillsRoot" }

try { $registry = Get-Content -Raw -Encoding UTF8 -LiteralPath $RegistryPath | ConvertFrom-Json } catch { throw "Invalid skill registry JSON: $($_.Exception.Message)" }
$routingPath = Join-Path $RepoRoot 'contracts\skill-routing.json'
if (-not (Test-Path -LiteralPath $routingPath)) { throw "Missing skill routing contract: $routingPath" }
try { $routing = Get-Content -Raw -Encoding UTF8 -LiteralPath $routingPath | ConvertFrom-Json } catch { throw "Invalid skill routing JSON: $($_.Exception.Message)" }
$routeById = @{}
foreach ($route in @($routing.routes)) {
    if ([string]::IsNullOrWhiteSpace([string]$route.id) -or $routeById.ContainsKey([string]$route.id)) { throw "Skill routing contains an invalid or duplicate route id: $($route.id)" }
    $routeById[[string]$route.id] = $route
}
if ($registry.schema_version -ne 1) { throw "Unsupported skill registry schema version: $($registry.schema_version)" }
$states = @($registry.lifecycle_states)
$expectedStates = @('mandatory','conditional','manual_only','archived','deprecated')
if ((@($states | Sort-Object) -join ',') -ne (@($expectedStates | Sort-Object) -join ',')) { throw 'Skill registry lifecycle_states must be the canonical five states.' }
$activationModes = @($registry.activation_modes)
if ((@($activationModes | Sort-Object) -join ',') -ne ((@('manual','route_candidate','guided_candidate') | Sort-Object) -join ',')) { throw 'Skill registry activation_modes must be manual, route_candidate, and guided_candidate.' }
$manualTriggers = @($registry.manual_selection_triggers)
if ($manualTriggers.Count -eq 0 -or @($manualTriggers | Where-Object { [string]::IsNullOrWhiteSpace([string]$_) }).Count -gt 0 -or @($manualTriggers | Sort-Object -Unique).Count -ne $manualTriggers.Count) { throw 'Skill registry manual_selection_triggers must be a non-empty unique list.' }
$recordsByPath = @{}
$recordsById = @{}
foreach ($record in @($registry.records)) {
    foreach ($field in @('id','entrypoint','family','lifecycle','reason')) {
        if ([string]::IsNullOrWhiteSpace([string]$record.$field)) { throw "Skill registry record is missing '$field'." }
    }
    if ($states -notcontains $record.lifecycle) { throw "Skill registry record '$($record.id)' has invalid lifecycle '$($record.lifecycle)'." }
    if ($null -eq $record.activation -or [string]::IsNullOrWhiteSpace([string]$record.activation.mode)) { throw "Skill registry record '$($record.id)' is missing activation metadata." }
    if ($activationModes -notcontains $record.activation.mode) { throw "Skill registry record '$($record.id)' has invalid activation mode '$($record.activation.mode)'." }
    $activationTriggers = @($record.activation.triggers)
    if ($activationTriggers.Count -eq 0 -or @($activationTriggers | Where-Object { [string]::IsNullOrWhiteSpace([string]$_) }).Count -gt 0 -or @($activationTriggers | Sort-Object -Unique).Count -ne $activationTriggers.Count) { throw "Skill registry record '$($record.id)' needs unique non-empty activation triggers." }
    $routable = $record.lifecycle -in @('mandatory','conditional')
    foreach ($field in @('purpose','explicit_signals','confirmation_policy')) { if ($null -eq $record.activation.$field -or [string]::IsNullOrWhiteSpace([string]$record.activation.$field)) { throw "Skill registry record '$($record.id)' is missing activation $field." } }
    if ($null -eq $record.activation.inferred_signals) { throw "Skill registry record '$($record.id)' is missing activation inferred_signals." }
    foreach ($field in @('explicit_signals','inferred_signals')) { if (@($record.activation.$field | Where-Object { [string]::IsNullOrWhiteSpace([string]$_) }).Count -gt 0) { throw "Skill registry record '$($record.id)' has empty activation $field." } }
    if ($routable) {
        if ($record.activation.mode -ne 'route_candidate') { throw "Routable skill '$($record.id)' must use route_candidate activation." }
        $expectedTriggers = @()
        foreach ($routeId in @($record.route_ids)) {
            if (-not $routeById.ContainsKey([string]$routeId)) { throw "Routable skill '$($record.id)' references unknown route '$routeId'." }
            $expectedTriggers += @($routeById[[string]$routeId].triggers)
        }
        $expectedTriggers = @($expectedTriggers | Sort-Object -Unique)
        if ((@($activationTriggers | Sort-Object) -join '|') -ne ($expectedTriggers -join '|')) { throw "Routable skill '$($record.id)' activation triggers must match its routed triggers." }
    } else {
        if ($record.activation.mode -notin @('manual','guided_candidate')) { throw "Non-routable skill '$($record.id)' must use manual or guided_candidate activation." }
        if (@($activationTriggers | Where-Object { $manualTriggers -notcontains $_ }).Count -gt 0) { throw "Manual skill '$($record.id)' has activation triggers outside manual_selection_triggers." }
        if ($record.activation.mode -eq 'guided_candidate' -and @($record.activation.inferred_signals).Count -eq 0) { throw "Guided skill '$($record.id)' requires inferred signals." }
    }
    if ($record.entrypoint -notmatch '^skills/.+/SKILL\.md$') { throw "Skill registry entrypoint must be a portable SKILL.md path: $($record.entrypoint)" }
    $key = $record.entrypoint.ToLowerInvariant()
    if ($recordsByPath.ContainsKey($key)) { throw "Duplicate registry entrypoint: $($record.entrypoint)" }
    if ($recordsById.ContainsKey($record.id.ToLowerInvariant())) { throw "Duplicate registry id: $($record.id)" }
    $recordsByPath[$key] = $record
    $recordsById[$record.id.ToLowerInvariant()] = $record
    $relativeUnderSkills = $record.entrypoint.Substring('skills/'.Length).Replace('/', [IO.Path]::DirectorySeparatorChar)
    if (-not (Test-Path -LiteralPath (Join-Path $SkillsRoot $relativeUnderSkills))) { throw "Registry entrypoint does not exist: $($record.entrypoint)" }
    if ($record.lifecycle -in @('mandatory','conditional') -and @($record.route_ids).Count -eq 0) { throw "Routable skill '$($record.id)' must declare route_ids." }
}

$discovered = @{}
foreach ($file in Get-ChildItem -LiteralPath $SkillsRoot -Recurse -File -Filter SKILL.md) {
    $relative = $file.FullName.Substring((Resolve-Path $SkillsRoot).Path.Length).TrimStart('\','/').Replace('\','/')
    $entrypoint = "skills/$relative"
    $key = $entrypoint.ToLowerInvariant()
    if ($discovered.ContainsKey($key)) { throw "Duplicate discovered portable skill entrypoint: $entrypoint" }
    $discovered[$key] = $entrypoint
}
foreach ($key in $discovered.Keys) { if (-not $recordsByPath.ContainsKey($key)) { throw "Unregistered portable skill entrypoint: $($discovered[$key])" } }
foreach ($key in $recordsByPath.Keys) { if (-not $discovered.ContainsKey($key)) { throw "Stale registry entrypoint: $($recordsByPath[$key].entrypoint)" } }

Write-Host "Skill registry validation passed ($($recordsByPath.Count) registered portable skills)."
