# P10K Stuff
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Load installs
source ~/.bash_config/installs

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions 
zinit light Aloxaf/fzf-tab # Add in snippets zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::git
zinit snippet OMZP::ubuntu
# zinit snippet OMZP::tmux
# zinit snippet OMZP::zoxide
zinit snippet OMZP::brew
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit 
zinit cdreplay -q


# Keybindings
# bindkey -v
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey jj vi-cmd-mode
bindkey -s '^z' '\e\e' # Add sudo at the front 
bindkey -s '^h' '^r' # search history
bindkey '^w' vi-forward-char
bindkey "^?" backward-delete-char # Fix backspace bug when switching modes
bindkey '^[[3~' delete-char        # Delete key
bindkey '^[[1~' beginning-of-line   # Home key
bindkey '^[[4~' end-of-line         # End key


repeat-last-command() {
  zle up-history
  zle accept-line
}
zle -N repeat-last-command
bindkey '^n' repeat-last-command

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling

# Define dir_style
dir_style='eza --color=always --git --no-filesize --icons --no-time --no-user --no-permissions --long --tree --level=2'
# dir_style='eza --color=always --git --no-filesize --icons --no-time --no-user --no-permissions --long'
file_style='bat -n --color=always'
combined_styles='[[ -d $realpath ]] && '${dir_style}' $realpath || '${file_style}' $realpath'

# zstyle configurations
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# fzf-tab configurations
zstyle ':fzf-tab:complete:cd:*' fzf-preview ''${dir_style}' $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview ''${dir_style}' $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview ''${combined_styles}' $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview ''${combined_styles}' $realpath'


# Shell integrations
eval "$(fzf --zsh)"
# eval "$(zoxide init zsh)" # unlink cd to z
# eval "$(zoxide init --cmd cd zsh)" # link cd to z

source ~/.bash_config/aliases

# Exports
export PYTHONDONTWRITEBYTECODE=1
export BAT_THEME="CatppuccinMocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export EZA_COLORS="$(vivid generate catppuccin-mocha)"
export EDITOR=nvim
export VISUAL=nvim

# Add .local/bin to path
export PATH=$PATH:$HOME/.local/bin


eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.omp.toml)"
source "$HOME/.rye/env"
