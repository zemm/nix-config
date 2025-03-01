{ inputs, outputs, lib, config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    # https://alacritty.org/config-alacritty.html
    settings = {
      #font.size = 8;
      window.opacity = 0.95;
      window.blur = true;
      selection.save_to_clipboard = false;
      # @TODO Figure out what would be the Right Way to do this,
      # as currently I have no login shell with Sway and Alacritty
      # https://github.com/alacritty/alacritty/issues/4786
      terminal.shell.program = "${pkgs.bashInteractive}/bin/bash";
      terminal.shell.args = [ "-l" ];
      env.WINIT_X11_SCALE_FACTOR = "1";
    };
  };
}
