{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./git.nix
    ./packages.nix
    ./pass.nix
    ./shell.nix
    #./shellcolor.nix
    #./ssh.nix
    ./tmux.nix
  ];
}
