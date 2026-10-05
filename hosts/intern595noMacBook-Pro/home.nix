{
  pkgs,
  ...
}:
{
  imports = [
    ../../profiles/hatena.nix

    ../../modules/home/darwin/aerospace.nix
    ../../modules/home/darwin/jankyborders.nix
    ../../modules/home/darwin/karabiner.nix
  ];

  home.username = "intern595";
  home.homeDirectory = "/Users/intern595";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
