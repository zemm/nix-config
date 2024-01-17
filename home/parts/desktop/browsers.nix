{ pkgs, lib, ... }:
{
  programs.chromium.enable = lib.mkDefault true;

  programs.firefox.enable = lib.mkDefault true;
}
