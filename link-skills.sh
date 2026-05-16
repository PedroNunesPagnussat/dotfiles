#!/usr/bin/env bash
# Symlink dual-use skills into web_claude_skills/.
# Source of truth lives in .claude/.claude/skills/<name>/.

set -euo pipefail

SKILLS=(
    "second-order-thinking"
    "hand-off"
)

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
src_dir="$repo_root/.claude/.claude/skills"
dst_dir="$repo_root/web_claude_skills"
rel_src="../.claude/.claude/skills"

mkdir -p "$dst_dir"

for skill in "${SKILLS[@]}"; do
    src="$src_dir/$skill"
    dst="$dst_dir/$skill"

    if [[ ! -d "$src" ]]; then
        echo "skip $skill: source missing at $src" >&2
        continue
    fi

    if [[ -L "$dst" ]]; then
        current=$(readlink "$dst")
        if [[ "$current" == "$rel_src/$skill" ]]; then
            echo "ok   $skill"
            continue
        fi
        echo "fix  $skill: relinking ($current -> $rel_src/$skill)"
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        echo "skip $skill: $dst exists and is not a symlink" >&2
        continue
    fi

    ln -s "$rel_src/$skill" "$dst"
    echo "link $skill"
done
