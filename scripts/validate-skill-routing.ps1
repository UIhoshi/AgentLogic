# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path)
$ErrorActionPreference = "Stop"
$registryPath = Join-Path $RepoRoot "contracts\skill-routing.json"
$modulePath = Join-Path $RepoRoot "modules\49_V6_8_AutonomousSkillEnforcement.md"
if (-not (Test-Path $registryPath)) { throw "Missing canonical skill routing registry: $registryPath" }
if (-not (Test-Path $modulePath)) { throw "Missing autonomous skill enforcement module: $modulePath" }
try { $registry = Get-Content -Raw -Encoding UTF8 $registryPath | ConvertFrom-Json } catch { throw "Invalid JSON in ${registryPath}: $($_.Exception.Message)" }
if ($registry.schema_version -ne 1) { throw "Unsupported skill routing schema version." }
if (-not $registry.completion_policy) { throw "Missing completion policy." }
$required = @('requirements-grilling','ui-design','code-review','security-review','browser-verification','visual-verification','test-design','package-release')
$seen = @{}
foreach ($route in @($registry.routes)) {
  if (-not $route.id -or $seen[$route.id]) { throw "Route ids must be unique and non-empty." }; $seen[$route.id] = $true
  foreach ($field in @('capability','fallback')) { if (-not $route.$field) { throw "Route '$($route.id)' is missing $field." } }
  if (@($route.triggers).Count -eq 0 -or @($route.host_skill_aliases).Count -eq 0 -or @($route.closure_evidence).Count -eq 0) { throw "Route '$($route.id)' needs triggers, host aliases, and closure evidence." }
}
foreach ($id in $required) { if (-not $seen[$id]) { throw "Missing required autonomous route '$id'." } }
$module = Get-Content -Raw -Encoding UTF8 $modulePath
foreach ($anchor in @('Strict missing-capability policy','Software candidate reporting','invocation evidence')) { if ($module -notmatch [regex]::Escape($anchor)) { throw "Enforcement module missing anchor: $anchor" } }
Write-Host "Autonomous skill routing validation passed ($($registry.routes.Count) routes)."
