#!/bin/bash

# Bar decoder, feeds final bar to dzen2.
left_bar() {
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
      T) # Window Title
        _title=""
        _title="$item"
        ;;

      F) # Window Frame
        _frame=""
        _frame="$item"
        ;;

      C) # Clock
        _clock=""
        _clock="$item"
        ;;

      K) # Calendar
        _calendar=""
        _calendar="$item"
        ;;

      F) # Window Layout
        _frame=""
        _frame="$item"
        ;;

      *)
        :
        ;;
    esac

    item=""
    select=""

    bar="${separator}"
    bar+="${_clock}"
    bar+="${bar_separator}"
    bar+="${_calendar}"
    bar+="${bar_separator}"
    bar+="${_frame}"
    bar+="${bar_separator}"
    bar+="${_title}"

    bar="$(format_vertical "$bar" "$panel_text_offset")"
    echo "${bar}"

    log=$($HOME/.config/herbstluftwm/mgr/check.sh "bar" "LOG ON")

    if [ $log -eq 1 ]; then
      echo "$bar" >> $HOME/.config/herbstluftwm/mgr/logs/bar_${monitor_index}_left
    fi
  done
}
