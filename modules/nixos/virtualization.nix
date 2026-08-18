{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  virtualisation = {
    containers = {
      enable = true;
      registries.search = [ "docker.io" ];
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };

  users.users.${username}.extraGroups = [
    "podman"
  ];
}
