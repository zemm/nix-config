{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.microsoft-edge
  ];

  programs.chromium = {
    enable = lib.mkDefault true;
    commandLineArgs = [
      "--force-device-scale-factor=1"
      "--ignore-gpu-blocklist"
    ];
  };

  programs.firefox = {
    enable = lib.mkDefault true;
  };
}
