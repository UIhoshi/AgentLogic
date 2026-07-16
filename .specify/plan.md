# AgentLogic V6.8.0 Logic Audit Remediation Plan

## Execution Order

1. Record this specification, plan, Red-Team results, and task list.
2. Replace the unrelated project-specific master map with an AgentLogic repository map.
3. Remove the context-reset token exception and align the startup wording.
4. Expand entry-gate validation to the declared operational entry scripts.
5. Align host names and replace the hard-coded history path.
6. Resolve active placeholder links and update the legacy boundary note.
7. Strengthen the text-to-image UI preview and explicit-opt-out gate.
8. Rebuild generated bundles and run all repository validation checks.

## Applicability

This is a logic-contract and packaging-surface change. It uses the full SDD path, including
Red-Team before implementation, but it does not require a UI mockup because no UI is being
implemented.

## Red-Team Results

### Claim 1: The current `src/` map can remain as a useful conceptual model

- Steelman: it documents the architecture of a related Agentic CLI and may help future users.
- Attack: the file is named and loaded as the current master logic, so agents can treat those
  paths as facts about this repository.
- Fails if: an agent searches for or edits nonexistent `src/` files instead of the actual
  scripts, modules, and adapters.
- Mitigation: map actual AgentLogic paths and move external architecture to reference-only
  wording.

### Claim 2: A token threshold is a harmless optimization for reset questions

- Steelman: asking about reset when context is tiny can add friction.
- Attack: the repository's entry header and checklist define the reset decision as mandatory,
  and token usage is not a stable cross-host measurement.
- Fails if: different hosts silently carry context under the same new-task condition.
- Mitigation: require an explicit reset decision for every non-extension coding round.

### Claim 3: Checking only Markdown entry documents is enough

- Steelman: agents usually begin from `AGENTS.md`, `README.md`, or `MAIN.md`.
- Attack: `install.ps1`, `install.sh`, doctor, validation, and adapter scripts are executable
  entrypoints and can be invoked directly.
- Fails if: direct script entry bypasses the declared gate without mechanical detection.
- Mitigation: maintain an explicit operational-entry inventory and validate its headers.

### Claim 4: The existing UI mockup gate already satisfies the new requirement

- Steelman: it already covers new layouts and complex components.
- Attack: the user requirement applies to formal UI work generally and requires showing the
  image to the user, unless the user explicitly opts out.
- Fails if: ordinary UI implementation starts without a preview and user checkpoint.
- Mitigation: make the preview gate universal for formal UI implementation, with only explicit
  user opt-out as a bypass.

## Architectural Decision

AgentLogic remains a portable method layer. Repository maps describe this repository's actual
logic assets; external project architecture is reference material only. Generated bundles are
rebuilt from source, and the UI preview rule is a blocking pre-implementation contract.
