{
  ...
}:
{
  imports = [
    ../../modules/system/darwin
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 7;
}
