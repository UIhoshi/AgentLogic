#!/usr/bin/env bash

# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGET_HOST="generic"
PROFILE_NAME="core-enhanced"
TARGET_PATH=""
USER_HOME="${HOME:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --host)
      TARGET_HOST="${2:?missing value for --host}"
      shift 2
      ;;
    --profile)
      PROFILE_NAME="${2:?missing value for --profile}"
      shift 2
      ;;
    --target-path)
      TARGET_PATH="${2:?missing value for --target-path}"
      shift 2
      ;;
    --user-home)
      USER_HOME="${2:?missing value for --user-home}"
      shift 2
      ;;
    -h|--help)
      cat <<'EOF'
Usage: ./install.sh [--host codex|claude|antigravity|generic] [--profile NAME] [--target-path PATH] [--user-home PATH]
EOF
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

if command -v pwsh >/dev/null 2>&1; then
  PS_BIN="pwsh"
elif command -v powershell >/dev/null 2>&1; then
  PS_BIN="powershell"
else
  PS_BIN=""
fi

if [[ -n "$PS_BIN" ]]; then
  ARGS=(
    -NoProfile
    -ExecutionPolicy Bypass
    -File "$SCRIPT_DIR/install.ps1"
    -TargetHost "$TARGET_HOST"
    -ProfileName "$PROFILE_NAME"
  )
  if [[ -n "$TARGET_PATH" ]]; then
    ARGS+=(-TargetPath "$TARGET_PATH")
  fi
  if [[ -n "$USER_HOME" ]]; then
    ARGS+=(-UserHome "$USER_HOME")
  fi
  exec "$PS_BIN" "${ARGS[@]}"
elif command -v node >/dev/null 2>&1; then
  NODE_ARGS=(
    "$SCRIPT_DIR/scripts/install.js"
    --host "$TARGET_HOST"
    --profile "$PROFILE_NAME"
  )
  if [[ -n "$TARGET_PATH" ]]; then
    NODE_ARGS+=(--target-path "$TARGET_PATH")
  fi
  if [[ -n "$USER_HOME" ]]; then
    NODE_ARGS+=(--user-home "$USER_HOME")
  fi
  exec node "${NODE_ARGS[@]}"
else
  echo "Either PowerShell ('pwsh'/'powershell') or Node.js ('node') is required." >&2
  exit 1
fi
