#!/bin/bash
#
# Relaunches dzen2 bar.

. $HOME/.scripts/functions_monitors.sh
panel_width=${1:-1920}
panel_height=${2:-22}

count=$(monitors::count_monitors)

killall -9 dzen2 
killall -9 launch_bar.sh

# cleans previous logs
if [ -n "$(ls $HOME/.config/herbstluftwm/mgr/logs/ | grep bar)" ]; then
  rm $HOME/.config/herbstluftwm/mgr/logs/bar*
fi

[ -n "$(ls $HOME/.config/herbstluftwm/bar/fifo/)" ] && rm $HOME/.config/herbstluftwm/bar/fifo/*

case "$count" in
  1)
    $HOME/.config/herbstluftwm/bar/launch_bar.sh $panel_width $panel_height 1 &
    ;;

  2|3)
    $HOME/.config/herbstluftwm/bar/launch_bar.sh $panel_width $panel_height 1 &
    $HOME/.config/herbstluftwm/bar/launch_bar.sh $panel_width $panel_height 2 &
    ;;

  *)
    echo "None or too many monitors connected."
    exit 1
    ;;
esac
