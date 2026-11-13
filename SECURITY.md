# Security Policy

## Scope & Authorized Use

AgentLogic is a rule, skill, and workflow governance framework for coding agents. It includes defensive security auditing, clean-room reverse-engineering, and authorized CTF/sandbox orchestration skills (`skills/reverse-skill/`, `decompile-reconstruction`) intended strictly for:

- Authorized security assessments, vulnerability research, and defensive hardening
- Clean-room interoperability analysis and authorized binary/source auditing
- Sandboxed educational and CTF environments

These capabilities MUST NOT be used for unauthorized access, exploitation of unowned systems, malware authoring, or bypassing access controls.

## Reporting a Vulnerability or Hygiene Issue

If you discover a security vulnerability, accidental secret, or unsafe rule/script behavior in this repository:

1. **Do not** open a public issue with sensitive details or exploit payloads.
2. Report it privately via GitHub Security Advisories (once public) or directly to the repository maintainer (`UIhoshi`).
3. Include affected file paths, reproduction steps, and suggested remediation where possible.

## Repository Hygiene

- Personal paths, credentials, API tokens, and private `reference/` archives must never be committed.
- Security/pentest reference documentation must defang active script/payload tags to prevent accidental execution or scanner false-positives.
