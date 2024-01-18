{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Basics
    dnsutils # `dig`, `nslookup`
    ipcalc
    sipcalc
    elinks
    lynx

    # Fancies
    neofetch # the fancy cli system info banner thingy

    # System & monitoring
    ltrace # library call monitoring
    ncdu # TUI disk usage
    strace # system call monitoring
    pciutils # lspci
    usbutils # lsusb

    # Nix
    nil # Nix LSP
    nixfmt # Nix formatter
    nvd # Differ
    nix-output-monitor # `nom`
  ];

  programs.translate-shell = {
    enable = true;
    # https://github.com/soimort/translate-shell/wiki/Configuration
    #settings = {
    #};
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
    #pinentryFlavor = "curses";
    pinentryFlavor = "gnome3";
    defaultCacheTtl = 60;
    defaultCacheTtlSsh = 60*60*12;
  };

  services.ssh-agent.enable = true;

  #programs.ssh.addKeysToAgent = "confirm";

  # Terminal file manager
  # https://github.com/sxyazi/yazi
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yazi.enable
  programs.yazi = {
    enable = true;
  };
}
