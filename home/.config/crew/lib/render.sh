#!/usr/bin/env bash
# render.sh — consumer side: read a session's state and draw it (sidebar frame +
# tmux status line). Sourced by ../crew ($CREW_FILE / $CREW_STATE set there).
# The producer half is lib/signal.sh.

# ANSI color helpers (mirror of the tmux helpers below)
_ascii()            { printf '\033[%sm%s\033[0m' "$1" "$2"; }
_ascii_yellow()     { _ascii 33 "$1"; }
_ascii_green()      { _ascii 32 "$1"; }
_ascii_red()        { _ascii 31 "$1"; }
_ascii_blue()       { _ascii 34 "$1"; }
_ascii_cyan()       { _ascii 36 "$1"; }
_ascii_black()      { _ascii 30 "$1"; }
_ascii_dim()        { _ascii 90 "$1"; }  # bright black
_ascii_bold()       { _ascii 1 "$1"; }
_ascii_underscore() { _ascii 4 "$1"; }

# tmux color helpers
_tmux()             { printf '#[fg=%s]%s#[fg=default]' "$1" "$2"; }
_tmux_yellow()      { _tmux yellow "$1"; }
_tmux_green()       { _tmux green "$1"; }
_tmux_red()         { _tmux red "$1"; }
_tmux_blue()        { _tmux blue "$1"; }
_tmux_cyan()        { _tmux cyan "$1"; }
_tmux_black()       { _tmux black "$1"; }
_tmux_dim()         { _tmux brightblack "$1"; }
_tmux_bold()        { printf '#[bold]%s#[default]' "$1"; }
_tmux_underscore()  { printf '#[underscore]%s#[default]' "$1"; }

crew_state() {
    if [ -f "$CREW_STATE/$1" ]; then
        cat "$CREW_STATE/$1"
    elif tmux has-session -t "=$1" 2>/dev/null; then
        echo live
    else
        echo dead
    fi
}

# crew_glyph <env> <state>   env: ascii (sidebar) | tmux (status line)
# One table of state -> (color, symbol); env only picks the color-wrapper family
# (_ascii_* vs _tmux_*), so both renderers share the same mapping.
crew_glyph() {
    local env="${1:-ascii}" state="$2" color sym
    case "$state" in
        working) color=yellow; sym='»' ;;
        done)    color=green;  sym='⏸' ;;
        waiting) color=cyan;   sym='⏸' ;;
        idle)    color=dim;    sym='●' ;;
        live)    color=green;  sym='●' ;;
        *)       color=dim;    sym='○' ;;  # dead / unknown
    esac
    "_${env}_${color}" "$sym"
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
        printf ' %d %s %s\n' "$i" "$(crew_glyph ascii "$(crew_state "$name")")" "$name"
    done < "$CREW_FILE"
}

crew_tmux_statusline() {
    [ -s "$CREW_FILE" ] || return 0
    local current="$1" out=" " line name state
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        name=${line%%=*}
        state="$(crew_state "$name")"

        if [ "$name" = "$current" ]; then
            out+="$(crew_glyph tmux "$state") $(_tmux_bold "$name") "
        else
            out+="$(crew_glyph tmux "$state") $(_tmux_dim "$name") "
        fi
    done < "$CREW_FILE"

    printf '%s' "$out"
    # printf '#[align=centre]%s' "$out"
}
