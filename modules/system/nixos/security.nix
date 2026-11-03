{
  ...
}:
{
  security = {
    pam.services = {
      greetd.enableGnomeKeyring = true;
      swaylock.enableGnomeKeyring = true;
    };
    polkit = {
      enable = true;
      extraConfig = /* js */ ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.login1.suspend" && subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };
}
