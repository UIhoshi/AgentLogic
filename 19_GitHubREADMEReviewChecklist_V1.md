# GitHub README Review Checklist V1

This file is the default self-review checklist for GitHub-facing `README.md` work.

Use it after drafting or rewriting a repository README.

It should be used together with:

- `16_GitHubREADMETemplate_V1.md`
- `17_GitHubREADMEStyleRules_V1.md`
- `18_GitHubREADMEExamples_V1.md`

## Purpose

- catch structural drift before the README is treated as complete
- keep different repositories visually related
- reduce fabricated or weak README content
- enforce a minimum public-homepage quality bar

## Automatic Trigger Check

- [ ] If the task includes uploading or publishing the repository to GitHub, the README four-layer workflow was actually invoked
- [ ] The README was not treated as optional polish during GitHub publication work
- [ ] Template, style rules, examples, and review checklist were all checked in the same round

## 1. Structure Check

- [ ] The README follows the template baseline or a justified repository-specific equivalent
- [ ] The README has a clear project title
- [ ] The README has a one-line positioning statement near the top
- [ ] The README includes a clear value or pain-point section
- [ ] The README includes a `Quick Start`, `Usage`, or equivalent runnable section
- [ ] The README includes core features or capability highlights
- [ ] The README includes technical implementation, project structure, or equivalent technical context
- [ ] The README includes contribution/support guidance
- [ ] The README includes a license section

## 2. Style Check

- [ ] The top-half structure roughly matches the standard rhythm: Hero -> proof/preview -> value -> quick start -> compact summary
- [ ] Locked top-half sections were not casually reordered
- [ ] The Hero section is centered by default, or there is a good reason not to center it
- [ ] If badges are present, they are placed near the hero and do not feel overloaded
- [ ] The README includes an `At a Glance` table or an equivalent compact summary block
- [ ] The technical section stays in the lower half and does not replace the landing-page layer
- [ ] The README feels structurally similar to the rest of the repository set, even if the exact style differs

## 3. Badge Check

- [ ] Badge count is within the normal range, usually 3 to 5
- [ ] Badge count does not exceed 6 without a good reason
- [ ] Every badge corresponds to real data
- [ ] There are no vanity badges that add no useful decision signal
- [ ] Missing CI, docs, release, or platform support has not been faked through badges
- [ ] Badge order follows the repository's style mode priority rather than random selection
- [ ] If the repository is minimal, weak badges were omitted instead of padding the strip

## 4. Content Truthfulness Check

- [ ] No screenshots are claimed unless they actually exist
- [ ] No GIFs or demo assets are claimed unless they actually exist
- [ ] No release links are used unless they are confirmed
- [ ] No commands are shown unless they are confirmed
- [ ] No platform support claims are made unless they are true
- [ ] No performance claims are made unless they are justified
- [ ] No placeholder text remains in the final README unless the user explicitly wants a scaffold draft

## 5. Multilingual Check

- [ ] Multilingual links are shown only if those files actually exist
- [ ] Full multilingual content is not stacked into one page by default
- [ ] `README.md` still works as the primary landing page
- [ ] Major section order is mirrored across language files unless there is a deliberate reason not to
- [ ] The top-half structure is mirrored across language files
- [ ] Shared screenshots, GIFs, and core links stay aligned across language files where possible

## 6. Preview And Proof Check

- [ ] Visual products include a preview or proof section near the top
- [ ] Non-visual projects replace screenshots with a better proof layer such as usage examples, API examples, or architecture proof
- [ ] The preview section is strong enough to explain the project quickly without becoming cluttered
- [ ] GIF use is restrained and purposeful
- [ ] Screenshot assets use stable repository-relative paths
- [ ] Screenshot filenames are clean and reusable rather than export-noise names
- [ ] The top-half preview block is not overloaded with too many images or GIFs

## 7. Quick Start Check

- [ ] The quick-start section is short and executable
- [ ] The quick-start section is in the upper half of the page
- [ ] Important warnings are placed directly near quick start
- [ ] If no release exists, source-based setup or another truthful path is used instead
- [ ] If the project has multiple real entry paths, quick start reflects them instead of collapsing everything into one fake path
- [ ] For product-style repositories, the normal user path appears before advanced developer-only paths

## 8. Style-Mode Check

- [ ] The README clearly leans toward either `Product Style` or `Developer Style`
- [ ] If the project is mixed, the tie-break rule was applied consciously rather than randomly
- [ ] A developer-first repository is not forced into a fake product page
- [ ] A product-style repository still exposes enough executable usage information

## 9. Optional Section Check

- [ ] FAQ is included if the project has recurring confusion, install issues, or compatibility caveats
- [ ] Roadmap is included if future direction helps readers
- [ ] Demo video is included only when GIFs are insufficient
- [ ] Version evolution is included only when it adds real context and remains lightweight
- [ ] Optional sections improve clarity instead of just making the README longer

## 10. Final Quality Check

- [ ] The first screen gives a clear and strong first impression
- [ ] The README is easy to scan
- [ ] The page feels balanced rather than text-heavy or image-heavy
- [ ] The repository homepage feels intentional rather than improvised
- [ ] The README is ready to function as a public-facing repository landing page

## Default Completion Rule

The README should not be treated as complete if:

- the structure check fails
- the truthfulness check fails
- the quick-start path is missing
- the page has clearly drifted away from the shared repository structure without a good reason
