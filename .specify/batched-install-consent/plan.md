# Batched Install Consent — Plan

## Approach

Add a general prerequisite-bundle and single-consent rule to Module 49, then align Module 50's OfficeCLI installation boundary and the stable version source. Generate host bundles through `scripts/build-profile.ps1`; do not edit `dist/` manually. Keep the current strict audit, integrity, permission, and verification gates.

## Verification

- Inspect generated diff for consistent wording and no broadened authority.
- Run logic-entry, package, and maintainer validation.
- Check that the pre-existing unrelated deletion stays untouched.

## Red-Team Results

1. **Fails if** one approval is interpreted as blanket trust or permission bypass. Steelman: a fully enumerated plan is a clear user authorization. Attack: audit results or host permission posture can invalidate the plan. Mitigation: explicitly retain all gates and stop on failed checks or denied permission.
2. **Fails if** an agent hides a newly discovered dependency inside the earlier approval. Steelman: dependencies are a normal part of installation. Attack: a new binary, data egress, or target can materially change risk. Mitigation: require a new disclosure and decision on material scope/risk changes.
3. **Fails if** the mandatory auditor is absent and the agent installs an untrusted auditor to approve itself. Steelman: bootstrapping the auditor unblocks review. Attack: circular trust is not an audit. Mitigation: list the gap and use only an already trusted/local review path; otherwise remain blocked.
4. **Fails if** OfficeCLI's existing “separate installation decision” wording causes repeated prompts. Steelman: separate means distinct from document processing, not one prompt per prerequisite. Attack: agents may read it literally. Mitigation: clarify that a bundled explicit decision satisfies the installation decision for disclosed scope.

Ranking: 1 > 2 > 3 > 4 by impact × likelihood × cheapness to test. All have text-level mitigations before implementation.
