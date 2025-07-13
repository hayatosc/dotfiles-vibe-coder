#!/bin/bash

set -e

echo "=== Home Manager Setup Script ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root"
    exit 1
fi

# Install Nix using the Determinate Nix Installer
echo "Installing Nix with Determinate Nix Installer..."
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

# Source nix environment
echo "Sourcing Nix environment..."
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Install home-manager using nix run
echo "Installing home-manager..."
nix run home-manager/master -- init --switch

# Clone dotfiles repository
echo "Cloning dotfiles repository..."

# Check if git is available, if not use nix to run it
if ! command -v git &> /dev/null; then
    echo "Git not found, using nix run..."
    nix run nixpkgs#git -- clone https://github.com/hayatosc/dotfiles-vibe-coder.git ~/.config/home-manager
else
    git clone https://github.com/hayatosc/dotfiles-vibe-coder.git ~/.config/home-manager
fi
cd ~/.config/home-manager

# Create set-env.sh from templates if they don't exist

if [ ! -f set-env.sh ]; then
    echo "Creating set-env.sh from template..."
    cp set-env-example.sh set-env.sh
    echo "Please edit set-env.sh with your personal information"
fi

echo "=== Setup Complete ==="
echo "Home Manager has been successfully installed and configured!"
echo "Configuration location: /root/.config/home-manager"
echo ""
echo "To set up your environment:"
echo "1. Edit ~/.config/home-manager/set-env.sh with your personal settings."
echo "2. Source the environment variables:"
echo "   source ~/.config/home-manager/set-env.sh"
echo "3. Run the following command to apply the configuration:"
echo "   home-manager switch --flake ."