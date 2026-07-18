# Plan: Mandatory Textual Project Code Map

## Approach

Extend the existing project-native knowledge-sync contract rather than adding a second mapping
system. `PROJECT_MAP.md` remains the concise L1-L4 architecture map; new root `CODE_MAP.md`
becomes the mandatory symbol-level handover map for full-workflow business projects.

## Changes

1. Add `templates/CODE_MAP.md` with bounded, source-backed sections.
2. Update Module 46, the project map template, entry rules, SDD, master map, README, and current
   version source to make the textual map mandatory and its visual counterpart optional.
3. Register the template in `manifest.json` and package validation.
4. Record ADR-0003 and regenerate `dist/` only through `scripts/build-profile.ps1`.

## Red-Team Results

### Claim: A mandatory code map will improve handover without becoming stale documentation

- Steelman: symbol ownership, storage keys, and entrypoints are expensive to rediscover in large
  files; a committed map makes the first search deterministic.
- Attack: a manually written exhaustive function catalog decays quickly and can mislead agents.
- Fails if: the map claims current symbols without a source/commit freshness marker or grows into
  a raw code dump.
- Mitigation: limit the template to navigation-critical symbols, require a freshness marker and
  same-commit updates for affected structural/key-flow changes, and retain direct-read evidence.

### Claim: Visual graph output can stay optional

- Steelman: visual graphs help architecture reviews but impose installation, privacy, and artifact
  costs.
- Attack: making them mandatory would block ordinary work on hosts without Graphify and create
  stale generated output.
- Fails if: a project cannot proceed without a third-party graph tool.
- Mitigation: keep Graphify consent-gated; record durable verified conclusions in text maps.

### Claim: Four tracked knowledge files are appropriate for every full-workflow business project

- Steelman: each file has a separate role: rules, L1-L4 facts, symbols, and resolved errors.
- Attack: tiny projects can be overburdened.
- Fails if: projects with no implementation code must invent a symbol inventory.
- Mitigation: require only a concise map; documentation-only/no-code projects may state that no
  implementation symbols exist and defer expansion until code is present.

## Validation

- Run `node scripts/check-logic-entry.js`.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1`.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1`.
- Inspect generated `dist/` and `git diff` after regeneration.
