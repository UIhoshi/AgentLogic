# Plan: AgentLogic UI Template Library

## Architecture

Create a static `templates/frontend/` asset layer. `foundation.css` is the sole source for design
tokens and reusable primitives. Each HTML file is deliberately standalone in content and imports
only that local stylesheet. The README is the entrypoint and defines the adaptation workflow.

## Template Set

1. **Editorial landing** — asymmetrical hero, proof strip, feature grid, and CTA.
2. **Analytics dashboard** — sidebar, KPI cards, chart-like data region, and responsive stacking.
3. **Settings surface** — navigable settings sections, semantic forms, and safe destructive-action
   presentation.

## Implementation Decisions

- Use a neutral ink/ivory/moss/cobalt token system from the approved preview, with CSS variables so
  project branding replaces tokens rather than markup.
- Use inline text glyphs only where a visual marker is necessary; no SVG, image, font, or external
  asset is copied or fetched.
- Prefer CSS grid, flexbox, native form controls, and media queries over dependencies.

## Red-Team Results

| Rank | Fails if | Mitigation / test |
| --- | --- | --- |
| 1 | a template causes narrow-view overflow | Use `minmax(0, ...)`, responsive breakpoints, and inspect for fixed-width content. |
| 2 | copied visual code or assets create license risk | Write original markup/CSS; permit no remote URLs or bundled media. |
| 3 | a visual starter becomes a generic, inaccessible shell | Include semantic regions, labels, focus-visible styling, and usage warnings. |
| 4 | templates bloat the host bundle | Keep them as local repository assets; do not add them to runtime profile file lists. |

No architectural assumption remains unmitigated: the files are static, isolated, and are validated
as a local reference library rather than a host runtime dependency.
