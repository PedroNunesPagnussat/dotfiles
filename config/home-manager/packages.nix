{ config, pkgs, ... }:

let
  # Shell and Terminal Tools
  shellTools = with pkgs; [
    bat
    btop
    eza
    fzf
    less
    oh-my-posh
    vivid
    tmux
    zsh
    xclip
    # fd-find
    ripgrep
  ];

  # Development Tools
  devTools = with pkgs; [
    docker
    git
    lazydocker
    lazygit
    neovim
    nixpkgs-fmt
    vim
  ];

  # Window Manager and Related Tools
  wmTools = with pkgs; [
    hyprland
    # hyprlock This does not work with nix for some reason using pacman
    hyprpaper
    hyprshot
    libglvnd
    libnotify
    mesa
    swaynotificationcenter
    waybar
    wayland
    wofi
  ];

  # System Utilities
  sysUtils = with pkgs; [
    btop
    wget               # Downloading
    curl               # Downloading
    unzip              # Unzipping
  ];

  # Browsers and Communication
  browsersAndComms = with pkgs; [
    bitwarden          # Password manager
    discord            # Communication
    firefox            # Browser
    obsidian           # Note taking
    slack              # Communication
    todoist            # Task management
  ];

  # Media and Graphics Tools
  mediaAndGraphics = with pkgs; [
    feh                # Image rendering
    nitrogen           # Wallpaper setter
    playerctl          # Media control
    font-awesome       # Icons

  ];

  # File Management
  fileManagement = with pkgs; [
    nautilus           # File manager
  ];

in {
  # List of packages to be installed
  home.packages = 
    shellTools       ++
    devTools         ++
    wmTools          ++
    sysUtils         ++
    browsersAndComms ++
    mediaAndGraphics ++
    fileManagement;
   

  # fonts.packages = [
  #   (pkgs.nerdfonts.override {fonts = [ "JetBrainsMono" ];})
  # ];
}

