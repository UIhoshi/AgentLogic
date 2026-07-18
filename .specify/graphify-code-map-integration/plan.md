# Plan: Graphify Code Map Integration

## Implementation

1. Register Graphify as a comparative external source in the active V6.8.1 source and
   both public READMEs.
2. Add `modules/45_V6_8_GraphifyCodeMapIntegration.md` as a portable policy module;
   it will define the Graph Preview Gate and external-extension boundary.
3. Register the module in both enhanced profiles and update the master/system maps.
4. Regenerate all host bundles and run entry, package, and maintainer checks.
5. Record the integration and security boundary in modification history before commit/push.

## Red-Team Results

### Claim: Always generating a graph near completion improves reviewability

- Steelman: a graph makes architecture and cross-module relationships easier to inspect.
- Attack: graph creation can be expensive, unnecessary for small tasks, and may process
  sensitive documentation through an optional semantic backend.
- Fails if: a user receives an unwanted tool installation, graph output, or external data use.
- Mitigation: ask once only for eligible substantial tasks; no installation or generation
  occurs without explicit consent.

### Claim: Graph relationships are proof of implementation behavior

- Steelman: AST-derived imports and calls are highly useful structural evidence.
- Attack: inferred edges, dynamic behavior, configuration, permissions, and UI output can
  be absent or ambiguous.
- Fails if: an agent closes a runtime or security claim from graph output alone.
- Mitigation: label graph output as discovery evidence and retain the Verification Matrix.

### Claim: An external Graphify skill can be trusted because it is useful and popular

- Steelman: Graphify documents local AST analysis and input protections.
- Attack: installation may write host instructions/hooks and optional paths can use network
  or model backends.
- Fails if: an unreviewed external extension changes host or project state.
- Mitigation: require the external-skill security audit and explicit installation intent;
  this integration ships policy only, not Graphify code.

