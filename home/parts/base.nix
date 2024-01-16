{ inputs, lib, pkgs, config, outputs, ... }:
#let
#  inherit (inputs.nix-colors) colorSchemes;
#  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; })
#    colorschemeFromPicture nixWallpaperFromScheme;
#in
{
#  imports = [
#    # If you want to use modules your own flake exports (from modules/home-manager):
#    # outputs.homeManagerModules.example
#
#    # Or modules exported from other flakes (such as nix-colors):
#    #inputs.nix-colors.homeManagerModules.default
#    inputs.nix-colors.homeManagerModule
#  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  #programs.git.enable = true;
  programs.home-manager.enable = true;

  home.keyboard = {
    options = "caps:backspace";
  };

  # Nicely reload system units when changing configs
  #systemd.user.startServices = "sd-switch";
}
