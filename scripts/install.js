#!/usr/bin/env node

// MANDATORY LOGIC GATE
//
// Read `AGENTS.md` and `README.md` before making changes here.
// Then follow the repository-declared logic entry chain.
// Before every new coding round, determine whether this task extends the previous round.
// If not, explicitly ask whether to forget/compress context first.
// This is a blocking gate; do not begin implementation before it is complete.

const fs = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');
const { execFileSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..');
const BEGIN_MARKER = '<!-- BEGIN AGENTLOGIC HOOK -->';
const END_MARKER = '<!-- END AGENTLOGIC HOOK -->';

function parseArgs(argv) {
  const opts = {
    host: 'generic',
    profile: 'core-enhanced',
    targetPath: '',
    userHome: os.homedir(),
  };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--host') opts.host = argv[++i] || '';
    else if (a === '--profile') opts.profile = argv[++i] || 'core-enhanced';
    else if (a === '--target-path') opts.targetPath = argv[++i] || '';
    else if (a === '--user-home') opts.userHome = argv[++i] || opts.userHome;
    else if (a === '-h' || a === '--help') {
      console.log('Usage: node scripts/install.js [--host codex|claude|antigravity|generic] [--profile NAME] [--target-path PATH] [--user-home PATH]');
      process.exit(0);
    } else {
      throw new Error(`Unknown argument: ${a}`);
    }
  }
  if (!['codex', 'claude', 'antigravity', 'generic'].includes(opts.host)) {
    throw new Error(`Unsupported host '${opts.host}'. Expected codex, claude, antigravity, or generic.`);
  }
  return opts;
}

function toFileUriPath(p) {
  return path.resolve(p).replace(/\\/g, '/').replace(/^\/+/, '');
}

function sha256(filePath) {
  return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

function copyDirClean(src, dest) {
  if (fs.existsSync(dest)) fs.rmSync(dest, { recursive: true, force: true });
  fs.mkdirSync(dest, { recursive: true });
  fs.cpSync(src, dest, { recursive: true });
}

function timestampSlug() {
  const d = new Date();
  const pad = (n) => String(n).padStart(2, '0');
  return `${d.getFullYear()}${pad(d.getMonth() + 1)}${pad(d.getDate())}-${pad(d.getHours())}${pad(d.getMinutes())}${pad(d.getSeconds())}`;
}

function buildBundleContent(manifest, profileName, targetHost) {
  const profile = manifest.profiles?.[profileName];
  if (!profile || !Array.isArray(profile.files) || profile.files.length === 0) {
    throw new Error(`Unknown or empty profile: ${profileName}`);
  }
  const emDash = '\u2014';
  const zhStartup = '\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002';
  const lines = [
    `# MANDATORY AGENT EXECUTIVE PROTOCOL (AgentLogic ${manifest.current_version})`,
    '',
    `- Host target: ${targetHost}`,
    `- Profile: ${profileName}`,
    `- Stable entry: ${manifest.entry}`,
    `- Version: ${manifest.current_version}`,
    '',
    '> [!CRITICAL]',
    '> **CROSS-HOST MANDATORY BLOCKING GATES (Antigravity / Claude Code / OpenAI Codex / Generic)**:',
    '>',
    `> **Gate 1 ${emDash} Startup Context-Reset & Autonomous Role Recommendation Gate (Turn 1 Blocking)**:`,
    `> Do NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or formal non-continuation task (coding, planning, UI, creative, Office, or audit ${emDash} trivial 1-turn read-only Q&A may answer directly without blocking), you MUST interactively execute BOTH:`,
    '> 1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to `forget/compress context` (in the user\'s active language):',
    `>    - Chinese: '${zhStartup}'`,
    ">    - English: 'Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context.'",
    '> 2. **Autonomous Role Recommendation & Dual-Axis Subagent Squads (`role-persona-router` / `contracts/role-personas.json`)**: Analyze the project domain, recommend the #1 best-fit Lead Role (with a 1-sentence rationale; plus a 1-line Supporting Subagent Squad for complex cross-domain tasks), and present the 11-role menu (`[1] Principal Systems Architect & Full-Stack Lead`, `[2] UI/UX Creative Design Director`, `[3] Reverse Engineering Specialist`, `[4] Management Consultant & Office Architect`, `[5] Multimodal Creative Director`, `[6] Chief Showrunner & Novel Architect`, `[7] Enterprise Flowchart Cartographer`, `[8] AppSec & DevSecOps Guardian`, `[9] Data Analytics & Visualization Architect`, `[10] Interactive Game & Graphics Lead`, `[11] Screenwriter, Manga-Script & Short-Video Showrunner`). When spawning subagents, assign BOTH execution posture (`explore|plan|implement|review|verify`) and specialist sub-role (`[1]-[11]`, `codebase-explorer`, or `independent-verifier`), propagate `Bound Skills`, enforce disjoint write ownership, and keep `max_depth = 1`.',
    '>',
    `> **Gate 2 ${emDash} Pure UI Design (\`ui-ux-pro-max\`) + Mandatory Text-to-Image Preview Gate (Blocking Before UI Code)**:`,
    '> Before writing or modifying production frontend/UI code for any new UI or substantial redesign (unless the user explicitly opts out): (a) run `product-requirements-grilling` one question at a time -> (b) run `ui-ux-pro-max` (`skills/design/ui-ux-pro-max/SKILL.md`) to derive a pure UI/UX design specification (industry color palette, font pairing, grid anatomy) -> (c) combine that specification with `imagegen` / `image-generator` / `multimodal-media-director` / `nano-banana-pro` to generate a visual UI mockup image -> (d) obtain user approval before writing UI code; (e) enforce real-world media download + `read_file` visual inspection for real-world SVGs/Canvas/animations and side-by-side Design QA (`P0`/`P1`/`P2` blocking loop) after implementation.',
    '>',
    `> **Gate 3 ${emDash} Skill-First Reflex & Auto-Use Domain Capabilities (Zero Manual Skill Selection)**:`,
    '> **SKILL-FIRST REFLEX HABIT**: Never wait for the user to name a skill. Before writing code, designing UI/charts, reviewing security/PRs, creating Office/PDF/media/games, or auditing skills, ALWAYS run a 3-second Scenario -> Skill scan; on any match, immediately read its `SKILL.md`, announce `[Skill Activated: <name>]`, and execute it by default (chaining multiple skills across multi-domain tasks):',
    '> - **Binaries / Bytecode / Obfuscated Bundles** -> `decompile-reconstruction` (`GhidraMCP` / `ida-reverse` / `jadx` / `ilspycmd` / `pycdc` / `webcrack`)',
    '> - **Post-Implementation Polish / Code Refactoring** -> `code-simplifier` (`ast-grep` structural rewrite + guard clauses + zero behavior regression)',
    '> - **Word / Excel / PPT / PDF Documents (`.docx`/`.xlsx`/`.pptx`/`.pdf`)** -> `office-pro-suite` (Word styles/three-line tables, live Excel formulas + tie-out QA, 16:9 action-title slides + QC, PDF `pdftoppm` visual inspection)',
    '> - **Text-to-Image / Video / Programmatic Video / Music** -> `multimodal-media-director` (art direction, shot-by-shot camera storyboards, Remotion/HyperFrames code video, BPM/Key/Metatag arrangement)',
    '> - **Novel / Fiction / Script Writing** -> `novel-story-architect` (`.story-bible/` continuity compiler, scene beat sheets, anti-AI-cliche prose filter)',
    '> - **Flowcharts / Swimlanes / Architecture Diagrams** -> `diagram-flowchart-architect` (`.drawio` XML, `.excalidraw` JSON, and themed `Mermaid`)',
    '> - **Modern Web Frontend (HTML/CSS/DOM/JS/CWV/A11y)** -> `modern-web-guidance` (query `npx -y modern-web-guidance@latest` or local `guides/` first, plus `legacy-scan`)',
    '> - **Chrome / Browser Extensions (Manifest V3 & Web Store)** -> `chrome-extensions` (MV3 service workers, side panels, CSP sandboxes, store compliance)',
    '> - **Security Review / Diff Audit / Threat Model / Ownership** -> `appsec-review` (diff-scoped reachability, `SECURITY.md` resolution, `confirmed`/`not_actionable`/`needs_review` verdicts, STRIDE)',
    '> - **Web Data Visualization (Charts / Dashboards / Maps / D3 / Vega / Canvas2D)** -> `web-data-visualization` (evidence-bearing encodings, dual desktop/mobile views, URL state, a11y)',
    '> - **2D / 3D Browser Games (Phaser / Canvas2D / Three.js / R3F)** -> `web-game-studio` (modular `core/entities/ui`, asset pipeline, browser playtest loop)',
    '> - **GitHub Actions CI Failures & PR Review Comments (`gh` CLI)** -> `gh-pr-ci-triage` (verify `gh auth status`, inspect logs/threads, plan before fixing)',
    '> - **Skill & Plugin Quality / Token-Budget Evaluation** -> `skill-evaluator` (`At a Glance` / `Fix First` report, frontmatter/links/token budget)',
    '> - **Manga/Webtoon Scripts, Short-Video/Micro-Drama Scripts, & Screenplays** -> `screenplay-manga-director` (panel breakdown, 0-3s hook multi-track table, `INT./EXT.` format, `.story-bible/` & media handoff)',
    '',
    'This is a generated primary-logic bundle. Regenerate it from scripts/build-profile.ps1 instead of editing it by hand.',
    '',
  ];

  for (const rel of profile.files) {
    const full = path.join(REPO_ROOT, ...rel.split('/'));
    if (!fs.existsSync(full)) throw new Error(`Profile file missing: ${rel}`);
    let content = fs.readFileSync(full, 'utf8').trimEnd();
    if (rel.toLowerCase().endsWith('.json')) {
      content = JSON.stringify(JSON.parse(content));
    }
    lines.push('---', '', `## BEGIN FILE: ${rel}`, '', content, '', `## END FILE: ${rel}`, '');
  }
  return lines.join('\n').replace(/\r\n|\r|\n/g, '\n');
}

function renderHook({ bundlePath, skillsRoot, enforcementRoot }) {
  const emDash = '\u2014';
  const zhStartup = '\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002';
  const zhSkipMockup = '\u4e0d\u9700\u8981\u5148\u753b\u56fe';
  const repoUri = toFileUriPath(REPO_ROOT);
  const bundleUri = toFileUriPath(bundlePath);
  const bundleFile = path.basename(bundlePath);
  const enfScriptUri = toFileUriPath(path.join(enforcementRoot, 'scripts', 'skill-enforcement.ps1'));
  const rolePersonasUri = toFileUriPath(path.join(enforcementRoot, 'contracts', 'role-personas.json'));
  const skillsUri = toFileUriPath(skillsRoot);

  return `${BEGIN_MARKER}
# Local AgentLogic Precedence Rule

- The agent MUST prioritize the local AgentLogic rule-set (located at [AgentLogic](file:///${repoUri})) as the highest-priority logic and execute its mandatory reading chain and blocking gates first.
- Full reference rules and contracts live on disk in [${bundleFile}](file:///${bundleUri}) and [role-personas.json](file:///${rolePersonasUri}). Read them on demand rather than duplicating them inline; the four non-negotiable blocking gates and automatic skill triggers are inlined directly below and MUST be executed in every workspace:

## Gate 1: Startup Context-Reset & Autonomous Role Recommendation Gate (Turn 1 Blocking ${emDash} Formal Projects)
- **EXECUTION vs SUMMARIZATION MANDATE**: You MUST NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or formal non-continuation task (coding, planning, UI, creative, Office, or audit ${emDash} trivial single-turn read-only Q&A with no edits or artifacts may answer directly), you MUST ACTUALLY EXECUTE BOTH steps below interactively:
  1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to \`forget/compress context\` in the user's interaction language:
     - Chinese: "${zhStartup}"
     - English: "Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context."
  2. **Autonomous Role Recommendation & Dual-Axis Subagent Squads ([role-persona-router](file:///${skillsUri}/role-persona-router/SKILL.md))**:
     - Analyze the user's project/task, **recommend the #1 best-fit Lead Role (with a 1-sentence rationale)** (plus a 1-line **Supporting Subagent Squad** ONLY when cross-domain/multi-module complexity warrants it), and display the compact 11-role selection menu so the user can approve or switch roles:
       - \`[1] Principal Systems Architect & Full-Stack Lead\`
       - \`[2] UI/UX Creative Design Director & Frontend Craftsman\`
       - \`[3] Reverse Engineering & Clean-Room Reconstruction Specialist\`
       - \`[4] Management Consultant & Financial/Office Architect\`
       - \`[5] Multimodal Creative Director (Image / Video / Code Video / Music)\`
       - \`[6] Chief Showrunner & Long-Form Novel Architect\`
       - \`[7] Enterprise Architecture & Flowchart Cartographer\`
       - \`[8] AppSec & DevSecOps Security Guardian\`
       - \`[9] Data Analytics & Visualization Architect\`
       - \`[10] Interactive Game & Creative Graphics Lead\`
       - \`[11] Screenwriter, Manga-Script & Short-Video Showrunner\`
     - **Subagent Role Assignment**: When spawning any subagent in complex tasks, assign BOTH Axis A (\`explore|plan|implement|review|verify\`) and Axis B (\`[1]\`-\`[11]\` or \`codebase-explorer\` / \`independent-verifier\`), propagate required \`SKILL.md\` paths (\`Bound Skills\`), enforce disjoint write ownership, and keep \`max_depth = 1\`.
- To prevent the "limited initial view" issue, proactively scan the \`AgentLogic\` directory or read [${bundleFile}](file:///${bundleUri}) on demand when deeper module rules are needed.

## Gate 2: Pure UI Design (\`ui-ux-pro-max\`) + Mandatory Text-to-Image Mockup Gate (BLOCKING Before Any UI Code)
- **WHEN TRIGGERED**: Whenever starting a new project with a UI, adding a net-new page/screen/component, or performing a substantial UI refactor/redesign.
- **HARD BLOCK**: You MUST NOT write or edit production UI/frontend code (\`.html\`, \`.css\`, \`.scss\`, \`.jsx\`, \`.tsx\`, \`.vue\`, \`.svelte\`, or UI layout/style blocks) until ALL of the following steps are completed, **UNLESS the user explicitly opts out** (e.g., explicitly says "${zhSkipMockup}" / "skip mockup"):
  1. **Single-Question Requirements Grilling**: Read and follow [product-requirements-grilling](file:///${skillsUri}/product-requirements-grilling/SKILL.md). Ask one unresolved product/UI decision question at a time, write \`.specify/<task>/requirements-brief.md\`, and obtain user approval.
  2. **Pure UI/UX Design Specification First ([ui-ux-pro-max](file:///${skillsUri}/ui-ux-pro-max/SKILL.md))**: Before generating any mockup or writing any code, derive the structured visual design specification (palette, typography, grid).
  3. **Mandatory Text-to-Image Mockup Generation (\`image-generator\` / [multimodal-media-director](file:///${skillsUri}/multimodal-media-director/SKILL.md) / \`nano-banana-pro\`)**: Generate a visual UI mockup, save it to \`.specify/mockups/\` (or artifact directory), present both spec and image, and wait for approval before UI code.
  4. **Workflow State Recording**: Record route progression via [skill-enforcement.ps1](file:///${enfScriptUri}).
  5. **Real-World Visual & Motion Reference Grounding & Side-by-Side Design QA**: Download real reference images/GIFs/videos locally and inspect via \`read_file\` for real-world subjects (avoid stick-puppet tubes), and run side-by-side Design QA (\`?t=\` for animations; fix any P0/P1/P2 gap).

## Gate 3: Skill-First Reflex & Auto-Use Domain Capabilities (Zero Manual Skill Selection)
- **SKILL-FIRST REFLEX HABIT (NON-NEGOTIABLE)**: Always run a 3-second Scenario -> Skill scan. On ANY match, read its \`SKILL.md\`, announce \`[Skill Activated: <name>]\`, and execute it by default ${emDash} never improvise from memory:
  1. **Compiled Binaries / Bytecode / Obfuscated Bundles** -> [decompile-reconstruction](file:///${skillsUri}/decompile-reconstruction/SKILL.md)
  2. **Post-Implementation Polish & Refactoring** -> [code-simplifier](file:///${skillsUri}/code-simplifier/SKILL.md)
  3. **Word / Excel / PPT / PDF Documents** -> [office-pro-suite](file:///${skillsUri}/office-pro-suite/SKILL.md)
  4. **Text-to-Image / Video / Programmatic Video / Music** -> [multimodal-media-director](file:///${skillsUri}/multimodal-media-director/SKILL.md)
  5. **Long-Form Novel & Fiction** -> [novel-story-architect](file:///${skillsUri}/novel-story-architect/SKILL.md)
  6. **Flowcharts & System Architecture Diagrams** -> [diagram-flowchart-architect](file:///${skillsUri}/diagram-flowchart-architect/SKILL.md)
  7. **Modern Web Frontend (HTML/CSS/DOM/JS/CWV/A11y)** -> [modern-web-guidance](file:///${skillsUri}/modern-web-guidance/SKILL.md)
  8. **Chrome / Browser Extensions (MV3)** -> [chrome-extensions](file:///${skillsUri}/chrome-extensions/SKILL.md)
  9. **Security Review, Diff Audit & Threat Model** -> [appsec-review](file:///${skillsUri}/appsec-review/SKILL.md)
  10. **Web Data Visualization (Charts / Dashboards / Maps)** -> [web-data-visualization](file:///${skillsUri}/web-data-visualization/SKILL.md)
  11. **2D / 3D Browser Games** -> [web-game-studio](file:///${skillsUri}/web-game-studio/SKILL.md)
  12. **GitHub Actions CI & PR Review Threads** -> [gh-pr-ci-triage](file:///${skillsUri}/gh-pr-ci-triage/SKILL.md)
  13. **Skill & Plugin Quality / Token-Budget Evaluation** -> [skill-evaluator](file:///${skillsUri}/skill-evaluator/SKILL.md)
  14. **Manga / Short-Video / Micro-Drama / Screenplays** -> [screenplay-manga-director](file:///${skillsUri}/screenplay-manga-director/SKILL.md)

## Gate 4: Project-Native Knowledge Sync & Verification Matrix
- Before business-project implementation, run \`git fetch --prune\` (when available) and read \`AGENTS.md\`, \`PROJECT_MAP.md\`, \`CODE_MAP.md\`, and \`.learnings/ERRORS.md\`; update them in the same commit as structural, key-flow, or error-lesson changes.
- After UI implementation, always verify visual rendering, container boundaries, and overflow with browser/screenshot evidence before claiming completion.
${END_MARKER}`;
}

function upsertBoundedHook(targetPath, host, hookText, userHome) {
  fs.mkdirSync(path.dirname(targetPath), { recursive: true });
  if (!fs.existsSync(targetPath)) {
    fs.writeFileSync(targetPath, `${hookText}\n`, 'utf8');
    return;
  }
  const existing = fs.readFileSync(targetPath, 'utf8');
  const bIdx = existing.indexOf(BEGIN_MARKER);
  const eIdx = existing.indexOf(END_MARKER);
  if (bIdx >= 0 && eIdx > bIdx) {
    const before = existing.slice(0, bIdx).replace(/[\r\n]+$/, '');
    const after = existing.slice(eIdx + END_MARKER.length).replace(/^[\r\n]+/, '');
    const parts = [];
    if (before.trim()) parts.push(before);
    parts.push(hookText);
    if (after.trim()) parts.push(after);
    fs.writeFileSync(targetPath, `${parts.join('\n\n')}\n`, 'utf8');
    return;
  }

  if (userHome) {
    const bakDir = path.join(userHome, '.agentlogic-backup', timestampSlug());
    fs.mkdirSync(bakDir, { recursive: true });
    fs.copyFileSync(targetPath, path.join(bakDir, `${host}.${path.basename(targetPath)}.bak`));
  }

  const legacyIdx = existing.indexOf('# Local AgentLogic Precedence Rule');
  const legacyBundleIdx = existing.indexOf('# MANDATORY AGENT EXECUTIVE PROTOCOL (AgentLogic');
  let updated;
  if (legacyIdx >= 0) {
    const before = existing.slice(0, legacyIdx).replace(/[\r\n]+$/, '');
    updated = before.trim() ? `${before}\n\n${hookText}\n` : `${hookText}\n`;
  } else if (legacyBundleIdx === 0 || (host === 'codex' && path.basename(targetPath) === 'model_instructions.md')) {
    updated = `${hookText}\n`;
  } else {
    const trimmed = existing.trimEnd();
    updated = trimmed ? `${trimmed}\n\n${hookText}\n` : `${hookText}\n`;
  }
  fs.writeFileSync(targetPath, updated, 'utf8');
}

function deployFirstPartySkills(skillsRoot) {
  const cap = JSON.parse(fs.readFileSync(path.join(REPO_ROOT, 'contracts', 'host-skill-capabilities.json'), 'utf8'));
  const list = [
    { id: cap.first_party_skill, source: cap.source },
    ...(cap.additional_first_party_skills || []),
  ];
  fs.mkdirSync(skillsRoot, { recursive: true });
  for (const item of list) {
    const src = path.join(REPO_ROOT, ...item.source.split('/'));
    const dest = path.join(skillsRoot, item.id);
    if (!fs.existsSync(path.join(src, 'SKILL.md'))) {
      throw new Error(`Missing first-party skill '${item.id}' at ${src}`);
    }
    copyDirClean(src, dest);
  }
  return list.length;
}

function deployEnforcementPayload(targetDir) {
  const payload = [
    'scripts/skill-enforcement.ps1',
    'contracts/skill-enforcement.json',
    'contracts/skill-routing.json',
    'contracts/skill-registry.json',
    'contracts/skill-workflow-graph.json',
    'contracts/role-personas.json',
  ];
  for (const rel of payload) {
    const src = path.join(REPO_ROOT, ...rel.split('/'));
    const dst = path.join(targetDir, ...rel.split('/'));
    fs.mkdirSync(path.dirname(dst), { recursive: true });
    fs.copyFileSync(src, dst);
    if (sha256(src) !== sha256(dst)) {
      throw new Error(`Enforcement payload SHA-256 verification failed: ${rel}`);
    }
  }
}

function buildCodexPlugin(manifest, outputDir) {
  const rawVersion = String(manifest.current_version).replace(/^[Vv]/, '');
  const metaDir = path.join(outputDir, '.codex-plugin');
  const marketDir = path.join(outputDir, '.agents', 'plugins');
  const skillsDir = path.join(outputDir, 'skills');
  fs.mkdirSync(metaDir, { recursive: true });
  fs.mkdirSync(marketDir, { recursive: true });
  deployFirstPartySkills(skillsDir);

  const pluginJson = {
    name: 'agentlogic',
    version: rawVersion,
    description: 'AgentLogic cross-host governance, Turn 1 11-role & Subagent squad routing, design-first UI mockups, and 17 habitual auto-triggered first-party skills.',
    author: { name: 'UIhoshi', url: 'https://github.com/UIhoshi/AgentLogic' },
    homepage: 'https://github.com/UIhoshi/AgentLogic',
    repository: 'https://github.com/UIhoshi/AgentLogic',
    license: 'MIT',
    keywords: ['agentlogic', 'codex', 'governance', 'sdd', 'ui-ux', 'appsec', 'data-visualization', 'skills'],
    skills: './skills/',
    interface: {
      displayName: 'AgentLogic',
      shortDescription: 'Habitual auto-triggered skills and blocking quality gates',
      category: 'Developer Tools',
      capabilities: ['Interactive', 'Read', 'Write'],
      websiteURL: 'https://github.com/UIhoshi/AgentLogic',
    },
  };
  const marketJson = {
    name: 'agentlogic-local',
    interface: { displayName: 'AgentLogic Local Plugin Marketplace' },
    plugins: [{
      name: 'agentlogic',
      source: { source: 'local', path: './' },
      policy: { installation: 'AVAILABLE', authentication: 'ON_INSTALL' },
      category: 'Developer Tools',
    }],
  };
  fs.writeFileSync(path.join(metaDir, 'plugin.json'), `${JSON.stringify(pluginJson, null, 2)}\n`, 'utf8');
  fs.writeFileSync(path.join(marketDir, 'marketplace.json'), `${JSON.stringify(marketJson, null, 2)}\n`, 'utf8');
}

function main() {
  const opts = parseArgs(process.argv.slice(2));
  console.log('Preflight: checking repository logic entry...');
  execFileSync(process.execPath, [path.join(REPO_ROOT, 'scripts', 'check-logic-entry.js')], { stdio: 'inherit' });

  const manifest = JSON.parse(fs.readFileSync(path.join(REPO_ROOT, 'manifest.json'), 'utf8'));
  const bundleText = buildBundleContent(manifest, opts.profile, opts.host);

  let bundlePath;
  let skillsRoot;
  let enforcementRoot;
  const installedTargets = [];

  if (opts.host === 'antigravity') {
    const hookTarget = opts.targetPath || path.join(opts.userHome, '.gemini', 'GEMINI.md');
    bundlePath = path.join(opts.userHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'AGENTS_BUNDLE.md');
    skillsRoot = path.join(opts.userHome, '.gemini', 'skills');
    enforcementRoot = path.join(opts.userHome, '.gemini', 'antigravity-cli', 'AgentLogic', 'skill-enforcement');

    fs.mkdirSync(path.dirname(bundlePath), { recursive: true });
    fs.writeFileSync(bundlePath, bundleText, 'utf8');
    const hookText = renderHook({ bundlePath, skillsRoot, enforcementRoot });
    upsertBoundedHook(hookTarget, 'antigravity', hookText, opts.userHome);
    installedTargets.push(hookTarget, bundlePath);
    if (!opts.targetPath) {
      const legacyTarget = path.join(opts.userHome, '.gemini', 'AgentLogic', 'GEMINI.md');
      upsertBoundedHook(legacyTarget, 'antigravity', hookText, opts.userHome);
      installedTargets.push(legacyTarget);
    }

    const cfgPath = path.join(opts.userHome, '.gemini', 'config', 'skills.json');
    fs.mkdirSync(path.dirname(cfgPath), { recursive: true });
    let cfg = { entries: [] };
    if (fs.existsSync(cfgPath)) {
      try { cfg = JSON.parse(fs.readFileSync(cfgPath, 'utf8') || '{}'); } catch { cfg = {}; }
    }
    const entries = Array.isArray(cfg.entries) ? cfg.entries : [];
    if (!entries.some((e) => e && (e.path === '~/.gemini/skills' || e.path === skillsRoot.replace(/\\/g, '/')))) {
      entries.push({ path: '~/.gemini/skills' });
    }
    cfg.entries = entries;
    fs.writeFileSync(cfgPath, `${JSON.stringify(cfg, null, 2)}\n`, 'utf8');
  } else if (opts.host === 'claude') {
    bundlePath = opts.targetPath || path.join(opts.userHome, '.claude', 'AgentLogic', 'CLAUDE.md');
    skillsRoot = path.join(opts.userHome, '.claude', 'skills');
    enforcementRoot = path.join(opts.userHome, '.claude', 'AgentLogic', 'skill-enforcement');

    fs.mkdirSync(path.dirname(bundlePath), { recursive: true });
    fs.writeFileSync(bundlePath, bundleText, 'utf8');
    installedTargets.push(bundlePath);
    if (!opts.targetPath) {
      const rootClaudeMd = path.join(opts.userHome, '.claude', 'CLAUDE.md');
      upsertBoundedHook(rootClaudeMd, 'claude', renderHook({ bundlePath, skillsRoot, enforcementRoot }), opts.userHome);
      installedTargets.push(rootClaudeMd);
    }
  } else if (opts.host === 'codex') {
    const codexDir = path.join(opts.userHome, '.codex', 'agentlogic');
    bundlePath = path.join(codexDir, 'AGENTLOGIC_BUNDLE.md');
    const hookTarget = path.join(codexDir, 'model_instructions.md');
    const cfgPath = path.join(opts.userHome, '.codex', 'config.toml');
    skillsRoot = path.join(opts.userHome, '.codex', 'skills');
    enforcementRoot = path.join(codexDir, 'skill-enforcement');

    fs.mkdirSync(codexDir, { recursive: true });
    fs.writeFileSync(bundlePath, bundleText, 'utf8');
    upsertBoundedHook(hookTarget, 'codex', renderHook({ bundlePath, skillsRoot, enforcementRoot }), opts.userHome);
    installedTargets.push(hookTarget, bundlePath);

    fs.mkdirSync(path.dirname(cfgPath), { recursive: true });
    const existingCfg = fs.existsSync(cfgPath) ? fs.readFileSync(cfgPath, 'utf8') : '';
    const line = `model_instructions_file = "${hookTarget.replace(/\\/g, '/').replace(/"/g, '\\"')}"`;
    let updatedCfg;
    const matchCfg = existingCfg.match(/^model_instructions_file\s*=.*$/m);
    if (matchCfg) {
      if (matchCfg[0].trim() !== line && opts.userHome) {
        const bakDir = path.join(opts.userHome, '.agentlogic-backup', timestampSlug());
        fs.mkdirSync(bakDir, { recursive: true });
        fs.copyFileSync(cfgPath, path.join(bakDir, 'codex.config.toml.bak'));
      }
      updatedCfg = existingCfg.replace(/^model_instructions_file\s*=.*$/m, () => line);
    } else {
      const idx = existingCfg.search(/^\[/m);
      if (idx >= 0) {
        const before = existingCfg.slice(0, idx).trimEnd();
        const rest = existingCfg.slice(idx).replace(/^[\r\n]+/, '');
        updatedCfg = (before ? `${before}\n` : '') + `${line}\n${rest}`;
      } else {
        const trimmed = existingCfg.trimEnd();
        updatedCfg = (trimmed ? `${trimmed}\n` : '') + `${line}\n`;
      }
    }
    fs.writeFileSync(cfgPath, updatedCfg, 'utf8');
    buildCodexPlugin(manifest, path.join(codexDir, 'codex-plugin'));
  } else {
    bundlePath = opts.targetPath || path.join(REPO_ROOT, 'dist', 'generic', 'AGENTLOGIC.md');
    const bundleDir = path.dirname(bundlePath);
    skillsRoot = path.join(bundleDir, 'skills');
    enforcementRoot = path.join(bundleDir, 'skill-enforcement');
    fs.mkdirSync(bundleDir, { recursive: true });
    fs.writeFileSync(bundlePath, bundleText, 'utf8');
    installedTargets.push(bundlePath);
  }

  const deployedCount = deployFirstPartySkills(skillsRoot);
  deployEnforcementPayload(enforcementRoot);

  for (const t of installedTargets) {
    if (!fs.existsSync(t)) throw new Error(`Missing installed target: ${t}`);
  }
  const reqSkill = path.join(skillsRoot, 'product-requirements-grilling', 'SKILL.md');
  if (!fs.existsSync(reqSkill)) throw new Error(`Missing deployed skill: ${reqSkill}`);

  console.log(`Installed AgentLogic (${manifest.current_version}) into ${opts.host} via Node.js installer.`);
  console.log(`Verified targets: ${installedTargets.join(', ')}`);
  console.log(`Deployed first-party skills: ${deployedCount} -> ${skillsRoot}`);
  console.log(`Verified workflow-enforcement payload: ${enforcementRoot}`);
}

main();
