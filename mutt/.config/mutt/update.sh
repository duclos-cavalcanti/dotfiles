#!/bin/bash

offlineimap -u quiet -c /home/duclos/.config/offlineimap/offlineimaprc & 
notmuch new &
