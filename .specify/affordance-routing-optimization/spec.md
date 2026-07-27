# Affordance Routing and Context-Budget Optimization

## Goal

Make AgentLogic's tool selection feel like human tool use: begin with the intended outcome,
choose the native evidence/action tool for that outcome, and use a specialized skill only when it
adds clear value. Reduce default bundle repetition so this operating model remains visible.

## Requirements

1. Add a concise normative module defining an outcome → evidence → tool/skill → closure flow.
2. Make matching tool use the normal next action, not a separate ritual or a generic question
   about which tool to use.
3. Preserve safety: high-impact mutations still require target confirmation and post-result
   inspection; evidence requirements remain unchanged.
4. Revise strict missing-specialized-skill behavior so an unavailable optional skill does not
   prevent ordinary implementation when the required evidence tool is available. The result must
   still disclose the unavailable specialization and never claim that skill was used.
5. Reduce `core-enhanced` to the high-frequency operational source set, and retain the former
   broad source set as an explicit `governance-reference` profile for deep audits, policy work,
   and maintenance.
6. Update all active version, map, profile, and generated-bundle sources for V6.8.4.
7. Do not commit, push, publish, or otherwise mutate GitHub state.
8. Make the project map the default first tool for code navigation: inherited projects establish
   and validate it before broad reads; owned projects create and update it with structural and
   key-flow changes.
9. Resolve the UI preview exception hierarchy, include the referenced risk matrix in the default
   profile, align reference-profile navigation with map-first behavior, and mechanically reject
   unreadable project code maps.

## Acceptance Criteria

- The default bundle is materially smaller while preserving the full entry chain, permissions,
  verification, SDD, UI, shipping, and routing controls.
- The new module supplies a compact human-affordance matrix covering writing, finding, checking,
  seeing, current research, and external change.
- The routing contract and Module 49 agree on fallback and disclosure behavior.
- Full governance remains available in a named profile rather than being deleted.
- All profiles and four generated host bundles validate successfully.
