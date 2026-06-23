#!/usr/bin/env bash
# Stow system-level packages (target: /). Requires sudo.
# System packages mirror /etc, /usr, etc. under the package dir.

set -euo pipefail

PACKAGES=(
    "logiops"
)

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

for pkg in "${PACKAGES[@]}"; do
    if [[ ! -d "$repo_root/$pkg" ]]; then
        echo "skip $pkg: package missing at $repo_root/$pkg" >&2
        continue
    fi
    echo "stow $pkg -> /"
    sudo stow -d "$repo_root" -t / "$pkg"
done
