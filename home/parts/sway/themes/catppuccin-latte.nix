{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    config = {
      colors = let
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
        background = "${blue}";
        focused = {
          background = "${peach}";
          border = "${peach}";
          childBorder = "${lavender}";
          indicator = "${rosewater}";
          text = "${base}";
        };
        focusedInactive = {
          background = "${rosewater}";
          border = "${rosewater}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${base}";
        };
        unfocused = {
          background = "${base}";
          border = "${base}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${text}";
        };
        urgent = {
          background = "${maroon}";
          border = "${maroon}";
          childBorder = "${peach}";
          indicator = "${overlay0}";
          text = "${base}";
        };
        placeholder = {
          background = "${base}";
          border = "${base}";
          childBorder = "${overlay0}";
          indicator = "${overlay0}";
          text = "${text}";
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
