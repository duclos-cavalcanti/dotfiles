#!/bin/bash
#
# Wifi script module for lemonbar.

function hl_wifi {
  . ${HLWM}/bar/utils/hl_utils.sh

  while true; do
    wifi=""
    icon=""
    icon="直"
    icon=$(format_font "$icon" "$font_icons")

    connection=$(nmcli general status | tail -1 | awk '{ print $2 }')
    connection_alt=$(nmcli general status | tail -1 | awk '{ print $4 }')
    
    if [[ "$connection" == "full" ]]; then
      icon="$(format_colors "$icon" "$primary")"
      wifi="$icon on"
    elif [[ "$connection" == "limited" || "$connection_alt" == "limited" ]]; then
      icon="$(format_colors "$icon" "$primary")"
      wifi="$icon on"
    else
      icon="$(format_colors "$icon" "$problem")"
      wifi="$icon off"
    fi

    wifi="$(format_button "$wifi" "1" "nm-connection-editor")"
    echo "W${wifi}"
    sleep 60s
  done
}
