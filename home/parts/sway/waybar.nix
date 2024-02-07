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
        position = "bottom";
        height = 20;
        #output = [
        #  "eDP-1"
        #  "HDMI-A-1"
        #];

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          #"sway/window"
        ];
        modules-center = [
          #"sway/window"
        ];
        modules-right = [
          "idle_inhibitor"
          #"bluetooth"
          "custom/vpn"
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "battery"
          #"backlight"
          "tray"
          "clock"
        ];

        backlight = {
          format = "{icon}  {percent}%";
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
          format = "{icon}  {capacity}% {time}";
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
          format = "{icon}  {status}";
          #format-alt = "bt:{status}";
          interval = 30;
          format-icons = {
            enabled = "";
            disabled = "";
          };
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
          #format = "  {usage}% {load}l"; # Icon: microchip
          format = "  {usage}% ({load})"; # Icon: microchip
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bash}/bin/bash -ci htop --sort-key PERCENT_CPU";
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
          #format = "  {}%u {used}u {avail}a {swapPercentage}%sw"; # Icon: memory
          format = "  {}% ({used}G  {avail}G  {swapPercentage}%󰓢)"; # Icon: memory
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bash}/bin/bash -ci htop --sort-key PERCENT_MEM";
          tooltip = true;
        };

        network = {
          interval = 5;
          format-wifi = "  {essid} ({signalStrength}%)"; # Icon: wifi
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
          on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bash}/bin/bash -ci ${pkgs.networkmanager}/bin/nmtui";
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
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
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

        "custom/vpn" = {
          format = "{icon}  {alt}";
          tooltip-format = "{}";
          exec = pkgs.writeShellScript "waybar-vpn" ''
            #!${pkgs.bash}/bin/bash
            if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
              conn=$( \
                ${pkgs.networkmanager}/bin/nmcli c show --active \
                  | ${pkgs.gnugrep}/bin/grep ' vpn ' \
                  | ${pkgs.coreutils}/bin/head -n1 \
                  | ${pkgs.gawk}/bin/awk '{print $1}' \
              )
              echo "{\"text\":\"Connected\", \"alt\":\"$conn\", \"class\":\"on\", \"percentage\":100}"
            else
              echo '{"text":"Disconnected", "alt":"vpn", "class":"off", "percentage":0}'
            fi
          '';
          return-type = "json";
          interval = 5;
          format-icons = ["" ""];
          on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bash}/bin/bash -ci ${pkgs.networkmanager}/bin/nmtui connect";
          #exec = pkgs.writeShellScript "waybar-vpn" ''
          #  #!${pkgs.bash}/bin/bash
          #  [ -d /proc/sys/net/ipv4/conf/wg0 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/at1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/be1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/bg1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/ch1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/hk1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/hu1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/is1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/it1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/nl1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/no1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/rs1 ] \
          #    || [ -d /proc/sys/net/ipv4/conf/tun0 ] \
          #  && echo '{"text":"Connected","class":"on","percentage":100}' \
          #    || echo '{"text":"Disconnected","class":"off","percentage":0}'
          #'';
        };

        #"custom/hello-from-waybar" = {
        #  format = "hello {}";
        #  max-length = 40;
        #  interval = "once";
        #  exec = pkgs.writeShellScript "hello-from-waybar" ''
        #    echo "from within waybar"
        #  '';
        #};

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
  };
}
