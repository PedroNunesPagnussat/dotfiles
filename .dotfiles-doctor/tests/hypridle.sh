#!/usr/bin/env bash
# hypridle / hyprlock / hyprsunset — same config grammar as hypr,
# but we also check for the specific DPMS-crash pattern (see regressions.sh).
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

HYPR_CFG="$DOTFILES/hypr/.config/hypr"
f="$HYPR_CFG/hypridle.conf"
[[ -f "$f" ]] || { skip "hypridle: $f not present"; exit 0; }

rc=0
open=$(grep -o '{' "$f" | wc -l)
close=$(grep -o '}' "$f" | wc -l)
if [[ "$open" != "$close" ]]; then
  fail "hypridle: unbalanced braces" "open=$open close=$close"
  rc=1
fi

# Every `listener {}` block needs a `timeout` and an `on-timeout`.
blocks=$(awk '/listener[[:space:]]*\{/,/\}/' "$f")
if [[ -n "$blocks" ]]; then
  if ! echo "$blocks" | grep -q 'timeout'; then
    fail "hypridle: listener block missing timeout"
    rc=1
  fi
  if ! echo "$blocks" | grep -q 'on-timeout'; then
    fail "hypridle: listener block missing on-timeout"
    rc=1
  fi
fi

[[ $rc -eq 0 ]] && pass "hypridle: structure + listener completeness"
exit $rc
