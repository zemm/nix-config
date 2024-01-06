{ pkgs, inputs, config, ... }:

{
  imports =
    [
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-ssd
      #inputs.hardware.nixosModules.dell-latitude-7440
      ./hardware-configuration.nix

      ../../parts/common
      ../../parts/desktop-base.nix
      ../../users/juperaja.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-09d052fa-324d-453e-8c39-acd57048b8e0".device = "/dev/disk/by-uuid/09d052fa-324d-453e-8c39-acd57048b8e0";
  boot.initrd.luks.devices."luks-09d052fa-324d-453e-8c39-acd57048b8e0".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "stoat";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  #services.geoclue2.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.sessionPackages = [ pkgs.sway ];
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Required for brightness and volume keys?
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
