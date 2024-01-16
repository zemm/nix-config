{ pkgs, inputs, config, ... }:

{
  imports =
    [
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-ssd
      #inputs.hardware.nixosModules.dell-latitude-7440
      ./hardware-configuration.nix

      # Users to create for this host
      ../../users/johndoe.nix

      # Include common system configurations for this host
      ../../parts/common
      ../../parts/desktop-base.nix
    ];

  # Add system settings specifically for this host

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
