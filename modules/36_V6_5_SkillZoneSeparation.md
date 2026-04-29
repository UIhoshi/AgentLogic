# V6.5 Skill Zone Separation

Status: **Stable V6.5 Line**.

This module defines the required separation between host-local skills and logic-package-governed skills.

---

## 1. Why The Separation Exists

Different machines may have very different skill inventories.

If AgentLogic does not distinguish:

- skills that belong to the current machine and host
- skills that belong to the logic package itself

then a local machine's personal skill sprawl can be mistaken for portable logic state.

That creates two failures:

1. one machine pollutes another machine's installation expectations
2. host-local skill cleanup accidentally mutates portable logic assets

---

## 2. The Two Required Skill Zones

### 2.1 Host-Local Skill Zone

This zone belongs to the current machine and current host installation.

Examples:

- `~/.codex/skills`
- `~/.claude/skills`
- `~/.gemini/skills`

Properties:

- machine-specific
- host-specific
- may differ across devices
- may include user-installed third-party skills
- must be audited during install and update

### 2.2 Logic-Carried Skill Zone

This zone belongs to the AgentLogic package itself.

Properties:

- repository-governed
- portable across machines
- versioned with the logic package
- should contain only skills that are intentionally shipped as part of AgentLogic

Current V6.5 posture:

- **AgentLogic does not currently ship a normal large logic-bundled skill pack**
- the main portable layer is still the logic modules themselves
- any future bundled skill layer must be explicitly declared as logic-carried rather than inferred from a host-local skill directory

---

## 3. Governance Rule

The install/update-time skill governance pass must operate only on the **host-local skill zone**.

It must not:

- treat host-local skill state as repository truth
- copy one machine's host-local skill inventory into another machine by default
- mutate a future logic-carried skill zone as if it were disposable user clutter

---

## 4. Install And Update Rule

During AgentLogic installation or update:

1. identify the target host-local skill zone
2. audit only that host-local zone
3. classify active-by-default vs archive-by-default host-local families
4. leave the logic-carried layer untouched unless the logic package itself is being upgraded

---

## 5. Current V6.5 Practical Meaning

For the current line:

- host-local skills remain local
- archived host-local skills remain local archives
- AgentLogic logic modules remain the portable source of truth

So a cleanup on one machine should not silently become the default skill set for another machine unless the user explicitly chooses to replicate it.

---

## 6. Future Expansion Rule

If AgentLogic later ships its own portable bundled skills, that layer must be explicitly documented with:

- the bundle path
- its role
- whether it is always installed or optional
- whether host-local governance may inspect it or must ignore it

Until then, host-local skills and logic-package modules must stay clearly separated.
