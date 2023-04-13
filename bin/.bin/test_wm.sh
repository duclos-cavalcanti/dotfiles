#!/bin/bash

test() {
    check Xephyr
    check awesome

    local SIZE="1024x640"
    local RC_FILE="$XDG_CONFIG_HOME"/awesome/rc.lua
    local XEPHYR_OPTIONS="-br -ac -noreset -screen ${SIZE}"

    [ -n "$(pgrep -f WM_TEST)" ] && kill $(pgrep -f WM_TEST)

    Xephyr :1 -name WM_TEST ${XEPHYR_OPTIONS} >/dev/null 2>&1 &
    sleep 1s

    DISPLAY=:1 awesome -c "$RC_FILE" &
    sleep 1s

    echo "
    Awesome PID: $(pgrep -n 'awesome'),
    Xephyr PID: $(pgrep -f 'WM_TEST')
    "
}

test "$@"
