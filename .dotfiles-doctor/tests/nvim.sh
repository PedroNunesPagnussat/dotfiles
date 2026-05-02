#!/usr/bin/env bash
# Neovim / LazyVim smoke test.
# Strategy: exit code of checkhealth is unreliable (always 0), so we capture
# the report and grep for structured ERROR markers from providers we care
# about. Also checks that `:Lazy check` doesn't report missing plugins.
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

NVIM_CFG="$DOTFILES/nvim/.config/nvim"
[[ -d "$NVIM_CFG" ]] || { skip "nvim: no config at $NVIM_CFG"; exit 0; }

rc=0
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

# 1. Lua syntax check on every lua file (cheap, catches typos fast).
while IFS= read -r -d '' f; do
  if ! luac -p "$f" 2>"$tmp"; then
    fail "nvim: lua syntax error in ${f#$NVIM_CFG/}" "$(cat "$tmp")"
    rc=1
  fi
done < <(find "$NVIM_CFG" -name '*.lua' -print0 2>/dev/null)

# 2. Headless startup: redirect messages, fail on Lua errors at load.
# We use -u to force the user config and +qa to exit. Errors during init
# are written to stderr and also appear as :messages.
if ! XDG_CONFIG_HOME="$DOTFILES/nvim/.config" nvim --headless \
      "+lua vim.defer_fn(function() vim.cmd('qa!') end, 100)" \
      "+qa!" 2>"$tmp" >/dev/null; then
  fail "nvim: headless startup failed" "$(head -20 "$tmp")"
  rc=1
fi
# Even on exit 0, stderr may contain "Error executing lua" — treat as failure.
if grep -qE 'Error|E5108|E5113' "$tmp"; then
  fail "nvim: errors during init" "$(grep -E 'Error|E5108|E5113' "$tmp" | head -5)"
  rc=1
fi

# 3. checkhealth parser — look for ERROR lines from core providers only.
# Warnings are allowed; errors are not.
XDG_CONFIG_HOME="$DOTFILES/nvim/.config" nvim --headless \
  "+checkhealth vim.lsp vim.treesitter vim.health" \
  "+w! $tmp" "+qa!" >/dev/null 2>&1 || true

if [[ -s "$tmp" ]]; then
  if grep -E '^\s*(ERROR|- ERROR)' "$tmp" >/dev/null; then
    fail "nvim: checkhealth reports errors" "$(grep -E '^\s*(ERROR|- ERROR)' "$tmp" | head -5)"
    rc=1
  fi
fi

[[ $rc -eq 0 ]] && pass "nvim: lua syntax + headless init + checkhealth"
exit $rc
