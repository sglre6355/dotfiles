{
  pkgs,
  ...
}:
{
  imports = [
    ../../profiles/reazon-holdings.nix

    ../../modules/home/darwin/desktop
  ];

  home.username = "keima_hara";
  home.homeDirectory = "/Users/keima_hara";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
