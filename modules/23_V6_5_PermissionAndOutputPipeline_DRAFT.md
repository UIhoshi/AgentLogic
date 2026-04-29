# V6.5 Draft Module: Permission And Output Pipeline

Status: draft only.

---

## 1. Why this module exists

In advanced agentic systems, permission behavior and output behavior are not side notes.
They define what the system is allowed to do and where the result is allowed to appear.

---

## 2. Permission pipeline model

V6.5 should recommend modeling permissions as a pipeline:

1. request origin
2. requested action or tool
3. classification of risk
4. rule or policy match
5. allow / ask / deny decision
6. fallback or alternate path
7. denial tracking or adaptive behavior
8. propagation to other runtime modes or bridges

This model is stronger than simply listing permission files.

---

## 3. Output pipeline model

V6.5 should also recommend output-target mapping:

- terminal output
- machine-readable output
- remote protocol output
- silent/background state update
- notification output
- persistent artifact output

For each target, the project should state:

- who consumes it
- whether formatting is strict or human-facing
- whether extra prose is allowed
- whether failures must be serialized explicitly

---

## 4. Integration rule

When the same action can be triggered from multiple modes, the agent should ask:

- does permission behavior stay the same across modes?
- does output behavior stay the same across modes?
- if not, where is the translation layer?

If this is not recorded, cross-mode bugs become likely.
