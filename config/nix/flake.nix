{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ...} @ inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {

    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;

  };
}
