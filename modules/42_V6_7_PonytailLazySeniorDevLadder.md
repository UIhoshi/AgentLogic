# V6.7.2 Ponytail Lazy Senior Developer's Ladder

Status: **Stable V6.7.2 Line (Mandatory implementation & refactoring protocol)**.

This module integrates the core philosophy and the **7-Rung Ladder** from the `ponytail` framework. It targets a major efficiency gap in AI agent coding: the tendency of agents to over-build, introduce unnecessary helper abstractions, install redundant packages, or rewrite code that already exists elsewhere in the codebase. By enforcing a "lazy but safe" posture, this module cuts code bloat, reduces token costs, and increases execution speed while maintaining absolute system safety.

---

## 1. The Core Philosophy: "Boring is Better than Clever"

"Lazy" means efficient and disciplined, not careless or negligent.
- The best code is the code that is never written.
- Delete over add. Reuse over rewrite.
- Boring, plain code that can be read easily at 3 AM is infinitely better than clever, customized abstractions.
- Never introduce speculative scaffolding or code "for later". Later can build for itself.

---

## 2. The 7-Rung Lazy Developer's Ladder

Before writing, modifying, or refactoring any line of code, the Agent **MUST** evaluate this ladder. Stop at the first rung that holds:

| Rung | Description | Operational Directive |
| :--- | :--- | :--- |
| **1. YAGNI (Need to Exist)** | Does this feature or abstraction need to exist at all? | If it is a speculative requirement or unrequested config, skip it. Explain in a single line to the user. |
| **2. Codebase Reuse** | Does a helper, utility, component, or type already live here? | Look before you write. Search files nearby. Re-implementing a utility that is a few directories over is the most common slop. |
| **3. Standard Library** | Does the language standard library cover this? | Reach for built-in library functions before writing custom parsing or logic wrappers. |
| **4. Native Platform** | Does the native platform provide a feature for this? | Prefer native platform elements (e.g., `<input type="date">` over a calendar library, native CSS scroll-behavior over JS scroll scripts, DB constraints over app-level validation). |
| **5. Existing Dependency** | Can an already-installed package solve it? | Reuse existing dependencies. Never add a new dependency for what a few lines of plain code or an existing library can do. |
| **6. One-Liner** | Can this entire change be implemented in a single line? | If yes, write one line. |
| **7. Minimum Viable Code** | If none of the above hold. | Write the absolute minimum amount of code that satisfies the specification. No unrequested abstractions, no interfaces with a single implementation, no factories for a single product. When taking a deliberate bounded shortcut (e.g., in-memory cache instead of Redis for `< 1k` items), leave a `// shortcut: <limit>, <when to upgrade>` comment so `ponytail-debt` can audit it. |

---

## 3. Bug-Fixing Rule: Root Cause vs. Symptom

AI agents often write quick symptom patches because they only read the path named in the bug ticket. This is prohibited.

When addressing a bug:
1. **Analyze caller hierarchy**: Before editing, grep every caller of the function you are about to touch.
2. **Fix at the root**: A single guard inside the shared function is a smaller, safer diff than a guard in every caller. Patching only the path the ticket names leaves sibling callers still broken.
3. **No shallow guards**: Do not patch around the bug at the outermost level. Fix it where all callers route through.

---

## 4. Strict Safety Boundaries: Lazy but Safe

The goal of the ladder is to eliminate code bloat, **not** to skip safety controls. The following surfaces are strictly excluded from YAGNI and are **never** on the chopping block:

- **Security & Authorization**: Input sanitization, CSRF tokens, database query parameterization, and endpoint claim checks (Module 41 §5) must be written thoroughly.
- **Data Loss Prevention**: Idempotency checks, database transactions, confirmation dialogs for destructive actions, and backup validation.
- **Accessibility (a11y)**: Proper ARIA labels, semantic HTML structure, keyboard navigation, and contrast compliance.
- **Error Handling**: Graceful fallback states, detailed error logging, and user-facing notifications.

"Lazy, not negligent." If a safety guard is missing, adding it is mandatory, even if it adds lines of code.

---

## 5. Integration with Spec-Driven Development (SDD)

This ladder is integrated as a blocking gate during **SDD Phase 6 (Implement Phase)**:

- **Pre-Task Check**: Before beginning any task from `.specify/tasks.md`, the Agent must state which rung of the Lazy Developer's Ladder is being used to address that task.
- **Checklist**:
  - [ ] Can we skip this task? (Rung 1)
  - [ ] Can we reuse code? (Rung 2)
  - [ ] Are we using stdlib/native? (Rungs 3 & 4)
  - [ ] Are we using existing dependencies? (Rung 5)
  - [ ] Is this the minimal working diff? (Rungs 6 & 7)

---

## 6. Integration with Taste Design & Verification

- **Aesthetics (Module 39)**: Simple code must not lead to visual slop. The use of native elements (Rung 4) must still be styled to look premium and aligned with the CSS design system.
- **Verification Matrix (Module 29)**: The evidence requirements for verification remain unchanged. A one-line implementation must still be validated with command execution or visual proof.
- **3-Tier Code Refinement Synergy (`code-simplifier` + `ast-grep`)**: Ponytail governs **Tier 1 (Pre-Implementation Subtraction)** before code is written. Once implementation or refactoring changes are written, the agent automatically transitions to **Tier 2 (`skills/engineering/code-simplifier/SKILL.md`)** via the `code-refinement` route to flatten nested conditionals into guard clauses, remove dead/redundant scaffolding, and apply structural AST rewrites (`ast-grep`) when 3+ call sites are modified, while **Tier 3 (`improve-codebase-architecture`)** remains available for macro module boundary deepening.
