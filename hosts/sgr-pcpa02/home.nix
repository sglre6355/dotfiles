{
  pkgs,
  ...
}:
{
  imports = [
    ../../profiles/sglre6355.nix

    ../../modules/home/linux/desktop.nix
    ../../modules/home/common/fonts.nix
    ../../modules/home/common/remote-desktop.nix
    ../../modules/home/linux/wayland.nix
    ../../modules/home/linux/mako.nix
    ../../modules/home/linux/sway.nix
    ../../modules/home/linux/computer-use.nix
    ../../modules/home/linux/wine.nix
  ];

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    audacity
    prismlauncher
    osu-lazer-bin
  ];

  wayland.windowManager.sway.config = {
    output = {
      "AOC 24B3HA2 AVKR69A005233" = {
        mode = "1920x1080@120Hz";
        pos = "0 0";
      };
      "AOC 24B3HA2 AVKR69A005771" = {
        mode = "1920x1080@120Hz";
        pos = "1920 0";
      };
      "MS Telematica MStar Demo 0x00000001" = {
        mode = "1360x768@60Hz";
        pos = "2200 -768";
      };
    };
    workspaceOutputAssign = [
      {
        workspace = "1";
        output = "AOC 24B3HA2 AVKR69A005771";
      }
      {
        workspace = "9";
        output = "AOC 24B3HA2 AVKR69A005233";
      }
      {
        workspace = "10";
        output = "MS Telematica MStar Demo 0x00000001";
      }
    ];
  };

  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-vaapi
  ];
}
