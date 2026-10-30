# Portable Skill Catalog

Generated from contracts/skill-registry.json. It recommends only selection postures; availability, permissions, trust, and route closure remain separate.

## skills-agent-browser-skill-data-agentcore-skill-md
- Entry: `skills/agent-browser/skill-data/agentcore/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Run agent-browser on AWS Bedrock AgentCore cloud browsers. Use when the user wants to use AgentCore, run browser automation on AWS, use a cloud browser with AWS credentials, or needs a managed browser session backed by AWS infrastructure. Triggers include "use agentcore", "run on…
- Explicit signals: explicit_user_request, dynamic_browser_or_session_task, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-agent-browser-skill-data-core-skill-md
- Entry: `skills/agent-browser/skill-data/core/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Core agent-browser usage guide. Read this before running any agent-browser commands. Covers the snapshot-and-ref workflow, navigating pages, interacting with elements (click, fill, type, select), extracting text and data, taking screenshots, managing tabs, handling forms and auth…
- Explicit signals: explicit_user_request, dynamic_browser_or_session_task, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-agent-browser-skill-data-dogfood-skill-md
- Entry: `skills/agent-browser/skill-data/dogfood/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Systematically explore and test a web application to find bugs, UX issues, and other problems. Use when asked to "dogfood", "QA", "exploratory test", "find issues", "bug hunt", "test this app/site/platform", or review the quality of a web application. Produces a structured report…
- Explicit signals: explore, application, bugs,, issues,, reproducible, findings.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-agent-browser-skill-data-electron-skill-md
- Entry: `skills/agent-browser/skill-data/electron/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Automate Electron desktop apps (VS Code, Slack, Discord, Figma, Notion, Spotify, etc.) using agent-browser via Chrome DevTools Protocol. Use when the user needs to interact with an Electron app, automate a desktop app, connect to a running app, control a native app, or test an El…
- Explicit signals: explicit_user_request, dynamic_browser_or_session_task, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-agent-browser-skill-data-slack-skill-md
- Entry: `skills/agent-browser/skill-data/slack/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Interact with Slack workspaces using browser automation. Use when the user needs to check unread channels, navigate Slack, send messages, extract data, find information, search conversations, or automate any Slack task. Triggers include "check my Slack", "what channels have unrea…
- Explicit signals: explicit_user_request, dynamic_browser_or_session_task, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-agent-browser-skill-data-vercel-sandbox-skill-md
- Entry: `skills/agent-browser/skill-data/vercel-sandbox/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Run agent-browser + Chrome inside Vercel Sandbox microVMs for browser automation from any Vercel-deployed app. Use when the user needs browser automation in a Vercel app (Next.js, SvelteKit, Nuxt, Remix, Astro, etc.), wants to run headless Chrome without binary size limits, needs…
- Explicit signals: explicit_user_request, dynamic_browser_or_session_task, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-agent-browser-skills-agent-browser-skill-md
- Entry: `skills/agent-browser/skills/agent-browser/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Browser automation CLI for AI agents. Use when the user needs to interact with websites, including navigating pages, filling forms, clicking buttons, taking screenshots, extracting data, testing web apps, or automating any browser task. Triggers include requests to "open a websit…
- Explicit signals: browser_ui_verification, dynamic_web_flow
- Inferred signals: 
- Confirmation: route_enforced

## skills-creative-multimodal-media-director-skill-md
- Entry: `skills/creative/multimodal-media-director/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Automatically direct and execute text-to-image, text-to-video, and text-to-music generation workflows.
- Explicit signals: text-to-image, text-to-video, text-to-music, generate image, generate video, generate music, bgm
- Inferred signals: visual mockup generation, video storyboard, musical arrangement
- Confirmation: automatic_for_matched_route

## skills-creative-novel-story-architect-skill-md
- Entry: `skills/creative/novel-story-architect/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Automatically manage Story Bibles, scene beat sheets, anti-AI-cliche drafting, and continuity checks for novels and stories.
- Explicit signals: novel, fiction, story writing, chapter, world-building, screenplay
- Inferred signals: long-form narrative, character arc, plot outline
- Confirmation: automatic_for_matched_route

## skills-design-ui-ux-pro-max-skill-md
- Entry: `skills/design/ui-ux-pro-max/SKILL.md`
- Lifecycle / posture: `mandatory` / `route_candidate`
- Purpose: Derive pure UI/UX design specifications and mandatory text-to-image mockup prompts before any frontend implementation.
- Explicit signals: ui design, frontend design, color palette, typography pairing, ui mockup
- Inferred signals: new page or screen, substantial interface redesign
- Confirmation: automatic_for_matched_route

## skills-engineering-ask-matt-skill-md
- Entry: `skills/engineering/ask-matt/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Ask which skill or flow fits your situation. A router over the skills in this repo.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-codebase-design-skill-md
- Entry: `skills/engineering/codebase-design/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes, make code more testable or AI-navigable, or when another skill needs the deep-module vocabulary.
- Explicit signals: design, deep, module, boundaries,, interfaces,, seams,, testability.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-code-review-skill-md
- Entry: `skills/engineering/code-review/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Review the changes since a fixed point (commit, branch, tag, or merge-base) along two axes — Standards (does the code follow this repo's documented coding standards?) and Spec (does the code match what the originating issue/PRD asked for?). Runs both reviews in parallel sub-agent…
- Explicit signals: code_audit, pull_request_review, release_review
- Inferred signals: 
- Confirmation: route_enforced

## skills-engineering-code-simplifier-skill-md
- Entry: `skills/engineering/code-simplifier/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Autonomous post-implementation code refinement, AST-aware structural refactoring, and 80/20 code-smell cleanup without altering behavior. Triggered automatically after feature/refactor implementation or when simplifying, cleaning up, or refactoring code.
- Explicit signals: code_refinement
- Inferred signals: 
- Confirmation: route_enforced

## skills-engineering-decompile-reconstruction-skill-md
- Entry: `skills/engineering/decompile-reconstruction/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Autonomous binary/bytecode/bundle decompilation and clean-room source code reconstruction. Triggered automatically when the user provides or asks to analyze, decompile, deobfuscate, or recover readable/compilable source code or algorithms from compiled binaries (PE/ELF/Mach-O/DLL/SO), Android APKs/JARs, .NET assemblies, Python bytecode (.pyc), WASM, or bundled/minified/obfuscated JS/Electron apps.
- Explicit signals: decompile_reconstruction
- Inferred signals: 
- Confirmation: route_enforced

## skills-engineering-diagnosing-bugs-skill-md
- Entry: `skills/engineering/diagnosing-bugs/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Diagnosis loop for hard bugs and performance regressions. Use when the user says "diagnose"/"debug this", or reports something broken/throwing/failing/slow.
- Explicit signals: diagnose, bugs,, failures,, regressions,, performance, problems.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-diagram-flowchart-architect-skill-md
- Entry: `skills/engineering/diagram-flowchart-architect/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Automatically generate zero-overlap flowcharts, swimlanes, and architecture diagrams in .drawio, .excalidraw, and Mermaid.
- Explicit signals: flowchart, diagram, drawio, excalidraw, mermaid, architecture diagram, swimlane
- Inferred signals: process map, sequence diagram, system topology
- Confirmation: automatic_for_matched_route

## skills-engineering-domain-modeling-skill-md
- Entry: `skills/engineering/domain-modeling/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Build and sharpen a project's domain model. Use when the user wants to pin down domain terminology or a ubiquitous language, record an architectural decision, or when another skill needs to maintain the domain model.
- Explicit signals: define, domain, vocabulary,, bounded, contexts,, architectural, terminology.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-grill-with-docs-skill-md
- Entry: `skills/engineering/grill-with-docs/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: A relentless interview to sharpen a plan or design, which also creates docs (ADR's and glossary) as we go.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-implement-skill-md
- Entry: `skills/engineering/implement/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Implement a piece of work based on a spec or set of tickets.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-improve-codebase-architecture-skill-md
- Entry: `skills/engineering/improve-codebase-architecture/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-prototype-skill-md
- Entry: `skills/engineering/prototype/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-research-skill-md
- Entry: `skills/engineering/research/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
- Explicit signals: research, question, with, high-trust, primary, sources.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-resolving-merge-conflicts-skill-md
- Entry: `skills/engineering/resolving-merge-conflicts/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Use when you need to resolve an in-progress git merge/rebase conflict.
- Explicit signals: resolve, in-progress, merge, rebase, conflict.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-setup-matt-pocock-skills-skill-md
- Entry: `skills/engineering/setup-matt-pocock-skills/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Configure this repo for the engineering skills — set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-tdd-skill-md
- Entry: `skills/engineering/tdd/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-to-spec-skill-md
- Entry: `skills/engineering/to-spec/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Turn the current conversation into a spec and publish it to the project issue tracker — no interview, just synthesis of what you've already discussed.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-to-tickets-skill-md
- Entry: `skills/engineering/to-tickets/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Break a plan, spec, or the current conversation into a set of tracer-bullet tickets, each declaring its blocking edges, published to the configured tracker — edges as text in one file per ticket locally, or native blocking links on a real tracker.
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-engineering-triage-skill-md
- Entry: `skills/engineering/triage/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Move issues and external PRs through a state machine of triage roles — categorise, verify, grill if needed, and write agent-ready briefs.
- Explicit signals: triage, issues, external, pull, requests, into, agent-ready, briefs.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-engineering-wayfinder-skill-md
- Entry: `skills/engineering/wayfinder/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Plan a huge chunk of work — more than one agent session can hold — as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.
- Explicit signals: plan, long-running, work, across, multiple, sessions, using, decision, tickets.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-nano-banana-pro-skill-md
- Entry: `skills/nano-banana-pro/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Generate or edit images via Gemini 3 Pro Image (Nano Banana Pro).
- Explicit signals: net_new_ui, substantial_ui_refactor
- Inferred signals: 
- Confirmation: route_enforced

## skills-ponytail-skill-md
- Entry: `skills/ponytail/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: >
- Explicit signals: behavior_change, coverage_gap, test_design
- Inferred signals: 
- Confirmation: route_enforced

## skills-ponytail-audit-skill-md
- Entry: `skills/ponytail-audit/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: >
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-ponytail-debt-skill-md
- Entry: `skills/ponytail-debt/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: >
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-ponytail-gain-skill-md
- Entry: `skills/ponytail-gain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: >
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-ponytail-help-skill-md
- Entry: `skills/ponytail-help/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: >
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-ponytail-review-skill-md
- Entry: `skills/ponytail-review/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: >
- Explicit signals: explicit_user_request, task_specific_domain_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-productivity-grilling-skill-md
- Entry: `skills/productivity/grilling/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
- Explicit signals: explicit_user_request, product_workflow_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-productivity-grill-me-skill-md
- Entry: `skills/productivity/grill-me/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: A relentless interview to sharpen a plan or design.
- Explicit signals: explicit_user_request, product_workflow_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-productivity-handoff-skill-md
- Entry: `skills/productivity/handoff/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Compact the current conversation into a handoff document for another agent to pick up.
- Explicit signals: create, compact, handoff, resume, packet, another, agent.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-productivity-office-pro-suite-skill-md
- Entry: `skills/productivity/office-pro-suite/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Automatically enforce executive typography in Word, dynamic formula modeling in Excel, and action-title visual design in PowerPoint.
- Explicit signals: word, docx, excel, xlsx, powerpoint, pptx, office document
- Inferred signals: spreadsheet model, presentation deck, formal report document
- Confirmation: automatic_for_matched_route

## skills-productivity-product-requirements-grilling-skill-md
- Entry: `skills/productivity/product-requirements-grilling/SKILL.md`
- Lifecycle / posture: `mandatory` / `route_candidate`
- Purpose: Clarify product requirements and net-new or substantially redesigned UI before specification, mockup generation, or implementation. Use for new projects, major features, new screens, substantial layout changes, bookings, payments, permissions, and other high-impact user flows. As…
- Explicit signals: major_feature, net_new_ui, substantial_ui_refactor
- Inferred signals: 
- Confirmation: route_enforced

## skills-productivity-role-persona-router-skill-md
- Entry: `skills/productivity/role-persona-router/SKILL.md`
- Lifecycle / posture: `mandatory` / `route_candidate`
- Purpose: Automatically recommend the best-fit expert role and present the 7-role selection menu at the start of every new project.
- Explicit signals: role selection, persona recommendation, new project kickoff, expert role menu
- Inferred signals: turn 1 project start, non-continuation task kickoff
- Confirmation: automatic_for_matched_route

## skills-productivity-teach-skill-md
- Entry: `skills/productivity/teach/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Teach the user a new skill or concept, within this workspace.
- Explicit signals: explicit_user_request, product_workflow_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-productivity-writing-great-skills-skill-md
- Entry: `skills/productivity/writing-great-skills/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Reference for writing and editing skills well — the vocabulary and principles that make a skill predictable.
- Explicit signals: explicit_user_request, product_workflow_match, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-ad-certificate-abuse-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-ad-certificate-abuse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for AD CS, certificate templates, enrollment rights, EKUs, SAN controls, PKINIT, certificate mapping, and cert-based privilege paths. Use when the user asks about ESC-style abuse, certificate templates,…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-agent-cloud-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-agent-cloud/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for AI-agent, prompt-injection, MCP or toolchain, cloud, container, CI/CD, and supply-chain challenges. Use when the user asks to analyze prompt-to-tool flows, retrieval poisoning, mounted secrets, deplo…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-android-hooking-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-android-hooking/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Android APK hooking, Frida tracing, request-signing recovery, SSL pinning bypass, JNI boundary inspection, and app trust-boundary analysis. Use when the user asks to hook an APK, inspect signer logic…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-browser-persistence-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-browser-persistence/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for browser cookies, localStorage, sessionStorage, IndexedDB, Cache Storage, service workers, offline caches, and client-side session persistence. Use when the user asks to inspect browser state, replay…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-bundle-sourcemap-recovery-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-bundle-sourcemap-recovery/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for source maps, build manifests, chunk registries, emitted bundles, obfuscated loader flow, and frontend runtime recovery. Use when the user asks to reconstruct served JavaScript structure, inspect sour…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-cloud-metadata-path-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-cloud-metadata-path/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for cloud metadata services, instance identity, workload identity, link-local credential paths, role assumption, and metadata-to-privilege trust edges. Use when the user asks to inspect metadata-service…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-container-runtime-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-container-runtime/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for live container runtime analysis, mounted secrets, sidecars, namespaces, init containers, entrypoint drift, and route-to-container resolution. Use when the user asks why a live container differs from…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-crypto-mobile-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-crypto-mobile/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for crypto, encoding, steganography, APK, IPA, and mobile trust-boundary challenges. Use when the user asks to decode a blob, recover a transform chain or key, inspect hidden media payloads, hook an APK…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-custom-protocol-replay-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-custom-protocol-replay/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for custom binary or text protocol recovery, handshake reconstruction, framing, sequence control, checksums, stateful replay, and accepted-session reproduction. Use when the user asks to decode an unknow…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-dpapi-credential-chain-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-dpapi-credential-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for DPAPI masterkeys, vault blobs, browser credential stores, protected secrets, domain backup keys, and secret-to-acceptance replay chains. Use when the user asks to inspect DPAPI blobs or masterkeys, r…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-file-parser-chain-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-file-parser-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for file uploads, imports, previews, archive extraction, format conversion, parser invocation, and deserialization chains. Use when the user asks to inspect an upload or import path, trace archive extrac…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-firmware-layout-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-firmware-layout/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for firmware images, partition tables, boot chains, update packages, extracted filesystems, embedded configs, and device-facing trust boundaries. Use when the user asks to unpack firmware, map partition…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-forensic-timeline-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-forensic-timeline/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for DFIR chronology, cross-artifact correlation, persistence chains, and incident timeline reconstruction. Use when the user asks to build a forensic timeline, correlate EVTX, PCAP, registry, disk, memor…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-graphql-rpc-drift-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-graphql-rpc-drift/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for GraphQL schemas, persisted queries, RPC manifests, generated clients, OpenAPI drift, hidden operations, and contract-to-handler mismatches. Use when the user asks to inspect GraphQL or RPC requests,…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-identity-windows-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-identity-windows/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Active Directory, Kerberos, LDAP, OAuth, enterprise messaging, Windows host forensics, credential material, and lateral-movement challenges. Use when the user asks to trace tickets or tokens, inspect…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-ios-runtime-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-ios-runtime/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for IPA runtime analysis, Frida hooks, Objective-C or Swift method tracing, Keychain inspection, SSL pinning bypass, URL scheme handling, and iOS request-signing recovery. Use when the user asks to hook…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-jwt-claim-confusion-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-jwt-claim-confusion/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for JWT, JWS, and JWE validation paths, header parsing, key selection, claim acceptance, audience and issuer checks, role derivation, and token-to-identity confusion bugs. Use when the user asks to inspe…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-k8s-control-plane-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-k8s-control-plane/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Kubernetes API analysis, service-account trust, RBAC edges, admission and controller behavior, cluster secrets, workload mutation, and namespace-scoped drift. Use when the user asks to inspect kube A…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-kerberos-delegation-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-kerberos-delegation/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Kerberos delegation, SPN trust edges, S4U abuse, RBCD, constrained or unconstrained delegation, and service-ticket acceptance. Use when the user asks about constrained delegation, unconstrained deleg…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-kernel-container-escape-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-kernel-container-escape/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for kernel attack surface, namespace and cgroup boundaries, container isolation assumptions, syscall paths, and escape primitive verification. Use when the user asks to analyze container-to-host escape p…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-linux-credential-pivot-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-linux-credential-pivot/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Linux credential artifacts, service tokens, SSH material, cloud and container secrets, socket-level trust, and host-to-host pivot chains. Use when the user asks to trace Linux auth artifacts, accepte…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-lsass-ticket-material-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-lsass-ticket-material/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for LSASS-resident secrets, Windows logon sessions, Kerberos ticket caches, DPAPI-backed material, SSP artifacts, and replayable credential extraction. Use when the user asks to inspect LSASS memory, rec…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-mailbox-abuse-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-mailbox-abuse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for enterprise mail abuse, OAuth consent, inbox or forwarding rules, transport rules, shared mailbox access, phishing chains, and token-to-mailbox side effects. Use when the user asks to trace mailbox ru…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-malware-config-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-malware-config/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for malware configuration recovery, staged payload boundaries, beacon parameter extraction, and IOC decoding. Use when the user asks to recover a malware config, decode C2 or beacon fields, unpack staged…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-oauth-oidc-chain-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-oauth-oidc-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for OAuth, OIDC, redirect flows, state or nonce handling, PKCE, token exchange, refresh logic, claim mapping, and accepted login paths. Use when the user asks to trace redirects, callback parameters, sco…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-pcap-protocol-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-pcap-protocol/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for packet capture analysis, session reconstruction, application-protocol decoding, stream reassembly, beacon timing, and packet-to-process correlation. Use when the user asks to analyze a PCAP, rebuild…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-prompt-injection-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-prompt-injection/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for prompt-injection, retrieval poisoning, memory contamination, planner drift, MCP or tool-boundary abuse, and agent exfiltration challenges. Use when the user asks to analyze prompt injection, retrieva…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-queue-worker-drift-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-queue-worker-drift/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for queues, async workers, cron jobs, delayed tasks, retry behavior, worker-only config drift, and payload-to-side-effect chains. Use when the user asks to trace a queue payload, inspect async job execut…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-race-condition-state-drift-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-race-condition-state-drift/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for race windows, ordering bugs, idempotency failures, lock gaps, concurrent worker drift, and state inconsistencies that produce decisive effects. Use when the user asks to reproduce timing-sensitive bu…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-relay-coercion-chain-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-relay-coercion-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for forced-auth coercion, relay chains, target selection, NTLM or related acceptance paths, and coercion-to-privilege transitions. Use when the user asks to trace a coercion primitive, follow a relay pat…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-request-normalization-smuggling-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-request-normalization-smuggling/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for parser differentials, HTTP normalization gaps, ambiguous headers, path decoding drift, transfer-framing mismatches, and request smuggling routes. Use when the user asks to trace proxy and backend par…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-reverse-pwn-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-reverse-pwn/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for reverse engineering, malware, DFIR, firmware, pwnable, and native exploit challenges. Use when the user asks to reverse a binary, unpack a sample, inspect a memory dump or PCAP, recover malware behav…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-runtime-routing-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-runtime-routing/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for reverse proxies, Host headers, forwarded headers, vhost routing, websocket upgrades, path-prefix rewriting, base-URL derivation, and multi-node route resolution. Use when the user asks which host or…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-ssrf-metadata-pivot-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-ssrf-metadata-pivot/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for SSRF reachability, internal route probing, metadata-service access, credential pivoting, and token-to-accepted-privilege chains. Use when the user asks to trace SSRF sources, internal hosts, metadata…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-stego-media-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-stego-media/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for image, audio, video, document, and container steganography. Use when the user asks to inspect metadata, alpha or palette channels, LSBs, thumbnails, appended trailers, QR fragments, transcoding artif…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-supply-chain-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-supply-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for CI/CD, registry, dependency drift, artifact provenance, image build, release pipeline, and runtime consumer challenges. Use when the user asks to trace dependency drift, registry pulls, malicious pac…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-template-render-path-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-template-render-path/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for SSR, template rendering, route loaders, hydration payloads, server-client render boundaries, and template-to-handler enforcement gaps. Use when the user asks to inspect SSR or template routes, trace…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-web-runtime-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-web-runtime/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for CTF web, API, SSR, frontend, queue-backed app, and routing challenges. Use when the user asks to inspect a site or API, follow real browser requests, debug auth or session flow, trace uploads or work…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-websocket-runtime-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-websocket-runtime/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for WebSocket and SSE handshakes, auth material, subscription state, realtime message schemas, reconnect behavior, and frame-driven runtime effects. Use when the user asks to inspect a WebSocket or SSE h…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-competition-windows-pivot-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/competition-windows-pivot/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Internal downstream skill for ctf-sandbox-orchestrator. CTF-sandbox workflow for Kerberos, WinRM, SMB, RDP, Windows credential material, replayable tickets, delegation edges, and host-to-host pivot chains. Use when the user asks to replay Kerberos material, trace a WinRM, SMB, or…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-ctf-sandbox-orchestrator-ctf-sandbox-orchestrator-skill-md
- Entry: `skills/reverse-skill/CTF-Sandbox-Orchestrator/ctf-sandbox-orchestrator/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Default entrypoint and master ctf-sandbox-orchestrator workflow for CTF, exploit, reverse engineering, DFIR, pwnable, crypto, stego, mobile, AI-agent, cloud, container, Active Directory, Windows-host, and identity challenges. Use first when the user presents challenge infrastruct…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-api-security-skill-md
- Entry: `skills/reverse-skill/skills/api-security/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-apk-reverse-skill-md
- Entry: `skills/reverse-skill/skills/apk-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: 在 CLI 环境下做 Android APK 逆向时使用。适用于 APK 解包、Java 反编译、smali 修改、重打包、Frida 动态 Hook，以及按需切换到 so/native 分析。优先使用本机已安装的 jadx、apktool、frida、adb、ida-reverse、radare2。
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-attack-chain-skill-md
- Entry: `skills/reverse-skill/skills/attack-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-binary-diff-skill-md
- Entry: `skills/reverse-skill/skills/binary-diff/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-browser-automation-skill-md
- Entry: `skills/reverse-skill/skills/browser-automation/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-diagram-generator-skill-md
- Entry: `skills/reverse-skill/skills/diagram-generator/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: generate, refine, validate, and render diagrams from natural language, notes, code snippets, schemas, tables, or existing diagram source. use for flowcharts, swimlanes, sequence diagrams, state diagrams, er diagrams, class diagrams, architecture/c4-style diagrams, dependency grap…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-docs-generator-skill-md
- Entry: `skills/reverse-skill/skills/docs-generator/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-dotnet-reverse-skill-md
- Entry: `skills/reverse-skill/skills/dotnet-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: .NET / C# 二进制逆向。当目标是 .NET assembly（PE 头含 CLR、.exe/.dll 托管程序）、C# 编译产物（含 NativeAOT）、红队 Sharp* 工具（Rubeus / SharpHound / SharpHound 等）、.NET 混淆程序（ConfuserEx / SmartAssembly / Babel / Eazfuscator）、.NET loader / info-stealer / 套壳 malware 时使用。优先用 dnSpyEx + de4dot，需要 AI 直接操作时联动 dnSpy MCP。…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-edr-bypass-re-skill-md
- Entry: `skills/reverse-skill/skills/edr-bypass-re/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-firmware-pentest-skill-md
- Entry: `skills/reverse-skill/skills/firmware-pentest/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-ida-reverse-skill-md
- Entry: `skills/reverse-skill/skills/ida-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-js-reverse-skill-md
- Entry: `skills/reverse-skill/skills/js-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: 在使用 js-reverse-mcp 做前端 JavaScript 逆向时使用，适用于签名链路定位、页面观察取证、运行时采样、本地补环境复现与证据化输出。优先适配当前环境里的 js-reverse_* 工具，需要更强的浏览器/CDP/Hook 面时联动 jshookmcp。
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-llm-security-skill-md
- Entry: `skills/reverse-skill/skills/llm-security/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-malware-analysis-skill-md
- Entry: `skills/reverse-skill/skills/malware-analysis/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-mobile-reverse-skill-md
- Entry: `skills/reverse-skill/skills/mobile-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-patch-diff-exploit-skill-md
- Entry: `skills/reverse-skill/skills/patch-diff-exploit/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-pentest-tools-skill-md
- Entry: `skills/reverse-skill/skills/pentest-tools/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-pentest-tools-src-hunter-skill-md
- Entry: `skills/reverse-skill/skills/pentest-tools/src-hunter/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: 实战 SRC / 众测 / Bug bounty 漏洞挖掘工作流 skill。包含：5 阶段方法论（intake → recon → enum → hunt → report）、19 个攻击类 playbook（SQLi/XSS/RCE/SSRF/IDOR/CSRF/Path Traversal/File Upload/SSTI/XXE/Race/HTTP Smuggling/OAuth/JWT/SAML/GraphQL/Mobile/LLM/DoS）、305 个结构化 payload、263 个 WAF/EDR 绕过变体、2887 份 HackerOn…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-pwn-chain-skill-md
- Entry: `skills/reverse-skill/skills/pwn-chain/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-radare2-skill-md
- Entry: `skills/reverse-skill/skills/radare2/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: |
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-reverse-engineering-dsl-vm-reverse-skill-md
- Entry: `skills/reverse-skill/skills/reverse-engineering/dsl-vm-reverse/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-reverse-engineering-skill-md
- Entry: `skills/reverse-skill/skills/reverse-engineering/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Provides reverse engineering techniques. Use when the main job is to understand how a compiled, obfuscated, packed, or virtualized target works before exploiting or solving it, including binaries, APKs, WASM, firmware, custom VMs, bytecode, malware-like loaders, and anti-debug or…
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-skill-md
- Entry: `skills/reverse-skill/skills/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-reverse-skill-skills-supply-chain-security-skill-md
- Entry: `skills/reverse-skill/skills/supply-chain-security/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Security and CTF specialty requires explicit classification and trust/risk review.
- Explicit signals: explicit_user_request, authorized_security_or_ctf_scope, isolated_or_approved_environment
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-self-improvement-self-improving-agent-skill-md
- Entry: `skills/self-improvement/self-improving-agent/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Captures learnings, errors, and corrections to enable continuous improvement. Use when: (1) A command or operation fails unexpectedly, (2) User corrects Claude ('No, that's wrong...', 'Actually...'), (3) User requests a capability that doesn't exist, (4) An external API or tool f…
- Explicit signals: explicit_user_request, verified_redacted_lesson, no_autonomous_persistent_write
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-brandkit-skill-md
- Entry: `skills/taste-skill/skills/brandkit/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Premium brand-kit image generation skill for creating high-end brand-guidelines boards, logo systems, identity decks, and visual-world presentations. Trained for minimalist, cinematic, editorial, dark-tech, luxury, cultural, security, gaming, developer-tool, and consumer-app bran…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-brutalist-skill-skill-md
- Entry: `skills/taste-skill/skills/brutalist-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Raw mechanical interfaces fusing Swiss typographic print with military terminal aesthetics. Rigid grids, extreme type scale contrast, utilitarian color, analog degradation effects. For data-heavy dashboards, portfolios, or editorial sites that need to feel like declassified bluep…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-gpt-tasteskill-skill-md
- Entry: `skills/taste-skill/skills/gpt-tasteskill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Elite UX/UI & Advanced GSAP Motion Engineer. Enforces Python-driven true randomization for layout variance, strict AIDA page structure, wide editorial typography (bans 6-line wraps), gapless bento grids, strict GSAP ScrollTriggers (pinning, stacking, scrubbing), inline micro-imag…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-imagegen-frontend-mobile-skill-md
- Entry: `skills/taste-skill/skills/imagegen-frontend-mobile/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Elite mobile app image-generation skill for creating premium, app-native screen concepts and flows. Designed for iOS, Android, and cross-platform mobile products. Prioritizes clean hierarchy, comfortably readable text, strong multi-screen consistency, controlled color palettes, n…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-imagegen-frontend-web-skill-md
- Entry: `skills/taste-skill/skills/imagegen-frontend-web/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Elite frontend image-direction skill for generating premium, conversion-aware website design references. CRITICAL OUTPUT RULE — generate ONE separate horizontal image FOR EVERY section. A landing page with 8 sections produces 8 images. Never compress multiple sections into one im…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-image-to-code-skill-skill-md
- Entry: `skills/taste-skill/skills/image-to-code-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Elite website image-to-code skill for Codex. For visually important web tasks, it must first generate the design image(s) itself, deeply analyze them, then implement the website to match them as closely as possible. In Codex, it must prefer large, readable, section-specific image…
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-minimalist-skill-skill-md
- Entry: `skills/taste-skill/skills/minimalist-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Clean editorial-style interfaces. Warm monochrome palette, typographic contrast, flat bento grids, muted pastels. No gradients, no heavy shadows.
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-output-skill-skill-md
- Entry: `skills/taste-skill/skills/output-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Overrides default LLM truncation behavior. Enforces complete code generation, bans placeholder patterns, and handles token-limit splits cleanly. Apply to any task requiring exhaustive, unabridged output.
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-redesign-skill-skill-md
- Entry: `skills/taste-skill/skills/redesign-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `guided_candidate`
- Purpose: Upgrades existing websites and apps to premium quality. Audits current design, identifies generic AI patterns, and applies high-end design standards without breaking functionality. Works with any CSS framework or vanilla CSS.
- Explicit signals: redesign, visually, upgrade, existing, website, application.
- Inferred signals: task_brief_matches_reviewed_purpose
- Confirmation: single_confirmation_when_competing_candidates_match

## skills-taste-skill-skills-soft-skill-skill-md
- Entry: `skills/taste-skill/skills/soft-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Teaches the AI to design like a high-end agency. Defines the exact fonts, spacing, shadows, card structures, and animations that make a website feel expensive. Blocks all the common defaults that make AI designs look cheap or generic.
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-stitch-skill-skill-md
- Entry: `skills/taste-skill/skills/stitch-skill/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: Semantic Design System Skill for Google Stitch. Generates agent-friendly DESIGN.md files that enforce premium, anti-generic UI standards — strict typography, calibrated color, asymmetric layouts, perpetual micro-motion, and hardware-accelerated performance.
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

## skills-taste-skill-skills-taste-skill-skill-md
- Entry: `skills/taste-skill/skills/taste-skill/SKILL.md`
- Lifecycle / posture: `conditional` / `route_candidate`
- Purpose: Anti-slop frontend skill for landing pages, portfolios, and redesigns. The agent reads the brief, infers the right design direction, and ships interfaces that do not look templated. Real design systems when applicable, audit-first on redesigns, strict pre-flight check.
- Explicit signals: net_new_ui, substantial_ui_refactor
- Inferred signals: 
- Confirmation: route_enforced

## skills-taste-skill-skills-taste-skill-v1-skill-md
- Entry: `skills/taste-skill/skills/taste-skill-v1/SKILL.md`
- Lifecycle / posture: `manual_only` / `manual`
- Purpose: The original v1 taste-skill, preserved for projects depending on its exact behavior. The current default is `design-taste-frontend` (v2 experimental), which is a substantial rewrite. Use this v1 install name only if you need exact backward compatibility.
- Explicit signals: explicit_user_request, visual_design_workflow, permission_and_scope_confirmed
- Inferred signals: 
- Confirmation: explicit_user_intent_required

