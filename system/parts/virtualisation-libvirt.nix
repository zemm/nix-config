{ pkgs, lib, ... }:
{
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  networking.firewall.enable = true;
  networking.firewall.trustedInterfaces = [
    "docker0"
    "virtbr0"
    "virtbr1"
    "virtbr2"
    "virtbr3"
    "virbr1"
    "virbr2"
    "virbr3"
    "virbr4"
  ];
}
