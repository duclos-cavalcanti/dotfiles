#!/bin/bash
#
# VPN script module for lemonbar.

function mod_vpn {
  . ${HLWM}/bar/utils/utils.sh

  icon=" "
  icon=$(format_font "$icon" "$font_icons")
  icon=$(format_colors "$icon" "$icon_color")

  while true; do
    state=$(/opt/cisco/anyconnect/bin/vpn state 2>/dev/null | grep state | head -1 | cut -d ':' -f2 | grep Dis)

    if [[ -z "$state" ]]; then # Connected
      vpn="$icon on"
    else 
      vpn="$icon off"
    fi

    echo "V${vpn}"
    sleep 300s
  done
}


