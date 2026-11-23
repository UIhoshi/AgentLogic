# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$ContractPath
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($ContractPath)) {
    $ContractPath = Join-Path $RepoRoot 'contracts\role-personas.json'
}
if (-not (Test-Path -LiteralPath $ContractPath)) {
    throw "Missing role personas contract: $ContractPath"
}

try {
    $contract = Get-Content -Raw -Encoding UTF8 -LiteralPath $ContractPath | ConvertFrom-Json
} catch {
    throw "Invalid role personas JSON: $($_.Exception.Message)"
}

if ($contract.schema_version -ne 1) {
    throw "Unsupported role personas schema_version: $($contract.schema_version)"
}

$leadRoles = @($contract.lead_roles)
if ($leadRoles.Count -ne 11) {
    throw "Expected exactly 11 orthogonal lead_roles in contracts/role-personas.json, found $($leadRoles.Count)."
}

$seenIds = @{}
$seenNums = @{}
foreach ($role in $leadRoles) {
    foreach ($field in @('id', 'title', 'domain')) {
        if ([string]::IsNullOrWhiteSpace([string]$role.$field)) {
            throw "Lead role missing required field '$field'."
        }
    }
    $num = [int]$role.number
    if ($num -lt 1 -or $num -gt 11 -or $seenNums.ContainsKey($num)) {
        throw "Lead role '$($role.id)' has invalid or duplicate number '$($role.number)'."
    }
    $seenNums[$num] = $true
    if ($seenIds.ContainsKey([string]$role.id)) {
        throw "Duplicate lead role id '$($role.id)'."
    }
    $seenIds[[string]$role.id] = $true
    if ($null -eq $role.default_skills -or @($role.default_skills).Count -eq 0) {
        throw "Lead role '$($role.id)' must declare at least one default skill."
    }
}

$funcRoles = @($contract.subagent_functional_roles)
if ($funcRoles.Count -lt 2) {
    throw "Expected at least 2 subagent_functional_roles."
}
$funcIds = @($funcRoles | ForEach-Object { [string]$_.id })
foreach ($reqFunc in @('codebase-explorer', 'independent-verifier')) {
    if ($funcIds -notcontains $reqFunc) {
        throw "Missing required subagent functional role '$reqFunc'."
    }
}
foreach ($fRole in $funcRoles) {
    foreach ($field in @('id', 'title', 'default_posture', 'capability', 'purpose')) {
        if ([string]::IsNullOrWhiteSpace([string]$fRole.$field)) {
            throw "Subagent functional role '$($fRole.id)' missing '$field'."
        }
    }
    if ($seenIds.ContainsKey([string]$fRole.id)) {
        throw "Subagent functional role id '$($fRole.id)' collides with a lead role id."
    }
}

$dispatch = $contract.subagent_dispatch_contract
if ($null -eq $dispatch) {
    throw "Missing subagent_dispatch_contract."
}
$expectedPostures = @('explore', 'implement', 'plan', 'review', 'verify')
if ((@($dispatch.execution_postures | Sort-Object) -join '|') -ne ($expectedPostures -join '|')) {
    throw "subagent_dispatch_contract.execution_postures must match explore|implement|plan|review|verify."
}
if ($null -eq $dispatch.guardrails -or $dispatch.guardrails.max_depth -ne 1 -or $dispatch.guardrails.disjoint_write_ownership -ne $true -or $dispatch.guardrails.propagate_bound_skills -ne $true -or $dispatch.guardrails.lead_synthesizes_and_updates_maps -ne $true) {
    throw "subagent_dispatch_contract.guardrails must enforce max_depth=1, disjoint_write_ownership=true, propagate_bound_skills=true, and lead_synthesizes_and_updates_maps=true."
}

Write-Host "Role personas contract validation passed ($($leadRoles.Count) lead roles, $($funcRoles.Count) subagent functional roles)."
