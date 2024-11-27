{ lib, inputs, outputs, pkgs, ... }:
{
  # https://nixos.wiki/wiki/I3

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    #mouse.naturalScrolling = true;
  };

  services.displayManager.defaultSession = "none+i3";

  services.xserver = {
    enable = true;

    dpi = 96; # @TODO: Is there a better way to fix wrong scaling? This is not recommended.

    autoRepeatDelay = 230;
    autoRepeatInterval = 32;
    xkb = {
      layout = "us";
      variant = "colemak";
      options = "eurosign:e,caps:backspace,nbsp:none,terminate:ctrl_alt_bksp";
    };

    windowManager.i3.enable = true;
  };

}
