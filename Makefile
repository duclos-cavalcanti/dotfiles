.PHONY: build home

PWD := $(shell pwd)
DOCKER := nix-docker
EXPERIMENTAL := --experimental-features 'nix-command flakes'

all: check

switch:
	sudo nixos-rebuild switch --flake ./

update:
	nix ${EXPERIMENTAL} flake update --recreate-lock-file

build:
	nix ${EXPERIMENTAL} build .#default

home:
	nix ${EXPERIMENTAL} build .#homeManagerConfigurations.duclos.activationPackage

run:
	nix ${EXPERIMENTAL} run

check:
	nix ${EXPERIMENTAL} flake check --show-trace

show:
	nix ${EXPERIMENTAL} flake show

clean:
	nix-collect-garbage -d
	rm -rf ~/.cache/nix

docker:
	docker run -it --name ${DOCKER} -v ${PWD}:/home/nixos nixos/nix

stop:
	docker stop ${DOCKER}

remove: stop
	docker rm ${DOCKER}
