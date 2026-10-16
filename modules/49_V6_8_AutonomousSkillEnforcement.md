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

## Portable-skill activation metadata

Every portable registry record declares explicit activation metadata. `mandatory` and
`conditional` records are `route_candidate` entries whose triggers are derived from the canonical
route contract; `manual_only` records are `manual` entries whose controlled selection conditions
make their scope visible without auto-enabling them. In particular, security/CTF, persistent-memory,
and other unreviewed specialties remain manual even when their metadata names a relevant task.
Use `scripts/audit-skill-duplicates.ps1` for read-only SHA-256 and front-matter-name candidate
discovery. A candidate is not deletion authority: removal still requires proof that it contributes
no unique workflow, scripts, templates, references, or risk boundary.

## Strict missing-capability policy

For a mandatory route, missing required evidence capability, denied permission, or failed required
evidence blocks implementation when the route says `block_before_*`, and blocks a `verified`
completion claim for all other routes. A missing specialist does not by itself block an ordinary
task when that route explicitly permits a native evidence fallback; record the missing specialist,
use the permitted native tool, and never claim specialist invocation. The agent may report a
partial/static result only with the missing capability and next safe action stated explicitly. It
must not silently replace a strict specialized route with generic reasoning or a custom script.

Explicit opt-outs remain limited to their existing contracts, such as the UI mockup opt-out. They do
not waive requirements discovery, security evidence, or visual/runtime proof.

## Prerequisite bundle and single-consent installation

When the user requests installation or enablement and a required audit, tool, dependency, or trust
decision is missing, do not turn the dependency chain into repeated surprise questions. First do
read-only preflight against the current host and present one concise, actionable bundle:

1. State that installation cannot safely proceed **yet**, and distinguish already available
   capabilities from the exact missing items. Do not ask the user to install an item that is already
   available; if no permitted route exists, say so rather than inventing one.
2. For each proposed item, give its purpose, source and pinned version/commit when known, exact
   install/enable target, required security and integrity reviews, expected local/external effects,
   credentials or data egress, and the post-install check or recovery path. Mark unresolved facts
   explicitly; do not describe a candidate as trusted or installed.
3. Ask **once** whether the user wants the listed reviews, prerequisite setup, and requested
   installation performed together. An explicit yes authorizes only the disclosed targets and
   actions; it is not blanket consent for future installs or a waiver of host permissions.
4. Within that approved scope, run the reviews before trusting or executing the candidate, then
   perform bounded steps and post-result verification without asking again at every ordinary
   boundary. Stop if a mandatory check fails, permission is denied, or a required capability
   remains unavailable. Report the blocker and the next safe option instead of retrying blindly.
5. If discovery changes the source/version, target, data destination, credential need, external
   effect, or risk materially, present the delta and obtain a new decision before that new action.
   Never silently add a dependency or extend the approval to a different product or host.

If the security-audit capability itself is missing, include that gap in the same bundle. Use an
already trusted first-party/local review path when permitted; otherwise remain blocked and offer a
reviewable setup option. Do not fetch an untrusted auditor and let it certify its own installation.
The bundle reduces conversation friction, not the underlying audit or permission standard.

Suggested user-facing shape (render in the user's language): “I cannot safely install this yet.
Missing: [only the actual gaps]. I can review [source/version] and install [listed items] to
[targets], then run [checks]; [notable risks/effects]. Shall I do these together?”

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

Use the first-party product-requirements-grilling skill for every requirements-grilling route. It must produce a user-approved brief that passes scripts/validate-requirements-brief.ps1 before mockup generation or UI implementation. For a new project or UI idea, recommend a mockup and explicitly ask whether the user wants it generated. For an existing layout the user dislikes, capture the current layout first; include that screenshot and the user's dissatisfaction/change brief in the image-generation or editing request. This approval/opt-out gate applies to net-new UI and substantial UI refactors; clearly classified small visual corrections may skip a new mockup but never visual verification.

## Ordered selection and overlap control

A route is not a flat list of interchangeable skills. The canonical registry stores one or more
ordered `primary_host_skill_aliases`, narrowly scoped `conditional_host_skill_aliases`, and a
selection rule. A conditional skill is never proof that a missing primary capability was supplied.

- UI work is deliberately split: `ui-design` requires image generation for the mockup/edit, while
  `ui-implementation` routes later code work to a frontend implementation skill. A frontend skill
  cannot close the mockup route.
- Code review defaults to the defect-first `review-agent` or `code-reviewer`; the portable `code-review` skill is an approved conditional route when installed and selected. The PR-focused skill is additional only for PR/merge workflow work.
- Security, testing, browser, and release specialties are selected by their explicit scenario in
  the registry rather than invoked together as generic substitutes.
- Figma context retrieval and Figma implementation are complementary specialized paths, not a
  generic UI-design substitute.

This registry is the sole source of concrete mandatory skill names. Modules 35 and 48 may govern
availability or evidence families, but they must defer to this registry when naming a required
skill or deciding whether a fallback is allowed.

Module 51 governs the natural first choice: intent → evidence → native tool → specialist when
materially useful → closure. The registry refines that choice for routes that need a specific
capability; it does not turn every routine task into a skill-selection ceremony.

## Cross-host first-party skill availability

The `product-requirements-grilling` skill is a first-party requirement, not merely a Codex-local
convenience. Every supported adapter must deploy it and post-verify its `SKILL.md` path according
to `contracts/host-skill-capabilities.json`. For Antigravity, whose per-file rule limit (`24 KB`)
requires a delegation hook in `GEMINI.md` rather than inlining the full bundle, the adapter must
also inline the blocking **UI Preview & Requirements Gate** directly inside `GEMINI.md` and register
the host-local skills directory in `config/skills.json`, mapping `ui-design` image generation to
Antigravity's built-in `image-generator` subagent or `nano-banana-pro`. A generic installation places it beside the generated
bundle under `skills/`; the generic host integrator must load that colocated skill before treating
requirements-grilling as available. The deployment contract does not claim that third-party or
system skills are installed.

## Non-default and persistent-memory skills

Do not automatically invoke `self-improving-agent` to write host-specific memory or permanent
rules. AgentLogic's project-native records remain the durable source of truth: `AGENTS.md`,
`PROJECT_MAP.md`, `CODE_MAP.md`, and `.learnings/ERRORS.md`. Use its analysis functions only with
an explicit user request and manually transfer any redacted, verified lesson through the normal
project knowledge-sync contract.

Skills marked `specialized_only` in the registry are not duplicate deletions; they are excluded
from generic routing until the request matches their narrow domain and risk boundary.

- Untrusted skills and plugins have their own extension-security route, whose primary skill is `skill-security-auditor`; a generic source-code security review cannot satisfy this trust boundary.

## Programming-Level Enforcement Contract

Module 53 and `contracts/skill-registry.json`, `contracts/skill-routing.json`,
`contracts/skill-enforcement.json`, and `contracts/host-skill-capabilities.json` are the executable
continuation of this module. Every portable `SKILL.md` must have an explicit lifecycle record.
Matched routes must progress through the deployable preflight → invocation → closure state machine;
a missing strict capability or evidence blocks the declared transition. The command validates
recorded workflow state only and must not be represented as unsupported host-native tool
interception. Project-level durable use belongs in `.agentlogic/skill-usage.json`, with a concise
`CODE_MAP.md` Skill Usage summary.
