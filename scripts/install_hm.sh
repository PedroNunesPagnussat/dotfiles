nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
export NIX_CONFIG="experimental-features = nix-command flakes"
cp $HOME/dotfiles/config/home-manager $HOME/.config/home-manager
home-manager switch
exec zsh
