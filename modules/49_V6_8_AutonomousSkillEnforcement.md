# Autonomous Skill Enforcement

## Purpose

This module makes skill routing an operational completion contract. It complements Module 48:
Module 48 selects evidence and a route; this module requires the selected route to be recorded and
prevents silent degradation when a mandatory capability is absent.

## Mandatory task state

Before implementation, review, or a verified completion claim, record:

1. task classification and intended conclusion;
2. each matched route from `contracts/skill-routing.json`;
3. the canonical capability, selected host skill alias, availability and permission posture;
4. invocation evidence or the exact unavailability reason; and
5. the required closure evidence and final status.

An alias is only a candidate. The agent must confirm that the matching host skill is available and
must read/invoke it before claiming that route was followed.

## Strict missing-capability policy

For a mandatory route, missing capability, denied permission, or failed required evidence blocks
implementation when the route says `block_before_*`, and blocks a `verified` completion claim for
all other routes. The agent may report a partial/static result only with the missing capability and
next safe action stated explicitly. It must not silently replace a mandatory specialized skill with
generic reasoning or a custom script.

Explicit opt-outs remain limited to their existing contracts, such as the UI mockup opt-out. They do
not waive requirements discovery, security evidence, or visual/runtime proof.

## Core routes

- Major features, net-new UI, and substantial UI refactors require single-question requirements
  grilling and an approved requirements brief before planning or mockup generation.
- Net-new/substantial UI then requires image generation, user approval or explicit opt-out, and
  visual verification after implementation. Clearly classified small corrections may skip a new
  mockup but never visual verification.
- Code audits, PR reviews, and release reviews require a code-review capability and a severity-
  backed review report. Security-scoped reviews additionally require security capability.
- Dynamic browser claims require browser automation; desktop/visible claims require capture.
- Behavior changes require test-engineering capability and relevant command evidence.
- Package/install/release completion requires artifact validation and post-result inspection.

## Software candidate reporting

When the user asks what is missing, inspect the current host and report only the relevant entries
from `docs/software-candidates.md`, including trigger, source class, and `review-required` status.
The directory is a joint decision queue, not installation authority. Any GitHub project must be
pinned and security-audited before installation.

## Honest enforcement boundary

The registry and validator prove route declarations are complete; they cannot independently prove
an LLM actually invoked a skill. Invocation records and matching evidence remain mandatory, and
unrecorded use must be treated as unverified.

## Product requirements and UI generation

Use the first-party product-requirements-grilling skill for every requirements-grilling route. It must produce a user-approved brief that passes scripts/validate-requirements-brief.ps1 before mockup generation or UI implementation. For a new project or UI idea, recommend a mockup and explicitly ask whether the user wants it generated. For an existing layout the user dislikes, capture the current layout first; include that screenshot and the user's dissatisfaction/change brief in the image-generation or editing request. Approval or explicit mockup opt-out remains required before formal UI code.

## Ordered selection and overlap control

A route is not a flat list of interchangeable skills. The canonical registry stores one or more
ordered `primary_host_skill_aliases`, narrowly scoped `conditional_host_skill_aliases`, and a
selection rule. A conditional skill is never proof that a missing primary capability was supplied.

- UI work is deliberately split: `ui-design` requires image generation for the mockup/edit, while
  `ui-implementation` routes later code work to a frontend implementation skill. A frontend skill
  cannot close the mockup route.
- Code review defaults to the built-in defect-first `review-agent` or `code-reviewer`; the
  PR-focused skill is additional only for PR/merge workflow work.
- Security, testing, browser, and release specialties are selected by their explicit scenario in
  the registry rather than invoked together as generic substitutes.
- Figma context retrieval and Figma implementation are complementary specialized paths, not a
  generic UI-design substitute.

## Non-default and persistent-memory skills

Do not automatically invoke `self-improving-agent` to write host-specific memory or permanent
rules. AgentLogic's project-native records remain the durable source of truth: `AGENTS.md`,
`PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. Use its analysis functions only with
an explicit user request and manually transfer any redacted, verified lesson through the normal
project knowledge-sync contract.

Skills marked `specialized_only` in the registry are not duplicate deletions; they are excluded
from generic routing until the request matches their narrow domain and risk boundary.

- Untrusted skills and plugins have their own extension-security route, whose primary skill is `skill-security-auditor`; a generic source-code security review cannot satisfy this trust boundary.
