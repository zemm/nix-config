{ inputs, outputs, lib, config, pkgs, ... }:
{
  # https://nix-community.github.io/home-manager/options.xhtml

  home.packages = with pkgs; [
    #blueman-applet
    networkmanagerapplet # for nm-applet
    pulseaudio # for pactl
    volumeicon
  ];

  programs.alacritty = {
    enable = true;
    # https://alacritty.org/config-alacritty.html
    settings = {
      window.opacity = 0.95;
      window.blur = true;
      # @TODO: colors
      colors.primary.background = "#050505";
      #colors.primary.background = "#fafafa";
    };
  };

  # various
  # @TODO swayr https://sr.ht/~tsdh/swayr/ https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swayr.enable
  # @TODO eww? https://github.com/elkowar/eww
  # @TODO blueman-applet?
  # @TODO undiskie?

  # locking
  # @TODO swayidle? https://nix-community.github.io/home-manager/options.xhtml#opt-services.swayidle.enable
  # @TODO swaylock https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable
  # @TODO betterlockscreen?
  # @TODO screen-locker?

  # notifications
  # @TODO avizo? https://github.com/misterdanb/avizo https://nix-community.github.io/home-manager/options.xhtml#opt-services.avizo.enable
  # @TODO dunz? https://github.com/dunst-project/dunst
  # @TODO fnott? https://codeberg.org/dnkl/fnott

  # auto brightness
  # @TODO gammastep? https://gitlab.com/chinstrap/gammastep
  # @TODO redshift?
  # @TODO safeeyes?
  # @TODO sctd?

  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "${config.home.homeDirectory}/Pictures/wall1";
        duration = "60m";
        apply-shadow = true;
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = let
      black = "#000000";
      blue = "#2b2e36";
      yellow = "#f0d48b";
      darky = "#433f15";
      lessdarky = "#664433";
      grey = "#b0b287";
      green = "#789073";
      red = "#ef2929";
    in rec {
      bars = [
        {
          fonts = {
            names = [ "Ubuntu Mono" "DejaVu Sans Mono" "DejaVu Sans" "FontAwesome5Free" ];
            style = "Semi-Condensed";
            size = 10.0;
          };
          # @TODO check if we have waybar or polybar
          #command = "${pkgs.waybar}/bin/waybar";
          command = "${pkgs.sway}/bin/swaybar";
          extraConfig = "";
          hiddenState = "hide";
          mode = "dock";
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          trayOutput = "*";
          trayPadding = 5;
          workspaceButtons = true;
          workspaceNumbers = true;
          colors = {
            activeWorkspace = {
              background = "${green}";
              border = "${black}";
              text = "${blue}";
            };
            background = "${black}";
            bindingMode = {
              background = "${red}";
              border = "${blue}";
              text = "${yellow}";
            };
            focusedBackground = "${black}";
            focusedSeparator = "${lessdarky}";
            focusedStatusline = "${blue}";
            focusedWorkspace = {
              background = "${darky}";
              border = "${lessdarky}";
              text = "${yellow}";
            };
            inactiveWorkspace = {
              background = "${black}";
              border = "${blue}";
              text = "${green}";
            };
            separator = "${green}";
            statusline = "${yellow}";
            urgentWorkspace = {
              background = "${black}";
              border = "${blue}";
              text = "${red}";
            };
          };
        }
      ];

      colors = {
        #background = "${black}";
        background = "${blue}";
        focused = {
          background = "${darky}";
          border = "${lessdarky}";
          childBorder = "${yellow}";
          indicator = "${red}";
          text = "${yellow}";
        };
        focusedInactive = {
          background = "${blue}";
          border = "${black}";
          childBorder = "${blue}";
          indicator = "${red}";
          text = "${yellow}";
        };
        unfocused = {
          background = "${black}";
          border = "${black}";
          childBorder = "${blue}";
          indicator = "${red}";
          text = "${green}";
        };
        urgent = {
          background = "${red}";
          border = "${red}";
          childBorder = "${blue}";
          indicator = "${red}";
          text = "${blue}";
        };
        placeholder = {
          background = "${blue}";
          border = "${black}";
          childBorder = "${blue}";
          indicator = "${red}";
          text = "${blue}";
        };
      };

      fonts = {
        names = [ "Ubuntu Mono" "DejaVu Sans Mono" "FontAwesome5Free" ];
        #names = [ "Noto Sans" "DejaVu Sans Mono" "FontAwesome5Free" ];
        #style = "Monospace";
        style = "Semi-Condensed";
        size = 10.0;
      };

      gaps = {
        smartBorders = "on";
        #smartGaps = true;
        #horizontal = 5;
        #vertical = 5;
        inner = 10;
        #outer = 10;
      };

      # @TODO: https://wiki.archlinux.org/title/sway#Idle

      # https://man.archlinux.org/man/sway-input.5
      input = {
        # Dell latitude
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us";
          xkb_variant = "colemak";
        };
        "type:keyboard" = {
          repeat_rate = "36";
          repeat_delay = "220";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          dwt = "enabled";
          #tap = "enabled";
          click_method = "clickfinger";
          accel_profile = "adaptive";
          pointer_accel = "0.3";
        };
      };

      # @TODO keybindings https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.keybindings

      # home row keys for moving
      # @TODO: fix collision on mod4+e (do colemak remapping)
      #left = "n";
      #right = "i";
      #up = "u";
      #down = "e";

      #menu = ""; https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.menu
      #modes = {}; https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.modes

      modifier = "Mod4";

      #outputs = {}; https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.outputs
      #seat = {}; # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.seat

      # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.startup
      startup = [
        { command = "alacritty"; }
        # @TODO add conditionals for waybar and polybar
        { command = "systemctl --user restart waybar || :"; always = true; }
        { command = "systemctl --user restart polybar || :"; always = true; }
      ];

      terminal = "alacritty";

      # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.window
      window = {
        border = 0;
        hideEdgeBorders = "both";
        titlebar = false;
      };

      workspaceAutoBackAndForth = true;

      #workspaceOutputAssign = {}; # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.workspaceOutputAssign
    };

    #extraConfigEarly = "";

    extraConfig = ''
      # Brightness
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      # Volume
      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
    '';

    #extraSessionCommands = "";

    swaynag = {
      enable = true;
    };
  };
}
