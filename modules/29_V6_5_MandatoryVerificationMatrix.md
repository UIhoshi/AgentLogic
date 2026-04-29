# V6.5 Mandatory Verification Matrix Draft

## 1. Purpose

This draft module turns the V6.5 mandatory tool-use policy into a concrete verification matrix.
It answers three questions for each conclusion type:

- which tool family must be used
- what minimum evidence must be produced
- when the result is still not strong enough to count as verified

## 2. Core Rule

If a conclusion belongs to one of the categories below, and the matching verification tool was not used, the conclusion must not be treated as fully verified.

## 3. Matrix

| Conclusion type | Mandatory tool family | Minimum pass condition | Still not verified when |
| --- | --- | --- | --- |
| Local repository fact | Local search/listing + targeted file reads | The relevant file path(s) are identified and the specific implementation location has been read directly | The conclusion is based only on memory, summaries, filenames, or search hits without direct reads |
| Latest/current/remote fact | Authoritative external read-only verification | The current fact is checked against an authoritative live source | The conclusion is based on memory, stale notes, or non-authoritative secondary references |
| UI / visible behavior | Screenshot or equivalent visual verification | A screenshot or equivalent visual artifact shows the actual state being claimed | The claim is based only on code reading, styling assumptions, or build success |
| Runtime / build / packaging claim | Command, build, or runtime verification | The relevant command or runtime path has actually been executed and its result inspected | The claim is inferred only from static files, config, or expected behavior |
| Path-sensitive write or side-effecting local command | Target-path confirmation + post-change inspection | The working directory and target path are confirmed before execution, and the changed result is inspected afterward | The command was run without target confirmation, or the post-change result was not checked |
| External state change | Local validation + remote-target confirmation + post-change verification | The change is validated locally first, the remote target is confirmed second, the remote change is executed last, and the final remote state is checked | The remote change was made first, or the final remote state was not checked |
| Permission-sensitive execution | Permission-mode and allowance verification | The current permission mode and actual allow/ask/deny posture are checked before execution | The tool was used without confirming the active permission posture |
| Behavior with ambiguous evidence | At least two independent evidence paths | Two independent evidence sources agree, such as file read + runtime result, or runtime log + screenshot | Only one weak evidence path exists and the behavior remains ambiguous |

## 4. Escalation Rule

The higher the consequence of being wrong, the stronger the verification path must be.

- low-impact conclusions may pass with one strong evidence path
- medium-impact conclusions should usually include both source evidence and execution evidence
- high-impact or irreversible conclusions should include precondition confirmation, execution evidence, and post-result verification

## 5. Tool-Evidence Matching Guidance

### 5.1 Search tools

Use them to identify candidate locations, not to close the case.
A search hit is a pointer, not proof.

### 5.2 Read tools

Use them to confirm actual implementation facts, call sites, configuration, and boundaries.

### 5.3 Command / runtime tools

Use them when the claim concerns execution, build success, runtime behavior, packaging output, or path effects.

### 5.4 Visual verification tools

Use them when the result is meant to be seen by a user.
If the claim is visual, the proof must also be visual.

### 5.5 External read-only tools

Use them for current facts, remote states, hosted settings, release metadata, or any fact that can drift over time.

## 6. Default Failure Rule

If the agent cannot show the matching evidence class for the conclusion type, the default status should be one of the following instead of "verified":

- unverified
- partially verified
- inferred but not confirmed
- blocked on required verification tool
