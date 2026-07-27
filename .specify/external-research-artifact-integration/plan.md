# Plan — External Research and Artifact Integration

## Approach

1. Add `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md` as the sole detailed policy
   owner for Bento, PixelRAG, and Firecrawl.
2. Cross-link it from the reference-to-interface and routing modules, keeping Modules 29–31 as
   the authority for proof strength.
3. Register it in `manifest.json`, the V6.8.3 source, and project/repository maps.
4. Rebuild profile bundles only through `scripts/build-profile.ps1`, then run structural and
   package/maintainer validation.
5. Copy the completed V6.8.3 source into a V6.8.4 source, update active-entry/version pointers,
   rebuild all bundles, and retain V6.8.3 as history.
6. Clone the three specified repositories into a sibling `external-audits/` directory with no
   installation or execution. Record an inventory only; the missing `skill-security-auditor`
   blocks a verified extension-trust audit.

## Load-Bearing Assumptions / Red-Team Results

| Assumption | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| Policy-only integration adds useful capability without unsafe coupling | The projects contain reusable workflow patterns while AgentLogic already has extension-trust controls | Readers infer a plugin, SDK, or API is installed or approved | State explicit non-import and availability rules; validate rendered bundles contain the policy. |
| A single module avoids routing conflicts | The three sources concern the same broad area: research/capture/artifacts | Existing Modules 47–48 become contradictory or duplicate concrete skills | Make Module 50 the source-specific policy owner and cross-link only at decision points. |
| Firecrawl can remain opt-in without weakening data safety | Its API can help with broad public collection when a user authorizes it | Hosted use leaks private/authenticated content or Actions cause side effects | Require explicit source/scope/data-egress approval; prohibit authenticated collection by default and classify interaction as side-effecting. |
| Bento adds handover value without host changes | A portable presentation file is useful for stakeholders | Its plugin/download behavior is implicitly authorized | Restrict it to user-requested artifact generation after separate audit/version pinning. |
| PixelRAG improves visual discovery without false visual proof | Screenshot retrieval preserves layout-heavy information | Its output is presented as runtime or UI verification | Require matching browser/screenshot/runtime evidence under Module 29. |
| Version promotion preserves a valid source chain | The new source is a copy-forward patch promotion | Active documents still point to V6.8.3 or historical source is overwritten | Preserve the old file, update active pointers, rebuild, and validate all bundles. |
| A source inventory is not mistaken for a security audit | Static reads can reveal repository shape and declared install paths | Missing designated audit skill is silently bypassed | Mark every result partial and leave trust/install status unchanged. |

## Design Decision

Use one optional policy module and no new mandatory capability route. The integrations are
source-specific candidates, not built-in tools. This maintains the strict missing-capability and
extension-trust rules while allowing a user-approved future installation.
