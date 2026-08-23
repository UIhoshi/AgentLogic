# Code Map

> **Freshness:** Reviewed commit: `<commit>` | Updated: `<YYYY-MM-DD>`

> This is a source-backed navigation aid, not runtime proof. Re-read the linked source and use
> matching verification before making behavior claims.

## Entry Points
| Surface / mode | Path | Entry symbol | Purpose |
| --- | --- | --- | --- |
| | | | |

## Module and Symbol Ownership
| Path | Key function / class / symbol | Responsibility | Main callers / dependencies |
| --- | --- | --- | --- |
| | | | |

## State, Storage, and Configuration
| Key / state | Type | Owner | Read / write paths | Notes |
| --- | --- | --- | --- | --- |
| | | | | |

## Interfaces and Events
| Surface | Handler / contract | Input | Side effects | Verification |
| --- | --- | --- | --- | --- |
| | | | | |

## Skill Usage
| Durable flow | Capability / skill | Trigger | Source of truth | Reviewed commit |
| --- | --- | --- | --- | --- |
| | | | .agentlogic/skill-usage.json | |

> Keep only durable flow-to-skill records here. Store task-level invocation evidence in .specify/<task>/skill-execution.json; never include secrets, private prompts, raw logs, or machine paths.

## Validation and Known Gaps
- **Validation commands:**
- **Unconfirmed points:**

## Update Rules
- When a durable skill is adopted, replaced, upgraded, or retired, update .agentlogic/skill-usage.json and this Skill Usage summary in the same commit.
- Refresh this map in the same commit as an affected entrypoint, module boundary, key flow,
  symbol ownership, storage/configuration contract, interface/event surface, or validation command.
- Keep it concise; do not paste source, raw logs, secrets, machine paths, or generated graph output.
- Visual maps are optional and require user approval. Record only durable, verified conclusions here
  or in `PROJECT_MAP.md`.
