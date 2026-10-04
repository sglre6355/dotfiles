{
  pkgs,
  username,
  ...
}:
{
  nix.settings = {
    allowed-users = [
      username
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "dialout"
      "disk"
      "networkmanager"
      "plugdev"
    ];
  };
}
