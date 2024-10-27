{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  imports = [
    ./packages.nix # Packages to install
  ];

  # Manage dotfiles
  home.file = {
    ".zshrc".source = ~/dotfiles/zshrc;
    ".tmux.conf".source = ~/dotfiles/tmux.conf;

    ".config/nvim" = {
      source = ~/dotfiles/config/nvim;
      recursive = true;
    };
    ".config/bat" = {
      source = ~/dotfiles/config/bat;
      recursive = true;
    };
    ".config/rofi" = {
      source = ~/dotfiles/config/rofi;
      recursive = true;
    };
    ".config/kitty" = {
      source = ~/dotfiles/config/kitty;
      recursive = true;
    };
    ".config/ohmyposh" = {
      source = ~/dotfiles/config/ohmyposh;
      recursive = true;
    };
    ".config/nix" = {
      source = ~/dotfiles/config/nix;
      recursive = true;
    };

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userEmail = "npedronp@outlook.com";
    userName = "PedroNunesPagnussat";
  };


}
