{ inputs, outputs, lib, config, pkgs, ... }:
let
  cmdChangeWallpaper = "test -d $HOME/Pictures/wall && find $HOME/Pictures/wall/ -type f | shuf -n1 | xargs --no-run-if-empty ${pkgs.feh}/bin/feh --bg-scale";
in {
  home.packages = with pkgs; [
    arandr
  ];

  programs.feh.enable = true;

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
      "change-background" = "${cmdChangeWallpaper}";
      "keep-dpi" = ''
        echo "Xft.dpi: 96" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
      '';
    };
  };

  services.autorandr = {
    enable = true;
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

  services.gnome-keyring = {
    enable = true;
    #components = [ "secrets" ];
  };

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock --show-failed-attempts --ignore-empty-password --pointer=win --no-unlock-indicator --image=$HOME/Pictures/lock.png";
    inactiveInterval = 10;
  };

  # @TODO https://nix-community.github.io/home-manager/options.xhtml#opt-services.xidlehook.enable
  #services.xidlehook = {
  #  enable = true;
  #}

  # https://nix-community.github.io/home-manager/options.xhtml#opt-xsession.windowManager.i3.enable
  xsession.windowManager.i3 = let
    cfg = config.xsession.windowManager.i3;
  in {
    enable = true;
    #package = pkgs.i3-gaps;

    config.menu = "${pkgs.rofi}/bin/rofi -show drun";

    config.modifier = "Mod4";

    config.workspaceAutoBackAndForth = true;

    config.floating.criteria = [
      { class = "Galculator"; }
      { class = "Calculator"; }
      { title = "i3_help"; }
    ];

    config.gaps = {
      inner = 10;
      outer = 5;
    };

    config.terminal = "${pkgs.alacritty}/bin/alacritty";

    config.startup = [
      { command = "${cmdChangeWallpaper}"; always = true; }
    ];

    config.keybindings = let
      mod = cfg.config.modifier;
      i3statusRefresh = "killall -SIGUSR1 i3status";
    in {
      "${mod}+Return" = "exec ${cfg.config.terminal}";
      "${mod}+Shift+q" = "kill";
      "${mod}+d" = "exec ${cfg.config.menu}";
      "${mod}+space" = "exec ${cfg.config.menu}";

      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      # Move focused container
      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";

      # Move focused workspace to another monitor
      "${mod}+Control+Left" = "move workspace to output left";
      "${mod}+Control+Right" = "move workspace to output right";
      "${mod}+Control+Up" = "move workspace to output up";
      "${mod}+Control+Down" = "move workspace to output down";

      "${mod}+h" = "splith";
      "${mod}+v" = "splitv";
      "${mod}+f" = "fullscreen toggle";
      "${mod}+p" = "focus parent";
      "${mod}+Shift+p" = "focus child";

      "${mod}+s" = "layout stacking";
      "${mod}+w" = "layout tabbed";
      "${mod}+t" = "layout toggle split";

      "${mod}+Shift+f" = "floating toggle";
      "${mod}+a" = "focus mode_toggle";

      "${mod}+1" = "workspace number 1";
      "${mod}+2" = "workspace number 2";
      "${mod}+3" = "workspace number 3";
      "${mod}+4" = "workspace number 4";
      "${mod}+5" = "workspace number 5";
      "${mod}+6" = "workspace number 6";
      "${mod}+7" = "workspace number 7";
      "${mod}+8" = "workspace number 8";
      "${mod}+9" = "workspace number 9";

      "${mod}+Shift+1" = "move container to workspace number 1";
      "${mod}+Shift+2" = "move container to workspace number 2";
      "${mod}+Shift+3" = "move container to workspace number 3";
      "${mod}+Shift+4" = "move container to workspace number 4";
      "${mod}+Shift+5" = "move container to workspace number 5";
      "${mod}+Shift+6" = "move container to workspace number 6";
      "${mod}+Shift+7" = "move container to workspace number 7";
      "${mod}+Shift+8" = "move container to workspace number 8";
      "${mod}+Shift+9" = "move container to workspace number 9";

      "${mod}+Shift+minus" = "move scratchpad";
      "${mod}+minus" = "scratchpad show";

      "${mod}+Shift+r" = "reload";
      #"${mod}+Shift+x" =
      #  "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

      "${mod}+r" = "mode resize";

      "${mod}+End" = "exec ${config.services.screen-locker.lockCmd} && ${pkgs.systemd}/bin/systemctl suspend";
      "${mod}+Home" = "exec ${config.services.screen-locker.lockCmd}";
      "${mod}+c" = "exec rofi -show calc";

      # Rename current workspace
      #"${mod}+Shift+n" = "exec swaymsg rename workspace to \"$(swaymsg -t get_workspaces|jq '.[]|select(.focused==true)|.num'):$(${pkgs.gnome.zenity}/bin/zenity --entry --title 'Rename workspace' --text 'New name:' --entry-text '')\"";
      "${mod}+Shift+n" = "exec NUM=$(i3-msg -t get_workspaces|jq \".[]|select(.focused==true)|.num\") && i3-input -F \"rename workspace to $NUM.%s\" -P \"New name for this workspace: $NUM.\"";

      # Rotate wallpaper
      "${mod}+Shift+w" = "exec ${cmdChangeWallpaper}";

      # Mediakeys
      "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5% && ${i3statusRefresh}";
      "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5% && ${i3statusRefresh}";
      "Shift+XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1% && ${i3statusRefresh}";
      "Shift+XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1% && ${i3statusRefresh}";
      "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && ${i3statusRefresh}";
      "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${i3statusRefresh}";
    };
  };
}
