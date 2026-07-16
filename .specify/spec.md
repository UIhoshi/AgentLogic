# AgentLogic V6.8.0 Logic Audit Remediation Specification

## Status

Approved for implementation by the user after the V6.8.0 read-only logic audit.

## Problem

The repository's validation commands pass, but several active rules do not describe the
repository that contains them. The master map still presents an unrelated `src/`-based
Agentic CLI as the current project, context-reset requirements disagree about a token
threshold, host documentation advertises a removed Gemini adapter, and the mechanical
entry checker covers fewer entrypoints than the rule claims. The current UI prototyping
rule is also narrower than the required user-facing design checkpoint.

## Goals

1. Make the AgentLogic repository's own boundaries and four-layer map factually accurate.
2. Make non-extension context-reset handling deterministic: ask explicitly, without a
   token-based silent exception.
3. Align the mandatory-entry rule with a mechanical inventory of actual entry scripts.
4. Align all host documentation with the manifest and installer (`antigravity`, not `gemini`).
5. Replace machine-specific history paths with portable sibling-repository guidance.
6. Replace user-facing repository placeholder links with repository-relative links.
7. Require a text-to-image UI preview to be generated and shown to the user before formal
   UI implementation, unless the user explicitly opts out.

## Non-goals

- Rewriting historical version files except for the current V6.8.0 source and active docs.
- Auditing imported raw skill content.
- Creating business-project code in this logic repository.
- Generating a UI mockup for this documentation-only rule change.

## Acceptance Criteria

- `modules/01_MasterLogic.md`, `modules/11_CrossDirectoryMap.md`, and
  `modules/40_AgentLogicSystemMap.md` describe existing AgentLogic paths or clearly label
  external concepts as references.
- Every mandatory context-reset rule says that a non-extension coding round requires an
  explicit reset decision; no token-based silent exception remains.
- The entry checker validates the declared operational entry scripts in addition to the
  repository Markdown entry documents.
- `MAIN.md`, `adapters/README.md`, `install.sh`, and legacy `00_README.md` do not advertise
  an unsupported `gemini` target.
- History synchronization guidance uses a portable sibling path or explicit configurable
  location and the local AgentLogic history records this correction.
- Active user-facing Markdown uses repository-relative links rather than
  `file:///REPO_ROOT_PLACEHOLDER/...` links.
- Before formal UI implementation, the agent must use text-to-image generation, show the
  resulting preview to the user, and wait for approval; an explicit user opt-out is the
  only bypass.
- `doctor.ps1`, `validate-package.ps1`, `check-logic-entry.js`, and
  `maintainer-check.ps1` pass, and the working tree is inspected afterward.
