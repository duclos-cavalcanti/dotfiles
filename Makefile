.PHONY: update

all: build

update:
	nix --experimental-features 'nix-command flakes' flake update

build:
	nixos-rebuild switch --flake ./
