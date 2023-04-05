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

    local D=1
    local SIZE="1024x640"
    local RC_FILE="$XDG_CONFIG_HOME"/awesome/rc.lua
    local XEPHYR_OPTIONS="-ac -br -noreset -screen ${SIZE}"

   # check for free DISPLAYS
    for ((i=0;;i++)); do
        if [[ ! -f "/tmp/.X${i}-lock" ]]; then
            D=$i
            break
        fi
    done

    Xephyr :$D -name xephyr_${D} ${XEPHYR_OPTIONS} >/dev/null 2>&1 &
    sleep 1s
    export XTEST=1
    sleep 1s
    DISPLAY=:${D}.0 awesome -c "$RC_FILE" &
    sleep 1s

    echo "
    XTEST: $XTEST,
    Display: $D,
    Awesome PID: $(pgrep -n 'awesome'),
    Xephyr PID: $(pgrep -f xephyr_${D})
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
