# Used for all hosts by default
{ lib, inputs, outputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locale.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  boot.tmp.cleanOnBoot = true;

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "root" "@wheel" ];
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nano
  ];

  #environment.enableAllTerminfo = true;
  #programs.fuse.userAllowOther = true;
  #hardware.enableAllFirmware = true;
}
