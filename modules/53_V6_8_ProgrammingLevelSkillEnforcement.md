# V6.8 Programming-Level Skill Enforcement

Status: **Active in the enhanced profiles.**

This module turns skill selection into a machine-checkable workflow gate. It complements Modules
29–31: those modules decide the evidence strength; this module prevents a matched required skill
route from being silently omitted during planning, implementation, review, verification, packaging,
or project handover.

## 1. Enforcement boundary

The enforcement level is deliberately explicit:

- **workflow_enforced** means the installed command validates task classification, matched routes,
  selected capabilities, invocation records, closure evidence, and permitted state transitions.
  Missing strict evidence blocks the declared workflow transition.
- **native_tool_interception** means a host-native mechanism can observe or prevent an individual
  tool call. Do not claim this level unless the host contract and post-install verification prove it.

A workflow ledger is evidence of a contract-valid recorded process, not proof of invisible host
behavior. An unrecorded skill invocation remains unverified; a host without native interception
must state that limitation rather than presenting workflow enforcement as a sandbox.

## 2. Canonical contracts

The following files are one system and must be updated together:

- `contracts/skill-registry.json`: exactly one lifecycle record for every `skills/**/SKILL.md`.
  Valid lifecycle states are `mandatory`, `conditional`, `manual_only`, `archived`, and
  `deprecated`. Every record also carries validated activation metadata: a route candidate derives
  its triggers from the canonical route contract, while a manual record selects only through the
  controlled manual-selection taxonomy. Existing skills with insufficient reviewed automatic-route
  evidence default to `manual_only` rather than becoming automatic.
- `contracts/skill-routing.json`: ordered task routes, triggers, dependencies, required invocation
  evidence, closure evidence, fallback/exemption policy, and blocked transitions.
- `contracts/skill-enforcement.json`: valid task classification dimensions, signal derivation,
  task-record state machine, and project skill-usage schema.
- `contracts/host-skill-capabilities.json`: each host's installed workflow-gate payload and its
  honestly declared native-interception status.

Adding a new portable skill without a registry record is a package-validation failure. Promoting a
skill from `manual_only` requires a reviewed trigger, route/fallback decision, invocation evidence,
closure evidence, host availability posture, and test coverage.

Use `scripts/audit-skill-duplicates.ps1` to identify exact-content and duplicate declared-name
candidates. The command is read-only; a candidate must still pass the four-part duplication test in
Module 35 before its files or registry record may be removed.

## 3. Required task state machine

For a non-trivial task, use `.specify/<task>/skill-execution.json` and the deployed
`skill-enforcement.ps1` command:

1. `initialize`: supply structured classification, which deterministically derives all matched
   routes in order.
2. `preflight`: confirm selected capabilities are available and block strict routes that are not.
3. `record-invocation`: write the required skill invocation evidence.
4. `closure`: require all route-specific evidence and closed route dependencies before a route is
   closed.

The command rejects changed route sets, invalid state transitions, missing strict skills, missing
invocation records, missing closure evidence, and remote releases without exact target
confirmation. A task may report a partial or blocked outcome when a required capability is absent;
it may not call that outcome verified.

## 4. Multi-route ordering and exemptions

Routes are merged from the classification signals, then sorted by their declared order. Dependencies
are blocking: requirements grilling closes before UI design; UI design closes before UI
implementation. A small visual correction may skip a new mockup only under the existing explicit
rule, but it always matches visual verification. An explicit mockup opt-out is not a waiver for
requirements discovery, browser/visual evidence, security evidence, or test evidence.

Remote release closure always includes local artifact validation, exact remote target confirmation,
and post-result inspection. Native package fallback applies only where the route explicitly permits
it; it never authorizes an external release mutation without the remote checks.

## 5. Cross-host deployment

Every supported adapter deploys the same self-contained enforcement payload and verifies it after
copying. The payload includes the command and the registry, routing, and enforcement contracts.
A host may only be labelled `workflow_enforced` after this verification. Adapters and documentation
must not call the deployment `native_tool_interception` unless an actual verified host hook is added
in a later, host-specific change.

## 6. Project Skill Usage handover

A business project records durable skill use in `.agentlogic/skill-usage.json` and maintains a
concise `## Skill Usage` section in `CODE_MAP.md`. The JSON record includes the skill/capability,
flows, trigger, source/version or provider, status, and reviewed commit. The map points to the JSON
source; it is not a raw invocation log. Per-task events remain under `.specify/<task>/`.

When a project adopts, replaces, upgrades, or retires a durable skill, update the JSON source and
its CODE_MAP summary in the same commit. Never store credentials, private prompts, raw logs, or
machine paths in either record.

## 7. Validation and future integration

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skill-registry.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skill-routing.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-enforcement.ps1
```

`validate-package.ps1` invokes the registry and routing checks. Future integrations must add the
skill registry record and any reviewed route changes before the package can validate; no installer,
profile bundle, or prose-only mention is an alternative path.
