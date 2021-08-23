#!/bin/bash

width=${1:-1920}
height=${2:-20}
mon_index=${3:-1}

fetch_bar_exec() {
  ext=$1
  . ${HLWM}/bar/bars/${ext}_bar.sh
  bar=${ext}_bar

  echo "$bar"
}

fetch_fifo() {
  ext="$1"
  hl_fifo=$HOME/.config/herbstluftwm/bar/fifo/hl_bar_${mon_index}${ext}.fifo

  if [ -e $hl_fifo ]; then 
    rm $hl_fifo
  fi

  mkfifo "${hl_fifo}"
  echo "${hl_fifo}"
}

fetch_text_offset() {
  align="$1"
  if [ "$align" == "center" ]; then
    echo -n "4"
  elif [ "$align" == "left" ]; then
    echo -n "1"
  elif [ "$align" == "right" ]; then
    echo -n "1"
  fi
}

modules() {
  source_modules
  fifo_name="$1"
  bar_pos="$2"

  if [ "$bar_pos" == "center" ]; then
    hl_tags $((mon_index-1))  > "$fifo_name" &

  elif [ "$bar_pos" == "left" ]; then
    hl_clock                  > "$fifo_name" &
    hl_calendar               > "$fifo_name" &
    hl_window                 > "$fifo_name" &
    hl_frame                  > "$fifo_name" &

  elif [ "$bar_pos" == "right" ]; then
    hl_disks                  > "$fifo_name" &
    hl_bluetooth              > "$fifo_name" &
    hl_wifi                   > "$fifo_name" &
    hl_sound                  > "$fifo_name" &
    hl_battery                > "$fifo_name" &

  else
    exit 1
  fi
}

bar() {
  source_bars

  ext=${1:-""}

  bar=$(fetch_bar_exec "$ext")
  fifo_name="$(fetch_fifo "_${ext}")"
  offset=$(fetch_text_offset "$ext")

  modules "$fifo_name" "$ext"
  echo "$bar"
  $bar "$width" "$height" "$offset" "$mon_index" < "$fifo_name"
}

launch_bar() {
  ext=${1:-""}
  w=${2:-$width}
  h=${3:-$height}
  x=${4:-0}
  y=${5:-0}
  align=${6:-l}
  off=${6:-l}

  bar "$ext" \
  | dzen2 -ta "$align" -w "$w" -h "$h" -x "$x" -y "$y" \
    -fg "$fg" -bg "$bg" -fn "$font_main" \
    -xs "$mon_index" -dock -p
}

main() {
  . $HOME/.config/herbstluftwm/bar/utils/hl_utils.sh
  #          extension  width           height      x                 y   alignment 
  launch_bar "left"     "$((width/3))"  "$height"   0                 0   l         &
  launch_bar "center"   "$((width/3))"  "$height"   "$((width/3))"    0   c         &
  launch_bar "right"    "$((width/3))"  "$height"   "$((width*2/3))"  0   r         &
}

main
