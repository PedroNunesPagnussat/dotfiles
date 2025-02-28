# Dotfiles

My Dotfiles and some system setup stuff

## Specs

- OS: `Arch Linux`
- Editor: `NeoVim`
- Shell: `ZSH`
- WM: `HyprLand`
- Terminal Emulator: `Kitty`
- Terminal Multiplexer: `Tmux`

## Setup

### Install Git and Clone the Repository

```bash
sudo pacman -S git
git clone https://github.com/PedroNunesPagnussat/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

### Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Install Home Manager

```bash
chmod +x $HOME/dotfiles/scripts/install_hm.sh
```

### Final setup

```bash
sudo pacman -S hyprlock
# sudo chsh -s /usr/bin/zsh
sh $HOME/dotfiles/scripts/install_nerd_font.sh
mkdir ~/dev
```

### Remove Old Configurations

```bash
nix-collect-garbage -d
```
