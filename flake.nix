{
  description = "My nix configs";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;

      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      #formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs outputs; };

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        myhost = nixpkgs.lib.nixosSystem {
          modules = [ ./system/hosts/myhost/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "johndoe@myhost" = home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              home.username = "johdoe";
              home.homeDirectory = "/home/johdoe";
              # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
              home.stateVersion = "23.11";
            }
            ./home/johndoe_myhost.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
