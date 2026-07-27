# External Research and Artifact Integration

## Goal

Integrate reviewed policy patterns from Bento, PixelRAG, and Firecrawl into AgentLogic without
importing their code, enabling their plugins, or treating any external capability as installed.

## Requirements

1. Add one optional policy module that defines the permitted role, trigger, trust boundary, data
   boundary, and non-goals for each source.
2. Treat Bento as an optional, user-requested single-file presentation artifact; never as a
   default host plugin or automatic download path.
3. Treat PixelRAG as an optional visual-retrieval accelerator for permitted visual documents;
   preserve browser, screenshot, and source-read verification requirements.
4. Treat Firecrawl as an optional, consent-bound external collection path; protect credentials,
   data egress, source scope, and side-effecting web actions.
5. Do not add a mandatory route, executable dependency, bundled source, external API key, or
   automatic installation.
6. Register the policy in the active profile, current version source, repository maps, and
   existing relevant routing/reference modules; regenerate every host bundle.
7. Promote the active stable source to V6.8.4 while preserving the V6.8.3 version file as
   historical source material; do not publish, push, or otherwise synchronize to GitHub.
8. Begin a read-only source inventory in an external audit workspace. Do not label an external
   extension as trusted or security-audited while the required audit capability is unavailable.

## Acceptance Criteria

- The policy module clearly distinguishes discovery, authorization, installation/trust, and
  verified use.
- All three integrations include explicit trigger and non-trigger rules.
- The default profile carries the policy, while external capabilities remain optional and
  unavailable until independently verified.
- `node scripts/check-logic-entry.js`, `scripts/validate-package.ps1`, and
  `scripts/maintainer-check.ps1` pass after the generated bundles are rebuilt.
- The manifest and all active host bundles report V6.8.4, and no Git remote mutation occurs.
