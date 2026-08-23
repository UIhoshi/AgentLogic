# Plan — Programming-Level Skill Enforcement

## Architecture

### Canonical contracts

- Add `contracts/skill-registry.json`: one explicit record per portable `SKILL.md`; any unreviewed legacy entry is `manual_only` with a reason.
- Add `contracts/skill-enforcement.json`: schema v1 for task classification, route sequence, strict workflow gate semantics, task-record fields, project skill-usage fields, and host capability requirements.
- Upgrade `contracts/skill-routing.json` to schema v3: route IDs retain current capabilities but add machine-evaluable `when`, `requires_routes`, `blocked_transitions`, `invocation_evidence`, and exact remote-release closure evidence.
- Upgrade `contracts/host-skill-capabilities.json`: each host declares the deployed enforcement directory, entry command, required payload, workflow gate support, and honest `native_tool_interception` status.

### Executable enforcement

- Add a common `scripts/skill-enforcement.ps1` command with `preflight`, `record-invocation`, `closure`, and `validate-project-usage` modes. It validates a task record under `.specify/<task>/skill-execution.json` against the contracts and refuses invalid lifecycle states.
- Add `scripts/deploy-skill-enforcement.ps1`, used by every adapter, to copy the command and required contracts to the declared host payload location and post-verify checksums/files.
- Add `scripts/validate-skill-registry.ps1` and extend `scripts/validate-skill-routing.ps1`; package validation invokes both. Add deterministic script tests with positive and negative fixtures.
- Enforcement is a **workflow gate**: it proves recorded, contract-valid route progression and blocks supported lifecycle states. It explicitly does not represent unsupported host-native interception as fact.

### Project knowledge integration

- Add a `Skill Usage` section to `templates/CODE_MAP.md`.
- Update knowledge-sync/routing/enforcement documentation so project `.agentlogic/skill-usage.json` is the durable machine-readable source, `CODE_MAP.md` is concise navigation, and `.specify/<task>/skill-execution.json` is the task-level evidence.

### Host and profile integration

- Include the new policy module and contracts in the enhanced profiles and version/source documentation.
- Update each adapter to deploy enforcement assets and verify the host-specific entry command before reporting success.
- Rebuild all generated host bundles rather than hand editing `dist/`.

## Red-Team Results

| Rank | Fails if ___ | Steelman / counter-argument | Mitigation and test |
| --- | --- | --- | --- |
| 1 | a workflow ledger is reported as host-native tool interception | Static installers can verify files but cannot see arbitrary host calls | Declare the enforcement level and native interception explicitly; reject any contract that labels a non-intercepting host as native strict; test invalid capability data. |
| 2 | a future `SKILL.md` bypasses the registry | A manual list eventually drifts | Discover all entrypoints directly from `skills/`; fail on missing, duplicate, or stale registry records; fixture test an unregistered entry. |
| 3 | an Agent records a route but skips invocation/closure evidence | JSON alone does not prove reality | Gate workflow state transitions through the command, require evidence fields, and label unrecorded work unverified; test missing invocation rejection. |
| 4 | route overlap causes visual/browser/testing validation to be skipped | Several task labels can be true simultaneously | Add ordered dependencies and a merged route plan; test a UI browser task and small visual correction classification. |
| 5 | strict deployment blocks all supported hosts due to missing host hooks | Hosts differ and some have no native interception API | Deploy a common workflow gate to all; report `workflow_enforced` versus `native_tool_interception`; never silently claim stronger capability. |
| 6 | CODE_MAP becomes an unbounded invocation log | Every task can use many skills | Keep only durable flow-to-skill rows in CODE_MAP; task events remain in `.specify/`; validate the dedicated JSON source. |
| 7 | broad registry updates misclassify security/CTF skills | Legacy subskills have sparse metadata | Default to `manual_only`, retain reason, and require later reviewed promotion. |

## Tasks

1. Define contracts and generate a complete initial skill registry.
2. Implement registry/routing/enforcement validators and their fixture tests.
3. Implement the workflow-gate command and payload deployment script.
4. Upgrade all adapters and host capability declarations; verify strictness labels.
5. Update module/version/profile/template documentation and package validation.
6. Rebuild bundles, run test/validation matrix, inspect diffs, and compile shipping review record.
