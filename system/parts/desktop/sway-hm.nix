{ lib, inputs, outputs, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = [ pkgs.sway ];
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
    options = "caps:backspace,nbsp:none,terminate:ctrl_alt_bksp";
  };
}
