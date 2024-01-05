{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/base.nix
    ./parts/cli
    ./parts/desktop/sway.nix
    ./parts/desktop/waybar.nix
  ];

  home.packages = with pkgs; [
    vscode # @TODO: move to desktop packages
    cowsay
    arandr
  ];

  manual.html.enable = true;

  # @TODO: programs.borgmatic
  # @TODO: services.borgmatic

  # @TODO: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.ssh.matchBlocks
  #programs.ssh.matchBlocks = {
  #};

  # @TODO: wallpaper stuff from
  # https://github.com/Misterio77/nix-config/blob/main/home/misterio/global/default.nix
}
