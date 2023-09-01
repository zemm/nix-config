# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, config, ... }:

{
  imports =
    [
      #inputs.hardware.nixosModules.
      ./hardware-configuration.nix
    ];

  boot.tmp.cleanOnBoot = true;

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

  console.keyMap = "colemak";

  networking.hostName = "stoat";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "fi_FI.UTF-8/UTF-8"
  ];

  location.latitude = 62.14;
  location.longitude = 25.44;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;

  #security.pam.services.swaylock.text = ''
  #  auth include login
  #'';
  security.polkit.enable = true;
  security.rtkit.enable = true;
  #security.pam.services = { swaylock = { }; };

  services.blueman.enable = true;

  #services.geoclue2.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.sessionPackages = [ pkgs.sway ];
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.juperaja = {
    isNormalUser = true;
    description = "juperaja";
    # When moving user, see https://github.com/Misterio77/nix-config/blob/main/hosts/common/users/misterio/default.nix#L2
    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    #  spotify
    #  microsoft-edge
    #  teams
    ];
  };
#  home-manager.users.juperaja = import ../../home/${config.networking.hostName}.nix;

  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    elinks
    fend
    git
    helix
    iio-sensor-proxy
    lynx
    tmux
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

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
