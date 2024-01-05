{ pkgs, lib, ... }:
{
  programs.git-cliff.enable = true;


  programs.gitui.enable = true;


  programs.git = {
    enable = true;

    userName = lib.mkDefault "Jussi Rajala";
    userEmail = lib.mkDefault "zemm@iki.fi";

    #delta.enable = true;

    #difftastic.enable = true;
    #difftastic.background = "dark"; # "light";
    #difftastic.display = "inline"; # "side-by-side"; "side-by-side-show-both";

    aliases = {
      st = "status -s";
      ci = "commit";
      co = "checkout";
      cb = "checkout -b";
      d = "diff";
      di = "diff";
      dc = "diff --cached";
      ff = "merge --ff-only";
      pullff = "pull --ff-only";
      noff = "merge --no-ff";
      b = "branch";
      ds = "diff --stat";
      l = "log --graph --pretty=\"tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(blue)<%an>%Creset %C(red)%d%Creset %s\"";
      ll = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      lll = "log --graph --pretty=\"tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(blue)<%an>%Creset %C(red)%d%Creset %s\"";
      dh1 = "diff HEAD~1";
      dh2 = "diff HEAD~2";
      dh3 = "diff HEAD~3";
      dh4 = "diff HEAD~4";
      dh5 = "diff HEAD~5";
      versioned = "ls-tree -r --name-only HEAD";
      l2 = "log --graph --pretty=\"tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(blue)<%an>%Creset %C(red)%d%Creset %s\"";
      l3 = "log --graph --pretty=\"tformat:%C(yellow)%h%Creset\\\\ %Cgreen(%ar)%Creset\\\\ %C(blue)<%an>%Creset\\\\ %C(red)%d%Creset\\\\ %s\"";
    };

    extraConfig = {
      pull = {
        rebase = false;
      };
      push = {
        default = "current";
        followTags = true;
      };
      github = {
        username = "zemm";
      };
      credential = {
        helper = "cache --timeout=7200";
      };
      "credential \"https://github.com\"" = {
        username = "zemm";
      };
      #merge = {
      #  tool = "meld";
      #};
      #diff = {
      #  tool = "meld";
      #};
      #mergetool = {
      #  keepBackup = false;
      #};
    };
  };
}
