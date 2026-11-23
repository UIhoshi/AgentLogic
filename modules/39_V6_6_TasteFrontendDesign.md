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

---

## 8. Modern Web Platform & Baseline Integration (`modern-web-guidance`)

While `ui-ux-pro-max` and `taste-skill` govern **aesthetic direction, anti-slop copy, and visual prototyping**, all HTML, CSS, DOM, and client-side JS implementation (`ui-implementation`) MUST pair them with **`skills/frontend/modern-web-guidance/SKILL.md`** (from `GoogleChrome/modern-web-guidance`):

1. **Search-First Platform Guidance**: Before writing custom JS workarounds or adding heavy UI libraries for modals, popovers, tooltips, tables, forms, dark mode, animations, or performance fixes, query `npx -y modern-web-guidance@latest search "<query>"` + `retrieve "<id>"` (or read the vendored offline catalog under `skills/frontend/modern-web-guidance/guides/`).
2. **Baseline Compatibility & Responsible Fallbacks**: Prefer **Baseline Widely available** native APIs (`<dialog>`, Popover API, CSS Anchor Positioning, Container Queries, View Transitions, Scroll-driven animations, `:user-invalid`, `oklch()`, `content-visibility`, `scheduler.yield()`). For features not yet Baseline Widely available, follow the guide's explicit fallback policy unless the project specifies a custom browser target.
3. **Codebase Modernization (`legacy-scan`)**: When asked for a broad frontend modernization or legacy-pattern audit, run `npx -y modern-web-guidance@latest legacy-scan <path> --json`, verify findings against `keepWhen`/`dropWhen`, and modernize with retrieved guides.
4. **Chrome Extensions (MV3)**: For browser extension development or Chrome Web Store publishing, load **`skills/frontend/chrome-extensions/SKILL.md`** and its `references/`.
5. **Deprecated Variants Removed**: Legacy `taste-skill-v1` has been retired in favor of `taste-skill` (`v2.5.1`) + `modern-web-guidance`.

---

## 9. Real-World Visual & Motion Reference Grounding Gate (SVG / Canvas / 3D / Animation)

Before generating bespoke frontend illustrations, vector graphics (`.svg`), Canvas/WebGL scenes, or motion/keyframe animations, the Agent MUST classify the subject's physical existence and apply reference-first grounding:

1. **Existence Classification**:
   - **Real-World Existing Subject** (animals such as zebras/horses, globes/continents, real architecture, human anatomy, mechanical devices, real vehicles): **BLOCKING** — Do NOT draw shapes or choreograph motion from blind text priors.
   - **Non-Existent / Purely Abstract Subject** (abstract geometric flourishes, fictional creatures, pure conceptual UI icons): May proceed directly to creative composition.
2. **Static Visual Reference (Mandatory Media Download + `read_file` Visual Inspection)**:
   - **NEVER substitute text-only `search_web` summaries for real visual inspection.**
   - When creating static visuals (e.g., an SVG/Canvas zebra, dog, pelican, or globe), first locate real photographs (e.g., Wikimedia Commons / verified visual sources), **download the actual image files locally** (e.g., into `references/media/` or `.specify/<task>/references/`), and **visually inspect each downloaded image with `read_file`** before writing `<path>` / `<g>` / Canvas geometry.
   - Extract exact silhouette proportions, joint musculature transitions, continent boundaries, and natural pattern flow (e.g., curved scapula/gluteal stripes rather than uniform "barcode" lines).
3. **Dynamic Motion Reference (Mandatory GIF / Video / Gait Frame Inspection)**:
   - When animating a real-world subject (e.g., making a zebra gallop, a dog run and sit, a pelican fly and dive), first locate and **download real motion references** (GIFs, short video clips, or multi-frame gait sequences) locally and inspect them via `read_file` (or extracted keyframes) to extract **keyframe phases, joint pivot points, leg-crossing order, easing curves, and secondary motion** before writing CSS `@keyframes`, SMIL, GSAP, Canvas, or Web Animations API code.
4. **Anti-Stick-Puppet Contour Discipline, Z-Depth Interleaving & Multi-State Visual Audit**:
   - Build real-world subjects using continuous anatomical Bézier contours (`bezierCurveTo` / SVG `<path>`) that blend torso, neck, and limb musculature—avoid bare ovals with straight-tube limbs and exposed circular joint caps. Interleave Z-depth layers (far limbs -> chassis/background -> torso -> near chassis -> near limbs) so riders/characters sit inside mechanisms rather than pasted in front.
   - **Multi-State / Multi-Frame Visual Audit**: For regular UI, verify key states & viewports (desktop + mobile + active overlays/modals). For animations, expose a deterministic time parameter (e.g., `?t=`) and inspect multiple keyframe moments (start, mid-action, climax, end) in a real browser/screenshot rather than only the initial frame.
5. **Scoped Creative Animation Sub-Path (Do NOT Bloat Standard Business UI)**:
   - Keep standard business/SaaS UI lean with native HTML/CSS (`modern-web-guidance`).
   - Only when building bespoke multi-act generative animations or painterly/ink/brush art styles, prefer modular separation (`rig/`, `timeline/`, `scenes/`) and specialized rendering primitives (e.g., `p5.js` + `p5.brush.js`, `Three.js`) over cramming bare geometric approximations into a single file.

---

## 10. Side-by-Side Design QA & P0/P1/P2 Blocking Iteration Loop

When verifying a rendered UI, prototype, or mockup-to-code implementation against its source visual target (approved mockup, Figma node, or reference capture):
1. **True Side-by-Side Visual Comparison**: Never treat inspecting the source design and the rendered implementation screenshot in two separate, isolated views as side-by-side QA. Compare both artifacts side-by-side (or inside a single combined composite input) at matching viewport dimensions and interaction states.
2. **Prioritized Severity Classification (`P0` / `P1` / `P2`)**: Record concrete visual discrepancies (layout drift, clipping/overflow, contrast/token mismatch, missing hierarchy, broken responsive state) by severity (`P0` blocker, `P1` major, `P2` polish).
3. **Blocking Remediation Loop**: If any actionable `P0`/`P1`/`P2` issue is found, keep Design QA in a **blocked** state, apply the fix, recapture at the same viewport/state, and re-compare side-by-side until clean. Build, dependency, lint, or preview server troubleshooting passes do NOT count as Design QA iterations.
