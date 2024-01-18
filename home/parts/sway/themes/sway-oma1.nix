{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    config = {
      colors = let
        black = "#000000";
        blue = "#2b2e36";
        foreground = "#00d48b";
        activebg2 = "#003f15";
        activebg = "#004433";
        grey = "#b0b287";
        green = "#789073";
        red = "#ef2929";
      in {
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
        smartBorders = "off";
        #smartGaps = true;
        #horizontal = 5;
        #vertical = 5;
        inner = 10;
        #outer = 10;
      };

      # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.window
      window = {
        border = 0;
        hideEdgeBorders = "both";
        titlebar = true;
      };
    };
  };
}
