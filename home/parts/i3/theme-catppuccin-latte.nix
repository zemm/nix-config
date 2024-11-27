{ pkgs, inputs, ... }:
{
  xsession.windowManager.i3 = let
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
    config = {
      colors = {
        background = "${surface0}";
        focused = {
          background = "${peach}";
          border = "${peach}";
          childBorder = "${rosewater}";
          indicator = "${rosewater}";
          text = "${base}";
        };
        focusedInactive = {
          background = "${rosewater}";
          border = "${rosewater}";
          childBorder = "${overlay2}";
          indicator = "${rosewater}";
          text = "${base}";
        };
        unfocused = {
          background = "${base}";
          border = "${base}";
          childBorder = "${overlay2}";
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
        names = [ "UbuntuMono Nerd Font" ];
        #style = "Monospace";
        style = "Semi-Condensed";
        size = 11.0;
      };

      gaps = {
        smartBorders = "off";
        #smartGaps = true;
        #horizontal = 5;
        #vertical = 5;
        inner = 10;
        #outer = 10;
        bottom = 0;
      };

      window = {
        border = 0;
        hideEdgeBorders = "both";
        titlebar = true;
      };
    };
  };


#  programs.waybar.style = ''
#    @import "${inputs.catppuccin-waybar}/themes/latte.css";
#
#    @keyframes blink-warning {
#      70% {
#        color: white;
#      }
#      to {
#        color: white;
#        background-color: orange;
#      }
#    }
#
#    @keyframes blink-critical {
#      70% {
#        color: white;
#      }
#      to {
#        color: white;
#        background-color: red;
#      }
#    }
#
#    /* -----------------------------------------------------------------------------
#    * Base styles
#    * -------------------------------------------------------------------------- */
#
#    /* Reset all styles */
#    * {
#      color: @text;
#      border: none;
#      border-radius: 0;
#      min-height: 0;
#      margin: 0;
#      padding: 0;
#    }
#
#    /* The whole bar */
#    #waybar {
#      background-color: alpha(@base, 1);
#      border: 0 solid alpha(@crust, 0.3);
#      color: @text;
#      font-family: UbuntuMono Nerd Font, Hack, Ubuntu;
#      font-size: 14px;
#    }
#
#    #workspaces {
#      border-right: 1px solid @crust;
#    }
#    #workspaces button {
#      padding: 0 5px;
#      border-left: 1px solid @mantle;
#    }
#    #workspaces button * {
#      color: @text;
#    }
#    #workspaces button.visible {
#      background-color: alpha(@peach, 0.5);
#    }
#    #workspaces button.focused {
#      background-color: @peach;
#    }
#    /*
#      * https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect
#      */
#    #workspaces button:hover {
#      background: @pink;
#      border-top: none;
#      border-right: none;
#      border-bottom: none;
#      padding: 0 5px;
#      box-shadow: inherit;
#      text-shadow: inherit;
#    }
#    #workspaces button.urgent {
#      background-color: @red;
#    }
#    #workspaces button.visible *,
#    #workspaces button.focused *,
#    #workspaces button.urgent *,
#    #workspaces button:hover * {
#      color: @base;
#    }
#
#    /* Each module */
#    #backlight,
#    #battery,
#    #bluetooth,
#    #clock,
#    #cpu,
#    #custom-keyboard-layout,
#    #custom-vpn,
#    #idle_inhibitor,
#    #memory,
#    #mode,
#    #network,
#    #pulseaudio,
#    #temperature,
#    #tray {
#      animation-timing-function: linear;
#      animation-iteration-count: infinite;
#      animation-direction: alternate;
#      padding-left: 10px;
#      padding-right: 10px;
#      margin-left: 2px;
#      margin-right: 2px;
#      border-radius: 8px;
#    }
#
#    #cpu {
#      margin-right: 0;
#      padding-right: 5px;
#      border-radius: 8px 0px 0px 8px;
#      border-right: 5px solid #17a1c5;
#    }
#    #memory {
#      margin-left: 0;
#      padding-left: 5px;
#      border-radius: 0px 8px 8px 0px;
#      border-left: 5px solid #0da3d5;
#    }
#
#    /* -----------------------------------------------------------------------------
#      * Module styles
#      * -------------------------------------------------------------------------- */
#
#    #idle_inhibitor { }
#    #bluetooth {  color: #ffffff; background-color: @blue; }
#    #custom-vpn.on {  color: #ffffff;   background-color: @mauve; }
#    #custom-vpn.off { color: @subtext0; background-color: @crust; }
#    #network {    color: #ffffff; background-color: @lavender; }
#    #cpu {        color: #ffffff; background-color: @sapphire; }
#    #memory {     color: #ffffff; background-color: @sky; }
#    #pulseaudio { color: #ffffff; background-color: @teal; }
#    #battery {    color: #ffffff; background-color: @green; }
#    #backlight {  color: #ffffff; background-color: @yellow; }
#    #tray {       color: #ffffff; background-color: @surface0; }
#    #clock { }
#
#
#    #battery {
#    }
#    #battery.warning {
#    }
#    #battery.critical {
#    }
#    #battery.warning.discharging {
#      background-color: @maroon;
#      animation-name: blink-warning;
#      animation-duration: 3s;
#    }
#    #battery.critical.discharging {
#      background-color: @red;
#      animation-name: blink-critical;
#      animation-duration: 2s;
#    }
#
#    #clock {
#      font-weight: bold;
#    }
#
#    #cpu {
#    }
#    #cpu.warning {
#    }
#    #cpu.critical {
#      animation-name: blink-critical;
#      animation-duration: 2s;
#    }
#
#    #custom-vpn.connected {
#    }
#    #custom-vpn.disconnected {
#      background-color: @crust;
#      color: @subtext0;
#    }
#
#    #memory {
#    }
#    #memory.warning {
#    }
#    #memory.critical {
#      animation-name: blink-critical;
#      animation-duration: 2s;
#    }
#
#    #mode {
#      background: #64727D;
#      border-top: 2px solid white;
#      /* To compensate for the top border and still have vertical centering */
#      padding-bottom: 2px;
#    }
#
#    #network {
#    }
#    #network.disconnected {
#      background-color: @red;
#    }
#
#    #pulseaudio {
#      background-color: @teal;
#    }
#    #pulseaudio.muted {
#    }
#
#    #custom-spotify {
#      color: rgb(102, 220, 105);
#    }
#
#    #temperature {
#    }
#    #temperature.critical {
#      background-color: @red;
#    }
#
#    #tray {
#      border-left: 1px solid @mantle;
#      border-right: 1px solid @mantle;
#    }
#
#    #window {
#      font-weight: bold;
#      padding-left: 10px;
#    }
#  '';
}
