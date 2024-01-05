{ inputs, outputs, lib, config, pkgs, ... }:
{
  # https://nix-community.github.io/home-manager/options.xhtml

  programs.alacritty = {
    enable = true;
    # https://alacritty.org/config-alacritty.html
    settings = {
      window.opacity = 0.9;
      window.blur = true;
      # @TODO: colors
    };
  };

  # @TODO swaylock https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable
  # @TODO swayr https://sr.ht/~tsdh/swayr/ https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swayr.enable

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        { command = "alacritty"; }
      ];

      gaps = {
        smartBorders = "on";
        #smartGaps = true;
        # @TODO: test these
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
    };
  };
}
