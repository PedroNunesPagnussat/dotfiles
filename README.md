# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/)

```bash
# Arch
sudo pacman -S stow

# Ubuntu/Debian
sudo apt install stow
```

## Structure

Each top-level directory is a stow package that mirrors the home directory structure:

```
dotfiles/
├── alacritty/.config/alacritty/alacritty.toml
├── btop/.config/btop/
├── fastfetch/.config/fastfetch/
├── ghostty/.config/ghostty/
├── hypr/.config/hypr/
├── kitty/.config/kitty/
├── lazygit/.config/lazygit/
├── mako/.config/mako/
├── omarchy/.config/omarchy/
├── starship/.config/starship.toml
├── swayosd/.config/swayosd/
├── tmux/.tmux.conf
├── walker/.config/walker/
└── waybar/.config/waybar/
```

## Usage

Clone the repo into your home directory:

```bash
git clone https://github.com/PedroNunesPagnussat/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Sync all packages

```bash
stow */
```

### Sync a specific package

```bash
stow tmux
stow hypr
stow kitty
```

### Remove symlinks for a package

```bash
stow -D tmux
```

### Re-sync (useful after pulling updates)

```bash
stow -R */
```

> **Note:** If a config file already exists at the target location, stow will refuse to overwrite it. Back up or remove the existing file first, then run `stow` again.
