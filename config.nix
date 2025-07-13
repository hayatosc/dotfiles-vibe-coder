# Personal configuration - customize this file
let
  getEnv = name: default: 
    let value = builtins.getEnv name;
    in if value != "" then value else default;
in
{
  user = {
    name = getEnv "NIX_USER_NAME" "root";
    homeDirectory = getEnv "NIX_HOME_DIRECTORY" "/root";
  };
  
  git = {
    userName = getEnv "NIX_GIT_USER_NAME" "User Name";
    userEmail = getEnv "NIX_GIT_USER_EMAIL" "user@example.com";
    defaultBranch = getEnv "NIX_GIT_DEFAULT_BRANCH" "main";
    editor = getEnv "NIX_GIT_EDITOR" "nano";
  };
  
  nix = {
    stateVersion = getEnv "NIX_STATE_VERSION" "25.05";
  };
}