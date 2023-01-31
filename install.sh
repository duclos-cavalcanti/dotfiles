#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

DOTFILES=$(dirname "$0")
FOLDERS=(bash
         tmux
         alacritty
         awesome
         nvim
         neomutt
         picom
         bin
         X11)

usage() {
  printf "USAGE: syntax: ./install.sh <options>
  OPTIONS:
    -i | --install:
    -u | --uninstall:
    -s | --system:
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
    local target=
    local uninstall="stow -Dvt $HOME"
    local install="stow -Svt $HOME"

    if [ $# -lt 1 ]; then
      usage
      exit 1
    fi

    while [[ $# -gt 0 ]]; do
       case $1 in
            -s|--system)
                pushd $DOTFILES
                for f in ${FOLDERS[@]}; do
                  if [ -d $f ]; then
                    $install $f
                  fi
                done
                popd
                exit 0
                ;;

            -i|--install)
                shift
                target="${1}"
                if [ -d $target ]; then
                    $install $target
                fi
                shift
                ;;

            -r|--reinstall)
                shift
                target="${1}"
                if [ -d $target ]; then
                    $uninstall $target
                    sleep 1s
                    $install $target
                fi
                shift
                ;;

            -u|--uninstall)
                shift
                target="${1}"
                if [ -d $target ]; then
                    $uninstall $target
                fi
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

check stow
main "$@"
