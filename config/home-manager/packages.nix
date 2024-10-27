{ config, pkgs, ... }:

{
  # List of packages to be installed
  home.packages = with pkgs; [
    # Git
    git
    less
    # Shell
    zsh
    fzf
    bat
    vivid
    eza
    oh-my-posh
    # Text editors
    vim
    neovim
    # Visual Improvements
    btop
    # Nix FMT
    nixpkgs-fmt
  ];
}

