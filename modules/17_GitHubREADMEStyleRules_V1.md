# GitHub README Style Rules V1

This file defines the default presentation rules for GitHub-facing `README.md` files that use the repository template.

## Purpose

- Keep repository homepages visually structured across different projects.
- Reduce README drift between repositories.
- Allow project-specific variation without losing the same overall page rhythm.

## Relationship To The Template

- `16_GitHubREADMETemplate_V1.md` defines the content structure.
- This file defines the presentation structure.
- Future projects should use both:
  - template for section selection and wording baseline
  - style rules for layout rhythm and visual consistency

## Design Goal

The goal is not pixel-level uniformity.

The goal is:

- similar first-screen structure
- similar information rhythm
- similar preview-section treatment
- similar technical summary treatment
- similar lower-page developer section treatment

Projects may differ in screenshots, copy tone, or section emphasis, but should not feel structurally unrelated.

## Constraint Levels

This file uses three levels:

- `Default Required`: should be treated as the normal baseline
- `Conditional Required`: must be used when the condition is met
- `Recommended`: preferred when it improves the repository homepage

## What To Keep From The Grok Draft

The following ideas are worth keeping:

- centered hero opening
- clear one-line positioning under the title
- multilingual links near the top when real files exist
- a visually strong preview section
- a compact “at a glance” summary table
- a technical implementation section lower on the page
- a short development command block near the lower half

## What To Avoid Or Soften

The following parts should not become hard requirements:

- inline HTML color styling such as `<span style="color:#0066ff;">...`
- forcing the exact same centered layout in every repository
- forcing every repository to have screenshots or GIFs
- forcing every repository to have emoji in the title
- forcing every repository to expose development commands high on the page

## Why The Grok Draft Needs Adjustment

- GitHub Markdown rendering does not reliably support all inline style expectations.
- Colored text in titles is fragile and not necessary for strong hierarchy.
- Some repositories are product-facing, while others are libraries or backend services.
- A single visual recipe should guide structure, not freeze all projects into one look.

## Default Visual Structure

The default README should follow this presentation rhythm:

1. Hero
2. Preview or proof section
3. Problem/value section
4. Quick start
5. At-a-glance summary
6. Core features
7. Technical implementation
8. Development or build commands
9. Contribution / support
10. License

Projects may merge adjacent sections, but should not scramble the top-half flow casually.

## Section Order Rigidity Rules

Structural consistency depends not only on which sections exist, but also on which sections are allowed to move.

### Top-Half Locked Order

The following top-half sequence should be treated as locked by default:

1. Hero
2. Preview or proof
3. Value or pain-point section
4. Quick start
5. At-a-glance summary

Rules:

- `Default Required`: do not move technical implementation above value or quick start in product-style repositories.
- `Default Required`: do not push quick start below large technical sections.
- `Conditional Required`: for developer-style repositories, install and usage may move above preview, but hero and first runnable path should still remain near the top.
- `Conditional Required`: if a repository has no preview section, the proof replacement section should occupy the same slot rather than shifting the whole rhythm.

### Lower-Half Flexible Order

The following lower-half sections may swap when it improves clarity:

- core features
- technical implementation
- repository layout
- development commands
- FAQ
- roadmap
- version evolution
- contribution
- license

Rules:

- Lower-half reordering is allowed only if the top-half rhythm remains intact.
- Do not use lower-half flexibility as an excuse to move the whole README into a developer-doc order for product repositories.

## Hero Rules

Recommended default:

```md
<div align="center">

# [OPTIONAL_EMOJI] [PROJECT_NAME]

**[ONE_LINE_POSITIONING]**

[English](./README.md) | [简体中文](./README.zh-CN.md) | [日本語](./README.ja.md)

</div>
```

Rules:

- `Default Required`: use a centered hero by default.
- `Conditional Required`: if the repository is clearly developer-first and has little benefit from a product-style landing page, a left-aligned hero is allowed.
- `Default Required`: keep the project title and one-line positioning in the hero area.
- Use emoji only when it improves recognition and does not look gimmicky.
- Remove multilingual links if the files do not exist.
- Do not rely on inline color styling as a required pattern.

## Preview Section Rules

For visual products, the preview section should appear early.

Recommended pattern:

```md
## Product Preview

<div align="center">

![Main UI](./screenshots/main.png)
**Main interface**

![Demo](./screenshots/demo.gif)
**Core workflow demo**

</div>
```

Rules:

- `Conditional Required`: if the project is visual, interactive, or workflow-driven, add a preview or proof section in the top half of the README.
- `Conditional Required`: if screenshots or GIFs do not exist yet, replace `Product Preview` with `Product Proof`, `Usage Proof`, or another truthful proof section instead of faking visuals.
- Use 1 to 3 preview assets by default.
- Use 1 GIF at most unless the product truly needs more.
- Do not overload the first half of the README with too many images.
- Prefer captions under images when the visual needs explanation.
- For non-visual projects, replace this section with usage proof, architecture, API example, or benchmark summary.

## Value Section Rules

- Keep the “what problem does this solve” section above deep technical details.
- Prefer 3 to 5 bullets.
- Bold the pain-point label if it improves scanning.
- Do not write generic marketing fluff without operational detail.

Recommended pattern:

```md
## ✨ What does this help with?

- **Pain point 1**: [specific problem and how the project helps]
- **Pain point 2**: [specific problem and how the project helps]
- **Pain point 3**: [specific problem and how the project helps]
```

## Quick Start Rules

- Quick start must remain short and executable.
- Keep it within 3 to 5 steps by default.
- `Default Required`: quick start or usage must appear in the upper half of the README.
- If a release link is not confirmed, use source setup instead.
- Important warnings should be placed directly below quick start, not buried later.
- `Conditional Required`: if the project has multiple real usage paths, structure `Quick Start` as a short multi-entry section instead of forcing a single path.
- Preferred order for product repositories:
  - release/install path
  - local source/runtime path
  - browser-only, fallback, or advanced path
- Do not let developer setup crowd out the normal user install path on product-style repositories.

## At-A-Glance Table Rules

This is worth standardizing because it reduces README drift well.

Recommended pattern:

```md
## At a Glance

<div align="center">

| Topic | Summary |
|-------|---------|
| Runtime | [RUNTIME_SUMMARY] |
| Deployment | [DEPLOYMENT_SUMMARY] |
| Focus | [PROJECT_FOCUS] |
| Documentation | [DOCS_LOCATION] |

</div>
```

Rules:

- `Default Required`: include an `At a Glance` summary table or an equivalent compact summary block.
- Keep 3 to 5 rows by default.
- Use this table for fast scanning, not detailed explanation.
- `Conditional Required`: for product-style repositories, this section should remain visually compact and easy to scan.
- `Conditional Required`: for very small libraries or micro-tools, an equivalent short summary block may replace the table, but omission should be rare.

## Badge Rules

Badges are worth standardizing because they create a stable visual strip under the hero.

Recommended default:

```md
<div align="center">

[![Release](https://img.shields.io/badge/release-v1.0.0-blue)]([RELEASE_URL])
[![License](https://img.shields.io/badge/license-MIT-green)]([LICENSE_URL])
[![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)]([PLATFORM_URL])

</div>
```

Rules:

- `Default Required`: place badges directly below the hero when the repository has meaningful badge data.
- `Default Required`: use 3 to 5 badges by default.
- `Default Required`: do not exceed 6 badges unless the repository has a very strong reason.
- `Conditional Required`: if there is no real data for a badge, omit it instead of inventing one.
- Good default badge categories:
  - release or version
  - license
  - platform
  - build status
  - stars
- Avoid vanity badges that do not help a reader decide whether to use the project.

## Badge Presets By Project Type

These presets are intended to reduce badge drift across repositories.

### Product-Style Repository Preset

Default priority:

- release or version
- license
- platform
- build status
- stars

Good fit:

- desktop apps
- web apps
- user-facing tools

Recommended pattern:

```md
<div align="center">

[![Release](https://img.shields.io/badge/release-[VERSION]-blue)]([RELEASE_URL])
[![License](https://img.shields.io/badge/license-[LICENSE]-green)]([LICENSE_URL])
[![Platform](https://img.shields.io/badge/platform-[PLATFORM]-lightgrey)]([PLATFORM_URL])
[![Build](https://img.shields.io/badge/build-passing-brightgreen)]([BUILD_URL])
[![Stars](https://img.shields.io/github/stars/[OWNER]/[REPO]?style=flat)]([STARS_URL])

</div>
```

### Developer-Style Repository Preset

Default priority:

- package version or release
- license
- build status
- language or runtime
- test coverage or docs status

Good fit:

- SDKs
- libraries
- CLI tools
- backend services

Recommended pattern:

```md
<div align="center">

[![Version](https://img.shields.io/badge/version-[VERSION]-blue)]([RELEASE_URL])
[![License](https://img.shields.io/badge/license-[LICENSE]-green)]([LICENSE_URL])
[![Build](https://img.shields.io/badge/build-passing-brightgreen)]([BUILD_URL])
[![Runtime](https://img.shields.io/badge/runtime-[RUNTIME]-informational)]([RUNTIME_URL])
[![Docs](https://img.shields.io/badge/docs-available-blueviolet)]([DOCS_URL])

</div>
```

### Minimal Repository Preset

Use when the repository is too small to justify a full badge strip.

Default priority:

- license
- version or release
- build status

Recommended pattern:

```md
<div align="center">

[![License](https://img.shields.io/badge/license-[LICENSE]-green)]([LICENSE_URL])
[![Version](https://img.shields.io/badge/version-[VERSION]-blue)]([RELEASE_URL])
[![Build](https://img.shields.io/badge/build-passing-brightgreen)]([BUILD_URL])

</div>
```

## Badge Selection Guardrails

- Prefer one badge per decision signal.
- Do not add multiple badges that communicate nearly the same thing.
- If a project is pre-release and has no stable version, use a truthful pre-release label rather than a fake stable version.
- If the repository has no CI, omit build badges.
- If the repository has no external docs, omit docs badges.
- If stars are too low to add signal, stars may be omitted without penalty.

## Badge Priority Matrix

Use this matrix when deciding which badges survive if the repository has too many possible badges.

### Product-Style Badge Order

Keep in this order:

1. release or version
2. license
3. platform
4. build status
5. stars
6. docs or website status

Rules:

- The first row should usually stop at 5 badges.
- A sixth badge is allowed only when it adds real reader decision value.
- If the repository has no releases yet, use a truthful pre-release or status badge instead of inventing a release badge.

### Developer-Style Badge Order

Keep in this order:

1. package version or release
2. license
3. build status
4. runtime or language
5. test coverage or docs status
6. package registry badge

Rules:

- Prefer build and runtime signal over stars for developer-first repositories.
- Coverage badges are optional and should be omitted if they are noisy, stale, or misleading.

### Minimal Badge Order

Keep in this order:

1. license
2. version or release
3. build status

Rules:

- If one of these signals is unavailable, do not replace it with vanity badges.
- Minimal repositories should favor fewer badges over weaker badges.

## Screenshot Asset Rules

Visual consistency across repositories should also come from screenshot structure, not only section order.

Recommended default directory:

- `screenshots/`

Recommended default filenames:

- `main.png` for the primary static hero screenshot
- `demo.gif` for the primary workflow animation
- `usage.png` for a real usage or secondary UI view
- `feature-01.png`, `feature-02.png`, `feature-03.png` for additional supporting stills

Rules:

- `Default Required`: use repository-relative screenshot paths such as `./screenshots/main.png`.
- `Default Required`: keep README assets inside `screenshots/` unless the project has a stronger established asset convention.
- `Default Required`: prefer lowercase kebab-case or simple lowercase filenames.
- `Default Required`: avoid spaces, dates, random export names, and machine-generated screenshot names in committed README assets.
- `Conditional Required`: for product-style repositories, the first screenshot should usually be a stable main UI or main workflow image.
- `Conditional Required`: if a GIF exists, keep a single primary GIF by default and avoid stacking many animations.
- `Recommended`: keep static screenshots in `.png` unless there is a strong reason to use another format.
- `Recommended`: use captions in the README when an image needs context.

## Screenshot Naming Guardrails

Avoid names like:

- `Screenshot 2026-04-17 at 10.22.44.png`
- `image (12).png`
- `final-final-demo.gif`

Prefer names like:

- `main.png`
- `demo.gif`
- `usage.png`
- `feature-01.png`

## Screenshot Layout Guardrails

- Do not place more than 3 visual assets in the top-half preview block by default.
- Prefer one strong main screenshot plus one GIF or one supporting screenshot.
- If a project needs more visual proof, move extra screenshots lower or into dedicated docs.

## Technical Section Rules

- Put technical implementation below the product/value half.
- Use short lists and one small repository-layout table.
- Do not let this section become a full architecture manual.

## Development Command Rules

Recommended pattern:

```bash
npm install
npm run dev
npm run build
```

Rules:

- Keep the command block short.
- Include only confirmed commands.
- Put long build or release procedures in `docs/` if necessary.

## Two Default Style Modes

### Product Style

Best for:

- desktop apps
- web apps
- end-user tools

Recommended traits:

- centered hero
- badge strip below the hero
- preview section early
- value proposition before technical details
- quick start oriented around using the product
- `At a Glance` table kept as a stable mid-page anchor
- optional lightweight `Version Evolution` section in the lower half when release maturity matters
- FAQ, roadmap, and demo video used only when they materially improve product understanding

### Developer Style

Best for:

- SDKs
- libraries
- CLI tools
- backend services

Recommended traits:

- centered hero still allowed, but left alignment is acceptable when product-style framing would feel artificial
- a smaller or more restrained preview section
- install and usage higher
- screenshots optional
- examples and technical summary earlier
- version-history detail may replace product-oriented evolution storytelling when the repository is primarily developer-facing

## Style Selection Rules

Use `Product Style` when most of the following are true:

- the project has a GUI
- screenshots or GIFs materially improve understanding
- the project is distributed as an app, packaged tool, or user-facing workflow
- the repository homepage should sell product value quickly
- the normal reader should understand how to use the product before reading technical details

Use `Developer Style` when most of the following are true:

- the project is mainly an SDK, library, CLI, API, or backend service
- the main reader is a developer
- installation and usage matter more than screenshots
- visual product proof is secondary to code examples or integration examples
- the README should optimize for implementation clarity over product landing-page impact

Tie-break rule:

- if a repository is mixed and also needs strong public presentation, default to `Product Style`
- then pull installation, examples, or developer commands slightly higher without abandoning the overall structure

## Version Evolution Section Rules

- `Conditional Required`: include a lightweight `Version Evolution`, `How It Evolved`, or equivalent section when the repository has meaningful product-stage progression and that history helps users understand the current release.
- Keep this section in the lower half of the README.
- Keep it short, usually 3 to 5 bullets.
- Use milestone framing, not a full changelog.
- If a detailed changelog or release-notes document already exists, this section should summarize rather than duplicate it.

## Structural Consistency Rule

Across repositories, the style does not need to be identical.

But the following should stay broadly consistent:

- recognizable hero section
- early value explanation
- early quick-start or usage path
- compact summary block or equivalent
- technical details in the lower half

This is the minimum structural consistency target.

## README Density By Repository Maturity

Repositories at different maturity levels should not all carry the same README density.

The structure skeleton should remain recognizable, but the amount of detail should scale with maturity.

### Early / New Repository

Best fit:

- first public push
- early alpha
- still validating scope

Density rules:

- keep the README lean
- keep optional sections to a minimum
- focus on positioning, value, quick start, core features, basic technical shape, and license
- omit roadmap, FAQ, version evolution, and heavy developer detail unless they already add real value

### Active / Mature Repository

Best fit:

- public project with active iteration
- real users or contributors
- stable enough release or usage story

Density rules:

- use the full normal skeleton
- FAQ, roadmap, version evolution, and richer quick-start variants are allowed when truthful
- keep the landing-page rhythm strong even when more lower-half detail is present

### Maintenance / Stable Repository

Best fit:

- feature-stable projects
- long-lived tools in maintenance mode
- archived or low-change but still usable repositories

Density rules:

- keep the top half strong and current
- compress forward-looking sections such as roadmap unless they are still meaningful
- prefer clear status signaling, compatibility, limitations, and maintenance notes over aspirational expansion
- avoid bloating the README with old historical detail that belongs in changelogs or release notes

## Density Guardrails

- `Default Required`: maturity level may change content density, but it must not break the shared section rhythm.
- `Default Required`: a sparse README is acceptable only when it is intentionally sparse, not incomplete.
- `Conditional Required`: early repositories may omit some optional sections, but should not omit the first runnable path.
- `Conditional Required`: mature repositories should not hide important usage, compatibility, or release information just to stay short.
- `Conditional Required`: maintenance-mode repositories should clearly communicate current status if development pace has slowed or feature growth has stopped.

## Conditional Expansion Rules

### FAQ

- `Conditional Required`: include an FAQ section when the project has recurring installation issues, compatibility caveats, or common misunderstandings.
- Place FAQ in the lower half of the README.

### Roadmap

- `Conditional Required`: include a roadmap when the repository is public, actively evolving, and readers benefit from seeing planned direction.
- Keep roadmap short. Detailed planning belongs in issues, milestones, or docs.

### Demo Video

- `Conditional Required`: include a demo video link when GIFs are insufficient to explain the product interaction.
- Prefer a linked thumbnail or a short labeled link rather than embedding clutter.
- Demo video is recommended for product-style repositories, not for every repository by default.

## Guardrails

- Do not add decorative HTML that GitHub may render inconsistently.
- Do not use colored text styling as a dependency.
- Do not center everything mechanically.
- Do not allow screenshots to push quick start too far down.
- Do not let technical sections dominate the first screen unless the repository is clearly developer-first.
