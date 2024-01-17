{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Requires managed passwords
  #users.mutableUsers = false;

  users.users.juperaja = {
    isNormalUser = true;
    description = "juperaja";
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "networkmanager"
      "docker"
      "podman"
      # @TODO: other groups
    ];
    packages = with pkgs; [
      home-manager
    ];
  };

  #openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/johndoe/ssh.pub) ];
  #hashedPasswordFile = config.sops.secrets.johndoe-password.path;
  #sops.secrets.johndoe-password = {
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

  #home-manager.users.juperaja = import ../../home/${config.networking.hostName}.nix;
}
