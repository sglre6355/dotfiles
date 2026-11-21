{
  lib,
  modulesPath,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../modules/system/nixos/network.nix
    ../../modules/system/nixos/openssh.nix
    ../../modules/system/nixos/swap.nix
    ../../modules/system/nixos/system.nix
    ../../modules/system/nixos/users.nix

    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  disabledModules = [ (modulesPath + "/profiles/base.nix") ];

  nixpkgs.hostPlatform = "aarch64-linux";

  hardware.enableRedistributableFirmware = true;

  users.users.${username}.initialPassword = "password";

  environment.systemPackages = [
    (pkgs.runCommand "ether-wake" { } ''
      mkdir -p $out/bin
      ln -s ${lib.getExe pkgs.busybox} $out/bin/ether-wake
    '')
  ];

  programs.zsh.enable = true;

  systemd.settings.Manager.RuntimeWatchdogSec = "30s";

  fileSystems."/".options = [ "noatime" ];
  services.journald.settings.Journal = {
    Storage = "volatile";
    RuntimeMaxUse = "64M";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  time.timeZone = "Europe/London";

  system.stateVersion = "26.11";
}
