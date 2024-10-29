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
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
export NIX_CONFIG="experimental-features = nix-command flakes"
home-manager switch
```

### Install PKGs that are not available with Nix

```bash
sudo pacman -S hyprlock
```

### Remove Old Configurations

```bash
nix-collect-garbage -d
```
