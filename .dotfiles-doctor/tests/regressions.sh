#!/usr/bin/env bash
# Regression tests for past failures.
#
# ⚠️  STUB STATUS — memory had no prior record of these bugs, so each test
# below encodes a *plausible* failure signature based on general knowledge
# of the named bug. Before relying on these, confirm with the user that
# the signature matches the actual incident. Tests marked @UNVERIFIED are
# guesses; tests marked @CONFIRMED have been validated against a real fix.
#
# Past failures (all @UNVERIFIED — awaiting user confirmation):
#   1. treesitter error
#   2. blink.cmp vs nvim-cmp conflict
#   3. DPMS crash (hypridle/hyprland screen-off)
#   4. VPN endpoint-missing-port bug
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

NVIM_CFG="$DOTFILES/nvim/.config/nvim"
HYPR_CFG="$DOTFILES/hypr/.config/hypr"
rc=0

# ---------------------------------------------------------------------------
# REG-1 @UNVERIFIED: treesitter
# Assumed shape: a parser installed but the corresponding `ensure_installed`
# or require("nvim-treesitter.configs").setup entry was malformed, causing
# runtime errors on file open. We grep for common foot-guns and verify
# headless checkhealth on nvim-treesitter reports no ERROR.
# ---------------------------------------------------------------------------
if [[ -d "$NVIM_CFG" ]]; then
  tmp="$(mktemp)"
  XDG_CONFIG_HOME="$DOTFILES/nvim/.config" nvim --headless \
    "+checkhealth nvim-treesitter" "+w! $tmp" "+qa!" >/dev/null 2>&1 || true
  if [[ -s "$tmp" ]] && grep -qE '^\s*(ERROR|- ERROR)' "$tmp"; then
    fail "REG-1 treesitter: checkhealth ERROR present" "$(grep -E 'ERROR' "$tmp" | head -3)"
    rc=1
  fi
  rm -f "$tmp"
fi

# ---------------------------------------------------------------------------
# REG-2 @UNVERIFIED: blink.cmp vs nvim-cmp
# Assumed shape: both completion engines enabled simultaneously → conflicting
# keymaps / duplicate menus. The fix is to have exactly one active. We grep
# the plugin spec for both names in non-disabled form.
# ---------------------------------------------------------------------------
if [[ -d "$NVIM_CFG" ]]; then
  has_blink=$(grep -rlE '"saghen/blink\.cmp"|saghen/blink\.cmp' "$NVIM_CFG" --include='*.lua' 2>/dev/null | head -1 || true)
  has_cmp=$(grep -rlE '"hrsh7th/nvim-cmp"|hrsh7th/nvim-cmp' "$NVIM_CFG" --include='*.lua' 2>/dev/null | head -1 || true)
  if [[ -n "$has_blink" && -n "$has_cmp" ]]; then
    # Both referenced — at least one must be explicitly disabled.
    disabled=$(grep -rE 'enabled\s*=\s*false|\{\s*"hrsh7th/nvim-cmp",\s*enabled\s*=\s*false' "$NVIM_CFG" --include='*.lua' 2>/dev/null || true)
    if [[ -z "$disabled" ]]; then
      fail "REG-2 blink.cmp vs nvim-cmp: both enabled" "$has_blink + $has_cmp"
      rc=1
    fi
  fi
fi

# ---------------------------------------------------------------------------
# REG-3 @UNVERIFIED: DPMS crash
# Assumed shape: hypridle on-timeout invoked `hyprctl dispatch dpms off` while
# a lock was also running, or monitor was already off — causing compositor
# crash on resume. Fix pattern: guard with `hyprctl monitors` / only dpms off
# via dedicated listener after lock. We assert hypridle.conf has no bare
# `dpms off` without a matching `dpms on` on-resume.
# ---------------------------------------------------------------------------
if [[ -f "$HYPR_CFG/hypridle.conf" ]]; then
  off_count=$(grep -cE 'dpms\s+off' "$HYPR_CFG/hypridle.conf" || true)
  on_count=$(grep -cE 'dpms\s+on'  "$HYPR_CFG/hypridle.conf" || true)
  if (( off_count > 0 && on_count == 0 )); then
    fail "REG-3 DPMS: dpms off without dpms on-resume listener" "off=$off_count on=$on_count"
    rc=1
  fi
fi

# ---------------------------------------------------------------------------
# REG-4 @UNVERIFIED: VPN endpoint missing port
# Assumed shape: a WireGuard / OpenVPN / similar config referenced an endpoint
# like `vpn.example.com` without `:PORT`. We scan likely config locations and
# fail if an Endpoint= / remote line lacks a port.
# Location is ambiguous — we check ~/dotfiles for any wg*.conf and /etc/wireguard
# only if readable.
# ---------------------------------------------------------------------------
scan_vpn() {
  local f="$1"
  # WireGuard: Endpoint = host:port
  while IFS= read -r line; do
    val="${line#*=}"
    val="${val## }"; val="${val%% }"
    # Accept IPv6 with brackets [::1]:port, otherwise require host:port
    if [[ "$val" =~ ^\[.*\]:[0-9]+$ ]] || [[ "$val" =~ :[0-9]+$ ]]; then
      :
    else
      fail "REG-4 VPN: endpoint missing port in ${f##*/}" "$line"
      rc=1
    fi
  done < <(grep -E '^\s*Endpoint\s*=' "$f" 2>/dev/null || true)
  # OpenVPN: `remote host port`
  while IFS= read -r line; do
    # remote line should have at least 3 fields: remote host port
    fields=$(echo "$line" | awk '{print NF}')
    if (( fields < 3 )); then
      fail "REG-4 VPN: openvpn remote missing port in ${f##*/}" "$line"
      rc=1
    fi
  done < <(grep -E '^\s*remote\s+' "$f" 2>/dev/null || true)
}

while IFS= read -r -d '' f; do
  scan_vpn "$f"
done < <(find "$DOTFILES" -type f \( -name 'wg*.conf' -o -name '*.ovpn' \) -print0 2>/dev/null)

[[ $rc -eq 0 ]] && pass "regressions: all 4 @UNVERIFIED checks clean"
exit $rc
