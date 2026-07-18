# Specification: Mandatory Textual Project Code Map

## Status

Approved by the user for the active V6.8.2 logic line.

## Problem

`PROJECT_MAP.md` is intentionally concise and records L1-L4 project facts, but it does not
provide enough symbol-level navigation for a new agent or a new window to locate the owning
file, function, state key, or event surface quickly. Optional Graphify output is useful for
visual exploration, but it should not become a mandatory dependency or generated artifact.

## Goals

1. Require a tracked root `CODE_MAP.md` for every business project using the full AgentLogic
   workflow.
2. Define a concise, text-first map containing entrypoints, module responsibilities, key
   functions/classes, state and storage keys, event/API surfaces, and validation commands.
3. Require `CODE_MAP.md` to be created or refreshed before non-trivial implementation work and
   updated in the same commit as affected structural or key-flow changes.
4. Preserve Graphify and other visual maps as user-approved, optional review accelerators.
5. Provide a reusable `templates/CODE_MAP.md` and package validation coverage.

## Non-goals

- Requiring Graphify installation, visual graph generation, or graph artifact commits.
- Replacing targeted source reads, runtime checks, or the Verification Matrix.
- Requiring a full function inventory for a documentation-only change or a project with no
  implementation code.

## Acceptance Criteria

- Active rules name `CODE_MAP.md` alongside `AGENTS.md`, `PROJECT_MAP.md`, and
  `.learnings/ERRORS.md` where the full project workflow applies.
- The template defines ownership, symbol, state, interface, validation, freshness, and privacy
  fields without requiring raw source dumps or secrets.
- SDD and entry/freshness guidance require reading the code map before relying on it and updating
  it when an affected structural or key-flow change lands.
- Graph Preview remains opt-in and `graphify-out/` remains untracked by default.
- Package validation verifies the code-map template and generated profiles carry the active rule.
