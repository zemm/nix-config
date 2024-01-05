{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basics
    bc
    curl
    dnsutils # `dig`, `nslookup`
    file
    jq
    ipcalc
    sipcalc
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
    ltrace # library call monitoring
    ncdu # TUI disk usage
    strace # system call monitoring
    # @TODO: move to desktop/laptop config
    #pciutils # lspci
    #usbutils # lsusb

    # Nix
    #nil # Nix LSP
    #nixfmt # Nix formatter
    #nvd # Differ
    nix-output-monitor # `nom`
  ];

  programs.gpg = {
    enable = true;
  };
}
