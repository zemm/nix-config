
.PHONY: shell
shell:
	nix develop

.PHONY: home
home:
	home-manager switch --flake .

.PHONY: nixos
nixos:
	sudo nixos-rebuild switch --flake .

# Alias
.PHONY: system
system: nixos
