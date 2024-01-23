#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

FOLDERS=(bash
         awesome
         picom
         wezterm
         nvim
         bin
         git
         X11)

usage() {
  printf "USAGE: syntax: ./stow.sh <options>
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
    local uninstall="stow -Dvt"
    local install="stow -Svt"
    local reinstall="stow -RSvt"

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

            -R|--root)
                $uninstall / root
                $install / root
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

check "stow"
main "$@"
