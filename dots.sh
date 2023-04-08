#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

DOTFILES=$(dirname "$0")
FOLDERS=(bash
         awesome
         picom
         wezterm
         nvim
         bin
         git
         X11)

usage() {
  printf "USAGE: syntax: ./dots.sh <options>
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

test() {
    check Xephyr
    check awesome

    local SIZE="1024x640"
    local RC_FILE="$XDG_CONFIG_HOME"/awesome/rc.lua
    local XEPHYR_OPTIONS="-br -ac -noreset -screen ${SIZE}"

    Xephyr :1 -name WM_TEST ${XEPHYR_OPTIONS} >/dev/null 2>&1 &
    sleep 1s

    DISPLAY=:1 awesome -c "$RC_FILE" &
    sleep 1s

    echo "
    Awesome PID: $(pgrep -n 'awesome'),
    Xephyr PID: $(pgrep -f 'WM_TEST')
    "
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
                    $install --adopt $f
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
                    $install --restow $target
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

            -t|--test)
                test
                exit 0
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
