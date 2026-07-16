# V6.5 Stable Module: Background Consolidation and Idle Lifecycle

Status: stable V6.5 module.
This module defines the "Dream Phase" – how an agent should act when a primary task is complete or during idle time.

---

## 1. Why this module exists

In most systems, the agent stops immediately after "Validate". This leaves:
- messy temporary files
- fragmented memory entries
- un-synced documentation
- un-shared structural lessons

V6.5 introduces the **Idle Lifecycle** to convert session noise into durable project knowledge.

---

## 2. The Post-Task "Dream" Lifecycle

Once the user's primary directive is marked `Verified`, the agent should perform these steps (ideally in the background if supported, or as a final cleanup turn):

### 2.1 Artifact Cleanup
- Delete temporary log files, test snapshots, and build artifacts created during implementation.
- Revert any non-essential environment changes (e.g., temporary `export` variables).

### 2.2 Memory Extraction
- Review the session history.
- Identify new structural facts (e.g., "The auth service requires X header").
- Identify new user preferences (e.g., "User prefers 4-space tabs").
- Write these to the appropriate tier (Project Fact Map, MEMORY.md, or Global Memory).

### 2.3 Documentation Sync
- Check if the code changes invalidate existing `GEMINI.md` or `README.md` descriptions.
- Propose or apply targeted updates to keep documentation in sync with reality.

### 2.4 Structural Consolidation
- If multiple small edits were made, look for a larger pattern (e.g., "We are consistently adding X to every route").
- Propose a refactor or a new logic rule to automate this pattern in the future.

---

## 3. Memory Triage (The 4-Tier Model)

When extracting memories, use the `claude-code` taxonomy:

1.  **User**: Personal preferences, coding style, local machine quirks. (Save to Global or Private Local Memory).
2.  **Feedback**: Methodological corrections or "lessons learned" from this specific session (e.g., "Don't use tool X for task Y").
3.  **Project**: Hard facts about the codebase, architecture, and logic. (Save to `GEMINI.md` or Project Fact Map).
4.  **Reference**: Pointers to external docs, APIs, or sibling services.

---

## 4. The "Idle" Prompt

If the agent is waiting for user input for a long period, it may (if the host allows) perform "Internal Checkup":
- Verify directory integrity.
- Re-index symbols if many files changed.
- Audit `MEMORY.md` for stale entries (> 90 days).

---

## 5. Enforcement

A task is not truly `Finalized` until the **Consolidation Phase** is complete.
The agent should be able to answer: "What did we learn in this session that should be saved forever?"
## V6.8.0 Complementary State Freshness

Background consolidation may extract durable patterns, but memory remains a retrieval aid rather than current-fact authority. Store provenance, scope, timestamp, confidence, and freshness state with durable items. Running background tasks and subagents must expose status, heartbeat, result/error, and cancellation handles; after compaction or resume, revalidate any state that may have changed. See `modules/44_V6_8_GrokBuildOperationalIntegration.md`.