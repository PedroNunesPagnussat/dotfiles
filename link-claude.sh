#!/usr/bin/env bash
# Symlink Claude Code config into ~/.claude with plain symlinks (no stow).
# For dev containers. Replaces whatever is at the target paths.

set -euo pipefail

src=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.claude/.claude
dest="$HOME/.claude"

mkdir -p "$dest"

ln -sfn "$src/CLAUDE.md" "$dest/CLAUDE.md"
ln -sfn "$src/settings.json" "$dest/settings.json"
ln -sfn "$src/statusline.sh" "$dest/statusline.sh"
rm -rf "$dest/skills"
ln -sfn "$src/skills" "$dest/skills"

echo "linked CLAUDE.md, settings.json, statusline.sh, skills/ -> $dest"
