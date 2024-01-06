{ pkgs, lib, ... }:
{
  # @see
  # https://drakerossman.com/blog/wayland-on-nixos-confusion-conquest-triumph

  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
  ];
  #environment.enableAllTerminfo = true;

  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fontconfig.defaultFonts = {
    serif = [ "DejaVu Serif" ];
    sansSerif = [ "DejaVu Sans" ];
    monospace = [ "DejaVu Sans Mono" ];
  };
  fonts.packages = with pkgs; [
    bakoma_ttf
    cantarell-fonts
    corefonts
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome
    font-awesome_5
    gentium
    inconsolata
    liberation_ttf
    (nerdfonts.override { fonts = [ "Cousine" "FiraCode" "DroidSansMono" "Ubuntu" "UbuntuMono" "Terminus" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    powerline-symbols
    source-code-pro
    source-han-sans
    terminus_font
    ubuntu_font_family
  ];

  hardware.opengl.enable = true;
  #hardware.enableAllFirmware = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General = {
    Enable = "Source,Sink,Media,Socket";
  };

  networking.networkmanager.enable = true;

  services.ntp.enable = true;
  services.ntp.servers = [ "0.fi.pool.ntp.org" "1.fi.pool.ntp.org" "2.fi.pool.ntp.org" "3.fi.pool.ntp.org" ];

  #programs.fuse.userAllowOther = true;
  programs.light.enable = true; # https://nixos.wiki/wiki/Sway

  # Needed for Sway with home manager
  security.polkit.enable = true;
  security.rtkit.enable = true;
  #security.pam.services = { swaylock = { }; };
  #security.pam.services.swaylock.text = ''
  #  auth include login
  #'';

  services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
