{ config, pkgs, ... }:

let
  # Load personal configuration
  userConfig = import ./config.nix;
in
{
  nixpkgs.config.allowUnfree = true;

  home.username = userConfig.user.name;
  home.homeDirectory = userConfig.user.homeDirectory;

  home.stateVersion = userConfig.nix.stateVersion;
  home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
    bun
    deno
    git
    gh
    uv
    tailscale
    docker
    docker-compose
    claude-code
    gemini-cli
    container-use
  ];

  home.file = {
    ".claude/settings.json".source = ./module/claude/settings.json;
    ".claude/CLAUDE.md".source = ./module/claude/CLAUDE.md;
    ".claude/commands".source = ./module/claude/commands;
  };

  home.sessionVariables = {
  };

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = userConfig.git.userName;
    userEmail = userConfig.git.userEmail;

    extraConfig = {
      init.defaultBranch = userConfig.git.defaultBranch;
      pull.rebase = true;
      push.default = "simple";
      core.editor = userConfig.git.editor;
    };
  };

  home.file.".local/bin/setup-github.sh" = {
    source = ./scripts/setup-github.sh;
    executable = true;
  };

  home.activation.setupGitHub = config.lib.dag.entryAfter ["installPackages"] ''
    if [[ -v DRY_RUN ]]; then
      echo "Would setup GitHub CLI authentication"
    else
      $HOME/.local/bin/setup-github.sh
    fi
  '';


  programs.home-manager.enable = true;
}
