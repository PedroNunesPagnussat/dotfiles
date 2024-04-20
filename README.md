
# Dotfiles

My Dotfiles and some system setup stuff

## Setup

```bash
sudo apt install git -y
git clone https://github.com/PedroNunesPagnussat/dotfiles.git $HOME/dotfiles
xargs --arg-file packages.txt sudo apt install -y
```

## Specs

- Editor: `NeoVim`
- Shell: `ZSH`
- WM: `QTile`
- Terminal Emulator: `TBD`
- Terminal Multiplexer: `Tmux`
