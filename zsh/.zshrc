# =============================================================================
# ZSH Configuration
# =============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS       # Don't save duplicate commands
setopt HIST_IGNORE_SPACE      # Don't save commands starting with space
setopt HIST_VERIFY            # Show expanded history before executing
setopt SHARE_HISTORY          # Share history across sessions
setopt INC_APPEND_HISTORY     # Append to history immediately

# Options
setopt AUTO_CD                # cd by typing directory name
setopt CORRECT                # Suggest corrections for mistyped commands
setopt NO_BEEP                # No beep on errors

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
# Plugins
# =============================================================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# History substring search keybindings (after syntax highlighting)
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey '^P' history-substring-search-up      # Ctrl+P
bindkey '^N' history-substring-search-down    # Ctrl+N

# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept               # Ctrl+Space to accept suggestion

# =============================================================================
# Keybindings
# =============================================================================

bindkey -e                                    # Emacs-style line editing
bindkey '^[[H' beginning-of-line              # Home
bindkey '^[[F' end-of-line                    # End
bindkey '^[[3~' delete-char                   # Delete
bindkey '^[[1;5C' forward-word                # Ctrl+Right
bindkey '^[[1;5D' backward-word               # Ctrl+Left
bindkey '^H' backward-kill-word               # Ctrl+Backspace

# =============================================================================
# Aliases
# =============================================================================

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias nv='nvim'
alias dev='cd ~/dev'
alias investments='cd ~/dev/investment-portfolio'
alias notes='cd ~/notes'

# Python venvs
alias mkvenv='python -m venv .venv'
alias avenv='source .venv/bin/activate'
alias va='source .venv/bin/activate'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gb='git branch'

# Git backup
alias backup='git add . && git commit -m "$(TZ=America/Sao_Paulo date +"%Y-%m-%d %H:%M:%S %Z")" && git push'

# =============================================================================
# Starship Prompt
# =============================================================================

eval "$(starship init zsh)"

# opencode
export PATH=/home/pedro/.opencode/bin:$PATH
