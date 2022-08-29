#!/bin/bash

USER=$(whoami)
HOST=$(hostname)

usage() {
  echo "USAGE:
    syntax: ./monitors.sh
    "
}

reset_monitors() {
  count="$1"
  count_active=$(xrandr --listactivemonitors | head -n 1 | cut -d ' ' -f2)
  count_diff=$((count_active - count))
  case "$count_diff" in
    2)
      inactive_primary=$(xrandr --listactivemonitors | head -2 | tail -1 | cut -d' ' -f6)
      inactive_secondary=$(xrandr --listactivemonitors | head -3 | tail -1 | cut -d' ' -f6)
      xrandr --output "${inactive_primary}" --off
      xrandr --output "${inactive_secondary}" --off

      ;;
    1)
      inactive_primary=$(xrandr --listactivemonitors | head -2 | tail -1 | cut -d' ' -f6)
      xrandr --output "${inactive_primary}" --off
      echo "$count_diff"
      ;;
    *)
      echo "No need to reset monitors!"
      ;;
  esac
}

set_monitors() {
    count=$(xrandr | grep "[^dis]connected" | wc -l)
    primary=$(xrandr | grep -E " connected" | head -1 | cut -d' ' -f1)
    secondary=$(xrandr | grep -E " connected" | head -2 | tail -1 | cut -d' ' -f1)
    tertiary=$(xrandr | grep -E " connected" | head -3 | tail -1 | cut -d' ' -f1)
    fourth=$(xrandr | grep -E " connected" | head -4 | tail -1 | cut -d' ' -f1)

    case "$count" in
        1)
            reset_monitors 1
            xrandr --output "${primary}" --mode "1920x1080" --primary
            ;;

        2)
            reset_monitors 2
            xrandr --output "${primary}" --mode "1920x1080"
            xrandr --output "${secondary}" --mode "1920x1080" --same-as "${primary}"
            ;;

        3)
            reset_monitors 3
            xrandr --output "${primary}" --mode "1920x1080"
            xrandr --output "${secondary}" --same-as "${primary}"
            xrandr --output "${tertiary}" --right-of "${secondary}" --auto
            ;;
        4)
            reset_monitors 4
            xrandr --output "${primary}" --mode "1920x1080"
            xrandr --output "${secondary}" --same-as "${primary}"
            # xrandr --output "${tertiary}" --left-of "${secondary}" --auto
            xrandr --output "${tertiary}" --rotate right --left-of "${secondary}" --auto
            xrandr --output "${fourth}" --right-of "${secondary}" --auto
            ;;


        *)
            echo "None or too many monitors connected!"
            exit 1
            ;;
    esac
}

main() {
    set_monitors
}

main
