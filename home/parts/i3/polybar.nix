{ inputs, outputs, lib, config, pkgs, ... }:
{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      alsaSupport = true;
      githubSupport = false;
      mpdSupport = false;
      #pulseSupport = config.pulseaudio or false;
      #pulseSupport = config.pulseaudio;
      pulseSupport = true;
      iwSupport = false;
      nlSupport = false;
      i3Support = true;
    };

#    config = {
#      "bar/bottom" = {
#        monitor = "\${env:MONITOR:eDP1}";
#        width = "100%";
#        height = "3%";
#        radius = 0;
#        modules-center = "date";
#      };
#
#      "module/date" = {
#        type = "internal/date";
#        internal = 5;
#        date = "%Y-%m-%d";
#        time = "%H.%M.%S";
#        label = "%time% %date%";
#      };
#
#      "module/volume" = {
#        type = "internal/pulseaudio";
#        format.volume = "<ramp-volume> <label-volume>";
#        label.muted.text = "🔇";
#        label.muted.foreground = "#666";
#        ramp.volume = ["🔈" "🔉" "🔊"];
#        click.right = "pavucontrol &";
#      };
#    };
    # extraConfig
    # script
    # settings
  };
}
