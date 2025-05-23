{
  description = "My nix configs";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #nix-colors.url = "github:misterio77/nix-colors";

    #flake-utils.url = "github:numtide/flake-utils";

    catppuccin-waybar.url = "github:catppuccin/waybar/main";
    catppuccin-waybar.flake = false;
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
      pkgsUnstableFor = lib.genAttrs systems (system: import nixpkgs-unstable {
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
        h = nixpkgs.lib.nixosSystem {
          modules = [ ./system/hosts/h/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };

        rlyeh = nixpkgs.lib.nixosSystem {
          modules = [ ./system/hosts/rlyeh/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };

        stoat = nixpkgs.lib.nixosSystem {
          modules = [ ./system/hosts/stoat/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "zemm@h" = home-manager.lib.homeManagerConfiguration {
          modules = [
            ./home/zemm_h.nix
          ];
          pkgs = pkgsFor.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgsUnstable = pkgsUnstableFor.aarch64-linux;
          };
        };

        "juperaja@stoat" = home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              home.username = "juperaja";
              home.homeDirectory = "/home/juperaja";
              # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
              home.stateVersion = "23.05";
            }
            ./home/stoat.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgsUnstable = pkgsUnstableFor.x86_64-linux;
          };
        };

        "zemm@rlyeh" = home-manager.lib.homeManagerConfiguration {
          modules = [
            {
              home.username = "zemm";
              home.homeDirectory = "/home/zemm";
              # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
              home.stateVersion = "23.05";
            }
            ./home/rlyeh.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgsUnstable = pkgsUnstableFor.x86_64-linux;
          };
        };
      };
    };
}
