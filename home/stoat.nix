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
  ];

  # @TODO: wallpaper stuff from
  # https://github.com/Misterio77/nix-config/blob/main/home/misterio/global/default.nix
}
