{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.microsoft-edge
  ];

  programs.chromium.enable = lib.mkDefault true;

  programs.firefox.enable = lib.mkDefault true;
}
