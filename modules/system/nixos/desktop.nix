{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.xserver = {
    desktopManager.runXdgAutostartIfNone = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --cmd '${lib.getExe config.programs.uwsm.package} start -g -1 -F -- ${lib.getExe config.programs.sway.package}'";
        user = "greeter";
      };
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
  };

  programs.uwsm.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
