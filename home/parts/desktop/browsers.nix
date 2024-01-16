{ pkgs, lib, ... }:
{
  programs.chromium.enable = lib.mkDefault true;
}
