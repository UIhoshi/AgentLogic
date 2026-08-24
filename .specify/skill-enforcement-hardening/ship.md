# Shipping Review Record — Programming-Level Skill Enforcement

## Scope

This change adds complete portable-skill lifecycle registration, schema-v3 ordered routing,
workflow-gate task records, cross-host enforcement payload deployment, and project Skill Usage
handover records. It changes rule architecture and installer behavior but adds no application auth,
database, remote API, or secret surface.

## Architecture and flow review

- **Registry flow:** `skills/**/SKILL.md` → `contracts/skill-registry.json` →
  `validate-skill-registry.ps1`; unregistered, duplicate, stale, or invalid-lifecycle entries fail.
- **Task flow:** classification → deterministic matched routes → preflight availability → recorded
  invocation → route closure with evidence/dependencies, stored in
  `.specify/<task>/skill-execution.json`.
- **Host flow:** adapter → `deploy-skill-enforcement.ps1` → verified payload containing the gate
  command plus its three contracts. `host-skill-capabilities.json` declares
  `workflow_enforced` and explicitly declares `native_tool_interception: false`.
- **Project handover flow:** `.agentlogic/skill-usage.json` is machine-readable; `CODE_MAP.md`
  contains only the concise durable-flow summary.

## Self-refuting audit

| Finding / claim | Evidence | Counter-argument attempted | Final status |
| --- | --- | --- | --- |
| The change guarantees interception of every arbitrary host tool call. | The host contract explicitly sets `native_tool_interception: false`; the gate validates a task ledger. | The deployed command can block recorded workflow transitions, but no inspected adapter registers a host-native pre-tool hook. | **Cleared as an overclaim.** The delivered guarantee is workflow enforcement, not invisible tool interception. |
| A future portable skill can be added without lifecycle handling. | Registry validator scans every `skills/**/SKILL.md` and compares it with registry records. | A skill could be added outside `skills/`; that is outside the portable-skill boundary and remains a repository-boundary review issue. | **Verified within the declared portable-skill boundary.** |
| Remote release can close without target confirmation. | `package-release` now requires `exact_remote_target_confirmation`; the test includes a negative closure fixture. | A caller could bypass the workflow command, but then it has no closed/verified route record and must not be reported as verified. | **Verified workflow-gate behavior; native bypass prevention not claimed.** |
| The four adapters deploy an equivalent payload. | All adapter scripts call deployment and `-Verify`; package validation asserts both anchors. | No real home-directory installation was run because that mutates user host configuration. | **Partially verified** by static adapter inspection and package validation; live install smoke tests remain a follow-up. |

## Validation evidence

- `node scripts/check-logic-entry.js` — passed.
- `scripts/validate-skill-registry.ps1` — passed with 116 registered portable skills.
- `scripts/validate-skill-routing.ps1` — passed with 10 ordered routes.
- `scripts/test-skill-enforcement.ps1` — passed positive lifecycle, unregistered-skill negative, and
  missing remote-target-confirmation negative cases.
- `scripts/validate-requirements-brief.ps1` — passed.
- `scripts/skill-enforcement.ps1 -Mode validate-project-usage` — passed for this repository.
- `git diff --check` — passed.
- `scripts/maintainer-check.ps1` — passed.

## Remaining review gap

The environment does not provide the registry's `review-agent` or `code-reviewer` capability, so no
capability-qualified formal code-review report is claimed. The static self-refuting review above is
not a replacement for that route.

## Post-review correction — dependency gating

- **Finding:** `ui-implementation` could record invocation before the `requirements-grilling` and
  `ui-design` routes closed, because dependency checks ran only during route closure.
- **Correction:** `skill-enforcement.ps1` now asserts every `requires_routes` dependency before
  recording invocation and reuses the same assertion at closure. It also resolves its default
  repository root after PowerShell parameter binding, so documented standalone invocation works.
- **Counter-argument:** A caller may still bypass the workflow command entirely. That is outside
  this workflow gate's declared enforcement boundary and cannot be represented as host-native
  interception.
- **Status:** **Verified for recorded workflow state.** The negative UI-route invocation fixture
  and the no-`-RepoRoot` project-usage fixture both fail/pass as expected.
