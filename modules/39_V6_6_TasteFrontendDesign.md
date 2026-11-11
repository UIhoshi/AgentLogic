# V6.6 Taste Frontend Design Integration

Status: **Stable V6.6 Line**.

This module defines the integration of the Taste Frontend Design Skill (from `taste-skill`) as a core visual-integrity capability under AgentLogic V6.6.

---

## 1. Core Integration Mandate

To prevent the generation of boilerplate, repetitive, or "slop" user interfaces, AgentLogic V6.6 embeds the **Taste Skill** guidelines. These rules enforce premium, design-system-driven aesthetic standards, layout variance, spring-based motion, and visual density controls.

For any user interface, website mockup, or frontend implementation task, the agent MUST prioritize premium aesthetics and avoid generic defaults.

---

## 2. Visual Dials & Parameters

When implementing or auditing user interfaces, the agent should configure and tune three primary design dials (rated 1 to 10):

1. **DESIGN_VARIANCE** (Default: 5): Controls layout experimentation.
   - *Lower (1-3)*: Clean, centered, symmetric, editorial structures.
   - *Higher (7-10)*: Modern, asymmetrical layouts, editorial overlaps, and bold branding.
2. **MOTION_INTENSITY** (Default: 5): Controls animation depth and micro-interactions.
   - *Lower (1-3)*: Standard transitions and elegant hover effects.
   - *Higher (7-10)*: Scroll-triggered, magnetic, and spring-based animations (powered by GSAP).
3. **VISUAL_DENSITY** (Default: 5): Controls whitespace and information distribution.
   - *Lower (1-3)*: Spacious, minimal interfaces, soft contrast.
   - *Higher (7-10)*: High-density dashboards, technical structures.

---

## 3. The Anti-Slop Redesign & `tasteskill 2.5.1` Workflow

For redesigns, landing pages, or visual upgrades of existing projects, follow this checklist:
1. **Business-Kind & Audit Phase**: Classify the business kind (`software`/`gaming`/`tech` vs. `product`/`service`/`place`) and conduct a full visual review to identify spacing inconsistency, low-contrast text, missing motion cues, or "default template" structures. Shader effects and code/telemetry scenes belong strictly on `software`, `gaming`, and `tech` pages.
2. **Token Set & Master + Overrides Persistence**: Declare a strict visual design system (typography scale, 192 industry palettes, spacing scale, equal edges, one section per viewport height) in `design-system/<project>/MASTER.md` (or `.specify/<task>/design-spec.md`) before writing CSS.
3. **Typography, Spacing & Resilient Text**: Ensure proportional hierarchy (`text-wrap: balance` on headings, `tabular-nums` on metrics, `+n` overflow disclosure on compact badge/chip lists) and strict margin/padding boundaries (`320px`/`390px` mobile collision checks and `>= 44px` tap targets).
4. **Motion & Finish Gate**: Implement quiet micro-interactions, a purposeful hero entrance, and 1–2 dealt scroll moments (`skills/taste-skill/skills/taste-skill/scripts/gate.mjs` and `copy-lint.mjs` anti-slop copy checks).

---

## 3.1 Visual Prototyping Gate (Design First Protocol)

For net-new UI and substantial UI refactors, the Agent MUST NOT write production HTML/CSS/JS/UI code directly. Instead, follow this mandatory visual prototyping gate. A clearly classified small visual correction may skip a new mockup under Module 49, but must still pass visual verification; ambiguous changes follow this gate. An explicit user instruction not to use the preview step also bypasses mockup approval:

1. **Prompt Formulation**: Formulate a highly detailed visual layout and style prompt based on the user's requirements (specifying typography, layout variance dials, HSL color palette, and visual density).
2. **Prototyping**: Invoke the host's text-to-image generation capability (e.g., `imagegen` on Codex, `invoke_subagent(TypeName="image-generator")` or `nano-banana-pro` on Antigravity) to generate a visual mockup / design image of the proposed UI. Never skip this step merely because a tool is named `image-generator` instead of `imagegen`.
3. **Artifact Review & Storage**: Save the generated image as a persistent artifact. If the host environment or chat client prevents direct visual rendering, save the mockup image directly to a visible folder within the project workspace (e.g., `.specify/mockups/` or the conversation artifacts folder), state the absolute file path clearly, and instruct the user to view the file locally.
4. **Interactive Consent**: Wait for the user to inspect the visual design mockup (either directly in the chat UI or via the local saved file path) and either explicitly approve it or explicitly opt out of the preview gate.
5. **Implementation**: Only after approval or explicit opt-out may the Agent proceed to code implementation. If the user requests changes, refine the prompt, re-run image generation, and present the updated design.
Verification of user interface changes is bound to the following rules:

| Visual Aspect | Mandatory Verification Tool / Method | Minimum Proof Required |
|---|---|---|
| Bounding Overflows | Parent-child bounding-box container check | No text clipping, line wrapping errors, or overflow on standard device viewports |
| Color / Contrast | Predefined HSL/RGB palette match check | CSS complies with contrast ratios and design token definitions |
| Micro-interactions | Screenshot / Browser event replay test | Interactive hover/active states trigger expected visual classes |
| Output Completeness | Post-edit full-code listing | Complete code files without truncated blocks or placeholder comments (e.g. `// TODO: implement rest`) |

---

## 5. Location of Assets

- **Design & Coding Skills**: `skills/taste-skill/skills/`
  - Default v2 Skill: `skills/taste-skill/skills/taste-skill/`
  - Minimalist UI: `skills/taste-skill/skills/minimalist-skill/`
  - Soft Visual Design: `skills/taste-skill/skills/soft-skill/`
  - Brutalist UI: `skills/taste-skill/skills/brutalist-skill/`
  - Stitch Rules: `skills/taste-skill/skills/stitch-skill/`
- **Image Generation Skills**: `skills/taste-skill/skills/imagegen-frontend-web/`, `skills/taste-skill/skills/imagegen-frontend-mobile/`, `skills/taste-skill/skills/brandkit/`
- **Research Findings (Laziness/Slop Root Causes)**: `skills/taste-skill/research/`
- **Original Rules Reference**: `skills/taste-skill/README.md`

## 6. Reference-to-Interface Extension

When design work begins from a permitted video, screenshot, live-page, or HTML reference, follow
`modules/47_V6_8_ReferenceToInterfaceWorkflow.md`. It adds source classification, constrained
reference briefs, approved capture paths, provenance boundaries, and conditional animation-
performance review; this module remains the authority for visual direction and preview approval.

## 7. Requirements-before-image integration

For net-new UI or substantial UI refactors, complete the single-question requirements grilling and record an approved UI brief before Prompt Formulation in section 3.1. A user may opt out of mockup approval only after that discovery step. Clearly classified small visual corrections may skip a new mockup under Module 49, but still require visual verification.
