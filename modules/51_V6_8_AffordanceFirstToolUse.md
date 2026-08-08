# Affordance-First Tool Use

Status: **Normative execution rule for enhanced profiles.**

## 1. Natural operating model

Choose tools the way a person chooses a pen, brush, ruler, or calculator: start with the work to
be done, then pick the tool whose native function produces the needed result. Do not begin every
task by asking abstractly which tool to use, and do not use a generic tool when a closer native
tool is already available and permitted.

The compact loop is:

```text
intent → evidence or artifact needed → native tool family → optional specialist → verify result
```

Safety and evidence gates remain part of the loop rather than a second, unrelated procedure.

## 2. Outcome-to-tool reflexes

| When the work is to… | Naturally use… | Close it with… |
| --- | --- | --- |
| take over an unfamiliar project | `PROJECT_MAP.md` and `CODE_MAP.md`, then freshness-checked source | a validated entry/module/symbol/impact map before implementation |
| find where code, a rule, or a file lives | the current code map first; local search only to fill or refresh a missing map entry | a direct read of the mapped owner and relevant boundary |
| understand or modify an existing behavior | the mapped flow, then only its callers, callees, state/config, and tests | an explicit impact path before editing |
| write or change a known local artifact | bounded edit/write tool | the matching test, build, or runtime evidence |
| prove behavior runs | test, build, command, or runtime tool | inspected command/result output |
| see a UI, layout, screenshot, or visual document | screenshot or real browser capture | visual evidence plus containment/overflow checks |
| build an interactive 3D webpage | native Three.js/frontend path; use img2threejs only for approved reference-image model reconstruction | browser/runtime, visual, containment, performance, and accessibility evidence |
| learn a current external fact | authoritative live source | source-linked current evidence |
| inspect a live browser flow | browser automation | fresh observation/captured artifact |
| collect a bounded public-web corpus | scoped collection tool | preserved URLs, data-boundary review, and claim-specific evidence |
| publish, install, delete, or change remote state | target confirmation before mutation | post-result inspection |

The table describes the default reflex, not a permission bypass. A visible tool must still be
available, allowed, and suitable for the current runtime.

## 3. Map before search, and maintain the map

For an inherited project, do not begin by repeatedly searching and reading random files. First run
the project freshness check, read `PROJECT_MAP.md` and `CODE_MAP.md`, and compare the relevant
entries with the current source and diff. If a map is missing or stale, create or repair the
smallest useful map before implementation:

```text
entrypoint → module boundary → key function/class → state/interface → callers/callees → validation
```

For a project being built or owned, establish that map from the first implementation flow. Keep
`PROJECT_MAP.md` current when structure, boundaries, dependencies, or validation change; keep
`CODE_MAP.md` current when a key symbol, flow, state/store, interface/event, or validation path
changes. Before a modification, consult the map to identify likely impact, then validate only the
necessary source chain. After the modification, update the same map so the next change does not
start from repository-wide discovery again.

Maps accelerate navigation; they are not runtime proof. The final change still follows the
matching evidence route.

## 4. Skills are specialist tools, not ceremony

Use a specialized skill when it is installed and materially improves the matched task: for example,
a requirements-grilling skill for major discovery, browser automation for a live browser flow, or
a review/security specialty for a requested review. Do not load broad skill libraries merely
because a task mentions a related word.

If a specialist is unavailable but the route's required evidence tool is available, proceed with
the native tool path when the route allows it. Record the unavailable specialization and never
claim the skill was used. If the required evidence itself is unavailable, the corresponding
verified claim remains blocked. Explicitly strict routes—untrusted-extension security, required
UI mockup generation, and requested specialized security/code review—remain strict.

## 5. Friction proportionality

- Map and refresh naturally before changing unknown code; search is for filling a known map gap,
  not for rediscovering the whole project every round.
- Verify naturally after an implementation or claim; do not create a separate ritual for obvious
  tool selection.
- Add confirmation only where risk rises: destructive/local side effects, credentials, data
  egress, external state, installation, release, and trust changes.
- Prefer the smallest tool that produces the correct evidence. Escalate only when the first tool
  cannot close the question.

Modules 29–31 define evidence strength, Module 27 defines risk gates, and Modules 48–49 define
the registered specialist routes. This module governs the first practical choice among them.
