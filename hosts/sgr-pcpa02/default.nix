{
  ...
}:
{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi
      path: guid(421ac87e-6137-4704-871c-c311c9a4711a):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  time.timeZone = "Asia/Tokyo";

  programs.steam.enable = true;

  system.stateVersion = "25.11";
}
