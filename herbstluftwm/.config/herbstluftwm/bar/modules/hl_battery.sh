#!/bin/bash
#
# Battery script module for lemonbar.

function hl_battery {
  . ${HLWM}/bar/utils/hl_utils.sh

  icon=" "
  icon=$(format_font "$icon" "$font_icons")
  icon=$(format_colors "$icon" "$primary")

  while true; do
    b_perc=$(acpi -b 2>/dev/null | grep "Battery $b_num" | awk '{ print $4 }' | cut -d ',' -f1 )
    battery="$icon ${b_perc}"
    echo "E${battery}"
    sleep 60s
  done
}
