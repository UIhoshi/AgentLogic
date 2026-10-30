---
name: code-simplifier
description: Autonomous post-implementation code refinement, AST-aware structural refactoring, and 80/20 code-smell cleanup without altering behavior. Triggered automatically after feature/refactor implementation or when simplifying, cleaning up, or refactoring code.
---

# Code Simplifier & AST-Aware Refactoring (`code-simplifier`)

 This skill refines and simplifies newly written or modified code for clarity, consistency, and maintainability **without changing external behavior**. It synthesizes patterns from Anthropic's official `code-simplifier` (`anthropics/claude-plugins-official`), `ast-grep` structural refactoring (`ast-grep/ast-grep`), and `obra/superpowers` Red-Green-Refactor discipline, complementing `ponytail` (pre-implementation YAGNI subtraction) and `improve-codebase-architecture` (macro module deepening).

## Automatic Trigger Contract (Encounter -> Auto-Use)

Do NOT wait for the user to type `/code-simplifier` or name this skill. Activate this workflow automatically whenever:

1. **Post-Implementation Polish**: You have just implemented a `feature`, `major_feature`, or `refactor` and the initial behavior/tests pass, before claiming final completion or entering `code-review`.
2. **Refactoring / Cleanup Request**: The user asks to improve, clean up, polish, deduplicate, simplify, or refactor existing code.
3. **Multi-Site Structural Change**: A rename, API migration, or pattern rewrite spans `>= 3` call sites or multiple files.

---

## The 4-Phase Refinement Loop

### Phase 1: Green Baseline Lock (Pre-Condition)

- Never simplify or refactor against a broken baseline.
- Verify that the relevant test, typecheck, or build command passes **before** structural refinement begins.
- Read `CONTEXT.md` (if present), `CODE_MAP.md`, and local conventions so naming and module boundaries match the repository's established standards.

### Phase 2: 80/20 Smell & AI-Slop Triage

Scan **only the recently modified hunks or explicitly targeted files** (never perform unrequested repo-wide formatting churn). Rank and target the highest-leverage improvements:

| Smell / Slop Category | What to Spot | Required Refinement |
| :--- | :--- | :--- |
| **1. Deep Nesting & Arrow Code** | `if`/`else`/`try` blocks nested `> 3` levels deep | Invert conditions and use **early returns / guard clauses** to flatten control flow. |
| **2. Dense / Nested Ternaries** | Nested ternary expressions (`a ? (b ? c : d) : e`) or long inline boolean chains | Replace with clear `if`/`else` statements, `switch`/`match` blocks, or named lookup maps. |
| **3. Redundant AI Defensive Slop** | Speculative `try/catch` that swallows errors, duplicate null checks already guaranteed by caller types, single-use wrapper functions, or pass-through middlemen | Delete redundant wrappers; keep validation strictly at real trust boundaries (per `ponytail` Rung 1 & 7). |
| **4. Duplicated Logic Shapes** | Identical 5+ line transformation or validation blocks repeated across functions in the diff | Extract a single shared helper in the existing module (reuse before inventing new files). |
| **5. Mysterious or Drifting Names** | Generic identifiers (`data`, `res`, `temp`, `handleThing`, `processData2`) or terms that drift from `CONTEXT.md` | Rename to explicit domain terms that state what the value holds or what the function returns. |
| **6. Data Clumps & Long Parameter Lists** | The same 3+ parameters passed together across multiple functions | Group into an existing domain struct/type or options object when it clarifies the seam. |

### Phase 3: AST-First Structural Execution

When applying the refinements identified in Phase 2:

1. **Prefer AST-Aware Rewrites for Multi-Site Patterns (`>= 3` sites)**:
   - Check whether `ast-grep` (`sg`) is available on the host (`Get-Command sg -ErrorAction SilentlyContinue` or `ast-grep`).
   - When `sg` is available and a structural pattern is being rewritten across multiple locations, use `sg run --pattern '<pattern>' --rewrite '<rewrite>'` (with metavariables like `$FUNC`, `$$$ARGS`) instead of fragile regex or repetitive manual edits.
2. **Atomic Bounded Edits**:
   - When `ast-grep` is unavailable or the refinement is local to 1–2 hunks, apply bounded file edits one cohesive transformation at a time.
   - **Preserve Documentation Integrity**: Never delete unrelated comments, docstrings, or mandatory logic-gate headers.
   - **Balance Clarity over Brevity**: Do not compress readable 4-line logic into an unreadable 1-line clever expression; explicit and boring beats dense and clever.

### Phase 4: Zero-Behavior-Change Verification & Closure

1. Re-run the exact test, build, or runtime verification command from Phase 1 immediately after refinement.
2. If any test or check breaks, **revert the offending simplification hunk immediately** rather than piling on workarounds.
3. Update `CODE_MAP.md` if any public symbol, signature, or key flow path changed during the refactor.
4. Record closure evidence (`refinement_or_smell_check` and `behavior_preserved_verification`).
