{ pkgs, lib, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = lib.mkDefault true;
    dockerCompat = lib.mkDefault true;
  };
}
