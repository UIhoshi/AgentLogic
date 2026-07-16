# Grok Build Complementary Integration Plan

## Execution order

1. Add the research matrix and this specification without changing runtime logic.
2. Run the Red-Team review below and resolve load-bearing risks.
3. Create `modules/44_V6_8_GrokBuildOperationalIntegration.md` as the method-layer contract.
4. Create `versions/AgentLogic_V6_8_1.md` from V6.7.2's stable line, add the new module,
   and register Grok Build as a comparative source.
5. Promote V6.8.0 through `manifest.json`, active entry docs, and install guidance using
   the repository release script rather than hand-editing version pointers.
6. Rebuild all host bundles from `core-enhanced`.
7. Run package, logic-entry, maintainer, and install/post-install verification.
8. Perform Converge and update tasks for any discrepancy.

## Red-Team results

### Claim 1: The external repository is an appropriate source for logic integration

- Steelman: Grok Build exposes concrete, tested patterns for project rules, sessions,
  permissions, compaction, skills, plugins, and subagents.
- Attack: its source is an application runtime snapshot, not a general governance specification;
  importing implementation details could couple AgentLogic to Grok or xAI assumptions.
- Fails if: the new module contains Rust APIs, Grok-only commands, or provider-specific behavior
  that cannot be applied to other hosts.
- Mitigation: translate only host-neutral contracts; record implementation paths as evidence;
  reject provider-specific and executable imports.

### Claim 2: More explicit runtime state rules improve AgentLogic without making it unusable

- Steelman: resumable sessions, active-state reminders, and bounded compaction reduce context loss.
- Attack: mandatory persistence of every runtime detail can create prompt bloat and false state.
- Fails if: the rules require injecting stale or irrelevant session data into every prompt.
- Mitigation: preserve only actionable state, attach provenance/freshness, use compact pointers,
  and revalidate state before relying on it.

### Claim 3: `deny > ask > allow` and segment analysis can be generalized safely

- Steelman: Grok's policy tests show explicit precedence and compound-command handling.
- Attack: shell grammars differ across platforms and tools; a simplistic parser can create false
  confidence or bypasses.
- Fails if: the agent treats incomplete parsing as safe allow, or applies Bash rules to non-Bash tools.
- Mitigation: scope rules by tool family, fail closed to ask/deny when parsing is incomplete, and
  require platform/runtime verification for security claims.

### Claim 4: V6.8.0 is the right release boundary

- Steelman: the integration spans multiple core modules and changes the default profile contract.
- Attack: a version promotion multiplies active references and bundle validation risk.
- Fails if: any active entry, manifest profile, generated output, or installer still points to
  the old active version.
- Mitigation: use `release-version.ps1`, validate every manifest output, rebuild all hosts, and
  run the maintainer check before installation.

## Architecture decision

Use a new additive V6.8.0 module and version file. Keep V6.7.2 immutable. Treat Grok Build as
an evidence source and comparative implementation reference, not as a runtime dependency.
