{
  ...
}:
{
  imports = [
    ../../profiles/sglre6355.nix
    ../../profiles/hatena.nix

    ../../modules/home/linux/desktop.nix
    ../../modules/home/common/fonts.nix
    ../../modules/home/common/remote-desktop.nix
    ../../modules/home/linux/wayland.nix
    ../../modules/home/linux/mako.nix
    ../../modules/home/linux/sway.nix
  ];

  home.stateVersion = "26.05";
}
