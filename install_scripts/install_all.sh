#!/bin/bash
sudo apt update -y
sudo apt upgrade -y


# Function to ask for user confirmation
confirm() {
    read -r -p "${1} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# Make sure all scripts are executable
chmod +x ./install_tmux_dependencies.sh
chmod +x ./install_nvm.sh
chmod +x ./install_nerd_font.sh
chmod +x ./install_from_sanp_store.sh
chmod +x ./install_docker.sh
chmod +x ./install_conda.sh

# Execute each script with confirmation
if confirm "Do you want to install tmux dependencies?"; then
    echo "Installing tmux dependencies..."
    ./install_tmux_dependencies.sh
else
    echo "Skipping tmux dependencies installation."
fi

if confirm "Do you want to install NVM?"; then
    echo "Installing NVM..."
    ./install_nvm.sh
else
    echo "Skipping NVM installation."
fi

if confirm "Do you want to install Nerd Font?"; then
    echo "Installing Nerd Font..."
    ./install_nerd_font.sh
else
    echo "Skipping Nerd Font installation."
fi

if confirm "Do you want to install from Snap Store?"; then
    echo "Installing from Snap Store..."
    ./install_from_sanp_store.sh
else
    echo "Skipping Snap Store installation."
fi

if confirm "Do you want to install Docker?"; then
    echo "Installing Docker..."
    ./install_docker.sh
else
    echo "Skipping Docker installation."
fi

if confirm "Do you want to install Conda?"; then
    echo "Installing Conda..."
    ./install_conda.sh
else
    echo "Skipping Conda installation."
fi

echo "All installations completed!"
