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
const { TextDecoder } = require('util');

const ROOT = path.resolve(__dirname, '..');

const REQUIRED_REPO_DOCS = ['AGENTS.md', 'README.md'];
const REQUIRED_LOGIC_CHAIN_ANCHORS = [
  '00_START_HERE.md',
  'modules/01_MasterLogic.md',
  'modules/15_LogicEntryChecklist.md',
];

const ENTRY_FILES = ['00_START_HERE.md', 'AGENTS.md', 'README.md', 'MAIN.md'];

// These files are executable entrypoints, not leaf implementation files. They must carry
// the same short gate so direct script invocation cannot bypass repository entry rules.
const OPERATIONAL_ENTRY_FILES = [
  'install.ps1',
  'install.sh',
  'scripts/check-logic-entry.js',
  'scripts/doctor.ps1',
  'scripts/validate-package.ps1',
  'scripts/build-profile.ps1',
  'scripts/maintainer-check.ps1',
  'scripts/skills-governance.ps1',
  'scripts/validate-skill-routing.ps1',
  'scripts/validate-requirements-brief.ps1',
  'scripts/deploy-first-party-skill.ps1',
  'adapters/codex/install.ps1',
  'adapters/claude/install.ps1',
  'adapters/antigravity/install.ps1',
  'adapters/generic/install.ps1',
];

const ACTIVE_VERSION_FILES = [
  'AGENTS.md',
  'README.md',
  '00_README.md',
  '00_START_HERE.md',
  'AGENT_INSTALL.md',
  'MAIN.md',
  'modules/41_V6_7_AIShippingAndReviewabilityAudit.md',
  'modules/42_V6_7_PonytailLazySeniorDevLadder.md',
  'modules/43_V6_7_MattPocockSkillsIntegration.md',
  'modules/01_MasterLogic.md',
  'modules/11_CrossDirectoryMap.md',
  'modules/12_AgentEnforcement.md',
  'modules/15_LogicEntryChecklist.md',
  'modules/26_V6_5_INDEX.md',
  'modules/34_V6_5_ProjectFactMap_V2.md',
  'modules/38_V6_6_SpecDrivenDevelopment.md',
  'modules/39_V6_6_TasteFrontendDesign.md',
  'modules/40_AgentLogicSystemMap.md',
  'modules/44_V6_8_GrokBuildOperationalIntegration.md',
  'modules/45_V6_8_GraphifyCodeMapIntegration.md',
  'modules/46_V6_8_ProjectKnowledgeSync.md',
  'modules/49_V6_8_AutonomousSkillEnforcement.md',
];

const GATE_ANCHORS = [
  'MANDATORY LOGIC GATE',
  'AGENTS.md',
  'README.md',
  'forget/compress context',
  'blocking gate',
];

const ABSOLUTE_PATH_PATTERNS = [/(?<![A-Za-z0-9])[A-Za-z]:[\\/]/, /[\\/]Users[\\/]/, /[\\/]home[\\/]/];

let hasError = false;

function fail(message) {
  console.error(`ERROR: ${message}`);
  hasError = true;
}

function ok(message) {
  console.log(`OK: ${message}`);
}

function readFileSafe(relPath) {
  const fullPath = path.join(ROOT, relPath);
  if (!fs.existsSync(fullPath)) {
    return null;
  }
  return fs.readFileSync(fullPath, 'utf8');
}

function checkRepoDocs() {
  for (const relPath of REQUIRED_REPO_DOCS) {
    const fullPath = path.join(ROOT, relPath);
    if (!fs.existsSync(fullPath)) {
      fail(`Missing required repository entry doc: ${relPath}`);
    } else {
      ok(`Found repository entry doc: ${relPath}`);
    }
  }
}

function checkLogicChainInRepoDocs() {
  const candidates = ['AGENTS.md', 'README.md'];
  const contents = candidates
    .map(readFileSafe)
    .filter(Boolean)
    .join('\n\n');

  for (const anchor of REQUIRED_LOGIC_CHAIN_ANCHORS) {
    if (!contents.includes(anchor)) {
      fail(`Repository entry docs do not declare logic-chain anchor: ${anchor}`);
    } else {
      ok(`Repository entry docs declare logic-chain anchor: ${anchor}`);
    }
  }
}

function checkActiveVersionAndPathHygiene() {
  const manifest = readFileSafe('manifest.json');
  if (!manifest) {
    fail('manifest.json is required for active-version checks.');
    return;
  }

  let parsed;
  try {
    parsed = JSON.parse(manifest);
  } catch (error) {
    fail(`manifest.json is not valid JSON: ${error.message}`);
    return;
  }

  const expectedVersion = parsed.current_version;
  const staleVersionPattern = /AgentLogic_V6_7_0|V6\.7\.0|AgentLogic_V6_7_1|V6\.7\.1/;
  const absoluteFileUriPattern = /file:\/\/(?:[A-Za-z]:|Users\/|home\/)/;

  for (const relPath of ACTIVE_VERSION_FILES) {
    const content = readFileSafe(relPath);
    if (content == null) {
      fail(`Active version file not found: ${relPath}`);
      continue;
    }
    if (staleVersionPattern.test(content)) {
      fail(`Stale stable-version reference found in active file: ${relPath}`);
    }
    if (absoluteFileUriPattern.test(content)) {
      fail(`Machine-specific absolute file URI found in active file: ${relPath}`);
    }
    if (content.includes('REPO_ROOT_PLACEHOLDER')) {
      fail(`Repository placeholder link found in active file: ${relPath}`);
    }
  }

  const startHere = readFileSafe('00_START_HERE.md');
  if (startHere) {
    const startupIndex = startHere.indexOf('## Startup Gate');
    const fullReadIndex = startHere.indexOf('## Mandatory Full-Read Chain');
    if (startupIndex === -1 || fullReadIndex === -1 || startupIndex > fullReadIndex) {
      fail('00_START_HERE.md must define Startup Gate before Mandatory Full-Read Chain.');
    } else {
      ok('Startup Gate precedes the Mandatory Full-Read Chain.');
    }
  }

  const profileFiles = parsed.profiles?.[parsed.default_profile]?.files || [];
  for (const relPath of profileFiles) {
    const content = readFileSafe(relPath);
    if (content == null) continue;
    if (ABSOLUTE_PATH_PATTERNS.some((pattern) => pattern.test(content))) {
      fail(`Machine-specific absolute path found in active profile file: ${relPath}`);
    }
    if (content.includes('REPO_ROOT_PLACEHOLDER')) {
      fail(`Repository placeholder found in active profile file: ${relPath}`);
    }
  }
}

function checkEntryFileGate(relPath) {
  const content = readFileSafe(relPath);
  if (content == null) {
    fail(`Entry file not found: ${relPath}`);
    return;
  }

  const head = content.split('\n').slice(0, 120).join('\n');

  for (const anchor of GATE_ANCHORS) {
    if (!head.includes(anchor)) {
      fail(`Missing gate anchor "${anchor}" in entry file header: ${relPath}`);
    }
  }

  for (const pattern of ABSOLUTE_PATH_PATTERNS) {
    if (pattern.test(head)) {
      fail(`Absolute path detected in entry file header: ${relPath}`);
    }
  }

  ok(`Mandatory logic gate header verified: ${relPath}`);
}

function checkMapLinks() {
  const mapFiles = ['modules/11_CrossDirectoryMap.md', 'modules/40_AgentLogicSystemMap.md'];
  for (const relPath of mapFiles) {
    const content = readFileSafe(relPath);
    if (!content) continue;

    const regex = /file:\/\/\/REPO_ROOT_PLACEHOLDER\/([^\s\)\>\"\#\`]+)/g;
    let match;
    let found = 0;
    while ((match = regex.exec(content)) !== null) {
      const linkPath = match[1];
      if (linkPath.startsWith('src/')) {
        found++;
        continue;
      }
      const targetFilePath = path.join(ROOT, linkPath);
      if (!fs.existsSync(targetFilePath)) {
        fail(`Link in ${relPath} points to non-existent file: ${linkPath}`);
      } else {
        found++;
      }
    }
    if (found > 0) {
      ok(`Verified ${found} map links in ${relPath} successfully.`);
    }
  }
}

function checkActiveRelativeLinks() {
  const manifest = readFileSafe('manifest.json');
  if (!manifest) return;

  let parsed;
  try {
    parsed = JSON.parse(manifest);
  } catch {
    return;
  }

  const files = parsed.profiles?.[parsed.default_profile]?.files || [];
  const markdownLink = /\[[^\]]*\]\(([^)]+)\)/g;
  let checked = 0;

  for (const relPath of files) {
    if (!relPath.endsWith('.md')) continue;
    const content = readFileSafe(relPath);
    if (content == null) continue;
    let match;
    while ((match = markdownLink.exec(content)) !== null) {
      let target = match[1].split('#', 1)[0].trim().replace(/^<|>$/g, '');
      if (!target || /^(https?:|mailto:|app:)/i.test(target)) continue;
      if (target.startsWith('file:///')) {
        fail(`Absolute file link found in active Markdown: ${relPath} -> ${target}`);
        continue;
      }
      const targetPath = path.resolve(path.dirname(path.join(ROOT, relPath)), target);
      checked += 1;
      if (!fs.existsSync(targetPath)) {
        fail(`Broken relative Markdown link: ${relPath} -> ${target}`);
      }
    }
  }

  if (checked > 0) ok(`Verified ${checked} active relative Markdown links.`);
}

function checkExternalReferences() {
  const manifest = readFileSafe('manifest.json');
  if (!manifest) return;

  let parsed;
  try {
    parsed = JSON.parse(manifest);
  } catch (error) {
    return;
  }

  const activeVersionFile = parsed.main_logic_file;
  const versionContent = readFileSafe(activeVersionFile);
  if (!versionContent) {
    fail(`Active version file not found: ${activeVersionFile}`);
    return;
  }

  const refSectionIndex = versionContent.indexOf('## 4. Reference Source Registration');
  if (refSectionIndex === -1) {
    fail(`Active version file missing Section 4 Reference Source Registration: ${activeVersionFile}`);
    return;
  }

  const nextSectionIndex = versionContent.indexOf('## 5.', refSectionIndex);
  const refSectionText = nextSectionIndex === -1
    ? versionContent.slice(refSectionIndex)
    : versionContent.slice(refSectionIndex, nextSectionIndex);

  const urlRegex = /Source URL:\s*`([^`]+)`/g;
  let match;
  const urls = [];
  while ((match = urlRegex.exec(refSectionText)) !== null) {
    urls.push(match[1].trim());
  }

  if (urls.length === 0) {
    const simpleUrlRegex = /Source URL:\s*([^\s]+)/g;
    while ((match = simpleUrlRegex.exec(refSectionText)) !== null) {
      urls.push(match[1].trim().replace(/[.)]$/, ''));
    }
  }

  if (urls.length === 0) {
    ok(`No external references found to validate in ${activeVersionFile}.`);
    return;
  }

  const readmeFiles = ['README.md', '00_README.md'];
  for (const readme of readmeFiles) {
    const readmeContent = readFileSafe(readme);
    if (!readmeContent) {
      fail(`Readme file not found for references check: ${readme}`);
      continue;
    }

    let checked = 0;
    for (const url of urls) {
      const normUrl = url.replace(/\/$/, '');
      if (!readmeContent.includes(normUrl)) {
        fail(`External reference URL "${url}" declared in ${activeVersionFile} is missing in ${readme}.`);
      } else {
        checked++;
      }
    }
    if (checked === urls.length) {
      ok(`All ${checked} external references validated successfully in ${readme}.`);
    }
  }
}

function checkProjectKnowledgeSyncContract() {
  const manifest = readFileSafe('manifest.json');
  if (!manifest) return;
  let parsed;
  try {
    parsed = JSON.parse(manifest);
  } catch {
    return;
  }

  if (!/^V6\.8\.[2-9]/.test(parsed.current_version || '')) return;

  const modulePath = 'modules/46_V6_8_ProjectKnowledgeSync.md';
  const content = readFileSafe(modulePath);
  if (!content) {
    fail(`Missing project-knowledge module: ${modulePath}`);
    return;
  }

  for (const anchor of ['AGENTS.md', 'PROJECT_MAP.md', 'CODE_MAP.md', '.learnings/ERRORS.md', 'git fetch --prune']) {
    if (!content.includes(anchor)) {
      fail(`Project-knowledge module is missing required anchor: ${anchor}`);
    }
  }

  const files = parsed.profiles?.[parsed.default_profile]?.files || [];
  if (!files.includes(modulePath)) {
    fail(`Default profile '${parsed.default_profile}' does not include '${modulePath}'.`);
  } else {
    ok('Project-native knowledge-sync contract verified.');
  }
}

function checkCodeMapReadability() {
  const relPath = 'CODE_MAP.md';
  const fullPath = path.join(ROOT, relPath);
  if (!fs.existsSync(fullPath)) {
    fail(`Missing mandatory text-first code map: ${relPath}`);
    return;
  }

  let content;
  try {
    content = new TextDecoder('utf-8', { fatal: true }).decode(fs.readFileSync(fullPath));
  } catch {
    fail(`${relPath} must be valid UTF-8.`);
    return;
  }

  if (content.includes('\uFFFD')) {
    fail(`${relPath} contains replacement characters and must be repaired from a readable source.`);
    return;
  }

  if (/[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F]/.test(content)) {
    fail(`${relPath} contains disallowed control characters.`);
    return;
  }

  ok(`${relPath} is valid UTF-8 and contains no disallowed control characters.`);
}

function main() {
  console.log('Checking repository logic-entry enforcement...\n');

  checkRepoDocs();
  checkLogicChainInRepoDocs();
  checkActiveVersionAndPathHygiene();

  for (const relPath of ENTRY_FILES) {
    checkEntryFileGate(relPath);
  }

  for (const relPath of OPERATIONAL_ENTRY_FILES) {
    checkEntryFileGate(relPath);
  }

  checkMapLinks();
  checkActiveRelativeLinks();
  checkExternalReferences();
  checkProjectKnowledgeSyncContract();
  checkCodeMapReadability();

  if (hasError) {
    console.error('\nLogic-entry check FAILED.');
    process.exit(1);
  }

  console.log('\nLogic-entry check PASSED.');
}

main();
