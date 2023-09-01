# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./generic.nix
  ];

  home = {
    username = "juperaja";
    homeDirectory = "/home/juperaja";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.vscode
  ];

  # @TODO: wallpaper stuff from
  # https://github.com/Misterio77/nix-config/blob/main/home/misterio/global/default.nix

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
