#!/bin/bash
#
# Bluetooth script module for lemonbar.

function mod_bluetooth {
  . ${HLWM}/bar/utils/utils.sh

  icon=" "
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$icon_color")"

  bluetooth=""
  while true; do
    state=$(bluetooth show | cut -d '=' -f2 | cut -d ' ' -f2)
    if [[ -n "$state" ]]; then
      bluetooth="$icon off"
    else 
      bluetooth="$icon on "
    fi

    bluetooth="$(format_button "$bluetooth" "1" "blueman-manager")"
    echo "B${bluetooth}"
    sleep 1s
  done
}


