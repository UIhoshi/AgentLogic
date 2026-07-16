# AgentLogic V6.8.0 Grok Build Complementary Integration Specification

## Status

Approved for implementation as a new versioned logic line after evidence review of
`xai-org/grok-build` at commit `c68e39f60462f28d9be5e683d9cbe2c57b1a5027`.

## Objective

Integrate the strongest reusable operational ideas from Grok Build into AgentLogic's
method layer while preserving the existing AgentLogic startup gate, task applicability
model, SDD/Red-Team/SRA lifecycle, evidence requirements, permission boundaries, and
cross-session error synchronization.

## User-visible outcomes

1. Project entry rules define how global, repository, subdirectory, compatibility, and
   task-local instructions are discovered, ordered, scoped, inspected, and revalidated.
2. Permission guidance uses a compiled `deny > ask > allow` policy model, analyzes compound
   commands at segment level, and escalates undecidable commands rather than over-allowing.
3. Hooks, plugins, MCP servers, skills, and agent definitions have explicit provenance and
   trust states; discovery never implies execution trust.
4. Session state has a durable preservation contract covering resume, fork, rewind/checkpoint,
   active TODOs, background tasks, subagents, pending user intent, loaded rules, and permission state.
5. Compaction has a concrete, bounded contract: threshold, token estimator, output budget,
   retry classification, timeout, context-overflow input ladder, summary validation, and
   deterministic-failure suppression.
6. Headless and automation workflows report machine-readable result envelopes with session
   identity, stop reason, turn count, usage completeness, and verification status.
7. Memory and Dream rules gain provenance and staleness controls without allowing stale memory
   to override current verified facts.
8. The default profile and all host bundles include the new integration module through the
   normal build pipeline.

## Non-goals

- Porting Rust crates or Grok's TUI/runtime into AgentLogic.
- Making AgentLogic depend on Grok, xAI, Rust, or Grok-specific CLI commands.
- Enabling autonomous `yolo` behavior by default.
- Replacing the existing SDD, SRA, verification, or `modification_history` rules.
- Importing executable hooks, plugins, or skills from the external checkout.

## Acceptance criteria

- A new version file records the external source URL, local comparison path, audited commit,
  integration date, retained strengths, and rejected behaviors.
- A new core-enhanced module defines the seven operational contracts in the objective.
- Active entry, package, profile, and install docs point to the new version without mutating
  historical V6.7.2 files.
- Generated bundles are rebuilt from source; `dist/` is never hand-edited.
- Package, logic-entry, maintainer, and host-install validation pass.
- The final diff contains no copied Rust implementation, unreviewed executable plugin/skill,
  machine-specific absolute path, or weakened mandatory gate.
