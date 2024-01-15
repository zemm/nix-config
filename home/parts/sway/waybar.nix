{ pkgs, ... }:
{
  home.packages = [
    pkgs.gsimplecal
  ];

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
        #height = 20;
        #output = [
        #  "eDP-1"
        #  "HDMI-A-1"
        #];

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "wlr/taskbar"
        ];
        modules-center = [
          "sway/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "backlight"
          "pulseaudio"
          "network"
          "bluetooth"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
          "tray"
        ];

        tray = {
          spacing = 10;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
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
          on-click = "blueman-manager";
        };

        clock = {
          tooltip = true;
          on-click = "gsimplecal";
        };

        cpu = {
          format = "cpu:{}%";
          on-click = "alacritty -e bash -ci htop --sort-key PERCENT_CPU";
        };

        memory = {
          format = "mem:{}%";
          on-click = "alacritty -e bash -ci htop --sort-key PERCENT_MEM";
        };

        temperature = {
          format = "temp:{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
          critical-threshold = 80;
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };

        battery = {
          tooltip = true;
          states = {
            "good" = 95;
            "warning" = 20;
            "critical" = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          #format-good = ""; # An empty format will hide the module
          #format-full = "";
          format-icons = ["" "" "" "" ""];
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

        # @TODO
        #"custom/vpn":{
        #    "format": "vpn {icon}",
        #    "tooltip-format": "{icon}",
        #    "exec": "~/.config/waybar/modules/vpn",
        #    "return-type": "json",
        #    "interval": 5,
        #    "format-icons": ["",""]
        #},

        pulseaudio = {
          tooltip = false;
          #"scroll-step = 1; # %, can be a float
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = " {icon}  {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click-right = "pavucontrol";
          on-click-middle = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
        };

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

    # @TODO
    #style = {
    #};
  };
}
