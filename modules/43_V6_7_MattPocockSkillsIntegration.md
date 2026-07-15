# V6.7.0 Matt Pocock Skills Integration

Status: **Stable V6.7.0 Line (Mandatory alignment & documentation protocol)**.

This module integrates the core engineering principles from the `mattpocock/skills` framework. It addresses two major communication and token-efficiency gaps in AI agent coding: (1) requirement misalignment due to passive task hand-off, and (2) excessive verbosity due to the lack of a shared, domain-specific vocabulary. By enforcing the **Grilling Process**, **Ubiquitous Glossary (`CONTEXT.md`)**, and **Architecture Decision Records (ADRs)**, this module aligns developer intent with implementation and drastically optimizes the token economy.

---

## 1. The Grilling Process Protocol

To eliminate misalignment between the user and the Agent, major feature plans **MUST** undergo a grilling session during **SDD Phase 2 (Specify Phase)**:

1. **Relentless Probing**: The Agent must walk down the plan's design tree, branch by branch, stress-testing decisions and resolving dependencies before writing code.
2. **Single-Question Flow**: The Agent **MUST** ask questions one at a time. Dumping a bulk list of questions is strictly prohibited.
3. **Recommended Answers**: For every question asked, the Agent **MUST** provide a clear, reasoned "Recommended Answer" (e.g., *"How should we handle caching here? Recommended: Redis with a 5-minute TTL because..."*). This allows the user to simply approve the recommendation or quickly course-correct.
4. **Codebase First**: The Agent must explore the codebase automatically to answer structural questions rather than asking the user for facts that can be statically verified.
5. **Human-Readable Proposal Gate**: At the conclusion of the grilling session, the Agent **MUST** ask the user whether they require a human-readable Project Proposal / Scope Statement (in Word, PDF, or Markdown layout). If requested, the Agent must generate a non-technical summary focused on business scope, milestone timelines, and visual expectations, hiding API schemas and engineering configurations.

---

## 2. Ubiquitous Vocabulary: `CONTEXT.md`

To reduce conversation verbosity and ensure consistent code naming, the project **MUST** establish a shared glossary.

### 2.1 Glossary Structure
- **Single-Context Repository**: A single file named `CONTEXT.md` (or `GLOSSARY.md`) at the repository root.
- **Multi-Context Repository**: A `CONTEXT-MAP.md` at the root mapping modules, with sub-contexts containing their own local `CONTEXT.md` (e.g., `src/<context>/CONTEXT.md`).

### 2.2 Content Constraints
- **Pure Jargon**: The glossary must contain ONLY domain terms, definitions, and acronym mappings.
- **No Implementation or Specs**: It must not contain scratchpad notes, code snippets, ticket descriptions, or temporary tasks.
- **Lazy Maintenance**: When a new terminology or decision crystallizes during a grilling session, the Agent must lazily update `CONTEXT.md` to define the term.

### 2.3 Variable and Naming Alignment
- Every class, variable, function, database table, and filename **MUST** use the exact terminology defined in `CONTEXT.md`.
- Using multiple names for the same domain concept (e.g., using `User`, `Account`, and `Profile` interchangeably) is prohibited.

---

## 3. Architecture Decision Records (ADRs)

For hard-to-reverse design decisions, surprising trade-offs, or choices involving complex tradeoffs (e.g., choosing a specific state library, introducing database migrations, or changing trust boundaries), the Agent must compile an ADR.

### 3.1 Storage and Format
- ADRs live in `docs/adr/` (or `src/<context>/docs/adr/` in multi-context layouts).
- Files must be sequentially numbered (e.g., `docs/adr/0001-slug.md`, `docs/adr/0002-slug.md`).
- Each ADR must contain:
  - **Title**: Brief name of the decision.
  - **Status**: Proposed, Accepted, Rejected, or Superseded.
  - **Context**: The background, constraints, and problem driving the decision.
  - **Decision**: The chosen solution.
  - **Consequences**: The trade-offs, negative impacts, and subsequent requirements.

### 3.2 Anti-Litigation Rule
Once an ADR is set to `Accepted`, the Agent **MUST** treat it as an immutable architectural rule for the current branch. Re-litigating previously accepted decisions during subsequent tasks is prohibited unless the user explicitly requests an architectural review.

---

## 4. Integration with Spec-Driven Development (SDD)

- **Specify Phase (Phase 2)**: The Agent must check if `CONTEXT.md` exists. If the task introduces new concepts, the Agent must initiate a single-question grilling session (§1) and append new terms to `CONTEXT.md`.
- **Plan Phase (Phase 3)**: If the plan introduces major trade-offs, the Agent must document them in a new ADR draft under `docs/adr/` before moving past the Plan phase.
