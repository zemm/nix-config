{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basics
    bc
    curl
    dnsutils # `dig`, `nslookup`
    file
    gnupg
    jq
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

    # Utils
    eza # ls
    fd # find
    fzf # fuzzy finder
    ripgrep # grep
    httpie # curl
    diffsitter # diff
    timer

    # Nix
    #nil # Nix LSP
    #nixfmt # Nix formatter
    #nvd # Differ
    nix-output-monitor # `nom`
  ];
}
