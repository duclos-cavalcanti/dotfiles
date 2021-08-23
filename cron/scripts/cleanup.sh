#!/bin/bash
#
# Deletes unwished confs and files.

QT_CONF="/home/duclos/.config/QtProject.conf"
UNKNOWN="/home/duclos/.config/Unknown Organization"

[ -f $QT_CONF ] && rm ${QT_CONF}
[ -d "$UNKNOWN" ] && rm -rf "${UNKNOWN}"
