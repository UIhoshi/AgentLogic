# Architecture

## Scope

This V6.8.0 change hardens the AgentLogic logic package rather than an application runtime. The package
has four operational surfaces:

1. repository-local entry and governance documents;
2. `manifest.json` profile and host-output contract;
3. PowerShell installers and validation scripts;
4. generated host bundles under `dist/`.

## Trust and risk boundaries

- Repository files are the source of truth; `dist/` is generated output.
- `install.ps1` crosses from repository state into host configuration and host-local skill state.
- Legacy host files are now moved to `.agentlogic-backup` only after the new target is verified.
- Active source documentation uses repository-relative links; generated bundles contain no
  build-machine absolute file URIs.
- Formal UI implementation is gated by a text-to-image preview and user review, unless the user
  explicitly opts out.

## Known risks / assumptions

- Host adapters still depend on PowerShell and host-specific configuration semantics.
- Host-local skill inventory is reported during installation; applying archive moves remains a
  separate user-requested operation.
- The imported `skills/` and `spec-kit/` trees are reference/integration surfaces and were not
  fully security-audited by this remediation.

## Related documents

- `.specify/spec.md`
- `.specify/plan.md`
- `.specify/tasks.md`
- `.specify/ship/flows.md`
- `.specify/ship/permissions.md`
- `.specify/ship/variables.md`
- `.specify/ship/tests.md`
- `docs/adr/0001-portable-bundles-and-conditional-gates.md`
