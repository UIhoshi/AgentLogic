# V6.5 Stable Module: Context Assembly and Instruction Stacking

Status: stable V6.5 module.
This module defines how to layer multiple instruction sources into a single coherent context without bloating or contradiction.

---

## 1. Why this module exists

Advanced agentic systems pull instructions from many sources:
- global personal preferences
- workspace-wide mandates
- subdirectory-specific rules
- project-managed instruction files (CLAUDE.md / GEMINI.md)
- automated memory entries (MEMORY.md)

If these are not stacked in a predictable order, the agent may:
- follow a global rule when a project-specific override exists
- ignore a subdirectory rule in favor of a root rule
- get confused by conflicting instructions

---

## 2. The Instruction Stack (Low to High Priority)

Instructions should be layered such that **higher-numbered sources override lower-numbered ones**:

1.  **Model/Provider Baseline**: The general knowledge and system prompt of the underlying LLM.
2.  **Global Personal Memory**: Cross-project user preferences (e.g., "I always prefer TypeScript").
3.  **Managed/Enterprise Policy**: Organizational rules enforced across all machines.
4.  **Project Root Instructions**: Mandates for the entire repository (e.g., `GEMINI.md` at root).
5.  **Subdirectory Instructions**: Overrides for specific modules (e.g., `src/api/GEMINI.md`).
6.  **Private Project Memory**: Local, machine-specific notes (e.g., `MEMORY.md`).
7.  **Dynamic Task Context**: Immediate instructions for the current coding round.

---

## 3. Stacking Rules

### 3.1 Specificity Wins
A rule at the `src/` level always overrides a rule at the project root level for files within `src/`.

### 3.2 Private Beats Public
`MEMORY.md` (private notes) overrides `GEMINI.md` (public repo instructions) for the current user's execution, as it often contains local environment-specific fixes.

### 3.3 Task Context is Supreme
If the user says "ignore the lint rule for this one file" in the current session, that instruction wins over all permanent rules for that specific task.

---

## 4. Anti-Pattern: The Bloated Prompt

Do **not** include the full text of every instruction file if they overlap significantly.
- Prefer **targeted inclusion**: only pull in the instructions relevant to the current directory and task.
- Use **Instruction Pointers**: if a file is too large, the agent should read its summary/index first and only deep-read relevant sections.

---

## 5. Instruction Collision Resolution

When two rules conflict:
1.  Identify the source tier for each rule.
2.  Apply the higher-tier rule.
3.  Log the collision in the current session context to explain why the lower-tier rule was ignored.

---

## 6. Implementation for V6.5

Agents should explicitly state their "Active Instruction Profile" when switching between subdirectories with different `GEMINI.md` files.
