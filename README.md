# Dotfiles

My Dotfiles and some system setup stuff

## Setup

```bash
sudo pacman -S git
git clone https://github.com/PedroNunesPagnussat/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
xargs --arg-file packages.txt sudo apt install -y
```

## Specs

- OS: `Arch Linux`
- Editor: `NeoVim`
- Shell: `ZSH`
- WM: `HyprLand`
- Terminal Emulator: `Kitty`
- Terminal Multiplexer: `Tmux`
