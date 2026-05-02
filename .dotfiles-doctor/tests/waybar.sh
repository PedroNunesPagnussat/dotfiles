#!/usr/bin/env bash
# Waybar smoke test.
# waybar itself has no --check-config flag, so we:
#   1. strip JSONC comments and validate as JSON via jq
#   2. sanity-check that modules referenced in modules-left/center/right
#      all have a corresponding top-level key
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

WB="$DOTFILES/waybar/.config/waybar"
cfg="$WB/config.jsonc"
[[ -f "$cfg" ]] || { skip "waybar: $cfg not present"; exit 0; }

rc=0
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

# Strip // line comments and /* block comments, then jq-validate.
# sed is intentional here — it's a tiny transform, not a search.
sed -E 's,//.*$,,; s,/\*.*\*/,,g' "$cfg" > "$tmp"

if ! jq empty "$tmp" 2>/dev/null; then
  err=$(jq empty "$tmp" 2>&1 | head -3)
  fail "waybar: invalid JSON(C)" "$err"
  rc=1
else
  # Cross-check referenced modules exist as top-level keys.
  refs=$(jq -r '(.["modules-left"], .["modules-center"], .["modules-right"])[]?' "$tmp" 2>/dev/null | sort -u)
  keys=$(jq -r 'keys[]' "$tmp" 2>/dev/null)
  while IFS= read -r m; do
    [[ -z "$m" ]] && continue
    # Strip instance suffix after '#'
    base="${m%%#*}"
    if ! grep -qxF "$base" <<<"$keys" && ! grep -qxF "$m" <<<"$keys"; then
      # Built-in modules (clock, tray, network, etc.) don't need a key — only
      # custom modules (prefixed with 'custom/') must be defined.
      if [[ "$m" == custom/* ]]; then
        fail "waybar: referenced custom module missing definition" "$m"
        rc=1
      fi
    fi
  done <<<"$refs"
fi

[[ $rc -eq 0 ]] && pass "waybar: JSONC parse + module refs"
exit $rc
