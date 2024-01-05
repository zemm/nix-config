{ pkgs, ... }: {
  imports = [
    # @TODO
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./pass.nix
    #./shellcolor.nix
    #./ssh.nix
    #./tmux.nix
  ];
}
