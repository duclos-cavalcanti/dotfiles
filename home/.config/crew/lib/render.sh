#!/usr/bin/env bash
# render.sh — consumer side: read a session's state and draw it (sidebar frame +
# tmux status line). Sourced by ../crew ($CREW_FILE / $CREW_STATE set there).
# The producer half is lib/signal.sh.

# Resolve a registered session's state: an agent word from the hook cache
# ($CREW_STATE/<name>: working|done|waiting|idle), else liveness (live|dead).
# The single seam -- both renderers below map its result to a glyph.
crew_state() {
    if [ -f "$CREW_STATE/$1" ]; then
        cat "$CREW_STATE/$1"
    elif tmux has-session -t "=$1" 2>/dev/null; then
        echo live
    else
        echo dead
    fi
}

crew_glyph() {
    case "$(crew_state "$1")" in
        working) printf '%s' $'\033[33m⚡\033[0m' ;;  # yellow: working
        done)    printf '%s' $'\033[32m✓\033[0m'  ;;  # green: finished
        waiting) printf '%s' $'\033[36m⏸\033[0m'  ;;  # cyan: needs input
        idle)    printf '%s' $'\033[90m●\033[0m'  ;;  # dim: present, idle
        live)    printf '%s' $'\033[32m●\033[0m'  ;;  # green: running (no hooks)
        *)       printf '%s' $'\033[90m○\033[0m'  ;;  # dim: not running
    esac
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

# tmux-format glyph (#[...]) for a session's state -- the status-line twin of
# crew_glyph, sharing crew_state.
crew_tmux_glyph() {
    case "$(crew_state "$1")" in
        working) printf '#[fg=yellow]⚡#[fg=default]' ;;
        done)    printf '#[fg=green]✓#[fg=default]'  ;;
        waiting) printf '#[fg=cyan]⏸#[fg=default]'   ;;
        idle)    printf '#[fg=brightblack]●#[fg=default]' ;;
        live)    printf '#[fg=green]●#[fg=default]'  ;;
        *)       printf '#[fg=brightblack]○#[fg=default]' ;;
    esac
}

# One-line, tmux-formatted (#[...]) summary of the crew, for a tmux status line.
crew_statusline() {
    [ -s "$CREW_FILE" ] || return 0
    local out="" line name
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        name=${line%%=*}
        out+="$(crew_tmux_glyph "$name") $name   "
    done < "$CREW_FILE"
    printf ' %s' "$out"
}
