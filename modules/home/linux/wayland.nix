{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waypipe
    wayvnc
    wl-clipboard
  ];

  i18n.inputMethod.fcitx5.waylandFrontend = true;
}
