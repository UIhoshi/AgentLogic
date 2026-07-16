# V6.6 Spec-Driven Development (SDD) Integration

Status: **Stable V6.6 Line (Mandatory operational protocol)**.

This module defines the Spec-Driven Development (SDD) workflow powered by the integrated `spec-kit` layer. SDD is the mandatory baseline for non-trivial implementation work, while read-only audits, documentation-only changes, metadata-only changes, and trivial isolated fixes use the lighter path defined by the repository Task Applicability Gate.

---

## 1. Core SDD Mandate

To eliminate "vibe coding" (writing arbitrary code without specifications or plans), AgentLogic V6.6 enforces Spec-Driven Development as a default operational normal.

Feature work, refactors, multi-file behavior changes, new projects, and release-affecting changes **MUST** go through the structured SDD pipeline automatically. Specifications are treated as executable definitions of behavior and must be written down before production code is touched. The lighter task classes must still record intent and validation, but must not manufacture irrelevant architecture documents.

---

## 2. Mandatory SDD Lifecycle Phases

When starting a project or introducing a feature, refactor, multi-file behavior change, or release-affecting change, the Agent MUST execute the following phases sequentially:

1. **Constitution Phase**: Establish the project's governing principles, style rules, quality criteria, and performance guidelines.
   - *Requirement*: The Agent must check if `.specify/constitution.md` (or equivalent) exists. If not, it MUST create it first.
2. **Specify Phase**: Define user scenarios, requirements, and user stories in clear, natural language.
   - *Requirement*: The specifications must be written to `.specify/spec.md` (or `.specify/specs/` directory).
- *Domain Vocabulary*: If the task introduces domain terminology or crosses bounded contexts, check or establish `CONTEXT.md` and run the single-question Grilling session (see `modules/43_V6_7_MattPocockSkillsIntegration.md`) before proceeding.
- *UI/UX Prototyping Gate*: Before any formal UI implementation, generate a visual mockup using a text-to-image tool (via the image-generation skill), present it to the user, and wait for the user's review. This gate may be bypassed only when the user explicitly says not to use it. Do not treat content changes, accessibility fixes, responsive bug fixes, or small visual corrections as implicit exemptions unless the user explicitly opts out.
3. **Plan Phase**: Draft a technical implementation plan specifying architecture, tech stack, data schemas, and integration logic.
   - *Requirement*: The plan must be saved in `.specify/plan.md`.
   - *Architectural Decisions*: If the plan involves hard-to-reverse trade-offs, they must be documented in a numbered ADR under `docs/adr/` (see `modules/43_V6_7_MattPocockSkillsIntegration.md`).
4. **Red-Team Gate** *(mandatory)*: Attack the plan's load-bearing assumptions before committing to tasks.
   - *Requirement*: The Agent MUST identify the load-bearing claims in `.specify/plan.md` — the assumptions that, if false, would cause the plan to fail.
   - *Method*: For each load-bearing claim: (a) Steelman — state the strongest version of why it might be true. (b) Attack — attack that steelmanned version, not a strawman. (c) Write each failure mode as "Fails if ___." — concrete and falsifiable.
   - *Ranking*: Rank failure modes by `(impact if wrong) × (likelihood wrong) × (cheapness to test)`. The top items are what to address *before* entering the Tasks phase.
   - *Output*: Append a "Red-Team Results" section to `.specify/plan.md` with the ranked attack results. If any top-ranked failure mode lacks a mitigation or test, the plan MUST be revised before proceeding.
   - *Skip Condition*: The Red-Team Gate may be skipped ONLY for trivial bug fixes or documentation-only changes where no architectural assumptions exist.
5. **Tasks Phase**: Translate the plan into a checklist of granular, actionable tasks.
   - *Requirement*: The task list must be saved in `.specify/tasks.md`.
6. **Implement Phase**: Systematically execute the tasks in order, applying the relevant build, test, runtime, or visual validation after each behavior-affecting task. The Agent MUST apply the 7-Rung Lazy Developer's Ladder (see `modules/42_V6_7_PonytailLazySeniorDevLadder.md`) before writing or changing production code.
7. **Converge Phase**: Match the codebase state against the specs, plan, and tasks. Any discrepancy or remaining gap must be appended as new tasks to `.specify/tasks.md` until fully resolved.
8. **Ship Phase**: Perform the AI Shipping & Reviewability Audit (SRA) to document architecture, flows, permissions, variables, and tests, running static audits before merging. See `modules/41_V6_7_AIShippingAndReviewabilityAudit.md`.

---

## 3. Enforcement & Verification Rules

- **Pre-Implementation Gate**: Writing production code for a full-SDD task before the **Specify** and **Plan** documents are created under `.specify/` is strictly prohibited. Lighter task classes must still record scope and validation, but do not require irrelevant SDD artifacts.
- **Red-Team Gate**: Entering the Tasks phase without completing the Red-Team Gate (Phase 4) on the plan is prohibited, except when the skip condition applies (trivial bug fixes or documentation-only changes).
- **Zero Vibe-Coding**: Every single code change must trace back to a defined task in `.specify/tasks.md`.
- **Shipping Gate**: No feature may be merged without completing the **Ship Phase** SRA checklist and compiling a reviewer-ready shipping packet under `documentation/` (or `.specify/ship/`).
- **Command Fallbacks**: The slash commands (like `/speckit.specify`, `/speckit.plan`, etc.) provided by `spec-kit` are shortcuts. In normal Agentic loops, the Agent MUST execute these steps natively and automatically create the documents, without requiring manual trigger commands.

---

## 4. Location of Assets

- **Specify CLI Codebase**: `spec-kit/src/`
- **Extensions & Templates**: `spec-kit/extensions/`, `spec-kit/templates/`
- **Presets & Workflows**: `spec-kit/presets/`, `spec-kit/workflows/`
- **Specification Documentation**: `spec-kit/spec-driven.md`

