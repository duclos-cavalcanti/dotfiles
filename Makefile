.PHONY: update docker build

PWD := $(shell pwd)
DOCKER := nix-docker
EXPERIMENTAL := --experimental-features 'nix-command flakes'

all:

update:
	nix ${EXPERIMENTAL} flake update ./

os:
	nixos-rebuild switch --flake ./

build:
	nix ${EXPERIMENTAL} build --verbose .\#hostname

check:
	nix ${EXPERIMENTAL} flake check

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
