{ pkgs, ... }:
{
  # Source: https://github.com/alacritty/alacritty-theme

  # https://alacritty.org/config-alacritty.html
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.settings
  programs.alacritty.settings.colors = {
    # Colors (Gruvbox light)

    # Default colors
    primary = {
      # hard contrast background = "#f9f5d7"
      background = "#fbf1c7";
      # soft contrast background = "#f2e5bc"
      foreground = "#3c3836";
    };

    # Normal colors
    normal = {
      black   = "#fbf1c7";
      red     = "#cc241d";
      green   = "#98971a";
      yellow  = "#d79921";
      blue    = "#458588";
      magenta = "#b16286";
      cyan    = "#689d6a";
      white   = "#7c6f64";
    };

    # Bright colors
    bright = {
      black   = "#928374";
      red     = "#9d0006";
      green   = "#79740e";
      yellow  = "#b57614";
      blue    = "#076678";
      magenta = "#8f3f71";
      cyan    = "#427b58";
      white   = "#3c3836";
    };
  };
}
