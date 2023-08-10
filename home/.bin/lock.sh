#!/bin/bash

gnome-screensaver-command -q 2> /dev/null
[ $? ] && gnome-screensaver-command -l

