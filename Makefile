.PHONY: build home

PWD := $(shell pwd)

all: debug

debug:
	@./scripts/debug.sh

stow:
	@./scripts/stow.sh -i

restow:
	@./scripts/stow.sh -r

unstow:
	@./scripts/stow.sh -u

root:
	@./scripts/stow.sh -R
