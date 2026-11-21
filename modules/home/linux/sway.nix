{
  config,
  lib,
  pkgs,
  ...
}:
let
  launchApp = pkgs.writeShellScript "launch-app" ''
    entry=$(${lib.getExe config.programs.wofi.package} --show drun -D key_expand=Tab -D drun-print_desktop_file=true) || exit 0
    exec ${lib.getExe pkgs.uwsm} app -- "''${entry/ /:}"
  '';

  # Sway ignores idle inhibitors held by regular clients (such as Waybar) while
  # the session is locked, so the inhibitor stops swayidle instead.
  swayidleIsActive = "${lib.getExe' pkgs.systemd "systemctl"} --user --quiet is-active swayidle.service";

  idleInhibitStatus = pkgs.writeShellScript "idle-inhibit-status" ''
    if ${swayidleIsActive}; then
      echo '{"alt": "deactivated", "class": "deactivated", "tooltip": "Idle inhibitor: deactivated"}'
    else
      echo '{"alt": "activated", "class": "activated", "tooltip": "Idle inhibitor: activated"}'
    fi
  '';

  idleInhibitToggle = pkgs.writeShellScript "idle-inhibit-toggle" ''
    if ${swayidleIsActive}; then
      ${lib.getExe' pkgs.systemd "systemctl"} --user stop swayidle.service
    else
      ${lib.getExe' pkgs.systemd "systemctl"} --user start swayidle.service
    fi
    ${lib.getExe' pkgs.procps "pkill"} -RTMIN+8 waybar
  '';

  cycleOutputFocus = pkgs.writeShellScript "cycle-output-focus" ''
    name=$(${lib.getExe' pkgs.sway "swaymsg"} -t get_outputs | ${lib.getExe pkgs.jq} -r --argjson step "$1" '
      [.[] | select(.active)] | sort_by(.rect.x, .rect.y) as $outs
      | ($outs | map(.focused) | index(true)) as $i
      | $outs[($i + $step) % ($outs | length)].name
    ')
    [ -n "$name" ] && exec ${lib.getExe' pkgs.sway "swaymsg"} focus output "$name"
  '';
in
{
  imports = [
    ../common/wezterm.nix
  ];

  # Without this, fcitx5 destroys its virtual keyboard on every deactivation
  # and sway's seat is left without a keyboard until a physical key is pressed.
  i18n.inputMethod.fcitx5.settings.addons.waylandim.globalSection.PersistentVirtualKeyboard = "True";

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = false;
    config = rec {
      modifier = "Mod4";
      terminal = "${lib.getExe pkgs.uwsm} app -- ${lib.getExe config.programs.wezterm.package}";
      menu = "${launchApp}";
      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      defaultWorkspace = "workspace number 1";
      output = {
        "*" = {
          bg = "#4e4e4e solid_color";
        };
      };
      bars = [
        {
          command = lib.getExe pkgs.waybar;
        }
      ];
      startup = [
        { command = "${lib.getExe pkgs.uwsm} finalize"; }
      ];
      focus.wrapping = "workspace";
      workspaceLayout = "tabbed";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";

        "Alt+Tab" = "workspace next_on_output";
        "Alt+Shift+Tab" = "workspace prev_on_output";

        "Alt+Control+Tab" = "exec ${cycleOutputFocus} 1";
        "Alt+Control+Shift+Tab" = "exec ${cycleOutputFocus} -1";

        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";

        "--locked XF86AudioRaiseVolume" =
          "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" =
          "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_SINK@ 5%-";
        "--locked XF86AudioMute" =
          "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" =
          "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_SOURCE@ toggle";

        "--locked XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
        "--locked XF86AudioNext" = "exec ${lib.getExe pkgs.playerctl} next";
        "--locked XF86AudioPrev" = "exec ${lib.getExe pkgs.playerctl} previous";

        "--locked XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set 10%+";
        "--locked XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set 10%-";
        "--locked XF86MonBrightnessUp+Shift" = "exec ${lib.getExe pkgs.brightnessctl} set 5%+";
        "--locked XF86MonBrightnessDown+Shift" = "exec ${lib.getExe pkgs.brightnessctl} set 5%-";

        # Snipping tool
        "${modifier}+Shift+s" =
          "exec ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";

        # Lock screen
        "${modifier}+l" = "exec ${lib.getExe pkgs.swaylock} -f";
        # Lock screen and suspend
        "${modifier}+Shift+l" =
          "exec ${lib.getExe' pkgs.systemd "systemctl"} suspend; ${lib.getExe pkgs.swaylock} -f";
      };
    };
  };

  programs.wofi.enable = true;

  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/workspaces"
        ];

        modules-right = [
          "network"
          "custom/separator"
          "wireplumber"
          "custom/separator"
          "battery"
          "custom/no_battery_indicator"
          "custom/separator"
          "clock"
          "custom/separator"
          "custom/idle_inhibitor"
          "tray"
        ];

        "custom/separator" = {
          format = "┃";
          tooltip = false;
        };

        "custom/no_battery_indicator" = {
          exec = ''
            ls /sys/class/power_supply/BAT* >/dev/null 2>&1 || echo "No battery"
          '';
          format = "{}";
        };

        network = {
          format = "{ifname}";
          format-wifi = "W: {essid} ({signalStrength}%)";
          format-ethernet = "E: {ifname}";
          format-disconnected = "No network";
        };

        wireplumber = {
          format = "V: {volume}%";
          format-muted = "V: muted ({volume}%)";
          scroll-step = 5;
          on-click = lib.getExe pkgs.pwvucontrol;
        };

        battery = {
          format = "BAT {capacity}% {time}";
          format-discharging = "BAT {capacity}% {time}";
          format-charging = "CHR {capacity}% {time}";
          format-plugged = "IDLE {capacity}%";
          format-full = "FULL {capacity}%";

          format-time = "{H}h {m}m";

          states = {
            warning = 15;
            critical = 5;
          };
        };

        clock = {
          format = "{:%Y-%m-%d %H:%M:%S}";
          interval = 1;
          tooltip = false;
        };

        "custom/idle_inhibitor" = {
          exec = "${idleInhibitStatus}";
          return-type = "json";
          interval = "once";
          signal = 8;
          on-click = "${idleInhibitToggle}";
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };

        tray = {
          icon-size = 15;
          show-passive-items = true;
          spacing = 5;
        };
      }
    ];

    style = ''
      * {
        border-radius: 1;
        font-family: monospace;
        font-size: 11px;
        min-height: 17px;
      }

      window#waybar {
        background: #323232;
        color: #ffffff;
        margin: 0px;
        padding: 0px;
      }

      #workspaces button {
        color: #5c5c5c;
        min-width: 17px;
        margin: 0px;
        padding: 0px 0.5px;
      }

      #workspaces button:hover {
        border: 1px solid #323232;
      }

      #workspaces button.visible {
        background: #5f676a;
        color: #ffffff;
      }

      #workspaces button.focused {
        background: #285577;
        color: #ffffff;
        border: 1px solid #4c7899;
      }

      #workspaces button.urgent {
        background: #900000;
        color: #ffffff;
        border: 1px solid #900000;
      }

      #custom-separator {
        color: #4c4c4c;
        margin: 0 2px;
      }

      #network {
        color: #00ff00;
      }
      #network.disconnected,
      #network.disabled {
        color: #ff0000;
      }

      #wireplumber.sink-muted {
        color: #ffff00;
      }

      #battery.warning {
        color: #ffff00;
      }
      #battery.critical {
        color: #ff0000;
      }

      #custom-idle_inhibitor {
        margin-right: 10px;
      }
    '';
  };

  services.swayidle =
    let
      lock = "${lib.getExe pkgs.swaylock} -f";
      display = status: "${lib.getExe' pkgs.sway "swaymsg"} 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 170;
          command = "${lib.getExe pkgs.libnotify} 'Locking in 10 seconds' -t 10000";
        }
        {
          timeout = 180;
          command = lock;
        }
        {
          timeout = 300;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 900;
          command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
        }
      ];
      events = {
        before-sleep = (display "off") + "; " + lock;
        after-resume = display "on";
      };
    };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "4e4e4e";
      show-failed-attempts = true;
    };
  };
}
