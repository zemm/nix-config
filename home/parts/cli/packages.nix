{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basics
    bc
    curl
    file
    jq
    tree
    which
    yq-go

    # System & monitoring
    bottom # system viewer
    btop # top / htop replacement
    htop # old habits
    iotop
    iftop
    lsof
  ];

  programs.gpg = {
    enable = true;
  };
}
