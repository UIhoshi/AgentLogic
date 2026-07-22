# Code Map

## Key flows

| Flow | Source of truth | Validation |
| --- | --- | --- |
| Profile compilation | `manifest.json` → `scripts/build-profile.ps1` → `dist/` | `scripts/validate-package.ps1` and bundle verification |
| Entry enforcement | entry documents + `modules/15_LogicEntryChecklist.md` | `node scripts/check-logic-entry.js` |
| Skill/tool selection | Modules 21, 24–25, 29–31, 35, and 48 | targeted evidence required by Module 29 |
| Reference-to-interface work | Modules 39 and 47 | user-approved mockup plus visual/runtime evidence |

## Interfaces and state

- `manifest.json` is the profile and host-output interface.
- `modules/47_V6_8_ReferenceToInterfaceWorkflow.md` defines the optional reference-workflow
  contract; it imports no external runtime dependency.
- `modules/48_V6_8_SkillAndToolRouting.md` defines the problem-to-evidence/skill routing aid.
