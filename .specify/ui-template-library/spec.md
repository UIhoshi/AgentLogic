# Specification: AgentLogic UI Template Library

## Goal

Provide a small, unbranded, local frontend template library that complements Taste. It must give
future UI work dependable structural and visual starting points without importing Open Design or
any third-party visual assets.

## Scope

- Add three responsive, standalone HTML examples: editorial landing page, analytics dashboard,
  and settings surface.
- Add one shared CSS foundation containing tokens, components, responsive rules, focus states, and
  reduced-motion handling.
- Add a concise usage guide that explains selection, copying, branding, verification, and the
  no-third-party-assets rule.

## Constraints

- All copy, brand names, icons, and data must be generic and replaceable.
- Do not copy Open Design code, images, fonts, logos, or proprietary-looking assets.
- No build tool, runtime dependency, JavaScript, remote font, or CDN may be required.
- Templates must be useful as references and starting points, not treated as completed product UI.
- Each template must use semantic landmarks and visible keyboard focus styles.

## Acceptance Criteria

1. `templates/frontend/README.md` explains how the library relates to Taste and how to use it.
2. All three HTML files share `foundation.css` and work when opened locally.
3. The layouts adapt at narrow widths without horizontal scrolling by design.
4. The assets are original, unbranded, and contain no network references.
5. Template structure and links pass repository/package validation where applicable.
