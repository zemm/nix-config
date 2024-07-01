{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/base.nix
    ./parts/cli
  ];

  home.packages = with pkgs; [
  ];

  home.username = "zemm";
  home.homeDirectory = "/home/zemm";

  # @TODO: programs.borgmatic
  # @TODO: services.borgmatic

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
