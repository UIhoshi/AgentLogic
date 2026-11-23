---
name: gh-pr-ci-triage
description: Debug failing GitHub Pull Request CI checks (GitHub Actions logs) and address PR review or issue comments systematically using the gh CLI. Trigger automatically when inspecting failing GitHub Actions PR checks or resolving GitHub PR review threads.
---

# GitHub PR & CI Triage (`gh-pr-ci-triage`)

This skill synthesizes the **Apache-2.0** `gh-fix-ci` and `gh-address-comments` workflows (`openai/skills`) for deterministic, plan-before-edit GitHub PR diagnostics via the `gh` CLI.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill whenever the user asks to:
- Debug, inspect, or fix failing GitHub PR checks or GitHub Actions workflow runs.
- Review, triage, or resolve open PR review threads or issue comments on the current branch's GitHub PR.

---

## 2. Preconditions

1. Verify GitHub CLI availability and authentication first:
   ```bash
   gh auth status
   ```
2. If `gh` is missing or unauthenticated (or lacks `repo`/`workflow` scope), stop and instruct the user to run `gh auth login` rather than guessing remote CI state.

---

## 3. Mode A: Failing PR Checks Triage (`gh-fix-ci`)

1. **Resolve PR**:
   - Prefer the current branch PR (`gh pr view --json number,url,headRefName`), or use the user-supplied PR number/URL.
2. **Inspect Checks & Scope Provider**:
   - Run `gh pr checks <pr> --json name,state,bucket,link,startedAt,completedAt,workflow` (if a field is rejected by an older `gh` version, retry with supported fields).
   - **External Provider Boundary**: GitHub Actions runs are in scope; external CI systems (e.g., Buildkite, CircleCI, Jenkins) are out of log-fetch scope — report their `link` URL and status honestly without fabricating logs.
3. **Fetch Actionable Failure Logs**:
   - Extract the run ID from the failing check's `link` URL and run:
     - `gh run view <run_id> --json name,workflowName,conclusion,status,url,event,headBranch,headSha`
     - `gh run view <run_id> --log-failed` (or `gh run view <run_id> --log` / `gh api repos/{owner}/{repo}/actions/jobs/{job_id}/logs` if the run is still in progress).
4. **Summarize & Plan Before Editing**:
   - Extract the exact failing step, command, and error snippet (root cause, not noisy tail lines).
   - Draft a concise fix plan, obtain approval when the fix crosses non-trivial boundaries, apply bounded edits, and run matching local checks before reporting resolution.

---

## 4. Mode B: PR Review Comment Resolution (`gh-address-comments`)

1. **Collect All Feedback**:
   - Fetch general PR comments and inline review threads via `gh pr view <pr> --comments --json comments,reviews` and GraphQL/REST review-thread queries (`gh api graphql` or `gh api repos/{owner}/{repo}/pulls/{pr}/comments`).
2. **Number & Group Actionable Items**:
   - Deduplicate resolved/outdated threads; group remaining comments by file and severity (Correctness/Security vs. Style/Question).
3. **Execute & Verify**:
   - Apply targeted fixes for valid findings (or prepare factual responses where a reviewer premise does not hold), run tests, and present a clear per-comment resolution summary before any push/reply.

---

## 5. Attribution
- Synthesized from `openai/skills` (`gh-fix-ci`, `gh-address-comments` — `Apache-2.0` License).
