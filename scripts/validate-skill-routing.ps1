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
$hostCapabilitiesPath = Join-Path $RepoRoot "contracts\host-skill-capabilities.json"
if (-not (Test-Path $registryPath)) { throw "Missing canonical skill routing registry: $registryPath" }
if (-not (Test-Path $modulePath)) { throw "Missing autonomous skill enforcement module: $modulePath" }
if (-not (Test-Path $hostCapabilitiesPath)) { throw "Missing host skill deployment contract: $hostCapabilitiesPath" }
try { $registry = Get-Content -Raw -Encoding UTF8 $registryPath | ConvertFrom-Json } catch { throw "Invalid JSON in ${registryPath}: $($_.Exception.Message)" }
if ($registry.schema_version -ne 2) { throw "Unsupported skill routing schema version." }
try { $hostCapabilities = Get-Content -Raw -Encoding UTF8 $hostCapabilitiesPath | ConvertFrom-Json } catch { throw "Invalid JSON in ${hostCapabilitiesPath}: $($_.Exception.Message)" }
if ($hostCapabilities.schema_version -ne 1 -or $hostCapabilities.first_party_skill -ne "product-requirements-grilling") { throw "Invalid host skill deployment contract." }
foreach ($targetHostName in @('codex','claude','antigravity','generic')) { if (-not $hostCapabilities.hosts.$targetHostName.target_relative) { throw "Host deployment contract missing target for $targetHostName." } }
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
$governancePath = Join-Path $RepoRoot "modules\35_V6_5_SkillGovernanceAndMandatoryUse.md"
$routingPath = Join-Path $RepoRoot "modules\48_V6_8_SkillAndToolRouting.md"
foreach ($path in @($governancePath, $routingPath)) { if (-not (Test-Path $path)) { throw "Missing routing integration module: $path" } }
$governance = Get-Content -Raw -Encoding UTF8 $governancePath
if ($governance -notmatch [regex]::Escape('Concrete mandatory skill selection is defined only by `contracts/skill-routing.json` and Module 49.')) { throw 'Skill governance does not defer concrete mandatory selection to the canonical registry.' }
$routing = Get-Content -Raw -Encoding UTF8 $routingPath
foreach ($anchor in @('For a matched route, honor its declared fallback:', 'Module 49 and the schema-v2 contract override any older concrete skill names')) { if ($routing -notmatch [regex]::Escape($anchor)) { throw "Routing module missing canonical precedence anchor: $anchor" } }
$affordancePath = Join-Path $RepoRoot "modules\51_V6_8_AffordanceFirstToolUse.md"
if (-not (Test-Path $affordancePath)) { throw "Missing affordance-first tool-use module: $affordancePath" }
$affordance = Get-Content -Raw -Encoding UTF8 $affordancePath
foreach ($anchor in @('Natural operating model', 'Outcome-to-tool reflexes')) { if ($affordance -notmatch [regex]::Escape($anchor)) { throw "Affordance module missing anchor: $anchor" } }
Write-Host "Autonomous skill routing validation passed ($($registry.routes.Count) routes)."
