# Grok Build Complementary Integration Research Matrix

Status: Evidence-backed design input for the AgentLogic V6.8.0 integration.

## Evidence snapshot

- External repository: `https://github.com/xai-org/grok-build`
- Audited checkout: `../grok-build`
- Audited commit: `c68e39f60462f28d9be5e683d9cbe2c57b1a5027`
- Primary evidence: `README.md`, `crates/codegen/xai-grok-pager/docs/user-guide/`,
  `crates/codegen/xai-grok-agent/`, `crates/common/xai-grok-compaction/`,
  `crates/codegen/xai-grok-workspace/`, and hook/plugin sources.

## Comparison matrix

| Grok Build capability | Current AgentLogic coverage | Decision | Integration boundary |
|---|---|---|---|
| Root-to-CWD `AGENTS.md` and rules discovery | Conceptual stacking exists in Module 32, but discovery names, scope, and inspectability are not explicit | Integrate | Method-level rule-resolution contract; do not copy Grok filenames blindly when a project declares another entry |
| Global/project/subdirectory configuration precedence | Permission and context modules discuss layers, but no compiled precedence model | Integrate | Add source, priority, conflict, and audit fields; preserve system/developer safety precedence |
| Deny > ask > allow policy merge | Allow/ask/deny exists, but rule algebra and chained-command coverage are not explicit enough | Integrate and strengthen | Add compiled policy rules, segment-level command analysis, and fail-closed escalation for undecidable compound commands |
| Hooks and plugin trust split | Hook lifecycle exists; skill governance exists | Integrate with correction | Hooks, MCP, plugins, and executable scripts require explicit trust; hook failure cannot be treated as a security boundary |
| Skills with scope, precedence, disable/ignore, and inspection | Host-local skill governance exists, but project/user/bundled resolution is incomplete | Integrate | Add scope and provenance; keep skills subordinate to logic and audit untrusted imports |
| Subagents with role, capability mode, and worktree isolation | Agent types and multi-agent entry rules exist, but capability/isolation contracts are sparse | Integrate | Add explore/read-only, plan/read-only, implementation, and isolated-worktree patterns; cap nesting depth |
| Session resume, fork, rewind, checkpoints, and session IDs | Session continuity and context compaction are described, but recovery state is underspecified | Integrate | Add a session-state contract with durable IDs, fork lineage, checkpoint scope, and rollback evidence |
| Active-state preservation after compaction | Agentic loop mentions compaction and tool-result budgets; V6.5 Dream handles post-task memory | Integrate | Preserve active TODOs, background tasks, subagents, permissions, loaded rules, and pending user query after compaction |
| Full-replace compaction with bounded retry and input ladder | Compaction is a policy concept, not a concrete failure contract | Integrate | Add threshold, token budget, retry classification, context-overflow ladder, summary validation, and deterministic-failure suppression |
| Headless JSON/streaming output and stop reasons | Runtime modes and verification exist; machine-readable result contract is missing | Integrate | Define plain/JSON/streaming result envelopes, session ID, turn count, stop reason, incomplete-usage flag, and evidence status |
| Memory with workspace identity, hybrid search, staleness, flush/dream | Four-tier memory and Dream lifecycle exist | Integrate and retain superiority | Add source identity, freshness, provenance, and revalidation; do not let memory override verified project facts or safety rules |
| Background tasks and visible task state | Background consolidation exists, but active execution state is not formalized | Integrate | Add task lifecycle, cancellation, timeout, checkpoint, and post-compaction reminder requirements |
| Sandbox plus permission policy plus folder trust | Permissions and safety are strong conceptually | Integrate and retain superiority | Keep AgentLogic's mandatory pre-target/post-result checks and evidence matrix; Grok sandbox is an implementation reference only |
| Codebase indexing and LSP as optional accelerators | Tool evaluation rule exists | Integrate lightly | Treat indexing/LSP as optional evidence accelerators, never as proof without direct reads/runtime checks |
| Retries, timeouts, output limits, circuit breakers | Tool safety and result budgets exist, but no unified resilience contract | Integrate | Add bounded retry taxonomy, timeout ownership, output byte/token budgets, and circuit-breaker behavior |

## Explicit non-import decisions

1. Do not copy Grok's Rust implementation into AgentLogic. AgentLogic is a method layer,
   not an application runtime.
2. Do not treat project rules, skills, hooks, plugins, or MCP definitions from an
   unfamiliar checkout as trusted merely because they were discovered.
3. Do not adopt `--yolo`-style autonomy as a default. AgentLogic keeps explicit permission
   posture and pre-target/post-result checks.
4. Do not let private memory or stale session summaries override current source evidence,
   system/developer instructions, or project security constraints.
5. Do not replace SDD, Red-Team, SRA, self-refutation, or `modification_history` with a
   generic plan mode or a verifier subagent.

## Areas where AgentLogic remains stronger

- Mandatory startup and context-reset gate before implementation.
- Conditional SDD lifecycle with Red-Team and Converge gates.
- Evidence-to-claim verification matrix and weak-tool anti-pattern controls.
- SRA shipping packet and self-refute-first audit discipline.
- Cross-session `modification_history` synchronization.
- Explicit separation between method rules, project facts, reference material, and host-local skills.
- Versioned source files plus deterministic host bundle generation.
