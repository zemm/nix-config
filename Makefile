
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

.PHONY: update
update:
	nix flake update

.PHONY: gen-system
gen-system:
	mkdir -p ./system/hosts/$$(hostname)
	nixos-generate-config --dir ./system/hosts/$$(hostname)
