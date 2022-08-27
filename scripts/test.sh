#!/bin/bash
#
# simple restow script

script_=$(basename $0)
config=$1

usage() {
  echo "USAGE:
    syntax: ./${script_} <target>

    ${script_} has:
    1) the following targets:
      * config: path to an awesome config
      "
}

print_error() {
    echo "ERROR: $*" >&2
    exit 1
}

if ! command -v awesome &>/dev/null ||
   ! command -v Xephyr &>/dev/null; then
    print_error "xephyr and awesome-wm have to be installed! "
    exit 1
fi

D=1
SIZE="1024x640"
RC_FILE="$XDG_CONFIG_HOME"/awesome/rc.lua
XEPHYR_OPTIONS="-ac -br -noreset -screen ${SIZE}"

parse() {
    while [[ -n "$1" ]]; do
        case "$1" in
            opt)    var="$1";;
            -C)     shift; var="$1";;
            *)      exit 1;;
        esac
        shift
    done
}

main() {
   # check for free DISPLAYS
    for ((i=0;;i++)); do
        if [[ ! -f "/tmp/.X${i}-lock" ]]; then
            D=$i
            break
        fi
    done

    Xephyr :$D -name xephyr_${D} ${XEPHYR_OPTIONS} >/dev/null 2>&1 &
    sleep 1s
    DISPLAY=:${D}.0 awesome -c "$RC_FILE" &
    sleep 1s

    echo "
    Display: $D,
    Awesome PID: $(pgrep -n "awesome"),
    Xephyr PID: $(pgrep -f xephyr_${D})
    "
}

main "$@"
