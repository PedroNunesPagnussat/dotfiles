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
├── .claude/.claude/                  # Claude Code config, skills, hooks
├── fastfetch/.config/fastfetch/
├── ghostty/.config/ghostty/
├── hypr/.config/hypr/
├── kitty/.config/kitty/
├── lazygit/.config/lazygit/
├── mako/.config/mako/
├── nvim/.config/nvim/
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

## Claude Code package

The `.claude` package tracks `~/.claude/` config: `settings.json`, `CLAUDE.md`, `statusline.sh`, `file-suggestion.sh`, and `skills/`.

`settings.local.json` is intentionally gitignored (per-machine permissions).

### One manual step after `stow .claude`

The omarchy skill points to a machine-local path, so stow can't track it. Recreate the symlink manually:

```bash
ln -s ~/.local/share/omarchy/default/omarchy-skill ~/.claude/skills/omarchy
```
