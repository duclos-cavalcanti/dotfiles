#!/bin/bash
#
# HLWM script module for dzen.

hc() {
  herbstclient "$@"
}

tags_symbol() {
  tag="$1"
  case $tag in
    1)
      echo "I"
      ;;

    2)
      echo "II"
      ;;

    3)
      echo "III"
      ;;

    4)
      echo "IV"
      ;;

    5)
      echo "V"
      ;;

    6)
      echo "VI"
      ;;

    7)
      echo "VII"
      ;;

    8)
      echo "VIII"
      ;;

    9)
      echo "IX"
      ;;

    10)
      echo "X"
      ;;

    *)
      echo "-"
      ;;
  esac
}


hl_tags_gen() {

  IFS=$'\t'
  while read -ra tags; do
    for i in "${tags[@]}"; do
      prefix=${i:0:1}
      tag_num=${i:1:${#i}}
      ws="$tag_num"

      case $prefix in
        '#') # Viewed on the specified monitor and is focused
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$primary")"
          ;;

        '+') # Viewed on the specified monitor and is not focused (Active)
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$special")"
          ;;

        '%') # Viewed on another monitor and is focused
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$problem")"
          ;;

        '-') # Viewed on another monitor and is not focused (Active)
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$special")"
          ;;

        '!') # Urgent
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$highlight")"
          ;;

        ':') # Not Empty
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$fg")"
          ;;

        '.') # Empty
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$bg_alt")"
          ;;

        *)  # ? Shouldnt be chosen
          # icon="$ws"
          icon="$(tags_symbol "$ws")"
          tag="$(format_padding "$icon" "1" "c")"
          tag=$(format_font "$tag" "$font_large")
          tag="$(format_button "$tag" "1" "herbstclient use $ws")"
          tag="$(format_colors "$tag" "$bg_alt")"
          ;;
      esac
      workspaces="${workspaces}${tag}"
      tag=""
    done
  done < <(herbstclient tag_status "$mon")

  workspaces="$(format_vertical_down "$workspaces" "3")"
  echo "D${workspaces}"

  workspaces=""
}

hl_tags() {
  . ${HLWM}/bar/utils/hl_utils.sh
  workspaces=""
  mon="$1"
  hl_tags_gen

  hc -i "tag_*" 2>/dev/null | \
  while read -r _; do
    hl_tags_gen
  done
}
