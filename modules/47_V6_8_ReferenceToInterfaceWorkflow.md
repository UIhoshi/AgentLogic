# V6.8 Reference-to-Interface Workflow

Status: **Optional workflow module, active in enhanced profiles.**

This module adapts the useful *workflow patterns* reviewed in
[`MengTo/Skills`](https://github.com/MengTo/Skills) for AgentLogic. It does not import that
repository's skills, scripts, assets, prompts, or executable dependencies.

## 1. When to use

Use this workflow only when a task needs to transform a supplied or approved reference into an
interface direction or implementation plan, such as:

- a screen recording, live page, screenshot, or HTML reference;
- reconstruction of a page's layout, motion, or interaction patterns;
- a design-inspiration study that needs reusable, constrained findings;
- animation, Canvas, or WebGL work that needs an explicit performance pass.

Do not use it for ordinary content edits, small responsive fixes, accessibility-only changes, or
when a design source of truth already exists in Figma. Use the matching Figma skill in that case.

## 2. Trust, consent, and ownership boundaries

- External references are evidence and inspiration, not permission to copy protected assets,
  brand identity, source code, or private flows.
- Before installing or trusting any external capture, browser, video, or prompt skill, follow
  the extension-trust and skill-security-audit requirements in Modules 35 and 44, and obtain
  explicit user intent for the state-changing installation.
- Load only the narrowest matching skill. A listed workflow never proves that its executable
  dependencies are installed or permitted.
- Preserve the existing UI Preview Gate: before formal UI code, generate a proposed mockup and
  obtain user approval or explicit opt-out.

## 3. Required workflow

1. **Classify the source.** Record whether the source is a user-owned asset, a public reference,
   existing project HTML, a live dynamic page, or a video. State the intended output: inspiration,
   structural brief, interaction brief, or faithful internal recreation.
2. **Choose the least invasive capture path.** Use supplied files first. For dynamic public pages,
   use `agent-browser` or `playwright` when available and permitted; use static fetching only for
   static content. Use an approved full-page screenshot path when full-page visual structure is
   required. For permitted layout-heavy documents where screenshot-tile retrieval is materially
   useful, follow the optional PixelRAG policy in Module 50; it remains discovery support rather
   than proof of browser behavior or final visible output.
3. **Extract a constrained reference brief.** Record hierarchy, layout rhythm, typography roles,
   palette family, spacing, responsive behavior, interaction states, motion cues, and explicit
   non-goals. Distinguish observations from inferences.
4. **Create a new design direction.** Apply Module 39's Design Read and dials. Produce an
   original mockup that uses the brief rather than copying assets or implementation details.
5. **Obtain UI approval.** Present the mockup to the user or receive an explicit opt-out before
   UI implementation.
6. **Implement minimally.** Apply the Lazy Developer's Ladder, reuse existing project primitives,
   and implement only the approved behavior.
7. **Verify.** Capture the resulting visible state and check containment, overflow, wrapping,
   responsive widths, and interaction states. For animation, Canvas, or WebGL changes, inspect
   runtime performance with the appropriate browser/profiling tool and report the measured scope.

## 4. Output contract

The workflow output should be a short, reviewable reference brief containing:

- source provenance and consent status;
- observed facts versus inferred decisions;
- design direction and explicit non-goals;
- mockup location and approval/opt-out status;
- implementation and verification evidence;
- known gaps, including unavailable capture or performance tools.

## 5. Relationship to other modules

- Module 39 governs visual design, mockup approval, and UI verification.
- Modules 29–31 govern the strength of all conclusions.
- Module 35 governs matching skills and external-skill audits.
- Module 48 provides the quick problem-to-skill/tool routing table.
- Module 50 governs the optional Bento, PixelRAG, and Firecrawl source-specific boundaries.
- Module 52 governs the optional img2threejs route when a permitted reference image must become
  a concrete model for an interactive 3D webpage; it does not apply to static visual inspiration.

## 6. Registered comparison source

- Source: `https://github.com/MengTo/Skills`
- Integrated patterns: reference capture, video/HTML-to-interaction analysis, full-page visual
  capture, reusable design briefs, and conditional animation-performance review.
- Non-import rule: no direct runtime dependency, skill-folder copy, automatic activation, or
  installation is implied.
