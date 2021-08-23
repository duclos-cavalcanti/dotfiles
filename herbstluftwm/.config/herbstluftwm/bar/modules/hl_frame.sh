#!/bin/bash
#
# Window frame script module for dzen2.

get_layout() {
  lay="$1"
  if [ -n "$(echo "$lay" | grep "hori")" ]; then
    echo -n "hor"
  elif [ -n "$(echo "$lay" | grep "vert")" ]; then
    echo -n "ver"
  elif [ -n "$(echo "$lay" | grep "max")" ]; then
    echo -n "max"
  else
    echo -n "$lay"
  fi
}


get_frame() {
    layout="$(herbstclient layout | grep "FOCUS" | cut -d '*' -f2 | cut -d ':' -f1)"
    layout="$(get_layout "${layout^}")"

    number="$(herbstclient layout | grep "FOCUS" | cut -d ':' -f2 | cut -d '[' -f1 | wc -w)"

    frame="${icon} ${layout} : $number"
    echo -n "$frame"
}

hl_frame() {
  icon=' '
  icon=$(format_font "$icon" "$font_icons")
  icon="$(format_colors "$icon" "$primary")"

  frame="$(get_frame)"
  echo "F${frame}"

  hc -i focus_* | while read -r _ _ _; do
    frame="$(get_frame)"
    echo "F${frame}"
  done
}
