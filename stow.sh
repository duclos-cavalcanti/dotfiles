#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

usage() {
  printf "USAGE: syntax: ./install.sh <options>
  OPTIONS:
    -i | --install:
    -r | --reinstall:
    -u | --uninstall:
    -h | --help:
  "
}

check() {
    local program="$1"
    if ! command -v ${program} &>/dev/null; then
        printf "${program} is not installed!\n"
        exit 1
    fi
}

main() {
    local uninstall="stow --no-folding -Dvt"
    local install="stow --no-folding -Svt"
    local reinstall="stow --no-folding -RSvt"

    if [ $# -lt 1 ]; then
      usage
      exit 1
    fi

    while [[ $# -gt 0 ]]; do
       case $1 in
            -i|--install)
                $install $HOME home
                shift
                ;;

            -r|--reinstall)
                $reinstall $HOME home
                shift
                ;;

            -u|--uninstall)
                $uninstall $HOME home
                shift
                ;;

            -h|--help)
                usage
                exit 0
                ;;

            *)
                usage
                exit 1
                ;;
       esac
    done
}

if ! command -v stow &>/dev/null; then
    printf "stow is not installed!\n"
    exit 1
fi

main "$@"
