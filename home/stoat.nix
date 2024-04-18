{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/base.nix
    ./parts/cli
    ./parts/sway
    ./parts/desktop/browsers.nix
    #./parts/desktop/randr.nix
    ./parts/desktop/vscode.nix
    ./parts/desktop/office.nix
    ./parts/work
  ];

  home.packages = with pkgs; [
    vagrant
  ];

  manual.html.enable = true;

  services.kanshi = {
    enable = true;
    # Use: swaymsg -t get_outputs
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
      dell_4k_top = {
        outputs = [
          {
            criteria = "Dell Inc. DELL P3222QE 3WJGT83";
            mode = "3840x2160";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "960,2160";
          }
        ];
      };
      dell_wide_p3421w_cwfzh53_top = {
        outputs = [
          {
            criteria = "Dell Inc. DELL P3421W CWFZH53";
            mode = "3440x1440";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "960,1440";
          }
        ];
      };
      dell_wide_p3421w_dpxzh53_top = {
        outputs = [
          {
            criteria = "Dell Inc. DELL P3421W DPXZH53";
            mode = "3440x1440";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "960,1440";
          }
        ];
      };
  #    aoc24_top = {
  #      outputs = [
  #        {
  #          criteria = "AOC 24G2W1G4 0x000054B4";
  #          mode = "1920x1080";
  #          position = "0,0";
  #        }
  #        {
  #          criteria = "eDP-1";
  #          mode = "1920x1200";
  #          position = "0,1080";
  #        }
  #      ];
  #    };
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
