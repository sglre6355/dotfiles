{
  pkgs,
  ...
}:
{
  imports = [
    ../../profiles/reazon-holdings.nix

    ../../modules/home/darwin/aerospace.nix
    ../../modules/home/darwin/jankyborders.nix
    ../../modules/home/darwin/karabiner.nix
  ];

  home.username = "keima_hara";
  home.homeDirectory = "/Users/keima_hara";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
