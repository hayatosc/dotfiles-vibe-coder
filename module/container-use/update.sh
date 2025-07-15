#!/usr/bin/env bash
# Script to update container-use package using nix-update

set -euo pipefail

# Get the latest version from GitHub releases
LATEST_VERSION=$(curl -s "https://api.github.com/repos/dagger/container-use/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')

echo "Latest container-use version: $LATEST_VERSION"

# Use nix-update to update the package
nix run nixpkgs#nix-update -- container-use --flake --version "$LATEST_VERSION"

echo "container-use: version $LATEST_VERSION"
echo "Run 'source ./set-env.sh && home-manager switch --flake . --impure' to apply changes"