# GitHub README Template V1

This file is the default GitHub-facing README template for projects that use this logic package.

## Purpose

- Use this template when creating a new repository `README.md`.
- Use this template when rewriting a weak, incomplete, or placeholder README.
- Use this template as the default baseline unless the project already has a stronger explicit README standard.
- Use this template together with `17_GitHubREADMEStyleRules_V1.md` when the repository needs both content structure and presentation structure.

## Automatic Trigger Rule

This README system should be triggered automatically when the task includes any of the following:

- uploading a project to GitHub
- preparing a repository for first public push
- preparing a repository homepage before publishing
- restructuring a repository before open-source release
- rewriting `README.md` as part of GitHub publication work

When one of these triggers is present, the agent should not treat README work as optional polish.

The agent should automatically run the GitHub README workflow:

1. template
2. style rules
3. examples
4. review checklist

## Integrated Existing Rules

This template already integrates the existing repository rules that:

- a GitHub README should act as the repository landing page and first product impression
- a README should include practical usage or quick-start content by default
- multilingual README content should not be stacked in full on one page by default
- repository-relative links are preferred over machine-specific absolute paths
- unverified release assets, screenshots, commands, and claims must not be fabricated
- README style should remain structurally consistent across repositories even when visual details vary

## Template Scope

This is a GitHub README template, not a generic project-doc template.

- It is optimized for repository homepages.
- It is not a PRD template.
- It is not a changelog template.
- It is not an issue template.
- It does not replace the style rules file.

## Applicability

Best fit:

- desktop apps
- web apps
- open-source tools
- developer utilities
- internal tools that still need a GitHub-facing homepage

May require adaptation:

- SDKs and libraries
- backend services
- APIs without a visual UI

## Required Output Rules

- Keep the top screen benefit-first, not architecture-first.
- The opening should explain what the project is and why it matters.
- Prefer concrete user pain points over abstract slogans.
- A practical `Quick Start`, `Usage`, or equivalent section must exist by default.
- If the project offers more than one real entry path, `Quick Start` should reflect the main supported paths instead of pretending there is only one.
- If the product has a UI, screenshots or GIFs are strongly recommended.
- If the project supports multiple languages, keep language links near the top and split full content into separate files.
- If a field is unverified, do not invent it. Leave it pending, omit it, or convert it into a TODO for the repository owner.

## Mandatory Sections

Every GitHub README generated from this template should include at least:

- project name
- one-sentence positioning
- pain points or value proposition
- quick start or usage
- core features
- target users or use cases
- technical implementation or project structure
- contribution or support path
- license

## Conditional Sections

Use only when applicable:

- multilingual navigation links
- product preview screenshots
- GIF demos
- latest release download link
- platform compatibility
- known limitations
- version history
- version evolution
- author/about section

## Maturity Adaptation Rule

The template should adapt to repository maturity without losing the shared README skeleton.

Rules:

- early or newly public repositories may stay lighter and omit some optional lower-half sections
- active or mature repositories may use more of the optional sections when they add real reader value
- maintenance-mode repositories should prefer current status, compatibility, and limits over aspirational filler
- regardless of maturity, the README should still provide a clear top-half landing page and at least one truthful usage path

## Private Testing Repository Rule

Some repositories are not yet public-release repositories, but are still product-like enough to benefit from a strong GitHub landing page.

Rules:

- a private-testing or internal-iteration repository should not automatically degrade into a plain developer note dump if the repository is still product-like
- if the repository is product-like, the README may still use a strong product-style structure with:
  - centered hero
  - visually clear badge strip
  - early proof section
  - compact summary block
- the repository's testing or private status should be expressed explicitly as truthful status information, rather than by removing the landing-page structure
- in this mode, README work should still preserve truthfulness:
  - do not invent releases
  - do not invent screenshots
  - do not invent licenses
  - do not invent public availability

## Placeholder Rules

Use explicit placeholders during drafting, and replace them only with confirmed facts:

- `[PROJECT_NAME]`
- `[ONE_LINE_POSITIONING]`
- `[LATEST_RELEASE_URL]`
- `[QUICK_START_STEP_1]`
- `[SCREENSHOT_1]`
- `[GIF_DEMO_1]`
- `[DEV_COMMAND]`
- `[BUILD_COMMAND]`
- `[LICENSE_NAME]`

## Multilingual Rule

If the repository is multilingual, prefer:

- `README.md` as the primary landing page
- `README.zh-CN.md` for Simplified Chinese
- `README.ja.md` for Japanese

Do not stack full Chinese, English, and Japanese versions into one page by default.

## Multilingual Structure Mirroring Rule

If multiple language README files exist, they should stay structurally mirrored unless there is a strong project-specific reason not to.

Rules:

- keep the same major section order across language files
- keep the same top-half structure across language files
- keep badge presence consistent across language files when the badge data is shared
- keep screenshots, GIFs, and repository-relative links aligned across language files where possible
- allow wording to be localized naturally without forcing sentence-level literal translation
- if one language omits a major section, that omission should be intentional and justified, not accidental drift

## Release Rule

If the README points users to downloadable release assets:

- use a confirmed release URL only
- do not invent a release link
- if no release exists yet, replace the download step with source-based setup or mark the release as pending

## Multi-Path Quick Start Rule

If the project has multiple truthful user entry paths, prefer a short multi-path quick-start block over a fake single-path flow.

Common valid paths include:

- release package path
- local source/runtime path
- browser-only or fallback path
- CLI path

Rules:

- keep each path short and outcome-oriented
- order paths by normal user priority, not by developer preference
- do not force `npm run dev` to be the only path if most users install from Releases
- do not add a path that is not actually supported

## Version Evolution Rule

Use a lightweight `Version Evolution`, `How It Evolved`, or equivalent section when:

- the project has real release evolution worth highlighting
- readers benefit from seeing how the product matured
- the section helps explain why the current version matters

Rules:

- keep it brief
- place it in the lower half of the README
- do not let it replace a full changelog or release notes
- prefer milestone-style summaries instead of exhaustive bullet dumps

## Screenshot Rule

If screenshots or GIFs are referenced:

- prefer repository-relative paths such as `./screenshots/dashboard.png`
- create a stable `screenshots/` directory when appropriate
- do not reference temporary local files
- do not claim screenshots exist if they have not been added

## Template

```md
# [PROJECT_NAME]

**[ONE_LINE_POSITIONING]**

Optional example:
**Offline LAN digital signage management system** -- stable remote control for multiple screens, fully offline, designed for stores and enterprise intranets.

Optional example:
**Turn hundreds or thousands of Excel files into a desktop search engine** -- no database required, import in two steps and search fast.

[English](./README.md) | [简体中文](./README.zh-CN.md) | [日本語](./README.ja.md)

> Remove the multilingual line if the repository does not actually provide those files.

## ✨ What problem does this solve?

- [PAIN_POINT_1]
- [PAIN_POINT_2]
- [PAIN_POINT_3]
- [OPTIONAL_PAIN_POINT_4]
- [OPTIONAL_PAIN_POINT_5]

### Product Preview

> Use this section for UI products. For libraries or backend services, replace this with architecture, API examples, or usage examples.

![Screenshot 1](./screenshots/[SCREENSHOT_1].png)
![Screenshot 2](./screenshots/[SCREENSHOT_2].png)
![Demo](./screenshots/[GIF_DEMO_1].gif)

## 30-Second Quick Start

### Path 1: Latest Release

1. Download from [Latest Release]([LATEST_RELEASE_URL])
2. [QUICK_START_STEP_1]
3. [QUICK_START_STEP_2]

### Path 2: Local Source Runtime

```bash
[DEV_COMMAND]
```

- [LOCAL_RUNTIME_NOTE_1]
- [LOCAL_RUNTIME_NOTE_2]

### Path 3: Optional Fallback Path

```bash
[OPTIONAL_FALLBACK_COMMAND]
```

- [OPTIONAL_FALLBACK_NOTE_1]
- [OPTIONAL_FALLBACK_NOTE_2]

> Remove unused paths. Keep only the real supported paths for the repository.

**Important notes**

- [IMPORTANT_NOTE_1]
- [IMPORTANT_NOTE_2]

## ✨ Core Features

- [FEATURE_1]
- [FEATURE_2]
- [FEATURE_3]
- [OPTIONAL_FEATURE_4]

## Who Is This For?

- [TARGET_USER_1]
- [TARGET_USER_2]
- [TARGET_USER_3]

## Technical Implementation

**Tech stack**

- [TECH_STACK_ITEM_1]
- [TECH_STACK_ITEM_2]
- [TECH_STACK_ITEM_3]
- [TECH_STACK_ITEM_4]

**Architecture highlights**

- [ARCH_HIGHLIGHT_1]
- [ARCH_HIGHLIGHT_2]
- [ARCH_HIGHLIGHT_3]

**Repository structure overview**

| Directory | Purpose |
|-----------|---------|
| `src/` | [SRC_PURPOSE] |
| `scripts/` | [SCRIPTS_PURPOSE] |
| `docs/` | [DOCS_PURPOSE] |
| `screenshots/` | README assets |

## Installation And Build

- Development: `[DEV_COMMAND]`
- Build: `[BUILD_COMMAND]`
- Package: `[PACKAGE_COMMAND]`

## Known Limitations

- [LIMITATION_1]
- [LIMITATION_2]

> Remove this section if there are no meaningful limitations to communicate yet.

## Version History

- [LATEST_VERSION_SUMMARY]

> Or replace with a link to Releases or a changelog.

## Version Evolution

- [VERSION_MILESTONE_1]
- [VERSION_MILESTONE_2]
- [VERSION_MILESTONE_3]

> Use only when the project has real release evolution worth highlighting. Keep this brief.

## Contributing / Support

- Star the repository if it helps
- Open an Issue for bugs or feature requests
- PRs are welcome

## License

[LICENSE_NAME]

---

**About**
[OPTIONAL_AUTHOR_OR_PROJECT_BACKGROUND]
```

## Style Pairing Rule

When this template is used for a real repository README:

- also check `17_GitHubREADMEStyleRules_V1.md`
- keep the same broad page rhythm across repositories
- allow project-specific variation without losing the same structural skeleton

## Adaptation By Project Type

### Desktop App

- Keep screenshots and GIFs.
- Keep installer or release download flow high on the page.
- Mention platform compatibility if relevant.

### Web App

- Emphasize hosted demo URL, deployment status, or login-free preview if available.
- Screenshots still help.

### Library Or SDK

- Move installation and usage examples above screenshots.
- Replace product-preview emphasis with code examples.

### Backend Service Or API

- Replace product preview with architecture diagram, endpoint example, or deployment quick start.
- Keep a runnable usage path.

## Authoring Guardrails

- Do not turn the README into an architecture dump.
- Do not let all value proposition disappear behind technical jargon.
- Do not include dead multilingual links.
- Do not include fake release links.
- Do not include fake badges or fake download numbers.
- Do not include placeholder sections in the final README unless the user explicitly wants a scaffold draft.
