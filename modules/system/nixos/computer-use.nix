{
  username,
  ...
}:
{
  # Pointer input for computer-use-linux: give the user access to /dev/uinput.
  hardware.uinput.enable = true;
  users.users.${username}.extraGroups = [ "uinput" ];

  # AT-SPI accessibility bus, so apps expose accessibility trees.
  services.gnome.at-spi2-core.enable = true;
}
