# Specification — Portable Skill Deduplication and Activation Metadata

## Goal

Audit every portable `skills/**/SKILL.md` entry, remove only a directly proven duplicate, and make
selection conditions explicit for every registered skill without auto-enabling unreviewed or
security-sensitive capabilities.

## Requirements

1. Keep exactly one registry record for every discovered portable `SKILL.md` entry.
2. Detect duplicate candidates deterministically using full-file SHA-256 and declared front-matter
   name. A non-identical file is not a deletion candidate without a separate human-reviewed
   equivalence decision.
3. Do not delete any skill unless the audit proves an exact duplicate and the registry can be
   updated without losing unique routing, scripts, templates, or references.
4. Add non-empty, validated selection conditions to all registry records.
5. Preserve the existing lifecycle boundary: `mandatory` and `conditional` records may be route
   candidates; `manual_only` records remain manual and must not be silently auto-routed.
6. Make automatic route-candidate triggers derive from the canonical route contract. Manual skills
   use an explicit controlled manual-selection taxonomy.
7. Add a read-only duplicate-audit command and validation coverage for malformed activation
   metadata.
8. Update the skill-enforcement documentation, project maps, and generated bundles.

## Acceptance Criteria

- The duplicate audit reports no unsupported deletion decision and identifies exact-content or
  duplicate-name candidates with paths.
- Every registry record has valid, non-empty activation metadata.
- Only the existing reviewed routable entries remain automatic route candidates unless a separately
  reviewed route is added.
- Registry, routing, enforcement, entry, package, and maintainer validation pass.
- Existing unrelated working-tree deletion remains untouched.