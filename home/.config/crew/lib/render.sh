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
_ascii_underscore() { _ascii 4 "$1"; }
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
_tmux_underscore()  { printf '#[underscore]%s#[default]' "$1"; }
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

# crew_color <state> -> color name (matches the _ascii_*/_tmux_* helper suffixes).
# Single source of truth for the state -> color association; used by crew_glyph
# and available to any other consumer that needs a state's color.
crew_color() {
    case "$1" in
        current) echo magenta ;;   # focused agent's own color (orthogonal to state)
        working) echo white ;;
        done)    echo red ;;
        waiting) echo dim ;;
        idle)    echo dim ;;
        live)    echo green ;;
        *)       echo dim ;;  # dead / unknown
    esac
}

# crew_sym <state> -> symbol. Single source of truth for the state -> glyph
# association; used by crew_glyph and available to any other layout.
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

# crew_attr <state> -> text-attribute helper suffix (mirrors crew_color/crew_sym).
# Only the focused agent gets emphasis; every real state renders plain.
crew_attr() {
    case "$1" in
        current) echo bold ;;   # focused agent's own text manipulation
        *)       echo plain ;;
    esac
}

# crew_glyph <env> <state> — the state's symbol, wrapped in the state's color.
# Shared composition: used by both crew_entry (status line) and crew_render
# (sidebar). env picks the color-wrapper family (_ascii_* vs _tmux_*).
crew_glyph() {
    local env="${1:-ascii}" color sym
    color=$(crew_color "$2")
    sym=$(crew_sym "$2")
    "_${env}_${color}" "$sym"
}

# crew_entry <env> <state> <name> [current] — one "glyph name" cell. The glyph
# keeps the state's color+symbol; the name uses the "current" treatment (its own
# color + text attribute) when it is the focused agent, else the state's color.
crew_entry() {
    local env="$1" state="$2" name="$3" current="${4:-}"

    # The glyph always follows the state; the name follows the "current"
    # treatment when it is the focused agent, else its own state.
    local key="$state"
    [ "$name" = "$current" ] && key=current

    # Compose the name label from the associations: wrap it in the key's color,
    # then wrap that in the key's text attribute. Both are _<env>_<suffix> helpers.
    local color attr painted label
    color=$(crew_color "$key")
    attr=$(crew_attr "$key")
    painted=$("_${env}_${color}" "$name")   # name in the key's color
    label=$("_${env}_${attr}" "$painted")   # then the key's text attribute

    printf '%s %s' "$(crew_glyph "$env" "$state")" "$label"
}

crew_render() {
    printf '%s\n\n' $'\033[1m CREW\033[0m'
    if [ ! -s "$CREW_FILE" ]; then
        printf ' (none registered)\n'
        return
    fi
    local i=0 line name state glyph
    while IFS= read -r line; do
        [ -n "$line" ] || continue        # skip blank registry lines
        name=${line%%=*}                  # registry line is "name=session"
        state=$(crew_state "$name")       # working | done | waiting | ... | dead
        glyph=$(crew_glyph ascii "$state")  # status symbol, painted by state
        i=$((i + 1))
        printf ' %d %s %s\n' "$i" "$glyph" "$name"
    done < "$CREW_FILE"
}

crew_tmux_statusline() {
    [ -s "$CREW_FILE" ] || return 0
    local current="$1" out=" " line name state
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        name=${line%%=*}
        state="$(crew_state "$name")"

        out+="$(crew_entry tmux "$state" "$name" "$current") "
    done < "$CREW_FILE"

    printf '%s' "$out"
    # printf '#[align=centre]%s' "$out"
}
