#!/bin/bash
sudo apt update
sudo apt install -y gpg

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install eza
brew install fzf
brew install zoxide
brew install bat
brew install vivid
brew install lf
brew install jandedobbeleer/oh-my-posh/oh-my-posh

bat cache --build

# sudo mkdir -p /etc/apt/keyrings
# wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
# sudo apt update
# sudo apt install -y eza
