# Plan — Portable Skill Deduplication and Activation Metadata

## Architecture

### Registry metadata

Add a central manual-selection taxonomy and an `activation` object to every
`contracts/skill-registry.json` record:

- `mode`: `route_candidate` for `mandatory`/`conditional` lifecycle records; `manual` for
  `manual_only` records.
- `triggers`: non-empty identifiers from the route contract for route candidates, or from the
  manual-selection taxonomy for manual records.
- `requirements`: explicit boundaries such as user request, task classification, permission,
  trust, or sandbox requirements.

The validator will enforce lifecycle-to-mode mapping, non-empty unique fields, valid taxonomy
references, and exact agreement between a route candidate's registry triggers and the union of its
referenced route triggers. This keeps the routing contract as the source of truth for automatic
selection.

### Duplicate evidence

Add `scripts/audit-skill-duplicates.ps1`. It reads every portable `SKILL.md`, computes a SHA-256
hash, inspects YAML front matter only for its declared `name`, and reports candidates. It never
modifies files. Exact-content and duplicate-name findings are evidence for review, not automatic
deletions.

### Validation and documentation

Extend the registry validator and its tests for activation metadata. Update Modules 49 and 53,
`CODE_MAP.md`, and `PROJECT_MAP.md`. Rebuild all generated bundles via
`scripts/build-profile.ps1`; do not hand-edit `dist/`.

## Deletion rule

The initial audit found no exact-content duplicate and no duplicate declared front-matter name.
Therefore this work performs **no deletion**. Non-identical skills remain intact unless a future
review establishes full duplication under Module 35's four-part test.

## Red-Team Results

| Rank | Fails if ___ | Counter-argument | Mitigation |
| --- | --- | --- | --- |
| 1 | a manual or security-sensitive skill becomes automatic merely because it has metadata | Metadata can clarify selection without changing lifecycle | Validator requires `manual_only -> manual`; automatic triggers must come from reviewed routes. |
| 2 | a common word or similar name deletes a unique skill | Similar workflows can carry distinct scripts or risk boundaries | Only hashes/name collisions are candidates; deletion requires separate direct equivalence evidence. |
| 3 | trigger metadata drifts from routing | Two contracts can diverge over time | Validate route-candidate triggers against referenced routing triggers. |
| 4 | broad bulk edits corrupt the 116-record registry | Generated JSON edits can omit entries or add invalid syntax | Use deterministic update plus registry and package validation. |
| 5 | generated bundles no longer match source | `dist/` is derived and can become stale | Rebuild through the profile builder and validate package/maintainer checks. |

## Validation

1. Run the read-only duplicate audit before and after changes.
2. Run skill-registry and skill-routing validators plus enforcement tests.
3. Run entry, package, and maintainer validation.
4. Inspect status and diff, ensuring the pre-existing deleted file remains untouched.