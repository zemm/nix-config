{ pkgs, inputs, config ,... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect

    ../../parts/common
    ../../parts/server.nix
    ../../parts/virtualisation-podman.nix
    ../../users/zemm.nix
  ];

  # https://nixos.wiki/wiki/Install_NixOS_on_Hetzner_Cloud
  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.kernelParams = [ "console=tty" ];

  boot.loader.grub.configurationLimit = 2;
  boot.loader.grub.device = "/dev/disk/by-uuid/3462-3E17";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "h";
  networking.domain = "8b.fi";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG1MLFpdlAKavBCbUEXKbH4DgO/SEz1jB/uucelKv9tF2Ge5m6fwgCtg1DG+yMKtSB1JsUPqCXJ1aARR1wo7H32sgO9+QZzdnD02E9oR507dRT5oY4Ik3r+XYRbiFLDzGIzSBziMcN9fm9lsp7Tr1v4Kx7tVdKKFDm2/9tdT2EqnCB2/6GY5r6FhSYl2d6/2jv/PhRwJZKpsZhrMBIM60jMj1p6FzTmG0IUhSnndf05toSMloIUjWoe0zXfGYCwCNZ2oTG9wfGn6zf3Y/jVOpYUxgoP6X/nj8h71++nSSQcDAii9M4pvmJpNMdi8eSwAsjfW1XWbceHXbM1SQnygBnyEX28MtHidhI2JDmR6X/iBjPvmkoZF0BcPNVVwSQP5NDTG3HmUc8NjklzpqPm3fQaD/4OEedGed776Kurb9/c0QVeFE/le4g4FxRAvI+jGGzwKWaOQNLOiBZ4q0ubWC/S578r7iCVWGzMNLCUCMqWFGlfNX4iaSZ8TXJxKdE7LreLXlCGwOl2akZL2kWauLOWw6aympNQ9rwacixFktvVxIpHPoIcZQBNtJakPoPD/0OtJzn2KDTcyNlBuqP9PFqFiYgy+Boz8dfTGL/EN++R0A7T2bHPqGlB+3CmbVtQIUTuDpIR13gSKaX69qnq5EiT0HguErN2GMS9siNKVNp5w== zemm@kobresia'' ];
  system.stateVersion = "23.11";
}
