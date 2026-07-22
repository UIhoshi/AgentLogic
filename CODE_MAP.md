# Code Map

## Key flows

| Flow | Source of truth | Validation |
| --- | --- | --- |
| Profile compilation | `manifest.json` â†’ `scripts/build-profile.ps1` â†’ `dist/` | `scripts/validate-package.ps1` and bundle verification |
| Entry enforcement | entry documents + `modules/15_LogicEntryChecklist.md` | `node scripts/check-logic-entry.js` |
| Skill/tool selection | Modules 21, 24â€“25, 29â€“31, 35, and 48 | targeted evidence required by Module 29 |
| Reference-to-interface work | Modules 39 and 47 | user-approved mockup plus visual/runtime evidence |

## Interfaces and state

- `manifest.json` is the profile and host-output interface.
- `modules/47_V6_8_ReferenceToInterfaceWorkflow.md` defines the optional reference-workflow
  contract; it imports no external runtime dependency.
- `modules/48_V6_8_SkillAndToolRouting.md` defines the problem-to-evidence/skill routing aid.

| Autonomous skill enforcement | contracts/skill-routing.json â†’ Module 49 â†’ scripts/validate-skill-routing.ps1 | registry validator + package validation |

| Product/UI requirements | `product-requirements-grilling` skill ¡ú `.specify/<task>/requirements-brief.md` ¡ú `validate-requirements-brief.ps1` ¡ú image/UI route | brief approval/content validation; mockup decision required |
