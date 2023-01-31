#!/bin/bash

if command -v Xephyr &>/dev/null; then
    Xephyr :1 -screen 1280x720 -ac &
    sleep 1
    DISPLAY=:1.0 exec gnome
else
    printf "No Xephyr installed! Run: sudo apt install xserver-xephyr\n"
fi
