{ config, pkgs, ... }:

let
  # Helper function to create out-of-store symlinks
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  imports = [
    ./packages.nix
  ];

  home.file = {
    ".zshrc".source = mkSymlink ~/dotfiles/zshrc;
    ".zshrc_aliases".source = mkSymlink ~/dotfiles/zshrc_aliases;
    ".zshrc_extratools".source = mkSymlink ~/dotfiles/zshrc_extratools;
    ".tmux.conf".source = mkSymlink ~/dotfiles/tmux.conf;

    # Recursively symlink directories
    ".config/nvim" = {
      source = mkSymlink ~/dotfiles/config/nvim;
      recursive = true;
    };
    ".config/bat" = {
      source = mkSymlink ~/dotfiles/config/bat;
      recursive = true;
    };
    ".config/kitty" = {
      source = mkSymlink ~/dotfiles/config/kitty;
      recursive = true;
    };
    ".config/ohmyposh" = {
      source = mkSymlink ~/dotfiles/config/ohmyposh;
      recursive = true;
    };
    ".config/nix" = {
      source = mkSymlink ~/dotfiles/config/nix;
      recursive = true;
    };
    ".config/waybar" = {
      source = mkSymlink ~/dotfiles/config/waybar;
      recursive = true;
    };
    ".config/wofi" = {
      source = mkSymlink ~/dotfiles/config/wofi;
      recursive = true;
    };
    # ".config/hyprland" = {
    #   source = mkSymlink ~/dotfiles/config/hypr;
    #   recursive = true;
    # };
  };
}

