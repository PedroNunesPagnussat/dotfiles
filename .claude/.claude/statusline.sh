#!/bin/bash
# Claude Code statusline
# Line 1: model | effort | context
# Line 2: session (5h) limit | week limit | cost
# Line 3: branch | mods (files) | time since last commit
input=$(cat)

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
DIM='\033[2m'
RESET='\033[0m'
CTX_ICON=$''

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
# Current context-window occupancy (input includes cache; not cumulative session totals)
TOK_IN=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
TOK_OUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')
RL_5H_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' | cut -d. -f1)
RL_5H_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
RL_7D_PCT=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Green → yellow → red by percentage
pct_color() {
    if [ "$1" -ge 80 ]; then
        printf '%s' "$RED"
    elif [ "$1" -ge 50 ]; then
        printf '%s' "$YELLOW"
    else
        printf '%s' "$GREEN"
    fi
}

# Green <40k → yellow 40-400k → red ≥400k by absolute token count
tok_color() {
    if [ "$1" -ge 400000 ]; then
        printf '%s' "$RED"
    elif [ "$1" -ge 40000 ]; then
        printf '%s' "$YELLOW"
    else
        printf '%s' "$GREEN"
    fi
}

# Worktree info
WT_BRANCH=$(echo "$input" | jq -r '.worktree.branch // empty')
WT_NAME=$(echo "$input" | jq -r '.worktree.name // empty')

# Git info
BRANCH=""
GIT_DIRTY=""
LAST_COMMIT=""
LINES_PART=""
MODS_TEXT=""
if cd "$DIR" 2>/dev/null && git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$(git status --porcelain 2>/dev/null | head -1)" ]; then
        GIT_DIRTY="*"
    fi
    LAST_COMMIT=$(git log -1 --format="%ar" 2>/dev/null)
    COMMIT_TS=$(git log -1 --format="%ct" 2>/dev/null)

    DIFF_STAT=$(git diff --numstat HEAD 2>/dev/null | awk '{a+=$1; r+=$2} END {if (NR>0) printf "%d %d", a, r}')
    if [ -n "$DIFF_STAT" ]; then
        LINES_ADDED=$(echo "$DIFF_STAT" | cut -d' ' -f1)
        LINES_REMOVED=$(echo "$DIFF_STAT" | cut -d' ' -f2)
        FILE_COUNT=$(git diff --name-only HEAD 2>/dev/null | wc -l)
    else
        LINES_ADDED=0
        LINES_REMOVED=0
        FILE_COUNT=0
    fi
    MODS_TEXT="+${LINES_ADDED} -${LINES_REMOVED}"
    LINES_PART="${GREEN}+${LINES_ADDED}${RESET} ${RED}-${LINES_REMOVED}${RESET}"
    if [ "$FILE_COUNT" -gt 0 ]; then
        MODS_TEXT="${MODS_TEXT} (${FILE_COUNT} files)"
        LINES_PART="${LINES_PART} ${DIM}(${FILE_COUNT} files)${RESET}"
    fi
fi

# Prefer worktree branch if available
if [ -n "$WT_BRANCH" ]; then
    BRANCH="$WT_BRANCH"
    [ -n "$WT_NAME" ] && [ "$WT_NAME" != "$WT_BRANCH" ] && BRANCH="${WT_BRANCH} (${WT_NAME})"
fi

# --- Row 1: model | effort | context ---
MODEL_PART="${CYAN}${MODEL}${RESET}"
MODEL_LEN=${#MODEL}

EFFORT_PART=""
EFFORT_LEN=0
if [ -n "$EFFORT" ]; then
    case "$EFFORT" in
        low|medium) EFFORT_COLOR="$GREEN" ;;
        high)       EFFORT_COLOR="$YELLOW" ;;
        xhigh|max)  EFFORT_COLOR="$RED" ;;
        *)          EFFORT_COLOR="$DIM" ;;
    esac
    EFFORT_TEXT="effort: ${EFFORT}"
    EFFORT_LEN=${#EFFORT_TEXT}
    EFFORT_PART="${DIM}effort:${RESET} ${EFFORT_COLOR}${EFFORT}${RESET}"
fi

TOK_TOTAL=$(( TOK_IN + TOK_OUT ))
if [ "$TOK_TOTAL" -ge 1000 ]; then
    TOK_FMT=$(awk "BEGIN {printf \"%.1fk\", $TOK_TOTAL/1000}")
else
    TOK_FMT="$TOK_TOTAL"
fi
CTX_TEXT="${CTX_ICON} ${PCT}% (${TOK_FMT})"
CTX_LEN=${#CTX_TEXT}
CTX_PART="$(pct_color "$PCT")${CTX_ICON} ${PCT}%${RESET} $(tok_color "$TOK_TOTAL")(${TOK_FMT})${RESET}"

# --- Row 2: session (5h) limit | week limit | cost ---
S5_PART=""
S5_LEN=0
if [ -n "$RL_5H_PCT" ]; then
    S5_TEXT="5h ${RL_5H_PCT}%"
    S5_PART="$(pct_color "$RL_5H_PCT")${S5_TEXT}${RESET}"
    RL_RESET_TIME=""
    [ -n "$RL_5H_RESET" ] && RL_RESET_TIME=$(date -d "@$RL_5H_RESET" +%H:%M 2>/dev/null)
    if [ -n "$RL_RESET_TIME" ]; then
        S5_TEXT="${S5_TEXT} (resets ${RL_RESET_TIME})"
        S5_PART="${S5_PART} ${DIM}(resets ${RL_RESET_TIME})${RESET}"
    fi
    S5_LEN=${#S5_TEXT}
else
    # Placeholder before first message: reserve full width so dividers don't shift
    S5_TEXT="5h --% (resets --:--)"
    S5_LEN=${#S5_TEXT}
    S5_PART="${DIM}${S5_TEXT}${RESET}"
fi

WK_PART=""
WK_LEN=0
if [ -n "$RL_7D_PCT" ]; then
    WK_TEXT="wk ${RL_7D_PCT}%"
    WK_LEN=${#WK_TEXT}
    WK_PART="$(pct_color "$RL_7D_PCT")${WK_TEXT}${RESET}"
else
    WK_TEXT="wk --%"
    WK_LEN=${#WK_TEXT}
    WK_PART="${DIM}${WK_TEXT}${RESET}"
fi

COST_PART=""
if [ -n "$COST" ]; then
    COST_FMT=$(printf "%.2f" "$COST")
    COST_PART="${DIM}\$${COST_FMT}${RESET}"
else
    COST_PART="${DIM}\$--.--${RESET}"
fi

# --- Row 3: branch | mods (files) | time since last commit ---
GIT_PART=""
BRANCH_LEN=0
if [ -n "$BRANCH" ]; then
    BRANCH_TEXT="${BRANCH}${GIT_DIRTY}"
    BRANCH_LEN=${#BRANCH_TEXT}
    GIT_PART="${BLUE}${BRANCH_TEXT}${RESET}"
fi

MODS_LEN=${#MODS_TEXT}

COMMIT_PART=""
if [ -n "$LAST_COMMIT" ]; then
    # Age coloring only when uncommitted changes exist
    COMMIT_COLOR="$DIM"
    if [ "${FILE_COUNT:-0}" -gt 0 ] && [ -n "$COMMIT_TS" ]; then
        AGE_DAYS=$(( ( $(date +%s) - COMMIT_TS ) / 86400 ))
        if [ "$AGE_DAYS" -gt 3 ]; then
            COMMIT_COLOR="$RED"
        elif [ "$AGE_DAYS" -gt 1 ]; then
            COMMIT_COLOR="$YELLOW"
        else
            COMMIT_COLOR="$GREEN"
        fi
    fi
    COMMIT_PART="${COMMIT_COLOR}${LAST_COMMIT} since last commit${RESET}"
fi

# Column widths (max across rows)
COL1_WIDTH=$MODEL_LEN
[ "$S5_LEN" -gt "$COL1_WIDTH" ] && COL1_WIDTH=$S5_LEN
[ "$BRANCH_LEN" -gt "$COL1_WIDTH" ] && COL1_WIDTH=$BRANCH_LEN

COL2_WIDTH=$EFFORT_LEN
[ "$WK_LEN" -gt "$COL2_WIDTH" ] && COL2_WIDTH=$WK_LEN
[ "$MODS_LEN" -gt "$COL2_WIDTH" ] && COL2_WIDTH=$MODS_LEN

# print_row <col1> <len1> <col2> <len2> <col3>
# Two internal dividers = 2 aligned │ per row.
print_row() {
    printf "%b%*s" "$1" "$(( COL1_WIDTH - $2 ))" ""
    printf "  │  %b%*s" "$3" "$(( COL2_WIDTH - $4 ))" ""
    [ -n "$5" ] && printf "  │  %b" "$5"
    printf "\n"
}

print_row "$MODEL_PART" "$MODEL_LEN" "$EFFORT_PART" "$EFFORT_LEN" "$CTX_PART"
print_row "$S5_PART" "$S5_LEN" "$WK_PART" "$WK_LEN" "$COST_PART"
if [ -n "$GIT_PART" ] || [ -n "$MODS_TEXT" ] || [ -n "$COMMIT_PART" ]; then
    print_row "$GIT_PART" "$BRANCH_LEN" "$LINES_PART" "$MODS_LEN" "$COMMIT_PART"
fi
