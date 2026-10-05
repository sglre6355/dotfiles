{
  pkgs,
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
