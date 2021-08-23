#!/bin/bash
#
# Menu script to send signals to hlwm commander.

custom_dmenu="rofi -dmenu -format i" 

hc() {
    herbstclient "$@"
}

main() {
  options=" Bar Logging On\0icon\x1fcomputer\n"
  options+=" Bar Logging Off\0icon\x1fcomputer"

  ans=$(echo -e "$options" | $custom_dmenu -i -p "Signal Menu")
  [ -z "$ans" ] && exit 0

  case "$ans" in
    0)
      hc emit_hook commander bar "LOG ON"
      notify-send "Bar Logging function has been turned on"
      ;;
    1)
      hc emit_hook commander bar "LOG OFF"
      notify-send "Bar Logging function has been turned off"
      ;;
    *)
      ;;
  esac
}

main "$@"

