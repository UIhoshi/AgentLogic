# Specification — Skill Enforcement Hardening

## Objective

Evolve autonomous skill routing from a prose-plus-static-route registry into an auditable, cross-host workflow gate. The system must make route selection, skill coverage, invocation evidence, closure evidence, host capability, and project handover records machine-checkable without claiming that a host intercepted an action it cannot actually observe.

## Functional requirements

1. **Complete portable-skill inventory.** A canonical skill registry must contain one record for every tracked `skills/**/SKILL.md` entrypoint. Every record must declare an identifier, entrypoint, family, lifecycle state, and rationale. Valid lifecycle states are `mandatory`, `conditional`, `manual_only`, `archived`, and `deprecated`.
2. **No silent future additions.** Validation must discover `SKILL.md` files directly and fail when an entrypoint is missing from the registry, duplicated, outside `skills/`, or assigned an invalid/incomplete lifecycle state.
3. **Deterministic task classification.** A machine-readable enforcement contract must define task class, change scope, UI scope, risk/external effect, known exemptions, route ordering, and required route evidence. It must cover small visual corrections, multi-file/refactor/SDD work, security-sensitive work, browser/visual claims, and local-package versus remote-release work.
4. **Route completeness.** Every mandatory/conditional route must specify trigger conditions, ordered dependencies, preflight requirement, invocation evidence, closure evidence, fallback/exemption rules, and final state that it blocks.
5. **Executable lifecycle gate.** A PowerShell command must validate a task ledger in `preflight`, `invocation`, and `closure` modes. It must refuse invalid state transitions and return non-zero on missing strict evidence. Its assertion is limited to recorded/validated workflow state; it must not claim invisible host-tool interception.
6. **Truthful cross-host strictness.** The host-capability contract must declare which installed files and gate commands exist per supported host. Installation must deploy and post-verify the enforcement payload. A host may be described as workflow-enforced only when those artifacts are verified; lack of host-native interception must be explicitly labelled rather than hidden.
7. **Project skill handover.** Projects use `.agentlogic/skill-usage.json` as the machine-readable source of truth for skills that support a durable flow. `CODE_MAP.md` gains a concise Skill Usage summary containing the flow, capability/skill, trigger, source of truth, and reviewed commit. Transient task invocation records remain under `.specify/<task>/`.
8. **Release safety.** Remote release routes require local artifact validation, exact remote target confirmation, and post-result inspection.
9. **Integration.** All four host bundles must include the enforcement module/contracts. Package validation must invoke the new validators and verify adapters deploy the payload.

## Non-functional requirements

- PowerShell scripts run without network access and emit clear remediation diagnostics.
- No registry, ledger, map, or generated bundle may contain secrets, private prompts, raw logs, or machine-specific paths.
- Generated `dist/` files are rebuilt only with `scripts/build-profile.ps1`.
- Existing legacy skill entries default to `manual_only` when trigger metadata has not been reviewed.

## Acceptance tests

- Registry validation passes on the repository and fails against a fixture with an unregistered or duplicate `SKILL.md` entry.
- Enforcement validation accepts a complete preflight → invocation → closure fixture and rejects a missing required invocation or remote target confirmation.
- Package validation, logic-entry validation, profile verification, and adapter post-verification pass.
- Generated host bundles contain the enforcement module and contracts.
- The `CODE_MAP.md` template exposes the bounded Skill Usage handover section.
