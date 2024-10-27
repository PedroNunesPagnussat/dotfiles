{
  description = "Pedro Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    # Define pkgs for the x86_64-linux system
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    
    configuration = { pkgs, ... }:
    {
      # All packages that need to be installed system-wide
      environment.systemPackages = [
        pkgs.git
        pkgs.less
        pkgs.openssh
        pkgs.ifconfig
      ];

      # Enable multi-user support (if desired)
      services.nix-daemon.enable = true;

      # Enable experimental features like flakes
      nix.settings.experimental-features = ["nix-command" "flakes"];

      # Set default shell to zsh
      programs.zsh.enable = true;
    };

  in
  {
    # Define packages for x86_64-linux
    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;
  };
}

