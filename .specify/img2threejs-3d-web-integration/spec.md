# img2threejs 3D Web Integration

## Goal

Add an optional, policy-only route for building interactive 3D web experiences. The route uses
img2threejs only when a user needs a concrete Three.js model generated or reconstructed from a
reference image; it does not install, copy, execute, or trust the external skill.

## Requirements

1. Define the 3D-web trigger precisely: a user requests a web experience with an operable 3D object
   or scene, such as rotation, dragging, zooming, camera orbit, 3D presentation, or model animation.
2. Require img2threejs only when that request also needs a specific model to be generated or
   reconstructed from a supplied or approved reference image.
3. Keep static "3D-feel" visuals, CSS perspective effects, and abstract primitive scenes outside the
   img2threejs route; use the ordinary UI/imagegen or standard Three.js route instead.
4. Preserve the UI approval gate, visual evidence, layout containment, accessibility/reduced-motion,
   lazy loading, performance, and browser-runtime verification requirements.
5. Record img2threejs as a pinned, review-required source candidate. Do not imply installation,
   execution permission, trust, or security-audit completion.
6. Register the new policy in the active profile, current stable source, routing/reference docs,
   software candidates, and repository maps; rebuild generated bundles.
7. Do not publish, push, install, clone, or enable external code.

## Acceptance Criteria

- The policy differentiates static 2D mockups, generic interactive 3D, and reference-image-based
  3D model reconstruction.
- The precise trigger and non-trigger examples appear in the route owner and routing guidance.
- The source is recorded as `img2threejs/img2threejs` at main commit
  `d6673386f89673a58736f8d398dd16ece67874f5` (observed 2026-08-08) and is explicitly review-required.
- All four default host bundles are regenerated and entry, package, and maintainer checks pass.
