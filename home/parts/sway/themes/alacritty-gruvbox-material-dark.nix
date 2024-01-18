{ pkgs, ... }:
{
  # Source: https://github.com/alacritty/alacritty-theme

  # https://alacritty.org/config-alacritty.html
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.settings
  programs.alacritty.settings.colors = {
    # Colors (Gruvbox Material Medium Dark)

    # Default colors
    primary = {
      background = "#282828";
      foreground = "#d4be98";
    };

    # Normal colors
    normal = {
      black   = "#3c3836";
      red     = "#ea6962";
      green   = "#a9b665";
      yellow  = "#d8a657";
      blue    = "#7daea3";
      magenta = "#d3869b";
      cyan    = "#89b482";
      white   = "#d4be98";
    };

    # Bright colors (same as normal colors)
    bright = {
      black   = "#3c3836";
      red     = "#ea6962";
      green   = "#a9b665";
      yellow  = "#d8a657";
      blue    = "#7daea3";
      magenta = "#d3869b";
      cyan    = "#89b482";
      white   = "#d4be98";
    };
  };
}
