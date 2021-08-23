#!/bin/bash
#
# Date script module for dzen2.

function hl_clock() {
  . ${HLWM}/bar/utils/hl_utils.sh

  icon=' '
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$primary")"

  while true; do
    clock=$(date +%H:%M:%S)

    echo "C${icon} ${clock}"
    sleep 1s
  done
}
