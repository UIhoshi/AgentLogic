# V6.5 Draft Module: Runtime Mode Taxonomy

Status: draft only.
This module extends `AgentLogic_V6` by making runtime modes explicit in large agentic systems.

---

## 1. Why this module exists

Many agentic repositories do not have one execution surface.
They have several runtime modes with different constraints, risks, and output expectations.

If the agent treats all of them as one generic "CLI", it will make wrong assumptions about:

- permissions
- tool availability
- output formatting
- validation strategy
- where results are supposed to go

---

## 2. Runtime mode categories

By default, V6.5 should distinguish at least the following modes:

### 2.1 Interactive terminal / REPL mode

Typical traits:

- user is present live
- interactive prompts are allowed
- rich terminal UI may exist
- permission `ask` flows are practical

Default focus:

- conversational flow
- incremental reasoning
- interactive approvals
- high-visibility feedback

### 2.2 Headless / pipe / structured-output mode

Typical traits:

- no human is watching each step live
- output may be consumed by another program
- extra prose may break the caller
- permission prompts may be impossible or undesirable

Default focus:

- deterministic output
- machine-readable response shape
- explicit failure signaling
- reduced interactivity assumptions

### 2.3 SDK / programmatic mode

Typical traits:

- the system is embedded as a library or service dependency
- host code expects stable contracts
- response objects matter more than terminal presentation

Default focus:

- API contracts
- event structure
- backpressure / cancellation behavior
- error surface stability

### 2.4 Server / daemon / background-worker mode

Typical traits:

- long-running lifecycle
- process supervision matters
- restart and cleanup behavior matter
- background state persistence matters

Default focus:

- startup / shutdown behavior
- resource cleanup
- worker isolation
- resilience and diagnostics

### 2.5 Bridge / remote-control / protocol mode

Typical traits:

- one process mediates another process or client
- permissions may cross boundaries
- transport and identity matter
- event propagation matters

Default focus:

- request origin
- trust boundary
- transport behavior
- permission propagation

### 2.6 Packaging / installer / updater mode

Typical traits:

- build artifacts matter more than live interaction
- path layout changes after packaging
- installation leftovers and upgrades matter

Default focus:

- artifact correctness
- path verification
- install/uninstall behavior
- update safety

---

## 3. Mandatory runtime-mode questions

Before implementation or review, the agent should answer:

1. Which runtime mode is active right now?
2. Is this repository multi-mode or single-mode?
3. Which files are the true entrypoints for each mode?
4. Do permissions differ by mode?
5. Do output requirements differ by mode?
6. Does validation differ by mode?

If these questions are not answered, the agent should not flatten mode-specific behavior into generic rules.

---

## 4. Documentation requirement

For multi-mode systems, the project fact map should record at minimum:

- mode name
- real entrypoint file
- expected user presence
- output target
- permission behavior
- validation method

---

## 5. Important boundary

This module does **not** say every project must support all modes.
It says the agent must not assume one mode when the project clearly supports many.
