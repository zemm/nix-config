{ inputs, outputs, lib, config, pkgs, ... }: {
  # Include common home manager configs for this host
  imports = [
    ./parts/base.nix
  ];

  # Configurations for this host

  home.packages = with pkgs; [
    # Packages for this host only
  ];

  manual.html.enable = true;
}
