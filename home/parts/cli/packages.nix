{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basics
    apg
    bc
    curl
    file
    gnumake
    jq
    tree
    unzip
    wget
    which
    yq-go
    zip

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
