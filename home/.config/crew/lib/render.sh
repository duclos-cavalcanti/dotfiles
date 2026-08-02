#!/usr/bin/env bash
# render.sh — consumer side: read a session's state and draw it (sidebar frame +
# tmux status line). Sourced by ../crew ($CREW_FILE / $CREW_STATE set there).
# The producer half is lib/signal.sh.

# ANSI color helpers (mirror of the tmux helpers below)
_ascii()            { printf '\033[%sm%s\033[0m' "$1" "$2"; }
_ascii_white()      { _ascii 37 "$1"; }
_ascii_yellow()     { _ascii 33 "$1"; }
_ascii_green()      { _ascii 32 "$1"; }
_ascii_red()        { _ascii 31 "$1"; }
_ascii_blue()       { _ascii 34 "$1"; }
_ascii_cyan()       { _ascii 36 "$1"; }
_ascii_magenta()    { _ascii 35 "$1"; }
_ascii_black()      { _ascii 30 "$1"; }
_ascii_dim()        { _ascii 90 "$1"; }  # bright black
_ascii_bold()       { _ascii 1 "$1"; }
_ascii_italic()     { _ascii 3 "$1"; }
_ascii_underscore() { _ascii 4 "$1"; }
_ascii_blink()      { _ascii 5 "$1"; }
_ascii_reverse()    { _ascii 7 "$1"; }
_ascii_hidden()     { _ascii 8 "$1"; }
_ascii_strikethrough() { _ascii 9 "$1"; }
_ascii_plain()      { printf '%s' "$1"; }  # identity: no attribute

# tmux color helpers
_tmux()             { printf '#[fg=%s]%s#[fg=default]' "$1" "$2"; }
_tmux_white()       { _tmux white "$1"; }
_tmux_yellow()      { _tmux yellow "$1"; }
_tmux_green()       { _tmux green "$1"; }
_tmux_red()         { _tmux red "$1"; }
_tmux_blue()        { _tmux blue "$1"; }
_tmux_cyan()        { _tmux cyan "$1"; }
_tmux_magenta()     { _tmux magenta "$1"; }
_tmux_black()       { _tmux black "$1"; }
_tmux_dim()         { _tmux brightblack "$1"; }
_tmux_bold()        { printf '#[bold]%s#[default]' "$1"; }
_tmux_italic()      { printf '#[italics]%s#[default]' "$1"; }
_tmux_underscore()  { printf '#[underscore]%s#[default]' "$1"; }
_tmux_blink()       { printf '#[blink]%s#[default]' "$1"; }
_tmux_reverse()     { printf '#[reverse]%s#[default]' "$1"; }
_tmux_hidden()      { printf '#[hidden]%s#[default]' "$1"; }
_tmux_strikethrough() { printf '#[strikethrough]%s#[default]' "$1"; }
_tmux_plain()       { printf '%s' "$1"; }  # identity: no attribute

crew_state() {
    if [ -f "$CREW_STATE/$1" ]; then
        cat "$CREW_STATE/$1"
    elif tmux has-session -t "=$1" 2>/dev/null; then
        echo live
    else
        echo dead
    fi
}

crew_sym() {
    case "$1" in
        working) echo '»' ;;
        done)    echo '⏸' ;;
        waiting) echo '⏸' ;;
        idle)    echo '●' ;;
        live)    echo '●' ;;
        *)       echo '○' ;;  # dead / unknown
    esac
}

crew_color() {
    case "$1" in
        working) echo green ;;
        done)    echo red ;;
        waiting) echo white ;;
        idle)    echo dim ;;
        live)    echo green ;;
        *)       echo dim ;;  # dead / unknown
    esac
}

crew_attr() {
    case "$1" in
        *)       echo plain ;;
    esac
    # bold, italic, underscore, blink, 
    # reverse, hidden, strikethrough, plain (identity / no-op).
}

crew_color_apply() {
    local text="${1}"
    local env="${2:-ascii}"
    local color="${3:-white}"
    "_${env}_${color}" "$text"
}

crew_attr_apply() {
    local text="${1}"
    local env="${2:-ascii}"
    local attr="${3:-plain}"
    "_${env}_${attr}" "$text"
}

crew_color_and_attr_apply() {
    local text="${1}"
    local env="${2:-ascii}"
    local color="${3:-white}"
    local attr="${4:-plain}"

    text=$("_${env}_${color}" "$text")
    "_${env}_${attr}" "$text"
}

crew_entry() {
    local env="$1" state="$2" name="$3" current="${4:-}"

    local text sym
    if [ "$name" = "$current" ]; then
        text=$(crew_color_and_attr_apply "$name" "$env" "$(crew_color "$state")" underscore)
    else 
        text=$(crew_color_apply "$name" "$env" "$(crew_color "$state")")
    fi
    sym=$(crew_color_apply "$(crew_sym "$state")" "$env" "$(crew_color "$state")")

    printf '%s %s' "$sym" "$text"
}

crew_render() {
    printf '%s\n\n' $'\033[1m CREW\033[0m'
    [ -s "$CREW_FILE" ] || { printf ' (none registered)\n'; return 0; }
    local i=0 line name state entry
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        name=${line%%=*}
        state="$(crew_state "$name")"
        entry="$(crew_entry ascii "$state" "$name")"
        i=$((i + 1))
        printf ' %d %s\n' "$i" "$entry"
    done < "$CREW_FILE"
}

crew_tmux_statusline() {
    [ -s "$CREW_FILE" ] || return 0
    local current="$1" out=" " line name state entry
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        name=${line%%=*}
        state="$(crew_state "$name")"
        entry="$(crew_entry tmux "$state" "$name" "$current")"
        out+="${entry} "
    done < "$CREW_FILE"

    printf '%s' "$out"
}
