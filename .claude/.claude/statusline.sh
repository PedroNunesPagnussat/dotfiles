#!/bin/bash
# Claude Code statusline
# Line 1: model | context | cost
# Line 2: branch | mods (files) | time since last commit
input=$(cat)

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BLUE='\033[34m'
CYAN='\033[36m'
DIM='\033[2m'
RESET='\033[0m'

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')

# Context window color: green → yellow → red
if [ "$PCT" -ge 80 ]; then
    CTX_COLOR="$RED"
elif [ "$PCT" -ge 50 ]; then
    CTX_COLOR="$YELLOW"
else
    CTX_COLOR="$GREEN"
fi

# Worktree info
WT_BRANCH=$(echo "$input" | jq -r '.worktree.branch // empty')
WT_NAME=$(echo "$input" | jq -r '.worktree.name // empty')

# Git info
BRANCH=""
GIT_DIRTY=""
LAST_COMMIT=""
if cd "$DIR" 2>/dev/null && git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$(git status --porcelain 2>/dev/null | head -1)" ]; then
        GIT_DIRTY="*"
    fi

    # Last commit time
    LAST_COMMIT=$(git log -1 --format="%ar" 2>/dev/null)
fi

# Prefer worktree branch if available
if [ -n "$WT_BRANCH" ]; then
    BRANCH="$WT_BRANCH"
    [ -n "$WT_NAME" ] && [ "$WT_NAME" != "$WT_BRANCH" ] && BRANCH="${WT_BRANCH} (${WT_NAME})"
fi

GIT_PART=""
if [ -n "$BRANCH" ]; then
    GIT_PART="${BLUE}${BRANCH}${GIT_DIRTY}${RESET}"
fi

# Last commit time
COMMIT_PART=""
if [ -n "$LAST_COMMIT" ]; then
    COMMIT_PART="${DIM}${LAST_COMMIT} since last commit${RESET}"
fi

# Lines changed and file count (from git diff in working directory)
LINES_PART=""
FILES_PART=""
if cd "$DIR" 2>/dev/null && git rev-parse --git-dir > /dev/null 2>&1; then
    DIFF_STAT=$(git diff --numstat HEAD 2>/dev/null | awk '{a+=$1; r+=$2} END {if (NR>0) printf "%d %d", a, r}')
    if [ -n "$DIFF_STAT" ]; then
        LINES_ADDED=$(echo "$DIFF_STAT" | cut -d' ' -f1)
        LINES_REMOVED=$(echo "$DIFF_STAT" | cut -d' ' -f2)
        LINES_PART="${GREEN}+${LINES_ADDED}${RESET} ${RED}-${LINES_REMOVED}${RESET}"

        # File count
        FILE_COUNT=$(git diff --name-only HEAD 2>/dev/null | wc -l)
        if [ "$FILE_COUNT" -gt 0 ]; then
            FILES_PART="${DIM}(${FILE_COUNT} files)${RESET}"
        fi
    else
        # No modifications - show +0 -0
        LINES_ADDED=0
        LINES_REMOVED=0
        FILE_COUNT=0
        LINES_PART="${GREEN}+0${RESET} ${RED}-0${RESET}"
    fi
fi

# Session cost
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
COST_PART=""
if [ -n "$COST" ]; then
    COST_FMT=$(printf "%.2f" "$COST")
    COST_PART="${DIM}\$${COST_FMT}${RESET}"
fi

# Calculate visible widths (excluding ANSI codes)
MODEL_LEN=${#MODEL}
BRANCH_TEXT="${BRANCH}${GIT_DIRTY}"
BRANCH_LEN=${#BRANCH_TEXT}

# Context field: "📂 PCT%" (emoji is 2 chars wide in most terminals)
CTX_TEXT="📂 ${PCT}%"
CTX_LEN=$(( ${#CTX_TEXT} + 1 ))  # +1 for emoji width

# Mods field: "+X -Y (N files)" or "+X -Y"
MODS_LEN=0
if [ -n "$LINES_PART" ]; then
    MODS_TEXT="+${LINES_ADDED} -${LINES_REMOVED}"
    [ "$FILE_COUNT" -gt 0 ] && MODS_TEXT="${MODS_TEXT} (${FILE_COUNT} files)"
    MODS_LEN=${#MODS_TEXT}
fi

# Cost field
COST_LEN=0
if [ -n "$COST_FMT" ]; then
    COST_TEXT="\$${COST_FMT}"
    COST_LEN=${#COST_TEXT}
fi

# Time field
TIME_LEN=0
if [ -n "$LAST_COMMIT" ]; then
    TIME_TEXT="${LAST_COMMIT} since last commit"
    TIME_LEN=${#TIME_TEXT}
fi

# Determine column widths
COL1_WIDTH=$MODEL_LEN
[ "$BRANCH_LEN" -gt "$COL1_WIDTH" ] && COL1_WIDTH=$BRANCH_LEN

COL2_WIDTH=$CTX_LEN
[ "$MODS_LEN" -gt "$COL2_WIDTH" ] && COL2_WIDTH=$MODS_LEN

COL3_WIDTH=$COST_LEN
[ "$TIME_LEN" -gt "$COL3_WIDTH" ] && COL3_WIDTH=$TIME_LEN

# Calculate padding for each field
MODEL_PAD=$(( COL1_WIDTH - MODEL_LEN ))
BRANCH_PAD=$(( COL1_WIDTH - BRANCH_LEN ))
CTX_PAD=$(( COL2_WIDTH - CTX_LEN ))
MODS_PAD=$(( COL2_WIDTH - MODS_LEN ))

# Line 1: model | context | cost
printf "${CYAN}%s${RESET}%*s  │  ${CTX_COLOR}📂 ${PCT}%%${RESET}%*s" "$MODEL" "$MODEL_PAD" "" "$CTX_PAD" ""
[ -n "$COST_PART" ] && printf "  │  %b" "$COST_PART"
printf "\n"

# Line 2: branch | mods (files) | time since last commit
if [ -n "$GIT_PART" ] || [ -n "$LINES_PART" ] || [ -n "$COMMIT_PART" ]; then
    [ -n "$GIT_PART" ] && printf "%b%*s" "$GIT_PART" "$BRANCH_PAD" ""
    if [ -n "$LINES_PART" ]; then
        printf "  │  %b" "$LINES_PART"
        [ -n "$FILES_PART" ] && printf " %b" "$FILES_PART"
        printf "%*s" "$MODS_PAD" ""
    fi
    [ -n "$COMMIT_PART" ] && printf "  │  %b" "$COMMIT_PART"
    printf "\n"
fi
