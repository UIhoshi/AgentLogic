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
if ($registry.schema_version -ne 1) { throw "Unsupported skill registry schema version: $($registry.schema_version)" }
$states = @($registry.lifecycle_states)
$expectedStates = @('mandatory','conditional','manual_only','archived','deprecated')
if ((@($states | Sort-Object) -join ',') -ne (@($expectedStates | Sort-Object) -join ',')) { throw 'Skill registry lifecycle_states must be the canonical five states.' }

$recordsByPath = @{}
$recordsById = @{}
foreach ($record in @($registry.records)) {
    foreach ($field in @('id','entrypoint','family','lifecycle','reason')) {
        if ([string]::IsNullOrWhiteSpace([string]$record.$field)) { throw "Skill registry record is missing '$field'." }
    }
    if ($states -notcontains $record.lifecycle) { throw "Skill registry record '$($record.id)' has invalid lifecycle '$($record.lifecycle)'." }
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
