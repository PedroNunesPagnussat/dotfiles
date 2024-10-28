{ config, pkgs, ... }:

{
  # List of packages to be installed
  home.packages = with pkgs; [
    # Shell tools
    zsh
    fzf
    bat
    vivid
    eza
    oh-my-posh
    btop

    # Git
    git
    less
    lazygit

    # HyprLand
    hyprland
    wofi
    waybar
    hyprshot
    swaynotificationcenter
    nitrogen
    hyprlock
    # nm-applet


    # This should be managed by mason
    nixpkgs-fmt

    # Docker
    docker
    lazydocker

    # IDEs
    # code
    neovim 
    vim 

    # Misc
    firefox # Browser
    bitwarden # Password manager
    discord # Communication
    slack # Communication
    tmux # Terminal multiplexer
    playerctl # Media control
    font-awesome # Icons
    wget # Downloading
    unzip # Unzipping
    nautilus # File manager
    feh # Image rendering
  ];

}

