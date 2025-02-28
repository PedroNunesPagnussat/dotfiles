#!/bin/bash

# Prompt for email
echo "Enter the email address for the SSH key:"
read email

ssh-keygen -t ed25519 -C "$email"
# Start the ssh-agent in the background if not already running
eval "$(ssh-agent -s)"

# Add the new SSH key to the ssh-agent
ssh-add ~/.ssh/github_ed25519

# Copy the SSH key to the clipboard
if command -v wl-copy &> /dev/null; then
    wl-copy < ~/.ssh/github_ed25519.pub
    echo "SSH key copied to clipboard."
elif command -v xclip &> /dev/null; then
    xclip -selection clipboard < ~/.ssh/github_ed25519.pub
    echo "SSH key copied to clipboard."
elif command -v pbcopy &> /dev/null; then
    pbcopy < ~/.ssh/github_ed25519.pub
    echo "SSH key copied to clipboard."
else
    echo "Clipboard utility not found. SSH key not copied to clipboard."
    echo "You can manually copy it from here:"
    cat ~/.ssh/github_ed25519.pub
fi

echo "Done. You can now add the key to your GitHub account."
