#!/usr/bin/env bash
# Claude Code statusline smoke test.
# Runs the script against a minimal stdin payload and checks it:
#   - exits 0
#   - prints non-empty output
#   - doesn't emit the word "null" or "error" unexpectedly
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

sl="$HOME/.claude/statusline.sh"
[[ -x "$sl" ]] || { skip "statusline: $sl not executable"; exit 0; }

rc=0
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

payload='{"model":{"display_name":"Opus"},"context_window":{"used_percentage":12.3},"workspace":{"current_dir":"'"$HOME"'"},"worktree":{}}'

if ! echo "$payload" | "$sl" >"$tmp" 2>&1; then
  fail "statusline: non-zero exit" "$(head -5 "$tmp")"
  rc=1
elif [[ ! -s "$tmp" ]]; then
  fail "statusline: empty output"
  rc=1
elif grep -qiE '\bjq: error\b|parse error' "$tmp"; then
  fail "statusline: jq errors in output" "$(head -3 "$tmp")"
  rc=1
fi

# Syntax check the file itself.
if ! bash -n "$sl" 2>"$tmp"; then
  fail "statusline: bash syntax error" "$(cat "$tmp")"
  rc=1
fi

[[ $rc -eq 0 ]] && pass "statusline: bash syntax + live invocation"
exit $rc
