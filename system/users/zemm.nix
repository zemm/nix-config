{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Requires managed passwords
  #users.mutableUsers = false;

  users.users.zemm = {
    uid = 1000;
    isNormalUser = true;
    description = "zemm";
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "podman"
      "qemu-libvirtd"
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

  #home-manager.users.zemm = import ../../home/${config.networking.hostName}.nix;
}
