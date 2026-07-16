# AgentLogic V6.8.0 — Grok Build Complementary Operational Integration

Status: **Active in the V6.8.0 core-enhanced profile**.

This module translates useful, provider-neutral operational patterns observed in
[`xai-org/grok-build`](https://github.com/xai-org/grok-build) into AgentLogic
method rules. It is an integration of contracts and safeguards, not a copy of
the Grok Build runtime, Rust source, prompts, or provider-specific behavior.

## 1. Boundary and precedence

The host runtime remains responsible for process execution, token counting,
filesystem isolation, permission dialogs, persistence, and transport. AgentLogic
defines the decision contracts around those mechanisms.

The effective instruction order is:

1. system, developer, safety, and host permission constraints;
2. AgentLogic entry, lifecycle, verification, and shipping rules;
3. project rules and project facts discovered for the current workspace;
4. user task instructions;
5. reference material, skills, plugins, and memory, subject to provenance and
   trust checks.

No discovered project file, memory item, plugin, skill, hook, or MCP server may
weaken a higher-priority safety, permission, verification, or history-sync rule.
Discovery is not activation, and activation is not verification.

## 2. Instruction and project-rule discovery contract

At session start and after a working-directory change, build a deterministic
instruction map:

- identify the workspace root using repository metadata when available;
- discover supported global, managed, repository-root, nested-directory, and
  current-working-directory instruction files;
- record each file's absolute origin, repository-relative path when applicable,
  scope, load order, digest or modification marker, and estimated token cost;
- apply broader rules before narrower rules, with a documented conflict result;
- expose the map through an inspectable report before relying on it for a
  high-impact change;
- re-run discovery after checkout, branch, worktree, or CWD changes.

The project may declare its supported instruction filenames. If it does not,
use the host's documented set and do not silently assume that an unfamiliar
filename is authoritative. Instruction files are treated as text policy, not as
permission to execute commands or install extensions.

## 3. Session lineage and resumability

Every non-trivial execution should have a session identity and, when resumed,
lineage metadata:

- `session_id`, parent or forked session, workspace identity, branch/worktree,
  and CWD;
- current phase, active plan, completed tasks, unresolved risks, and pending
  user decisions;
- permission decisions, pending side effects, running background tasks, and
  child-agent identifiers;
- checkpoint, resume, fork, rewind, and compaction events with timestamps.

Resume continues the same task only when workspace identity and instruction
provenance are still valid. Fork creates a new lineage and must not silently
share mutable side effects. Rewind restores a verified checkpoint, not merely a
chat transcript. Session metadata supports recovery; it never replaces fresh
reads of current files, permissions, or remote state.

## 4. Active-state-preserving compaction

Compaction is a controlled state transition, not a generic summary operation.
The host should provide a token estimator and a bounded input ladder:

1. verbatim history when it fits;
2. fitted history with low-value tool output reduced;
3. lossy history with a structured summary and explicit reminders;
4. a safe failure that requests a smaller scope or new session.

The default trigger may be around 85% of the usable context budget, but the
host must tune it to the model and reserve space for the next tool round. Each
attempt has a timeout, bounded retries, and a classified outcome (transient,
deterministic, or context-overflow). Compaction must preserve or explicitly
reconstruct:

- the active logic entry and applicable project-rule map;
- the latest user request and current acceptance criteria;
- the structured plan, phase, TODOs, completed work, and unresolved blockers;
- running background tasks and subagents, including poll/cancel handles;
- permission mode, explicit denies, pending approvals, and uncommitted
  side-effect warnings;
- relevant file paths, test failures, verification gaps, and the last known
  repository state.

Only actionable state is retained in the reminder. Completed, cancelled, stale,
or unverifiable items are marked as such rather than presented as active. After
compaction, perform a post-transition integrity check and revalidate facts that
may have changed.

## 5. Policy compilation and command safety

Permission decisions are compiled per tool family and per executable action,
not only per top-level request. Merge rules from all applicable scopes using:

`deny > ask > allow`.

For shell-like tools, analyze the whole command and each chained segment,
redirection, substitution, pipeline, script block, and decoded command when
possible. If intent or target is undecidable, escalate to `ask` or `deny`; do
not treat a broad allow pattern as proof of safety. A pre-tool hook may add a
deny or ask, but a hook is not a security boundary: hook failure, timeout, or
absence must not bypass the host sandbox or permission engine.

After permission resolution, record the effective rule, target, allowance, and
post-execution result. For path-sensitive or externally visible actions,
confirm the resolved target before execution and inspect the result afterward.
This extends `modules/05_PermissionsAndSafety.md` without weakening its
allow/ask/deny model.

## 6. Extensions, skills, plugins, hooks, and MCP trust

Use a four-state extension record:

- discovered: source and metadata found;
- enabled: selected by configuration;
- trusted: the user or repository policy explicitly authorizes activation;
- verified: provenance, contents, permissions, and behavior passed the relevant
  audit.

Untrusted executable hooks, MCP servers, LSP servers, plugin commands, install
scripts, and generated code remain inactive. Record source, scope, version or
commit, capabilities, and trust decision. Run the applicable skill-security
audit before installing or trusting an unfamiliar external skill or plugin.
Project-local extensions do not outrank AgentLogic or host security policy.

## 7. Subagent contract

Every child agent receives an explicit contract:

- role: `explore`, `plan`, `implement`, `review`, or `verify`;
- capability: `read-only`, `read-write`, `execute`, or `all`;
- isolation: shared workspace, isolated worktree, or another host-enforced
  boundary;
- allowed tools, forbidden tools, input scope, output schema, timeout, and
  cancellation handle;
- parent session, task identifier, and whether background execution is allowed.

Default to read-only exploration and planning. Default to isolated worktrees for
parallel write work. Keep nesting bounded (normally one child level) unless a
new risk review explicitly authorizes more. A tool is not callable merely
because it is visible in a child prompt: `visible == callable` must be checked
against the child capability contract and current permission result.

## 8. Headless and automation result contract

Headless execution must expose a stable envelope containing, where supported,
the session ID, request ID, stop reason, turn count, model/usage accounting,
tool results, errors, and compaction or background-task events. Plain output is
for humans; JSON or streaming JSON is for automation. Structured output proves
transport completeness, not implementation correctness. Correctness still
requires the applicable verification matrix, build/runtime checks, visual
evidence, or external confirmation.

Headless defaults must remain conservative. A yolo-like mode is an explicit
opt-in, must retain explicit denies and host sandboxing, and must be reported in
the execution record.

## 9. Memory and revalidation

Memory may be partitioned into global, workspace, and session scopes. Workspace
identity should use a stable repository origin when available and fall back to a
normalized path. Each memory item records source, scope, timestamp, confidence,
and freshness/staleness state.

Memory is a retrieval aid, not current fact authority. Before implementation,
re-read current repository files and remote sources for claims that can change.
When memory conflicts with current evidence, current evidence wins and the
conflict may be logged as a learning. Dream/flush/consolidation processes may
extract durable patterns, but must not silently promote unverified assumptions
into project rules.

## 10. Resilient execution and bounded resource use

For model calls, tool calls, background jobs, and compaction, define the owner of
each timeout and cancellation path. Use bounded retries only for classified
transient failures; do not retry permission denials, deterministic validation
errors, or unsafe operations. Enforce output budgets and preserve truncation
metadata. Circuit-break repeated failures and surface a recoverable state.

Background work must expose status, progress or last heartbeat, result/error,
workspace impact, and poll/cancel controls. A background task that changes
external state requires the same pre-target and post-result confirmation as a
foreground action.

## 11. Optional accelerators are not proof

Indexes, LSPs, fast search, browser automation, cached project maps, and
parallel exploration can improve speed. They are accelerators only. Static
search does not prove runtime behavior; a build does not prove visual layout; a
cached or memory result does not prove a current remote fact. Use the strongest
matching verification tool and downgrade conclusions when that evidence is
missing.

## 12. Explicit non-imports

This integration does not import:

- Grok Build's Rust crates, xAI runtime, provider-specific prompts, or binaries;
- automatic trust of discovered project rules, plugins, skills, hooks, or MCP;
- a default yolo/auto-approve permission posture;
- memory as a substitute for current facts or AgentLogic history synchronization;
- a plan/verifier skill as a replacement for SDD, Red-Team, SRA, self-refute,
  or the mandatory verification matrix.

## 13. Operational checklist

Before implementation, record: instruction sources and precedence; workspace and
session lineage; task role/capability/isolation; permission mode and effective
rules; extension provenance and trust; compaction reserve and active-state
reminders; background-task handles; verification evidence still required.

After implementation or compaction, record: changed files; post-result state;
remaining TODOs and risks; current rule/permission map; test/build/runtime or
visual evidence; and any stale memory or external-fact conflicts.

## 14. Evidence and comparison source

- Repository: `https://github.com/xai-org/grok-build`
- Audited local checkout: `../grok-build`
- Audited commit: `c68e39f60462f28d9be5e683d9cbe2c57b1a5027`
- Comparison artifacts: `.specify/grok-build-integration/research-matrix.md`,
  `spec.md`, `plan.md`, and `tasks.md`

