{ config, pkgs, ... }:

{
  # List of packages to be installed
  home.packages = with pkgs; [
    # Git
    git
    less
    # Text editors
    vim
    neovim
    # Visual Improvements
    btop
  ];
}

