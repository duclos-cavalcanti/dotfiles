.PHONY: update container build foo

PWD := $(shell pwd)
DOCKER := nix-docker

all: build

update:
	nix --experimental-features 'nix-command flakes' flake update

build:
	nixos-rebuild switch --flake ./

container:
	docker run -it --name ${DOCKER} -v ${PWD}:/home/nixos nixos/nix

stop:
	docker stop ${DOCKER}

remove: stop
	docker rm ${DOCKER}
