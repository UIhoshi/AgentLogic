# Project Fact Map Template

Status: active project-fact template.
This template supports the V6.8.3 project-native knowledge-sync contract. It belongs in the
target project as `PROJECT_MAP.md`, travels with project code, and contains no private agent
memory or machine-specific data.

`PROJECT_MAP.md` is the concise L1-L4 architecture map. Keep symbol-level ownership, state keys,
and interface/event navigation in the mandatory companion `CODE_MAP.md`.

---

## 1. Project Identity & Freshness
- **Project Name**:
- **Repository / Branch**:
- **Remote freshness check**: `git fetch --prune` [Verified/Offline/Not configured]
- **Working-tree status**:
- **Installed AgentLogic entry**:

## 2. The Project L1-L4 Map

### L1 — Entry & Surface
- **Entrypoints**:
- **User/API/CLI surfaces**:
- **Primary documentation**:

### L2 — Flow & Lifecycle
- **Core flows**:
- **State / task lifecycle**:
- **Key module boundaries**:

### L3 — Control & Verification
- **Services, permissions, and trust boundaries**:
- **Validation commands**:
- **Known constraints / architectural debt**:

### L4 — Base & Dependencies
- **Data stores / providers**:
- **Foundational tools and dependencies**:
- **External systems**:

## 3. Unconfirmed Points
- [ ] Point 1
- [ ] Point 2

## 4. Update Rules
- Update this file in the same commit as a structural or validation-boundary change.
- Record material errors in `.learnings/ERRORS.md`, not in this map.
- Do not include secrets, personal paths, private prompts, raw logs, or generated graph output.
- Use current source and matching verification evidence to confirm facts; this map is not proof by itself.
