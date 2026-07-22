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
if ($registry.schema_version -ne 2) { throw "Unsupported skill routing schema version." }
if (-not $registry.completion_policy) { throw "Missing completion policy." }
$required = @('requirements-grilling','ui-design','ui-implementation','code-review','security-review','extension-security-review','browser-verification','visual-verification','test-design','package-release')
$seen = @{}
foreach ($route in @($registry.routes)) {
  if (-not $route.id -or $seen[$route.id]) { throw "Route ids must be unique and non-empty." }; $seen[$route.id] = $true
  foreach ($field in @('capability','fallback','selection_rule')) { if (-not $route.$field) { throw "Route '$($route.id)' is missing $field." } }
  if (@($route.triggers).Count -eq 0 -or @($route.primary_host_skill_aliases).Count -eq 0 -or @($route.closure_evidence).Count -eq 0) { throw "Route '$($route.id)' needs triggers, primary aliases, and closure evidence." }
}
foreach ($id in $required) { if (-not $seen[$id]) { throw "Missing required autonomous route '$id'." } }
if (@($registry.routes | Where-Object { $_.id -eq 'ui-design' }).primary_host_skill_aliases -notcontains 'imagegen') { throw "UI-design must require imagegen as a primary mockup capability." }
if (@($registry.routes | Where-Object { $_.id -eq 'ui-design' }).primary_host_skill_aliases -contains 'senior-frontend') { throw "UI-design must not treat frontend implementation as mockup capability." }
if (@($registry.routes | Where-Object { $_.id -eq 'ui-implementation' }).primary_host_skill_aliases -notcontains 'senior-frontend') { throw "UI implementation must route to senior-frontend." }
if (@($registry.routes | Where-Object { $_.id -eq 'code-review' }).primary_host_skill_aliases -notcontains 'review-agent') { throw "Code review must include the built-in review-agent." }
if (@($registry.routes | Where-Object { $_.id -eq 'extension-security-review' }).primary_host_skill_aliases -notcontains 'skill-security-auditor') { throw "Untrusted extension review must require skill-security-auditor." }
foreach ($policy in @($registry.non_default_skill_policy)) { foreach ($field in @('skill','status','reason')) { if (-not $policy.$field) { throw "Non-default skill policy is missing $field." } } }
foreach ($requiredPath in @('skills\productivity\product-requirements-grilling\SKILL.md','skills\productivity\product-requirements-grilling\assets\requirements-brief.md','scripts\validate-requirements-brief.ps1')) { if (-not (Test-Path (Join-Path $RepoRoot $requiredPath))) { throw "Missing autonomous workflow asset: $requiredPath" } }

$module = Get-Content -Raw -Encoding UTF8 $modulePath
foreach ($anchor in @('Strict missing-capability policy','Software candidate reporting','invocation evidence')) { if ($module -notmatch [regex]::Escape($anchor)) { throw "Enforcement module missing anchor: $anchor" } }
Write-Host "Autonomous skill routing validation passed ($($registry.routes.Count) routes)."
