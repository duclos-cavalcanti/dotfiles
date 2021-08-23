#!/bin/bash
#
# Library used to interact with xrandr for monitor configurations.

monitors::add_mode() {
  monitor="$1"
  mode="'2560x1440_60.00' 312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync"

  xrandr --newmode "$mode"
  xrandr --addmode "$monitor" 2560x1440_60.00
}

monitors::primary_monitor() {
  xrandr | grep -E "[^dis]connected" | head -1 | cut -d' ' -f1
}

monitors::secondary_monitor() {
  xrandr | grep -E "[^dis]connected" | head -2 | tail -1 | cut -d' ' -f1
}

monitors::tertiary_monitor() {
  xrandr | grep -E "[^dis]connected" | head -3 | tail -1 | cut -d' ' -f1
}

monitors::count_monitors() {
  xrandr | grep "[^dis]connected" | wc -l
}
