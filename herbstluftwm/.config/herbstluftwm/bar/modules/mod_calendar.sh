#!/bin/bash
#
# Date script module for dzen2.

function mod_calendar() {
  . ${HLWM}/bar/utils/utils.sh

  icon=' '
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$icon_color")"

  while true; do
    month=$(date +%B)
    day=$(date +%d)
    weekday=$(date +%a)

    calendar="${weekday}, ${month} ${day}th"

    echo "K${icon} ${calendar}"
    sleep 60s
  done
}
