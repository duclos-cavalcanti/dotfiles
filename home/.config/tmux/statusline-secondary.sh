#!/bin/sh
# statusline-secondary.sh <session> — tmux status-format[1]: crew summary.
# (disk/ram/cpu moved to the primary status-right; see statusline-sysinfo.sh.)
crew="$HOME/.config/crew/crew"

"$crew" tmux-statusline "$1"
