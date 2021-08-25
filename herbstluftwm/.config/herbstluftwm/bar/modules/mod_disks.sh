#!/bin/bash
#
# Bspwm script module for disks space.

function mod_disks() {
  . ${HLWM}/bar/utils/utils.sh

  icon_home="ﳐ "
  icon_home=$(format_font "$icon_home" "$font_icons")
  icon_home="$(format_colors "$icon_home" "$icon_color")"

  icon_root="ﳎ "
  icon_root=$(format_font "$icon_root" "$font_icons")
  icon_root="$(format_colors "$icon_root" "$icon_color")"

  while true; do
    home_disk=$(df -h -P | grep /dev/nvme0n1p4)
    home_perc=$(echo "$home_disk" | awk '{ print $5 }')

    home="${icon_home} ${home_perc}"

    root_disk=$(df -h -P | grep /dev/nvme0n1p3)
    root_perc=$(echo "$root_disk" | awk '{ print $5 }')

    root="${icon_root} ${root_perc}"

    echo "H${home}"
    echo "R${root}"

    sleep 600s
  done
}
