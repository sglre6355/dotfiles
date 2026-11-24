{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Keyboard input for computer-use-linux on wlroots compositors.
    wtype
    # gdbus and gsettings, used to check and enable AT-SPI accessibility.
    glib
  ];

  # Ask toolkits (GTK, Firefox, Chromium) to expose AT-SPI accessibility trees.
  dconf.settings."org/gnome/desktop/interface".toolkit-accessibility = true;
}
