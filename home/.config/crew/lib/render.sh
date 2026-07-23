#!/usr/bin/env bash
# render.sh — draw one frame of the crew sidebar: each registered session with a
# status glyph. Sourced by ../crew ($CREW_FILE set there).
#
# Status is LIVENESS for now (session running or not). crew_glyph is the seam for
# growth: swap it later to read real agent state (working/done/waiting) from a
# hook cache, without touching the rest.

crew_glyph() {
    if tmux has-session -t "=$1" 2>/dev/null; then
        printf '%s' $'\033[32m●\033[0m'   # green: running
    else
        printf '%s' $'\033[90m○\033[0m'   # dim: not running
    fi
}

crew_render() {
    printf '%s\n\n' $'\033[1m CREW\033[0m'
    if [ ! -s "$CREW_FILE" ]; then
        printf ' (none registered)\n'
        return
    fi
    local i=0 line name
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        i=$((i + 1))
        name=${line%%=*}
        printf ' %d %s %s\n' "$i" "$(crew_glyph "$name")" "$name"
    done < "$CREW_FILE"
}
