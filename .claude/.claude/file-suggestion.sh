#!/bin/bash
# Custom @ file suggestions: deprioritize 000_META/, exclude 000_META/ARCHIVE/
# stdin: {"query": "user-typed-text"}
# stdout: up to 15 newline-separated paths

query=$(jq -r '.query // ""')
exclude="^000_META/ARCHIVE/"
tier2="^000_META/"
tier3="^\."

cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)" || exit 0

files=$(git ls-files --cached --others --exclude-standard 2>/dev/null \
  || find . -type f ! -path "*/.git/*" | sed 's|^\./||')

# Fuzzy match: chars in order, case-insensitive (e.g. "booksb" -> b.*o.*o.*k.*s.*b)
if [ -n "$query" ]; then
  pattern=$(printf '%s' "$query" | sed 's/./&.*/g')
  matches=$(printf '%s\n' "$files" | grep -i -- "$pattern")
else
  matches="$files"
fi

# Hard exclusion: archived notes never surface in @ picker
matches=$(printf '%s\n' "$matches" | grep -v -E "$exclude")

# Tier 1: everything else, Tier 2: 000_META/, Tier 3: .obsidian — cap at 15
{
  printf '%s\n' "$matches" | grep -v -E "$tier2|$tier3"
  printf '%s\n' "$matches" | grep -E "$tier2"
  printf '%s\n' "$matches" | grep -E "$tier3"
} | head -n 15
