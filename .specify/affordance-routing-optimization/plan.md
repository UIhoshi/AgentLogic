# Plan — Affordance Routing and Context-Budget Optimization

## Audit finding

The V6.8.4 `core-enhanced` profile loads 47 files, approximately 281,520 characters and 6,581
lines. Several narrative tool/permission/routing modules repeat the same decision path. This
increases initial context cost and makes the operational rule less salient.

## Approach

1. Add `modules/51_V6_8_AffordanceFirstToolUse.md` as the concise operational rule:
   goal → evidence need → native tool family → optional specialized skill → closure evidence.
2. Amend Modules 48 and 49 to defer to the affordance rule and distinguish an unavailable
   specialized skill from unavailable required evidence.
3. Keep the existing default profile name, but reduce its file list to entry, source-of-truth,
   safety, verification, lifecycle, UI, shipping, and routing modules. Create a
   `governance-reference` profile carrying the prior broad list for deep policy/reference work.
4. Register the new module/profile in V6.8.4, maps, and documentation, rebuild all bundles, and
   compare profile size before/after.
5. Amend the affordance rule and routing table so project/code maps precede search and targeted
   reads, with an explicit inherited-project and owned-project maintenance path.
6. Resolve the audit findings: classify UI changes consistently, restore Module 27 to the default
   bundle, make Module 21 map-first, rewrite `CODE_MAP.md` as clean UTF-8, and add a readability
   check to the entry validator.

## Load-Bearing Assumptions / Red-Team Results

| Assumption | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| A lean default bundle improves compliance | Shorter, non-duplicative operational rules are easier to apply at task time | Removing modules omits a required safety rule | Retain the full entry chain and all core safety/verification/SDD/SRA/routing controls; preserve the prior set in `governance-reference`. |
| Outcome-first wording causes natural tool selection | Humans select a tool by the work they need done and evidence they need | The wording weakens required evidence or high-risk confirmation | Make evidence selection precede mutation and state that risk gates remain mandatory. |
| Specialized-skill fallback can be less blocking | Most ordinary tasks can be safely completed with native host tools plus matching evidence | A missing specialized skill silently downgrades a security/review/visual claim | Permit fallback only when a matching evidence tool is available; disclose the missing skill and keep explicit security/untrusted-extension, visual, browser, and other high-evidence routes blocked when their evidence is unavailable. |
| A reference profile avoids governance loss | Deep maintainers can load full narrative policy only when needed | Hosts cannot select the new profile or bundles drift | Register it in the manifest and build/verify all four host outputs for both profiles. |
| Map-first navigation prevents repeated broad reading | A maintained symbol and impact map narrows reads to the change boundary | The map is stale or treated as runtime proof | Freshness-check it against source/diff, then follow callers, callees, config, and tests before editing. |
| UI exceptions remain understandable | Small visual corrections need less ceremony while new UI needs design approval | Broad entry rules still say opt-out is the only bypass | Define the classification once and link all entry/lifecycle modules to it. |

## Design decision

The default bundle becomes an execution layer, not a complete encyclopedia. Full governance is
retained as a separately selectable reference profile. The new affordance module is normative for
the first tool choice; existing matrices remain evidence and risk authorities.
