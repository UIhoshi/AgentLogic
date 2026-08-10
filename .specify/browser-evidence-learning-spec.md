# Browser Evidence Learning Record

## Scope

Document one material execution error in the tracked learning log.

## Incident

A direct HTTP request to a public webpage returned an anti-bot verification page. The task was
initially reported as blocked instead of using the available real-browser evidence path. A browser
snapshot subsequently confirmed that the requested page rendered normally.

## Required learning

For public web-content tasks, a transport-level HTTP response is not conclusive evidence that the
page is inaccessible. If the task requires rendered content and a browser capability is available,
attempt a normal browser snapshot before reporting the page inaccessible. Do not bypass CAPTCHAs,
authentication, or access controls.

## Non-goals

- Do not turn a single incident into a global mandatory rule.
- Do not change generated bundles or host adapters.
- Do not record user data, local paths, raw logs, or browser session data.
