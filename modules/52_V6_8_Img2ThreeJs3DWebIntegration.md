# V6.8 img2threejs Interactive 3D Web Integration

Status: **Optional source-specific policy, active in enhanced profiles.**

This module registers patterns reviewed from
[`img2threejs/img2threejs`](https://github.com/img2threejs/img2threejs). It imports no source,
Python script, model asset, dependency, browser extension, MCP server, or host skill. Discovery of
the repository does not establish installation, permission, trust, or security-audit completion.

## 1. Purpose and boundaries

Use this policy for web work that includes an operable three-dimensional object or scene. Its
purpose is to distinguish ordinary visual design from interactive 3D implementation, and to invoke
img2threejs only when a reference image must become a concrete procedural Three.js model.

The source may generate TypeScript/Three.js factories from a supplied image through a staged,
quality-gated reconstruction workflow. It is not a general replacement for image generation, CSS
perspective effects, normal frontend work, or a generic Three.js scene authoring workflow.

## 2. Trigger decision

Apply the following decision tree before selecting a tool:

| User outcome | Route | img2threejs status |
| --- | --- | --- |
| A static webpage visual, including a "3D-feel" composition | UI mockup / `imagegen` route | Do not use. |
| A webpage with an operable 3D object or scene—rotation, dragging, zooming, camera orbit, 3D presentation, or model animation—but no source-image reconstruction requirement | Standard Three.js / frontend route | Do not use by default. |
| The same operable 3D experience **and** a request to generate or reconstruct a concrete model from a supplied or approved reference image | Interactive 3D web route plus img2threejs candidate | Consider only after the trust and consent gates below. |

Do not treat the words "3D", "effect image", "depth", "parallax", or "three-dimensional
style" by themselves as an img2threejs trigger. Clarify the intended interaction and whether a
specific reference-based model is required when that distinction remains ambiguous.

## 3. Required route

For the reference-based interactive 3D route:

1. Complete the applicable requirements, specification, and UI approval gates before formal UI
   implementation. A page composition mockup remains a separate artifact from the 3D model.
2. Confirm the reference provenance, the user's right to use it, the intended model purpose, and
   the project Three.js/runtime constraints.
3. Before installing, cloning, enabling, or executing img2threejs, pin an exact reviewed commit,
   obtain explicit user consent, and complete the external-skill security-audit route. Until then,
   report the capability as unavailable and use only a permitted native alternative.
4. If it is approved and installed in a target project, follow its staged model-specification,
   pass-gated generation, and reference-comparison workflow. Record uncertainty from hidden or
   unobserved geometry instead of presenting inferred details as measured fact.
5. Integrate the resulting model into the actual webpage with bounded loading and lifecycle cleanup.
   Do not let a model-review render substitute for integration evidence.
6. Verify the delivered page with the matching browser/runtime and visual paths: actual controls,
   model readiness, viewport containment, responsive fit, lazy-load/fallback behavior, performance
   scope, keyboard/accessibility support, and `prefers-reduced-motion` behavior where motion exists.

## 4. Safety, trust, and performance

- The image/model source, generated artifacts, and any hosted analysis path remain subject to the
  user’s data-rights and data-egress constraints.
- A third-party skill is `discovered` until it is separately enabled, trusted, and verified under
  Module 44. It is not trusted merely because this policy names it.
- Do not add a 3D runtime to a page solely for decoration. Prefer CSS or existing primitives for
  non-interactive depth effects; lazy-load the 3D route when it is needed and provide graceful
  non-WebGL, loading, and reduced-motion fallbacks.
- img2threejs review screenshots show model fidelity only. Final visible claims still require the
  project page’s actual browser capture and containment checks under Modules 29, 39, 47, and 51.

## 5. Registered comparison source

- Source: `https://github.com/img2threejs/img2threejs`
- Observed branch and pin: `main` at `d6673386f89673a58736f8d398dd16ece67874f5` on 2026-08-08.
- Declared upstream license: Apache-2.0; compatibility and repository contents still require the
  applicable review before any import or installation.
- Integrated patterns: reference-image model reconstruction, explicit staged quality gates,
  uncertainty reporting, and reference-versus-render review.
- Non-import rule: no source checkout, executable dependency, host installation, or automatic
  activation is included in AgentLogic.

## 6. Relationship to other modules

- Module 39 remains the authority for UI direction, mockup approval, and visual verification.
- Module 47 governs source provenance and permitted references before interface work.
- Module 48 selects the evidence/tool path, and Module 49 retains strict external-extension audit
  and availability requirements.
- Module 51 governs the natural routing distinction: mockup first for static visuals, native
  Three.js for generic interaction, and img2threejs only for approved reference-model reconstruction.
