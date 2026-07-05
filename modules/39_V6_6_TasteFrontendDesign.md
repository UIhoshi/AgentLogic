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

## 3. The Anti-Slop Redesign Workflow

For redesigns or visual upgrades of existing projects, follow this checklist:
1. **Audit Phase**: Conduct a full visual review to identify spacing inconsistency, low-contrast text, missing motion cues, or "default template" structures.
2. **Token Set**: Declare a strict visual design system (typography scale, palette, spacing scale) before writing CSS.
3. **Typography and Spacing**: Ensure proportional hierarchy (e.g. tracking/leading adjustments) and strict margin/padding boundaries.
4. **Motion Enhancement**: Implement spring physics animations (preferably using GSAP or standard spring transitions) instead of linear ease functions.

---

## 3.1 Visual Prototyping Gate (Design First Protocol)

When designing a new frontend layout, app UI, or complex web interface component, the Agent MUST NOT write production HTML/CSS/JS code directly. Instead, follow this mandatory visual prototyping gate:

1. **Prompt Formulation**: Formulate a highly detailed visual layout and style prompt based on the user's requirements (specifying typography, layout variance dials, HSL color palette, and visual density).
2. **Prototyping**: Invoke the `generate_image` tool (powered by `skills/nano-banana-pro/`) to generate a visual mockup / design image of the proposed UI.
3. **Artifact Review**: Save the generated image as a persistent artifact under the conversation directory and present it clearly to the user.
4. **Interactive Consent**: Wait for the user to inspect the visual design mockup and provide explicit approval.
5. **Implementation**: Only after the user confirms that the mockup's aesthetics are premium and match expectations, should the Agent proceed to code implementation. If the user requests changes, refine the prompt, re-run image generation, and present the updated design.

---

## 4. Mandatory Design Verification Rules

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
