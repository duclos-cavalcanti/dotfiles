#!/bin/bash

# Bar decoder, feeds final center bar to dzen2.
center_bar() {
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
      D) # Tags
        _tags=""
        _tags="$item"
        ;;
      *) # Nothing
        ;;
    esac

    item=""
    select=""

    bar="${_tags}"

    bar="$(format_vertical "$bar" "$panel_text_offset")"
    echo "$bar"

    log=$($HOME/.config/herbstluftwm/mgr/check.sh "bar" "LOG ON")

    if [ $log -eq 1 ]; then
      echo "$bar" >> $HOME/.config/herbstluftwm/mgr/logs/bar_${monitor_index}_center
    fi
  done
}
