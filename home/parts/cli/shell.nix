{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # Utils
    bat # cat clone
    eza # ls
    fd # find
    fzf # fuzzy finder
    httpie # curl
    ripgrep
    skim # another fuzzy finder
    timer
  ];

  #programs.atuin = {
  #  enable = true;
  #  flags = [
  #    #"--disable-up-arrow"
  #    #"--disable-ctrl-r"
  #  ];
  #  # https://atuin.sh/docs/config
  #  settings = {
  #    update_check = false;
  #    sync_address = "http://localhost";
  #    enter_accept = false;
  #  };
  #};

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.skim.enable
  programs.skim = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        #error_symbol = "[➜](bold red)";
        error_symbol = "[✗](bold red)";
      };
      env_var = {
        variable = "KOPLA_REGION";
        symbol = "";
        format = "[$symbol $env_value]($style) ";
        style = "red";
      };
    };
  };

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historyIgnore = [ "ls" "cd" "exit" ];

    #bashrcExtra = ''
    #'';
    #initExtra = ''
    #'';
    #profileExtra = ''
    #'';
  };

  programs.tealdeer = {
    enable = true;
    # https://dbrgn.github.io/tealdeer/config.html
    #settings = {};
  };
}
