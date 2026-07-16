# V6.7.2 AI Shipping & Reviewability Audit Integration

Status: **Stable V6.7.2 Line (Mandatory shipping & verification protocol)**.

This module defines the **AI Shipping & Reviewability Audit (SRA)** workflow, integrating concepts from the `pm-ai-shipping` framework. It addresses the critical gap in AI-assisted coding: while AI agents write code at extremely high speeds (the vibe-coding phase), they often leave no trace of design intent, security assumptions, variable maps, or test coverage. This protocol restores human reviewability and ensures safety before code is shipped.

---

## 1. The SRA Core Mandate

Every completed application implementation, major refactor, externally consumed logic change, or
version/release package **MUST** pass through the applicable **Ship & Audit Phase** before being
merged or packaged. Read-only audits and documentation-only changes use targeted review unless
they alter a shipped rule contract, install path, trust boundary, or packaging surface.

The goal is to translate "vibe-coded" codebases into documented, verified, and audited systems where developers and PMs can confidently verify:
1. What the code is *intended* to do (documented intent).
2. What the code *actually* does (implemented reality).
3. The exact *gap* between intent and implementation, backed by concrete evidence.

---

## 2. Standard Shipping Artifacts

To compile a reviewer-ready **Shipping Packet** under `documentation/` (or `.specify/ship/`), the Agent must generate or update the following documents, organized as **Core** (always required) and **Conditional** (only when the capability exists).

### 2.1 Core Documents

Every reviewable application or release surface **MUST** produce these five documents. However, non-application script changes, local build/validation script tooling (e.g., CLI helpers), or pure logic-document changes are exempt from generating `permissions.md` and `variables.md` (and other irrelevant application-centric SRA files) if they do not contain user authorization, database tables, or environment secrets. For such tooling or pure logic modifications, the shipping audit may be consolidated into a single `review_record.md` or documented within the version update history / PR description.

| Artifact File | Purpose | Required Contents |
| :--- | :--- | :--- |
| **`architecture.md`** | What the system is and how it connects | Product overview, tech stack, auth/session flow, trust boundaries, **Known risks / assumptions** list (each entry citing where it shows up in the code), and a "Related Documents" index linking to every other shipping doc. This is the root document. |
| **`flows.md`** | Runtime view of who does what, when, and in what order | Each load-bearing flow as: actor → precondition → success outcome. Step-by-step sequence across UI → server → data → jobs → providers → agents. The **authz check at each protected step** (which claim/role/scope, on which resource, and the expected *deny* case). The **trust-boundary crossings** at each step (see §5). State changes and side effects each step causes. |
| **`permissions.md`** | Static declaration of access rules | User role matrices, RBAC/policy declarations, endpoint access rules, resource-level permission grants. This is the *declared* view; `flows.md` is the *runtime* view. Reviewers compare the two. |
| **`variables.md`** | Environment variable and secret registry | Environment variable registries, third-party API configurations, strict validation rules, zero-hardcoded-credentials verification. |
| **`tests.md`** | Derived verification map | **NOT** an inventory of existing tests. This document is **derived from** `architecture.md`, `flows.md`, and `permissions.md` by the `/derive-tests` workflow. It lists the tests that *should* exist based on documented intent, cross-references which currently exist, and highlights unverified gaps. |

**Anti-PRD Rule**: A flow that does not touch permissions, data integrity, external side effects, or trust-boundary crossings is not worth documenting in `flows.md`. This prevents the shipping packet from inflating into a meaningless PRD.

### 2.2 Conditional Documents

Include a conditional document **only if** the application actually has that capability. If the capability does not exist, write a single line in `architecture.md` (e.g., "No scheduled work — no `cron.md`.") rather than creating an empty document. Reviewability comes from an honest map, and "we don't do X" is part of the map.

| Conditional File | Trigger Condition |
| :--- | :--- |
| **`cron.md`** | The application has any background scheduled tasks, cron jobs, or periodic workers |
| **`emails.md`** | The application sends transactional or marketing emails, including templates and trigger rules |
| **`seo.md`** | The application has SEO-critical pages, structured data, or sitemap generation |
| **`agents.md`** | The application embeds AI agents, LLM calls, autonomous workflows, or tool-use chains |

---

## 3. Universal Audit Principle: Self-Refute First

**This principle applies to all selected audit workflows in this module, not just security.**

For every finding reported by any audit workflow (§4.1–§4.4), the Agent **MUST**:
1. **State the finding** with specific code location and evidence.
2. **Try to disprove it** using local code evidence (a counter-argument grounded in actual implementation).
3. **Report only findings that survive self-refutation**. Each surviving finding must include its
   evidence, counter-argument, residual uncertainty, and a status such as verified, partially
   verified, or needs runtime confirmation. The standard is strong local evidence, not an
   impossible claim of absolute certainty.

Findings that can be disproven should be logged as "Investigated and cleared" with the disproving evidence, not silently dropped.

This principle integrates with `modules/29_MandatoryVerificationMatrix.md` §4 (Escalation Rule): the higher the consequence of a false finding, the stronger the self-refutation attempt must be.

---

## 4. Operational SRA Workflows

When executing the shipping phase, the Agent performs the following audit workflows natively:

### 4.1 App Reverse-Engineering (`/document-app` workflow)

If documentation is missing or outdated, the Agent must read the source code and reconstruct the system intent:
- Document the actual database state, API schemas, and component architecture into `architecture.md`.
- Reconstruct the runtime flows into `flows.md`, explicitly marking each trust-boundary crossing (see §5).
- Extract the static permission declarations into `permissions.md`.
- Identify conditional capabilities (background cron jobs, embedded AI agents, SEO structures, email templates) and generate the corresponding conditional documents (§2.2) only for capabilities that actually exist.
- Apply the Self-Refute principle (§3): any architectural assumption must be verified against code evidence.

### 4.2 Intended vs. Implemented Gap Analysis (`/derive-tests` workflow)

The Agent must match the documented specifications (from `.specify/spec.md` or earlier project docs) against the actual codebase implementation:
- **Compare**: Search for features mentioned in specs that are missing in the code, or undocumented logic implemented in the codebase.
- **Deduce**: Create a gap analysis report citing the exact lines of code or specs where divergence occurs.
- **Derive**: Generate `tests.md` as a **verification map** — listing the tests that *should* exist based on architecture, flows, and permissions documents, not merely inventorying existing tests.
- **Cover**: For untested business logic, generate precise test scenarios and recommend a green-before-merge CI gate.
- **Self-Refute** (§3): For each reported gap, attempt to find code evidence that the gap does not actually exist (e.g., the feature is implemented under a different name or path).

### 4.3 Static Security & Trust Boundary Audit (`/security-audit-static` workflow)

A disciplined, self-refuting security scan:
- **Map Trust Boundaries**: Document who may read or write to specific folders, tables, or endpoints, using the trust-boundary crossing enumeration (§5).
- **Verify Secrets**: Scan for raw strings, hardcoded tokens, or unsafe exposure of `.env` configurations.
- **Self-Refute Findings** (§3): For every security finding, the Agent must try to disprove it using local code evidence. Report only risks that are backed by undeniable code proof.

### 4.4 Static Performance & Caching Audit (`/performance-audit-static` workflow)

A static analysis of application efficiency:
- Detect N+1 query patterns, nested API requests (waterfalls), and database over-fetching.
- Identify missing database indexes or redundant network roundtrips.
- Recommend caching rules ranked by implementation effort and performance impact.
- **Self-Refute** (§3): For each performance finding, verify that the pattern actually executes in a hot path (not dead code or a rarely-hit branch).

---

## 5. Trust Boundary Crossing Enumeration

When documenting flows (§2.1 `flows.md`) and performing security audits (§4.3), the Agent must explicitly label each trust-boundary crossing using this structured enumeration:

| Boundary Type | Example | What to verify |
| :--- | :--- | :--- |
| **browser → server** | Form submission, API call | Input validation, CSRF protection, auth token |
| **server → database** | SQL query, ORM call | Query parameterization, permission scoping |
| **server → provider** | Third-party API call | API key handling, response validation, timeout |
| **job → app** | Background worker callback | Authentication of job origin, idempotency |
| **agent → tool** | LLM calling an external tool | Tool permission boundary, output sanitization |
| **webhook → app** | External service callback | Signature verification, replay protection |
| **server → server** | Microservice-to-microservice | mTLS, service identity, scope propagation |

Each crossing point is a potential security gap and must be explicitly annotated in `flows.md`.

---

## 6. Gated Shipping Checklist (`/ship-check` execution)

Before declaring an applicable task finished and ready for human merge review, the Agent **MUST** run the `/ship-check` cycle:

- [ ] **Specs Sync**: Check if `.specify/spec.md` is aligned with the final code.
- [ ] **Core Docs Compiled**: Verify that `documentation/` (or `.specify/ship/`) contains updated `architecture.md`, `flows.md`, `permissions.md`, `variables.md`.
- [ ] **Tests Derived**: Verify that `tests.md` has been derived from the other core documents via §4.2, not merely copied from existing test files.
- [ ] **Conditional Docs Honest**: Verify that conditional documents (§2.2) exist only for capabilities that are present, and absent capabilities are declared in `architecture.md`.
- [ ] **Security Clear**: When the change has secrets, permissions, trust boundaries, or external inputs, run the static security audit (§4.3) with self-refutation (§3) and verify the applicable secret-handling claims.
- [ ] **Performance Approved**: When the change has a runtime hot path, database access, network flow, or caching behavior, run the performance audit (§4.4) with self-refutation.
- [ ] **All Findings Self-Refuted**: Confirm that every reported finding has been through the self-refutation process (§3).
- [ ] **Human Handover**: Ask about a human-readable handover package only when the user or project stakeholders need business-facing reporting; compile it only if requested.

---

## 7. Integration with Verification Matrix

This module operates under the same evidence standards defined in `modules/29_MandatoryVerificationMatrix.md`:

- **Security claims** are "Runtime / build / packaging claims" → require command/runtime verification, not just code reading.
- **Performance claims** are "Behavior with ambiguous evidence" → require at least two independent evidence paths.
- **Architecture claims** are "Local repository facts" → require targeted file reads confirming actual implementation.
- The **Escalation Rule** (Module 29 §4) applies: high-impact SRA findings demand precondition confirmation + execution evidence + post-result verification.

The SRA module does not lower the evidence bar. It structures what must be documented; Module 29 governs how the documentation claims are verified.
