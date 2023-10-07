.PHONY: update

all: build

update:
	nix --experimental-features 'nix-command flakes' flake update

build:
	echo nixos-rebuild switch --flake <flake-uri>
