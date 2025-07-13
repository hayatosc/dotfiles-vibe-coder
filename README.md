# dotfiles-vibe-coder

A declarative Home Manager configuration for managing user environments on Linux systems.

## 🚀 Quick Start

### Automated Setup

The easiest way to get started is using the automated setup script:

1. **Run the setup script directly**:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/hayatosc/dotfiles-vibe-coder/refs/heads/main/setup.sh | bash
   ```

The setup script will:
- Install Nix using Determinate Nix Installer
- Install Home Manager
- Set up your personal configuration

### Manual Setup

If you prefer manual setup:

1. **Prerequisites**: Nix with flakes enabled, Home Manager

2. **Clone and configure**:
   ```bash
   git clone <repository-url>
   cd dotfiles-vibe-coder
   ```

3. **Configure personal settings**:
   ```bash
   # Copy and customize the environment script
   cp set-env-example.sh set-env.sh
   nano set-env.sh
   
   # Source the environment variables
   source ./set-env.sh
   ```

4. **Apply configuration**:
   ```bash
   source ./set-env.sh && home-manager switch --flake . --impure
   ```

## ⚙️ Configuration

### Personal Settings

The configuration uses environment variables that can be set using the `set-env.sh` script:

1. **Copy and customize the environment script**:
   ```bash
   cp set-env-example.sh set-env.sh
   # Edit set-env.sh with your personal information
   nano set-env.sh
   ```

2. **Source the environment script before building**:
   ```bash
   source ./set-env.sh && home-manager switch --flake . --impure
   ```

The `config.nix` file reads these environment variables with fallback defaults.

### Included Tools

- **Development**: Node.js, pnpm, git, gh (GitHub CLI), uv (Python), tailscale, claude-code, gemini-cli
- **Shell**: bash configuration
- **Auto-setup**: GitHub CLI authentication

## 🔧 Usage

```bash
# Apply configuration
source ./set-env.sh && home-manager switch --flake . --impure

# Build without applying
source ./set-env.sh && home-manager build --flake . --impure

# Check configuration
source ./set-env.sh && nix flake check --impure

# Update dependencies
nix flake update
```

## 📂 Structure

```
.
├── setup.sh             # Automated setup script
├── flake.nix            # Main flake configuration
├── home.nix             # Home Manager module
├── config.nix           # Personal configuration (reads environment variables)
├── set-env.sh           # Environment setup script (gitignored)
├── set-env-example.sh   # Environment setup template
├── module/              # Module configurations
│   └── claude/          # Claude Code configuration and commands
├── scripts/             # Setup scripts
│   └── setup-github.sh
└── .gitignore          # Git ignore rules
```

## 🔒 Security

- Personal information is stored in `set-env.sh` (gitignored)
- `set-env-example.sh` provides a safe template for sharing
- `config.nix` reads environment variables with safe defaults
- No personal data is committed to the repository

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Ensure `set-env-example.sh` reflects any new configuration options
4. Submit a pull request