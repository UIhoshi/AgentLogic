# Skills, Tools, and Reference-to-Interface Routing

## Goal

Add a lean, optional reference-to-interface workflow inspired by the reviewed MengTo/Skills
repository, and make AgentLogic's required skill and tool selection procedure easier to apply.

## Requirements

1. Retain AgentLogic's existing verification and extension-trust boundaries.
2. Add a profile-shipped optional workflow for reference videos, pages, screenshots, and HTML.
3. Add a single routing matrix that maps common problem types to required evidence, the preferred
   tool family, and the matching skill when available.
4. Do not import MengTo/Skills code, scripts, demos, or its complete skill library.
5. Do not auto-install, auto-enable, or trust third-party skills.
6. Update the current logic source, profile registration, repository maps, and generated bundles.

## Acceptance Criteria

- The default `core-enhanced` profile includes the two new modules.
- The modules clearly state triggers, sequence, evidence requirements, and non-triggers.
- Existing rules still require direct reads for local facts, runtime commands for runtime claims,
  visual evidence for visual claims, and authoritative lookup for current remote facts.
- Package and logic-entry validation pass, and every generated host bundle is current.
