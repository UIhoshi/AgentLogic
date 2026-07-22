# Plan — Skills, Tools, and Reference-to-Interface Routing

## Approach

1. Add `modules/47_V6_8_ReferenceToInterfaceWorkflow.md` as an optional, external-source
   workflow. It will cover reference capture, structured extraction, mockup approval, targeted
   implementation, visual verification, and animation-performance checks.
2. Add `modules/48_V6_8_SkillAndToolRouting.md` as the operational decision table. It will
   make the existing Modules 21, 24, 25, 29–31, and 35 easier to execute without weakening them.
3. Cross-link the routing rules from the current skill-governance and frontend modules.
4. Register both modules in the V6.8.2 source, manifest profiles, repository/project maps, and
   rebuild all host bundles.

## Load-Bearing Assumptions / Red-Team Results

| Assumption | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| One routing module improves compliance | A single matrix lowers lookup cost while retaining the normative modules | It duplicates or conflicts with existing matrices | Define it as a router and retain existing modules as authoritative evidence policy; validate links and wording. |
| The external workflow is useful without importing the repository | The source has reusable procedural patterns for capture and extraction | It silently implies installed tools or third-party trust | Mark it optional/external, enumerate preconditions, and require security audit plus explicit consent before installation. |
| Default profile inclusion remains lean | Two concise policy modules improve routing more than they increase prompt cost | The modules grow into an imported skill library | Include only workflow contracts and pointers; no demos, assets, or specific effect recipes. |

## Design Decision

Use two modules rather than modifying the existing verification matrix: reference-to-interface
has a distinct lifecycle, while routing is a cross-cutting operational aid. The verification
matrix remains the final authority on proof strength.
