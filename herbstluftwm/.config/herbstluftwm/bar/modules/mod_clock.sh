#!/bin/bash
#
# Date script module for dzen2.

function mod_clock() {
  . ${HLWM}/bar/utils/utils.sh

  icon=' '
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$icon_color")"

  while true; do
    clock=$(date +%H:%M:%S)

    echo "C${icon} ${clock}"
    sleep 1s
  done
}
