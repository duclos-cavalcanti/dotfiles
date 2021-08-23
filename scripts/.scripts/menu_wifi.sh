#!/bin/bash
#
# Menu script to connect to wifi.

custom_dmenu="rofi -dmenu"

main() {
  networks=$(nmcli device wifi list | sed -n '1!p' | cut -b 9-)
  net=$(echo "$networks" | $custom_dmenu -p "Select Wifi Network:" | cut -d ' ' -f1)
  pass=$(echo "" | "$custom_dmenu" -p "Password:")

  nmcli device wifi connect "$net" password "$pass"
}

main "$@"

