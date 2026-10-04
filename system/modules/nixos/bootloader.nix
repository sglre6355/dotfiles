{
  ...
}:
{
  boot = {
    initrd.systemd.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        secureBoot.enable = true;
        maxGenerations = 5;
        style = {
          wallpapers = [ ];
          interface = {
            helpHidden = true;
          };
        };
      };
    };
  };
}
