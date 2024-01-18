{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/base.nix
    ./parts/cli
    ./parts/sway
    ./parts/desktop/browsers.nix
    #./parts/desktop/randr.nix
    ./parts/desktop/vscode.nix
    ./parts/work
  ];

  home.packages = with pkgs; [
  ];

  manual.html.enable = true;

  services.kanshi = {
    enable = true;
    profiles = {
      int = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "0,0";
          }
        ];
      };
      aoc24_top = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "0,1080";
          }
          {
            criteria = "AOC 24G2W1G4 0x000054B4";
            mode = "1920x1080";
            position = "0,0";
          }
        ];
      };
    };
  };

  # @TODO: programs.borgmatic
  # @TODO: services.borgmatic

  # @TODO: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.ssh.matchBlocks
  #programs.ssh.matchBlocks = {
  #};

  # @TODO: wallpaper stuff from
  # https://github.com/Misterio77/nix-config/blob/main/home/misterio/global/default.nix
}
