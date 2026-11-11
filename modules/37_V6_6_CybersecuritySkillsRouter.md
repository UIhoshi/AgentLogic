# V6.6 Cybersecurity Skills Router Integration

Status: **Stable V6.6 Line**.

This module defines the integration of the Cybersecurity Skills Router (from `reverse-skill`) as a core operating capability under AgentLogic V6.6.

---

## 1. Core Integration Mandate

Cybersecurity and reverse-engineering tasks require specialized toolchains, strict execution playbooks, and structured feedback loops to prevent model hallucination and command stalling.

AgentLogic V6.6 embeds the **Cybersecurity Skills Router** to provide:
- A systematic workflow for APK analysis, binary reverse engineering, frontend JS signing, firmware testing, and CTF challenges.
- Explicit tool orchestration mapping for `jadx`, `apktool`, `Frida`, `radare2`, `IDA`, `BurpSuite`, and browser automation.
- Auto-validation of security tool availability.
- A **Field Journal** system to save and reuse exploit patterns, commands, and lessons learned.

---

## 2. Classification & Routing Workflow

For any cybersecurity or reverse-engineering task, the agent MUST execute the following sequence:

1. **Classification**: Identify target type (APK, ELF/PE/Mach-O, Go/Rust binary, JS/Browser Extension, Web Traffic/Protocol, Cloud/K8s/AD, CTF, Firmware) and user intent:
   - **Security / Vulnerability / CTF / Traffic Audit (`security_surface`)**: Route through `skills/reverse-skill/skills/` (`apk-reverse`, `ida-reverse`, `ghidra-reverse`, `binary-ninja-reverse`, `go-rust-reverse`, `macos-reverse`, `protocol-reverse`, `browser-extension-reverse`, `malware-analysis`, `firmware-pentest`, `js-reverse`, `ctf-sandbox`, `cloud-k8s`, `windows-ad`, `code-audit`, `case-review`).
   - **Engineering Decompilation & Clean-Room Source Reconstruction (`decompile_or_reconstruct`)**: When the goal is to recover readable, typed, buildable source code or module contracts from compiled binaries, stripped Go/Rust binaries, Unity IL2CPP/Godot containers, bytecode, or minified bundles, automatically route through `skills/engineering/decompile-reconstruction/SKILL.md` (`decompile-reconstruction` route), which orchestrates `GhidraMCP` (`ghidra-reverse`), `ida-reverse`, `binary-ninja-reverse`, `go-rust-reverse`, `jadx`, `ilspycmd`, `pycdc`, and `webcrack`.
2. **Routing**: Map to the appropriate skill directory under `skills/reverse-skill/skills/` or `skills/engineering/decompile-reconstruction/`.
3. **Pre-check**: Run tool detection scripts (e.g. `skills/reverse-skill/kali/` or `skills/reverse-skill/skills/scripts/bootstrap-reverse.sh`) to verify tool paths and versions.
4. **Execution**: Perform static/dynamic analysis using precise, script-guided methods instead of "vibe guessing."
5. **Post-result**: Save findings to the Field Journal (`skills/reverse-skill/skills/field-journal/`) and generate structured vulnerability/reversing reports.

---

## 3. Mandatory Security Verification Rules

When executing tasks under this module, verification claims are bound to the following tools:

| Reversing Claim | Mandatory Verification Tool / Method | Minimum Proof Required |
|---|---|---|
| Binary / APK structure | `jadx` / `readelf` / `file` command output | Decompiled class lists or section headers |
| Exploit success / PoC | Local script execution in sandbox | Command stdout showing control/access (e.g. CTF flag) |
| Web API signature / Encryption | BurpSuite MCP or Browser replay trace | Intercepted payload or dynamic trace |
| EDR Bypass / Native Hooking | Frida hook logs or debugger registers | Hook activation logs showing memory override |

---

## 4. Location of Assets

- **Cybersecurity Skills**: `skills/reverse-skill/skills/`
- **Engineering Decompilation Reconstruction**: `skills/engineering/decompile-reconstruction/`
- **MCP Server & Tooling**: `skills/reverse-skill/burp-mcp-full/`
- **Sandbox Orchestrator**: `skills/reverse-skill/CTF-Sandbox-Orchestrator/`
- **Kali Linux Helpers**: `skills/reverse-skill/kali/`
- **Router Rules Reference**: `skills/reverse-skill/RULES.md`
