#!/bin/bash
set -euo pipefail

export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/root/bin:$PATH"

find_gh_binary() {
    local gh_bin=""
    if [ -f "$HOME/.nix-profile/bin/gh" ]; then
        gh_bin="$HOME/.nix-profile/bin/gh"
    elif [ -f "/etc/profiles/per-user/root/bin/gh" ]; then
        gh_bin="/etc/profiles/per-user/root/bin/gh"
    fi
    echo "$gh_bin"
}

setup_github_auth() {
    local gh_bin
    gh_bin=$(find_gh_binary)
    
    if [ -z "$gh_bin" ]; then
        echo "GitHub CLI binary not found in expected locations"
        echo "Searching for gh..."
        find /nix /etc/profiles -name "gh" -type f 2>/dev/null | head -5 || echo "No gh binary found"
        echo "Please run 'gh auth login' manually after setup."
        return 1
    fi
    
    if ! "$gh_bin" auth status >/dev/null 2>&1; then
        echo "Found GitHub CLI at: $gh_bin"
        echo "Checking GitHub CLI authentication status..."
        echo ""
        echo "=========================================="
        echo "GitHub CLI is not authenticated"
        echo "Attempting to authenticate..."
        echo "=========================================="
        echo ""
        
        if "$gh_bin" auth login --git-protocol ssh --web; then
            echo ""
            echo "GitHub authentication successful!"
            "$gh_bin" auth status
        else
            echo ""
            echo "Automatic authentication failed."
            echo "Please run 'gh auth login' manually after setup."
            return 1
        fi
    else
        echo "GitHub CLI already authenticated"
        "$gh_bin" auth status
    fi
}

main() {
    echo "Setting up GitHub CLI authentication..."
    setup_github_auth
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi