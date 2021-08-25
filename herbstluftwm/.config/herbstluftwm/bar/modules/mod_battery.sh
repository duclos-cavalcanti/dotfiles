#!/bin/bash
#
# Battery script module for lemonbar.

function mod_battery {
  . ${HLWM}/bar/utils/utils.sh

  icon=" "
  icon=$(format_font "$icon" "$font_icons")
  icon=$(format_colors "$icon" "$icon_color")

  while true; do
    b_perc=$(acpi -b 2>/dev/null | grep "Battery $b_num" | awk '{ print $4 }' | cut -d ',' -f1 )
    battery="$icon ${b_perc}"
    echo "E${battery}"
    sleep 60s
  done
}
