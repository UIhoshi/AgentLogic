# V6.6 Spec-Driven Development (SDD) Integration

Status: **Stable V6.6 Line (Mandatory operational protocol)**.

This module defines the Spec-Driven Development (SDD) workflow powered by the integrated `spec-kit` layer. Under V6.6, SDD is promoted from an optional command-line toolkit to a **mandatory baseline development protocol** that must govern all codebase tasks.

---

## 1. Core SDD Mandate

To eliminate "vibe coding" (writing arbitrary code without specifications or plans), AgentLogic V6.6 enforces Spec-Driven Development as a default operational normal. 

All development tasks, new projects, and feature requests **MUST** go through the structured SDD pipeline automatically. Specifications are treated as executable definitions of behavior and must be written down before code is touched.

---

## 2. Mandatory SDD Lifecycle Phases

When starting a project or introducing a new feature, the Agent MUST execute the following phases sequentially:

1. **Constitution Phase**: Establish the project's governing principles, style rules, quality criteria, and performance guidelines.
   - *Requirement*: The Agent must check if `.specify/constitution.md` (or equivalent) exists. If not, it MUST create it first.
2. **Specify Phase**: Define user scenarios, requirements, and user stories in clear, natural language.
   - *Requirement*: The specifications must be written to `.specify/spec.md` (or `.specify/specs/` directory).
3. **Plan Phase**: Draft a technical implementation plan specifying architecture, tech stack, data schemas, and integration logic.
   - *Requirement*: The plan must be saved in `.specify/plan.md`.
4. **Tasks Phase**: Translate the plan into a checklist of granular, actionable tasks.
   - *Requirement*: The task list must be saved in `.specify/tasks.md`.
5. **Implement Phase**: Systematically execute the tasks in order, running build and test validation after each task.
6. **Converge Phase**: Match the codebase state against the specs, plan, and tasks. Any discrepancy or remaining gap must be appended as new tasks to `.specify/tasks.md` until fully resolved.

---

## 3. Enforcement & Verification Rules

- **Pre-Implementation Gate**: Writing production code before the **Specify** and **Plan** documents are created under `.specify/` is strictly prohibited.
- **Zero Vibe-Coding**: Every single code change must trace back to a defined task in `.specify/tasks.md`.
- **Command Fallbacks**: The slash commands (like `/speckit.specify`, `/speckit.plan`, etc.) provided by `spec-kit` are shortcuts. In normal Agentic loops, the Agent MUST execute these steps natively and automatically create the documents, without requiring manual trigger commands.

---

## 4. Location of Assets

- **Specify CLI Codebase**: `spec-kit/src/`
- **Extensions & Templates**: `spec-kit/extensions/`, `spec-kit/templates/`
- **Presets & Workflows**: `spec-kit/presets/`, `spec-kit/workflows/`
- **Specification Documentation**: `spec-kit/spec-driven.md`

