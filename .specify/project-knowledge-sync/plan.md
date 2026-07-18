# Project-Knowledge Sync Implementation Plan

## Architecture

Introduce a V6.8.2 project-native knowledge-sync module. It will separate global method
rules from project facts: AgentLogic remains host-installed; each business project tracks
only `AGENTS.md`, `PROJECT_MAP.md`, and `.learnings/ERRORS.md` with its own code.

## Implementation Steps

1. Promote the active stable line to V6.8.2 and add `modules/46_V6_8_ProjectKnowledgeSync.md`.
2. Replace the external-history blocking language in entry and enforcement rules with the
   project-native startup, update, and safe-sync protocol.
3. Update the project-fact template, SDD, SRA, Graphify, system maps, READMEs, manifest,
   and validation script to register the three-file contract and conditional `.specify/` /
   ADR surfaces.
4. Add project-file templates and an ADR recording the sync-boundary decision.
5. Regenerate all host bundles, validate, install the Codex bundle, record the AgentLogic
   release history, and publish in the required order.

## Red-Team Results

| Load-bearing claim | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| Project Git is sufficient for cross-device knowledge sync | Code and knowledge share one Git history and remote | The project has no remote, branch divergence, or uncommitted changes | Require fetch/status first; only permit a fast-forward pull after clean-target confirmation; state offline fallback clearly |
| Project-local documents remain safe to share | A minimal, redacted contract captures durable facts | Secrets or personal information are added and pushed | Explicitly prohibit sensitive content; validate required headings/anchors, not private content; keep raw/private material out of tracked files |
| Removing the hard external-history gate does not lose reusable learning | Project facts are best kept with code; cross-project history is optional | A systemic lesson remains trapped in one project | Add a promotion rule: recurring lessons may be elevated to AgentLogic or the optional archive |
| Graphify does not create accidental disclosure | Only durable summaries are tracked by default | Full generated graph artifacts are committed | Default `graphify-out/` to ignored/external and document the boundary |

Top-ranked failure mode: stale or divergent local project knowledge. Address it before Tasks
by making `git fetch --prune` and branch/worktree inspection mandatory before reliance, while
keeping `git pull` an explicit state-changing step.
