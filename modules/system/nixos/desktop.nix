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
    # TODO: Remove once nixpkgs ships a json-c release that includes f291fa8.
    # json-c 0.19 leaks nested objects in release builds, and Sway leaks every
    # IPC reply with it.
    package = pkgs.sway.override {
      sway-unwrapped = pkgs.sway-unwrapped.override {
        json_c = pkgs.json_c.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            (pkgs.fetchpatch {
              url = "https://github.com/json-c/json-c/commit/f291fa81c6f21d925ea771a8cca597f5886309cc.patch";
              hash = "sha256-ZffSw1pfEfOH2ylRpJShdx7sTQR2nmPM/JIj/26UrDM=";
            })
          ];
        });
      };
    };
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
