{ pkgs, ... }:
{
  # Source: https://github.com/alacritty/alacritty-theme

  # https://alacritty.org/config-alacritty.html
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.alacritty.settings
  programs.alacritty.settings.colors = {
    # Colors (Gruvbox Material Medium Light)

    # Default colors
    primary = {
      background = "#fbf1c7";
      foreground = "#654735";
    };

    # Normal colors
    normal = {
      black   = "#654735";
      red     = "#c14a4a";
      green   = "#6c782e";
      yellow  = "#b47109";
      blue    = "#45707a";
      magenta = "#945e80";
      cyan    = "#4c7a5d";
      white   = "#eee0b7";
    };

    # Bright colors (same as normal colors)
    bright = {
      black   = "#654735";
      red     = "#c14a4a";
      green   = "#6c782e";
      yellow  = "#b47109";
      blue    = "#45707a";
      magenta = "#945e80";
      cyan    = "#4c7a5d";
      white   = "#eee0b7";
    };
  };
}
