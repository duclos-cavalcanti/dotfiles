#!/usr/bin/env bash
# float.sh — dispatcher for "float + select + connect back to tmux" actions.
# Invoked from a `display-popup -E` binding in the `float` key-table.
# Each action: open a popup, fuzzy-select something, feed the result back
# into tmux (clipboard / buffer / switch / etc). Add new actions as cases.
#
#   usage: float.sh <action> [root]

set -euo pipefail

action="${1:-}"
root="${2:-$HOME}"

# Copy a value to the system clipboard + tmux buffer, and flash it.
yank() {
  local val="$1"
  [ -z "$val" ] && exit 0
  printf '%s' "$val" | pbcopy
  tmux set-buffer -- "$val"
  tmux display-message "copied: $val"
}

case "$action" in
  # Fuzzy-pick a file or dir under $root; yank its path.
  path)
    sel="$(
      fd --hidden --follow --exclude .git . "$root" \
        | fzf --prompt='path> ' --height=100% --reverse \
              --preview 'test -d {} && ls -la --color=always {} || cat {} 2>/dev/null' \
              --preview-window=right:50%
    )" || exit 0
    yank "$sel"
    ;;

  # Fuzzy-pick a directory only; yank its path.
  dir)
    sel="$(
      fd --type d --hidden --follow --exclude .git . "$root" \
        | fzf --prompt='dir> ' --height=100% --reverse \
              --preview 'ls -la --color=always {}' --preview-window=right:50%
    )" || exit 0
    yank "$sel"
    ;;

  *)
    tmux display-message "float.sh: unknown action '${action}'"
    exit 1
    ;;
esac
