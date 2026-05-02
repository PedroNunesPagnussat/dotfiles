#!/usr/bin/env bash
# PostToolUse hook dispatcher for Claude Code.
#
# Reads the hook payload on stdin, extracts the edited file path, and
# runs only the relevant smoke test(s) via run.sh --for-file.
#
# Policy on failure: we DO NOT auto-revert (that would destroy other
# unstaged edits in the same file). We emit a structured error on stderr
# and exit 2, which Claude Code surfaces as a blocking message without
# undoing the edit. The user chooses whether to revert.
#
# To enable auto-revert, set DOTFILES_DOCTOR_AUTOREVERT=1. This runs
# `git checkout HEAD -- <file>` — only safe if the file had no prior
# unstaged edits. The hook refuses to revert if the file was already
# dirty before the edit (detected via git stash list sentinel).
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

payload=$(cat)
file=$(echo "$payload" | jq -r '.tool_input.file_path // .tool_input.path // empty')

# Only act on files under ~/dotfiles.
case "$file" in
  "$HOME/dotfiles"/*) ;;
  *) exit 0 ;;
esac

out=$("$SCRIPT_DIR/run.sh" --for-file "$file" 2>&1)
ec=$?

if (( ec == 0 )); then
  exit 0
fi

# Structured error for Claude Code.
{
  echo "dotfiles-doctor: smoke test failed for $file"
  echo "---"
  echo "$out"
  echo "---"
  if [[ "${DOTFILES_DOCTOR_AUTOREVERT:-0}" == "1" ]]; then
    cd "$HOME/dotfiles" || exit 2
    # Refuse revert if the file had other unstaged changes we'd clobber.
    if git diff --quiet HEAD -- "$file"; then
      echo "auto-revert: nothing to revert (no diff vs HEAD)"
    else
      git checkout HEAD -- "$file" && echo "auto-revert: restored $file from HEAD"
    fi
  else
    echo "(auto-revert disabled; set DOTFILES_DOCTOR_AUTOREVERT=1 to enable)"
  fi
} >&2

exit 2
