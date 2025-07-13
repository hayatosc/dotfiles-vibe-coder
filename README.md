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
- Apply the Home Manager configuration
- Initialize a git repository

### Manual Setup

If you prefer manual setup:

1. **Prerequisites**: Nix with flakes enabled, Home Manager

2. **Clone and configure**:
   ```bash
   git clone <repository-url>
   cd home-manager-config
   ```

3. **Configure personal settings**:
   ```bash
   cp config.nix.example config.nix
   # Edit config.nix with your personal information
   nano config.nix
   ```

4. **Apply configuration**:
   ```bash
   home-manager switch --flake .
   ```

## ⚙️ Configuration

### Personal Settings

Edit `config.nix` to customize your setup:

```nix
{
  user = {
    name = "your-username";
    homeDirectory = "/home/your-username";
  };
  
  git = {
    userName = "Your Full Name";
    userEmail = "your.email@example.com";
    defaultBranch = "main";
    editor = "nano";
  };
  
  nix = {
    stateVersion = "25.05";
  };
}
```

### Included Tools

- **Development**: Node.js, pnpm, git, gh (GitHub CLI), uv (Python), claude-code, gemini-cli
- **Shell**: bash configuration
- **Auto-setup**: GitHub CLI authentication

## 🔧 Usage

```bash
# Apply configuration
home-manager switch --flake .

# Build without applying
home-manager build --flake .

# Check configuration
nix flake check

# Update dependencies
nix flake update
```

## 📂 Structure

```
.
├── setup.sh             # Automated setup script
├── flake.nix            # Main flake configuration
├── home.nix             # Home Manager module
├── config.nix           # Personal configuration (gitignored)
├── config.nix.example   # Configuration template
├── scripts/             # Setup scripts
│   └── setup-github.sh
└── .gitignore          # Git ignore rules
```

## 🔒 Security

- Personal information is stored in `config.nix` (gitignored)
- `config.nix.example` provides a safe template for sharing
- No personal data is committed to the repository

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Ensure `config.nix.example` reflects any new configuration options
4. Submit a pull request