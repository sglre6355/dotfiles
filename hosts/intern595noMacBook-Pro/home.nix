{
  pkgs,
  ...
}:
{
  imports = [
    ../../profiles/hatena.nix

    ../../modules/home/darwin/desktop
  ];

  home.username = "intern595";
  home.homeDirectory = "/Users/intern595";

  home.packages = with pkgs; [
    coreutils
  ];

  home.stateVersion = "26.05";
}
