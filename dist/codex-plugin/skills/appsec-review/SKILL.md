---
name: appsec-review
description: Comprehensive application security review, diff-scoped vulnerability triage, repository-grounded threat modeling, and security ownership analysis. Trigger automatically when reviewing PRs/diffs for security, auditing auth/crypto/permissions/input-parsing/secrets/sandbox boundaries, running threat modeling, or analyzing sensitive-code bus factor.
---

# Application Security Review & Threat Modeling (`appsec-review`)

This skill synthesizes the open-source Apache-2.0 security workflows from **OpenAI Skills** (`openai/skills`: `security-best-practices`, `security-threat-model`, `security-ownership-map`) with clean-room diff-scoped reachability review, directory-scoped `SECURITY.md` resolution, and tri-state static verdict discipline.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill (without waiting for the user to ask by skill name) whenever the task involves:
- Security review or AppSec audit of source code, a PR, commit range, branch diff, or working-tree patch (`security-review`).
- Repository-grounded threat modeling (`STRIDE`, trust boundaries, assets, abuse paths, mitigations).
- Sensitive-code ownership, `CODEOWNERS` risk validation, or bus-factor hotspot topology.
- Modifying authentication, authorization, cryptography, secrets handling, deserialization, parsers, sandboxing, or external network/file boundaries.

---

## 2. Mode A: Diff-Scoped & Language Security Review (`security-diff-and-best-practices`)

### A.1 Policy & Scope Resolution
1. Resolve the exact scope first: Git diff range, local patch, or targeted directory/language (`python`, `javascript`/`typescript`, `go`, `powershell`, etc.).
2. Inspect **every changed text file** in scope, including **deleted files** at the baseline revision, and trace changed behavior into supporting callers/callees without expanding into an unrelated full-repo audit unless requested.
3. Locate and read the root and any directory-scoped `SECURITY.md` policy covering affected paths before assigning severity, so attacker roles, trusted inputs, and product security boundaries match project policy.

### A.2 Language & Secure-by-Default Checklist
- **Input & Injection Surfaces**: Parameterized SQL/queries, strict command-arg arrays (never unsanitized shell interpolation), safe path normalization against traversal, prototype/attribute-pollution guards, safe XML/YAML/JSON deserialization, and output encoding / CSP hygiene (never write raw unescaped markup sinks).
- **AuthN / AuthZ & Session Integrity**: Server-side authorization checks on every state-changing endpoint/action, CSRF/origin validation, constant-time token comparison, least-privilege session/JWT validation (`alg` pinning, expiry, audience).
- **Secrets, Crypto & Sandbox**: Zero hardcoded credentials or tokens, CSPRNG (`crypto.randomBytes` / `secrets`) for security tokens, AEAD ciphers (`AES-GCM` / `ChaCha20-Poly1305`), TLS verification enabled, explicit outbound URL/redirect SSRF allowlists.
- **CI / Build / Packaging Surfaces**: Unpinned third-party Actions, untrusted PR script execution (`pull_request_target`), environment/secret leakage in logs.

### A.3 Tri-State Static Verdict & Self-Refute First Gate
Every candidate finding MUST follow **Self-Refute First** and carry one explicit static-evidence verdict:
- **`confirmed`**: Attacker-controlled source -> reachable sink verified in current code with concrete `file:line` evidence and no effective upstream sanitizer/guard.
- **`not_actionable`**: Counter-argument succeeded (unreachable, dead path, non-attacker-controlled input, or enforced upstream guard/policy).
- **`needs_review`**: Reached a clear risk boundary, but missing runtime/config/external proof prevents confirmation.

**Honesty Rule**: Never turn an incomplete scan or skipped files into a "no findings" claim; explicitly state coverage limits and uninspected paths.

---

## 3. Mode B: Repository-Grounded Threat Modeling (`threat-model`)

1. **System Model Extraction**: Inventory primary components, data stores, external integrations, and runtime entrypoints (server, CLI, worker, library), separating runtime from CI/dev tooling and tests.
2. **Trust Boundaries, Assets & Entrypoints**: Map concrete trust boundaries (protocol, auth, encryption, validation, rate limits), high-value assets (credentials, user data, models, compute, audit logs), and attack surfaces (endpoints, uploads, parsers, jobs, admin tools).
3. **Abuse Paths & Mitigations**: Enumerate realistic `Actor -> Entrypoint -> Asset -> Impact` paths, distinguish existing verified controls from gaps, and tie each mitigation to a concrete owner/file.

---

## 4. Mode C: Security Ownership & Bus-Factor Map (`security-ownership`)

When auditing maintainer risk, orphaned sensitive code, or `CODEOWNERS` accuracy:
1. Analyze git history (excluding noise commits like lockfiles/Dependabot unless requested) to build a people-to-file topology and file co-change clusters.
2. Flag sensitive hotspots (auth, crypto, permissions, CI workflows) with `bus_factor <= 1`, inactive/departed primary owners, or stale `CODEOWNERS` rules.

---

## 5. Attribution
- Incorporates methodologies from `openai/skills` (`security-best-practices`, `security-threat-model`, `security-ownership-map` — `Apache-2.0`) and clean-room diff-scoped / tri-state verdict workflows.
