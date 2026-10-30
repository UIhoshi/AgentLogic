---
name: ui-ux-pro-max
description: Pure UI/UX design-system intelligence, industry palette & typography reasoning, layout architecture, and mandatory text-to-image mockup prompt synthesis. Triggered automatically before any UI mockup generation or frontend code implementation.
---

# UI/UX Pro Max Design System Architect (`ui-ux-pro-max`)

This skill synthesizes the pure design intelligence of `nextlevelbuilder/ui-ux-pro-max-skill` with AgentLogic's `taste-skill` (Module 39). **It focuses strictly on UI/UX design reasoning and visual specification—NOT writing frontend code—and MUST be combined with text-to-image mockup generation before any UI code is written.**

## 1. Mandatory Activation & Hard Block Rule

Whenever the user requests a new website/app/page/component or a substantial UI redesign:
1. **Never jump to HTML/CSS/React/Vue code.**
2. **Never send a vague, generic 1-sentence prompt to the image generator.**
3. You MUST run this `ui-ux-pro-max` design reasoning pass immediately after requirements clarification (`product-requirements-grilling`) to produce a **Structured Visual Design Specification**, and then feed that exact specification into the text-to-image mockup generator (`image-generator` / `nano-banana-pro` / `multimodal-media-director`).

## 2. Step-by-Step Pure Design Reasoning Protocol

### Step 1: Domain & Aesthetic Archetype Selection
Select the primary archetype that fits the product domain (never default to generic SaaS purple/blue gradient cards):
- **Precision Swiss Editorial**: High-contrast serif/sans pairing, exposed 1px hairline grids (`#E5E5E0`), generous warm paper whitespace (`#FAF8F5`).
- **Tactile Industrial / Linear Craft**: Deep obsidian surfaces (`#0B0C0E`), subtle 1px inner specular borders (`rgba(255,255,255,0.08)`), monospace telemetry accents, crisp micro-charts.
- **Warm Organic / Hospitality Luxury**: Earthy muted clay/sage/sand HSL palettes, editorial photography framing, asymmetric Bento rhythm, fluid kinetic typography.
- **High-Density Institutional / FinTech Terminal**: Tabular-nums alignment, semantic status color coding, zero decorative fluff, split-pane workspace hierarchy.
- **Neo-Brutalist / Creative Studio**: Bold geometric blocks, high-saturation accent bursts, intentional structural tension, custom Neo-grotesque display headers.

### Step 2: Color System & HSL Token Matrix
Define exact HSL/Hex values before generating the mockup:
- **Canvas Background (Primary / Secondary / Elevated Surface)**
- **Text Hierarchy (Primary Ink / Muted Secondary / Subtle Caption)**
- **Accent & Semantic Tokens (Primary Brand Action / Secondary Highlight / Border Hairline / Success-Warn-Danger)**
- *Rule*: Avoid pure `#000000` on `#FFFFFF` harshness or muddy mid-gray text; enforce WCAG AA/AAA contrast ratios.

### Step 3: Typography Pairing & Scale
Specify exact font roles and scale ratios:
- **Display / Headline Font**: Characterful serif, editorial display, or geometric sans with tight tracking (`-0.02em` to `-0.04em`).
- **UI Body Font**: High-legibility neutral sans (`15px–16px`, line-height `1.55–1.65`).
- **Data / Metric / Code Font**: Monospace or `tabular-nums` for prices, timestamps, counters, and tables.

### Step 4: Spatial Grid, Density & Component Anatomy
Define the spatial layout architecture:
- **Viewport & Grid**: e.g., 12-column asymmetric editorial grid, 3-zone workspace (collapsible rail + primary stage + inspector), or asymmetric Bento grid (`2fr 1fr` / `1fr 1fr 1.5fr`).
- **Whitespace & Breathing Room**: Minimum 25%–35% open canvas ratio; explicit padding hierarchy (`24px` / `32px` / `48px` / `64px`).
- **Focal Point & Visual Anchor**: Define the single dominant hero visual or primary interactive focal point above the fold.

### Step 5: Mandatory Synthesis into Text-to-Image Mockup Prompt
Compile Steps 1–4 into a **Master Visual Mockup Prompt** and immediately invoke the image generation capability (`image-generator` subagent, `imagegen`, or `nano-banana-pro`):
- Include: **Device frame & aspect ratio (16:9 desktop or 9:16 mobile) + Aesthetic archetype + Exact Hex/HSL color palette + Typography hierarchy + Section-by-section spatial layout + Lighting/texture details + Explicit negative constraints (no generic AI robot icons, no gibberish text, no neon purple/cyan slop)**.
- Save the generated mockup image to `.specify/mockups/` (or artifact directory), present both the **Design Specification** and the **Visual Mockup Image** to the user, and wait for approval before writing any UI code.
