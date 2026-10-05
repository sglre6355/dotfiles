{
  lib,
  pkgs,
  hostPlatform,
  ...
}:
{
  imports = [
    ./core.nix

    ../modules/home/common/veracrypt.nix
    ../modules/home/common/rtorrent.nix

    ../modules/home/common/claude-code.nix
    ../modules/home/common/codex.nix
    ../modules/home/common/devenv.nix
    ../modules/home/common/kubernetes.nix
    ../modules/home/common/podman.nix
  ]
  ++ lib.optionals hostPlatform.isLinux [
    ../modules/home/linux/easyeffects.nix
  ];

  home.username = lib.mkDefault "sglre6355";
  home.homeDirectory = lib.mkDefault "/home/sglre6355";

  home.packages = with pkgs; [
    ffmpeg
    gimp
    imagemagick
    poppler-utils

    android-tools
    google-cloud-sdk

    unar
  ];

  programs.zsh.initContent = /* zsh */ ''
    nix() {
      if [[ "$1" == develop ]]; then
        shift
        command nix develop "$@" -c zsh
      else
        command nix "$@"
      fi
    }
  '';

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            email = "sglre6355@gmail.com";
            name = "sglre6355";
          };
        };
      }
    ];
  };

  programs.discord.enable = true;

  programs.obs-studio.enable = true;
}
