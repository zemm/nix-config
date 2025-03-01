{ pkgs, inputs, config, ... }:

{
  imports =
    [
      inputs.hardware.nixosModules.lenovo-thinkpad-t460s
      ./hardware-configuration.nix

      ../../parts/common
      ../../parts/desktop-base.nix
      ../../parts/virtualisation-podman.nix
      ../../parts/virtualisation-libvirt.nix
      ../../parts/desktop/i3-hm.nix
      ../../users/zemm.nix
    ];

  environment.systemPackages = with pkgs; [
    #dropbox
    #dropbox-cli
    fend
    gparted
    linuxPackages.tp_smapi
    lm_sensors
    maestral
    maestral-gui
    nix-index
    #qemu_kvm
    vagrant
    virt-manager
    #vivaldi
    wget
    wl-clipboard
    xclip

    ## Modem
    modemmanager
    libqmi
    libmbim

    ## Gnome
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.battery-time
    gnomeExtensions.bluetooth-battery
    gnomeExtensions.dash-to-panel
    #gnomeExtensions.emoji-selector
    #gnomeExtensions.kitchen-timer
    gnomeExtensions.network-stats
    gnomeExtensions.spotify-tray
    #gnomeExtensions.tp_wattmeter
    #gnomeExtensions.volume-mixer

    ## PipeWire
    pavucontrol
  ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.grub.configurationLimit = 25;

  boot.initrd.luks.devices.lukspv = {
    device = "/dev/disk/by-uuid/974c1a12-7c83-425d-8a92-700a862caa6e";
    preLVM = true;
    #allowDiscards = true; # TRIM seems to be iffy on Samsumg SSD
  };

  fileSystems."/".options = [ "noatime" "nodiratime" ];

  ## -H-
  hardware.pulseaudio.enable = false;

  i18n.defaultLocale = "fi_FI.UTF-8";

  ## -N-
  networking.hostName = "rlyeh";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.interfaces.wwp0s20f0u2i12.useDHCP = true;

  ## -P-
  programs.bash.completion.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  ## -S-
  security.chromiumSuidSandbox.enable = true;
  #security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  security.pam.services.juperaja.enableGnomeKeyring = true;

  security.rtkit.enable = true; # Recommended https://nixos.wiki/wiki/PipeWire

  services.dbus.packages = [ pkgs.dconf ];
  services.fprintd.enable = true;

  services.pipewire = {
    alsa.support32Bit = true;
    jack.enable = true;
  };

  #services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.redshift.enable = true;

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak";
  services.xserver.xkb.options = "eurosign:e,caps:backspace,nbsp:none";

  #sound.mediaKeys.enable = true; # Not needed for Gnome

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
