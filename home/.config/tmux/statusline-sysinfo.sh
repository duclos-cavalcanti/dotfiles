#!/bin/sh
# statusline-sysinfo.sh — disk/ram/cpu for the primary status-right.
# (status-right is already right-aligned by tmux, so no #[align=right] here.)
bin="$HOME/.bin"
disk=$("$bin/disk-info")
ram=$("$bin/ram-info")
cpu=$("$bin/cpu-info")
printf '#[fg=white]disk: %3s%% | ram: %3s%% | cpu: %3s%%#[default] ' "$disk" "$ram" "$cpu"
