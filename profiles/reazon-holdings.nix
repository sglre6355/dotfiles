{
  lib,
  pkgs,
  hostPlatform,
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
    bruno
    slack
    nodejs
    bun
    uv
    go
    golangci-lint
    buf
    google-cloud-sdk
  ];

  programs.git.includes = [
    {
      condition = "gitdir:~/ghq/github.com/reazon-hypes/";
      contents = {
        commit.gpgSign = false;
        user = {
          email = "keima_hara@reazon.jp";
          name = "keima_hara";
        };
      };
    }
  ];
}
