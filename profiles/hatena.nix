{
  pkgs,
  hostPlatform,
  lib,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/home/common/google-chrome.nix
    ../modules/home/common/claude-code.nix
    ../modules/home/common/devenv.nix
  ]
  ++ lib.optionals hostPlatform.isDarwin [
    ../modules/home/darwin/google-chrome.nix
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
