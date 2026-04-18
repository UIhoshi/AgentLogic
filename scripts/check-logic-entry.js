#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const ROOT = process.cwd();

const REQUIRED_REPO_DOCS = ['AGENTS.md', 'README.md'];
const REQUIRED_LOGIC_CHAIN_ANCHORS = [
  '00_START_HERE.md',
  'modules/01_MasterLogic.md',
  'modules/15_LogicEntryChecklist.md',
];

const ENTRY_FILES = ['00_START_HERE.md', 'AGENTS.md', 'README.md', 'MAIN.md'];

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

function main() {
  console.log('Checking repository logic-entry enforcement...\n');

  checkRepoDocs();
  checkLogicChainInRepoDocs();

  for (const relPath of ENTRY_FILES) {
    checkEntryFileGate(relPath);
  }

  if (hasError) {
    console.error('\nLogic-entry check FAILED.');
    process.exit(1);
  }

  console.log('\nLogic-entry check PASSED.');
}

main();
