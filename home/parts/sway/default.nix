{ pkgs, lib, ... }:
{
  imports = [
    ./sway.nix
    ./waybar.nix
    ./themes/sway-catppuccin-latte.nix
    ./themes/alacritty-gruvbox-material-dark.nix
  ];
}
