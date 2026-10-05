{
  config,
  lib,
  ...
}:
{
  options.karabiner.rules = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
    default = [ ];
    description = "Complex modification rules for Karabiner-Elements.";
  };

  config = {
    home.file = {
      ".config/karabiner/karabiner.json" = {
        force = true;
        text = builtins.toJSON {
          profiles = [
            {
              name = "Default";
              selected = true;
              virtual_hid_keyboard = {
                keyboard_type_v2 = "ansi";
              };
              complex_modifications = {
                inherit (config.karabiner) rules;
              };
            }
          ];
        };
      };
    };

    karabiner.rules = [
      {
        description = ''
          Remap Ctrl+A/C/V/X/Z(+Shift)/Enter to Cmd equivalents except in terminal apps
        '';
        manipulators =
          let
            # WezTerm and Terminal.app are excluded so Ctrl+A/C/V/X/Z still behave as expected in a shell.
            terminalApps = [
              "^com\\.github\\.wez\\.wezterm$"
              "^com\\.apple\\.Terminal$"
            ];
            remap = key: extraModifiers: {
              type = "basic";
              from = {
                key_code = key;
                modifiers = {
                  mandatory = [ "control" ] ++ extraModifiers;
                  optional = [ "caps_lock" ];
                };
              };
              to = [
                {
                  key_code = key;
                  modifiers = [ "command" ] ++ extraModifiers;
                }
              ];
              conditions = [
                {
                  type = "frontmost_application_unless";
                  bundle_identifiers = terminalApps;
                }
              ];
            };
          in
          [
            (remap "a" [ ])
            (remap "c" [ ])
            (remap "v" [ ])
            (remap "x" [ ])
            (remap "z" [ ])
            (remap "c" [ "shift" ])
            (remap "v" [ "shift" ])
            (remap "z" [ "shift" ])
            (remap "return_or_enter" [ ])
          ];
      }
    ];
  };
}
