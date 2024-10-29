{ pkgs, lib, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = lib.mkDefault false;
    dockerCompat = lib.mkDefault true;
  };
}
