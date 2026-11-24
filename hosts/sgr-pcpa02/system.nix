{
  ...
}:
{
  imports = [
    ../../modules/system/nixos
    ../../modules/system/nixos/computer-use.nix
    ./hardware-configuration.nix
  ];

  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi
      path: guid(421ac87e-6137-4704-871c-c311c9a4711a):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  time.timeZone = "Europe/London";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.etc."systemd/network/99-default.link.d/wake-on-lan.conf".text = ''
    [Link]
    WakeOnLan=magic
  '';

  programs.steam.enable = true;

  system.stateVersion = "25.11";
}
