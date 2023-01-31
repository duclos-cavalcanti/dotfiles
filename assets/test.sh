#!/bin/bash
#
# testing window manager script

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
    export XTEST=1
    sleep 1s
    DISPLAY=:${D}.0 awesome -c "$RC_FILE" &
    sleep 1s

    echo "
    XTEST: $XTEST,
    Display: $D,
    Awesome PID: $(pgrep -n "awesome"),
    Xephyr PID: $(pgrep -f xephyr_${D})
    "
}

main "$@"
