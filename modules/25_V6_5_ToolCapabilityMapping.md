# V6.5 Stable Module: Tool Capability Mapping

Status: stable V6.5 module.
This module maps tool families to the kinds of questions they are appropriate to answer.

---

## 1. Why this module exists

A tool is not just "available" or "unavailable".
A tool has an appropriate question shape.

If the agent uses the wrong tool for the wrong question, failure usually looks like one of these:

- weak evidence
- fake certainty
- wasted latency
- unnecessary risk
- correct tool, wrong time

Therefore V6.5 should map each tool family to:

- what question it is good at answering
- what must be true before it is used
- what it should not be used for
- what evidence it produces

---

## 2. Search and listing tools

Examples:

- grep
- glob
- tree / directory listing
- symbol search
- route search

### Best at answering

- Where is the likely entrypoint?
- Which files mention this symbol or concept?
- How many times does this pattern appear?
- Which directories probably own this behavior?
- Is this capability likely centralized or scattered?

### Preconditions

- the repository path is known
- the search pattern is meaningful enough to narrow the field

### Do not use for

- proving exact runtime behavior by itself
- proving call order by itself
- proving a capability is actually enabled by itself

### Evidence produced

- candidate file set
- pattern distribution
- likely ownership surface

### Follow-up tool normally required

- local file read

---

## 3. Local file read tools

Examples:

- direct file open/read
- targeted source excerpt inspection
- config / markdown inspection

### Best at answering

- What does this implementation actually do?
- What arguments or contracts exist here?
- What does the entry file say?
- What does the README or module doc require?
- What is the real boundary of this function/module?

### Preconditions

- the candidate file is already known or strongly suspected

### Do not use for

- repo-wide discovery when no target exists yet
- validating runtime behavior that only execution can prove

### Evidence produced

- direct implementation truth
- direct documentation truth
- contract detail

### Follow-up tools often required

- additional file read
- edit/write
- command validation

---

## 4. Local edit/write tools

Examples:

- file edit
- file write
- patch application
- targeted codemod

### Best at answering

These tools do **not** answer questions well.
They exist to implement already-justified changes.

### Preconditions

- the owning file is known
- the required change is understood
- the task boundary is explicit
- the rollback path is understood

### Do not use for

- discovery
- speculation
- "trying random things"

### Evidence produced

- changed state only

### Required follow-up

- command/runtime/build/test validation
- documentation sync when appropriate

---

## 5. Local command tools

Examples:

- build
- test
- lint
- runtime launch
- package install
- git status / diff / log
- shell inspection commands

### Best at answering

- Does it build?
- Does it run?
- Which files actually changed?
- Is the environment missing something?
- Does the package manager or runtime agree with the code reading?
- What happens on this platform in practice?

### Preconditions

- working directory is correct
- command effect is understood
- read-only vs state-changing behavior is known

### Do not use for

- replacing local source reading when implementation facts are needed
- broad destructive mutation before path verification

### Evidence produced

- build truth
- runtime truth
- environment truth
- concrete failure logs

### Special note

Commands are often the strongest validation tool, but not always the correct first discovery tool.

---

## 6. External read-only tools

Examples:

- web search
- official docs lookup
- release notes lookup
- remote repository inspection

### Best at answering

- What is the current upstream version?
- What does the official documentation say now?
- Has this release/API/library changed recently?
- What is the current public state of the remote repository?

### Preconditions

- there is a real chance the answer changed recently
- local files are insufficient for the question
- the source authority matters

### Do not use for

- replacing codebase reading for local implementation truth
- answering stable local questions that the repository already contains

### Evidence produced

- current remote truth
- authoritative documentation truth

### Required follow-up

- explicitly separate remote fact from local fact

---

## 7. External write/change tools

Examples:

- push
- release publish
- repository setting changes
- visibility changes
- remote configuration mutation

### Best at answering

These tools do not answer investigative questions.
They apply confirmed decisions to external state.

### Preconditions

- the user wants the external state changed
- the target is confirmed
- local validation already happened
- risk/rollback is understood

### Do not use for

- exploration
- trial-and-error validation
- "let's see if production accepts it"

### Evidence produced

- changed remote state

### Required follow-up

- post-change verification
- path/URL/visibility confirmation

---

## 8. Planning and orchestration tools

Examples:

- explicit plan mode
- worktree switching
- task queues
- sub-agent delegation
- teammate or swarm dispatch

### Best at answering

- How should this work be decomposed?
- Which parts are independent?
- What should happen in parallel versus serially?
- Where should boundaries and ownership live?

### Preconditions

- the task is complex enough to justify orchestration
- the host allows these tools
- delegation boundaries are explicit

### Do not use for

- avoiding local responsibility for the critical-path task
- replacing direct thinking with procedure theater

### Evidence produced

- structure of work
- ownership map
- sequencing plan

---

## 9. Capability-to-question cheat sheet

| Question Type | Best Tool Family |
|---|---|
| "Where is this implemented?" | Search/listing |
| "What exactly does this file do?" | Local file read |
| "Can I safely change this now?" | Local read first, then edit |
| "Does it actually build/run?" | Local commands |
| "What is the latest official version/rule/doc?" | External read-only |
| "Can I publish or push now?" | External write only after local validation |
| "How should I split this complex task?" | Planning/orchestration |

---

## 10. Minimum question discipline

Before choosing a tool, the agent should ask internally:

1. Is this a location question, truth question, mutation question, runtime question, current-remote-fact question, or decomposition question?
2. Which tool family is naturally aligned with that question?
3. Is there a lower-risk tool that can answer it first?
4. What evidence will this tool actually produce?

That short internal check is usually enough to prevent most poor tool choices.
