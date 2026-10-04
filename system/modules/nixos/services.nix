{
  ...
}:
{
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    libinput.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    pcscd.enable = true;
    printing.enable = true;
  };
}
