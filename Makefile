.PHONY: update

all: build

update:
	nix flake update --write-lock-file

build:
	echo nixos-rebuild switch --flake <flake-uri>
