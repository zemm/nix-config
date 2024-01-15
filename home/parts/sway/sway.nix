{ inputs, outputs, lib, config, pkgs, ... }:
{
  # https://nix-community.github.io/home-manager/options.xhtml

  home.packages = with pkgs; [
    # Utils
    feh

    # Tray
    networkmanagerapplet # for nm-applet
    pulseaudio # for pactl

    # Screenshotting
    grim # screenshotting
    slurp # select screen area
    wayshot # screenshotting
  ];

  programs.swaylock = {
    enable = true;
    settings = {
      show-failed-attempts = true;
      indicator-idle-visible = true;

      font-size = 24;
      indicator-radius = 100;

      # Colors from Dracula https://github.com/dracula/swaylock/blob/main/swaylock/config
      #color = "282a36";
      color = "#000000";
      inside-color = "1F202A";
      line-color = "1F202A";
      ring-color = "bd93f9";
      text-color = "f8f8f2";

      layout-bg-color = "1F202A";
      layout-text-color = "f8f8f2";

      inside-clear-color = "6272a4";
      line-clear-color = "1F202A";
      ring-clear-color = "6272a4";
      text-clear-color = "1F202A";

      inside-ver-color = "bd93f9";
      line-ver-color = "1F202A";
      ring-ver-color = "bd93f9";
      text-ver-color = "1F202A";

      inside-wrong-color = "ff5555";
      line-wrong-color = "1F202A";
      ring-wrong-color = "ff5555";
      text-wrong-color = "1F202A";

      bs-hl-color = "ff5555";
      key-hl-color = "50fa7b";

      text-caps-lock-color = "f8f8f2";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      { event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
    timeouts = [
      { timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg \"output * power off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * power on\"";
      }
      { timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      { timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

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

  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Ubuntu Sans Mono 14";
    pass = {
      enable = true;
    };
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-top
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    # @TODO https://nix-community.github.io/home-manager/options.xhtml#opt-programs.rofi.theme
  };

  wayland.windowManager.sway = let
    cfg = config.wayland.windowManager.sway;
  in {
    enable = true;
    config = let
      black = "#000000";
      blue = "#2b2e36";
      foreground = "#00d48b";
      activebg2 = "#003f15";
      activebg = "#004433";
      grey = "#b0b287";
      green = "#789073";
      red = "#ef2929";
    in rec {
      colors = {
        #background = "${black}";
        background = "${blue}";
        focused = {
          background = "${activebg2}";
          border = "${activebg}";
          childBorder = "${foreground}";
          indicator = "${red}";
          text = "${foreground}";
        };
        focusedInactive = {
          background = "${blue}";
          border = "${black}";
          childBorder = "${blue}";
          indicator = "${red}";
          text = "${foreground}";
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

      menu = "${pkgs.rofi}/bin/rofi -show drun";

      # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.keybindings
      keybindings = {
        "${modifier}+Return" = "exec ${cfg.config.terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${cfg.config.menu}";
        "${modifier}+Space" = "exec ${cfg.config.menu}";

        #"${modifier}+${cfg.config.left}" = "focus left";
        #"${modifier}+${cfg.config.down}" = "focus down";
        #"${modifier}+${cfg.config.up}" = "focus up";
        #"${modifier}+${cfg.config.right}" = "focus right";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+${cfg.config.left}" = "move left";
        "${modifier}+Shift+${cfg.config.down}" = "move down";
        "${modifier}+Shift+${cfg.config.up}" = "move up";
        "${modifier}+Shift+${cfg.config.right}" = "move right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+h" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+u" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+p" = "layout toggle split";

        "${modifier}+Shift+a" = "floating toggle";
        "${modifier}+a" = "focus mode_toggle";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+x" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+r" = "mode resize";

        "${modifier}+End" = "exec ${pkgs.swaylock}/bin/swaylock -f && ${pkgs.systemd}/bin/systemctl suspend";
        "${modifier}+Home" = "exec ${pkgs.swaylock}/bin/swaylock";
        "${modifier}+c" = "exec rofi -show calc";
      };

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
        { command = "wpaperd"; }
        { command = "nm-applet"; }
        { command = "blueman-applet"; }
        #{ command = "volumeicon"; } # does not work
        { command = "systemctl --user restart waybar || :"; always = true; }
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

      # Screengrap
      bindsym Print exec 'grim ~/Pictures/screenshots/screen_$(date -u +%Y%m%d-%H%M%S).png'
      bindsym Mod4+Print exec 'wayshot --slurp="$(slurp)" -f ~/Pictures/screenshots/area_$(date -u +%Y%m%d-%H%M%S).png'
    '';

    #extraSessionCommands = "";

    swaynag = {
      enable = true;
    };
  };
}
