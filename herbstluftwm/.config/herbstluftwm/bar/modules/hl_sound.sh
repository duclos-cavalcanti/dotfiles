#!/bin/bash
#
# Sound script module for lemonbar.

function hl_sound() {
  . ${HLWM}/bar/utils/hl_utils.sh
  icon=" "
  icon="$(format_font "$icon" "$font_icons")"
  icon="$(format_colors "$icon" "$primary")"

  while true; do
    sound_perc=$(pactl list sinks | grep "Volume" | head -1 | awk '{ print $5 }')
    sound="$(format_button "${icon} ${sound_perc}" "1" "pavucontrol")"

    echo "S${sound}"
    sleep 1s
  done
}
