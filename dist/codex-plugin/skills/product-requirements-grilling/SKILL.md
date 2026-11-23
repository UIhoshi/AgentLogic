---
name: product-requirements-grilling
description: Clarify product requirements and net-new or substantially redesigned UI before specification, mockup generation, or implementation. Use for new projects, major features, new screens, substantial layout changes, bookings, payments, permissions, and other high-impact user flows. Ask one decision question at a time and produce an approved requirements brief.
---

Inspect the repository before asking about facts it can answer. Ask exactly one unresolved decision at a
 time and give a recommended answer with its trade-off. Do not ask bulk questionnaires.

For a net-new project, UI idea, or substantial UI refactor, resolve: business goal and users; core
flow; scope and non-goals; content/brand/assets; integrations and permissions; responsive,
accessibility, and performance constraints; and acceptance criteria.

Write `.specify/<task>/requirements-brief.md` using `assets/requirements-brief.md`. Mark each
decision as user-confirmed, recommended-and-accepted, or unresolved. Do not generate a mockup,
write formal UI code, or declare the specification complete until required sections are complete and
the user has approved the brief.

After approval, recommend a visual mockup and ask whether the user wants it generated. For an
existing layout the user dislikes, first obtain a current screenshot using the required visual capture
path; combine that screenshot and the user's stated dissatisfaction/change brief in the image
creation or edit request. Present the resulting mockup and wait for approval or explicit opt-out
before UI implementation.

Use `scripts/validate-requirements-brief.ps1` before mockup generation and UI implementation. If it
fails, report the missing sections and continue the one-question flow.
