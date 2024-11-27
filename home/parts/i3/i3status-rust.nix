{ inputs, outputs, lib, config, pkgs, ... }:
let
  # catppuccin-latte
  rosewater = "#dc8a78";
  flamingo =  "#dd7878";
  pink =      "#ea76cb";
  mauve =     "#8839ef";
  red =       "#d20f39";
  maroon =    "#e64553";
  peach =     "#fe640b";
  yellow =    "#df8e1d";
  green =     "#40a02b";
  teal =      "#179299";
  sky =       "#04a5e5";
  sapphire =  "#209fb5";
  blue =      "#1e66f5";
  lavender =  "#7287fd";
  text =      "#4c4f69";
  subtext1 =  "#5c5f77";
  subtext0 =  "#6c6f85";
  overlay2 =  "#7c7f93";
  overlay1 =  "#8c8fa1";
  overlay0 =  "#9ca0b0";
  surface2 =  "#acb0be";
  surface1 =  "#bcc0cc";
  surface0 =  "#ccd0da";
  base =      "#eff1f5";
  mantle =    "#e6e9ef";
  crust =     "#dce0e8";
in {
  xsession.windowManager.i3.config.bars = [
    {
      position = "bottom";
      statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
      fonts = [ "DejaVu Sans Mono" "Font Awesome 6 Free" "FontAwesome6Free" ];
      extraConfig = ''
        workspace_min_width 30
      '';
      colors = {
        inactiveWorkspace = {
          background = "#2a2c41";
          border = "#000000";
          text = "${overlay1}";
        };
        focusedWorkspace = {
          background = "${peach}";
          border = "${peach}";
          text = "${base}";
        };
        activeWorkspace = {
          background = "${rosewater}";
          border = "${rosewater}";
          text = "${text}";
        };
        urgentWorkspace = {
          background = "${red}";
          border = "${red}";
          text = "${text}";
        };
        #background = "${base}";
        #separator = "${teal}";
        #statusline = "${sapphire}";
        #focusedBackground = "${peach}";
        #focusedSeparator = "${flamingo}";
        #focusedStatusline = "${maroon}";
      };
    }
  ];

  programs.i3status-rust = {
    enable = true;

    bars = {
      bottom = {
        icons = "awesome6";
        #theme = "gruvbox-light";
        theme = "modern";

        settings = {
          theme =  {
            theme = "modern";
          };
        };

        blocks = [
          {
            block = "pomodoro";
          }
          {
            block = "custom";
            command = pkgs.writeShellScript "i3status-vpn" ''
              if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
                conn=$( \
                  ${pkgs.networkmanager}/bin/nmcli c show --active \
                    | ${pkgs.gnugrep}/bin/grep ' vpn ' \
                    | ${pkgs.coreutils}/bin/head -n1 \
                    | ${pkgs.gawk}/bin/awk '{print $1}' \
                )
                echo "{\"state\":\"good\", \"text\":\"VPN $conn\", \"alt\":\"$conn\", \"class\":\"on\", \"percentage\":100}"
              else
                echo '{"state":"idle", "text":"VPN off", "alt":"vpn", "class":"off", "percentage":0}'
              fi
            '';
            json = true;
            click = [{
              button = "left";
              cmd = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bash}/bin/bash -ci \"${pkgs.networkmanager}/bin/nmtui connect\"";
            }];
            theme_overrides.good_bg = "${pink}";
            theme_overrides.good_fg = "${base}";
            #theme_overrides.idle_bg = "${text}";
            #theme_overrides.idle_fg = "${surface1}";
          }
          {
            block = "net";
            format = " $icon ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) $ssid ";
            theme_overrides.idle_bg = "${lavender}";
          }
          #{
          #  alert = 10.0;
          #  block = "disk_space";
          #  format = " $icon /: $available.eng(w:2) ";
          #  info_type = "available";
          #  interval = 60;
          #  path = "/";
          #  warning = 20.0;
          #  theme_overrides.idle_bg = "${teal}";
          #}
          {
            block = "memory";
            theme_overrides.idle_bg = "${sky}";
          }
          {
            block = "cpu";
            interval = 1;
            theme_overrides.idle_bg = "${sapphire}";
          }
          {
            block = "load";
            interval = 3;
            theme_overrides.idle_bg = "${teal}";
          }
          {
            block = "sound";
            click = [
              {
                button = "left";
                cmd = "${pkgs.pavucontrol}/bin/pavucontrol --tab=3";
              }
            ];
            theme_overrides.idle_bg = "${teal}";
          }
          {
            block = "battery";
            #theme_overrides.idle_bg = "${green}";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%Y-%m-%d %R') ";
            interval = 60;
          }
        ];
      };
    };
  };
}
