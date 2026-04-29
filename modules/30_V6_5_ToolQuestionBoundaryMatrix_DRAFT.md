# V6.5 Tool Question-Boundary Matrix Draft

## 1. Purpose

This draft module defines which question types each tool family is allowed to answer strongly, which question types it may only support indirectly, and which question types it must not answer alone.

The goal is to prevent tool waste in one direction and false certainty in the other:

- do not ignore tools that are required for good verification
- do not let a weak tool family pretend to answer a stronger question than it can actually justify

## 2. Core Rule

A tool family may only close a question type when its evidence class is strong enough for that question.
If the evidence class is weaker than the question requires, the tool may assist but must not close the question by itself.

## 3. Matrix

| Tool family | Strongly allowed question types | Support-only question types | Must not answer alone |
| --- | --- | --- | --- |
| Local search / listing | Where is the likely entrypoint? Which files mention this symbol or pattern? Which directory likely owns this behavior? | What is the actual implementation? What is the true runtime path? | Final implementation facts, runtime behavior, UI-visible outcome, current remote state |
| Targeted local reads | What does this file or function actually do? What config or boundary is explicitly declared? | Does the whole system truly behave this way at runtime? | UI-visible outcome, runtime execution result, current remote state |
| Command / runtime / build tools | Does it build? Does the command run? What artifact was produced? What runtime path actually happened? | Why is the code written this way? Which design rule should govern it? | Final UI visual quality, current remote setting unless the command actually queries it authoritatively |
| Screenshot / visual verification | What does the user-visible state actually look like right now? Did the UI regress visually? | Why the UI looks this way in code | Hidden internal logic, invisible state transitions without visual evidence |
| External read-only verification | What is the current remote fact, release state, hosted setting, or live metadata? | How is the local implementation structured? | Local implementation facts, local runtime claims, local path effects |
| Local edit / write tools | Applying a change after the question has already been answered by stronger evidence | Testing whether a candidate fix changes behavior when combined with verification tools | Discovery, fact-finding, current remote fact verification |
| External write / change tools | Applying a confirmed remote change after local and target validation | Verifying whether a planned remote update is technically possible | Fact discovery, first-pass diagnosis, proof of safety by themselves |
| Planning / orchestration tools | Decomposing work, sequencing tools, assigning verification paths | Summarizing already gathered evidence | Closing factual questions without the underlying evidence tools |

## 4. Common Failure Patterns

### 4.1 Search-hit closure

Failure pattern:
- a symbol is found by search
- the agent treats the search hit as proof of implementation

Correct posture:
- search narrows the candidate set
- targeted reads confirm the actual fact

### 4.2 Read-only closure on runtime questions

Failure pattern:
- config or code looks correct
- the agent treats expected behavior as observed behavior

Correct posture:
- if the claim is about execution, use execution evidence

### 4.3 Build-success closure on UI questions

Failure pattern:
- the build passes
- the agent concludes the visible behavior is fixed

Correct posture:
- if the claim is visual, the proof must be visual

### 4.4 Remote-memory closure

Failure pattern:
- the agent remembers a release state, setting, or hosted fact
- the agent answers without current authoritative verification

Correct posture:
- if the fact can drift over time, verify it live

## 5. Escalation Rule

When the first tool family cannot close the question safely, escalate to the next stronger evidence class rather than forcing a weak tool to over-answer.

Typical escalation patterns:

- search -> read
- read -> runtime/build
- read -> screenshot
- local validation -> external verification
- planning -> actual evidence tools

## 6. Default Output Labels

If the current tool family can only support but not close the question, the answer should use a weaker label such as:

- likely location only
- implementation suggests
- inferred from static read
- needs runtime confirmation
- needs visual confirmation
- needs authoritative remote verification
