# V6.8 Skill and Tool Routing

Status: **Operational router, active in enhanced profiles.**

This module answers: *given the current problem, which evidence tool and skill path are required
before an agent can close the claim?* It routes work; Modules 29–31 remain authoritative for
verification strength and anti-pattern handling.

## 1. Mandatory routing procedure

Before acting, the agent must:

1. classify the problem and the conclusion it intends to make;
2. select the required evidence tool family first;
3. select the narrowest matching available skill second;
4. confirm availability, permission posture, and external-extension trust before execution;
5. run the required post-result verification; and
6. state a downgraded result when the required tool or evidence is unavailable.

`Skill available` does not mean `tool permitted`; `tool succeeded` does not mean `claim verified`.

## 2. Problem-to-path matrix

| Problem / intended claim | Required evidence and tool path | Preferred skill when available | Closure requirement |
| --- | --- | --- | --- |
| Find where a feature, rule, or symbol lives | Local search/listing → targeted reads | `engineering/wayfinder`, `engineering/research` | Directly read the owning implementation and relevant caller/config. |
| Diagnose a bug or unexpected command failure | Reproduce/log → search/read call chain → narrow fix → command validation | Narrowest installed debugging skill; project-native error record after a material correction | Verify root cause or label as unconfirmed; record material lessons without secrets. |
| Implement/refactor behavior | Read boundary → reuse search → spec/task → bounded edit → tests/runtime | `engineering/implement`, `ponytail`, `engineering/tdd` | Match spec/task and execute relevant validation. |
| Current library, product, release, or remote setting | Authoritative external lookup | Official-doc skill/path, `openai-docs` for OpenAI products | Cite or record the live authoritative source; memory is insufficient. |
| Dynamic web flow, SPA, login, or browser interaction | Real browser interaction and capture | `playwright`; `agent-browser` only under its conditional route rule | Observe the actual flow; static reading alone cannot close it. |
| Desktop/window/OS visual state | OS-level capture | `screenshot` | Capture the actual target state. |
| UI appearance, layout, responsive fit, or interaction state | Build/run → screenshot or browser replay → boundary check | `screenshot` for desktop capture; `playwright` for browser flow | Prove visible state, containment, overflow/wrap behavior, and relevant interaction state. |
| Net-new UI, new visual asset, or approved reference-to-interface work | Requirements brief → `imagegen` mockup/edit → user approval → frontend implementation | Module 49 ordered UI routes | Do not write formal UI code before approval or explicit opt-out. |
| Animation, Canvas, or WebGL performance | Runtime profiling plus visual inspection | Browser/profiling skill when available; Module 47 | Report measured runtime scope; static code review is insufficient. |
| Security review, untrusted skill/plugin, or security-sensitive change | Targeted security audit + source/runtime evidence | `security-best-practices`, `engineering/skill-security-auditor`, `reverse-skill` when classified | Self-refute findings and retain only evidence-backed risks. |
| GitHub Actions PR-check failure | Read workflow/logs → reproduce or inspect job output | `gh-fix-ci` | Verify the affected check or explicitly state external limitation. |
| Package/install/release | Build/package → inspect artifact → confirm target → post-result check | Packaging scripts / SRA path | Validate local artifact before any remote mutation. |
| External installation or plugin/MCP enablement | Security audit → explicit user consent → scoped install → inspect result | `engineering/skill-security-auditor` | Record source, scope, version, capabilities, and trust state. |

## 3. Fallback and conflict rules

- For advisory paths outside the canonical contract, use the strongest available tool family and say which required evidence remains missing. For a matched mandatory contract route, do not downgrade: use only its primary/conditional selection rule or report the required block/partial result.
- If multiple skills match, choose the smallest scope; do not load broad libraries for one task.
- If a specialized skill conflicts with higher-priority safety, permission, SDD, or verification
  rules, the higher-priority rule wins.
- Do not create a custom replacement script when an approved, available specialized tool already
  covers the task—unless that tool cannot meet the required permission, platform, or output
  constraint.

## 4. Fast labels

Use only after the matching route: **verified**, **partially verified**, **inferred from static
read**, **needs visual confirmation**, **needs runtime confirmation**, or **needs authoritative
remote verification**.

## 5. Autonomous enforcement

For mandatory route declarations, host aliases, invocation records, strict missing-capability handling, and software-gap reporting, follow modules/49_V6_8_AutonomousSkillEnforcement.md and contracts/skill-routing.json. Code and PR audits must select the code-review route; generic static reading alone cannot close an audit claim. Module 49 and the schema-v2 contract override any older concrete skill names in this module.
