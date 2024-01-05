{ pkgs, ... }:
{
  home.packages = [
    pkgs.arandr
  ];

  programs.autorandr = {
    enable = true;
    # @TODO https://nix-community.github.io/home-manager/options.xhtml#opt-programs.autorandr.profiles
  };

  services.autorandr = {
    enable = true;
  };
}
