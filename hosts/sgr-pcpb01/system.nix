{
  ...
}:
{
  imports = [
    ../../modules/system/nixos
    ../../modules/system/nixos/computer-use.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "Europe/London";

  system.stateVersion = "25.11";
}
