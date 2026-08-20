#!/bin/sh
# pane-border.sh <index> <active> <command> <path> — one-line label drawn on a
# pane's border. Called from pane-border-format; tmux expands the #{...} args
# per-pane before invoking, so each pane gets its own context.
#
#   $1 index   = pane index (#P)
#   $2 active  = 1 for the active pane, else 0 (#{pane_active})
#   $3 command = foreground command (#{pane_current_command})
#   $4 path    = pane cwd (#{pane_current_path})
#   $5 pid     = pane shell PID (#{pane_pid})


jobs_count() {
    [ -n "$pid" ] || return
    n=$(pgrep -P "$pid" 2>/dev/null | wc -l | tr -d ' ')
    [ "$n" -gt 0 ] && printf ' [%s]' "$n"
}

main() {
    local index=$1
    local active=$2
    local command=$3
    local path="$4"
    local pid=$5
    local mark dir n

    if [ -n "$pid" ]; then
        n=$(pgrep -P "$pid" 2>/dev/null | wc -l | tr -d ' ')
    else
        n=""
    fi

    dir=$(basename "$path")
    printf ' [%s] %s  %s %s ' "$index" "$command" "$dir" "{n=$n}"
}

main "$@"
