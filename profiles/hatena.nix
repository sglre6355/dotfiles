{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/home/common/applications/google-chrome.nix
    ../modules/home/common/development/claude-code.nix
    ../modules/home/common/development/devenv.nix
  ];

  home.packages = with pkgs; [
    slack
    (lib.lowPrio minikube)
    skaffold
    gcc
    go
    nodejs
    terraform
    awscli2
  ];
}
