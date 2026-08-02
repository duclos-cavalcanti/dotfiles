#!/bin/sh
# statusline-secondary.sh <session> — tmux status-format[1]: crew (left) + disk/ram/cpu (right).
crew="$HOME/.config/crew/crew"
bin="$HOME/.bin"

left()  { "$crew" tmux-statusline "$1"; }

right() {
    disk=$("$bin/disk-info")
    ram=$("$bin/ram-info")
    cpu=$("$bin/cpu-info")
    printf '#[align=right]#[fg=white]disk: %3s%% | ram: %3s%% | cpu: %3s%%#[default] ' "$disk" "$ram" "$cpu"
}

printf '%s%s' "$(left "$1")" "$(right)"
