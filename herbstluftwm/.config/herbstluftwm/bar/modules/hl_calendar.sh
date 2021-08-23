#!/bin/bash
#
# Date script module for dzen2.

function hl_calendar() {
  . ${HLWM}/bar/utils/hl_utils.sh

  icon=' '
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$primary")"

  while true; do
    month=$(date +%B)
    day=$(date +%d)
    weekday=$(date +%a)

    calendar="${weekday}, ${month} ${day}th"

    echo "K${icon} ${calendar}"
    sleep 60s
  done
}
