{
  ...
}:
{
  security = {
    pam.services = {
      greetd.enableGnomeKeyring = true;
      swaylock.enableGnomeKeyring = true;
    };
    polkit.enable = true;
  };
}
