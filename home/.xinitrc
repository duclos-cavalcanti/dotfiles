#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge Xresources - System
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

# Modify Xmodmap/Keyboard Layout - System
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# Xinit System
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
else
    systemctl --user import-environment DISPLAY XAUTHORITY
    if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
    fi
fi

exec gnome-session
