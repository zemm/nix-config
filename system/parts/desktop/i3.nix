{ lib, inputs, outputs, pkgs, ... }:
{
  # https://nixos.wiki/wiki/I3

  services.illum.enable = true;
  services.redshift.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
      clickMethod = "clickfinger";
    };
  };

  services.xserver = {
    enable = true;

    autoRepeatDelay = 230;
    autoRepeatInterval = 32;
    xkb = {
      layout = "us";
      variant = "colemak";
      options = "eurosign:e,caps:backspace,nbsp:none,terminate:ctrl_alt_bksp";
    };

    desktopManager.gnome.enable = lib.mkDefault true;
    desktopManager.xterm.enable = false;

    displayManager.gdm.enable = true;
    displayManager.sessionCommands = ''
      export TERMINAL=${pkgs.alacritty}/bin/alacritty
      xset r rate 230 32
    '';

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  #export TERMINAL=${pkgs.gnome.gnome-terminal}/bin/gnome-terminal
  services.displayManager.defaultSession = "none+i3";
}
