{ pkgs, inputs, ... }:
{
  wayland.windowManager.sway.config.bars = [];

  # https://github.com/Alexays/Waybar/wiki
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    # https://github.com/Alexays/Waybar/wiki/Configuration
    #
    # Inspirations:
    # https://gitlab.com/jbauernberger/dotfiles/-/tree/master/.config/waybar
    # https://github.com/yurihikari/garuda-sway-config
    #
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        #output = [
        #  "eDP-1"
        #  "HDMI-A-1"
        #];

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "sway/window"
        ];
        modules-center = [
          #"sway/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "backlight"
          "cpu"
          "memory"
          "network"
          #"bluetooth"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
        ];

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
          tooltip = true;
        };

        battery = {
          interval = 10;
          states = {
            "good" = 95;
            "warning" = 25;
            "critical" = 15;
          };
          format = "{capacity}% {time} {icon}";
          #format-charging = "{capacity}% ";
          #format-plugged = "{capacity}% ";
          #format-alt = "{time} {icon}";
          #format-good = ""; # An empty format will hide the module
          #format-full = "";
          format-icons = [
            "" # battery-full
            "" # battery-three-quarters
            "" # battery-half
            "" # battery-quarter
            "" # battery-empty
          ];
          tooltip = true;
        };

        bluetooth = {
          format = "bt:{status}";
          #format-alt = "bt:{status}";
          interval = 30;
          #format-icons = {
          #  enabled = "";
          #  disabled = "";
          #};
          tooltip-format = "bluetooth {status}";
          #on-click = "blueman-manager";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
        };

        clock = {
          interval = 1;
          format = "  {:%Y-%m-%d %H:%M:%S}"; # Icon: calendar-alt
          on-click = "${pkgs.gsimplecal}/bin/gsimplecal";
          tooltip = true;
        };

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 60;
          format = "  {:%Y-%m-%d}"; # Icon: calendar-alt
        };

        cpu = {
          interval = 5;
          format = "  {usage}% ({load})"; # Icon: microchip
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${pkgs.alacritty}/bin/alacritty -e bash -ci htop --sort-key PERCENT_CPU";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };

        memory = {
          interval = 5;
          format = "  {}%"; # Icon: memory
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${pkgs.alacritty}/bin/alacritty -e bash -ci htop --sort-key PERCENT_MEM";
          tooltip = true;
        };

        network = {
          interval = 5;
          format-wifi = "  {essid} ({signalStrength}%)"; # Icon: wifi
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        # @TODO
        #"network": {
        #  "interface": "wlp2s0", // (Optional) To force the use of this interface
        #  "format-wifi": "{essid} ({signalStrength}%) ",
        #  "format-ethernet": "{ifname}: {ipaddr}/{cidr} ",
        #  "format-linked": "{ifname} (No IP) ",
        #  "format-disconnected": "Disconnected ⚠",
        #  "on-click-right": "kitty --start-as normal bash -ci nmtui",
        #  //"on-click": "kitty --start-as normal bash -ci what",
        #  "format-alt": "{ifname}: {ipaddr}/{cidr}"
        #}

        "sway/mode" = {
          format = "<span style=\"italic\">  {}</span>"; # Icon: expand-arrows-alt
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 120;
        };

        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll = true;
        };

        #pulseaudio = {
        #  tooltip = false;
        #  #"scroll-step = 1; # %, can be a float
        #  format = "{volume}% {icon} {format_source}";
        #  format-bluetooth = "{volume}% {icon}  {format_source}";
        #  format-bluetooth-muted = " {icon}  {format_source}";
        #  format-muted = " {format_source}";
        #  format-source = "{volume}% ";
        #  format-source-muted = "";
        #  format-icons = {
        #    headphone = "";
        #    hands-free = "";
        #    headset = "";
        #    phone = "";
        #    portable = "";
        #    car = "";
        #    default = ["" "" ""];
        #  };
        #  on-click-right = "pavucontrol";
        #  on-click-middle = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        #  on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        #};

        pulseaudio = {
          #scroll-step = 1;
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "pavucontrol";
        };

        #temperature = {
        #  format = "temp:{temperatureC}°C {icon}";
        #  format-icons = ["" "" ""];
        #  critical-threshold = 80;
        #};

        temperature = {
          critical-threshold = 80;
          interval = 5;
          format = "{icon}  {temperatureC}°C";
          format-icons = [
            "" # Icon: temperature-empty
            "" # Icon: temperature-quarter
            "" # Icon: temperature-half
            "" # Icon: temperature-three-quarters
            "" # Icon: temperature-full
          ];
          tooltip = true;
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        # @TODO
        #// % calculated based on (!!) design capacity:
        #// upower -i /org/freedesktop/UPower/devices/battery_BAT0
        #"custom/bat0": {
        #    "states": {
        #        "good": 95,
        #        "warning": 15,
        #        "critical": 10
        #    },
        #    "exec": "~/.config/waybar/modules/battery.py BAT0",
        #    // todo: exec-if not working script gets restarted when reloading sway
        #    // "exec-if": "[ $(pgrep battery.py | wc -l) -lt 1 ]",
        #    "return-type": "json",
        #    "format": "{} {percentage}% {icon}",
        #    "format-icons": ["" "" "" "" ""],
        #    "tooltip": false,
        #    "on-click-right": "kitty --start-as normal bash -i bat",
        #},

        # @TODO
        #"custom/vpn":{
        #    "format": "vpn {icon}",
        #    "tooltip-format": "{icon}",
        #    "exec": "~/.config/waybar/modules/vpn",
        #    "return-type": "json",
        #    "interval": 5,
        #    "format-icons": ["",""]
        #},

        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };

        "wlr/taskbar" = {
          format = "{icon}";
          all-outputs = false;
          on-click = "activate";
          on-middle-click = "close";
          rewrite = {
            "Firefox Web Browser" = "Firefox";
          };
        };
      };
    };

    style = ''
      @import "${inputs.catppuccin-waybar}/themes/latte.css";

      @keyframes blink-warning {
        70% {
          color: white;
        }
        to {
          color: white;
          background-color: orange;
        }
      }

      @keyframes blink-critical {
        70% {
          color: white;
        }
        to {
          color: white;
          background-color: red;
        }
      }

      /* -----------------------------------------------------------------------------
      * Base styles
      * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
        color: @text;
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      /* The whole bar */
      #waybar {
        background-color: alpha(@base, 1);
        border: 0 solid alpha(@crust, 0.3);
        color: @text;
        font-family: UbuntuMono, monospace;
        font-size: 14px;
      }

      /* Each module */
      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #idle_inhibitor,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 2px;
        margin-right: 2px;
        border-radius: 10px;
      }

      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #idle_inhibitor { }
      #backlight {  background-color: shade(@lavender, 1.2); }
      #cpu {        background-color: shade(@sapphire, 1.2); }
      #memory {     background-color: shade(@sky, 1.2); }
      #network {    background-color: shade(@pink, 1.2); }
      #bluetooth { }
      #pulseaudio { background-color: shade(@mauve, 1.9); }
      #battery {    background-color: shade(@green, 1.8); }
      #clock { }


      #battery {
      }
      #battery.warning {
      }
      #battery.critical {
      }
      #battery.warning.discharging {
        background-color: @maroon;
        animation-name: blink-warning;
        animation-duration: 3s;
      }
      #battery.critical.discharging {
        background-color: @red;
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #clock {
        font-weight: bold;
      }

      #cpu {
      }
      #cpu.warning {
      }
      #cpu.critical {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #memory {
      }
      #memory.warning {
      }
      #memory.critical {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #mode {
        background: #64727D;
        border-top: 2px solid white;
        /* To compensate for the top border and still have vertical centering */
        padding-bottom: 2px;
      }

      #network {
      }
      #network.disconnected {
        background-color: @red;
      }

      #pulseaudio {
        background-color: @teal;
      }
      #pulseaudio.muted {
      }

      #custom-spotify {
        color: rgb(102, 220, 105);
      }

      #temperature {
      }
      #temperature.critical {
        background-color: @red;
      }

      #tray {
      }

      #window {
        font-weight: bold;
        padding-left: 10px;
      }

      #workspaces button {
        padding-left: 5px;
        padding-right: 5px;
        color: @mantle;
      }
      #workspaces button.focused {
        background-color: @peach;
        font-weight: bold;
        color: #ffffff;
      }
      #workspaces button.urgent {
        background-color: @red;
        color: #ffffff;
      }
    '';
  };
}

#      #workspaces button {
#        color: @base;
#        border-radius: 50%;
#        margin: 0px 0px;
#        padding: 4 6 2 6;
#      }
#
#      #workspaces button:hover {
#        color: @mauve;
#        box-shadow: none;
#        text-shadow: none;
#        border: 0px;
#        background: none;
#      }
#
#      #workspaces button:hover * {
#        color: @mauve;
#        background-color: @base;
#      }
#
#      #workspaces * {
#        color: whitesmoke;
#      }
#
#      #workspaces {
#        border-style: solid;
#        background-color: @base;
#        opacity: 1;
#        border-radius: 10px;
#        margin: 8px 0px 8px 8px;
#      }
#
#      #workspaces button.focused {
#        color: @mauve;
#        border-radius: 20px;
#      }
#
#      #workspaces button.focused * {
#        color: @mauve;
#      }
#
#      #mode {
#        color: #ebcb8b;
#      }

#      #clock,
#      #custom-swap,
#      #custom-cava-internal,
#      #battery,
#      #cpu,
#      #memory,
#      #idle_inhibitor,
#      #temperature,
#      #custom-keyboard-layout,
#      #backlight,
#      #network,
#      #pulseaudio,
#      #mode,
#      #tray,
#      #custom-power,
#      #custom-pacman,
#      #custom-launcher,
#      #mpd {
#        padding: 5px 8px;
#        border-style: solid;
#        background-color: shade(@base, 1);
#        opacity: 1;
#        margin: 8px 0;
#      }
#
#      /* -----------------------------------------------------------------------------
#        * Module styles
#        * -------------------------------------------------------------------------- */
#      #mpd {
#        border-radius: 10px;
#        color: @mauve;
#        margin-left: 5px;
#        background-color: rgba(0, 0, 0, 0);
#      }
#
#      #mpd.2 {
#        border-radius: 10px 0px 0px 10px;
#        margin: 8px 0px 8px 6px;
#        padding: 4px 12px 4px 10px;
#      }
#
#      #mpd.3 {
#        border-radius: 0px 0px 0px 0px;
#        margin: 8px 0px 8px 0px;
#        padding: 4px;
#      }
#
#      #mpd.4 {
#        border-radius: 0px 10px 10px 0px;
#        margin: 8px 0px 8px 0px;
#        padding: 4px 10px 4px 14px;
#      }
#
#      #mpd.2,
#      #mpd.3,
#      #mpd.4 {
#        background-color: @base;
#        font-size: 14px;
#      }
#
#      #mode {
#        border-radius: 10px;
#        color: @mauve;
#        margin-right: 5px;
#      }
#
#      #custom-cava-internal {
#        border-radius: 10px;
#        color: @mauve;
#      }
#
#      #custom-swap {
#        border-radius: 10px;
#        color: @base;
#        margin-left: 15px;
#        background-color: @mauve;
#      }
#
#      #clock {
#        color: @sky;
#        border-radius: 10px;
#        margin: 8px 10px;
#      }
#
#      #backlight {
#        color: @yellow;
#        border-radius: 10px 0 0 10px;
#      }
#
#      #battery {
#        color: #d8dee9;
#        border-radius: 0 10px 10px 0;
#        margin-right: 10px;
#      }
#
#      #battery.charging {
#        color: #81a1c1;
#      }
#
#      @keyframes blink {
#        to {
#          color: @red;
#        }
#      }
#
#      #battery.critical:not(.charging) {
#        color: #bf616a;
#        animation-name: blink;
#        animation-duration: 0.5s;
#        animation-timing-function: linear;
#        animation-iteration-count: infinite;
#        animation-direction: alternate;
#      }
#
#      #cpu {
#        color: @sky;
#      }
#
#      #cpu #cpu-icon {
#        color: @sky;
#      }
#
#      #memory {
#        color: @sky;
#      }
#
#      #network.disabled {
#        color: #bf616a;
#      }
#
#      #network {
#        color: @green;
#        border-radius: 10px;
#        margin-right: 5px;
#      }
#
#      #network.disconnected {
#        color: #bf616a;
#      }
#
#      #pulseaudio {
#        color: @flamingo;
#      }
#
#      #pulseaudio.muted {
#        color: #3b4252;
#      }
#
#      #temperature {
#        color: @teal;
#        border-radius: 10px 0 0 10px;
#      }
#
#      #temperature.critical {
#        color: @red;
#      }
#
#      #idle_inhibitor {
#        background-color: #ebcb8b;
#        color: @base;
#      }
#
#      #tray {
#        margin: 8px 10px;
#        border-radius: 10px;
#      }
#
#      #custom-launcher,
#      #custom-power {}
#
#      #custom-launcher {
#        background-color: @mauve;
#        color: @base;
#        border-radius: 10px;
#        padding: 5px 10px;
#        margin-left: 15px;
#      }
#
#      #custom-power {
#        color: @base;
#        background-color: @red;
#        border-radius: 10px;
#        margin-left: 5px;
#        margin-right: 15px;
#        padding: 5px 10px;
#      }
#
#      #window {
#        border-style: hidden;
#        margin-left: 10px;
#        padding: 8px 1rem; */
#        margin-right: 10px;
#        color: #eceff4;
#      }
#
#      #custom-keyboard-layout {
#        color: @peach;
#        border-radius: 0 10px 10px 0;
#        margin-right: 10px;
#      }
