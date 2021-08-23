#!/bin/bash
#
# Window title script module for dzen2.

remove_quotes() {
  text="$1"
  text="${text#??}"
  text="${text%?}"
  echo -n "$text"
}

get_class() {
    id="$(xdo id)"
    info="$(xprop -id "$id" | grep "WM_CLASS" | cut -d "=" -f2)"

    class="$(echo "$info" | cut -d "," -f2)"

    if [ -n "$class" ]; then
      class="$(remove_quotes "$class")"
      class=$(format_colors "${class^}" "$fg")

      echo -n "$class"
    else
      echo -n "None"
    fi
}

get_instance() {
    id="$(xdo id)"
    info="$(xprop -id "$id" | grep "WM_CLASS" | cut -d "=" -f2)"

    instance="$(echo "$info" | cut -d "," -f1)"
    instance="$(remove_quotes "$instance")"

    echo -n "$instance"
}

hl_window() {
  . ${HLWM}/bar/utils/hl_utils.sh

  icon='类'
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$primary")"

  class="$(get_class)"
  echo "T${icon} ${class}"

  hc -i focus_changed | \
  while read -r _ _ hltitle; do
    class="$(get_class)"
    echo "T${icon} ${class}"
  done
}
