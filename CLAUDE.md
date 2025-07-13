# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Nix Home Manager configuration repository that manages user environment setup for the root user on a Linux system. The configuration uses Nix flakes and provides a declarative way to manage packages, dotfiles, and system setup.

## Key Files and Structure

- `flake.nix` - Main Nix flake configuration defining inputs (nixpkgs, home-manager) and outputs
- `home.nix` - Home Manager configuration module containing package lists, program configurations, and activation scripts
- `config.nix` - Personal configuration file that reads environment variables with fallback defaults
- `set-env.sh` - Environment setup script (gitignored) containing personal settings
- `set-env-example.sh` - Environment setup template for sharing
- `flake.lock` - Lock file pinning specific versions of dependencies

## Common Commands

### Building and Applying Configuration
```bash
# Build the Home Manager configuration
nix build .#homeConfigurations.root.activationPackage

# Apply the configuration (switch to new generation)
home-manager switch --flake .

# Build without switching (test configuration)
home-manager build --flake .

# Show current generation
home-manager generations
```

### Development and Testing
```bash
# Check flake configuration
nix flake check

# Update flake inputs
nix flake update

# Show what packages would be installed
nix flake show

# Enter development shell with packages available
nix develop
```

## Architecture and Key Components

### Package Management
- Uses nixpkgs unstable channel for latest packages
- Installs development tools: Node.js, pnpm, git, GitHub CLI, uv, tailscale, claude-code, gemini-cli
- Allows unfree packages (configured in home.nix:8)

### Shell Configuration
- Configures bash for development environment

### Git Configuration
- User-specific Git settings loaded from config.nix (name, email, editor preferences)
- Sets default branch to "main", enables rebase on pull
- Personal information is kept separate from the main configuration

### Activation Scripts
The configuration includes an activation script that runs during home-manager switch:

1. **GitHub CLI Setup** (home.nix:53-59): Copies setup script to `$HOME/.local/bin/setup-github.sh` and runs it during activation to authenticate with GitHub CLI using web-based OAuth

### Environment Variables
- Basic environment configuration for development tools

## Special Considerations

- Personal configuration is separated into set-env.sh (gitignored) for privacy
- set-env-example.sh provides a template for environment setup
- User settings (username, home directory, Git info) are loaded from environment variables via config.nix
- config.nix reads environment variables with getEnv function and fallback defaults
- Uses Home Manager version specified via NIX_STATE_VERSION environment variable
- Activation scripts include dry-run support and error handling
- Configuration automatically handles tool installation and authentication during deployment

## Setup Instructions

### Automated Setup (Recommended)
Run the setup script directly from GitHub:
```bash
curl -fsSL https://raw.githubusercontent.com/hayatosc/dotfiles-vibe-coder/refs/heads/main/setup.sh | bash
```

### Manual Setup
1. Copy the environment template: `cp set-env-example.sh set-env.sh`
2. Edit set-env.sh with your personal information
3. Source the environment: `source ./set-env.sh`
4. Apply the configuration: `home-manager switch --flake .`