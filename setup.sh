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

# Create config.nix from template if it doesn't exist
if [ ! -f config.nix ]; then
    echo "Creating config.nix from template..."
    cp config.nix.example config.nix
    echo "Please edit config.nix with your personal information before running home-manager switch"
fi

echo "=== Setup Complete ==="
echo "Home Manager has been successfully installed and configured!"
echo "Configuration location: /root/.config/home-manager"
echo ""
echo "To set up your environment:"
echo "1. Edit ~/.config/home-manager/config.nix with your personal settings."
echo "2. Run the following command to apply the configuration:"
echo "   home-manager switch"