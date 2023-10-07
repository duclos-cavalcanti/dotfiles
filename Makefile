.PHONY: update

all: build

update:
	nix flake update

build:
	printf "Build\n"
