{
  host,
  ...
}:
{
  networking = {
    hostName = host;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  services.tailscale.enable = true;
  services.zerotierone.enable = true;
  networking.firewall.checkReversePath = "loose";
}
