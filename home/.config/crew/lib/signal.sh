#!/usr/bin/env bash
# signal.sh — capture side (producer): map a Claude Code hook event to an agent
# state and record it for this tmux session. Counterpart to lib/render.sh
# (consumer). $CREW_STATE is set by ../crew.
#
# Invoked as `crew signal <event>` from the Claude Code hook router running
# inside the agent's pane; self-locates the tmux session via $TMUX. This is
# where the event->state logic lives (the hook side is a dumb router). No-op
# outside tmux / on unknown events, so it's safe from any hook context.

crew_signal() {
    local state sess
    case "$1" in
        SessionStart)     state="idle" ;;
        UserPromptSubmit) state="working" ;;
        Stop)             state="done" ;;
        Notification)     state="waiting" ;;
        *)                return 0 ;;
    esac
    sess=$(tmux display-message -p '#{session_name}' 2>/dev/null) || return 0
    [ -n "$sess" ] || return 0
    mkdir -p "$CREW_STATE"
    printf '%s\n' "$state" > "$CREW_STATE/$sess"
}
