# ADR-0003: Mandatory Textual Project Code Map

- **Status:** Accepted
- **Date:** 2026-07-19

## Context

The tracked L1-L4 `PROJECT_MAP.md` is deliberately concise. It helps agents identify a project
surface, but it does not give a new agent enough symbol-level navigation to locate the function,
class, state key, event surface, or owning module for a task without repeating broad discovery.
Visual graph tools can help, but they are external, consent-sensitive, and unsuitable as a
mandatory baseline.

## Decision

1. Every business project using the full AgentLogic workflow tracks root `CODE_MAP.md` alongside
   `AGENTS.md`, `PROJECT_MAP.md`, and `.learnings/ERRORS.md`.
2. `CODE_MAP.md` is a concise, source-backed navigation map, not a code dump or runtime proof.
   It records entrypoints, module ownership, key symbols, state/storage, interfaces/events,
   validation commands, and a freshness marker.
3. It is read at project entry and refreshed in the same commit as an affected structural or
   key-flow change. Projects without implementation code may explicitly record that fact.
4. Visual maps, including Graphify output, remain optional and user-approved. Their durable,
   verified conclusions are written back to the textual maps.

## Consequences

- New agents and fresh windows have a deterministic handover surface before deep source search.
- Map claims remain subject to current source reads and matching verification evidence.
- Repositories gain one small tracked artifact, while avoiding a mandatory external graph tool or
  committing generated graph artifacts by default.
