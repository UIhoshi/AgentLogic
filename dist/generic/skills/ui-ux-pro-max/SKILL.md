---
name: ui-ux-pro-max
description: Pure UI/UX design-system intelligence, industry palette & typography reasoning, layout architecture, and mandatory text-to-image mockup prompt synthesis. Triggered automatically before any UI mockup generation or frontend code implementation.
---

# UI/UX Pro Max Design System Architect (`ui-ux-pro-max`)

This skill synthesizes the pure design intelligence of `nextlevelbuilder/ui-ux-pro-max-skill` (v2.5+: 192 industry reasoning rules, 80 searchable UI styles [51 active, 29 supplemental], 192 color palettes, 74 font pairings, 119 UX guidelines, RTL compatibility, and Resilient Text & Compact UI rules) with AgentLogic's `taste-skill` 2.5.1 (Module 39). **It focuses strictly on UI/UX design reasoning and visual specification—NOT writing frontend code—and MUST be combined with text-to-image mockup generation before any UI code is written.**

## 1. Mandatory Activation & Hard Block Rule

Whenever the user requests a new website/app/page/component or a substantial UI redesign:
1. **Never jump to HTML/CSS/React/Vue code.**
2. **Never send a vague, generic 1-sentence prompt to the image generator.**
3. You MUST run this `ui-ux-pro-max` design reasoning pass immediately after requirements clarification (`product-requirements-grilling`) to produce a **Structured Visual Design Specification**, persist it using the **Master + Overrides Pattern** (`design-system/<project>/MASTER.md` + optional `design-system/<project>/pages/<page>.md`), and feed that exact specification into the text-to-image mockup generator (`image-generator` / `nano-banana-pro` / `multimodal-media-director`).

## 2. Step-by-Step Pure Design Reasoning Protocol

### Step 1: Domain Business-Kind & Aesthetic Archetype Selection
First classify the **Business Kind** (`software` / `gaming` / `tech` vs. `product` / `service` / `place` / `institutional`) and select the primary archetype across the 192 industry reasoning rules and 80 UI styles (never default to generic SaaS purple/blue gradient cards):
- **Precision Swiss Editorial**: High-contrast serif/sans pairing, exposed 1px hairline grids (`#E5E5E0`), generous warm paper whitespace (`#FAF8F5`).
- **Tactile Industrial / Linear Craft**: Deep obsidian surfaces (`#0B0C0E`), subtle 1px inner specular borders (`rgba(255,255,255,0.08)`), monospace telemetry accents, crisp micro-charts.
- **Warm Organic / Hospitality Luxury**: Earthy muted clay/sage/sand HSL palettes, real editorial photography framing, asymmetric Bento rhythm, fluid kinetic typography.
- **High-Density Institutional / FinTech Terminal**: Tabular-nums alignment, semantic status color coding, zero decorative fluff, split-pane workspace hierarchy.
- **Neo-Brutalist / Creative Studio**: Bold geometric blocks, high-saturation accent bursts, intentional structural tension, custom Neo-grotesque display headers.
- *Business-Kind Media Rule (`tasteskill 2.5.1`)*: Shader effects, WebGL canvases, and code/telemetry scenes belong **only** on `software`, `gaming`, and `tech` pages; `product`, `service`, and `place` pages use real photography and clean editorial surfaces.

### Step 2: Color System & HSL Token Matrix (192 Industry Palettes)
Define exact HSL/Hex values before generating the mockup:
- **Canvas Background (Primary / Secondary / Elevated Surface)**
- **Text Hierarchy (Primary Ink / Muted Secondary / Subtle Caption)**
- **Accent & Semantic Tokens (Primary Brand Action / Secondary Highlight / Border Hairline / Success-Warn-Danger)**
- *Rule*: Avoid pure `#000000` on `#FFFFFF` harshness or muddy mid-gray text; enforce WCAG AA/AAA contrast ratios.

### Step 3: Typography Pairing, Scale & Resilient Text Rules (74 Font Pairings)
Specify exact font roles, scale ratios, and resilient text behavior:
- **Display / Headline Font**: Characterful serif, editorial display, or geometric sans with tight tracking (`-0.02em` to `-0.04em`) and progressive-enhancement `text-wrap: balance` (headings `<= 6` lines).
- **UI Body Font**: High-legibility neutral sans (`15px–16px`, line-height `1.55–1.65`) with `text-wrap: pretty` and `overflow-wrap: break-word` for user-generated or dynamic strings.
- **Data / Metric / Code Font**: Monospace or `tabular-nums` for prices, timestamps, counters, and tables.
- **RTL & BiDi Readiness**: When targeting multilingual or Arabic/Hebrew/Persian audiences, evaluate style RTL compatibility (`full`, `partial`, or `caveats`) and enforce logical CSS properties (`margin-inline`, `padding-inline`, `inset-inline`).

### Step 4: Spatial Grid, One-Section-Per-Screen Rhythm & Compact UI Rules
Define the spatial layout architecture:
- **Viewport & Grid**: e.g., 12-column asymmetric editorial grid, 3-zone workspace (collapsible rail + primary stage + inspector), or asymmetric Bento grid (`2fr 1fr` / `1fr 1fr 1.5fr`), enforcing equal container edges and **one coherent section per viewport height** on narrative/landing pages.
- **Whitespace & Breathing Room**: Minimum 25%–35% open canvas ratio; explicit padding hierarchy (`24px` / `32px` / `48px` / `64px`).
- **Compact UI & Overflow Discipline**: Cap visible tags/chips/badges in cards (`+n` disclosure for overflow), ensure `>= 44x44px` interactive tap targets on mobile (`320px` and `390px` viewports), and prevent rapid-interaction state corruption during async transitions.
- **Master + Overrides Persistence**: Record global tokens in `design-system/<project>/MASTER.md` (or `.specify/<task>/design-spec.md`) and page-specific deviations in `design-system/<project>/pages/<page>.md`.

### Step 5: Mandatory Synthesis into Text-to-Image Mockup Prompt
Compile Steps 1–4 into a **Master Visual Mockup Prompt** and immediately invoke the image generation capability (`image-generator` subagent, `imagegen`, or `nano-banana-pro`):
- Include: **Device frame & aspect ratio (16:9 desktop or 9:16 mobile) + Business kind & aesthetic archetype + Exact Hex/HSL color palette + Typography hierarchy + Section-by-section spatial layout + Lighting/texture details + Explicit negative constraints (no generic AI robot icons, no gibberish text, no neon purple/cyan slop, no 3-equal-card SaaS clichés)**.
- Save the generated mockup image to `.specify/mockups/` (or artifact directory), present both the **Design Specification** and the **Visual Mockup Image** to the user, and wait for approval before writing any UI code.
