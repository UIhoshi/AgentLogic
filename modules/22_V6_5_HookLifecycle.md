# V6.5 Stable Module: Agent Loop Hook Lifecycle

Status: stable V6.5 module.

---

## 1. Why this module exists

Large agentic systems usually become extensible through hook points long before they become cleanly modular.
If the hooks are undocumented, future maintainers cannot tell where safe extension actually belongs.

---

## 2. Default lifecycle map

V6.5 should encourage recording these hook stages when they exist:

1. session start
2. pre-query context assembly
3. query dispatch
4. stream/event normalization
5. pre-tool-use
6. permission decision
7. tool execution
8. post-tool-use
9. result budgeting / storage / compaction
10. post-compact
11. user-visible output emission
12. session end / abort / recovery

---

## 3. Why this matters

This model clarifies:

- where side effects happen
- where permission checks belong
- where notifications belong
- where telemetry belongs
- where recovery or cancellation belongs

Without this map, repositories often grow hidden coupling between query logic, tool logic, UI logic, and persistence.

---

## 4. Documentation rule

When a project has hook-based extension or lifecycle interception, the logic package should record:

- hook name or stage
- trigger condition
- input context
- side effects allowed
- output/result path
- whether failure at this stage is recoverable
