{ pkgs, ... }: {
  imports = [
    # @TODO
    ./packages.nix
    #./git.nix
    ./bash.nix
    #./shellcolor.nix
    #./ssh.nix
    ./starship.nix
    #./tmux.nix
  ];
}
