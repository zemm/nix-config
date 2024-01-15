{ pkgs, ... }:
{
  wayland.windowManager.sway.config.bars = let
    black = "#000000";
    blue = "#2b2e36";
    yellow = "#f0d48b";
    darky = "#433f15";
    lessdarky = "#664433";
    grey = "#b0b287";
    green = "#789073";
    red = "#ef2929";
  in [
    {
      fonts = {
        names = [ "Ubuntu Mono" "DejaVu Sans Mono" "DejaVu Sans" "FontAwesome5Free" ];
        style = "Semi-Condensed";
        size = 12.0;
      };
      # @TODO check if we have waybar or polybar
      #command = "${pkgs.waybar}/bin/waybar";
      command = "${pkgs.sway}/bin/swaybar";
      extraConfig = "";
      hiddenState = "hide";
      mode = "dock";
      position = "top";
      statusCommand = "${pkgs.i3status}/bin/i3status";
      trayOutput = "*";
      trayPadding = 5;
      workspaceButtons = true;
      workspaceNumbers = true;
      colors = {
        activeWorkspace = {
          background = "${yellow}";
          border = "${yellow}";
          text = "${black}";
        };
        background = "#00000033";
        #bindingMode = {
        #  background = "${red}";
        #  border = "${blue}";
        #  text = "${yellow}";
        #};
        focusedBackground = "#00000022";
        focusedSeparator = "${black}";
        focusedStatusline = "${yellow}";
        focusedWorkspace = {
          background = "${darky}";
          border = "${lessdarky}";
          text = "${yellow}";
        };
        inactiveWorkspace = {
          background = "#00000000";
          border = "#00000000";
          text = "${yellow}";
        };
        separator = "${green}";
        statusline = "${yellow}";
        urgentWorkspace = {
          background = "${black}";
          border = "${red}";
          text = "${red}";
        };
      };
    }
  ];
}
