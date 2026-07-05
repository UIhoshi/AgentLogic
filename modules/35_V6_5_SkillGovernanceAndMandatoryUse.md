# V6.5 Skill Governance And Mandatory Use

Status: **Stable V6.5 Line**.

This module defines how host-local skills should be treated under V6.5.

Zone separation between host-local skills and any future logic-carried skill layer is defined in `modules/36_V6_5_SkillZoneSeparation.md`.

---

## 1. Core Distinction

The logic package and the host-local skill system are not the same layer.

This module governs the **host-local skill zone**. It does not redefine a future logic-carried skill zone as disposable user clutter.

- **Logic package**
  - defines behavioral rules
  - defines entry discipline
  - defines verification standards
  - defines tool/question/risk boundaries
- **Skills**
  - provide reusable domain workflows
  - provide operational wrappers, scripts, templates, or reference packs
  - accelerate execution in recurring task families

The logic package is the operating method.
Skills are optional execution amplifiers that must remain subordinate to the logic package.

---

## 2. Deduplication Rule

A skill should be treated as a **full duplicate** and may be removed only when all of the following are true:

1. it adds no unique workflow beyond the main logic
2. it adds no unique scripts, templates, or operational wrappers
3. it adds no domain-specific reference layer
4. its practical behavior is fully replaced by existing logic-package modules

If a skill overlaps conceptually with the logic package but still contributes unique operational value, it should be kept and classified as **partial overlap, not duplicate**.

---

## 3. Current Audit Result

### 3.1 Full duplicates

Current audit result:

- **no active skill family was judged to be a full duplicate of the V6.5 logic package**

Therefore, no skill family should be deleted on "duplicate-only" grounds at this time.

### 3.2 Partial-overlap skills that should be kept

These skills overlap with V6.5 logic but still provide unique operational value:

- `screenshot`
  - overlaps with mandatory visual verification
  - still provides OS-level screenshot capture procedures and scripts
- `playwright`
  - overlaps with browser/UI verification
  - still provides real browser automation workflow
- `security-best-practices`
  - overlaps with safety and verification philosophy
  - still provides language/framework-specific security guidance
- `gh-fix-ci`
  - overlaps with validation/build discipline
  - still provides GitHub Actions-specific inspection workflow
- `.system/openai-docs`
  - overlaps with official-doc verification rules
  - still provides concrete OpenAI-doc workflow
- `engineering/skill-security-auditor`
  - overlaps with skill-governance and safety
  - still provides a concrete audit workflow for untrusted skills
- `figma` / `figma-implement-design`
  - overlaps with UI verification and design handoff
  - still provides design-specific execution guidance
- `agent-browser`
  - overlaps with static page fetching (`read_url_content`) and playwright-based UI verification
  - still provides high-performance, deterministic ref-based headless browser automation optimized for AI agents

### 3.3 Archived-but-not-duplicate families

The following families may remain archived/off-by-default for context-budget reasons, but they are not logic duplicates:

- business-growth
- c-level-advisor
- finance
- marketing-skill
- product-team
- project-management
- ra-qm-team

They are **budget-heavy domain packs**, not duplicate logic layers.

---

## 4. Active vs Archived Skill Policy

### 4.1 Active-by-default

Keep active-by-default only the skills that materially support the normal coding / debugging / review / verification workflow.

Typical active-by-default families:

- `.system`
- `engineering`
- `engineering-team`
- `playwright`
- `screenshot`
- `security-best-practices`
- `figma`
- `figma-implement-design`
- `gh-fix-ci`
- `agent-browser`

### 4.2 Archived-by-default

Archive large domain packs by default when they:

- inflate skill context budgets
- are irrelevant to most coding rounds
- dilute the chance that the most useful engineering skills stay visible

Archived skills should be restored only when the current task clearly matches their domain.

---

## 5. Mandatory Skill-Use Situations

The following are not just "nice to have" skill triggers. They should be treated as mandatory when the condition matches and the skill is available.

### 5.1 Screenshot skill

Use `screenshot` when:

- the user explicitly asks for a desktop or system screenshot
- an OS-level app/window/region capture is required
- no better tool-specific capture path exists

Do not replace this with code reading or build success claims.

### 5.2 Playwright skill

Use `playwright` when:

- the task requires real browser interaction from the terminal
- a live web flow must be inspected
- browser UI behavior must be reproduced, clicked through, or captured

Do not substitute static reads for this when the required proof is browser behavior.

### 5.3 Security-best-practices skill

Use `security-best-practices` when:

- the user explicitly asks for security review or secure-by-default guidance
- the task is a security best-practices review for supported stacks

Do not downgrade this to generic code review when the request is explicitly security-scoped.

### 5.4 Gh-fix-ci skill

Use `gh-fix-ci` when:

- the user asks to investigate or fix failing GitHub PR checks
- the failure surface is GitHub Actions-centered

Do not replace this with a generic "look at CI later" workflow if the problem is specifically PR checks.

### 5.5 OpenAI-docs skill

Use `.system/openai-docs` when:

- the user asks how to use OpenAI products or APIs
- current official OpenAI documentation is needed
- a latest-model or latest-doc answer is required

This matches the stable rule that OpenAI-product guidance should be grounded in official current sources.

### 5.6 Skill-security-auditor

Use `engineering/skill-security-auditor` when:

- evaluating an untrusted third-party skill
- installing a skill or plugin from a new external source
- checking whether a skill contains dangerous scripts or prompt injection patterns

This should be treated as the default pre-install safety gate for untrusted skill imports.

### 5.7 Figma / Figma-implement-design

Use `figma` or `figma-implement-design` when:

- the task is explicitly design-to-implementation from Figma
- the user expects design-source inspection rather than approximate recreation

Do not treat plain code reading as sufficient when the real source of truth is the design surface.

### 5.8 Agent-browser skill

Use `agent-browser` when:

- the task requires dynamic web interaction, page navigation, clicking elements, filling forms, session-isolated browsing, or executing client-side JavaScript from the terminal.
- standard static url fetching (`read_url_content`) is insufficient due to Single Page Application (SPA) rendering or multi-step user flow requirements.

---

## 6. Skills Must Not Weaken Verification

A skill invocation does not bypass V6.5 verification rules.

Even when a skill is used correctly:

- `29_MandatoryVerificationMatrix.md` still applies
- `30_ToolQuestionBoundaryMatrix.md` still applies
- `31_ToolMisuseAndAntiPatternMatrix.md` still applies

A skill may accelerate the path, but it does not lower the evidence requirement.

---

## 7. Restore Rule For Archived Skills

If an archived skill family becomes relevant again:

1. restore only the smallest relevant family or subfamily
2. do not bulk-restore every archived pack
3. verify that the restored set does not re-trigger skills context budget degradation
4. if the restored family becomes a recurring requirement, document that promotion explicitly

---

## 8. Practical Judgment

The preferred V6.5 posture is:

- **keep the logic package lean and authoritative**
- **keep only high-value execution skills active by default**
- **archive broad domain packs unless currently needed**
- **treat skills as execution amplifiers, not as replacements for logic**

---

## 9. Dynamic Context-Based Skill Selection (Context-Driven Routing)

To eliminate manual activation and ensure skills are integrated seamlessly based on conversation flow, the agent must dynamically evaluate skill applicability:

### 9.1 Dialog Intent Mapping
Every turn, the agent MUST inspect the user's request and the conversation context to determine if they intersect with any active or archived skill domains:
1. **Direct Action Mapping**: If the user asks for actions like web interaction, dynamic page testing, visual inspection, or exploit pattern tracking, the agent must automatically invoke the relevant skill (`agent-browser`, `playwright`, `screenshot`, or `reverse-skill`).
2. **Implicit Need Detection**: If a task requires dynamic rendering or session persistence (e.g. logging into a site), the agent must dynamically activate the matching skill rather than asking the user to manually trigger it.

### 9.2 Auto-Restoration protocol
If the conversation context demands an archived skill, the agent should dynamically restore/activate it (by parsing its `SKILL.md` or loading its template) for the current task scope without user intervention.

### 9.3 Codebase Tool Dominance
When a skill introduces a specialized command-line utility (e.g. `agent-browser` CLI), the agent must automatically prefer utilizing it over writing custom scripts or ad-hoc wrappers, ensuring unified tool usage.
