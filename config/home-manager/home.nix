{ config, pkgs, ... }:

let
  # Helper function to create out-of-store symlinks
  Symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";

  # nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = 
    pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
    "obsidian"
    "slack"
    "todoist"
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  imports = [
    ./packages.nix
  ];

  home.file = {
    ".zshrc".source = Symlink ~/dotfiles/zshrc;
    ".zshrc_aliases".source = Symlink ~/dotfiles/zshrc_aliases;
    ".zshrc_extratools".source = Symlink ~/dotfiles/zshrc_extratools;
    ".tmux.conf".source = Symlink ~/dotfiles/tmux.conf;

    # Recursively symlink directories
    ".config/nvim" = {
      source = Symlink ~/dotfiles/config/nvim;
      recursive = true;
    };
    ".config/bat" = {
      source = Symlink ~/dotfiles/config/bat;
      recursive = true;
    };
    ".config/kitty" = {
      source = Symlink ~/dotfiles/config/kitty;
      recursive = true;
    };
    ".config/ohmyposh" = {
      source = Symlink ~/dotfiles/config/ohmyposh;
      recursive = true;
    };
    ".config/nix" = {
      source = Symlink ~/dotfiles/config/nix;
      recursive = true;
    };
    ".config/waybar" = {
      source = Symlink ~/dotfiles/config/waybar;
      recursive = true;
    };
    ".config/wofi" = {
      source = Symlink ~/dotfiles/config/wofi;
      recursive = true;
    };
    ".config/hypr" = {
      source = Symlink ~/dotfiles/config/hypr;
      recursive = true;
    };
  };
}

