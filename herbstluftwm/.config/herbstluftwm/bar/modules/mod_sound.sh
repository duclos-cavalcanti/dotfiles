#!/bin/bash
#
# Sound script module for lemonbar.

function mod_sound() {
  . ${HLWM}/bar/utils/utils.sh
  icon=" "
  icon="$(format_font "$icon" "$font_icons")"
  icon="$(format_colors "$icon" "$icon_color")"

  while true; do
    sound_perc=$(pactl list sinks | grep "Volume" | head -1 | awk '{ print $5 }')
    sound="$(format_button "${icon} ${sound_perc}" "1" "pavucontrol")"

    echo "S${sound}"
    sleep 1s
  done
}
