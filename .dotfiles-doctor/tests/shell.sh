#!/usr/bin/env bash
# Shell config smoke test: .zshrc, tmux.conf, starship.toml, any shell scripts.
# shellcheck is not installed — using `bash -n` / `zsh -n` for syntax.
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

rc=0
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

# zshrc
if [[ -f "$DOTFILES/zsh/.zshrc" ]]; then
  if ! zsh -n "$DOTFILES/zsh/.zshrc" 2>"$tmp"; then
    fail "zsh: .zshrc syntax error" "$(cat "$tmp")"
    rc=1
  fi
fi

# starship toml
if [[ -f "$DOTFILES/starship/.config/starship.toml" ]] && have starship; then
  if ! starship print-config --default >/dev/null 2>"$tmp"; then
    # Fallback to TOML parse via python if available.
    if have python3; then
      python3 -c "import tomllib,sys; tomllib.load(open('$DOTFILES/starship/.config/starship.toml','rb'))" 2>"$tmp" || {
        fail "starship: TOML parse error" "$(cat "$tmp")"
        rc=1
      }
    fi
  fi
fi

# tmux — syntax check via a short-lived server on a unique socket.
if [[ -f "$DOTFILES/tmux/.tmux.conf" ]] && have tmux; then
  sock="doctor-$$"
  if ! tmux -L "$sock" -f "$DOTFILES/tmux/.tmux.conf" start-server \; kill-server 2>"$tmp"; then
    fail "tmux: config error" "$(head -5 "$tmp")"
    rc=1
  fi
fi

# Any loose .sh files in the repo: bash -n each.
while IFS= read -r -d '' f; do
  if ! bash -n "$f" 2>"$tmp"; then
    fail "shell: syntax error in ${f#$DOTFILES/}" "$(cat "$tmp")"
    rc=1
  fi
done < <(find "$DOTFILES" -name '*.sh' -not -path '*/.git/*' -print0 2>/dev/null)

[[ $rc -eq 0 ]] && pass "shell: zsh + tmux + starship + *.sh syntax"
exit $rc
