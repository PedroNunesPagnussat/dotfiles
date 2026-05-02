#!/usr/bin/env bash
# Hyprland config smoke test.
#
# IMPORTANT: `hyprctl reload` is NOT a dry-check — it reloads the live
# compositor and can crash the session on a bad config. There is no
# first-party offline validator. We therefore do static analysis only:
#   - balanced braces
#   - every `source =` target exists
#   - no obviously malformed key bindings
#
# A full reload check would need a nested Hyprland instance (out of scope).
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

HYPR_CFG="$DOTFILES/hypr/.config/hypr"
[[ -d "$HYPR_CFG" ]] || { skip "hypr: no config at $HYPR_CFG"; exit 0; }

rc=0

# 1. Brace balance per file.
for f in "$HYPR_CFG"/*.conf; do
  [[ -f "$f" ]] || continue
  open=$(grep -o '{' "$f" | wc -l)
  close=$(grep -o '}' "$f" | wc -l)
  if [[ "$open" != "$close" ]]; then
    fail "hypr: unbalanced braces in $(basename "$f")" "open=$open close=$close"
    rc=1
  fi
done

# 2. Resolve every `source = <path>` and confirm the file exists.
while IFS= read -r line; do
  target="${line#*=}"
  target="${target## }"; target="${target%% }"
  target="${target/\~/$HOME}"
  # relative paths are resolved from ~/.config/hypr (runtime), but in the
  # repo they sit under $HYPR_CFG — check both.
  if [[ "$target" != /* ]]; then
    if [[ ! -f "$HYPR_CFG/$target" && ! -f "$HOME/.config/hypr/$target" ]]; then
      fail "hypr: source target missing" "$target"
      rc=1
    fi
  elif [[ ! -f "$target" ]]; then
    fail "hypr: source target missing (abs)" "$target"
    rc=1
  fi
done < <(grep -rhE '^\s*source\s*=' "$HYPR_CFG" 2>/dev/null)

# 3. Bind lines must have at least MOD, KEY, DISPATCHER — 3 commas after 'bind'.
while IFS= read -r line; do
  # strip trailing comment
  clean="${line%%#*}"
  # count commas in the value
  val="${clean#*=}"
  commas=$(echo "$val" | tr -cd ',' | wc -c)
  if (( commas < 2 )); then
    fail "hypr: malformed bind (need MOD,KEY,DISPATCHER)" "$line"
    rc=1
  fi
done < <(grep -rhE '^\s*bind[lermn]*\s*=' "$HYPR_CFG" 2>/dev/null)

[[ $rc -eq 0 ]] && pass "hypr: braces + sources + binds"
exit $rc
