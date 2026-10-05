{
  ...
}:
{
  imports = [
    ../../modules/system/nixos
    ./hardware-configuration.nix
  ];

  time.timeZone = "Europe/London";

  system.stateVersion = "25.11";
}
