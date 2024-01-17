{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/base.nix
    ./parts/cli
    ./parts/sway
    ./parts/desktop/browsers.nix
    #./parts/desktop/randr.nix
    ./parts/desktop/vscode.nix
    ./parts/work
  ];

  home.packages = with pkgs; [
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
