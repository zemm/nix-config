{ pkgs, lib, ... }:
{
  imports = [
    ./sway.nix
    ./waybar.nix
    ./theme-catppuccin-latte.nix
    ../alacritty/alacritty.nix
    ../alacritty/theme-gruvbox-material-dark.nix
  ];
}
