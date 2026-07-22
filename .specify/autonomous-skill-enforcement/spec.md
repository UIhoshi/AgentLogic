# Autonomous Skill Enforcement and Software Candidate Registry

## Goal

Turn the existing prose-only skill router into an auditable, host-aware operating contract:
required task types select a canonical capability, map it to an available host skill, record the
selection, and block implementation or completion when required evidence or a mandatory capability
is unavailable. Preserve explicit user opt-outs only where an existing policy allows them.

## Requirements

1. Add a machine-readable canonical capability registry with task triggers, required workflow
   stages, host skill aliases, fallback posture, and completion evidence.
2. Add a profile-shipped enforcement module that requires task classification, capability
   availability checks, invocation records, and an explicit blocked/partial result when a mandatory
   capability is missing.
3. Add mandatory routes for requirements grilling, net-new/substantial UI work, code/PR review,
   security review, testing, browser verification, screenshots, package/release, and external
   installation.
4. Require net-new or substantial UI work to complete single-question requirements grilling and a
   recorded UI brief before image generation; retain the explicit preview opt-out rule.
5. Preserve a narrow exception for clearly classified small UI corrections, with visual verification
   still mandatory.
6. Maintain a reviewed-software candidate registry. When a user asks what is missing, report the
   registry entries relevant to the task and state that GitHub projects require review before
   installation.
7. Validate the canonical registry and profile inclusion deterministically; do not auto-install,
   trust, enable, or archive external skills or software.
8. Regenerate every host bundle and update project maps and the active version documentation.

## Acceptance Criteria

- The default profile includes the enforcement module and bundles its rules for every host.
- A validator fails if mandatory routes have no canonical capability, host alias list, fallback
  posture, or closure evidence.
- Code/PR review is explicitly routed to code-review capability; security reviews retain their
  specialized route.
- UI work cannot move from requirements to image generation until a UI brief and grilling outcome
  exist, except for the documented small-correction path.
- The candidate registry lists OpenTofu, kubectl, psql, FFmpeg, and Go with trigger, source class,
  and pre-install review requirements.
- Package, entry, and generated-bundle verification pass.

## Extension: Product requirements skill and UI-generation decision flow

9. Ship a first-party `product-requirements-grilling` skill that wraps the audited generic grilling
   behavior and produces a deterministic requirements brief.
10. Install that skill into Codex during AgentLogic installation and make it the only primary alias
    for the requirements-grilling route.
11. Add a brief validator. It must block net-new/substantial UI generation and implementation until
    required sections plus user approval are present.
12. For new projects/UI ideas, require the agent to recommend and explicitly ask whether to create a
    mockup. For dissatisfaction with an existing layout, require a current screenshot plus the
    user's stated problems as image-generation/edit inputs before proposing a replacement mockup.

## Extension: Route overlap audit and ordered selection

13. Replace flat host-alias lists with ordered primary and conditionally applicable aliases.
14. Split UI mockup generation from frontend UI implementation; image generation is mandatory for
    the mockup route and a frontend skill is mandatory only after the mockup gate closes.
15. Add the built-in `review-agent` as a primary code-review route and constrain PR/security/test
    specialties to their explicit situations.
16. Record non-default policy for Claude-oriented persistent-memory behavior and high-impact or
    schema-specialized skills; do not delete them automatically.

## Extension: Cross-host first-party skill deployment and canonical-rule convergence

17. Deploy the first-party product-requirements skill through every supported host adapter and
    verify the exact deployed `SKILL.md` path after installation.
18. Add a host deployment contract and static validation so every manifest host has a first-party
    skill target; generic output keeps the skill beside its generated bundle.
19. Retire conflicting legacy mandatory aliases in Modules 35 and 48. Module 49 plus the canonical
    registry are the only source of concrete mandatory skill selection.
20. Narrow Module 48 fallback language so it cannot authorize a downgrade of a contract-mandated
    capability.
