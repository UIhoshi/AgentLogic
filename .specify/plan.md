# AgentLogic V6.7.2 Logic Audit Remediation Plan

## Execution Order

1. Create the SDD records and define the applicability model.
2. Repair the entry-gate order and remove contradictory mandatory wording.
3. Update active V6.7.2 metadata and clarify the duplicate `00_README.md` boundary.
4. Make SDD/SRA and related gates conditional by task class and capability.
5. Make bundle generation deterministic and portable.
6. Strengthen mechanical validation and maintainer-check ordering.
7. Harden installation error handling, post-install verification, and legacy-file backup.
8. Rebuild all tracked host bundles.
9. Run source, package, generated-output, and installation-script validations.

## Task Applicability Model

| Task class | Required path |
| --- | --- |
| Read-only question or audit | Entry gate, fact map, matching evidence; no SDD artifacts or ship packet |
| Documentation-only or metadata-only change | Entry gate, targeted review, link/package validation; skip architecture Red-Team unless a rule contract changes |
| Trivial isolated fix | Lightweight spec/task note, targeted validation; Red-Team may be skipped when no architectural assumption exists |
| Feature, refactor, or multi-file behavior change | Full SDD phases, including Red-Team before tasks and Converge after implementation |
| Frontend visual change | Above path plus visual mockup approval only for net-new/major visual design; screenshot and layout-boundary verification for visible behavior |
| Install, packaging, or release change | Target confirmation, build/package verification, post-result inspection, and conditional SRA artifacts |

## Red-Team Results

### Claim 1: Keeping repository-relative placeholders is safer than resolving paths during build

- Steelman: generated bundles are easier to navigate when links resolve to local source files.
- Attack: the bundle is installed on another machine, so an absolute build-machine path is stale
  or leaks the build environment.
- Fails if: a generated bundle contains `file:///C:/`, `file:///D:/`, or equivalent host paths.
- Mitigation: preserve `REPO_ROOT_PLACEHOLDER` in generated content and mechanically reject machine
  absolute paths in active and generated logic.

### Claim 2: Validating generated outputs after building all hosts provides a reliable release gate

- Steelman: every host output is produced from the manifest and can be checked against the source.
- Attack: a maintainer may validate only generic output or validate before generation.
- Fails if: any manifest host output has an old version header or differs from a deterministic
  fresh build.
- Mitigation: validate all manifest outputs, compare deterministic hashes through a temporary build,
  and make maintainer-check build all four hosts before final validation.

### Claim 3: Moving legacy files after successful installation prevents destructive loss

- Steelman: the new target must win precedence over stale host files.
- Attack: cleanup before a successful install can leave the host without working logic; cleanup after
  install can delete the newly selected default target.
- Fails if: an install failure removes the only existing logic file, or post-install cleanup removes
  the new target.
- Mitigation: verify the new target first, protect the selected target, and move other legacy files
  into a timestamped backup directory.

### Claim 4: Conditional gates preserve safety without weakening high-risk work

- Steelman: every task receiving the same gates is simple to reason about.
- Attack: universal SDD, visual, glossary, performance, security, and business-handover steps create
  noise and encourage bypassing the whole system.
- Fails if: a task with a trust-boundary, release, frontend-visible, or architectural change can
  bypass its matching verification path.
- Mitigation: classify tasks first, keep matching gates mandatory, and explicitly exempt only low-risk
  classes that do not exercise the capability.

## Architectural Decision

The repository will use a single task-applicability model and deterministic, portable generated
bundles. Historical version files remain immutable; active documentation and generated outputs are
the synchronized surface.
