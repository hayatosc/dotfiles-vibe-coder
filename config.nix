# Personal configuration - edit set-env.sh to set environment variables
let
  getEnv = name: default: 
    let value = builtins.getEnv name;
    in if value != "" then value else default;
  
  getEnvRequired = name: 
    let value = builtins.getEnv name;
    in if value != "" then value else throw "Environment variable ${name} is required but not set. Please set it in set-env.sh or your environment.";
in
{
  user = {
    name = getEnv "NIX_USER_NAME" "root";
    homeDirectory = getEnv "NIX_HOME_DIRECTORY" "/root";
  };
  
  git = {
    userName = getEnvRequired "NIX_GIT_USER_NAME";
    userEmail = getEnvRequired "NIX_GIT_USER_EMAIL";
    defaultBranch = getEnv "NIX_GIT_DEFAULT_BRANCH" "main";
    editor = getEnv "NIX_GIT_EDITOR" "nano";
  };
  
  nix = {
    stateVersion = getEnv "NIX_STATE_VERSION" "25.05";
  };
}