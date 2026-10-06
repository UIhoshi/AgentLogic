# Batched Install Consent — Specification

## Intent

When a requested installation is blocked by prerequisite reviews or missing capabilities, give the user one complete, actionable list instead of a sequence of surprise approval questions. Ask whether to perform the listed prerequisite reviews and installation together.

## Acceptance criteria

1. The agent checks what is already available, then lists only missing prerequisites, required audits, proposed components, sources/versions, target locations, side effects, and verification/rollback steps before asking for consent.
2. One explicit answer may authorize the whole disclosed, bounded sequence. Ordinary steps inside that approved scope do not trigger repeated confirmation.
3. Approval is not a waiver of security review, checksum/signature checks, host permissions, or post-install verification. Installation remains blocked if a required check fails.
4. A changed source, target, credential/data-egress need, remote effect, new high-risk/irreversible action, or materially different risk requires a new disclosure and decision.
5. Missing review tooling is included in the prerequisite list; an untrusted auditor is not silently installed or allowed to self-certify.
6. OfficeCLI-specific wording follows the general rule rather than forcing a separate approval for every stage.

## Out of scope

- No automatic installation, permission bypass, external publication, or Office file modification.
- No change to the skill-enforcement state machine or third-party trust status.
