#!/bin/bash

# Bar decoder, feeds final right bar to dzen2.
right_bar() {
  panel_width="$1"
  panel_height="$2"
  panel_text_offset="$3"
  monitor_index="$4"

  bar_separator="^p(10)^fg(#434c5e)^r(2x15)^fg()^p(10)"
  separator="^p(20)"

  while read -r line; do
    item=${line#?}
    select="${line:0:1}"

    case "$select" in
      H) # Home Disk
        _home=""
        _home="$item"
        ;;

      R) # Root Disk
        _root=""
        _root="$item"
        ;;

      W) # Wifi
        _wifi=""
        _wifi="$item"
        ;;

      B) # Bluetooth
        _blue=""
        _blue="$item"
        ;;

      E) # Battery
        _battery=""
        _battery="$item"
        ;;

      S) # Sound
        _sound=""
        _sound="$item"
        ;;
    esac

    item=""
    select=""

    bar="${_root}"
    bar+="${bar_separator}"
    bar+="${_home}"
    bar+="${bar_separator}"
    bar+="${_blue}"
    bar+="${bar_separator}"
    bar+="${_wifi}"
    bar+="${bar_separator}"
    bar+="${_sound}"
    bar+="${bar_separator}"
    bar+="${_battery}"
    bar+="${separator}"

    bar="$(format_vertical "$bar" "$panel_text_offset")"
    echo "$bar"

    log=$($HOME/.config/herbstluftwm/mgr/check.sh "bar" "LOG ON")

    if [ $log -eq 1 ]; then
      echo "$bar" >> $HOME/.config/herbstluftwm/mgr/logs/bar_${monitor_index}_right
    fi
  done
}
