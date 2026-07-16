#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');

const REQUIRED_REPO_DOCS = ['AGENTS.md', 'README.md'];
const REQUIRED_LOGIC_CHAIN_ANCHORS = [
  '00_START_HERE.md',
  'modules/01_MasterLogic.md',
  'modules/15_LogicEntryChecklist.md',
];

const ENTRY_FILES = ['00_START_HERE.md', 'AGENTS.md', 'README.md', 'MAIN.md'];

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
];

const GATE_ANCHORS = [
  'MANDATORY LOGIC GATE',
  'AGENTS.md',
  'README.md',
  'forget/compress context',
  'blocking gate',
];

const ABSOLUTE_PATH_PATTERNS = [/[A-Za-z]:\\/, /\/Users\//, /\/home\//];

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

function main() {
  console.log('Checking repository logic-entry enforcement...\n');

  checkRepoDocs();
  checkLogicChainInRepoDocs();
  checkActiveVersionAndPathHygiene();

  for (const relPath of ENTRY_FILES) {
    checkEntryFileGate(relPath);
  }

  checkMapLinks();

  if (hasError) {
    console.error('\nLogic-entry check FAILED.');
    process.exit(1);
  }

  console.log('\nLogic-entry check PASSED.');
}

main();
