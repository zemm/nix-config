{ pkgs, lib, ... }:
{
  programs.password-store = {
    enable = true;
  };

  # @TODO: programs.browserpass
  # https://github.com/browserpass/browserpass-extension
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.browserpass.enable

}
