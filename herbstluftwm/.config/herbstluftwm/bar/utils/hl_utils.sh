#!/bin/bash
#
# Helper functions for the lemonbar modules.

font_main='Ubuntu Mono:style=regular:size=9'           # Regular
font_small='Ubuntu Mono:style=regular:size=8'          # Small
font_large='Ubuntu Mono:style=regular:size=9'         # Large
font_icons='Ubuntu Nerd Font:style=bold:size=8'        # Icons
font_icons_large='Ubuntu Nerd Font:style=bold:size=16' # Icons Large
font_bold='Ubuntu Mono:style=bold:size=9'              # Bold

bg="#1f2531"
bg_alt="#434c5e"

fg="#ffffff"
fg_alt="#7c818c"

primary="#88c0d0"
secondary="#a3be8c"
tertiary="#d08770"
special="#b48ead"
problem="#bf616a"
highlight="#000000"

rectangle_background="$bg_alt"

underline_color="#88c0d0"

source_modules() {
  modules=$HOME/.config/herbstluftwm/bar/modules
  for mod in $(ls $modules); do
    . ${modules}/${mod}
  done
}

source_bars() {
  bars_dir=$HOME/.config/herbstluftwm/bar/bars/
  for bar in $(ls $bars_dir); do
    . ${bars_dir}/${bar}
  done
}

format_font() {
  text=$1
  font=$2
  echo -n "^fn(${font})${text}^fn()"
}

format_colors() {
  if [[ $# -eq 3 ]]; then
    text=$1
    background=$2
    foreground=$3
    echo -n "^bg(${background})^fg(${foreground})${text}^bg(${bg})^fg(${fg})"

  elif [[ $# -eq 2 ]]; then
    text=$1
    foreground=$2
    echo -n "^bg(${bg})^fg(${foreground})${text}^bg(${bg})^fg(${fg})"

  else
    text=$1
    echo -n "^bg(${bg})^fg(${fg})${text}^bg(${bg})^fg(${fg})"
  fi
}

format_button() {
  # left          - 1
  # right         - 2
  # middle        - 3
  text="$1"
  button="$2"
  command="$3"
  echo -n "^ca(${button},${command})${text}^ca()"
}

format_vertical() {
  text="$1"
  cnt="$2"

  echo -n "^p(;-${cnt})${text}^p(;+${cnt})"
}

format_vertical_down() {
  text="$1"
  cnt="$2"

  echo -n "^p(;+${cnt})${text}^p(;-${cnt})"
}

format_padding() {
  text="$1"
  cnt="$2"
  mode="$3"
  padding=" "

  i="0"
  case "$mode" in 
    l)
      while [ "$i" -lt "$cnt" ]; do
        text="${padding}${text}"
        ((i++))
      done
      ;;
    c)
      while [ "$i" -lt "$cnt" ]; do
        text="${padding}${text}${padding}"
        ((i++))
      done
      ;;
    *|r)
      while [ "$i" -lt "$cnt" ]; do
        text="${text}${padding}"
        ((i++))
      done
      ;;
  esac
  echo -n "$text"
}

format_cutoff() {
  text="$1"
  cutoff="$2"
  size="${#text}"
  if [ "$size" -gt "$cutoff" ]; then
      i="$size"
      while [ "$i" -gt "$cutoff" ]; do
        text="${text%?}"
        ((i--))
      done
      echo "${text}..."
  else
    echo "$text"
  fi
}

format_progress() {
  val="$1"
  min=${2:-0}
  max=${3:-100}
  color=${4:-${primary}}
  height=${5:-5}

  echo -n "$(echo "$val" | gdbar -max $max -min $min -fg "$color" -bg "$rectangle_background" -h "$height")"
}

format_rectangle() {
  text=${1}
  width=${2:-5}
  height=${3:-5}
  color=${4:-${primary}}

  rectangle="^ib(1)^fg($color)^r(${width}x${height})^fg()^p(-$((width/2 + ${#text} + 3)))${text}^p($((width/2)))^ib(0)"

  echo -n "$rectangle"
}
