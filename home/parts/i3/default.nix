{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./i3.nix
#    ./polybar.nix
    ./i3status-rust.nix
    ./theme-catppuccin-latte.nix
    ./autorandr.nix
    ../alacritty/alacritty.nix
    ../alacritty/theme-gruvbox-material-dark.nix
  ];
}
