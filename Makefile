.PHONY: update

all: build

update:
	nix flake update --write-lock-file

build:
	printf "Build\n"
