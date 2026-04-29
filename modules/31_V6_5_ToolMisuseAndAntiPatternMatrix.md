# V6.5 Tool Misuse And Anti-Pattern Matrix Draft

## 1. Purpose

This draft module records common tool-usage mistakes that create false certainty, weak verification, or unsafe execution.

It exists to answer four questions:

- what the anti-pattern looks like
- why it is invalid
- what stronger path should replace it
- what status label should be used until the stronger path is completed

## 2. Core Rule

If the agent followed an anti-pattern below, the result must not be labeled as fully verified, fixed, safe, or complete.

## 3. Matrix

| Anti-pattern | What it looks like | Why it is invalid | Required correction | Safe interim label |
| --- | --- | --- | --- | --- |
| Search-hit closure | A grep/search hit is treated as proof that the implementation fact is settled | Search only identifies candidates; it does not prove the actual logic or path | Read the concrete file/function/config directly | likely location only |
| Static-read closure on runtime claims | Code/config looks correct, so the runtime claim is treated as verified | Expected behavior is not observed behavior | Run the relevant command/runtime/build path and inspect the result | inferred from static read |
| Build-success closure on visual claims | The build passes, so the UI fix is treated as complete | Build success does not prove visible behavior | Use screenshot or equivalent visual verification | needs visual confirmation |
| Visual-only closure on hidden logic | The screen looks right, so hidden internal behavior is assumed correct | A visible state may hide incorrect data flow or wrong transitions | Add source read, logs, runtime inspection, or state inspection | visually plausible only |
| Memory-based current-fact answer | The agent answers a current remote/release/settings question from memory | Current facts drift over time | Use authoritative external read-only verification | needs authoritative remote verification |
| Stale-local-note closure | Old markdown/task notes are treated as proof of current system state | Local notes may be outdated or project-specific | Re-read the current source/doc/remote fact directly | stale note not confirmed |
| Write-first diagnosis | The agent edits files before proving where the fault actually is | Mutation before diagnosis increases noise and drift | Search, read, and verify the failure path first | diagnosis incomplete |
| Broad-shell mutation without target confirmation | A side-effecting command is run before the directory/path/target is checked | The command may affect the wrong scope | Confirm working directory and exact target before execution | target not confirmed |
| Remote-change-first workflow | A remote setting/repo/release state is changed before local validation and target confirmation | It raises avoidable external risk and may change the wrong target | Validate locally first, confirm remote target second, then change and post-verify | remote change not yet justified |
| Permission-blind execution | A sensitive tool is executed without checking allow/ask/deny posture | The execution may violate the active safety boundary | Check permission mode and tool allowance before running | permission not confirmed |
| Planner-only factual closure | A plan/orchestration step is treated as proof of the underlying fact | Planning sequences work; it does not produce factual evidence | Use actual evidence tools for the factual layer | plan only, not verified |
| Single-weak-evidence closure on ambiguous behavior | One weak signal is treated as enough in an ambiguous case | Ambiguous behavior needs stronger or independent evidence | Add a second independent evidence path | ambiguous, needs second evidence path |

## 4. High-Frequency Failure Patterns

### 4.1 Fast but fake certainty

This happens when the agent reaches a conclusion with the fastest available tool instead of the strongest required tool.

Typical symptoms:
- strong wording after weak evidence
- no artifact, no direct read, no screenshot, no runtime output
- a conclusion that sounds settled but cannot be traced to a matching evidence path

### 4.2 Tool skipping after partial evidence

This happens when the agent starts with the right first tool but skips the required next one.

Examples:
- search was used, but read was skipped
- read was used, but runtime verification was skipped
- runtime verification was used, but visual verification was skipped for a UI claim

### 4.3 Correct tool, wrong question strength

This happens when the chosen tool is valid in general but too weak for the specific question being closed.

Examples:
- static file reads used to answer a runtime-execution question
- build output used to answer a visual-quality question
- screenshot used to answer a hidden internal-state question

## 5. Correction Recipes

### 5.1 Repository fact recipe

- search/list candidates
- targeted read
- if needed, follow the call/config chain
- only then state the implementation fact strongly

### 5.2 Runtime claim recipe

- read the relevant implementation/config
- run the command or runtime path
- inspect the result/log/artifact
- only then state the runtime claim strongly

### 5.3 UI claim recipe

- read the likely UI path if needed
- run/build the relevant target
- capture screenshot or equivalent visual proof
- only then state the visual claim strongly

### 5.4 Remote/current fact recipe

- identify the exact remote target
- query an authoritative live source
- answer with current-state wording tied to that source

## 6. Enforcement Labels

When an anti-pattern occurred and correction has not yet happened, the answer should prefer labels such as:

- unverified
- partially verified
- inferred from static read
- likely location only
- needs runtime confirmation
- needs visual confirmation
- needs authoritative remote verification
- blocked on required verification path
