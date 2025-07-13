#!/bin/bash

# Nix Home Manager Environment Configuration Script - Example Template
# Copy this file to set-env.sh and customize the values

# User Configuration
export NIX_USER_NAME="your-username"
export NIX_HOME_DIRECTORY="/home/your-username"

# Git Configuration
export NIX_GIT_USER_NAME="Your Full Name"
export NIX_GIT_USER_EMAIL="your.email@example.com"
export NIX_GIT_DEFAULT_BRANCH="main"
export NIX_GIT_EDITOR="nano"

# Nix Configuration
export NIX_STATE_VERSION="25.05"

# Display current configuration
echo "Environment variables set:"
echo "  NIX_USER_NAME: $NIX_USER_NAME"
echo "  NIX_HOME_DIRECTORY: $NIX_HOME_DIRECTORY"
echo "  NIX_GIT_USER_NAME: $NIX_GIT_USER_NAME"
echo "  NIX_GIT_USER_EMAIL: $NIX_GIT_USER_EMAIL"
echo "  NIX_GIT_DEFAULT_BRANCH: $NIX_GIT_DEFAULT_BRANCH"
echo "  NIX_GIT_EDITOR: $NIX_GIT_EDITOR"
echo "  NIX_STATE_VERSION: $NIX_STATE_VERSION"
echo ""
echo "To apply these settings, run: source ~/.config/home-manager/set-env.sh && home-manager switch --flake . --impure"