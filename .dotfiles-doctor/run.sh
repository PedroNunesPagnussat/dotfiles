#!/usr/bin/env bash
# dotfiles-doctor orchestrator.
# Usage:
#   run.sh                       # full battery
#   run.sh nvim hypr             # subset
#   run.sh --for-file PATH       # pick tests by file path (used by hook)
#   run.sh --json                # machine-readable output
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

ALL_TESTS=(nvim hypr hypridle waybar statusline shell regressions)
JSON=0
FOR_FILE=""
SELECTED=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --json) JSON=1; shift ;;
    --for-file) FOR_FILE="$2"; shift 2 ;;
    -h|--help)
      echo "usage: $0 [--json] [--for-file PATH] [test ...]"
      echo "tests: ${ALL_TESTS[*]}"
      exit 0
      ;;
    *) SELECTED+=("$1"); shift ;;
  esac
done

# Route by file path when called from the hook.
if [[ -n "$FOR_FILE" ]]; then
  case "$FOR_FILE" in
    *nvim/*|*.lua)            SELECTED=(nvim regressions) ;;
    *hypr/hypridle.conf)      SELECTED=(hypridle regressions) ;;
    *hypr/*.conf)             SELECTED=(hypr regressions) ;;
    *waybar/*)                SELECTED=(waybar) ;;
    *statusline.sh|*/claude/*) SELECTED=(statusline) ;;
    *.zshrc|*tmux.conf|*.sh|*starship*) SELECTED=(shell) ;;
    *wg*.conf|*.ovpn)         SELECTED=(regressions) ;;
    *) SELECTED=() ;;
  esac
fi

(( ${#SELECTED[@]} == 0 )) && SELECTED=("${ALL_TESTS[@]}")

failed=()
passed=()
skipped=()

for t in "${SELECTED[@]}"; do
  f="$SCRIPT_DIR/tests/$t.sh"
  if [[ ! -x "$f" ]]; then
    skipped+=("$t:not-found")
    continue
  fi
  out=$("$f" 2>&1)
  ec=$?
  if (( JSON )); then
    # Accumulate; print at end.
    :
  else
    echo "$out"
  fi
  if (( ec == 0 )); then passed+=("$t"); else failed+=("$t"); fi
done

if (( JSON )); then
  jq -n \
    --argjson passed  "$(printf '%s\n' "${passed[@]}"  | jq -R . | jq -s .)" \
    --argjson failed  "$(printf '%s\n' "${failed[@]}"  | jq -R . | jq -s .)" \
    --argjson skipped "$(printf '%s\n' "${skipped[@]}" | jq -R . | jq -s .)" \
    '{passed:$passed, failed:$failed, skipped:$skipped, ok:($failed|length==0)}'
fi

(( ${#failed[@]} == 0 ))
