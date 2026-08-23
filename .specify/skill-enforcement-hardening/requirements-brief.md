# Requirements Brief

## Status
- Task classification: major feature; cross-host rule, contract, installer, validator, and documentation change.
- User approval: approved
- Mockup decision: not applicable (no user-interface implementation).

## Goal and users

Make AgentLogic route required skills through machine-readable, programming-level enforcement so coding agents and maintainers do not silently skip a required skill. Primary users are AI coding agents, project maintainers, and future skill integrators across Codex, Claude, Antigravity, and generic deployments.

## Core flow

1. Classify a task using stable task and risk fields.
2. Match the ordered skill routes, including required dependencies and permitted exemptions.
3. Verify the host can enforce the route before installation or execution is labelled strict.
4. Record selected skills, invocation evidence, and closure evidence in a machine-readable ledger.
5. Reject implementation, verified completion, package, or release transitions when strict requirements are missing.
6. Synchronize the project-level skill record and concise CODE_MAP.md Skill Usage summary when a project adopts, replaces, upgrades, or retires a skill.

## Scope and non-goals

In scope:
- A canonical registry covering every existing and future portable skill entrypoint.
- Explicit lifecycle states: mandatory, conditional, manual_only, archived, or deprecated.
- Deterministic trigger classification, route ordering, exemptions, fallbacks, closure evidence, and strict host capability checks.
- Cross-host installer and package validation for Codex, Claude, Antigravity, and generic bundles.
- A project-local .agentlogic/skill-usage.json source of truth and a concise CODE_MAP.md summary contract.

Non-goals:
- Claiming that a host has intercepted a tool call when it has no verified hook capability.
- Automatically trusting, installing, enabling, or invoking external skills.
- Duplicating a complete historical invocation log inside CODE_MAP.md.
- Building any UI or generating a visual mockup.

## Content, brand, and assets

This is a policy and automation change. It uses Markdown, PowerShell, and JSON contracts only. No brand, visual assets, copied third-party assets, or generated UI artifacts are needed.

## Integrations, data, and permissions

- Integrates with manifest profiles, build-profile, four host adapters, existing skill-routing validation, package validation, and first-party skill deployment.
- Stores project-local skill usage under .agentlogic/skill-usage.json. It must contain no credentials, private prompts, raw terminal output, or other sensitive content.
- A host may be declared strict only after its declared enforcement capability has been installed and post-verified. Unsupported hosts must fail strict installation rather than silently downgrade.

## Responsive, accessibility, and performance constraints

No UI surface is in scope. Validators must be deterministic, local, offline-capable, and produce short actionable errors. Registry and ledger processing must avoid scanning unrelated project content and must support the existing Windows PowerShell environment.

## Acceptance criteria

- Every discovered portable SKILL.md has exactly one explicit registry record and valid lifecycle state; unregistered future skills fail validation.
- Every mandatory or conditional route declares classifier conditions, order/dependencies, permitted fallback/exemption policy, and closure evidence.
- A strict host deployment cannot succeed without a verified preflight, invocation-record, and closure-validation capability declaration.
- Cross-host profiles include the enforcement policy and contracts; package validation detects omissions and generated-bundle drift.
- A project has a machine-readable skill-usage source of truth plus a bounded CODE_MAP.md Skill Usage summary; validators reject missing or inconsistent updates when a skill lifecycle event is recorded.
- Remote-release routes require exact target confirmation, local artifact validation, and post-result inspection.
- Existing low-confidence legacy skills default to manual_only until their trigger and closure metadata are reviewed.

## Existing-layout change brief
- Current screenshot path (required only for dissatisfied existing layouts): Not applicable; no existing UI layout change.
- User dissatisfaction and requested changes: Not applicable; this is workflow enforcement and project knowledge synchronization.

## Decision log
- Decision: Cover Codex, Claude, Antigravity, and generic bundles.
  - Status: user-confirmed
  - Rationale: The user requested full-host enforcement rather than a single-host implementation.
- Decision: Enforce strict capability truthfulness.
  - Status: user-confirmed
  - Rationale: A host without verified preflight, invocation, and closure capability must not be labelled strictly enforced.
- Decision: Require explicit lifecycle registration for existing and future skills.
  - Status: user-confirmed
  - Rationale: Unregistered or incomplete skills must fail package/CI validation to prevent silent routing gaps.
- Decision: Default incomplete legacy skills to manual_only.
  - Status: user-confirmed
  - Rationale: Avoid unsafe automatic routing until triggers and closure evidence are reviewed.
- Decision: Store project skill use in a dual record.
  - Status: user-confirmed
  - Rationale: .agentlogic/skill-usage.json is machine-verifiable; CODE_MAP.md is a concise handover summary.
