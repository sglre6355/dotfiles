{
  ...
}:
{
  imports = [
    ../../modules/system/nixos
    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Tokyo";

  system.stateVersion = "25.11";
}
