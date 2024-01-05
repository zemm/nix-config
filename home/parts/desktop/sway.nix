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

  programs.waybar = {
    enable = true;
    # https://github.com/Alexays/Waybar/wiki/Configuration
    #settings = {
    #};
  };

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
        smartGaps = true;
        # @TODO: test these
        horizontal = 5;
        vertical = 5;
        #inner = 5;
        #outer = 5;
      };

      input = {
        "*" = {
          xkb_variant = "colemak";
        };
      };
    };
  };
}
